Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932953AbeENRCn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:02:43 -0400
Received: from mail-pl0-f48.google.com ([209.85.160.48]:42910 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754121AbeENRCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:02:40 -0400
X-Google-Smtp-Source: AB8JxZrJtv4iPibcm2R/uYNbRJQAX2VbZSbq0MJuifaEGEX0G8KO1vHyxyAwsk0Ghx2CiWu15xNL3g==
Date: Mon, 14 May 2018 10:02:37 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: kgunda@codeaurora.org
Cc: Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V1 5/5] backlight: qcom-wled: Add auto string detection
 logic
Message-ID: <20180514170237.GL14924@minitux>
References: <1525341432-15818-1-git-send-email-kgunda@codeaurora.org>
 <1525341432-15818-6-git-send-email-kgunda@codeaurora.org>
 <20180507181044.GE2259@tuxbook-pro>
 <abe98bd822f8c7bab80f9ec9afb34d9b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abe98bd822f8c7bab80f9ec9afb34d9b@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09 May 00:14 PDT 2018, kgunda@codeaurora.org wrote:

> On 2018-05-07 23:40, Bjorn Andersson wrote:
> > On Thu 03 May 02:57 PDT 2018, Kiran Gunda wrote:
> > 
> > [..]
> > > +
> > > +#define WLED_AUTO_DETECT_OVP_COUNT		5
> > > +#define WLED_AUTO_DETECT_CNT_DLY_US		HZ /* 1 second */
> > > +static bool wled_auto_detection_required(struct wled *wled)
> > 
> > So cfg.auto_detection_enabled is set, but we didn't have a fault during
> > wled_auto_detection_at_init(), which I presume indicates that the boot
> > loader configured the strings appropriately (or didn't enable the BL).
> > Then first time we try to enable the backlight we will hit the ovp irq,
> > which will  enter here a few times to figure out that the strings are
> > incorrectly configured and then we will do the same thing that would
> > have been done if we probed with a fault.
> > 
> > This is convoluted!
> > 
> > If auto-detection is a feature allowing the developer to omit the string
> > configuration then just do the auto detection explicitly in probe when
> > the developer did so and then never do it again.
> > 
> As explained in the previous patch, the auto-detection is needed later,
> because are also cases where one/more of the connected LED string of the
> display-backlight is malfunctioning (because of damage) and requires the
> damaged string to be turned off to prevent the complete panel and/or board
> from being damaged.

Okay, that sounds very reasonable. Please ensure that it's clearly
described in the commit message, so that we have this documented if
someone wonders in the future.

Regards,
Bjorn
