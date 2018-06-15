Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E1A48C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D28B208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7vwv4Il"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D28B208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965613AbeFOJQz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:16:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55421 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965488AbeFOJQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:16:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id v16-v6so2384719wmh.5;
        Fri, 15 Jun 2018 02:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u8uyJeGy/cAiD8T6tosGrx1vHzCQmRrW/SKPd54wM4A=;
        b=G7vwv4Ilpg/2vN5VoS2EmAdf26YMkDvt7GfU3Hd0zC+L3sxy3LEgb7ITBJzVCPu1K+
         dnuh28HqXgFsC8WprultWUy0EH3fVzbriTQINBY6FlzSfj7CCSDShc96zCfudR1vXIkt
         dhVBeA0rIbHSwIF3XN26jk61IuDXhbMIp3bsHHg+EXmgCKgLOmsh34CCWaZvy5vmJ+6k
         AKvyEFRFXJtpindMxTLTX0FVbedXbotI1FHA4zYu5yw+og8GN3DgulyL8+E8UUgbf+yY
         pMjlzTHNR36XnXZh8C9UzCxm9W49Os5sAg4dG+J/wFIN6zj/5nRE3Um9oaZpU2BOhWCA
         ZOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u8uyJeGy/cAiD8T6tosGrx1vHzCQmRrW/SKPd54wM4A=;
        b=Qpphk1PHYftPGW/hJbYmBgD8tPQ7Y/y5vKkS+XB96mS5g4T3VqnsGsmkwgpiaybkYv
         ky7gyVo1uaArS5VS6GJh/xc9FFJEESjCS5gHrtxfeSbetk2SZnA5xXIrFbXoG2JxsqQX
         BFwB/Fmeh1kK+sy3uqfSJ4bDGEZvuIMqYOOqi7jYw6Uzu5rBk5BX2wJ60x2uBOmWhvok
         i08yCfnsnfltQ6/6qVwmFStjZ9bbkAZDq716IeemeAabcdxM3HjX7+/KLm8627dyifHr
         iQQswWcXGBXFNKY0y68Swa3mbbTZB8Hym165Oi4AcV097bFH+8dk2TvXiaCXlBZuPex8
         /cOQ==
X-Gm-Message-State: APt69E02Sdn3SIiMI3+65szFM2raxbH8/9M9yZFaonBbKZX/dmXxnj2t
        i5GltPzr2vapIzWQN533RL8=
X-Google-Smtp-Source: ADUXVKLQpro8fYUiiDZSdlJlriXwDPHuibu9gON7xAf2HKX9RjgKIlZBddbpPILNk1b+xIh0suDF8g==
X-Received: by 2002:a1c:b745:: with SMTP id h66-v6mr575194wmf.151.1529054212550;
        Fri, 15 Jun 2018 02:16:52 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id i46-v6sm15490464wra.36.2018.06.15.02.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 02:16:51 -0700 (PDT)
Date:   Fri, 15 Jun 2018 11:16:50 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] Re: [PATCH] crypto: sun4i-ss: prevent deadlock on
 emulated hardware
Message-ID: <20180615091650.GC3047@Red>
References: <20180614193659.29261-1-clabbe.montjoie@gmail.com>
 <20180615075754.b3ivyagjsomiafwk@flea>
 <20180615081554.GA3047@Red>
 <20180615090412.xgw35ga5cvc6w3h3@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615090412.xgw35ga5cvc6w3h3@flea>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 11:04:12AM +0200, Maxime Ripard wrote:
> On Fri, Jun 15, 2018 at 10:15:54AM +0200, Corentin Labbe wrote:
> > On Fri, Jun 15, 2018 at 09:57:54AM +0200, Maxime Ripard wrote:
> > > On Thu, Jun 14, 2018 at 09:36:59PM +0200, Corentin Labbe wrote:
> > > > Running a qemu emulated cubieboard with sun4i-ss driver enabled led to a never
> > > > ending boot.
> > > > This is due to sun4i-ss deadlocked and taking all cpu in an infinite loop.
> > > > Since the crypto hardware is not implemented, all registers are read as 0.
> > > > So sun4i-ss will never progress in any operations. (TX_CNT being always 0)
> > > > 
> > > > The first idea is to add a "TX_CNT always zero timeout" but this made cipher/hash loops
> > > > more complex and prevent a case that never happen on real hardware.
> > > > 
> > > > The best way to fix is to check at probe time if we run on a virtual
> > > > machine with hardware emulated but non-implemented and prevent
> > > > sun4i-ss to be loaded in that case.
> > > > Letting sun4i-ss to load is useless anyway since all crypto algorithm will be
> > > > disabled since they will fail crypto selftests.
> > > > 
> > > > Tested-on: qemu-cubieboard
> > > > Tested-on: cubieboard2
> > > > 
> > > > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > > > ---
> > > >  drivers/crypto/sunxi-ss/sun4i-ss-core.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-core.c b/drivers/crypto/sunxi-ss/sun4i-ss-core.c
> > > > index a81d89b3b7d8..a178e80adcf3 100644
> > > > --- a/drivers/crypto/sunxi-ss/sun4i-ss-core.c
> > > > +++ b/drivers/crypto/sunxi-ss/sun4i-ss-core.c
> > > > @@ -341,9 +341,18 @@ static int sun4i_ss_probe(struct platform_device *pdev)
> > > >  	 * I expect to be a sort of Security System Revision number.
> > > >  	 * Since the A80 seems to have an other version of SS
> > > >  	 * this info could be useful
> > > > +	 * Detect virtual machine with non-implemented hardware
> > > > +	 * (qemu-cubieboard) by checking the register value after a write to it.
> > > > +	 * On non-implemented hardware, all registers are read as 0.
> > > > +	 * On real hardware we should have a value > 0.
> > > >  	 */
> > > >  	writel(SS_ENABLED, ss->base + SS_CTL);
> > > >  	v = readl(ss->base + SS_CTL);
> > > > +	if (!v) {
> > > > +		dev_err(&pdev->dev, "Qemu with non-implemented SS detected.\n");
> > > > +		err = -ENODEV;
> > > > +		goto error_rst;
> > > > +	}
> > > 
> > > This is wrong way to tackle the issue. There's multiple reason why
> > > this could happen (for example the device not being clocked, or
> > > maintained in reset). There's nothing specific about qemu here, and
> > > the fundamental issue isn't that the device isn't functional in qemu,
> > > it's that qemu lies about which hardware it can emulate in the DT it
> > > passes to the kernel.
> > > 
> > > There's no way this can scale, alone from the fact that qemu should
> > > patch the DT according to what it can do. Not trying to chase after
> > > each and every device that is broken in qemu.
> > > 
> > > NAK.
> > > 
> > 
> > My fix detect also when the device is badly clocked.
> 
> In which case, the proper fix is to enable the clock, not throw the
> kernel's arm up in the air.
> 

By badly I mean "not clocked" or "with the wrong frequencies".

I could change the clock rate range test to exit (it issue only a warning for now).
But I think this fix detect all cases and still permit someone to play with overclocking/downclocking.

Regards
