Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B228FECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C2A20877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dominion-thruhere-net.20150623.gappssmtp.com header.i=@dominion-thruhere-net.20150623.gappssmtp.com header.b="UVECDnAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C2A20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominion.thruhere.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbeGQINO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:13:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43514 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbeGQINN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:13:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id b20-v6so371780edt.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 00:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=CkXzUIntqWgB6DdWCIPR+BzNgd7spEli8/WPBRHS1u4=;
        b=UVECDnAYhTV6ppL9FSkcoRvuAlkdNSI/g0tjZqMvmY00NLc5tELUoEoKydlqQBnW1h
         EbINFe9KWfEzsWlArUEunXl5g8c1szYTDvwngEREcjviQKdjjEUssTelcqVbnMXtDROM
         JXjwS1IURffSHPhfk6CBfMjLonB0r8T1gX06VOLguLYh95Zr1HZ5c0e8783Zg7K0Biz9
         +iSf/0VytWYAlHAOt/jKwEPddG0032PuPn2dbbu5YiByVTvWGNETmRA79Ie6gfsjsOy/
         5PT5NSs5Ap4slpj1Yk1l9JFE/uSj6HnhkKCkYvBdXHMoUBKGLDBLQW3aTNlSYvWbIjSW
         bhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CkXzUIntqWgB6DdWCIPR+BzNgd7spEli8/WPBRHS1u4=;
        b=qUeNh4WXHdFT2/qmaHYTKjFehs+m3dWw95aFlIEcW7oQVEHztK6UTW+jT+lRL0T35A
         pbpNuz+0sjlJXn9/sBkpde30/VJYoSb5HrEkn+Sn5ptvy0JuuvWMlvgQq7VTATabSgHU
         DIB0lxpvKnPxjs8sXfKJqK5W/x1LrLx0jjT3dabmfQgvGqlyF1QCwXYAWSfRLy4JVZrh
         Tj8SCpGL8a8F4cdhPrf6nD0hAjW0FDownKhO3PXFmIp+KgJ084WBoWKw8FedRtBFSUAC
         da8Ak1GflXS2K6vz6yIa5loEeg4+ZI9DaqRmYfYDPlWGzvv2gMPjG/uq+VFeGeP4tlfj
         u/rw==
X-Gm-Message-State: AOUpUlE01bbF7JKH915ySl4Xu9jmXa+WsW1g0A2jzE2TdCxDl0BFzg3W
        plZcWOsLZyAFYqqM9t9L247aEqGZ
X-Google-Smtp-Source: AAOMgpcfrpv0WF6Tvh0neuqxd3IDWEd0jip/MJ1kqEuqU6wtq1ynfMCO8H+1+gpQb2tzJS51oV5NDg==
X-Received: by 2002:a50:aa83:: with SMTP id q3-v6mr1202268edc.64.1531813316617;
        Tue, 17 Jul 2018 00:41:56 -0700 (PDT)
Received: from localhost ([82.163.40.65])
        by smtp.gmail.com with ESMTPSA id a2-v6sm223711ede.21.2018.07.17.00.41.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 00:41:55 -0700 (PDT)
From:   Koen Kooi <koen@dominion.thruhere.net>
To:     linux-omap@vger.kernel.org
Cc:     tony@atomide.com, Koen Kooi <koen@dominion.thruhere.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        David Lechner <david@lechnology.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        SZ Lin <sz.lin@moxa.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: Add vendor prefix for Sancloud
Date:   Tue, 17 Jul 2018 09:40:58 +0200
Message-Id: <1531813262-2063-2-git-send-email-koen@dominion.thruhere.net>
X-Mailer: git-send-email 2.0.1
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

