Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE46C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159372084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159372084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbeLKOUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:20:12 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37542 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeLKOUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:20:11 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBBEK9Lr028077;
        Tue, 11 Dec 2018 08:20:09 -0600
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBBEK9F1088529
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Dec 2018 08:20:09 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 11
 Dec 2018 08:20:09 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 11 Dec 2018 08:20:09 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBBEK6ed024675;
        Tue, 11 Dec 2018 08:20:07 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <kishon@ti.com>, <faiz_abbas@ti.com>, <j-keerthy@ti.com>
Subject: [PATCH v2 0/2] Workaround errata i929
Date:   Tue, 11 Dec 2018 19:52:51 +0530
Message-ID: <20181211142253.23747-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches workaround errata i929 by implementing
a new tuning algorithm.

Changes in v2:
 1. Added patch to document the name of the thermal_zone "cpu_thermal"
 2. Rebased to latest linux-next

Faiz Abbas (2):
  dt-bindings: sdhci-omap: Add note for cpu_thermal
  mmc: sdhci-omap: Workaround errata regarding SDR104/HS200 tuning
    failures (i929)

 .../devicetree/bindings/mmc/sdhci-omap.txt    |  2 +
 drivers/mmc/host/Kconfig                      |  2 +
 drivers/mmc/host/sdhci-omap.c                 | 90 ++++++++++++++++++-
 3 files changed, 93 insertions(+), 1 deletion(-)

-- 
2.19.2

