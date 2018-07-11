Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F5FC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE53220881
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dominion-thruhere-net.20150623.gappssmtp.com header.i=@dominion-thruhere-net.20150623.gappssmtp.com header.b="WJM6alyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE53220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominion.thruhere.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbeGKG4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 02:56:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35896 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeGKG4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 02:56:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id t3-v6so18336874eds.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 23:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lPKLPOYObV03grPgdMoKcfqDokZT1uBH81+Uic57yIU=;
        b=WJM6alyYPWvjDYOeZhT/X2ZWoBe8KnLUfXCOxxzQm46AunRgu8uxQv/TnWN4rbyPjl
         Wi0HHfiWF3tRz/tJfYYWAFb+e847jBp70vzmdiTnXVOadu9YSauPdBzVhYsVQB6BSjZS
         r/qmjnRgU8PL1adHmxmMTxsVxX99dA9NGF3bV4+POXVBZMz5Ytj2Fd6rwbIFEvY+qn+r
         H72pRtkUKA8O57cpXAGKudFAxJNbX6VQaKwzasDuh13AbGqyZO5V0BEKz1K6nOkmhXAd
         LlJkEHa6T5HUzKQYvGbbqYwZJ18kFetLNxM672I1kF5NAKrIHsSICB2JfuERyKnMdFeE
         USPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lPKLPOYObV03grPgdMoKcfqDokZT1uBH81+Uic57yIU=;
        b=WBlJnqs0LZHgsBvKfFQFhWDsXJ7Z3zK/liJxxn2pnjWLtoFmKcUAl0PpanoHh1gfek
         bv0ApgPCpXX3cRn4dttaigFVXeYEFUz1FDC7zbybcLV67uCRiZS3cZ7/olEoDTLjQKok
         XIblvR+duuP3LMBfLcXVDD/pcn2ECmLzv+XlAGVCanZN1Me0NKDJXSuQLZxOx/+HE/XD
         rv83YsdVvEMnxQnONMCd2AFF1St5adkOit53srlf/Ymg2cRmP3MXjIkblevdoILsf+ok
         fG/0LTRjmIO1zRvA4lD9cI8fp5brlX90j17F6Uyq5iT8rA0L7p93s/cVsup72yZNwu9q
         S6gQ==
X-Gm-Message-State: APt69E3ouVphWND/eow80xosZC2HroY0nWKtLuTpY2Z3b6vzkJQJ72An
        c/XZGK+R5FMGC862MrpGF9uZvg==
X-Google-Smtp-Source: AAOMgpdcY4l9j8syeLFQ2X2R8fXDjg7kp3yHNYaqhWZJ33fNOApqTCY8Vkhurzcx6z9e/JxW7qpaZQ==
X-Received: by 2002:a50:b2a6:: with SMTP id p35-v6mr30144776edd.215.1531292004192;
        Tue, 10 Jul 2018 23:53:24 -0700 (PDT)
Received: from localhost ([82.163.40.65])
        by smtp.gmail.com with ESMTPSA id n10-v6sm9300128edr.59.2018.07.10.23.53.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 23:53:23 -0700 (PDT)
From:   Koen Kooi <koen@dominion.thruhere.net>
To:     linux-omap@vger.kernel.org
Cc:     Koen Kooi <koen@dominion.thruhere.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        SZ Lin <sz.lin@moxa.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: Add vendor prefix for Sancloud
Date:   Wed, 11 Jul 2018 08:53:09 +0200
Message-Id: <1531291992-30512-2-git-send-email-koen@dominion.thruhere.net>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1531291992-30512-1-git-send-email-koen@dominion.thruhere.net>
References: <1531291992-30512-1-git-send-email-koen@dominion.thruhere.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Sancloud Ltd.

Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
---
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

