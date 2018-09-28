Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D3FC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DCD21580
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86DCD21580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbeI1Tpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:45:40 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52218 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbeI1Tpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:45:40 -0400
Received: from wd0267.dip.tu-dresden.de ([141.76.109.11] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1g5siK-0006It-Kq; Fri, 28 Sep 2018 15:21:48 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     dri-devel@lists.freedesktop.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-pwm@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@collabora.com, cl@rock-chips.com
Subject: Re: [PATCH v3] backlight: pwm_bl: switch to using "atomic" PWM API
Date:   Fri, 28 Sep 2018 15:21:47 +0200
Message-ID: <2092357.WrANtTvkTV@phil>
In-Reply-To: <20180910144924.GU28860@dell>
References: <20180814165059.13219-1-enric.balletbo@collabora.com> <20180910144924.GU28860@dell>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Am Montag, 10. September 2018, 16:49:24 CEST schrieb Lee Jones:
> On Tue, 14 Aug 2018, Enric Balletbo i Serra wrote:
> 
> > The "atomic" API allows us to configure PWM period and duty_cycle and
> > enable it in one call.
> > 
> > The patch also moves the pwm_init_state just before any use of the
> > pwm_state struct, this fixes a potential bug where pwm_get_state
> > can be called before pwm_init_state.
> > 
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> > 
> > Changes in v3:
> > - Get rid of duty_cycle variable from pwm_backlight_update_status.
> > - Get rid of pb->enabled and use only the status.enabled variable.
> > - Make power_on match power_off.
> > - Do not share status between ...update_status and ...power_on
> > 
> > Changes in v2:
> > - Do not force the PWM be off in the first call to pwm_apply_state.
> > - Delayed applying the state until we know what the period is.
> > - Removed pb->period as after the conversion is not needed.
> > 
> >  drivers/video/backlight/pwm_bl.c | 81 +++++++++++++++++---------------
> >  1 file changed, 42 insertions(+), 39 deletions(-)
> 
> Applied, thanks.

did this miss some push or so, because looking at [0], I don't see
any new patches for a while now?

Heiko

[0] https://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git/


