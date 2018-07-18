Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33800ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A9720673
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiWxlCd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A9720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbeGRRsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:48:00 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:56301 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbeGRRsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:48:00 -0400
Received: by mail-it0-f68.google.com with SMTP id 16-v6so5163010itl.5;
        Wed, 18 Jul 2018 10:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J2w8KPi3/w/ulogr2wJhnS6JbCr3nZP8SC2pMZOnIfo=;
        b=iiWxlCd3ewafN7Sev/IJFL9otQPlJ3Mcd5CKCeNStsbUFIcqFVLqJrADPVsH1bd6h0
         /9UoZaBKf1AT/Z3Jf89KapjRShffDc6UtDx8XQOjL7LRTHI2G3GVasKNi7cD9b2JcSrg
         oP9k9iWwbptC8seg7tvJaBKXLx8sP5mMVD7PQ0N4MKaVu9olcdjHryl9UGteKj0DZsZz
         emzU5vOiVitUNOGgbU7N1XnlD4oJnxKjIooUMaT1sTGyLhCGu1J1IhVckwjp2VEB6XnK
         iU1GWmyFz5Nmy84zanQLle5Tq8KdxSwGRHmytkupzKPdJbHMxYOeknuKxAT9zeAdJyOH
         RgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J2w8KPi3/w/ulogr2wJhnS6JbCr3nZP8SC2pMZOnIfo=;
        b=ZIPN6evdrHdhCQa2uhefAJ7n8LjBjsMpg5ftJnj41c/LCPKa5efKozFmdZ/iCVu0vQ
         KOcSBbfShF0kDdToNQtnnKgI07HEEz8Rh8dCj3TouOHMqNvko86euNKT2XsuDI+F0iYj
         KCGe2MJmsuAugVtTX+t1tERCqhTJhqdGKWONiZ2EkorXGArXVEfciIoYuZA08fDJsnJk
         Z3s9Bs5BBzpb/jrA0D4O8KjjglX3y4FZJciMoF5qx2zdOg22mlIceHKB54CRymzWfk0D
         mDGqvAhmAwBGqpqF9hldW8wWocrrzyNPwivOf+GmN+Xp3j/F54+UbVNZ7Q1BRke+tEKz
         xVFA==
X-Gm-Message-State: AOUpUlGoN3exuWQ5S40KgzUNCvmjbiFTRuskXwNuK17TK/bDs/jO2+m8
        N2scPLBT6QU9pufZA65Pn6k=
X-Google-Smtp-Source: AAOMgpePPkoMLSzL1uN4/ds+lSBKfG0vq+N/NAyNEYDel//9POkB2zF2QgSUMGZX8RJomK97Xc6KLQ==
X-Received: by 2002:a24:b604:: with SMTP id g4-v6mr2803578itf.101.1531933749345;
        Wed, 18 Jul 2018 10:09:09 -0700 (PDT)
Received: from localhost ([12.130.117.108])
        by smtp.gmail.com with ESMTPSA id m140-v6sm1684635itb.11.2018.07.18.10.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 10:09:08 -0700 (PDT)
Date:   Wed, 18 Jul 2018 17:09:02 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Vignesh R <vigneshr@ti.com>, Jonathan Cameron <jic23@kernel.org>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 0/5] ti_am335x_tsc: Enable wakeup capability
Message-ID: <20180718170902.vk7rahyoaevucxbi@penguin>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <dcb4a63b-9ecb-a72e-bfb8-ebb62017b4f7@ti.com>
 <20180718074736.GA4641@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718074736.GA4641@dell>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 08:47:36AM +0100, Lee Jones wrote:
> On Tue, 17 Jul 2018, Vignesh R wrote:
> 
> > Hi Dmitry,
> > 
> > On Saturday 30 June 2018 04:03 PM, Vignesh R wrote:
> > > On AM335x, resistive TSC can wakeup the system from low power state.
> > > Currently, parent MFD device is marked as wakeup source, which is
> > > inaccurate as its the touch event generated by TSC thats the wakeup
> > > source. This series moves all wakeup related calls to operate on TSC
> > > device instead of MFD. It also marks TSC IRQ as wakeup capable, so that
> > > its not disabled during system suspend.
> > > 
> > > This series is based on Dmitry's comments here:
> > > https://lkml.org/lkml/2018/4/24/65
> > > 
> > > There are many new patches in this series, hence did not mark this as v4.
> > > 
> > > Vignesh R (5):
> > >   mfd: ti_am335x_tscadc: Don't mark TSCADC MFD as wakeup capable
> > >   Input: ti_am335x_tsc: Mark TSC device as wakeup source
> > >   mfd: ti_am335x_tscadc: Keep ADC interface on if child is wakeup
> > >     capable
> > >   iio: adc: ti_am335x_adc: Disable ADC during suspend unconditionally
> > >   Input: ti_am335x_tsc: Mark IRQ as wakeup capable
> > > 
> > >  drivers/iio/adc/ti_am335x_adc.c           | 12 ++++--------
> > >  drivers/input/touchscreen/ti_am335x_tsc.c | 22 +++++++++++++++++-----
> > >  drivers/mfd/ti_am335x_tscadc.c            | 14 +++++++++++++-
> > >  3 files changed, 34 insertions(+), 14 deletions(-)
> > > 
> > 
> > Gentle ping... Could you review/pick this series? MFD amd IIO bits are
> > already ACKed
> 
> MFD patches are reviewed "for my own reference" meaning that we
> haven't yet agreed on a merge plan yet.

I think this series makes sense to be pushed through a single tree as
opposed to being spread between 3, even if it could technically be
possible. It looks like Jonathan is fine with going it through either
his or some other tree, I am fine with it going through MFD. I just
Acked the 2 input-related patches.

Thanks.

-- 
Dmitry
