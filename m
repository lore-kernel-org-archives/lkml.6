Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED1BECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6532086D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIBg0vjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6532086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388527AbeGTSuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:50:46 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37479 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388244AbeGTSuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:50:46 -0400
Received: by mail-lf1-f68.google.com with SMTP id j8-v6so2363465lfb.4;
        Fri, 20 Jul 2018 11:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vR6C3I2Fy9q9bRqLA8kcVUidjEGecyI3ITJaRwWs9TE=;
        b=VIBg0vjyFo6UuNYOZK6Ytq6kK4+0FQaKIO1VSL27sI1RqIcXRhpSC9Rip+3A00TsbT
         Uh/132qTXmZvLEKVx7MxeC7aaIyeTPNRrU0UGShWtVJWa+I3Oa1yBKJb8zS2+/qEM+2Q
         OD9xN7H3ZEZ9GMaEeLg2o8I/71ioAR6m8/jJ1u8To+/uf3yfQ2NA8+QSTKanKCi69O/G
         wXw4J+ykPGNM5Xug+PjbZlMtzMHY9Mb07xUGzDhGadQ3giJLSBMQOAwqSIotK+A96TYB
         jaAbUxROSKz6DX/0j0UOFgTxyiROGzk5hY1FcFDErpg39zZU/ASj8yG0pAqk675HcD+q
         9Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vR6C3I2Fy9q9bRqLA8kcVUidjEGecyI3ITJaRwWs9TE=;
        b=c141cN3YQOBnG4ehYWpANs8TaiPFXCQW3yAt+UgFkyLq2wQGWptqsp66VbaqlD3Pe1
         BT8UuYZcpOTnuQJlPYz27f9BkbSNHq+G3j3X+Jyz3Ls/3CgM1GIBzMWGfc89p4IIXtqc
         2nkgVevxvFBrIVb5Jr37IgTVDv+9AKFmekxUYboajY4xkisUQ5geYA3w09JhU2tTl13F
         eL88bA9QlLRCf15l1Hkw8qJfL5MbTyktn/SrKVw77+NRTPj3nY8n6hlKEXtWnEdNWJKr
         wAs9ZnJI053zRkxa6ka//op/x5VzFgLZAaUkE9GGY27BnOXhRmoVdP2lmyVUvI8VRWRm
         mDuA==
X-Gm-Message-State: AOUpUlG1pqc4U8Tt5S0N22ggNt306DdXYSeDTl45h5zBsGC8sMDbM2Wu
        IylKvcuIR8siU8R/QiZxj68=
X-Google-Smtp-Source: AAOMgpei6WCLtFHjbDXVx+oOPx7xULY7NZ2kxx9HME/yLS9R4TeMx0VT8OfIYxHKvT1KzjWVMz28dg==
X-Received: by 2002:a19:b519:: with SMTP id e25-v6mr1907510lff.119.1532109681760;
        Fri, 20 Jul 2018 11:01:21 -0700 (PDT)
Received: from z50.localnet ([31.0.82.186])
        by smtp.gmail.com with ESMTPSA id 85-v6sm381947lft.76.2018.07.20.11.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 11:01:21 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [RFC PATCH 2/8] mtd: rawnand: ams-delta: Write protect device during probe
Date:   Fri, 20 Jul 2018 20:02:02 +0200
Message-ID: <1627187.tdZp97APJX@z50>
In-Reply-To: <20180719082200.470ac8d1@bbrezillon>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180718235710.18242-3-jmkrzyszt@gmail.com> <20180719082200.470ac8d1@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 19, 2018 8:22:00 AM CEST Boris Brezillon wrote:
> On Thu, 19 Jul 2018 01:57:04 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Initialize NWP GPIO pin low to protect the device from hazard during
> > probe.  Release write protection as soon as the device is under
> > control.
> > 
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > ---
> >  drivers/mtd/nand/raw/ams-delta.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
> > index 48233d638d2a..6ac38e9cfa1a 100644
> > --- a/drivers/mtd/nand/raw/ams-delta.c
> > +++ b/drivers/mtd/nand/raw/ams-delta.c
> > @@ -219,8 +219,8 @@ static int ams_delta_init(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, priv);
> >  
> > -	/* Set chip enabled, but  */
> > -	priv->gpiod_nwp = devm_gpiod_get(&pdev->dev, "nwp", GPIOD_OUT_HIGH);
> > +	/* Set chip enabled but write protected */
> > +	priv->gpiod_nwp = devm_gpiod_get(&pdev->dev, "nwp", GPIOD_OUT_LOW);
> >  	if (IS_ERR(priv->gpiod_nwp)) {
> >  		err = PTR_ERR(priv->gpiod_nwp);
> >  		dev_err(&pdev->dev, "NWP GPIO request failed (%d)\n", err);
> > @@ -267,6 +267,9 @@ static int ams_delta_init(struct platform_device *pdev)
> >  	if (err)
> >  		goto out_mtd;
> >  
> > +	/* As soon as the device is found, release write protection */
> > +	gpiod_set_value(priv->gpiod_nwp, 1);
> 
> Please don't do that until we have a generic way to assert/deassert WP
> from the core. I agree that we shouldn't write things in the
> nand_scan() path, but I'd be more comfortable if the core had control
> on this pin just in case we ever need to disable write-protection
> during chip detection/initialization.

OK, I can drop this patch for now if that's what you suggest.
 
Thanks,
Janusz


