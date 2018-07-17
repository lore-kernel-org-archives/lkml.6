Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A409EECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6F1208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dominion-thruhere-net.20150623.gappssmtp.com header.i=@dominion-thruhere-net.20150623.gappssmtp.com header.b="Xtaq19d4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6F1208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominion.thruhere.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbeGQHXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:23:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40976 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbeGQHXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:23:41 -0400
Received: by mail-ed1-f65.google.com with SMTP id s24-v6so267944edr.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 23:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CkXzUIntqWgB6DdWCIPR+BzNgd7spEli8/WPBRHS1u4=;
        b=Xtaq19d4W2TjAq1OGPATQzOM0QZPtMquXlS/5TxJvDNeUGgBbEsMcd1QjWCgMFalnL
         of9CAOfEoZ5Pm7QOs+9CQU827Cjlcj6yWIB5Jiis9raf2tjHylqkVqxgS0LHQ3/2Gumt
         mvARI+VQN3vV5GQYb1fh8N70tBCtSHktiHyA9XdURczbX9oIN4G63KIXrBLktQ2uMmRz
         Dq5BpeOTBdTR8lknUpNTH1nST0SVIDI8V0qk/vdTdPqejTiCB4BEl2dvBnkNrb5uQjfu
         Z+RmFLor/8hInchy/d+hModmaPsH9Wk89tcjU/1KwuqQOCcMaq0b05u4ESWeqB8+AhvQ
         Yo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CkXzUIntqWgB6DdWCIPR+BzNgd7spEli8/WPBRHS1u4=;
        b=UqXAZ360LZUJNNBSdZekI5eSvquBPQOv/k+VQC0AT80q0n5C8Oq7W1AVIwqWurdY6j
         36i75GthVEy3roV6bqvASj0fjwKgrM2tgs/ZAMY/wm8zeeu743EnynEc52BEoblj2RYg
         uWKpA5MA+sCRncLd/eNZUoojXjASzRZE7hpDNG+yin2nej5grqorr0mCRELgAa+fBRq7
         SYSLp1vlVt3PKGxjbe2TadgtXu28eJpymq4sOZoJFgz7lf5dh43z2zwccz7WqJ3MFZ4i
         XF/+Jvw9XTnQ+xDxDASgtgzJs14XwJ5UBjqJ53hXddynUP6B7c1ADdJ9HTR6iGkdPZSD
         rSag==
X-Gm-Message-State: AOUpUlER68+EZjtDAKJPclFIIeZSzl38F2PFVeElmDmr2gHE/6U111i5
        esA53ycq4Sog0yNxNiKY9Ca/Tg==
X-Google-Smtp-Source: AAOMgpdExypI7oVDdmQKkintfLcLPTdAtV0flw+UxXlg3xSVsap8tpOw5Wo86RP2J/3az1859zYeOQ==
X-Received: by 2002:a50:a962:: with SMTP id m31-v6mr976167edc.180.1531810356373;
        Mon, 16 Jul 2018 23:52:36 -0700 (PDT)
Received: from localhost ([82.163.40.65])
        by smtp.gmail.com with ESMTPSA id g6-v6sm191740edn.28.2018.07.16.23.52.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 16 Jul 2018 23:52:35 -0700 (PDT)
From:   Koen Kooi <koen@dominion.thruhere.net>
To:     linux-omap@vger.kernel.org
Cc:     Koen Kooi <koen@dominion.thruhere.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>, SZ Lin <sz.lin@moxa.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: Add vendor prefix for Sancloud
Date:   Tue, 17 Jul 2018 08:51:48 +0200
Message-Id: <1531810311-29915-2-git-send-email-koen@dominion.thruhere.net>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1531810311-29915-1-git-send-email-koen@dominion.thruhere.net>
References: <1531810311-29915-1-git-send-email-koen@dominion.thruhere.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Sancloud Ltd.

Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
Acked-by: Rob Herring <robh@kernel.org>
---

v6: No changes
v5: No changes
v4: Add Acked-by
v3: No changes
v2: No changes
v1: Initial submission

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 7cad066..c7aaa1f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -314,6 +314,7 @@ rohm	ROHM Semiconductor Co., Ltd
 roofull	Shenzhen Roofull Technology Co, Ltd
 samsung	Samsung Semiconductor
 samtec	Samtec/Softing company
+sancloud	Sancloud Ltd
 sandisk	Sandisk Corporation
 sbs	Smart Battery System
 schindler	Schindler
-- 
2.0.1

