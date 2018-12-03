Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9361C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8419E20834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qwjckMS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8419E20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeLCLdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:33:00 -0500
Received: from mail-eopbgr20052.outbound.protection.outlook.com ([40.107.2.52]:21376
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726328AbeLCLc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzLlwmFFStEM5MCz3J8XQj4oqR1LTlwFWl7oZllBRE8=;
 b=qwjckMS+vW/cvEK3SbgbjLs8QaU3G1uVCMl1JMpAYQkxcUG9ym/rNWGnwticury80fBe42wwJjvqSSXVESBmfKRusg/PuMiQmOVUhU9xUpSgp+L/rm4jfHWZMJwqK+KXgVpVgTFu4iKPLKaWR/fJpUYYRnLff0gthcDzw/ZOtdA=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3491.eurprd08.prod.outlook.com (20.177.108.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Mon, 3 Dec 2018 11:32:05 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa%6]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 11:32:05 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     nd <nd@arm.com>
Subject: [RFC AFBC 11/12] drm/arm/malidp:- Disregard the pitch alignment
 constraint for AFBC framebuffer.
Thread-Topic: [RFC AFBC 11/12] drm/arm/malidp:- Disregard the pitch alignment
 constraint for AFBC framebuffer.
Thread-Index: AQHUivvRde0QVAJcak6cnHk/9XEoiw==
Date:   Mon, 3 Dec 2018 11:32:05 +0000
Message-ID: <1543836703-8491-12-git-send-email-ayan.halder@arm.com>
References: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
In-Reply-To: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0279.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::27) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.55]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3491;6:jHNyifNsUvKZpA05dI71GSSaPE+Z91lHIAu3VMmoMmHsP1b7qRV9wYpz4+VzgdIXNWttpODPX5VMp2PnLsK/+FGMcsnDTtOzQM6jv9gW8fQuUQgIB1xYp/Nwwe01+jNFE7VJ6LLNcWnWACpfnmYodWkB0kmn/YNhjtIqZoupRcxbftqOa91FiDlvllZsIg4O9St6SDWzJRoXBDZvhWzL7LnRaE02TVkLLT6sl4ar/Po6SqrjC10REfrQ59gtS+H2OxbpqFsQRHAWUkzz7aqnfl5aq0i84YFvTVv8M6V//M5+yjfIhbgvTwN4UZDKxfHVUWjzZ9Hjd13Lhe/uALLXYvopwQ8oPY4SEONmUJQxNpqLPaPwD1zGKY3wPCQ9Akkt/rZlbJMNV4BXBYU7UJrpRc2ZilNwY3t7PsZsBWuRRJ3m2paJk1u/dbsh6Bc/7yzFGMh4h4Q+SOdYJUCuwECyXA==;5:awsOQLE9lcxwpmNnT9DHSVc2sL+4QTgVUyWgyEH/wntKJqRzutXzL1eOoWPk0SByeWD3Q2LkYsiz61c1dWj7K1v66rPI9m85XL+DP4Xr3Sgt/+XTNHcChSenGMnAcc2RarhGO+ZQVo5ZuymXLMM0/qI3nPyQOu5NxDngM7+sZxs=;7:Q+ev2Iu8VYgeCKNgBrMAEJbc34mnEEDb6GtLtNZO5EX8kTXVM0COQO9in4Awzf2k3QCFJr8a4S8hf4lO8dWv6WW1pSlDyZQGJcmL9WV6ngQ/L9SJe1GkF8klNVkkRK313Uklp2hDy1OGFVgW3VCRiQ==
x-ms-office365-filtering-correlation-id: 6045ec51-73ab-4721-463e-08d65912f3c7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3491;
x-ms-traffictypediagnostic: AM0PR08MB3491:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3491D7CE1525E737961A7CFFE4AE0@AM0PR08MB3491.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3491;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3491;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(366004)(199004)(189003)(99286004)(4326008)(71190400001)(97736004)(36756003)(71200400001)(106356001)(6486002)(68736007)(72206003)(256004)(14454004)(66066001)(478600001)(7416002)(5660300001)(45080400002)(81166006)(8936002)(7736002)(25786009)(2201001)(81156014)(305945005)(3846002)(6116002)(26005)(102836004)(316002)(186003)(6436002)(11346002)(486006)(2906002)(2501003)(8676002)(575784001)(2616005)(44832011)(476003)(6512007)(105586002)(217873002)(53936002)(52116002)(446003)(386003)(6506007)(86362001)(110136005)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3491;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dr4E/Xbufg1S2KyrT6eSrvIbRAAXOGXzYWkw8iHtUlKRWh410evlJF0fAVI8lVgn1xpk/QBmWycNg9/y9ypUa2I2ibEu8+4X30KC+Ib8VqBoXNrCc9c9+ke93xZjYVAYzk/sSHpZvYzppEfIosvgIpcmcvJqIp9M33WCDJy5U/r4WK+h6gynSnRaidXW1yo9oBM4X8aImqR6jljckZunnD6dvr1ddzOeMQlOnDNKtJijImG/aKngYrBfnm3Gca8TD6rNlBCW0q1KCCRp/Su6vpqK/bjbyVKrowPdMan00aYCkfe4TPlpl1cHtEF2Fe/uJDaRdW2k3kfIKFtpQH6orS9K9+IMC61EQ2940ShG73U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6045ec51-73ab-4721-463e-08d65912f3c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 11:32:05.6122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3491
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Considering the fact that some of the AFBC specific pixel formats are expre=
ssed
in bits per pixel (ie bpp which is not byte aligned), the pitch (ie width *=
 bpp)
is not guaranteed to be aligned to burst size (ie 8 or 16 bytes).
For example, DRM_FORMAT_VUY101010 is 30 bits per pixel. For a framebuffer o=
f
width 32 pixels, the pitch will be 120 bytes which is not aligned to burst =
size
(ie 16 bytes) for DP650.

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/arm/malidp_planes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/mali=
dp_planes.c
index d0a00ee..eec0442 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -529,8 +529,8 @@ static int malidp_de_plane_check(struct drm_plane *plan=
e,
 	for (i =3D 0; i < ms->n_planes; i++) {
 		u8 alignment =3D malidp_hw_get_pitch_align(mp->hwdev, rotated);
=20
-		if ((fb->pitches[i] * drm_format_info_block_height(fb->format, i))
-				& (alignment - 1)) {
+		if (((fb->pitches[i] * drm_format_info_block_height(fb->format, i))
+				& (alignment - 1)) && !(fb->modifier)) {
 			DRM_DEBUG_KMS("Invalid pitch %u for plane %d\n",
 				      fb->pitches[i], i);
 			return -EINVAL;
--=20
2.7.4

