Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EADDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:20:59 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608BE205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="y6c4kuAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608BE205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391201AbfBOJUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:20:17 -0500
Received: from mail-eopbgr770073.outbound.protection.outlook.com ([40.107.77.73]:18929
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730658AbfBOJUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEYMzIdTn5QWExcCPZoHLa59sK1Qewc3SBYdnv+1EaM=;
 b=y6c4kuABBp7wD9wAzdooDZbmjipSS2vUoWWA9FF35xQ4T+XxK6JZXR+Ugq8ih4Ew7NGSOvzGyjQssCVIbfsm0BMXjTyltparGwDPlb5yJWd3yQTr0wEl5XMXultZ31JgNVwYubzHPzt+Kq4C4+J5+i1x6tb68usGUCdNv4xKh0o=
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3615.namprd12.prod.outlook.com (20.178.242.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 15 Feb 2019 09:20:07 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f01f:c1eb:8483:1679]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f01f:c1eb:8483:1679%5]) with mapi id 15.20.1622.018; Fri, 15 Feb 2019
 09:20:07 +0000
From:   "Mehta, Sanju" <Sanju.Mehta@amd.com>
To:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>
CC:     "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>
Subject: [PATCH 1/4] NTB: ntb_perf: Increased the number of message retries to
 1000
Thread-Topic: [PATCH 1/4] NTB: ntb_perf: Increased the number of message
 retries to 1000
Thread-Index: AQHUxQ+kzcBLircFnkWwMPFTZUsE7g==
Date:   Fri, 15 Feb 2019 09:20:07 +0000
Message-ID: <1550222279-27216-1-git-send-email-Sanju.Mehta@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::21) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56f66693-fd3c-480b-cbf8-08d69326c674
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3615;
x-ms-traffictypediagnostic: MN2PR12MB3615:
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3615;20:wz0L8m8i+dYdUrCIEz9DRJXLqnxfa3K12SY1YlmMgLj6DfGBWOxEMvD4xVXoi06cIaQj/YhnBQkc/sTMd1/aPMQEQ6XDQEgxIOcpRUQ0fx49ppby/yolgi8+tnRwewSerwcOVxW2BOwo5ySxfCefOPn8THF4yPFpeefVFgkRKreD92JvUA25LaHZxchz4moggks4Iyq5PSFDNlLkd2wofe9YvOJIZadRUTlBtm7QO1Mi3K0XBj0Dq2r9bWKm7Rh9
x-microsoft-antispam-prvs: <MN2PR12MB361579EE71F3EA679F41DC00E5600@MN2PR12MB3615.namprd12.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(346002)(39860400002)(189003)(199004)(68736007)(256004)(86362001)(2501003)(14454004)(6486002)(6436002)(97736004)(2201001)(6116002)(3846002)(72206003)(2906002)(66066001)(478600001)(36756003)(2616005)(186003)(476003)(26005)(52116002)(4744005)(6512007)(486006)(4326008)(25786009)(110136005)(316002)(54906003)(99286004)(50226002)(8936002)(81166006)(81156014)(8676002)(305945005)(7736002)(106356001)(71190400001)(71200400001)(105586002)(53936002)(386003)(102836004)(14444005)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3615;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MCjH15XAqrxRLfm0vNYDbOrbH7TZ3N50G3hB6xVvglQ5q1DtEqRz+L1iJ/kruSwRBCAprVwRKuiDwNJq4r6m5gxdy+qNmlzMmt3GTRTr8BgIer4LU8DQozqHDhOXledNziEotBPsG4HYhCIouZW2tEpPiNypBWPAXgRzHynfGus44fB2ck8kUpCJjoA8eYKDuBg5CE3TbdtmmxmhxPG39gyr4T3ixBETFTgAbnUvFwTXr1BaeaWOF3Y69mYHdgOdi9O/ONAeco4JAMtnVQRxOFM3xR8j/7n0ZN+ALrsgeTQ0k6Inbv7sRoeLifldep1vB9k6G3+6qrW1aNm6PUcCcN4jnrE8s22lj4jy7m/iRC7t6VbS3VQKrgrw0ZMyJoOCFt56B7IBr590Lr1xD/iH/Mh0+7FnnKve8s2JYE5FnWw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f66693-fd3c-480b-cbf8-08d69326c674
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 09:20:04.4921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

while waiting for the peer ntb_perf to initialize scratchpad
registers, local side ntb_perf  might have already exhausted the
maximum number of retries which is currently set to 500. To avoid
this and to give little more time to the peer ntb_perf for scratchpad
initialization, increased the number of retries to 1000

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 2a9d6b0..a828d0e 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -100,7 +100,7 @@ MODULE_DESCRIPTION("PCIe NTB Performance Measurement To=
ol");
 #define DMA_TRIES		100
 #define DMA_MDELAY		10
=20
-#define MSG_TRIES		500
+#define MSG_TRIES		1000
 #define MSG_UDELAY_LOW		1000
 #define MSG_UDELAY_HIGH		2000
=20
--=20
2.7.4

