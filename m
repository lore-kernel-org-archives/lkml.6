Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC873C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3BD206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D2f8pTKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfBXNNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 08:13:54 -0500
Received: from mail-eopbgr40060.outbound.protection.outlook.com ([40.107.4.60]:5777
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726835AbfBXNNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 08:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpNmAJGfNaAbucE9at8ymMaSSbS6S7aVICsihO7VzvQ=;
 b=D2f8pTKa+M+LNCtAizGstJZ2Db2D7c96itlmOHob8s8EVwXoPr859Bs5O6nyqbpCLOagwxjh+O5HMUs1N7TN6xe24FJIrhA3oHu+VAtiC4sVyhmjkCiBFzrASpxCgY2c0DupwnnQaZkG4jzezhIKCAyXfJ3p0zPKPNbMDU6/whE=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5651.eurprd04.prod.outlook.com (20.178.118.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Sun, 24 Feb 2019 13:13:50 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185%5]) with mapi id 15.20.1643.019; Sun, 24 Feb 2019
 13:13:50 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "dennis@kernel.org" <dennis@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>, "cl@linux.com" <cl@linux.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] percpu: km: no need to consider pcpu_group_offsets[0]
Thread-Topic: [PATCH 2/2] percpu: km: no need to consider
 pcpu_group_offsets[0]
Thread-Index: AQHUzELI99orDQmet0qADTSfLzpSUQ==
Date:   Sun, 24 Feb 2019 13:13:50 +0000
Message-ID: <20190224132518.20586-2-peng.fan@nxp.com>
References: <20190224132518.20586-1-peng.fan@nxp.com>
In-Reply-To: <20190224132518.20586-1-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: 6348761f-7961-49e4-f8b6-08d69a59eac8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5651;
x-ms-traffictypediagnostic: AM0PR04MB5651:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB5651;23:wqjxN6jLGDsg0Vq9FnyEweRo7y7akEJU5QtmbMh?=
 =?iso-8859-1?Q?eP+YH8FtXVshIYy0hsfRQlisrJ451zQ2/PM9g3QDLTcHJ0+GE4J7Aw7DEt?=
 =?iso-8859-1?Q?+ULoDOWJ6CJBQs+6KYqeDrdvBDLE0cf41hyTbx7yD2lQ3HLYUzobaOoCJH?=
 =?iso-8859-1?Q?xpIsx+pIoLDh9V+gU13ItxnuYznd24AzVJOALZWWX3zHbRdNGf+CpTILvR?=
 =?iso-8859-1?Q?2kGhTaj42AaYR2bGOXetZYOy6VPhjhhsvJIC7X1hRkXfl/vWExREzHnFlc?=
 =?iso-8859-1?Q?Q5OGzOaXS4aoXEWkN1pS897zW6jF/3mUKucwbUAYvkIKLOHij/uL4e4tFy?=
 =?iso-8859-1?Q?z3KZ/aV6OkUME5rw+qVjK0HoYmNlMgZhKgLb1zudj7FUs9OrrhTYrgaWTI?=
 =?iso-8859-1?Q?M6Xd6LhSxt94mHme3oUqCYyMo9uaCtjsVO4ZDUL+QbWPBZEk5qYuR/pe4H?=
 =?iso-8859-1?Q?LQRt83ETt4ICQRkPk5Kn+9PNk8iH/CB7HF7TYcceVakU+ttoeUptHPA83b?=
 =?iso-8859-1?Q?HjqF22IUs40jJqn1K7tgy+K8yQNxrDNDcb2W4rnN2P8VEYGuygaI2bniDf?=
 =?iso-8859-1?Q?YTfx2AXltxpp6lVmhgnQEqSB2sf2plXG06/e9CqF5ZuHWuLQQbp54N9EZ6?=
 =?iso-8859-1?Q?topoWoSpMm/JXXR5CkDFVm5YzPnWaSrMtHUayWFktf5qA8DcpWHChXDTQ9?=
 =?iso-8859-1?Q?Hu+NLJ4ECCCBYaUOwunzhojW1URp4Lr8Yo62aA5OFE9JEcE9mkJO4pHK3t?=
 =?iso-8859-1?Q?uyJiPpkABg+I2cPuRrEQsdRvzknCCi+UclNedeDYzUdu8xjbxel6O+i5wz?=
 =?iso-8859-1?Q?sGXFTkfhdFieaAPJkqB9KBK1aPDfUSA/tIoAnk4RBy8SDuUBUsrer1+avY?=
 =?iso-8859-1?Q?fi01rx6XaNrfMllcN8zx+ZAUXna3IitglKX5xWVrwCAcAtQ1RZ/zmXgB2D?=
 =?iso-8859-1?Q?l/Ou5jH5OZK/k197hnwU05/K/g8xG9rTMzl+jFsx2KV36yFEdyNGFVeOha?=
 =?iso-8859-1?Q?XxM7J/X4SZbbdF1b8VcrqQdiHC6ThAtjazdpVmjPZCctIE+l/et6UF4OfD?=
 =?iso-8859-1?Q?nLYhuEACc3SF5k9GtZPOv818VMMiN7PvioIYROmtGCAnOfaSRMtFf3WeAP?=
 =?iso-8859-1?Q?tNqilBOs7nIF7nelRqIUY6Ow69xWhJ+46pPB0ymKt0PRMI2eRyZ1lEOUi8?=
 =?iso-8859-1?Q?igkObpqUxZihV9tW2KyrklPhjLq5WHttgNS+OxgIPF8Vf90Q9wBZWOU81d?=
 =?iso-8859-1?Q?BS7UG0AdzoBwM/ASM4l2O6l6LCGDNtfHE0bIukef+AIFh17PnDpsvAjq13?=
 =?iso-8859-1?Q?tuNNmCdnlinTKSYJ6KJsExMGqQaGno1GcsyBUlw5yupsQVUto61qsLGyWv?=
 =?iso-8859-1?Q?wsZXcTQU=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB56510436CA3A8B61A4781FEB88790@AM0PR04MB5651.eurprd04.prod.outlook.com>
