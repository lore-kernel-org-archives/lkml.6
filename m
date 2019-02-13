Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93712C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6079721901
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OizWi1r6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732653AbfBMJh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:37:29 -0500
Received: from mail-eopbgr140048.outbound.protection.outlook.com ([40.107.14.48]:16099
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728873AbfBMJh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnY/qp239EOY3vBcm8BDFWUmCqHswRUXtsscN9BRC8M=;
 b=OizWi1r6BQerM4ejTHl42XuZhzEqDjogUaAKC5sqH72j+Hz2l5AWUgu5YSRYp4z+f/g1vonAeCBIcYDgRo9mep+Sr1zRF8s66Vvsei2KMdl3oDruiGYErZGqbBVGrY8Ujd2b0JLYnfSQio92y65P2P3mXle6RQD2p+h3br0/ESk=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.16) by
 DB7PR04MB5323.eurprd04.prod.outlook.com (20.176.236.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Wed, 13 Feb 2019 09:37:24 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::fd45:a391:7591:1aa5]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::fd45:a391:7591:1aa5%6]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 09:37:24 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "yaojun8558363@gmail.com" <yaojun8558363@gmail.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/3] arm64: mmu: update paging_init comments
Thread-Topic: [PATCH 1/3] arm64: mmu: update paging_init comments
Thread-Index: AQHUw3+594hgBkL8LUmsAWmiVRUwog==
Date:   Wed, 13 Feb 2019 09:37:24 +0000
Message-ID: <20190213094831.7292-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:36::25) To DB7PR04MB4490.eurprd04.prod.outlook.com
 (2603:10a6:5:35::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cfa51da-d64b-4fed-c942-08d69196dbaa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5323;
x-ms-traffictypediagnostic: DB7PR04MB5323:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB7PR04MB5323;23:HKRx29R84n/BPevZ173oXY0lSvZckSdkyFV3O4a?=
 =?iso-8859-1?Q?env5n3d8npQ+lUXkBZF/c31W5UCsBTviZXuxKdHF8UTx/QYasI0Sphp4Qm?=
 =?iso-8859-1?Q?IwFvzeEkdMRI6K7+N7AKyJMae5+L3DYdP/VXsccp8A6kZuz0+w7Nm+TENT?=
 =?iso-8859-1?Q?VmjIs+WCPMTamTmsnZv5kRn9ST7KriMeImUcmO8U2jwWyo536kaFCW68LG?=
 =?iso-8859-1?Q?VxE5150DJ0TGUpYnKzrX9nBEDtOSLGT5Mer3N+yeV3AIoJK9F1JQ918o6O?=
 =?iso-8859-1?Q?jUk6uwy1Hf9odDULM1V28Tkp3eFKSWgQN4DJUQEBseaRrJcbVBNToOKdz4?=
 =?iso-8859-1?Q?WeiJfL80puMjGPGUeEQXOfrbu+iUVzzQrMhWZDTAWkxooaX9l/2PYtxfAO?=
 =?iso-8859-1?Q?1/USTrx37uRBVuRjC1erKSFQmREu7i6+N2ehg89r+jsPH8FyvnL+A5Txau?=
 =?iso-8859-1?Q?o/Wpm4MfSWgt5XYzMm94rnIPobg+XDRi0JJnKwJULYxpmqgWB6QUSDhWUS?=
 =?iso-8859-1?Q?lqDSRdwwhUDF5EDdRn8HxKthL5LpMRjKPvx7Fk2ggwk84xn7LK72godAgV?=
 =?iso-8859-1?Q?3/NvMy8qXdGBubL+8TEhI+z/taElWr89M3q1NRfCULmLcx3T2ae6JLrjnc?=
 =?iso-8859-1?Q?VSKp3xYK4eEwXxhmEMdRuZwqTF61y1UaafeaW8GH3/EaRdkqsdfuZYSP8o?=
 =?iso-8859-1?Q?3G/PI1EYXvpHgUdyIRKJE4rk75IlPqLiIqJ8MvJY1Agf1gVQ/jRS/PZF9O?=
 =?iso-8859-1?Q?Qo1TBWfcnAtKhAOoEOTFzVjYQgun7ZDxB7QmZLFwg8WmpuL8F+yak7c5da?=
 =?iso-8859-1?Q?K9UukSi+Sr1dhjB+VBaM3j4EaAVgi99ySeFG8h7OdYYGfn1liooHGWRfTY?=
 =?iso-8859-1?Q?jkru4DqhHidDymagH1pKeKwR7+3D20jb49iNgPZAG2mpOyQTRbER4fxSr+?=
 =?iso-8859-1?Q?C+viAlaqedn0LTT4XM6POLQYjEnq1UAhOdvG56hLkw/5WNuPtQOyhEL9SN?=
 =?iso-8859-1?Q?I7s0YOwf213vCNMajnI0EQJ3b+oowmBB5E1gAfI4xBEDV9YV26Sjz9MIBG?=
 =?iso-8859-1?Q?9ICF0ErIF2xyCMrMyeFF3k07gtkezku354mCDYY14vQXSYa3NBkGdw2axv?=
 =?iso-8859-1?Q?PemGonwX0+7/ln1tjzJzz0L616jGO8AO74lghc8q6GS30bjXiRofZ0J7py?=
 =?iso-8859-1?Q?A7vYrrgHwGfzK7m609e1Z5TJmU6ep31oRO+vWYxepkYtzBvE5o4uz6/nv/?=
 =?iso-8859-1?Q?Cgev5mTPzpk1mP2MsYOKZ2mB3kPjBCtnLJ8DNBZTYs+MwTJ9zZjCfFqUIf?=
 =?iso-8859-1?Q?HqmaUVZbxdex1OpIxaG5GKc?=
x-microsoft-antispam-prvs: <DB7PR04MB53232E5817BBE2A23586661788660@DB7PR04MB5323.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(346002)(136003)(396003)(189003)(199004)(14454004)(86362001)(14444005)(2201001)(2616005)(2501003)(68736007)(50226002)(1076003)(256004)(15650500001)(8936002)(6116002)(6512007)(3846002)(478600001)(71190400001)(7736002)(71200400001)(66066001)(316002)(52116002)(110136005)(26005)(99286004)(6436002)(476003)(305945005)(25786009)(4326008)(4744005)(186003)(53936002)(6506007)(54906003)(97736004)(2906002)(386003)(7416002)(36756003)(81156014)(6486002)(8676002)(44832011)(106356001)(81166006)(102836004)(105586002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5323;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: keXuUhSCRHnjqsaDDIWPMuGZNHiftCQITUuSwktacwMfrA6mX0JpXjhoy6KtQpet9f5eVZdjFhDxY0gx2LbsiMKOlSftQfyHFTRkQU1UEtunf1OwKgUmIT3ynQCTQI8Zt/rA1AYWYI9svFmtRZ6BF7o7fub6ZvTiihEOV0795DUx0nStOWj3eUNMFcqec2glQSGmI2t5KursrYHDMIWGRfJpeGDhu9cIXOeH1qn+q8bfSuu/AIMYDLH7xTevSJ6Vm4pl/Pn0o++cPwAtX889MRJw/8kn+qQzSB8VdQFBwCMkyUKFDghzlf9RE/y0O59rvk7DOo5sfTGMcHkoEuukL5mEBfxs1O3txDuu8+07iM8pGKq0BEEQTkJuh5PHhHCTicFt2jVFp3y8GXp6gw8kgu0xMkgsQ22Eogk4gDQ3fcI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfa51da-d64b-4fed-c942-08d69196dbaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 09:37:19.8231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comments has not been changed since the function introduced, but the
function has been changed dramatically, so update the comments to
reflect the code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/mm/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d6b6f1b169bb..065202da3ad2 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -655,8 +655,8 @@ static void __init map_kernel(pgd_t *pgdp)
 }
=20
 /*
- * paging_init() sets up the page tables, initialises the zone memory
- * maps and sets up the zero page.
+ * paging_init() sets up the page tables, switch ttbr1 from init_pg_dir
+ * to swapper_pg_dir, free init_pg_dir memblock and permit memblock resizi=
ng.
  */
 void __init paging_init(void)
 {
--=20
2.16.4

