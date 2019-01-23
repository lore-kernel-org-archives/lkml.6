Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D66C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55B1218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="P8ci7Vzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfAWTa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:30:58 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3729 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfAWTa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 14:30:58 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c48c0d90000>; Wed, 23 Jan 2019 11:30:33 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 23 Jan 2019 11:30:57 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 23 Jan 2019 11:30:57 -0800
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 23 Jan
 2019 19:30:57 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 23 Jan 2019 19:30:57 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c48c0f00009>; Wed, 23 Jan 2019 11:30:56 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mperttunen@nvidia.com>, <chunyan.zhang@unisoc.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <anrao@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V11 1/4] dt-bindings: mmc: Add supports-cqe property
Date:   Wed, 23 Jan 2019 11:30:51 -0800
Message-ID: <1548271854-1765-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548271833; bh=XeLhe1vLauuUj/UJdfZxRYISTqWQAoxuCMHmYasSZlw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=P8ci7VzjPa88qnNa9ni1QB9qblIn93GeIYNZ5RcLswQv1wW1ti54c60TYdKPFXY4k
         9dgLC04uG05t8JMRhe8lgVbbNA5WrXHmk/PnqsV1JOgEgxh+bWRZjVOsYR3vQCh+Z1
         S1cRQOb3Cp0vjvbiPou9vvqfkGY0wuckWx/HC4GLj1zq/Rvsqbc66RdCxw5a/jUzAS
         cb43/3A4hdyNo8D0u6DDv3J98xtQ2Dm84W77izGiTkD1wCWU1WNLQ07ABY2m9Vy99r
         kb2w/N0Fl0YMP63ptCFHtdPRHBLhJNf64s1FOO1jELyGyBa7DCFU1Pwjr73nGQ/O1x
         WpZkFI1zwSB9A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add supports-cqe optional property for MMC hosts.

This property is used to identify the specific host controller
supporting command queue.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
---
 [V11]: Same as V10
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

