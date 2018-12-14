Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7930CC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390BB2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="V/SkCdL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390BB2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbeLNJt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:49:59 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16056 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeLNJt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:49:59 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c137cc20001>; Fri, 14 Dec 2018 01:49:54 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 14 Dec 2018 01:49:58 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 14 Dec 2018 01:49:58 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 14 Dec
 2018 09:49:58 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 09:49:58 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c137cc30001>; Fri, 14 Dec 2018 01:49:57 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <rui.zhang@intel.com>, <edubezval@gmail.com>
CC:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v6 0/4] Fixes for Tegra soctherm
Date:   Fri, 14 Dec 2018 17:49:49 +0800
Message-ID: <1544780993-20744-1-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544780994; bh=i6bdi1JXbBC3f4G92KlsmgBRp2ms65aAKP0C5re2YFI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=V/SkCdL44rKoYFsmTINCY0ihQRaqmd56q2GV9RtuFzHIbH/oSNOuEWjMI4uGv6Mqx
         WmJN28VDGy2554zrtdgIg4xp9ncGQgLdIhxBjQFPAUHZzEpdLYukH6QDftGgIbfC3r
         V5QMR0HIohISl6oxxxrFNDXPlIkw7G/vjBgrjYnId9ko6yhzgjRYL4zPo0xb7U9b4j
         0Q3dB3JNcNpmn0ev1cL6aSXrsn3Xj7lit9w90vJHLi9M/R5GrzD9KV/DJrBjPdHqqM
         MId+hzv6TFSxP7N7AAyiwfrDDnrTC+fFDe+ee+PeTB23FO6AXPZLWsQ41c6cU+tVIQ
         m9/N3HJWMN03g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixed some issues for Tegra soctherm,
and add get_trend().

Main changes from v5:
1. Move the get_trend() patch https://lkml.org/lkml/2018/11/20/643
into this serial.

Main changes from v4:
1. fixed for the parsing sensor id.
2. keep warning for missing critical trips.

Main changes from v3:
1. updated codes for parsing sensor id, per Thierry's comments

Main changes from v2:
1. add codes to parse sensor id to avoid registration
failure.

Main changes from v1:
1. Acked by Thierry Reding <treding@nvidia.com> for the patch
"thermal: tegra: fix memory allocation".
2. Print out the sensor name when register failed.
2. Remove patch "thermal: tegra: fix coverity defect"

Wei Ni (4):
  thermal: tegra: remove unnecessary warnings
  thermal: tegra: fix memory allocation
  thermal: tegra: parse sensor id before sensor register
  thermal: tegra: add get_trend ops

 drivers/thermal/tegra/soctherm.c | 85 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 80 insertions(+), 5 deletions(-)

-- 
2.7.4

