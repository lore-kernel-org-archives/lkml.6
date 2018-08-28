Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BC6C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222F72088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEgJxfPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222F72088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeH1U7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:59:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46518 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeH1U7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:59:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id a108-v6so2245367wrc.13;
        Tue, 28 Aug 2018 10:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GoQS+Y3dk7D+EnkKnilGHShYfCR2R3ibWaExXqv4wXc=;
        b=dEgJxfPiIu3H16+Uxl7wwuvVjTl7d4rtHsJo5cN/E79eCWniIHbBJjNqSPU4j8iLjg
         7wt+LTv+WBlZ2xFCnME8q6gn1dl8K4fjJgiKVcVq6/9ZpSeACgKxaEfARpl0k6/cThDT
         e8bQV0SH8WBCV1iuUDxdxmC5C6ggRNcNfjsCX8AJVRQYOGzBtpXCj7fT76lnrcLc2IcB
         BcTmj8WOaKOp6+XKZn5QEhXkCLuE+7IDRksWwdTMaddB+BheM8yIK9AstDlJ4tcs9Qsp
         fGHeyGfA3tABaUJvP9jpECY+2m5BzFrERI9pCcb/NcjcWpA/9LYHLWqIsuieeDxsnD6w
         fA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GoQS+Y3dk7D+EnkKnilGHShYfCR2R3ibWaExXqv4wXc=;
        b=kYRmqyxxlIWgfnWc8PsvpaOFGFVxchQAONdtucaJmMeIrKhVofRU4BL3JrWLucaekb
         BNZRfebxgG7d5K40n2byDUDOliQZvkepNTkdAy479RsDpC+MRzEsSfrqzL5xvHwW562r
         OhV/QHMSxc2wF+RmQcXZtY3fRvXgKJroMOhIJqylVbeRHCgaSeoiXVVU0r5Ce2wVhg4z
         Yr39o/01KzKyc0RlOVS7iZKawZwzrDXKJYP/CWMJdaz281YFztIcq/leG0rYouQXn90Z
         C721iQXMHijOVx4EJVb9yTWkYlngNDqvoO64EpdbTVze9czpkeYpx+Gi4Pe+RDyV/uL8
         I0+Q==
X-Gm-Message-State: APzg51CM5EB2MAINsDfeyi86w6q5ZEhIAZF+wedOSomUTcxsC8Ef+R6+
        gXE/wt9CVS3VCT26BlsKSegYCUqpqks=
X-Google-Smtp-Source: ANB0VdYzw3gRpF9oItfuwAtzBFIElC71IE9M8cMFA20bQen9mxhvwhrRwl4fMm4eYn7LK6yJDOs0FQ==
X-Received: by 2002:a5d:6381:: with SMTP id p1-v6mr1750111wru.106.1535476002569;
        Tue, 28 Aug 2018 10:06:42 -0700 (PDT)
Received: from menoah.home ([2a01:cb19:190:c500:bc4f:281b:73be:395d])
        by smtp.gmail.com with ESMTPSA id k13-v6sm979189wrq.7.2018.08.28.10.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 10:06:41 -0700 (PDT)
From:   Pierre-Jean Texier <texier.pj2@gmail.com>
Cc:     texier.pj2@gmail.com, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx7s-warp: use SPDX-License-Identifier
Date:   Tue, 28 Aug 2018 19:06:37 +0200
Message-Id: <1535475997-21027-1-git-send-email-texier.pj2@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease
license compliance management.

Signed-off-by: Pierre-Jean Texier <texier.pj2@gmail.com>
---
 arch/arm/boot/dts/imx7s-warp.dts | 39 +--------------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index fa390da..bf33c74 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -1,44 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2016 NXP Semiconductors.
  * Author: Fabio Estevam <fabio.estevam@nxp.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
 /dts-v1/;
-- 
2.7.4

