Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC695C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7565B2086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7565B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388957AbeKGODJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 09:03:09 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59388 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbeKGODJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 09:03:09 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA74YS5R130861;
        Tue, 6 Nov 2018 22:34:28 -0600
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA74YSo9117462
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Nov 2018 22:34:28 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 6 Nov
 2018 22:34:27 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 6 Nov 2018 22:34:27 -0600
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA74YOvk020896;
        Tue, 6 Nov 2018 22:34:25 -0600
From:   Keerthy <j-keerthy@ti.com>
To:     <vireshk@kernel.org>, <nm@ti.com>, <sboyd@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <d-gerlach@ti.com>, <t-kristo@ti.com>, <j-keerthy@ti.com>
Subject: [PATCH 0/2] opp: ti-opp-supply: Fixes
Date:   Wed, 7 Nov 2018 10:04:21 +0530
Message-ID: <1541565263-8296-1-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series brings in couple of fixes to the ti-opp-supply driver.
One of them updates u_volt_min dynamically and avoids hang due
to lesser static u_volt_min and the other fixes the supply in
_get_optimal_vdd_voltage.

Keerthy (2):
  power: opp: ti-opp-supply: Dynamically update u_volt_min
  power: opp: ti-opp-supply: Correct the supply in
    _get_optimal_vdd_voltage call

 drivers/opp/ti-opp-supply.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
1.9.1

