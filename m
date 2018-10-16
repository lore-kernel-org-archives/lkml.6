Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA79FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B3E208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b77Z+u4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B3E208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeJPNwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 09:52:19 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38880 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeJPNwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 09:52:19 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9G63Eug079168;
        Tue, 16 Oct 2018 01:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539669794;
        bh=weq2nqCBJa7kjy85CfuhVV5+Br9OUTAT1fq3bxEw78Q=;
        h=From:To:CC:Subject:Date;
        b=b77Z+u4J7H5jicf4JoIg0WW64/aa0BK5kVLsLjw1nuS95v7xEV74hHSKcQmWnmRaP
         dj53hxsSKmDHAM54bAjKs/Og8jHXMWYEl+76fDmlts6Zh7Xc5CqELvBmHpg5URsZO1
         OZhcwcINmnRBC2jyxVD2FNuvFd6e3Zmvja/+NIRo=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9G63EQU031099;
        Tue, 16 Oct 2018 01:03:14 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 16
 Oct 2018 01:03:13 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 16 Oct 2018 01:03:14 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9G63Boj027391;
        Tue, 16 Oct 2018 01:03:11 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v2 0/2] pwm-tiecap: Add support for AM654 SoCs
Date:   Tue, 16 Oct 2018 11:34:00 +0530
Message-ID: <20181016060402.18756-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Couple of patches to enable pwm-tiecap driver to be used with TI's new
AM654 platforms.

Vignesh R (2):
  dt-bindings: pwm: tiecap: Add TI AM654 SoC specific compatible
  pwm: Kconfig: Enable TI ECAP driver for ARCH_K3

 Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
 drivers/pwm/Kconfig                                  | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.19.1

