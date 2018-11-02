Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0390C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F8D2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV19jPWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F8D2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbeKBQsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 12:48:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44164 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKBQsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 12:48:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id j13-v6so614763pff.11;
        Fri, 02 Nov 2018 00:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BwAknXHU3CvvyG4AcdYDqFLDKfBIGw3GGTZAmDcZgzI=;
        b=VV19jPWQ3ll3wECm+8RgBItYXC+YlWyS1/E2XjbwLKxPMsgVW9h6juMnf0imVkoa+w
         EAhnu0OsARg8kCvZWOLU7l4TkPJ24F4XB31TZOCFVdYczGGCZSqlchTWoI1P0XxFll1J
         jDmJqxpCECqe1GfAD6WeqxT1WuvRiIIa852EKwo5z1Zx1teIES0D4nmjo3A+17hjgDm4
         AowL6SBPaAXZgxXJJCPRuHL63zK577SnZMCYXSwBz0qVPZ/XFXf86zN9ipJH9neGCf+s
         9ctszMyqRaypH9bAR5GsAzsXHuiEJJ6V2PaZUlqcRR18sfK88llDKUP4ROEnbbt0bCHx
         NLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BwAknXHU3CvvyG4AcdYDqFLDKfBIGw3GGTZAmDcZgzI=;
        b=fmB2m0nSsPemyA0SXpzifCMDf1iqka2tSJyRNSbgu1Tp0n2/7GhTji0p1zZFLiJjuW
         JoE8tKPzUMWWNL35D+fqTNa5vv5IzrWfKpl92aEKvWfO+aT8NmJKGqGqRwQB9W54w/mz
         nSRhUasepz+4Tv3hL8nm4C2HdyMs58OSyYHDBhTM4SaV32x1YKafKJqujKqfcxJzhe15
         udj5uxpqrEztqv21UV7EtRz87DEmJ9hp7zXzABDGoCrb3ZDifML+6ghLaKZ+REYeySsi
         fdUBCEh7e7QzHcxWDJjMeaRQ+uEYZ7ZwY181VHQGBnUeEJw3fu3vw0BEHcnMSS7Uab7U
         hqMA==
X-Gm-Message-State: AGRZ1gKktGqcyE9m5sOIWdVnBLrYTo5XMNgQef7KQ5LQUuXiADWalHa3
        aKpis71tGWe+sw2AisKoZn4=
X-Google-Smtp-Source: AJdET5dH9WG4PoWGliNvqR1Rk9EM+iChbzwT9HTSJEZkUytieEH94tUFDi72Bs6Dc0utS5U3jLY3pA==
X-Received: by 2002:a62:9f11:: with SMTP id g17-v6mr10720729pfe.144.1541144551119;
        Fri, 02 Nov 2018 00:42:31 -0700 (PDT)
Received: from localhost (97.64.17.87.16clouds.com. [97.64.17.87])
        by smtp.gmail.com with ESMTPSA id y184sm654113pgd.71.2018.11.02.00.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 00:42:30 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        preid@electromag.com.au, himanshujha199640@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH v5 1/3] dt-bindings: Add PNI to the vendor prefixes.
Date:   Fri,  2 Nov 2018 15:42:07 +0800
Message-Id: <20181102074209.12620-2-songqiang1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181102074209.12620-1-songqiang1304521@gmail.com>
References: <20181102074209.12620-1-songqiang1304521@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8fcc16..adcdf60124dd 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -303,6 +303,7 @@ pixcir  PIXCIR MICROELECTRONICS Co., Ltd
 plathome	Plat'Home Co., Ltd.
 plda	PLDA
 plx	Broadcom Corporation (formerly PLX Technology)
+pni     PNI Sensor Corporation
 portwell	Portwell Inc.
 poslab	Poslab Technology Co., Ltd.
 powervr	PowerVR (deprecated, use img)
-- 
2.17.1

