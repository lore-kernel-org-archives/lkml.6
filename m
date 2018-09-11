Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACBDC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571B020881
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=az8.co header.i=afonsobordado@az8.co header.b="c8EaO4I4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571B020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=az8.co
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeIKUAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:00:47 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21434 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbeIKUAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:00:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1536678038; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=IGjP4dL7D8n70LU3pV51rN6+PB2533GFTzH1GUiFZQegieb/gmiDc2cdJ8h7FSymA/AhIahs7iZfhJDwnEq6jBziTffrOEWFbAECZ0mX4BVNN8kqghXbXtMcpTTYJzqYbRdAp2BCzX/gUJPt9GcllL3E7anchpiKOXb7w6Q9TvY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1536678038; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=dPPZBBSx8zOsrGge9Xb59PHumf0eZhSyqPc/0Jm6Raw=; 
        b=O73wEwndKXYavTvFRdErf2YBdJjE46gwbLAxAA6KuH59OGs9aC2W6mp58bUBb9XjZttq5ru4o1SHA0MLU/FumrHb/hkVlgTwJ8oXLbt5JVktAxn28u8eMXdCViL/xQoMim8Qu4GbEFEVTPNQl3STwQbyhqMgrRMz/usGg1HljN4=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=az8.co;
        spf=pass  smtp.mailfrom=afonsobordado@az8.co;
        dmarc=pass header.from=<afonsobordado@az8.co> header.from=<afonsobordado@az8.co>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1536678038;
        s=dkimmail; d=az8.co; i=afonsobordado@az8.co;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=803;
        bh=dPPZBBSx8zOsrGge9Xb59PHumf0eZhSyqPc/0Jm6Raw=;
        b=c8EaO4I42oSy/lrmSKFTojcuV8xkqENi5oUluxWEvwuAiFJZ9n9C13aGV9WotM5l
        EmhvzdJI60Da/nzsTzgBYDmLbyd0790j/umkLQaCsDJ+nyxN+GAehofkg4qJQmMh38v
        zQ1GqHhU0Di4VEn3YZAMCc99MytDB1Ob3brWYmQ0=
Received: from localhost (bl9-77-228.dsl.telepac.pt [85.242.77.228]) by mx.zohomail.com
        with SMTPS id 1536678037099683.3705023699581; Tue, 11 Sep 2018 08:00:37 -0700 (PDT)
From:   Afonso Bordado <afonsobordado@az8.co>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 5/5] MAINTAINERS: add entry for fxas21002c gyro driver
Date:   Tue, 11 Sep 2018 16:00:11 +0100
Message-Id: <20180911150011.31964-5-afonsobordado@az8.co>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180911150011.31964-1-afonsobordado@az8.co>
References: <20180911150011.31964-1-afonsobordado@az8.co>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for fxas21002c gyroscope driver and add myself as
maintainer of this driver.

Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b9a364b043d..9420f0a8140d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5718,6 +5718,13 @@ S:	Maintained
 F:	drivers/net/ethernet/freescale/gianfar*
 F:	Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
 
+FREESCALE FXAS21002C
+M:	Afonso Bordado <afonsobordado@az8.co>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/gyro/fxas21002.c
+F:	Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
+
 FREESCALE GPMI NAND DRIVER
 M:	Han Xu <han.xu@nxp.com>
 L:	linux-mtd@lists.infradead.org
-- 
2.18.0


