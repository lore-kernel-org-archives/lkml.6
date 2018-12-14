Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC22C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8862070B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LZLN1Z0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbeLNQEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:04:13 -0500
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:15328
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729649AbeLNQEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8DGjilkDTAtvOUr9EdaT9/pa7rB4S81GfK1HIBkt4w=;
 b=LZLN1Z0XabNTxCRNzYUMj6Eykm4Fv4FxAwnx2+TDSyR04KTHbNR4R5BuqMQKT1Qldsnl/bmHlMhCqmNrgXSCyj6b7l6pJAjG3qxxNh4QmCXs119++OWrec2QIOzOnaYOiD4pUuJGiCyvPvI6JSNCM6HIA2EQWsRCV6ce7ACzMOo=
Received: from AM0PR04MB4994.eurprd04.prod.outlook.com (20.177.40.15) by
 AM0PR04MB5316.eurprd04.prod.outlook.com (20.177.42.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Fri, 14 Dec 2018 16:04:06 +0000
Received: from AM0PR04MB4994.eurprd04.prod.outlook.com
 ([fe80::f53c:adef:eddb:4a2]) by AM0PR04MB4994.eurprd04.prod.outlook.com
 ([fe80::f53c:adef:eddb:4a2%5]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 16:04:06 +0000
From:   Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>, Roy Pledge <roy.pledge@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 2/2] soc: fsl: dpio: Change bpid type to u16
Thread-Topic: [PATCH 2/2] soc: fsl: dpio: Change bpid type to u16
Thread-Index: AQHUk8ajD2zLcqlfekeh8n/wdrEQSw==
Date:   Fri, 14 Dec 2018 16:04:06 +0000
Message-ID: <1544803440-32755-2-git-send-email-ruxandra.radulescu@nxp.com>
References: <1544803440-32755-1-git-send-email-ruxandra.radulescu@nxp.com>
In-Reply-To: <1544803440-32755-1-git-send-email-ruxandra.radulescu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0011.eurprd05.prod.outlook.com
 (2603:10a6:803:1::24) To AM0PR04MB4994.eurprd04.prod.outlook.com
 (2603:10a6:208:c7::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5316;6:Qq8nIiy543LJVk3p276qGUK+2pCVg83OJtnwgBaO7re+/XaXOgD68IUsHEqzSCbnlbOUTOS43SyY4k42bF7iCb9n4EGfuHor8jUL4ygGwYFt1f5kBmkXHhQT4OImh2b83N83A+gxKP5ByhSvEUnVSmJfF2rncmiAKhm95ckNKX4SbhiHvzdFmYnDslTP5ib41nHyUR03AxRdYO9iUKpE1bV4VXqLwdXmKwnnCjdTsDEWZb5psaRsOpDHrgLay3y7lrSSwoty5Tr8H0GLo8kUokj8jYl7dnCGVhjpaygP2OkN9pMfaEqXqBeL3w3hUoztVxbfObiUztd7RJcW1T0L/0pqNnPQ8EOpxtM9SabRb7eYsZESdHDeGGLnPe5P6laNWR0GMaPa2vCgnzBCWS3p7ckb/RO8GVG3gK8BSjDSHHKKyGU5kDM1PhN9WZoxf257+AErq3fu86jZCBd484uuqA==;5:oz2SL1KgOA56atgxwvlnZjAOGrHrgNKFWj9LG4lNIWci0bEVjUSVcpeFjRHeOuMuTQKzzYlWSXr/mpYKhCWGxGSEsrsiKfdmpi6doSLi+1yHJM/3JIr3vln8wedOXbuHo4iNZ3YW8TqnKxJQfJm2Q1QXOUMwYre8Fa2ThNizJOQ=;7:Z56ukYe3xaXYQJoVZhp0D9RkLTktfgL0iEhywIOFUBgJkEaioRSC1Sq8zhNWs8pA5m1VdWQOK0DnByB87aWcvxwRfN7NSCkvpGYI91nKxLFU/8or4ix4eAmov5oK2xnOruKm2IhZ4qA+wmsrqJnQeQ==
x-ms-office365-filtering-correlation-id: ca8fa24e-4155-4742-5529-08d661ddc60e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5316;
x-ms-traffictypediagnostic: AM0PR04MB5316:
x-microsoft-antispam-prvs: <AM0PR04MB5316092E2BC27D99BE4A760094A10@AM0PR04MB5316.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5316;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5316;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39860400002)(189003)(199004)(52116002)(26005)(71190400001)(8936002)(99286004)(71200400001)(478600001)(25786009)(476003)(53936002)(105586002)(106356001)(110136005)(102836004)(6116002)(6436002)(54906003)(186003)(81156014)(81166006)(6506007)(256004)(76176011)(316002)(14444005)(85306007)(3846002)(86362001)(97736004)(386003)(36756003)(4326008)(68736007)(486006)(8676002)(305945005)(446003)(11346002)(2616005)(6486002)(5660300001)(6636002)(66066001)(2906002)(14454004)(6512007)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5316;H:AM0PR04MB4994.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xPswCFKjgd7cmsKb4dW0HbMlW4wzkVSFs65WX//MUE0qMoYGKYG0x66ZGG7I9U1/TAGULRXfqNePrytgoHoUWaTPGG01JVYiqyy9p6Yya5TudqLMucjFV6EWscjkU6G0d25UN9zlVMITwXar4HMpArhVnKuuxjHa9oeW5IqORk7lh++sNd5dmkKQl9tAW/G2E/UOWm5vBMP5YEm1fPpUR7/lAsHO+Ul2C221PE8LQQifboYZ798ouBJypitxhmMBciSMbHFewk9AvO0fTrC6ICcuL24c5iwR+d9AOFjpzT7YaASeO0I6KThqB1epgGIN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8fa24e-4155-4742-5529-08d661ddc60e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 16:04:06.5033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5316
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In all QBMan registers, the buffer pool id field is two bytes long.
The low level qbman APIs reflect this, but the high level DPIO ones
use u32. Modify them in order to avoid implicit downcasts.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/soc/fsl/dpio/dpio-service.c | 4 ++--
 include/soc/fsl/dpaa2-io.h          | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpi=
o-service.c
index 56a35c0..f9c372e 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -456,7 +456,7 @@ EXPORT_SYMBOL_GPL(dpaa2_io_service_enqueue_qd);
  * Return 0 for success, and negative error code for failure.
  */
 int dpaa2_io_service_release(struct dpaa2_io *d,
-			     u32 bpid,
+			     u16 bpid,
 			     const u64 *buffers,
 			     unsigned int num_buffers)
 {
@@ -485,7 +485,7 @@ EXPORT_SYMBOL_GPL(dpaa2_io_service_release);
  * Eg. if the buffer pool is empty, this will return zero.
  */
 int dpaa2_io_service_acquire(struct dpaa2_io *d,
-			     u32 bpid,
+			     u16 bpid,
 			     u64 *buffers,
 			     unsigned int num_buffers)
 {
diff --git a/include/soc/fsl/dpaa2-io.h b/include/soc/fsl/dpaa2-io.h
index e11eed1..5186ad4 100644
--- a/include/soc/fsl/dpaa2-io.h
+++ b/include/soc/fsl/dpaa2-io.h
@@ -108,9 +108,9 @@ int dpaa2_io_service_enqueue_fq(struct dpaa2_io *d, u32=
 fqid,
 				const struct dpaa2_fd *fd);
 int dpaa2_io_service_enqueue_qd(struct dpaa2_io *d, u32 qdid, u8 prio,
 				u16 qdbin, const struct dpaa2_fd *fd);
-int dpaa2_io_service_release(struct dpaa2_io *d, u32 bpid,
+int dpaa2_io_service_release(struct dpaa2_io *d, u16 bpid,
 			     const u64 *buffers, unsigned int num_buffers);
-int dpaa2_io_service_acquire(struct dpaa2_io *d, u32 bpid,
+int dpaa2_io_service_acquire(struct dpaa2_io *d, u16 bpid,
 			     u64 *buffers, unsigned int num_buffers);
=20
 struct dpaa2_io_store *dpaa2_io_store_create(unsigned int max_frames,
--=20
2.7.4

