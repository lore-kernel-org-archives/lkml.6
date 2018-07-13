Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F0BECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D7C2089C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dominion-thruhere-net.20150623.gappssmtp.com header.i=@dominion-thruhere-net.20150623.gappssmtp.com header.b="vxFCVTqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D7C2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominion.thruhere.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbeGMGii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 02:38:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45190 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeGMGig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 02:38:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id i20-v6so10695617eds.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 23:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cn/kE1oD1u/R+hJvm8gH36WislHxk3EZp6a0ZUzDhkI=;
        b=vxFCVTqSnZVXcGM7PgsDwfPtSpPj1N/l1AU0LE9wDgvhG+/TfNTZoSaCRPJpumigiC
         AljiADx+cX9z2XylyMA480dAa74MqVioY9n0Ty8cJWqg1Ar07vMgHdQvG9tDZZdppych
         ZDk7hpsTjtT7ILr/MixTpr0PpeFH9qKMwuJUflFgj7z51mMCjMB0837SaDhBO9WntEGI
         8s6l5GH6qvV1ccp/uxem5eEI1m/qb1paTRpVvDaBCLGfZNZsIeOHbpmrJO6HROI8zp95
         W1NmlwoOw6fud0G9yweuGB6IVpwXxNsTn2nodFdm+HU6p3MJImpaVKMXEVrbk2Stc2Ma
         6OdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cn/kE1oD1u/R+hJvm8gH36WislHxk3EZp6a0ZUzDhkI=;
        b=VMmCoRMcSpiisE1oWpYQVZhIHREsmAoMi5ZrP4z91fD63AclZ/gYKl155jTksxAoh/
         BhR4+kidpJ7w4uOpVhfcA9dwRKwIiV6zdhbrcTyvqXOUYIgv4gJpAt4YEVCEnc9nmMI0
         P5VhUagDOmQh3IhZBeYS8EZBVbQTjXsHcArddOwNSmW2MTeqb7pWt/6P/Q7X2tX+VJi7
         2HkCOZQNFl34Uh3RTddtxFssujO6NF4xvmU6X+UothO/LO7DTRNGOez5ANyDYKSlCSM8
         VcoWWgsyZZ8DDc3W6D0wkt58x3jyCh8r5TDtWts9eSoaXzCgzNOQKbrRnMN1XWRy7sjt
         w5YQ==
X-Gm-Message-State: AOUpUlHghzSJAG1uE0ZWHa+ooJGBt9bGDVGJg8OKldENqxThZOqq928+
        mUAsbnihsmGAAMJJMYtqyLyL1w==
X-Google-Smtp-Source: AAOMgpeHlxPEEmuB++NvTWwMUjdyWLXv0nmxIHjaKGRBS629mL72HnC4g+wXcRZ9A6qFyJ8tlXlx9Q==
X-Received: by 2002:a50:955e:: with SMTP id v30-v6mr5766927eda.268.1531463127409;
        Thu, 12 Jul 2018 23:25:27 -0700 (PDT)
Received: from localhost ([82.163.40.65])
        by smtp.gmail.com with ESMTPSA id a2-v6sm976611ede.21.2018.07.12.23.25.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 23:25:26 -0700 (PDT)
From:   Koen Kooi <koen@dominion.thruhere.net>
To:     linux-omap@vger.kernel.org
Cc:     Koen Kooi <koen@dominion.thruhere.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        Shawn Guo <shawnguo@kernel.org>, SZ Lin <sz.lin@moxa.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: Add vendor prefix for Sancloud
Date:   Fri, 13 Jul 2018 08:25:19 +0200
Message-Id: <1531463123-30340-2-git-send-email-koen@dominion.thruhere.net>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1531463123-30340-1-git-send-email-koen@dominion.thruhere.net>
References: <1531463123-30340-1-git-send-email-koen@dominion.thruhere.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Sancloud Ltd.

Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
Acked-by: Rob Herring <robh@kernel.org>
---

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

