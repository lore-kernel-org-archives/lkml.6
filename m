Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EF0C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE5922393
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJFkwNzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE5922393
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeHJB4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 21:56:07 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43023 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbeHJB4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 21:56:06 -0400
Received: by mail-qt0-f194.google.com with SMTP id f18-v6so8485367qtp.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 16:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NpeV+aJ7LaJRP69LLtGKMBm9N8UzxobKqW9qf8JHJtM=;
        b=DJFkwNztovO5iV1drvn/ZpmQfAuBmTIGSGnTHUVSYEjOW9o9rezEww+TDH0GJ+I9IJ
         OdthP2gXB6Sp8M1CvjLc7/KPJPIrxnrroraGYUKCP1KazePCiIoXwWpDXy4y4sV4+3Ys
         NKp0U2bMd+53P6k8Qtft01fcdR5wjsxWpYAgfm9kZz/TARY+ElnTHxVCNL7YN1Youk+t
         mbxf+G1byHckeohHOf51fNLaovICJp5trIKiS76g9948cCdxPlT9oXrjP8iB6U8s9IGR
         Kx/eTHgkvfxDWr8xe7Ldc+Yf3EwzpV8/SxCmODC7NP1/Pa5szW7ywNDwBQpKwkp7sKuv
         y0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NpeV+aJ7LaJRP69LLtGKMBm9N8UzxobKqW9qf8JHJtM=;
        b=IXrEPV0CRv7hXH0Chzxk8Xqw6rvBa6Qfash0xXkNk3m/OiriDumFYK/4TmiflIzVVS
         jMkK3dGRauLXN7A1mqvbDbpMI4xO7YLZBQKY1ryQ+gvBMzb4KWq5w3rdxMLBpKLUYhFe
         NMepz3EzgkhraZE4xMR3nTku96JwAOo9lg9i9YBCdcHYlgQbVZIOv957hlXvoULVUg3z
         90Twz84U+a0yqCzfeoQ5cjmyDxwSUIuooAeTzNE0eDwNjgglMvyZS6SkGlIZm9WEVR92
         92/YC2jNftz2RksDoT4GalmxpkPMrSqBIBpnLeYXc7kdTCid1pp2d/rddVQ4W7W0h9in
         3bng==
X-Gm-Message-State: AOUpUlE5ETqrcE5eiKJOFxeQkMHj7P+5/lfFPYDRZlZrB4jubVAygWrd
        gxByDDcwElOyp1NVKvv+Ya8=
X-Google-Smtp-Source: AA+uWPwf+Cl5PN0UC+tiCHt7nSiGzxNHejo5BkEDHJNE1OAGL5UoaOJvCq8IlFD6r2EkMGQ06w2YMg==
X-Received: by 2002:ac8:1779:: with SMTP id u54-v6mr4209257qtk.285.1533857338739;
        Thu, 09 Aug 2018 16:28:58 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id j88-v6sm5221763qte.49.2018.08.09.16.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 16:28:58 -0700 (PDT)
Date:   Thu, 9 Aug 2018 20:28:51 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: fbtft: Moves ";" from macro definition to macro
 usage.
Message-ID: <d3d79581fccabb25174f5679415c2f985d1271a4.1533857298.git.leobras.c@gmail.com>
References: <cover.1533857298.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1533857298.git.leobras.c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the macro usage more like a function declaration.
Also, ending a macro definition with ";" is not
recommended by checkpatch.pl.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 8ce1ff9b6c2a..274388313780 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -60,11 +60,11 @@ void func(struct fbtft_par *par, int len, ...)                                \
 out:									      \
 	va_end(args);                                                         \
 }                                                                             \
-EXPORT_SYMBOL(func);
+EXPORT_SYMBOL(func)
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
-define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, );
+define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, );
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, );
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.18.0

