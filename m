Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D16C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA2F2172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA2F2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbeI1RK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 13:10:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41178 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbeI1RK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 13:10:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id m77-v6so4059946pfi.8;
        Fri, 28 Sep 2018 03:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oUw8B05mI9kDkMK4kaePtNYQtB6yTOSz0Cad6B5Y5aw=;
        b=f5Gk7xSHy2e5hd3wOBMIglpQ84tWBVI73KgschkiG/dkct6a1wVYDQiYV+JnypG5JR
         IT2mIEN3dcJikjbblF72RkSCFqQ/aDTrK84A/hhN+YNxdZLQ982R3c6eGatBA+66Rjox
         P4SSCFa1r90gxvoEAEjxhIEw6MxC4i5NAqLN/v9RZmPuGoSJ1HyCJGkiEEPBM7nQgJap
         6snwL7YYsQ9hzxZwhVCBdiG5gk7VO99yANNX3IQMeOIXhstGNTe+J+qnyfSRw8Bn/2mc
         O5gugVVCotsF1dE+6hVaANk61XLk/wPV+qTwBngviNeVB8HuinRLC6HlkwqNnkbQRtNn
         frTg==
X-Gm-Message-State: ABuFfojIiJJXuNUPeQpIx9jqg8vaSwNKaOiUI27/TGt5UzieKRvxiAL+
        qB1MbNk6rZ1d3/LusjDBTpc=
X-Google-Smtp-Source: ACcGV61xg8OnwLbCdq/1VwC4bNnC7e0hd7T7L7qwpTLy4j4WHDlJilnKC7av3BhPXrOJR1F67r92EA==
X-Received: by 2002:a17:902:bc8c:: with SMTP id bb12-v6mr818215plb.275.1538131667097;
        Fri, 28 Sep 2018 03:47:47 -0700 (PDT)
Received: from szlin-TW ([122.146.92.136])
        by smtp.gmail.com with ESMTPSA id w24-v6sm6711226pfn.90.2018.09.28.03.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 03:47:46 -0700 (PDT)
Received: from root by szlin-TW with local (Exim 4.91)
        (envelope-from <root@localhost>)
        id 1g5qJF-00081l-LF; Fri, 28 Sep 2018 18:47:45 +0800
From:   =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?= 
        <sz.lin@moxa.com>
Cc:     =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?= 
        <sz.lin@moxa.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: arm: omap: Add binding for Moxa UC-2101 open platform
Date:   Fri, 28 Sep 2018 18:47:38 +0800
Message-Id: <20180928104739.30727-1-sz.lin@moxa.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Moxa UC-2101 open platform

Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
---
 Documentation/devicetree/bindings/arm/omap/omap.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 2ecc712bf707..c5ca3d6a8099 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -157,6 +157,9 @@ Boards:
 - AM335X phyCORE-AM335x: Development kit
   compatible = "phytec,am335x-pcm-953", "phytec,am335x-phycore-som", "ti,am33xx"
 
+- AM335X UC-2100: Wireless-enabled palm-sized industrial computing platform
+  compatible = "moxa,uc-2101", "ti,am33xx"
+
 - AM335X UC-8100-ME-T: Communication-centric industrial computing platform
   compatible = "moxa,uc-8100-me-t", "ti,am33xx";
 
-- 
2.19.0

