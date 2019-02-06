Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660E3C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A762184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gYtaO/R0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbfBFLwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:52:22 -0500
Received: from mail-eopbgr10069.outbound.protection.outlook.com ([40.107.1.69]:62276
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726750AbfBFLwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PxwKeGPwGbTG10grj0H6t2OYo81lHbAk9I505525JQ=;
 b=gYtaO/R0ZDl9jDU7hlRI9ChC9oKUen7WKiGupV5s2xXYVx3YgbkoKjoI505h2iv9975VK52WJUC1aX491U4WCfg6vWFVsxzxqEFe+L59Uez4QMB9+Zg3AiAP5TWGy3Z0TOHX7I8cvi6DriQF6Ea8XNjvkF/hR2YhhbdJQUjtcaI=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3743.eurprd04.prod.outlook.com (52.134.15.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 11:52:01 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477%4]) with mapi id 15.20.1580.019; Wed, 6 Feb 2019
 11:52:01 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 4/7] staging: fsl-dpaa2/ethsw: Add ndo_get_phys_port_name
Thread-Topic: [PATCH 4/7] staging: fsl-dpaa2/ethsw: Add ndo_get_phys_port_name
Thread-Index: AQHUvhJej2fG9BHR30qEtZIFl6ZDsg==
Date:   Wed, 6 Feb 2019 11:52:01 +0000
Message-ID: <1549453888-24593-5-git-send-email-ioana.ciornei@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3743;6:WWtwDUKtCuT9uS0hhhKAZRLG2mHM3jIN95ba/yLAyKNsN/HEVmEVTlx+nljL12RicPyUdHfiqqd1h+X5L3yOBtpe96krCdtc+RUQNpv0kyzy5xossAetzzkcyJeNdxLw5Dj9I0S9LvNmUfFajsm4LvCuehnAF3RJCFVI1fviMelShAi2i4MxH48X72QguqftwfAWu9oLAsNxPCdtz+8O4Lo+o58DBp/o0QvJVWWUC/aH19OgOz61TOTpXntMhEXxXOCE8NkTpeKryU6gmOPbX0ysCB0MtgBr2ToymTAwSAAQZaKhBv8XzbJjA5j+/9CkTZpUHSa6olki3lh4+iOi08G5UWtAD8Q6W9ShfpibRPFsGKVoSO+No0/w9Xs3h/Ab9mP402rJTG5dF7CRDegkVwm8v+ybbh4lKTQEm4Ph09gaHVg1Lon9fo7EgcjP3nYwAqzIvZ0JvZo6ZPs3j0KEeA==;5:/B/MpCFG5EwtQ48TDaaj+fum03tdVNErx//p3UP7vEsMGoV5XPw61W4JncGJ8kE9E/P3pSBmxIzeqF6ut07yO4gJQUDJ1Aq76Z8X928/PwVyQPG/f2BObKzvqzLb0H3IFstco/QB+wZBL/aeJxDwo7MQdiOzXak7O6KYCqhmEDVKNwFBMnPxTmwuP+ZHeLZYaIHsaqCiQd574RLCyt2Efw==;7:NOOmbr4gX6pBIYOzMq6Fx/Ju4H++sBXW76xlLGUvWkfT75TidwuFVZdl1tKVkpGft3mq8nC8Z/E2G3gKiEUTZMBIdqI5qCAOWLBrbjPJKIldR5H5jiPPy5vnDbyApA6DpwnOTFwFGOmGc5QmRgeFXQ==
x-ms-office365-filtering-correlation-id: 6c17dc58-2f88-429c-bf0c-08d68c298134
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3743;
x-ms-traffictypediagnostic: VI1PR0402MB3743:
x-microsoft-antispam-prvs: <VI1PR0402MB3743018E3B05D90752129F02E06F0@VI1PR0402MB3743.eurprd04.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(39860400002)(136003)(376002)(346002)(396003)(189003)(199004)(256004)(6486002)(386003)(6506007)(486006)(53936002)(68736007)(102836004)(478600001)(86362001)(2351001)(14454004)(105586002)(71190400001)(71200400001)(2616005)(11346002)(106356001)(6436002)(446003)(26005)(476003)(4326008)(305945005)(186003)(76176011)(7736002)(81156014)(97736004)(99286004)(14444005)(44832011)(5640700003)(54906003)(8676002)(6512007)(36756003)(1730700003)(81166006)(316002)(3846002)(2501003)(6916009)(6116002)(25786009)(50226002)(52116002)(2906002)(66066001)(8936002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3743;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DQX7PT5gOkSgJ59zoFtLHeT5i3BIA0I+88RSRXHd26tqKZxlKs6WZK6FMVfnycRQEyUM6ZxHQloLeyeu7ueB8r1BLQShZ9HHzBTdM4IM3bbgca1I8Ng8szhm3jKxyd4CxZAVLbS+/UsxKBm6NoV8mQYDLjsWSkZdJeakM0pfjZpzcshyl0XBq96jf5Ort18DqKdKe4irDs1qGkHbf/M0ShVyxmUupnLYihVJujq5eBl3NSKqL4n1Ckr0Y4JJqiKCXL2mKuyBdI8VLstmTmS+Qtv6lNXDqnM+y0FDFLV3MBk1w86bK+j5OOhnzFJpqvp+ZaOvU9+wLoJgmpjGV4WGlKDbKbWKR+v500h+RHXzlgCj+A9pY0IaoQoTZ97czI9p1S0nU9X945QmeqXQ34wcdND0AfusNeXYxK8xay/riyU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c17dc58-2f88-429c-bf0c-08d68c298134
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 11:52:00.7618
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

Add the ndo_get_phys_port_name callback to the ethsw driver.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-=
dpaa2/ethsw/ethsw.c
index fa3af4a..f179fd0 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -505,6 +505,19 @@ static netdev_tx_t port_dropframe(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
=20
+static int port_get_phys_name(struct net_device *netdev, char *name,
+			      size_t len)
+{
+	struct ethsw_port_priv *port_priv =3D netdev_priv(netdev);
+	int err;
+
+	err =3D snprintf(name, len, "p%d", port_priv->idx);
+	if (err >=3D len)
+		return -EINVAL;
+
+	return 0;
+}
+
 static const struct net_device_ops ethsw_port_ops =3D {
 	.ndo_open		=3D port_open,
 	.ndo_stop		=3D port_stop,
@@ -516,6 +529,7 @@ static netdev_tx_t port_dropframe(struct sk_buff *skb,
 	.ndo_get_offload_stats	=3D port_get_offload_stats,
=20
 	.ndo_start_xmit		=3D port_dropframe,
+	.ndo_get_phys_port_name =3D port_get_phys_name,
 };
=20
 static void ethsw_links_state_update(struct ethsw_core *ethsw)
--=20
1.9.1

