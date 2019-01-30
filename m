Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378F3C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0798C2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baUrPWxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfA3P1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:27:11 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33479 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfA3P1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:27:11 -0500
Received: by mail-ed1-f66.google.com with SMTP id p6so19374515eds.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 07:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=f98j6mmZbCQLTqIqnb3teBzYPbTR/4082gObU1s4slE=;
        b=baUrPWxCGlxVe2uAI4kSkA23zzz+ccit+b8/VSStN1i/WOC+l0T8pclJ6Nj+OWaye7
         sLn2SI1/lxTAFV1lYZotffBfLG15LcZ18RT53AUPWOpm6ZaZhaUwtI2ejUM/RKQGs2VR
         XBKjUAnfq+FlxoKnePDzCVxps4TPo49iI//M/OaHPPlhIfpDESsYZjllD4w1UrGQpaIS
         t4V1YlvJgHm8PHqfJM5Xr1TSGhCmyzlvJhN0P7ytI9bihq7a5jX0T+bFujpHcfhAPPjr
         bC+J3zDAWOr4ht6hdfjdoyB7JztHUDZkkyEIcpzmQawXtwicawf3Cfmip811H58ljJkh
         w80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=f98j6mmZbCQLTqIqnb3teBzYPbTR/4082gObU1s4slE=;
        b=aEgTfcCGqSWQbyazVYQDUsGnTjABWq+0UsQXDbzQu8ZHTY24KlVWGYkmo7m3xZ3Rzk
         b/SiMdF92ea33Eh2eCnleuUaOoUMdBMMj6Xhc17Bwff35osKE3U1ZXKtcGQUrKUhi5jV
         akxdiWWKBEOusqfQEFFiTUDRpwPlwK3qkMzzSCYNMFcwHq/f0yVlQn79VUEr5tzKI2P5
         7hwUg21q1QGZsaZlXm6+Om3w91DCUTBITtH1r7woheH9GFFdrN0k3HJpd7PtztJNwqZn
         xcajE48X9JDEwzqyZfDSYNnjgH7zIlkGdog50jmNM/mhOMmT3teFRr2oU2xgFllrsl+s
         OCqg==
X-Gm-Message-State: AJcUukc9AcRaT7kX/yXdvLSTH7Wcqf6LkixC1xeAoMzc7TQl3QlqFgKV
        ni6hp4DIxWM/ZlcWUhciREKPfAsuHUsfeQ==
X-Google-Smtp-Source: ALg8bN6wKA2nlz5ve8BB6vTXAxwchE9xOXTpsWrpY7PaG2MMsVCgYiowLAPbsaj+v3xfOdfkq6g2wg==
X-Received: by 2002:a50:90c6:: with SMTP id d6mr31209880eda.15.1548862029089;
        Wed, 30 Jan 2019 07:27:09 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id p16-v6sm352314eju.73.2019.01.30.07.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 07:27:08 -0800 (PST)
Date:   Wed, 30 Jan 2019 08:27:06 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: meson: Fix linking error on 32-bit
 platforms
Message-ID: <20190130152706.GA31999@archlinux-ryzen>
References: <20190129214657.5877-1-natechancellor@gmail.com>
 <42d2e92e-9f5a-62b2-c0af-b7f3544d79d2@amlogic.com>
 <20190130103220.27b13ab9@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190130103220.27b13ab9@xps13>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 10:32:20AM +0100, Miquel Raynal wrote:
> Hi Liang, Nathan,
> 
> Liang Yang <liang.yang@amlogic.com> wrote on Wed, 30 Jan 2019 17:26:39
> +0800:
> 
> > Hi Nathan,
> > 
> > On 2019/1/30 5:46, Nathan Chancellor wrote:
> > > On arm little endian allyesconfig:
> > > 
> > >    ld.lld: error: undefined symbol: __aeabi_uldivmod  
> > >    >>> referenced by meson_nand.c
> > >    >>> mtd/nand/raw/meson_nand.o:(meson_nfc_setup_data_interface) in archive drivers/built-in.a  
> > > 
> > > The dividend tBERS_max is u64, meaning we need to use DIV_ROUND_UP_ULL
> > > (which wraps do_div) to prevent the compiler from emitting
> > > __aebi_uldivmod.
> > > 
> > > Fixes: 2d570b34b41a ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >   drivers/mtd/nand/raw/meson_nand.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> > > index e858d58d97b0..6f12a96195d1 100644
> > > --- a/drivers/mtd/nand/raw/meson_nand.c
> > > +++ b/drivers/mtd/nand/raw/meson_nand.c
> > > @@ -1116,8 +1116,8 @@ int meson_nfc_setup_data_interface(struct nand_chip *nand, int csline,
> > >   				       div * NFC_CLK_CYCLE);
> > >   	meson_chip->tadl = DIV_ROUND_UP(PSEC_TO_NSEC(timings->tADL_min),
> > >   					div * NFC_CLK_CYCLE);
> > > -	tbers_clocks = DIV_ROUND_UP(PSEC_TO_NSEC(timings->tBERS_max),
> > > -				    div * NFC_CLK_CYCLE);
> > > +	tbers_clocks = DIV_ROUND_UP_ULL(PSEC_TO_NSEC(timings->tBERS_max),
> > > +					div * NFC_CLK_CYCLE);  
> > 
> > Looks good to me:
> > 
> > Acked-by: Liang Yang <liang.yang@amlogic.com>
> 
> This is nand/next material, so if you don't mind I would like to squash
> this fix into the original commit inserting the driver.
> 
> 
> Thanks,
> Miquèl

Hi Miquel,

That is totally fine by me, thanks for the quick response!

Nathan
