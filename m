Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F96C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDCC21884
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBDCC21884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeHHBwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 21:52:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40391 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeHHBwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 21:52:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id x5-v6so163465pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 16:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sgS7uSKHd3U40z7M6lV1Z8K23SqJlzTdOphb9vDOlRk=;
        b=Iccf/LXxX7lD11p2h7fm5p3NOM3uplYJG2mo5Axj3ghrfXFVzmrSECisFc0V8XHI8P
         8A0yYbXSvf2BlqlNGFOlUpAgBE4y2fHIutfFeGvGrGO5ci77BaPz4I02HYoX16lsD7Hu
         vQ252K3Z8fQxQo5RuTEEicOvKAEVeibuW+aapEr/WD1Zd0alekaNlLI7w+khctBN8Gz7
         rh+Aq3Z5qvo++aP7grmd7A39bbi+mlB9mXMLZfTFMXxp2Zaw6t+x0hS6sgex+ZZglf9z
         Htiee8Ms4aVSzUMUb2benDoKrt+Wdr6jaI2qb84/aFkZu6zuSEfCTsDoXKTvwvQ052HQ
         8xGA==
X-Gm-Message-State: AOUpUlHVWvGlCZE/W8DkAJwT9QdbmOo5rUCpIE+1nMrMJ1KfN6hG4GHB
        DN+mN5HMJievwmmglx6ONPMpJQ==
X-Google-Smtp-Source: AA+uWPw0cgfnC+wrtIrlEoY4eg4/u0E6xpN1VhC83QsjlCcFW1VRgEBGLsJRbkb9yIHvfyu2aYymTw==
X-Received: by 2002:a63:1262:: with SMTP id 34-v6mr357842pgs.154.1533684932139;
        Tue, 07 Aug 2018 16:35:32 -0700 (PDT)
Received: from localhost (c-107-3-165-230.hsd1.ca.comcast.net. [107.3.165.230])
        by smtp.gmail.com with ESMTPSA id a81-v6sm4906609pfa.152.2018.08.07.16.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 16:35:31 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     davem@davemloft.net
Cc:     keescook@chromium.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williams@ni.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] net: nixge: Get rid of unused struct member 'last_link'
Date:   Tue,  7 Aug 2018 16:35:20 -0700
Message-Id: <20180807233520.31127-1-mdf@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of unused struct member 'last_link'

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/net/ethernet/ni/nixge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 5b56a2f2ff8a..5e34905bd8d8 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -183,7 +183,6 @@ struct nixge_priv {
 
 	int tx_irq;
 	int rx_irq;
-	u32 last_link;
 
 	/* Buffer descriptors */
 	struct nixge_hw_dma_bd *tx_bd_v;
-- 
2.18.0

