Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D22C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B86B20869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YasFKiHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B86B20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeKESvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:51:54 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4929 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeKESvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:51:54 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5be00e590000>; Mon, 05 Nov 2018 01:33:13 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 05 Nov 2018 01:32:57 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 05 Nov 2018 01:32:57 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 5 Nov
 2018 09:33:04 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Mon, 5 Nov 2018 09:33:04 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5be00e4f0000>; Mon, 05 Nov 2018 01:33:04 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <linux-kernel@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v1 0/4] Fixes for Tegra soctherm
Date:   Mon, 5 Nov 2018 17:32:30 +0800
Message-ID: <1541410354-19090-1-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1541410393; bh=3EGQJYyAvqmlEA2/sj1FMDXmNVHhTJoW2ie8XEChk1w=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=YasFKiHtbzyKY73KevcIonDUE2cNXuKbipR0eqLKUlYro8+x8NGD+eg6GTPjrbUad
         osAnPbAfz6IbXjwiKMnNWG8ieqLD9u5sKEco3nnJYDJbDN0c2aIKBmOQq3uY2AK4oQ
         3UxNEhrPUpYiFOBjII9/q0cdDtkg3D/6pe3KnufMF1/mol1NK9I5rAOxZcp1/1Jpg/
         mu8IKe02Xe6skQetA0LPX8W1n6I+MxL+sXVzdIMWisrFtnE6diElYujwxVFCF5NT6T
         xGJRE7t/98148GYsQOh1iOleUTfbnMKk2OQ6fWZPtAWfARSa3xCOMfeX/ExPOaynDU
         FWrn2yik/h9hw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixed some issues for Tegra soctherm

Wei Ni (4):
  thermal: tegra: continue if sensor register fails
  thermal: tegra: remove unnecessary warnings
  thermal: tegra: fix memory allocation
  thermal: tegra: fix coverity defect

 drivers/thermal/tegra/soctherm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

-- 
2.7.4

