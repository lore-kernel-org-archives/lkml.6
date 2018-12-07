Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2B9C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9662A20892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yIreeFiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9662A20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbeLGJfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:35:08 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50096 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeLGJfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:35:08 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB79Yfj2094915;
        Fri, 7 Dec 2018 03:34:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544175281;
        bh=UR9SKAvC0F91KARB/Z+1hpGbJb5qjzF/MvR0or80YHk=;
        h=From:To:CC:Subject:Date;
        b=yIreeFiBrxDvRxXiLrzlNANGhrdCRp5GgVt5yy4w27f+lsuLhogWyksHsYngFkpTa
         g5z6hLhvcPxNeZ3hVIo2TcCsoDKZ+cLDAWFG9DzZAT/uUR5wAFZsfImzOl2gABkAjP
         lqXttdH4Fh3Feo2FTDO1FVZrUt3cq7Q0Io89t3lY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB79Yfck032459
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Dec 2018 03:34:41 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 7
 Dec 2018 03:34:41 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 7 Dec 2018 03:34:41 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB79Ycw6011818;
        Fri, 7 Dec 2018 03:34:39 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/2] AM654: Add ECAP PWM support
Date:   Fri, 7 Dec 2018 15:05:33 +0530
Message-ID: <20181207093535.5497-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Couple of patches to add ECAP PWM support for AM654 SoC. Based on top of
git://git.kernel.org/pub/scm/linux/kernel/git/kristo/linux.git 4.20-rc1-am65x-queue

Vignesh R (2):
  arm64: dts: ti: k3-am65-main: Add ECAP PWM node
  arm64: dts: ti: k3-am654-base-board: Enable ECAP PWM

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi       |  9 +++++++++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 11 +++++++++++
 2 files changed, 20 insertions(+)

-- 
2.19.2

