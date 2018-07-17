Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD46ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82F7208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dominion-thruhere-net.20150623.gappssmtp.com header.i=@dominion-thruhere-net.20150623.gappssmtp.com header.b="Bq0wkQ8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82F7208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominion.thruhere.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbeGQG4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 02:56:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33185 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbeGQG4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 02:56:04 -0400
Received: by mail-ed1-f65.google.com with SMTP id x5-v6so224747edr.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 23:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rk2XZJ46uJUA5KPKeRj0yx73Grh3Myhstzio+EjSxGM=;
        b=Bq0wkQ8cdVn+QX6grMgLDy4CNuM6LqkESJ6YZIkz2WSreRVgKbRGk5z8V5PC6IU/qz
         I/yjOv6r2KsARXS8EE3IkVCzkWyYJ0b3UFU9Hk9Elu8IngIspvhQI7k9YDDViSmm01Iy
         634ip/gnR/gQlsULIurSDRuCuvk7q8yLbDx8SNmN/aESHBlIcHPAcQERJL1z1Eby38Kk
         iyO+GT5ASIWgTaqslDhfoKiusoX2wFoZkD6dZw1UsIZdoYrOKRqKhe4Fr7JvQde3IHeQ
         lMz/cUV3glHtbZO/bKA3jRjS8LWI6tCcVm3ODaTYae5apOciC1KPtxJDh8dswI8jmBDX
         LsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rk2XZJ46uJUA5KPKeRj0yx73Grh3Myhstzio+EjSxGM=;
        b=anhwAPoMJs0UOuXyWWFBdBoRfbH15DUOZ8EgdwD8qFLn51Xb8Ix5zEmDr2pT7UF9zt
         el9kyqXLlllPk77ARA/gJrvgMuziRPTqdkrvCP9T0RpRx+rbJrZZMQncxu+B2FWGZSx9
         UyE4LRgZM3XCWCeTTeN1CkZOw/2dlvKoQA/0x649YNSIsw/cqv858XuTAd0dKoJ9Q+8U
         YC+WRwB4YnKQFMr0mRxL3Yr2T4DNWS53GC3C9wvtVu3jIx9kS52hgodQkifulwmFuI8/
         4TVmJAnK+t6SyCHim/D71PIKkmOnXdu3VSqIz3YFkOr/NYUl2CTBxi2PBE/QGYYUSM5S
         bWXQ==
X-Gm-Message-State: AOUpUlGkhVKHYax6hFFUVV4EJRdenq5THBUqV9mjd/9ukOQcCas62yvR
        FmWI/uDTUtfZtBEVNCb6BO3Kig==
X-Google-Smtp-Source: AAOMgpf/IW8fBGe1qX+uWqmpP4U+AuURu/KtKQxdm0UhJoaSOfgpFq+6FIpmbP2ZLIYRavzL4p4LJQ==
X-Received: by 2002:a50:c251:: with SMTP id t17-v6mr897245edf.108.1531808705359;
        Mon, 16 Jul 2018 23:25:05 -0700 (PDT)
Received: from localhost ([82.163.40.65])
        by smtp.gmail.com with ESMTPSA id o12-v6sm171113edj.54.2018.07.16.23.25.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 16 Jul 2018 23:25:04 -0700 (PDT)
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
Subject: [PATCH v5 1/2] dt-bindings: Add vendor prefix for Sancloud
Date:   Tue, 17 Jul 2018 08:24:45 +0200
Message-Id: <1531808688-9716-2-git-send-email-koen@dominion.thruhere.net>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1531808688-9716-1-git-send-email-koen@dominion.thruhere.net>
References: <1531808688-9716-1-git-send-email-koen@dominion.thruhere.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Sancloud Ltd.

Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
Acked-by: Rob Herring <robh@kernel.org>
---

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