x-forefront-prvs: 09583628E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(396003)(39850400004)(189003)(199004)(8936002)(8676002)(81166006)(44832011)(81156014)(486006)(97736004)(7736002)(6436002)(11346002)(446003)(476003)(110136005)(68736007)(305945005)(2616005)(53936002)(6512007)(54906003)(316002)(2906002)(26005)(186003)(2501003)(4744005)(14454004)(1076003)(50226002)(256004)(478600001)(52116002)(76176011)(66066001)(99286004)(71190400001)(71200400001)(386003)(6506007)(5660300002)(106356001)(36756003)(105586002)(2201001)(6116002)(4326008)(3846002)(6486002)(14444005)(102836004)(86362001)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5651;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZlgEQcSPGQTUfjrCx6CeqTSgsM1y7qKUgDLM0l8C6SYqoltT3GUTSSDwgDtD5m4jOOXEcqsAp2NM2sIi1rd0Qyel7C7dEh2Q7WTK0H6423BLqRdT+YB7zIMcBG3l0gKdUvImpP692UQsPzvYLlZzXGhjV93U+N+4Cuvfbmr7NIUpYegeP7uB0UGYdWJ1009NIA2cYnIke+QqpHTNKd5ixb8aHcLf54yZwMaEIcxJyp1h+OrETnYhyHiz4P+uhYs9dT3H+UgDx7A5/b6ffDWZRPRyKVIm3guN+npFtvx1kLaW3MqcN8+egdkF3EtxMG1kbWFswWwLis9j+ELSIbqlaxckwpnjgd6ZfUj8L4JN+39fjlCMZMLALE5L1D6Og40Rtltf23oHgZs3GdJR6TrY+LqqRbg4GhKSSEaXop1ymCw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6348761f-7961-49e4-f8b6-08d69a59eac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 13:13:47.7133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5651
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

percpu-km is used on UP systems which only has one group,
so the group offset will be always 0, there is no need
to subtract pcpu_group_offsets[0] when assigning chunk->base_addr

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 mm/percpu-km.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu-km.c b/mm/percpu-km.c
index 66e5598be876..8872c21a487b 100644
--- a/mm/percpu-km.c
+++ b/mm/percpu-km.c
@@ -67,7 +67,7 @@ static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
 		pcpu_set_page_chunk(nth_page(pages, i), chunk);
=20
 	chunk->data =3D pages;
-	chunk->base_addr =3D page_address(pages) - pcpu_group_offsets[0];
+	chunk->base_addr =3D page_address(pages);
=20
 	spin_lock_irqsave(&pcpu_lock, flags);
 	pcpu_chunk_populated(chunk, 0, nr_pages, false);
--=20
2.16.4

