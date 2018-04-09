Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523240316-2-6301095041703890437
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240315; b=ecqlY/9qY3V/XLYwNBUHKCGW3HhFk6dr1e+Ibd1m6HNBJ6xq0v
    D+Z5R9ArmBD/r1rOP6zEYQq7ps9JvQabPtFLe4hPDz9zMEJ7J3P6E7t5xR+1tAi0
    39EuM68RRs5Vfgan5Bc648N7l4fBFeGi4/HRnhtI6XMJ8gn8jwNKQ3LDAWgGzxOr
    19GUM/D85BtHipJFt0aV4PAV8cfHksIHaAthEk2l0ReZdq4OUteLAUAY9NDxT2Zj
    j9JkXZrEYrdzzCIEuU1ER9O5Eu5odFdFo2GOonFthhqxh8joT3wFVPiZBs8czTEl
    xifZcOT2BTl1gyWpH6J5YVjPZNzDj2G+9hxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240315; bh=1rH3Wc0pSi
    YgTHt0x/HXx8FgTDUouPd/LnQiICTau0w=; b=FLz5uxnmA3Ra+Qubis/DRo8mb3
    vYMTPGZntrUuyJFxBDzrpmitt0xXxT7h53EAvvOVwLne80EUgZBEXjTpINtl9Ni9
    ucBnG/JoMceH8N4r2CZOGG3nHWLcZdLQY23Uyka6dhJMtUp8vPYXgRTIuKthP8rz
    IbkShEqK7YIYYguPcToiftD0ybp8CCtXW5PBY98PP2mCFQ20PWcWy6DndxHFSczR
    DqtLzhLYidFGlGZaGTvyWZ4p26TrmaeIcorvOSs90bETMtM3o9Gmiccwk/cxS7VT
    SXdM9/KWLLwrwq/Tnu24BtWmYg2vH7Y32sVQvCvNwl+pDz4LUxbKPlapj5gw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nXRllAY4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nXRllAY4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDdnkmA3lMF1n8hJzaDxyGiq767kai9xmE0nqZd+k/TabvWJuEupkz6Q15/yIgcM7J/JZUDrvQiQoiRnpXP8Em/uDF9I2VjUywpuFGhkszoV41b1LtDe
    fJc2gXpkB7EYlZFgFNtxBsFrtsSBuIJQlmdCXIx7Ty9ZMs7jXo5/bXQYMmPX801oIrWh30N57PZXa5kjvAv3lrnJaV4Od8dW4/hHIGenxgw9y85hCdmW4Cpq
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=qOCqdZANoq3OZa2K87wA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756064AbeDIAaZ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:30:25 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:10314
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755787AbeDIAaX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:23 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 128/293] iwlwifi: mvm: use scnprintf() instead
 of snprintf()
Thread-Topic: [PATCH AUTOSEL for 4.9 128/293] iwlwifi: mvm: use scnprintf()
 instead of snprintf()
