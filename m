Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA72BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BF12184C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="F6JKn1yV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbeLSI6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:58:16 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36527 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbeLSI6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:58:16 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so9165510plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 00:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=W6pQQtiooT/ADwr0XYoNIMzL8tlsJR0JaZNF4kZWDrI=;
        b=F6JKn1yVP5lueLtgwPxp+yDvWTFKRqcarEHE2WzP54jpxFRj9lmSC5ZAG00/jHWcTY
         Gbo3IX0oRABOpflxVI8bc9aFze4u4uLuY97yD/5lKm9M0HWoPHiVljCz5/YQ/1gZsqys
         3FTpC/eVnii5SxDq3XNKdlBHavq6IQ3xJy0MhNGXZsoSZTgdPqjQphveI7xkkutmQo5V
         RQ3wScEFadf9+sRXO6hEWuyVJ7HC292JEsRdSAQttv+kL1Vw3CBRIKlUs2ttVtEgc+iy
         Z53LQwi3/mwVUXYpgO02ButEAKKnlpF249qTToh4dWqX4XhcXgYaMqxMqoyvRteQ+Qaq
         +Rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W6pQQtiooT/ADwr0XYoNIMzL8tlsJR0JaZNF4kZWDrI=;
        b=NNveMbe9hXUtZW8RRGozrxdxqcHLukCwRanUod3CknSXXEsZDDbvE4yNus9uZJyv/e
         Wvdm9j2Dt+QuaQwwBrMrIh/zwHlnkuVyPxy9zJVw19nkohNrCnpW/bySzV4eMBRxnP5Y
         MNIBJuC8dtF2mb9a+/oE1Dm016d9MDjTlCfAErKr5myRxQ5yuVoBAiRRX/sLBAYeKkEJ
         ByYG06r6zjGL7XBp/g8erT9d5WJxQ70s0nMbCy6gaejrj0N9rCBirasTj9GziSN25YQ1
         RXESQfaxi0FzL7UZAUNm53cXv/hpPn156L0Cne6r9XIHmoAbWu0pBqDy1Lu9Fq3m8t+g
         3BBg==
X-Gm-Message-State: AA+aEWZZbCRvOBOtdM9SeDNQLtPffs0zkXpTyNFN8c/Hk90QX9EUshdx
        TQrg203+mjd6Gb3DsvGsqyc9NQ==
X-Google-Smtp-Source: AFSGD/WRNTZZ+dSdON4HcO3tdpG+votukG8IzssFHtAmdV/BWQCB00sapVwCAUgFLY3LS8Wf2K6B/A==
X-Received: by 2002:a17:902:e290:: with SMTP id cf16mr20038663plb.81.1545209895409;
        Wed, 19 Dec 2018 00:58:15 -0800 (PST)
Received: from localhost.localdomain (36-239-224-74.dynamic-ip.hinet.net. [36.239.224.74])
        by smtp.gmail.com with ESMTPSA id e188sm21896281pfg.130.2018.12.19.00.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 00:58:14 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrei Stefanescu <andrei.stefanescu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: mcp16502: Fix missing n_voltages setting
Date:   Wed, 19 Dec 2018 16:58:04 +0800
Message-Id: <20181219085804.9601-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The n_voltages setting is not set, fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mcp16502.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 25d7b433fafd..ec5b6836a20c 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -90,6 +90,7 @@ static unsigned int mcp16502_of_map_mode(unsigned int mode)
 		.ops			= &(_ops),			\
 		.type			= REGULATOR_VOLTAGE,		\
 		.owner			= THIS_MODULE,			\
+		.n_voltages		= MCP16502_VSEL + 1,		\
 		.linear_ranges		= _ranges,			\
 		.n_linear_ranges	= ARRAY_SIZE(_ranges),		\
 		.of_match		= of_match_ptr(_name),		\
-- 
2.17.1

