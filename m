Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1E9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC3F223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="N7kggzy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC3F223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbeKMUDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:03:44 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8790 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731448AbeKMUDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:03:44 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5beaa2170000>; Tue, 13 Nov 2018 02:06:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 13 Nov 2018 02:06:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 13 Nov 2018 02:06:22 -0800
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 13 Nov
 2018 10:06:21 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 13 Nov
 2018 10:06:21 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 13 Nov 2018 10:06:21 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5beaa21b0002>; Tue, 13 Nov 2018 02:06:20 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <linux-kernel@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 0/3] Fixes for Tegra soctherm
Date:   Tue, 13 Nov 2018 18:06:04 +0800
Message-ID: <1542103567-5521-1-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542103575; bh=zgVdWNkiMjE8Tyf75mGchC2ShPzMs7jvOR992jxZdlY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=N7kggzy7rJeUiirZ84Wl0aFjPLa782VjUEoy9+WcBl3+ioI20ihASltsJnS1O+qSx
         htmSPiSZ+ROTk/H21/T9crXlZ8NL551ayw3zEJSnXzpTApjz2sCEaWTn+FgCy9+ryO
         eg2U7sNnpPQ7hg9sppBAo8cn9TZl5arQDGhs7+caUR00TXVU1LXY0p8o7X1ByqL8+P
         KTqHL10bNgYKYzIbSOzKFjIEZ4YKC/upwLFZlGyO3EA2PJDSBkzQl4UIUvS6V//eYg
         iyRLq6T98g8mlWmT7NgSz0GAO5beOzM0T8Zaxn+WbZHUCIBA9ZySbGzKrIDjOpFo3Z
         weGKxZcsqXYrA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixed some issues for Tegra soctherm

Main changes from v1:
1. Acked by Thierry Reding <treding@nvidia.com> for the patch
"thermal: tegra: fix memory allocation".
2. Print out the sensor name when register failed.
2. Remove patch "thermal: tegra: fix coverity defect"

Wei Ni (3):
  thermal: tegra: continue if sensor register fails
  thermal: tegra: remove unnecessary warnings
  thermal: tegra: fix memory allocation

 drivers/thermal/tegra/soctherm.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

-- 
2.7.4