Thread-Index: AQHTz5khK5hisPfu3kWAON7W+yozxA==
Date: Mon, 9 Apr 2018 00:24:32 +0000
Message-ID: <20180409002239.163177-128-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:gRtg4kSi0rH/Q28vBOw2KMk1mkjVp9i/B+NtkjzrcysFnJFBn9bsovgL0AiPnnOYYbYClp4HqSFa6TKz7Ac+GjBknr86/pbaFo5+5Tpq62v99bRadmU4Z5ishaNqXQDw2n351dVF19LScNQUcpX9qg7Ue5NFZRQxCz7VD/A4f6GK+pNNZ2PL/ECmAYUjiZcjhtiTG/yNNOTb5jLTvNDMfVov+ChWq2w5RmvUcvuBis9O0bfIGCukLETQ65q1GHOa;20:6n2T4v7JcCEc7coXJcugXBaNIdNFKqCUm8r0srK9aDdQsB/j5IydPB0Y9GgThxYS/CXHU0ili7v3HHpvFD0RkJ8VIxff9fPcj0sXNzKoe5MCe+gb3Y07d4XlAy5KrzIjRswRLaZW+/xpyGtImXis8pFxC7LxjL7bv70zXd5KZI8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: acb0b6d7-b1ad-43d1-08e7-08d59db111f7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032BBD3D0FA0BFD073FFEADFBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(5660300001)(76176011)(99286004)(10090500001)(2900100001)(105586002)(305945005)(7736002)(107886003)(2501003)(5250100002)(14454004)(53936002)(4326008)(8936002)(68736007)(25786009)(86612001)(3846002)(66066001)(1076002)(486006)(316002)(72206003)(22452003)(106356001)(186003)(97736004)(6436002)(6116002)(476003)(2616005)(478600001)(6486002)(10290500003)(2906002)(110136005)(54906003)(6512007)(81156014)(81166006)(8676002)(36756003)(11346002)(3660700001)(446003)(6666003)(86362001)(26005)(102836004)(3280700002)(6506007)(59450400001)(22906009)(2004002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: WuwftFS0lJqxkOfFzbQdvS45F+LT0aa6P35vgv//3Kl3sGZGMHXWws9eNCMwIRzr8OD/c8c1BTlaTwDekzyFMFPQCJYm1xHkZ4luobsRLSc64ladRzCJrRl01NC/JBl6YSmSg2a1VIUp/5OBoTPTHENZFHFQtC/R7dpmfLA0iYrxQ1YlDUVsWflJcNQb8XblRgQ7KuxIMAipKeZzh+qXRQUJJcH3Jp2I8MWUJwDZHlm0rqo3PSWkAgy7dygGgtvu8KcqzNWww7UrrDE8DTNgFypZc998rcEelhnrgbFn4WM/BB7ae8vJc/SgLxikcRvkoIks5GU0cmHBnW6Vg+c9pEy6GlWzZTTUcA8A4ruQDpDKOH+u/K1sksOGGz9y6L/dvbWIHYXz3jSTFaXb1pVe++m6EvyFna74aUYepHLU3RY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb0b6d7-b1ad-43d1-08e7-08d59db111f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:32.8000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 40e86a3619a1e84ad73c716c943f65fc38eb1e28 ]

It's safer to use scnprintf() here because the buffer might
be too short for the full format strings. In most cases
this isn't true because of external limits on the values.

In one case, this fixes a stack data leak.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../net/wireless/intel/iwlwifi/mvm/debugfs-vif.c   | 22 ++++++++++++------=
----
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers=
/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index f4d75ffe3d8a..41a105116d14 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -7,7 +7,7 @@
  *
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
- * Copyright(c) 2016        Intel Deutschland GmbH
+ * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -34,7 +34,7 @@
  *
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
- * Copyright(c) 2016        Intel Deutschland GmbH
+ * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -1304,11 +1304,11 @@ static ssize_t iwl_dbgfs_low_latency_read(struct fi=
le *file,
 	char buf[30] =3D {};
 	int len;
=20
-	len =3D snprintf(buf, sizeof(buf) - 1,
-		       "traffic=3D%d\ndbgfs=3D%d\nvcmd=3D%d\n",
-		       mvmvif->low_latency_traffic,
-		       mvmvif->low_latency_dbgfs,
-		       mvmvif->low_latency_vcmd);
+	len =3D scnprintf(buf, sizeof(buf) - 1,
+			"traffic=3D%d\ndbgfs=3D%d\nvcmd=3D%d\n",
+			mvmvif->low_latency_traffic,
+			mvmvif->low_latency_dbgfs,
+			mvmvif->low_latency_vcmd);
 	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
 }
=20
@@ -1385,10 +1385,12 @@ static ssize_t iwl_dbgfs_rx_phyinfo_read(struct fil=
e *file,
 	struct ieee80211_vif *vif =3D file->private_data;
 	struct iwl_mvm_vif *mvmvif =3D iwl_mvm_vif_from_mac80211(vif);
 	char buf[8];
+	int len;
=20
-	snprintf(buf, sizeof(buf), "0x%04x\n", mvmvif->mvm->dbgfs_rx_phyinfo);
+	len =3D scnprintf(buf, sizeof(buf), "0x%04x\n",
+			mvmvif->mvm->dbgfs_rx_phyinfo);
=20
-	return simple_read_from_buffer(user_buf, count, ppos, buf, sizeof(buf));
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
 }
=20
 static void iwl_dbgfs_quota_check(void *data, u8 *mac,
@@ -1439,7 +1441,7 @@ static ssize_t iwl_dbgfs_quota_min_read(struct file *=
file,
 	char buf[10];
 	int len;
=20
-	len =3D snprintf(buf, sizeof(buf), "%d\n", mvmvif->dbgfs_quota_min);
+	len =3D scnprintf(buf, sizeof(buf), "%d\n", mvmvif->dbgfs_quota_min);
=20
 	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
 }
--=20
2.15.1
