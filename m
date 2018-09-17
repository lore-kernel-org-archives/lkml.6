Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF95ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DD72147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lu4m8jzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DD72147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbeIQIac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:32 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:18657
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730549AbeIQIab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjaKqpySGZhMf5q2CIQNAu44eRFr2RYeBQnHOL5ZCNA=;
 b=lu4m8jznwKWuvtnEBX1b4AvNQOq/5JmZ6MDDeHw9lQGccgvXnkPEhHQwDPl5VhvSUq8aZTuWmp2V1ckz0ydvH6AuGOuJKzo91CLocyk4SJNLosTvjbTjWn3PsQ/1azz/D7nDbtWoIOLWk512kLCp1NQ2xa0tAKS6KLOFj3dUyh4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0133.namprd21.prod.outlook.com (10.173.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:05:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 84/87] Input: xen-kbdfront - fix multi-touch
 XenStore node's locations
Thread-Topic: [PATCH AUTOSEL 4.14 84/87] Input: xen-kbdfront - fix multi-touch
 XenStore node's locations
Thread-Index: AQHUTjL7dhZ5UbXKyEyu4+UQVvwLPQ==
Date:   Mon, 17 Sep 2018 03:03:18 +0000
Message-ID: <20180917030220.245686-84-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0133;6:I+m9wNDGdMqIex1XGP2Bp6fUyfJYexU3QyBGT+nvxJEte5pe0r9zURHKAlCIduZoiOcNcS2Z4thsjjmzq9CgGGxgC63KC+BSlM7n3dbskwnM4XkMj45eqcyZt44hUyboHvmv5R3tv6C86SY78Exv2O3VCjYXH6XiXWd5ipZbnHQTWw5GuXhZuQz8CeFjv6LsgVQus+dTTmk2qXgeFc/0dhygPKRWRNAChUp7JbRoHxTx0aTiUBOFh+qEOwjKTVAC7SnVaS8IysJ0bOri4Jj4N3Y6xKNFz9ejFTxpWpl8AWXu6fl3f0TGQX8zLWSLKcPquycVIRXBB8KApjoFg1udD6gIf/94dpXTfu4HulatO2GV0NNjJalHvbfmttEZDzHFh9h5GmvCyANWa/dddbNtElx0NOZWk5uuvu9kOsK/RGQBbmIZr6gDNDkxnDOnPtP+Ub6qjAEuSPYxFVSDPpT3wQ==;5:kMF6fj8ptVJUVaVLrFqFSU/ip9nG3E+KqmbU1+RbFXZNsXAisUfIct568qUx/dMkiAZ6/kSVYqa3N+um+0alcPcfp+zRNbIYS5TerPbOIof3BwCzdEHvg+4G/i5Qrrb3QfQf9pVNLBuo7r6hpLMimzzptAXzRBpPWHOX4FLS5ck=;7:/eUDtbnY1O4/06sV6nsXNKo4W8bONldAMJcyayJWvOFVtYCKaL9WWY/xDaxM5MOTsgwnExeLc6ciA3pqXEcXaqYUdNgkfo4ZqAixOnGbbPZryvWIdE2F/mtP7kCxR5klc2uQbcYT/P4U45Gmyn8ammhi+qqS/fiQiWprxgeQXQdqrG1XJ9CIxGU+Gw7XQKo7sBpqZWK4gJT53m6UnQInqm8Z5XID6AsopLvitfDhUxAdZG5HLh+oM1af5fdY13TK
x-ms-office365-filtering-correlation-id: 3503470f-d628-472d-21be-08d61c4a5d68
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0133;
x-ms-traffictypediagnostic: CY4PR21MB0133:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01330EA789A2EFCF8302D924FB1E0@CY4PR21MB0133.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(4114951738403)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0133;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(102836004)(53936002)(8676002)(486006)(476003)(3846002)(6116002)(76176011)(10290500003)(97736004)(217873002)(256004)(5660300001)(107886003)(6506007)(478600001)(39060400002)(110136005)(2501003)(10090500001)(305945005)(7736002)(446003)(11346002)(36756003)(2906002)(1076002)(22452003)(5250100002)(2616005)(26005)(316002)(106356001)(25786009)(68736007)(86362001)(14454004)(72206003)(105586002)(99286004)(6486002)(6436002)(6512007)(86612001)(6666003)(81166006)(81156014)(186003)(2900100001)(54906003)(8936002)(4326008)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0133;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MgOcFQD5tyf42nxGGIFQNLP9ANFGZm6pK4ISbEfMIzDK7eOedcq50rBOxO8FNt1idfEfEFMgSgZlPCOZDAT9v5fMT6XCMoRbKqmbmDsgSaUlUe1D1Vuuny+FpweZGzJ6P60T8sZ5XVSGkPzFqMa1Cg+O46sF/q2COQErt0pcnXqEcRV2p0HG5/EaW0j1DYxA2E96UuAaERxLNiSIlgpkeAA5ZouGrSFjVMCywUdlB1G1NsgBbT93WNCzowP0uqp/briI1ZWsq/7dSwIlQp7Kk6nGLaRfz+AQzZnd89j+M3qgfnHynVjaLfdSRhH5gzQigma47fU1SsAXgneg0iKl634aR3+RC/JI3mfWn5/hW4Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3503470f-d628-472d-21be-08d61c4a5d68
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:18.1808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

[ Upstream commit ce6f7d087e2b037f47349c1c36ac97678d02e394 ]

kbdif protocol describes multi-touch device parameters as a
part of frontend's XenBus configuration nodes while they
belong to backend's configuration. Fix this by reading the
parameters as defined by the protocol.

Fixes: 49aac8204da5 ("Input: xen-kbdfront - add multi-touch support")

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/misc/xen-kbdfront.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbd=
front.c
index d91f3b1c5375..92d739649022 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -229,7 +229,7 @@ static int xenkbd_probe(struct xenbus_device *dev,
 		}
 	}
=20
-	touch =3D xenbus_read_unsigned(dev->nodename,
+	touch =3D xenbus_read_unsigned(dev->otherend,
 				     XENKBD_FIELD_FEAT_MTOUCH, 0);
 	if (touch) {
 		ret =3D xenbus_write(XBT_NIL, dev->nodename,
@@ -304,13 +304,13 @@ static int xenkbd_probe(struct xenbus_device *dev,
 		if (!mtouch)
 			goto error_nomem;
=20
-		num_cont =3D xenbus_read_unsigned(info->xbdev->nodename,
+		num_cont =3D xenbus_read_unsigned(info->xbdev->otherend,
 						XENKBD_FIELD_MT_NUM_CONTACTS,
 						1);
-		width =3D xenbus_read_unsigned(info->xbdev->nodename,
+		width =3D xenbus_read_unsigned(info->xbdev->otherend,
 					     XENKBD_FIELD_MT_WIDTH,
 					     XENFB_WIDTH);
-		height =3D xenbus_read_unsigned(info->xbdev->nodename,
+		height =3D xenbus_read_unsigned(info->xbdev->otherend,
 					      XENKBD_FIELD_MT_HEIGHT,
 					      XENFB_HEIGHT);
=20
--=20
2.17.1
