Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521497781-2-8299118634329900655
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521497780; b=JgZ4ovr+zAjCJ3wq2rqX1xfrdjSJQbGLxWPWE5/WKUKfc4j
    fyVrUUgbgvC+ky+uNh5U7leojPnrL7U+MrE4LLj4PGwt0eyIShMyS+QOuIkALAVt
    j4yXj37STX6Q1n84E6iDH3nednvtOCRIpkDgrdbLmXFIksy4T/tSQOdhn1E0WdvG
    9zHVbJe6m3IriDe0ZvLzaeVAvYxNARR1dXTtRMZUJPCRAThRC6MBk/4H4+QtzNlL
    Hpv9AH3N4jWDPmvsmA4axhFy2eUyN7/2+HMHbXN/C5H4tVo3HP6rBD+5KuJ7VACw
    0vLUQaTkj6MxuzAWzlbGrx8b+eoWleGV1bJPY4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497780; bh=Y24JSo
    TkvdIfc3XJvh/ig07yoqq7orAK/fGxlenGqGM=; b=iwWaW3JXSVFvADRibHdu81
    OCRFQPcG0EIAr2bwDb+jqfBGtNQgbhxV4XQWW/Gi7fC517jFplE3DSES1MQ5/Xao
    R41Qkt+dR7pxuQD5ciGsLx6MYj+fx7YT4GUKF7D4Rk2nEQTkMJ76qis8vt9Rt2IC
    hWzyOR0FeamV0LDSZhnAswcqCknFn6EomtpcWmQSdJmj/sC7nUqGmT9+2QYDefSS
    /D4tzxDmlmlF3ZlVAVr2idDeEK9Ew6ruAXapi/G5kpx/PS8+mGlsxX/pTzIgy89J
    yZLRUbPMRaxHJWZhnblQ8UmWyPzJCtp6n7LUm+vZpYyBLwrnRdwDW9ytuaslfaWg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y7octwze x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeltddvtdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y7octwze x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeltddvtdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934439AbeCSWPm (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:15:42 -0400
Received: from mail-bl2nam02on0123.outbound.protection.outlook.com ([104.47.38.123]:41056
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934010AbeCSPt5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:57 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 106/124] scsi: megaraid_sas: Error handling
 for invalid ldcount provided by firmware in RAID map
Thread-Topic: [PATCH AUTOSEL for 4.15 106/124] scsi: megaraid_sas: Error
 handling for invalid ldcount provided by firmware in RAID map
Thread-Index: AQHTv5nLbinE4tj260y2cR69xlVb+g==
Date: Mon, 19 Mar 2018 15:48:58 +0000
Message-ID: <20180319154645.11350-106-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:fIT1dEUSdLQbk39+8+CghNs3s8UwDxDCZjuVGP1TP9R2EpnLySAH9I9U4+cNKw1BNNtxbkaOSxuFQrsVC95JMKTCmFJFXPeC0uY8gHzjg7tXZ+8ViofunYE8RJbep9Dx55RA4ghuu2ARi54/ioI6bptYzBIw2bvlpIXjXWcpLSpkUmsF50EwU2Iork8R55ErpAwN+NWOC1wvSw6w2O64BJQzxmhjW9QRXEpqHwCCyzi8Mk7N8gKGNxIUkCXhWnxZ;20:gTU+CKs82TQ1P0GGXtlOFKntlkoeLlSc4lakspAQQ4mrVHs0Z8Ac5ye670MLQIKVC0tRproDEuZJf4Dwfs+Y9yGRiRWnXeFu93FGGeHqUIg4nNgN1BXOED6w4vw0aSsZo/RRVWQWpeuXIX0VLCkuFMNPnSDkfXbeHcuQqBAZkRo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45a94598-f3f6-4815-b089-08d58db1098f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1109562EFF22739A48AA5A70FBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(81166006)(10290500003)(107886003)(81156014)(106356001)(6506007)(8676002)(3846002)(36756003)(8936002)(97736004)(6116002)(1076002)(102836004)(68736007)(6666003)(3280700002)(2950100002)(3660700001)(478600001)(72206003)(59450400001)(2906002)(14454004)(76176011)(66066001)(6512007)(5250100002)(10090500001)(2501003)(53936002)(6486002)(6436002)(26005)(316002)(22452003)(305945005)(7736002)(4326008)(25786009)(86362001)(575784001)(86612001)(5660300001)(2900100001)(99286004)(54906003)(186003)(105586002)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Iujg+YOa7oXwMBZuMDFH73h6+ffPdqBPSXtds3wrwtLpAxx9ylC+aHiAyRPRO8Ko2dSWDc8n15pbwHM+WJ8N9Slw32n3lobMqGTxSe8WUZlNs5t2DLzWwwkvn15jsLpYnDj+QVY1muBHeB7KoKGzf1WLfcQI6ZHHvB/UY/IPiAejJ/z+f20g3nXwZNEwmX0ze6nlmzFKQPAeBF49jN79/8auJgx/O/qGcVQSwZkoyj3pwyusfWVU6r6Se0/4uvfqk92I74tzzCAWO1b4qS5f5oGgL1RufPQuhqmrOaUGHrMx9f9OG7Aw1zzeB4wWsneRmSaDDvZcaYFwZ64amheEgQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a94598-f3f6-4815-b089-08d58db1098f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:58.4135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>

[ Upstream commit 7ada701d0d5e5c6d357e157a72b841db3e8d03f4 ]

Currently driver does not validate ldcount provided by firmware.  If the
value is invalid, fail RAID map validation accordingly.  This issue is
rare to hit in field and is fixed as part of code review.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/megaraid/megaraid_sas_fp.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fp.c b/drivers/scsi/megarai=
d/megaraid_sas_fp.c
index bfad9bfc313f..f2ffde430ec1 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fp.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fp.c
@@ -168,7 +168,7 @@ static struct MR_LD_SPAN *MR_LdSpanPtrGet(u32 ld, u32 s=
pan,
 /*
  * This function will Populate Driver Map using firmware raid map
  */
-void MR_PopulateDrvRaidMap(struct megasas_instance *instance)
+static int MR_PopulateDrvRaidMap(struct megasas_instance *instance)
 {
 	struct fusion_context *fusion =3D instance->ctrl_context;
 	struct MR_FW_RAID_MAP_ALL     *fw_map_old    =3D NULL;
@@ -259,7 +259,7 @@ void MR_PopulateDrvRaidMap(struct megasas_instance *ins=
tance)
 		ld_count =3D (u16)le16_to_cpu(fw_map_ext->ldCount);
 		if (ld_count > MAX_LOGICAL_DRIVES_EXT) {
 			dev_dbg(&instance->pdev->dev, "megaraid_sas: LD count exposed in RAID m=
ap in not valid\n");
-			return;
+			return 1;
 		}
=20
 		pDrvRaidMap->ldCount =3D (__le16)cpu_to_le16(ld_count);
@@ -285,6 +285,12 @@ void MR_PopulateDrvRaidMap(struct megasas_instance *in=
stance)
 			fusion->ld_map[(instance->map_id & 1)];
 		pFwRaidMap =3D &fw_map_old->raidMap;
 		ld_count =3D (u16)le32_to_cpu(pFwRaidMap->ldCount);
+		if (ld_count > MAX_LOGICAL_DRIVES) {
+			dev_dbg(&instance->pdev->dev,
+				"LD count exposed in RAID map in not valid\n");
+			return 1;
+		}
+
 		pDrvRaidMap->totalSize =3D pFwRaidMap->totalSize;
 		pDrvRaidMap->ldCount =3D (__le16)cpu_to_le16(ld_count);
 		pDrvRaidMap->fpPdIoTimeoutSec =3D pFwRaidMap->fpPdIoTimeoutSec;
@@ -300,6 +306,8 @@ void MR_PopulateDrvRaidMap(struct megasas_instance *ins=
tance)
 			sizeof(struct MR_DEV_HANDLE_INFO) *
 			MAX_RAIDMAP_PHYSICAL_DEVICES);
 	}
+
+	return 0;
 }
=20
 /*
@@ -317,8 +325,8 @@ u8 MR_ValidateMapInfo(struct megasas_instance *instance=
)
 	u16 ld;
 	u32 expected_size;
=20
-
-	MR_PopulateDrvRaidMap(instance);
+	if (MR_PopulateDrvRaidMap(instance))
+		return 0;
=20
 	fusion =3D instance->ctrl_context;
 	drv_map =3D fusion->ld_drv_map[(instance->map_id & 1)];
--=20
2.14.1
