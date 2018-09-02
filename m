Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85010C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350352077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YFBRncm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350352077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbeIBRrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:47:35 -0400
Received: from mail-eopbgr700093.outbound.protection.outlook.com ([40.107.70.93]:58944
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728363AbeIBRUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoQPbTswxZj8WpFx0XjVdE0U9aCqF2mV6vET/BD+bko=;
 b=YFBRncm2qgt9I0dbHJlLrMgU9g7oeceXSk9MNVlmRw20Zf6fA+4zJO49SedNAaVQpZ7tFRY71RTK7kS4Sn5OJol3C80v47Pcz1wDYRnbKQB3aZwYcMmbINiAJDHUTNEAj2Jvx5gvzEyU4txLMWrqSAn3Jmcv6yykzL2UMC35BTw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:51 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Robert Schlabbach <Robert.Schlabbach@gmx.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 067/131] media: em28xx: explicitly disable TS
 packet filter
Thread-Topic: [PATCH AUTOSEL 4.18 067/131] media: em28xx: explicitly disable
 TS packet filter
Thread-Index: AQHUQr150r0H28C+HECAcd8J7+CdtQ==
Date:   Sun, 2 Sep 2018 13:04:25 +0000
Message-ID: <20180902064601.183036-67-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:/QEioAyZSelsBOoYeFMgY0FtK0aE44SP8S8cdR/XHgEXnKalZv1I7njjSOsmKMRyx9sT6/9JePCAxqrKbkULWgC3sJu+QzYLu6+gN1j5FdNpS/XQ0ufZCTUG+1ZaZ2clsy2HMNGrG6+lWxcA8a+E7C6nR3c4zGbpPHZ9RWZxWZQTVLalwcM/hABtufude2l1aUVWprnurz7OKN/dI3DdosF4caarWKfVyW1NVCZ4UtBjMEm5O4OeoGqkHz7hqhXCbH7tnObqtmB6yh6LzS0ZI8Ez82a0ZSkU9xRwJm6jVQotFSzo6DbkykQgBIh/mKqg32FZNQk9vjSOAK80sgoimuX2RQyGIVuh6csi1I+RL1N9ES4B6FCsdGm5c+sgWgYdWc6Y3swNmIm0IgabVzC/96RNJiZHaiN7eZS1AUzuzUN+D06eIV1ZR/7QxfyjxT6pgiDkJjpgmOLeuAt8A7lAqg==;5:shIGasnIQyAgSZg6ErwSIxCcRnA555tDvakOecy28NEKpwQZNrurKZ6s8jSatHgLoR/4RXohODzrOWXEljc5X9dqICGMx/tX2tXICUU4Ge0wjtOwDx8WTBKOwSai0Bv62aQipr6dwH2ShhVNZqtMv+0lyWEfKwTBlA8ML2vJik4=;7:aVhGrBV/xy9jndhALKF/pYjavcpVfM5pE40PGZYS9Xnv9PyWU546dXKtJzjokt1fpuq/U6gYrmZnk65/yj+7DF5BqpNxdoPbbQp+wySy9ViWUR9LhAbgmKtaUOw6DPyQJqRCDXFZ25vup9hVVWHy7m1msvqf8FZKp1DjoUDiRGqbA+67L+wP2PBrMlkN2arY1kQjUouXcOb9ILRzqe5zt/PlzErAI5C6hEkrpkgzya8a8W0WzUK8jWN5dwvB4kb+
x-ms-office365-filtering-correlation-id: d64563b4-d691-42b1-754b-08d610d4ab64
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01209DB1AADCE933F7160B75FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(278428928389397)(89211679590171)(248736688235697);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(110136005)(5660300001)(107886003)(26005)(6506007)(6666003)(2900100001)(8936002)(68736007)(66066001)(99286004)(76176011)(217873002)(2906002)(1076002)(316002)(3846002)(6116002)(86612001)(14444005)(54906003)(6436002)(305945005)(7736002)(256004)(575784001)(86362001)(6486002)(25786009)(10290500003)(478600001)(14454004)(476003)(22452003)(5250100002)(97736004)(106356001)(72206003)(53936002)(2501003)(2616005)(446003)(11346002)(6512007)(10090500001)(4326008)(36756003)(105586002)(102836004)(8676002)(81156014)(81166006)(186003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WeQdw4XnGSfEI3T4ov+AdoNmdUp3FIC4LbznTUgL9oOInJRRgPH2NnZEsdKf5hYUaaSNRXRbgEtXQ9RC4gtKhOCpqYrsRVgn/MB/jP6VO5bRxN0PEqikYUOc+vSGmHKdT+U/BM2zME+7MsX9P6BDgDMqlxJweOoz6QuHc/AvBfjA8MLBpiN4k9odlpaKPI4iUAEeNSak2sUDBDJqPWvwxbKhIkLNPWZ9Mf3uxrFiaqhmPoQ+TEvn3xEoq9Tmztgnzzrnc0Us1No2VKlqX7SwQtPWfl5ZBe9b6XCCgORSC4lF1ef7a9JjdrPsHoiAODjBT3yB+mxepBn8DBe0GHHkDaggM/qMB+KBjMvBRKWnvfg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d64563b4-d691-42b1-754b-08d610d4ab64
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:25.6119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Schlabbach <Robert.Schlabbach@gmx.net>

[ Upstream commit 157eb9a0b75e97ad390c6e50c7381b0a0e02fe97 ]

The em28xx driver never touched the EM2874 register bits that control
the transport stream packet filters, leaving them at whatever default
the firmware has set. E.g. the Pinnacle 290e disables them by default,
while the Hauppauge WinTV dualHD enables discarding NULL packets by
default.

However, some applications require NULL packets, e.g. to determine the
load in DOCSIS segments, so discarding NULL packets is undesired for
such applications.

This patch simply extends the bit mask when starting or stopping the
transport stream packet capture, so that the filter bits are cleared.
It has been verified that this makes the Hauppauge WinTV dualHD pass
an unfiltered DVB-C stream including NULL packets, which it didn't
before.

Signed-off-by: Robert Schlabbach <Robert.Schlabbach@gmx.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/usb/em28xx/em28xx-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/em28xx/em28xx-core.c b/drivers/media/usb/em2=
8xx/em28xx-core.c
index f70845e7d8c6..45b24776a695 100644
--- a/drivers/media/usb/em28xx/em28xx-core.c
+++ b/drivers/media/usb/em28xx/em28xx-core.c
@@ -655,12 +655,12 @@ int em28xx_capture_start(struct em28xx *dev, int star=
t)
 			rc =3D em28xx_write_reg_bits(dev,
 						   EM2874_R5F_TS_ENABLE,
 						   start ? EM2874_TS1_CAPTURE_ENABLE : 0x00,
-						   EM2874_TS1_CAPTURE_ENABLE);
+						   EM2874_TS1_CAPTURE_ENABLE | EM2874_TS1_FILTER_ENABLE | EM2874_TS1=
_NULL_DISCARD);
 		else
 			rc =3D em28xx_write_reg_bits(dev,
 						   EM2874_R5F_TS_ENABLE,
 						   start ? EM2874_TS2_CAPTURE_ENABLE : 0x00,
-						   EM2874_TS2_CAPTURE_ENABLE);
+						   EM2874_TS2_CAPTURE_ENABLE | EM2874_TS2_FILTER_ENABLE | EM2874_TS2=
_NULL_DISCARD);
 	} else {
 		/* FIXME: which is the best order? */
 		/* video registers are sampled by VREF */
--=20
2.17.1
