Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C084C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E9424995
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bO2LcwT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E9424995
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754694AbeFVXGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 19:06:47 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40387 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754580AbeFVXGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 19:06:44 -0400
Received: by mail-pl0-f66.google.com with SMTP id t12-v6so4131594plo.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 16:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hNzkmK1RwyRCBhRgYtHgfx4SairokWbaH1n7UcW7kr8=;
        b=bO2LcwT3l91DmUc//6x9pXWugBqEXfhUHty4CnKIZ7BCvVca5v0LYWr6Yke5A62yqM
         ELgnvBvaL2MVNXDkNlDlvFkQlGJ1hPYsaX82XA/wIp8TBJuGEYhDqYY1yRnDardx/43V
         SL6YuzXwLHgc2GNTD2lezcb+FZpcxWl9GjYFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hNzkmK1RwyRCBhRgYtHgfx4SairokWbaH1n7UcW7kr8=;
        b=aLdF58dkcXUThHn/R1ei89tMmTfAKgcWodD49uA/zbfOB8I51ANcGUVZkfv5G5hlOu
         eVFS4PTdPlxHQ8ZjW3KgqQ56twhjr6UmqICLMiEFf1ZmZrji4vZT1bXTtY1a1kV7Ni+M
         xJpZXmElnM0deKYkCvgwoBr3JcB8l+pN0hMyBiZ9E90GXbckZdc4g0CcOrT2HZB7lvvl
         ++8WdTIQdlkq0UsT+2c5Fo84e97zJNBo4dwA6Z7bzUlB49/h2PIhSe+GE9Soc0+lwa7a
         NQ8KhWz6pKtQ6lMjh79pZ0vbQZlHE2dq7KzV/xfE62YDy/xwBviEM5TMro7yb+GrdBfX
         bi8A==
X-Gm-Message-State: APt69E1QRinVKmK8xyszX2JZimTBOdE1wMHldSSNcsPXGpqO6UKJFuce
        cDkjB0N8T2g42NgpurkF8iUpnw==
X-Google-Smtp-Source: ADUXVKJrl02xCQG1kwt0Kj4jmm8TiL3amEDTgaYlTKA2nWO9TvRvUQp44mqtIgRF0rI9sWByq+6/2A==
X-Received: by 2002:a17:902:850b:: with SMTP id bj11-v6mr3406281plb.210.1529708803675;
        Fri, 22 Jun 2018 16:06:43 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t5-v6sm12677577pfh.32.2018.06.22.16.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 16:06:42 -0700 (PDT)
Date:   Fri, 22 Jun 2018 16:09:03 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     kgunda@codeaurora.org
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V3 5/7] backlight: qcom-wled: Add support for WLED4
 peripheral
Message-ID: <20180622230903.GM3402@tuxbook-pro>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-6-git-send-email-kgunda@codeaurora.org>
 <20180620051417.GI15126@tuxbook-pro>
 <27aa7ff8f7e0cd8fdca5d3ee17bb1ef4@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27aa7ff8f7e0cd8fdca5d3ee17bb1ef4@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20 Jun 04:00 PDT 2018, kgunda@codeaurora.org wrote:

> On 2018-06-20 10:44, Bjorn Andersson wrote:
> > On Tue 19 Jun 04:13 PDT 2018, Kiran Gunda wrote:
> > 
> > > WLED4 peripheral is present on some PMICs like pmi8998 and
> > > pm660l. It has a different register map and configurations
> > > are also different. Add support for it.
> > > 
> > > Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> > > ---
> > >  drivers/video/backlight/qcom-wled.c | 635
> > > ++++++++++++++++++++++++++++--------
> > >  1 file changed, 503 insertions(+), 132 deletions(-)
> > 
> > Split this further into a patch that does structural preparation of
> > WLED3 support and then an addition of WLED4, the mixture makes parts of
> > this patch almost impossible to review. Please find some comments below.
> > 
> Sure. I will split it in the next series.

Thanks!

> > > 
> > > diff --git a/drivers/video/backlight/qcom-wled.c
> > > b/drivers/video/backlight/qcom-wled.c
> > [..]
> > > 
> > >  /* WLED3 sink registers */
> > >  #define WLED3_SINK_REG_SYNC				0x47
> > 
> > Drop the 3 from this if it's common between the two.
> > 
> > > -#define  WLED3_SINK_REG_SYNC_MASK			0x07
> > > +#define  WLED3_SINK_REG_SYNC_MASK			GENMASK(2, 0)
> > > +#define  WLED4_SINK_REG_SYNC_MASK			GENMASK(3, 0)
> > >  #define  WLED3_SINK_REG_SYNC_LED1			BIT(0)
> > >  #define  WLED3_SINK_REG_SYNC_LED2			BIT(1)
> > >  #define  WLED3_SINK_REG_SYNC_LED3			BIT(2)
> > > +#define  WLED4_SINK_REG_SYNC_LED4			BIT(3)
> > >  #define  WLED3_SINK_REG_SYNC_ALL			0x07
> > > +#define  WLED4_SINK_REG_SYNC_ALL			0x0f
> > >  #define  WLED3_SINK_REG_SYNC_CLEAR			0x00
> > > 
> > [..]
> > > +static int wled4_set_brightness(struct wled *wled, u16 brightness)
> > 
> > Afaict this is identical to wled3_set_brightness() with the exception
> > that there's a minimum brightness and the base address for the
> > brightness registers are different.
> > 
> > I would suggest that you add a min_brightness to wled and that you
> > figure out a way to carry the brightness base register address; and by
> > that you squash these two functions.
> > 
> There are four different parameters. 1) minimum brightness 2) WLED base
> addresses
> 3) Brightness base addresses 4) the brightness sink registers address
> offsets also
> different for wled 3 and wled4. (in wled3 0x40, 0x42, 0x44, where as in
> wled4 0x57, 0x67, 0x77, 0x87).
> 

Sorry, I must have gotten lost in the defines, I see the difference
between the two register layouts now. If you retain the old mechanism of
doing the math openly in the function this would have been obvious.

> Irrelevant to this patch, but wled5 has some more extra registers to
> set the brightness.  Keeping this in mind, it is better to have
> separate functions? Otherwise we will have to use the version checks
> in the wled_set_brightness function, if we have the common function.

Okay, so it sounds reasonable to split this out to some degree.

Regards,
Bjorn
