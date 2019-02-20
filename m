Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D590C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26EEE20685
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="RxNbtJgD";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="jCuZSHdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfBTLDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:03:13 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:41412 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727876AbfBTLDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:03:08 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KB03Gl012056;
        Wed, 20 Feb 2019 03:02:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=EASPNoBKi6Ks4AV8MelgOXLZSCDsc3PeCFHJjtcArk4=;
 b=RxNbtJgD6hkaUtNVCIH7MjG19irLSQQbFgz/VxHDc8gZERsAGQJyikqKAd8YEMdcTd6P
 p0OLFraTYx8n+wS6fBKEOrkW6MQ7w9BO5tKvA0p6ROkr1Jw2RRmdnz2IavMmKlQ92VHY
 aPcG8r2oamie50fgYQtUsob2Qy3z8+aK+DjALOQn196nHWddMwL13xXKnw7faCE9r2j9
 h1MG8JwNFm21YbIbA7J2xn2lkdW9r/vBnQbjbNPxMRsO6r2Y4Gmk9XMrGfduO4Fdg27V
 1LGFcT1cJH3D8VvC4SX2yXyLYIO4bPTCmu50GsArVXpTjYOb8E8LOsCv6RhLS8rR4YRH RA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2qrh8xbr2d-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Feb 2019 03:02:48 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 20 Feb
 2019 03:02:47 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.58) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 20 Feb 2019 03:02:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EASPNoBKi6Ks4AV8MelgOXLZSCDsc3PeCFHJjtcArk4=;
 b=jCuZSHdVdtkXpbdRSyjv8itlhZUp1wlA+5aj4JrnoW5S/otZXoGLz4I4UHvH6yTXWTHFUpCQ56ghLMOE3//ZXb+BXBAQqGZHHmvvsSP0sjr6slGig/44kFX1hMK6MC6xbtcIgiCgeN4jRGkBmC3IfjUleTrH6I8ona2f0XQnFho=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.183.147) by
 CY4PR18MB1350.namprd18.prod.outlook.com (10.173.247.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 20 Feb 2019 11:02:43 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4%4]) with mapi id 15.20.1643.014; Wed, 20 Feb 2019
 11:02:43 +0000
From:   Vadim Lomovtsev <vlomovtsev@marvell.com>
To:     "sgoutham@cavium.com" <sgoutham@cavium.com>,
        "sunil.kovvuri@gmail.com" <sunil.kovvuri@gmail.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "dnelson@redhat.com" <dnelson@redhat.com>,
        Vadim Lomovtsev <vlomovtsev@marvell.com>
Subject: [PATCH v3 1/8] net: thunderx: correct typo in macro name
Thread-Topic: [PATCH v3 1/8] net: thunderx: correct typo in macro name
Thread-Index: AQHUyQvNmcxOkf8tTkOLLfX41R6xXg==
Date:   Wed, 20 Feb 2019 11:02:43 +0000
Message-ID: <20190220110225.9497-2-vlomovtsev@marvell.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20190220110225.9497-1-vlomovtsev@marvell.com>
In-Reply-To: <20190220110225.9497-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b82b3ac-3705-4f9f-3fba-08d69722f07c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB1350;
x-ms-traffictypediagnostic: CY4PR18MB1350:
x-microsoft-exchange-diagnostics: 1;CY4PR18MB1350;20:j2mvD8aUsqrPjQSRtPKirTV0wJT80HVTSzBwANq1LpREA8L4HGgU9oUHKRDE0fsqZkPWWk0SZimEweypjuis7vD5ERQ0v3St4e7gO3vR2WkGuJcFygnZRkbrps+XC6Ko77aKJcDtkFHVaBTFM2aG/+HG6x1oj5k+OZPpnYT8bbg=
x-microsoft-antispam-prvs: <CY4PR18MB135063A21B0711351113D766CD7D0@CY4PR18MB1350.namprd18.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(86362001)(97736004)(478600001)(476003)(11346002)(2616005)(68736007)(446003)(6512007)(5660300002)(256004)(186003)(99286004)(14454004)(76176011)(2906002)(36756003)(6486002)(2201001)(102836004)(6506007)(2501003)(6436002)(26005)(316002)(8936002)(305945005)(7736002)(25786009)(1076003)(53936002)(71200400001)(54906003)(81156014)(4326008)(110136005)(106356001)(107886003)(66066001)(81166006)(6116002)(8676002)(71190400001)(105586002)(3846002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB1350;H:CY4PR18MB1112.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 432vTtXEphtQwjdYMggkkcQ/hk7ikD7E0Q5tF4G0YJJcUNY2lYKRlQEcXiYAA8YCrSCF4u8RRQaeSA3c3vryfvkFH3ClcQ465+QOTdc6761aWOXEVw/HQMoENC0rTg4QHb2JBKjCgASxfWiViJRZB1FLXIHNFbJ34gegJDfUL8g9666xDUvBHPwOWGrLs1MaqY9jDkTcTwKEXlVQNuOyVr6iVeslGnpf+NxET1w2e1zW3BZL4XR43sKxM4v0AA+ct5Ros7vOfiHfLYnHjazs4AFurDmeBKndb5nwbbhubnJxMS2nZ0YWg76/QYxbhl2OGMb7iZZmHQJEpR33d3m7B2dSQNsGNUXl1fVAvHYj6K9F6hFsMsCEwW+lIISuxSGKBvtnaw3VvddcJWzfHi5Unaax4Y9Kx/IbVqZKXQkoq3c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b82b3ac-3705-4f9f-3fba-08d69722f07c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 11:02:43.1864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1350
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_09:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=763 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct STREERING to STEERING at macro name for BGX steering register.

Signed-off-by: Vadim Lomovtsev <vlomovtsev@marvell.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 2 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/ne=
t/ethernet/cavium/thunder/thunder_bgx.c
index e337da6ba2a4..673c57b8023f 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1217,7 +1217,7 @@ static void bgx_init_hw(struct bgx *bgx)
=20
 	/* Disable MAC steering (NCSI traffic) */
 	for (i =3D 0; i < RX_TRAFFIC_STEER_RULE_COUNT; i++)
-		bgx_reg_write(bgx, 0, BGX_CMR_RX_STREERING + (i * 8), 0x00);
+		bgx_reg_write(bgx, 0, BGX_CMR_RX_STEERING + (i * 8), 0x00);
 }
=20
 static u8 bgx_get_lane2sds_cfg(struct bgx *bgx, struct lmac *lmac)
diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.h b/drivers/ne=
t/ethernet/cavium/thunder/thunder_bgx.h
index cbdd20b9ee6f..5cbc54e9eb19 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
@@ -60,7 +60,7 @@
 #define  RX_DMACX_CAM_EN			BIT_ULL(48)
 #define  RX_DMACX_CAM_LMACID(x)			(((u64)x) << 49)
 #define  RX_DMAC_COUNT				32
-#define BGX_CMR_RX_STREERING		0x300
+#define BGX_CMR_RX_STEERING		0x300
 #define  RX_TRAFFIC_STEER_RULE_COUNT		8
 #define BGX_CMR_CHAN_MSK_AND		0x450
 #define BGX_CMR_BIST_STATUS		0x460
--=20
2.17.2
