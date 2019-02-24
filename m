Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412A6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 09:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029E220663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 09:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dgghTv5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfBXJRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 04:17:53 -0500
Received: from mail-eopbgr150054.outbound.protection.outlook.com ([40.107.15.54]:49533
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727852AbfBXJRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 04:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/vvz0CsE6aBmqv0Tl0i1NxOnYOHo0csiozE5qVFmL4=;
 b=dgghTv5Q+sxiC4isZb7KuB3+GhKCH59TIbBBV82RbrRijQI7qPNhHnJe+aX9Ec6pA1IdcA+atN4tsOIkvTH170g8xC3a1JUwpyUWoO+/2CjurOpuZPb1GzCZE44roDsirmLW021a11KQrFXiHkl3tLS45dtRl2dzhIQUs/TPzhA=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5778.eurprd04.prod.outlook.com (20.178.118.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Sun, 24 Feb 2019 09:17:09 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185%5]) with mapi id 15.20.1643.019; Sun, 24 Feb 2019
 09:17:08 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "dennis@kernel.org" <dennis@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>, "cl@linux.com" <cl@linux.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [RFC] percpu: decrease pcpu_nr_slots by 1
Thread-Topic: [RFC] percpu: decrease pcpu_nr_slots by 1
Thread-Index: AQHUzCG3EUVkDmE6x0qXBqXQe9HUiw==
Date:   Sun, 24 Feb 2019 09:17:08 +0000
Message-ID: <20190224092838.3417-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0PR03CA0053.apcprd03.prod.outlook.com
 (2603:1096:203:52::17) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00916004-cb34-40a2-046a-08d69a38d9f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5778;
x-ms-traffictypediagnostic: AM0PR04MB5778:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB5778;23:gg7fxxfc4aSOFxGdzZYB3TlJKbxPXL4wAPeTpUc?=
 =?iso-8859-1?Q?MKP4pCbn5hnlkyHx+IaZ55Thhwhu4crzbYEYdBgrZmkBQtG9YQVEK2oXmX?=
 =?iso-8859-1?Q?aKt3dACVwB620MZA2B8ZnOxWBDZj1f9wOwLaehs7CPj0qtwGriV6mskWD1?=
 =?iso-8859-1?Q?7nkQMbzu/x++szmBZ+vJ5gKkcqDyNkMx/9DgRF4RyepUe4m4TEgOS3eJ6U?=
 =?iso-8859-1?Q?56PbZar/TIcw7PDT8J0hsFNlBYZizRF0Li++F5PDf1C2+H9GlOhw0oPm6o?=
 =?iso-8859-1?Q?ZoezH5EIznUR5MNELcIe5wz7D0Oz+l4MrRChE4MS0DUlSiXMWf44BRjXZL?=
 =?iso-8859-1?Q?OmmRpfNQ6voPt3p/S17/BuFrtvuo7+0sAMqH1prn3MBGXiScP8vmllKgoO?=
 =?iso-8859-1?Q?ZKpJgBH60bvJbU5qqTTZbI3eGZJUeuomBbiO50o5wWWqjPSuZ0O2srYpEi?=
 =?iso-8859-1?Q?4y3BkwMHIdveyeeQcCz6PNeDjjpjfTXVYU7ABG5DM5qObGuha7yGwf39B7?=
 =?iso-8859-1?Q?zgQg7nBvN7PvAjpqNil4A5ySH5iDDw4CJWjDSyDMI2DvPEgZFIsEujXmKC?=
 =?iso-8859-1?Q?1PgtoVMC+l/6U+Hq72nInP2ZdeutsvZuI1JjxvKakuvcpfwtQ0+5Dovi8/?=
 =?iso-8859-1?Q?bImVXOOgXuwezFhL4XHJq5vRtshdKKLUrnvs1lXrskqKfCbwz4H4UT2KoB?=
 =?iso-8859-1?Q?Uf90gnGfhA/sebf7p4VqmmeVlnvZRCm/DM4yQCG9GcOpuaMTvEWz8QA726?=
 =?iso-8859-1?Q?4F2m0+bBjACnTL9+Z8Q/YGdrDvd7ZL14AWPJuaQNOw687ZJ0C12WzF9s7z?=
 =?iso-8859-1?Q?TRZYCBR9mfpKsmJxeNN5L1UFnNVKc/uAJIU/HxuUKOPq0I1jui5m7SDG9M?=
 =?iso-8859-1?Q?xNABUAvgAltGisZF0WbYj00lEjfAq9fOODIp7n+kDzNaOJ4GOg3gKX+zZA?=
 =?iso-8859-1?Q?SrMguTyqN3+Ydv+AdfoUf4kfmB+ftV1xkbhldU33MyaBTqpNB8KI2yzhIS?=
 =?iso-8859-1?Q?l1hUozciqQygfe1Zmxp9fuJd+Iy1WU7tdzJ8pl482zCkYRJzxQ/oPi/Le1?=
 =?iso-8859-1?Q?LhQQp2oIR4d7tfzcY3p4aE/AYOmcBGM3pQzPWiWuYhYs8/j06/atTfKvJX?=
 =?iso-8859-1?Q?ZT0DUv/e8ozG6ehIEXQPu8/eIIJKewkXUXiFRCLLz++7zmgB4NzjGJJXc9?=
 =?iso-8859-1?Q?WKoH8JS6jByl3J7DqR3RqHGmfPxyWh3sLb04j0MtZ4pVQ/QQL2jFLwk7Fs?=
 =?iso-8859-1?Q?DRqhcv6+L1vmiSSl5OB9RSG2KXsAP0gXnttdutw=3D=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB5778E8E5480C03E1EF94C82D88790@AM0PR04MB5778.eurprd04.prod.outlook.com>
