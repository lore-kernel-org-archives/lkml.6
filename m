Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DECAC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2263020B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o/yELe4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbfBFLwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:52:31 -0500
Received: from mail-eopbgr10056.outbound.protection.outlook.com ([40.107.1.56]:41348
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730139AbfBFLwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8ugd+EHEWDJCUThMlH057rjhrMQ9jj+GfmzSKtIVw4=;
 b=o/yELe4Hc/AwjnWqcCmzOhyPBoznfQqiRK9o0rPSlUBtdUa2qdGaHx8W1l0GyD2NGD10KlBKHhsu1B3dWc+lPeBBVx5Mhn+7+q5fx6jHkazfEnwNsIaNAck3P6PDCjlkeQsKevXrt3lZ0fThNMEvVaEQSsPHnLdAFMTLLxn84C0=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3871.eurprd04.prod.outlook.com (52.134.16.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 11:52:02 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477%4]) with mapi id 15.20.1580.019; Wed, 6 Feb 2019
 11:52:02 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 6/7] staging: fsl-dpaa2/ethsw: Add comments to ETHSW_VLAN
 flags
Thread-Topic: [PATCH 6/7] staging: fsl-dpaa2/ethsw: Add comments to ETHSW_VLAN
 flags
Thread-Index: AQHUvhJfhP9X5VgXGE6isxNlyQx30A==
Date:   Wed, 6 Feb 2019 11:52:02 +0000
Message-ID: <1549453888-24593-7-git-send-email-ioana.ciornei@nxp.com>
References: <1549453888-24593-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1549453888-24593-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0259.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::32) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3871;6:gKslv4JrZa2oRjX9w8/krAzjvc52hNGNe/AxJmHRjqW8IiO7Et/lkdYTPk5IE4LKviPGRK072YbdWYEh0vjyxcfDGFQlq0X5ChaX+C4EhUBz3HNq28jzg8MbRkIzEyXvqZ9CZdz0HDVq7NGrMcWIOcWbVB4M3kWN38gSsBonCoTIAeWE5lx/nMimk+lM9obxAop0vFuW11aLouMC4qLqRNUP2Vvanuozp69bnjhtm4A8UdynKY4A1lyjVctbSww0l5Uh3ROonGh8gMi97KMiQi5f7I/7mxfkEdMXY2907Dicnr3bTQTn+rXAvTsB+0Ty9l7WLHEDPhuPTcG7WtJ4JgI9igm/0P7qFmOKOQ9ikhAyZVDp5ArzdoOun2j/hp6mFrNyc/0XrlzrtEyQI9F/cP88+e3ZdFe9rQ9gPs847yJTIT3pd830TQu0EVDHYqXdbI9lb8GNmrkmVm+UDxC5ag==;5:occaS4ad0dadgkzflZsc1Yx0+cpAnmbQiFLjLO2ZfkztMXOY3VU8cP/BVu7E9ZwK6Okv6dInBFQB+WDQSX8k7VcKocHsBlYi350C/Ddp2AmPyRVOSbC0cbc6vR+gwa1g1mt8wa/0JyK9N6NA+brySMNM57OA44OfLdnOTxpOw2GZ0Up2/9p72IaYfu7Dsim2rRiL8knOE2NxF6kKW2qVww==;7:knt7DjTuV5QVPdj/ur+tdsOjgSp3KP5j67nYjsopkk3BOUkAxuYC1LkG7BifBYjYBoo2J3RB9K5O15eqEPyMAgNYpKdglgc75Avc+tnTGQDknyQfzlffiX16YCnIJ6xK7YBf0y4HNSz/uv6J5DNy+A==
x-ms-office365-filtering-correlation-id: 36564092-1e94-4dfd-bb79-08d68c2981bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3871;
x-ms-traffictypediagnostic: VI1PR0402MB3871:
x-microsoft-antispam-prvs: <VI1PR0402MB3871AEA9A18A66C46D07A089E06F0@VI1PR0402MB3871.eurprd04.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(366004)(376002)(199004)(189003)(71190400001)(71200400001)(86362001)(36756003)(6512007)(66066001)(6486002)(6916009)(50226002)(478600001)(5640700003)(2501003)(14454004)(4326008)(53936002)(6436002)(25786009)(68736007)(54906003)(105586002)(316002)(52116002)(2351001)(106356001)(2906002)(305945005)(7736002)(99286004)(2616005)(256004)(446003)(76176011)(26005)(97736004)(486006)(476003)(44832011)(102836004)(11346002)(81156014)(6506007)(6116002)(386003)(4744005)(3846002)(1730700003)(8676002)(81166006)(8936002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3871;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hkpc/S045MEwYFds6EYuHqJmSCR7DzdBfa6lkQV3dNZ0LBVbZziumdLT9AZjwgXqwE9Z+nbrStykwgveSAMobzo6lmWMP7AJ0Dyw4eUUlPgGiMkz1KC+GfcfsEc/fZ77KzZxcmW+NT86hcv0iG4R2GeDgCo9m9t3mwm9sQo/fABr6+5i3rs2pZoJX5uTW5dxwznex/heXywj+W4gcHXKwvTGQs3B4RNrQHnpLI4vbg9L2+Tw3Q/bLaulb7tkMmBCs+Im2OMvGP0FFaazHdW6uF2CV4/AlD2rlqPnxjw2QpI/se1vDrI5/T172AD3WZ2SRzaahoxEBdTzTWiWjvP4jW9J1zqCKVUsU2tlWvJ+cItZnk9nWEQmGTu99sLzcTQPJgNshcCMPpKrQK9duJXnsmx9bFUjzVnqLGhy6YmGxDM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36564092-1e94-4dfd-bb79-08d68c2981bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 11:52:01.6565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3871
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Razvan Stefanescu <razvan.stefanescu@nxp.com>

Document each ETHSW_VLAN flag with the appropriate comment.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h b/drivers/staging/fsl-=
dpaa2/ethsw/ethsw.h
index c487836..3ea8a0a 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
@@ -23,9 +23,13 @@
 /* Number of IRQs supported */
 #define DPSW_IRQ_NUM	2
=20
+/* Port is member of VLAN */
 #define ETHSW_VLAN_MEMBER	1
+/* VLAN to be treated as untagged on egress */
 #define ETHSW_VLAN_UNTAGGED	2
+/* Untagged frames will be assigned to this VLAN */
 #define ETHSW_VLAN_PVID		4
+/* VLAN configured on the switch */
 #define ETHSW_VLAN_GLOBAL	8
=20
 /* Maximum Frame Length supported by HW (currently 10k) */
--=20
1.9.1

