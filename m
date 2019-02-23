Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35C4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B266F20684
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IqgI783a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfBWItC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 03:49:02 -0500
Received: from mail-eopbgr00050.outbound.protection.outlook.com ([40.107.0.50]:32576
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727329AbfBWIs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 03:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9Ze09qwdhxVOM725jUjaMrvxUe0dyEHvpL1bkdoooo=;
 b=IqgI783aC/0ir4XEktlWUU3GJekgcHUi+XPnIFxi3cg4rj69TGuT2jHuq+P5+Z8mE8fLPgpkdY1kKVP6sLlPUUC+ZVHYw7U4T6oa8iEaBsb3alUW476Gb8i5PVilbC8/SdjXky1E9g08NhdB4YqEj7frupYattQ8ScVxO7bqEi8=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3855.eurprd04.prod.outlook.com (52.134.16.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Sat, 23 Feb 2019 08:48:55 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477%5]) with mapi id 15.20.1643.019; Sat, 23 Feb 2019
 08:48:55 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>
CC:     Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        "brouer@redhat.com" <brouer@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 3/3] dpaa2-eth: configure the cache stashing amount on a queue
Thread-Topic: [PATCH 3/3] dpaa2-eth: configure the cache stashing amount on a
 queue
Thread-Index: AQHUy1Sce6CSfKYA40uc+yzfmqx49A==
Date:   Sat, 23 Feb 2019 08:48:55 +0000
Message-ID: <20190223084816.28985-4-ioana.ciornei@nxp.com>
References: <20190223084816.28985-1-ioana.ciornei@nxp.com>
In-Reply-To: <20190223084816.28985-1-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0061.namprd04.prod.outlook.com
 (2603:10b6:805:2a::38) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.8.3
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 443011c1-e52a-4027-1bbc-08d6996bbe6a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3855;
x-ms-traffictypediagnostic: VI1PR0402MB3855:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3855;23:reNY8u9BNfPSeKlDGZS8KMWZi1gbU3j8FgiYr?=
 =?iso-8859-1?Q?vq1GZSPUmWBS5GPeltxAC3Sck9+3Wvh6CkWbJpNpOVaD8Q4IgePHG+2dFa?=
 =?iso-8859-1?Q?ZqJPdb2hFW2JGs1yBHREwK4lw4Y5b0sfVQq3c8ENbAronXSFI61yxQbVyL?=
 =?iso-8859-1?Q?HJEun9Ohyd2pX19NqPveJKGMgz24GLkwA566+bUeQsUnBGarK6QBUcOhDn?=
 =?iso-8859-1?Q?dNlqB8+GHZLQunaQqb9aL1DuMNp5h0JPInY/iFk9+in7PJu+Smuz1tYJ/k?=
 =?iso-8859-1?Q?r42V2+OvuWDir/cjmJAtf04BUBiWjtSMvam5InebRk0tAmWyOTF9/zsCxs?=
 =?iso-8859-1?Q?sT2dsIN5WFmZq8O4Fa+HW03swRbVtUK95HT6pAxi6g0BUj9LT3xcG+t88D?=
 =?iso-8859-1?Q?Xk2YVkhAA8eNFTCtx9BhpME4JTwuyujPG0X05bzLXH7kKI4u2Rnnp04iPH?=
 =?iso-8859-1?Q?5hQboSNUs+Qqp/abCegHwCmh+hTHZrQGEFzaB6VINY3rpIzaBbBRll2Fcc?=
 =?iso-8859-1?Q?FhnBHA8A2uq3UP6SeeMQdLeyyHeCsfwvXnSwWk5SzwNGkB4IjxMkOtZaHv?=
 =?iso-8859-1?Q?0PAlEJHHZrYg4RxmbJvIyn//OUQVP6ifDEdUYDyjDSoXYH2/JY/M+CN/aP?=
 =?iso-8859-1?Q?m/VF++B4whfXAPLt1zJLl8UdWrxSG8d04Culm8FqtqoSJ8nc6ag2yYytVQ?=
 =?iso-8859-1?Q?V34iixrnOxe37Of4gvwIxyyxf9pLd8ZN4y8isC1Zs0DXNne1WyV3cQMWKD?=
 =?iso-8859-1?Q?KyNTG0Vssdd3tGcyBRuTQgf9d2LTzMf2y56mkSS5nMUj3U3TSF2fz3C9Xo?=
 =?iso-8859-1?Q?xdKWHsSP0I06nXaretI27OGHjAavrap0M94Op6OHCJ6Ko7f1TQxdh+gi31?=
 =?iso-8859-1?Q?EF6maKQ22FnF/mlM2EuHgW9fsHp45kgUzvNH+64DdVQtL2eI3gD7bTdN5X?=
 =?iso-8859-1?Q?ZGtiEgRycTIBy00FWsaDzr56Vy4lXir/XglnioWtCzEm9RRi21qrbXS8AM?=
 =?iso-8859-1?Q?K0neyvLide/haFt8JmQx0YUhKnkkGLw7lIV6mh1XsjSk+1V92kka0Wa/tQ?=
 =?iso-8859-1?Q?Bx1QUonfqmMwwVu0yLEVYTJePS8a1K8HbDZB/QqpxQNxDwy7jx+81NPnxV?=
 =?iso-8859-1?Q?6TbrTrckKKuP4L5qAauuQy/MOcl/HZUgK2O8jnY04F8tEFp0BiB91tq9xz?=
 =?iso-8859-1?Q?Dj8XxVE/UVNWEnDIy/p/HOLt8zcGPNMMAE0JKHZ9UtJwf8GjMi2I3oXN5X?=
 =?iso-8859-1?Q?2sdSzTfM81pYaZvefIOKmJ0mGSfz/6pTeaICXUVKzTlnA7I1pGSSiXfMp5?=
 =?iso-8859-1?Q?rwEeOSHK+kIrc8XWNU7wHoXp49V5iwSD53sDPqANSPqzuFw=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB38550E0686524A3E58354F18E0780@VI1PR0402MB3855.eurprd04.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(376002)(396003)(346002)(189003)(199004)(486006)(14454004)(50226002)(71190400001)(26005)(11346002)(44832011)(186003)(2616005)(478600001)(71200400001)(99286004)(52116002)(68736007)(4326008)(102836004)(2906002)(25786009)(446003)(476003)(76176011)(6636002)(6862004)(105586002)(6506007)(6436002)(54906003)(386003)(8936002)(3846002)(305945005)(8676002)(37006003)(6486002)(86362001)(5660300002)(106356001)(53936002)(256004)(7736002)(97736004)(14444005)(6512007)(66066001)(36756003)(316002)(81166006)(6116002)(1076003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3855;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9+idEhZOFk5vqN4Uh6IvAkrJUKDSLwswtyRG0SIFdtotl9cIK4oqJmK+ZFwHOACxfERGfpzExsZF9T3P6GFHRggV7kwGqlRVMRHuS55K40Yin5bKwW3/xsr21wszbmog5Cftu72qPMvnTM3csJZPG0lMkAIflQmNOHczcN21UyPfQfGXoafopbf3VR+x4aFdiMsL6uyaFpz6RU8DZ/HOL5shmKm+e0oOpJ1SXrqyaj9ywmIcHuSr7nP3R0ovK7klH/wtW8RSOGGmWWYSjhO5aR+GetugLD1XG9eWJzp5lRZ1Z9QUcbhzgwfsZ80XJroMQ7xNOjuZWUsGZ3HL8M7fSRQOjSusVpQ4xbLMCmAZTP4KjL53iD2MH2TUocr3+/SeMDd6V6+K8538Oq/oyAyrxEIjDYid5QTuZrWqEFmD2/s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443011c1-e52a-4027-1bbc-08d6996bbe6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 08:48:53.9246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the amount of 64 bytes of frame, annotation and context data
that will be cache stashed for a specific frame queue.  Since the frame
context is not used, configure that only 64 bytes of frame data and 64
bytes of annotation will be stashed.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net=
/ethernet/freescale/dpaa2/dpaa2-eth.c
index c500ea7..3c03fca8 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -2303,9 +2303,14 @@ static int setup_rx_flow(struct dpaa2_eth_priv *priv=
,
 	queue.destination.type =3D DPNI_DEST_DPCON;
 	queue.destination.priority =3D 1;
 	queue.user_context =3D (u64)(uintptr_t)fq;
+	queue.flc.stash_control =3D 1;
+	queue.flc.value &=3D 0xFFFFFFFFFFFFFFC0;
+	/* 01 01 00 - data, annotation, flow context */
+	queue.flc.value |=3D 0x14;
 	err =3D dpni_set_queue(priv->mc_io, 0, priv->mc_token,
 			     DPNI_QUEUE_RX, 0, fq->flowid,
-			     DPNI_QUEUE_OPT_USER_CTX | DPNI_QUEUE_OPT_DEST,
+			     DPNI_QUEUE_OPT_USER_CTX | DPNI_QUEUE_OPT_DEST |
+			     DPNI_QUEUE_OPT_FLC,
 			     &queue);
 	if (err) {
 		dev_err(dev, "dpni_set_queue(RX) failed\n");
--=20
1.9.1

