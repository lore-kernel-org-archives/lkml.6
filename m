Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2AEC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD24C20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lzDNy737"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfAVT4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:56:37 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14336 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfAVT4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:56:36 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4775510000>; Tue, 22 Jan 2019 11:56:01 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 22 Jan 2019 11:56:35 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 22 Jan 2019 11:56:35 -0800
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 22 Jan
 2019 19:56:35 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Jan 2019 19:56:35 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c4775730000>; Tue, 22 Jan 2019 11:56:35 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mperttunen@nvidia.com>, <chunyan.zhang@unisoc.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <anrao@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V10 1/4] dt-bindings: mmc: Add supports-cqe property
Date:   Tue, 22 Jan 2019 11:56:30 -0800
Message-ID: <1548186993-6229-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548186961; bh=ySVFnMc0Btin29IEea+T3cQLiX+hR5w0znLYdyxd9pw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=lzDNy737gQWN5mzLZ54cYKOQPClxTL4hYcEjEEIjoAr99bIpLcwY8SCleE8epWYTL
         z4d9Wy1sesC/5p/kfybSkeaPk5C/RKNtEAMrSo8IdU8m5J92ljnoSWBDF7JNJnb7S/
         iMiSee9x9b3j92/QTcuFJMBL2cf+GUelY6ftRawxdd/oAJi+rYN532P2zaZLRumU8g
         Ov9Zse6AzhtLjnoJ1Myb4jaX83xPHQIKO4TDbzpJymgvQicEQ772UxKuky77k1CQgn
         kTKD7XCoXxywdjBzPe127+KVRPI5AHjGOJF7gTwptp0b9Pb0JqM6NK0ZxHy2DUyXsu
         bdZEm26LZbbCw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add supports-cqe optional property for MMC hosts.

This property is used to identify the specific host controller
supporting command queue.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V10]: This patch version moves supports-cqe property from vendor
	specific MMC property to common MMC property.

 Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index f5a0923b34ca..cdbcfd3a4ff2 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -62,6 +62,8 @@ Optional properties:
   be referred to mmc-pwrseq-simple.txt. But now it's reused as a tunable delay
   waiting for I/O signalling and card power supply to be stable, regardless of
   whether pwrseq-simple is used. Default to 10ms if no available.
+- supports-cqe : The presence of this property indicates that the corresponding
+  MMC host controller supports HW command queue feature.
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
-- 
2.7.4

