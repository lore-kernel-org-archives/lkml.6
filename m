Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94ABC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84176206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OvVDnBwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfBXNNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 08:13:48 -0500
Received: from mail-eopbgr40078.outbound.protection.outlook.com ([40.107.4.78]:27872
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726835AbfBXNNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 08:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2G4O9wlADocTI+KLYf2C4pFRKOP+5n5ebNSX0r2+y0=;
 b=OvVDnBwO3X3f0rK7c4337JhaoK3C8BIJ6bx+jhEzXMB0V7B6I2kAKXsK0AaGWKXtU++pWwvZ3+B42dl/kD60PeQ89VSYDCN239E5xYB+2YBLaKs4hhcZWku9pVZgq4RScL2n2FqMOKdcDxBhcmFtZrdT1Etd8YOa7Og3TkNdQUo=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5651.eurprd04.prod.outlook.com (20.178.118.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Sun, 24 Feb 2019 13:13:43 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185%5]) with mapi id 15.20.1643.019; Sun, 24 Feb 2019
 13:13:43 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "dennis@kernel.org" <dennis@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>, "cl@linux.com" <cl@linux.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] percpu: km: remove SMP check
Thread-Topic: [PATCH 1/2] percpu: km: remove SMP check
Thread-Index: AQHUzELEXhV7UVWfi0W/HwwXYpeEXw==
Date:   Sun, 24 Feb 2019 13:13:43 +0000
Message-ID: <20190224132518.20586-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:202:16::15) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1732d3c7-21c0-4f68-94f5-08d69a59e653
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5651;
x-ms-traffictypediagnostic: AM0PR04MB5651:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB5651;23:xiMsaAmZ8pun0f27xTp7/QNsVnrSyGVfb7IR9yO?=
 =?iso-8859-1?Q?Gd8SzEziPqW9jDiezxk500wetxooeiLs2sYPWCchKNRrKcF6fvIZvO1klB?=
 =?iso-8859-1?Q?rpp7fFmhmAVTd8Wl36prVYI9PYxmIufPt79deLiDyqePCnj/qG/3WTlvC9?=
 =?iso-8859-1?Q?mx9PPIg9Rq2OXcQd0HhhqJwX3KTVp7q/1Fog4/+Xf3W5DZETVzLvcmT8T/?=
 =?iso-8859-1?Q?Y4Q1KZxTzzSJ0v2+yVjs9PEG2Ne7oU/fzpPdEEw3RvbX4H2aPRGjDVISx3?=
 =?iso-8859-1?Q?Be9fzbV5SJAoqON4tWgNWDOlsZ0iav9zAtphp722urykIBJgfoyhNg+fHG?=
 =?iso-8859-1?Q?SqlqpuMclixY+LcBUcQ/hpmYSOWrd2ujNkZXIT7ooLdsOA3QMwLUYMblEM?=
 =?iso-8859-1?Q?HFJF1+Lg4RwtAUvSdtgAUax9o40FRe8RfnnW8qhRFD7Ztv1dIJM1XtutS5?=
 =?iso-8859-1?Q?iH2y+QsPImEUpnTXiA4esjFipOhDZk1cx+Jnh+OP0fdmytTYyUV/Dd2gy3?=
 =?iso-8859-1?Q?MfK5ofWlnkKn8kjNkC2H6zUzMqgkBra/JtXCe7ASYYLsrZU8IfLaR9pdnD?=
 =?iso-8859-1?Q?GjzU/yjlcxvnkPqC37Qn1HVQMAovr0sLi7sLlVFZqZyNGq5vW7aDKehqYS?=
 =?iso-8859-1?Q?dVt3YUfyEX44tnkt0EDi34n7nzAn8os866ek95Cnt6K6vtGHezH1spNzzO?=
 =?iso-8859-1?Q?jQErh9XmSOOBCn2X3Uu+PwWtwJgOmkIk00JzcyJFfUWkAQg8F9ijeb0jmK?=
 =?iso-8859-1?Q?sOQgU3pOqDttjbLBvfS6wPVVY8SflEe9HF0ORCH2/hUPN6QZ7JRmGsjadY?=
 =?iso-8859-1?Q?23Ij/qHxCDm75JsntHnvJWnjVAOZQanI0Pu6gG7ywwXO8CEambHlplRSGw?=
 =?iso-8859-1?Q?MiEfKCGSs3YM7wcxP5Zj0IgRflS3XSuYrH5Wdmpb0g7pCdUe1mZYGbIgFa?=
 =?iso-8859-1?Q?YVXmIj3SAvoZ0qukfIt+1r9cgZLqU5vQU2i3gmztQRhbAjvXqLBPxIBMRV?=
 =?iso-8859-1?Q?oZkbU4JW+h4TKNPiKfHA0eSh5AGw65szAhODGRGQOeyNzTx34B+vxzjWDc?=
 =?iso-8859-1?Q?G0JoYaodzXCg/1005AnWmYakUAiv9y4vnTe4ZkfzLfyv9EONEbhJHn6WiZ?=
 =?iso-8859-1?Q?1re0TWRXQWWAxfVrqXVNXQIn2dwsPrAnXv81Ah/6YACS9TRUNUAjKwi96e?=
 =?iso-8859-1?Q?RXfsrR6Lz2p2J8PBXyuDJZc2hPg0TGeWMMkXmgafcoN6xMJxQoCpVs2RzP?=
 =?iso-8859-1?Q?/9V3+79XVu6M8ueN0MEBdSItp1+pUafnGaT7UBWI/E23G4SiKfd16xU68E?=
 =?iso-8859-1?Q?CQ=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB5651B069F2E82FA2D8114DDD88790@AM0PR04MB5651.eurprd04.prod.outlook.com>
