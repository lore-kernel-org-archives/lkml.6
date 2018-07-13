Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648D7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204BE20843
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dominion-thruhere-net.20150623.gappssmtp.com header.i=@dominion-thruhere-net.20150623.gappssmtp.com header.b="Hm/ttAu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204BE20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominion.thruhere.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbeGMGfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 02:35:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45922 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeGMGfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 02:35:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id i20-v6so10690729eds.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 23:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xRwZteiui4ibJcEzwlRzOZLCu4DZY+VfqOoD+wkvc7o=;
        b=Hm/ttAu8LDwNtgjpXQ6EbgNPko7naEmuMgh9vPdftH/CHkBxM9yjju+4PQ0No0Vt63
         ozuVqA5zuTrrtq8KUwZuXr/C7MlobVsTWZcFRBHUGhiUmJcZTXsnyW7FC+xSTNgd/RRF
         1xdujyuw3g2t55F2o0JwijTmU9vWasfJkRCfNZM/15UV3qXYKoBfT2D3tBoWXiEGsTN+
         W3DST7kX5HY92eYeJqiC1wF6dDq/J03sI8icoQfIlKDDrd9jHO3zHZylyS5hOu262wSa
         5BQgdhbVfaLx9mt7g5revp10lG7e391882v19RgGcHg8kdKtfXvDInbvWQXDhg18E2BP
         npqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xRwZteiui4ibJcEzwlRzOZLCu4DZY+VfqOoD+wkvc7o=;
        b=hAHxR7CxuuSnlg0x1RFdl8cwy5fTcgRRwmwKdPAhnScn0hf6JSSXZ5yXI7vuo3TBea
         bUfyHXp+gAuXgVwKP5PRnEATFMEHjQfzjdrQGJDvBy1EN3s4T37uFYKjsZzjnPWr2mq5
         N6GqdorwmQ0TgSHFlqDE498v17SnSHR5tKiv2ofGYGish4ve64pdnIHZLlWnYbF9mbeS
         94VEpxV+8+7/dm3q2kypqM1ff6H16Qq+iehLV0NU0NTLYYkSpFBDsb8F0DvqkNdxodvl
         sSxvR6VR/83SVYoyafCEYGXiOqij/WjOifC8a1rjZZbyJaUXhEq4IFnu9iWZK7hoLoaV
         yxfQ==
X-Gm-Message-State: AOUpUlEpQIxINWlNbdf03eIEmItF7D16Y+J6ZOY255avjwgH8yyheWcX
        knCPooGyKpXyxU0zhQx9tMkP2Q==
X-Google-Smtp-Source: AAOMgpfLJDacoyV9r7/SZp7jnmTvaJsFNKimc3JOJKtOPSUaEBjPMEhj9O7JOuz65l1cTd7FsSYtag==
X-Received: by 2002:a50:9069:: with SMTP id z38-v6mr5648059edz.79.1531462951802;
        Thu, 12 Jul 2018 23:22:31 -0700 (PDT)
Received: from localhost ([82.163.40.65])
        by smtp.gmail.com with ESMTPSA id m6-v6sm11046599ede.61.2018.07.12.23.22.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 23:22:31 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: Add vendor prefix for Sancloud
Date:   Fri, 13 Jul 2018 08:22:20 +0200
Message-Id: <1531462943-26226-2-git-send-email-koen@dominion.thruhere.net>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1531462943-26226-1-git-send-email-koen@dominion.thruhere.net>
References: <1531462943-26226-1-git-send-email-koen@dominion.thruhere.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Sancloud Ltd.

Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
---

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

