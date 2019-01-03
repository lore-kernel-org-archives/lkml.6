Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583F2C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269B020815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Te4DshEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbfACKNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:13:15 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3186 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfACKNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:13:14 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c2de02c0000>; Thu, 03 Jan 2019 02:13:00 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 03 Jan 2019 02:13:14 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 03 Jan 2019 02:13:14 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 3 Jan
 2019 10:13:13 +0000
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 3 Jan
 2019 10:13:13 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 3 Jan 2019 10:13:13 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c2de0370001>; Thu, 03 Jan 2019 02:13:13 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <edubezval@gmail.com>
CC:     <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Wei Ni <wni@nvidia.com>
Subject: [PATCH v7 0/3] Fixes for Tegra soctherm
Date:   Thu, 3 Jan 2019 18:12:46 +0800
Message-ID: <1546510369-28491-1-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546510380; bh=thSPNh5qclnMONRqSWDQUSlfaobtykRz5XwkoJgugjA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=Te4DshEbUB7X4PzEB+5WmOa3cbSYn7yKVl4pfvQhWeNR3JkzR00fdSqLMkY8+SvZY
         TYqX7I94Y7bAZZJtnN0BgS9dsFZhgnX3kVWB1YKcsoLUE4oNdDIkfYv0yGVcEzxZTu
         P8arhOIYCiiNRjotxW2RNVzA6BGmfF86pN3puEkXO5sAOOU0cuMMiwRH7ErP0D6f4x
         yEMZ3ujaKyzPDizOEhNIV1H8kwOhPVxsD7cJTU/NfGsnf9Il5EA4QVa6ypeaqisFQS
         YRKtWtdXHWYAqNuRQ2JQ2CXR7AbPgWqlHZ6KVtHoM5U4yuOT1Kfmuq+IdBniowJ1dx
         7wK8r/xv41WLw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixed some issues for Tegra soctherm,
and add get_trend().

Main changes from v6:
1. Per Eduardo's comment, we can remove the change:
"thermal: tegra: parse sensor id before sensor register"

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

Wei Ni (3):
  thermal: tegra: remove unnecessary warnings
  thermal: tegra: fix memory allocation
  thermal: tegra: add get_trend ops

 drivers/thermal/tegra/soctherm.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

-- 
2.7.4