x-forefront-prvs: 09583628E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(396003)(39850400004)(189003)(199004)(8936002)(8676002)(81166006)(44832011)(81156014)(486006)(97736004)(7736002)(6436002)(476003)(110136005)(68736007)(305945005)(2616005)(53936002)(6512007)(54906003)(316002)(2906002)(26005)(186003)(2501003)(4744005)(14454004)(1076003)(50226002)(256004)(478600001)(52116002)(66066001)(99286004)(71190400001)(71200400001)(386003)(6506007)(5660300002)(106356001)(36756003)(105586002)(2201001)(6116002)(4326008)(3846002)(6486002)(14444005)(102836004)(86362001)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5651;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JmCNdrJHUtGwPN8uvn3la4mMD04szSF4b9BKS1jWQ4dsDi1SG4swoPSDZZwMHjYGDeJFM1RDg1mqSgQbdORF0bskE/MkEGxzc6OwWIZoX6eiiXmhI2XEisbZtKdfjL1w/M7gTUpwO9mx/qk+k+tpffLaFtVZ1/eG7P3/fJGAJLo2QhuyKoQbsL5iW1UHNt0vdpy8UEa6/aWtE/xwQBKPwMcIGkJyAwE6GZmsWmMdi+425kZ3mWZzPQOVeKNT2Ug7ZMqFzJYCIJVvbmqKM9PPrLVKNR4xWwLwcS37xmr31LMOGhyPI+/gUxgtXP1ACLnh6MY8hg0kqiuIXl7TEFAcA47QqFFX7cr5sEFUILGxbzn9vUcuxlYTQAD1tSIU0W3EQKtjjXFbnxKkKwhJ99RY3dUyAnc0f0zq+dVCKb+lUxI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1732d3c7-21c0-4f68-94f5-08d69a59e653
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 13:13:40.2301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5651
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

percpu-km could only be selected by NEED_PER_CPU_KM which
depends on !SMP, so CONFIG_SMP will be false when choose percpu-km.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 mm/percpu-km.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu-km.c b/mm/percpu-km.c
index 0f643dc2dc65..66e5598be876 100644
--- a/mm/percpu-km.c
+++ b/mm/percpu-km.c
@@ -27,7 +27,7 @@
  *   chunk size is not aligned.  percpu-km code will whine about it.
  */
=20
-#if defined(CONFIG_SMP) && defined(CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK)
+#if defined(CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK)
 #error "contiguous percpu allocation is incompatible with paged first chun=
k"
 #endif
=20
--=20
2.16.4

