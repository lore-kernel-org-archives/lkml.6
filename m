Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755629AbeEIFGE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 01:06:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52348 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbeEIFGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 01:06:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 09 May 2018 10:36:01 +0530
From: kgunda@codeaurora.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH V1 4/5] backlight: qcom-wled: Add support for OVP
 interrupt handling
In-Reply-To: <20180508171936.GK2259@tuxbook-pro>
References: <1525341432-15818-1-git-send-email-kgunda@codeaurora.org>
 <1525341432-15818-5-git-send-email-kgunda@codeaurora.org>
 <20180507172152.GD2259@tuxbook-pro>
 <3736480b2712e2dd401fed0a635a25d7@codeaurora.org>
 <20180508171936.GK2259@tuxbook-pro>
Message-ID: <9757b8fbcdd55cb72a42451270b3cb33@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-08 22:49, Bjorn Andersson wrote:
> On Tue 08 May 05:26 PDT 2018, kgunda@codeaurora.org wrote:
> 
>> On 2018-05-07 22:51, Bjorn Andersson wrote:
>> > On Thu 03 May 02:57 PDT 2018, Kiran Gunda wrote:
> [..]
>> > > @@ -220,7 +255,12 @@ static int wled_module_enable(struct wled
>> > > *wled, int val)
>> > >  				WLED3_CTRL_REG_MOD_EN,
>> > >  				WLED3_CTRL_REG_MOD_EN_MASK,
>> > >  				WLED3_CTRL_REG_MOD_EN_MASK);
>> > > -	return rc;
>> > > +	if (rc < 0)
>> > > +		return rc;
>> > > +
>> > > +	schedule_delayed_work(&wled->ovp_work, WLED_SOFT_START_DLY_US);
>> >
>> > Do you really want to delay the work on disable?
>> >
>> > Wouldn't it be better to use a delay worker for the enablement and in
>> > the disable case you cancel the work and just disable_irq() directly
>> > here.
>> >
>> Sure. Will do it in the next series.
>> > But more importantly, if this is only related to auto detection, do you
>> > really want to enable/disable the ovp_irq after you have detected the
>> > string configuration?
>> >
>> Ok. This is used for the genuine OVP detection and for the auto 
>> detection as
>> well.
> 
> What is the expected outcome of detecting an OVP condition, outside 
> auto
> detection?
> 
Ok... Out side auto detection, it is used for information purpose. I 
think it is
okay to ignore enable/disable the ovp_irq after auto detection is done.
> Regards,
> Bjorn