x-forefront-prvs: 09583628E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(346002)(136003)(39860400002)(199004)(189003)(6116002)(66066001)(2201001)(2906002)(53936002)(86362001)(50226002)(110136005)(54906003)(316002)(3846002)(97736004)(68736007)(2616005)(486006)(44832011)(476003)(106356001)(105586002)(6512007)(8936002)(186003)(71200400001)(71190400001)(386003)(14454004)(52116002)(5660300002)(26005)(99286004)(36756003)(8676002)(81166006)(81156014)(4326008)(6436002)(478600001)(102836004)(1076003)(6486002)(6506007)(2501003)(6346003)(305945005)(7736002)(25786009)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5778;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Uhi/87XIig0dEnPril51t8ynkQXD8ruwccAvZr+3rYCLo/vTXKcOrl4g9mv3Qv15q3t/HwM1A34dpJzvyGgWL7GZJ2EMURQ5v7RulXD3RSCup4PR9wf9b+DPapnY7j3BYnrQWSWodk1dL0xNZg6jRVdT1osydLDmRcmIKfUkn5+pNd2LZL79SyEs3vPkkVowLvUfRuUl1fRkVTaRMu0jVgZ/WzJoLu+A4BRZv+4h311YQPYJ+iQdLdHCoHVz7H9caGeMobKthBrVU06d90rk9pwFXG2tzR/635rIkDHmSUFoe/7qzXlXX0ODHKJ14ROuy+62X7j0a/CMjnB6KnVPLS6FK1/eONJHaamlpdqHmQQ7umGf3gO/eNSjyT7Y1vbgDKzyQKgF2KK4fycdwnu0vcoHOI/wCWJErS+WqnbgPIE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00916004-cb34-40a2-046a-08d69a38d9f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 09:17:06.1536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5778
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Entry pcpu_slot[pcpu_nr_slots - 2] is wasted with current code logic.
pcpu_nr_slots is calculated with `__pcpu_size_to_slot(size) + 2`.
Take pcpu_unit_size as 1024 for example, __pcpu_size_to_slot will
return max(11 - PCPU_SLOT_BASE_SHIFT + 2, 1), it is 8, so the
pcpu_nr_slots will be 10.

The chunk with free_bytes 1024 will be linked into pcpu_slot[9].
However free_bytes in range [512,1024) will be linked into
pcpu_slot[7], because `fls(512) - PCPU_SLOT_BASE_SHIFT + 2` is 7.
So pcpu_slot[8] is has no chance to be used.

According comments of PCPU_SLOT_BASE_SHIFT, 1~31 bytes share the same slot
and PCPU_SLOT_BASE_SHIFT is defined as 5. But actually 1~15 share the
same slot 1 if we not take PCPU_MIN_ALLOC_SIZE into consideration, 16~31
share slot 2. Calculation as below:
highbit =3D fls(16) -> highbit =3D 5
max(5 - PCPU_SLOT_BASE_SHIFT + 2, 1) equals 2, not 1.

This patch by decreasing pcpu_nr_slots to avoid waste one slot and
let [PCPU_MIN_ALLOC_SIZE, 31) really share the same slot.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 Not very sure about whether it is intended to leave the slot there.

 mm/percpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 8d9933db6162..12a9ba38f0b5 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -219,7 +219,7 @@ static bool pcpu_addr_in_chunk(struct pcpu_chunk *chunk=
, void *addr)
 static int __pcpu_size_to_slot(int size)
 {
 	int highbit =3D fls(size);	/* size is in bytes */
-	return max(highbit - PCPU_SLOT_BASE_SHIFT + 2, 1);
+	return max(highbit - PCPU_SLOT_BASE_SHIFT + 1, 1);
 }
=20
 static int pcpu_size_to_slot(int size)
@@ -2145,7 +2145,7 @@ int __init pcpu_setup_first_chunk(const struct pcpu_a=
lloc_info *ai,
 	 * Allocate chunk slots.  The additional last slot is for
 	 * empty chunks.
 	 */
-	pcpu_nr_slots =3D __pcpu_size_to_slot(pcpu_unit_size) + 2;
+	pcpu_nr_slots =3D __pcpu_size_to_slot(pcpu_unit_size) + 1;
 	pcpu_slot =3D memblock_alloc(pcpu_nr_slots * sizeof(pcpu_slot[0]),
 				   SMP_CACHE_BYTES);
 	for (i =3D 0; i < pcpu_nr_slots; i++)
--=20
2.16.4

