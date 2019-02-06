Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCA1C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C8D2184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IKuUIU4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbfBFLwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:52:09 -0500
Received: from mail-eopbgr10069.outbound.protection.outlook.com ([40.107.1.69]:62276
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726750AbfBFLwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbBabJuvicYwHlfXSqD/F+Nd/LVAYMsGzLnx1Zxd/2I=;
 b=IKuUIU4/XZWv/+9CugRu0YIlW0V+nz464zYWhULGgZm//awDDQHWavKajkjmKV4Uwyz9My3OiEfAvkxXSHuvuETQjnAOzqIirIF+PRUWRTt6tyjZprrS+gTvsu8bauROubxb6AFkQK0KtA5cYuplgIfqjrJxrI4PqtVawxBEVWY=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3743.eurprd04.prod.outlook.com (52.134.15.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 11:52:00 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477%4]) with mapi id 15.20.1580.019; Wed, 6 Feb 2019
 11:52:00 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 2/7] staging: fsl-dpaa2/ethsw: Add network interface
 statistics
Thread-Topic: [PATCH 2/7] staging: fsl-dpaa2/ethsw: Add network interface
 statistics
Thread-Index: AQHUvhJewM6lQt23ekiGUBAs/XaFAw==
Date:   Wed, 6 Feb 2019 11:52:00 +0000
Message-ID: <1549453888-24593-3-git-send-email-ioana.ciornei@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3743;6:WVXVqOgXIMcOwVghHoML1DhzvUNHNEjGpuC5zaQa1eWrRZvwoax+0/Cx0lCiVz9g0N9nZTWJk16HBXHtqfFdFxEVijGQMQJuxS5JRkPJF51CKT6mzrvdwCe6mT+e/Ysof51Yr/0kIUEU+070tSZeW/HDnRpczZPwNYjlkJCFgBI7mF6FNZcr3eVfyiuteZzteea4UKNzVVammgsd7s2V3IwC0FGoTRylUuGvD8FwMnf4/iJCjdauH/zCIUgbrWF0uPjlM7Ck2tWtMu3WtYpxevXWx1FBn8LhTG0axQtQiIhUU6vh9cPp85UEb4gHiKGO+LMsKs64QVUl/tlw1PSHpXJhSD54v64Tpgt/lPZDzPPWuuJCPgLw2heU2DjOVzJgHTpTaVQBZpMVqsCIaOpkLSD9da3RIEGrcO2i6lKBc+P0x2iWVIN4Hw8fyHq7mQPKJe955lO0knfFZJnfNw06Hg==;5:KeHxdyrkQT4xGIZol2ZSko4iyCVR8JT04qoOMTwPWhCKoBGns6vpx3zuY01w1rx/Xl6liHtj6Oe+2/OSy1KYPm4hPsOvc1tS7vWcz7vlkvqlSXrAmgf8w734vyd0Ter3uc+pLbfD+l8M90ha3msTge7jOM+RtmIwGiqOaLomAsjjvabfnHngjN4Pmbq7Nz5XfJlB9Djwx+g31G5yAzcnmg==;7:azyDXgQPOPuJNHtiKAuSDydgnrM9I//iLj+sRVYHMzO33afGBdLYRBTZ9H4O+ywK2rX2tvH6R5lih6q5ZSOmjrmD78UcxxHjgehPnSZhNBEiI9aHy6Ct9K1mPpWenm6dBnZ0UM1d5JzcsENzqx2cNg==
x-ms-office365-filtering-correlation-id: dd7997fd-5b68-4062-498a-08d68c2980ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3743;
x-ms-traffictypediagnostic: VI1PR0402MB3743:
x-microsoft-antispam-prvs: <VI1PR0402MB3743614C470B235FC2653AEDE06F0@VI1PR0402MB3743.eurprd04.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(346002)(396003)(189003)(199004)(256004)(6486002)(386003)(6506007)(486006)(53936002)(68736007)(102836004)(478600001)(86362001)(2351001)(14454004)(105586002)(71190400001)(71200400001)(2616005)(11346002)(106356001)(6436002)(446003)(26005)(476003)(4326008)(305945005)(186003)(76176011)(7736002)(81156014)(97736004)(99286004)(14444005)(44832011)(5640700003)(54906003)(8676002)(6512007)(36756003)(1730700003)(81166006)(316002)(3846002)(2501003)(6916009)(6116002)(25786009)(50226002)(52116002)(2906002)(66066001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3743;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xStc9Z3DYzAKcy66ZhaFY6qOnqa3L6WXbksSwNHP+Q7X+W4dqBXvNMrarjZPS1dVcsCxNsDOusyflRRWwfonuy0ouJu2hUVzat/LtSbaOnCcKmR6IfurLF28b5Yx3FfYTM8+HyZIB4eSiPlcapsqKV7wzpAq9NdL1hR/t1yhaeQc1WSLYnchX/6MZ/bnpA/TvM6iDx+45Zl0BfHWsRB1bdwOTI5DmiOl/WgEiqLK6kVj+6RXmwlAbsNq6tJ/3ao+KIQ+prtc+vg2uiLEFdENjXIw8M8pM0yxodfXT7mzLNC7ZoJafvHCPYh/nnO8BM9rbga5GZrNVqvyJC/VKtWx7y4EvV2PaIGT4eDgdD+bCW2E3ZhUB992OknjnLYv01VCvwUEuuT/WsiqMlIpDCy1kB71/wC3B2i3yeYxCzAmATA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7997fd-5b68-4062-498a-08d68c2980ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 11:51:59.8750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3743
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Razvan Stefanescu <razvan.stefanescu@nxp.com>

Allocate MC portal with atomic context for I/O and enable network interface
statistics for hardware counters.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-=
dpaa2/ethsw/ethsw.c
index 9463e05..d15d03b 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -510,6 +510,7 @@ static netdev_tx_t port_dropframe(struct sk_buff *skb,
 	.ndo_stop		=3D port_stop,
=20
 	.ndo_set_mac_address	=3D eth_mac_addr,
+	.ndo_get_stats64	=3D port_get_stats,
 	.ndo_change_mtu		=3D port_change_mtu,
 	.ndo_has_offload_stats	=3D port_has_offload_stats,
 	.ndo_get_offload_stats	=3D port_get_offload_stats,
@@ -1468,7 +1469,8 @@ static int ethsw_probe(struct fsl_mc_device *sw_dev)
 	ethsw->dev =3D dev;
 	dev_set_drvdata(dev, ethsw);
=20
-	err =3D fsl_mc_portal_allocate(sw_dev, 0, &ethsw->mc_io);
+	err =3D fsl_mc_portal_allocate(sw_dev, FSL_MC_IO_ATOMIC_CONTEXT_PORTAL,
+				     &ethsw->mc_io);
 	if (err) {
 		if (err =3D=3D -ENXIO)
 			err =3D -EPROBE_DEFER;
--=20
1.9.1

