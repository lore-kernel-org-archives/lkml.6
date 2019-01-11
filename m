Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F9DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F62B20652
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nga3n1EL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389761AbfAKSGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:06:11 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44208 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733270AbfAKSFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:05:40 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BI5YPD067756;
        Fri, 11 Jan 2019 12:05:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547229934;
        bh=Yq4cXQfamzKl0NmCfFm3bOQyw/1goxd1B0CYdDiR2qU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Nga3n1ELy72fOPwpXJu3coMo5VzPCkfqcicBZG5TMX5//LjdjrJNuLJwtaQsHLXgH
         f5PkI33CoPrxFzNFjNuT4QGsGlcwEQmurvCFnZrO7PPVeZ97iZEBKMbwQhz7dk6aNV
         xLB7GStCF+npiAqHXylAQr0zhXHqV2le9Kzxd+dY=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BI5Y3K059316
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 12:05:34 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 12:05:34 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 12:05:34 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BI5YBU025847;
        Fri, 11 Jan 2019 12:05:34 -0600
Received: from localhost (uda0226330.dhcp.ti.com [172.22.109.196])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x0BI5XU07756;
        Fri, 11 Jan 2019 12:05:33 -0600 (CST)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
CC:     <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 11/14] staging: android: ion: Allow heap name to be null
Date:   Fri, 11 Jan 2019 12:05:20 -0600
Message-ID: <20190111180523.27862-12-afd@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111180523.27862-1-afd@ti.com>
References: <20190111180523.27862-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The heap name can be used for debugging but otherwise does not seem
to be required and no other part of the code will fail if left NULL
except here. We can make it required and check for it at some point,
for now lets just prevent this from causing a NULL pointer exception.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/staging/android/ion/ion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index bba5f682bc25..14e48f6eb734 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -467,7 +467,7 @@ static int ion_query_heaps(struct ion_heap_query *query)
 	max_cnt = query->cnt;
 
 	plist_for_each_entry(heap, &dev->heaps, node) {
-		strncpy(hdata.name, heap->name, MAX_HEAP_NAME);
+		strncpy(hdata.name, heap->name ?: "(null)", MAX_HEAP_NAME);
 		hdata.name[sizeof(hdata.name) - 1] = '\0';
 		hdata.type = heap->type;
 		hdata.heap_id = heap->id;
-- 
2.19.1

