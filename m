Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755419AbeEHRSS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:18:18 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33237 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755209AbeEHRSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:18:14 -0400
X-Google-Smtp-Source: AB8JxZq3ntkWxEZERq7O1Pr4uhxaMUPKrdLDkPjvNGPOmzeYYF6/BSTLNoIEkluZXKdghqd5icvoww==
Date: Tue, 8 May 2018 10:19:36 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: kgunda@codeaurora.org
Cc: Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH V1 4/5] backlight: qcom-wled: Add support for OVP
 interrupt handling
Message-ID: <20180508171936.GK2259@tuxbook-pro>
References: <1525341432-15818-1-git-send-email-kgunda@codeaurora.org>
 <1525341432-15818-5-git-send-email-kgunda@codeaurora.org>
 <20180507172152.GD2259@tuxbook-pro>
 <3736480b2712e2dd401fed0a635a25d7@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3736480b2712e2dd401fed0a635a25d7@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08 May 05:26 PDT 2018, kgunda@codeaurora.org wrote:

> On 2018-05-07 22:51, Bjorn Andersson wrote:
> > On Thu 03 May 02:57 PDT 2018, Kiran Gunda wrote:
[..]
> > > @@ -220,7 +255,12 @@ static int wled_module_enable(struct wled
> > > *wled, int val)
> > >  				WLED3_CTRL_REG_MOD_EN,
> > >  				WLED3_CTRL_REG_MOD_EN_MASK,
> > >  				WLED3_CTRL_REG_MOD_EN_MASK);
> > > -	return rc;
> > > +	if (rc < 0)
> > > +		return rc;
> > > +
> > > +	schedule_delayed_work(&wled->ovp_work, WLED_SOFT_START_DLY_US);
> > 
> > Do you really want to delay the work on disable?
> > 
> > Wouldn't it be better to use a delay worker for the enablement and in
> > the disable case you cancel the work and just disable_irq() directly
> > here.
> > 
> Sure. Will do it in the next series.
> > But more importantly, if this is only related to auto detection, do you
> > really want to enable/disable the ovp_irq after you have detected the
> > string configuration?
> > 
> Ok. This is used for the genuine OVP detection and for the auto detection as
> well.

What is the expected outcome of detecting an OVP condition, outside auto
detection?

Regards,
Bjorn
