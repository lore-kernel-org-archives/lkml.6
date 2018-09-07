Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35813C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84772083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NA9BUve4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84772083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbeIGFaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:30:03 -0400
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:33184
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726620AbeIGFRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIclNX57bRjHAM9wMxoQ70UrlkQ/TJaLUwMbFQjfLZo=;
 b=NA9BUve44rvqh5aynwGlgd9kqNO/JttwkOG5qAxHxZ+CTVyZwZxOzzC9Pdl98MUpzDhT0AwSDH/TE6oPaxake17KQTVlHegOk4H+LXInq8qTvhXtTc1swye/XxHyi2CBdtfDvKEN1HIjnT5IU1c9aEuS20KttmVKHmfuM0wmVrQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1143.1; Fri, 7 Sep 2018 00:39:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Cercueil <paul@crapouillou.net>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 46/67] MIPS: jz4740: Bump zload address
Thread-Topic: [PATCH AUTOSEL 4.14 46/67] MIPS: jz4740: Bump zload address
Thread-Index: AQHURkME6lcKZYfmiE6TY9G3D+z9Cg==
Date:   Fri, 7 Sep 2018 00:37:55 +0000
Message-ID: <20180907003716.57737-46-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:IUI6jxPbu0TSqaDq9Ce9yKEns0oun40+IttlzPvxmaQj+tfQuzmggHEqnl6Ni+xQujJR0IY2nUuCCkW5cEd8tlP6Xv8ucTlcPXGI3NR7WljJ5BLvXDHTAoMMkCsNKnNjr3m1R0Tim6DGwSc6hwZOCM0/cd3AOnD41xVrjwrZ34W9wcAjPAXKCuVmKXc0yynWg/3F41ZqXDLaDVRaCH1gZkY97eEUyucie9sDKPANvWM3HHxPjtN6Pq6cno1CvMi+gwlMZG2hXgPX+Gzgi4ildJmMd9P5rrLwJhbxHbUzWssii5lk4zEPHqeayM6fc+ARJ04YcvGKxJK/B+DIXfd3Lmq8ee9EWRS5Al9aLgyxfd0fWQe0/wt91wZ72RZAQ+C9PY9UHrtrAQB1KByueRSg3bwwrLbvBi1ceFDnpPzcQXcNwlxh7FaGAemV7gV0CQkb0q8mYAHozCJxsFaf1o6PgA==;5:hLKtaTc0HN0sbqEPSUlxPCgOcEB6W4NRbanC60oLEBl6wBhKKlkF+3xSSq6whn5PTg/PvhYb6OYcBxXjli3dcfgullUPtPrE/wB2aJ5n5okajA3h++WumAntzwD76y9fJC8IBqpWFPhBPzKiNMeiYcvaWFxlPhoNIn7diI95NTM=;7:YBt0FfzWBtVEIt2c952fijIRsNRXV6lwqwyuSctk7mySNKGpc/G7i2W2gjmhd2seABDW1UCHwiaFW8HYWy9niJRBjyBQ4+x/o4nZLU8f2U7FHz2XUgTfwavtrAinqwLX2JLeDXFF5H7bN7I4PiT2VDImWS3OYtPI6GZHTQ/o42FrE7bjunc12nV1C5XyMXNHxO2nh85DKGy0GjGV6N3mX3g4M6j7l1Tn6LISIVheg2VPjHmrRW93BEt7FXISgzM9
x-ms-office365-filtering-correlation-id: c2d8d3de-3fc3-4637-07ad-08d6145a4ef7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB07574AF5CBAFC356CC8568CEFB000@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8936002)(3846002)(81166006)(86612001)(6666003)(5250100002)(81156014)(486006)(99286004)(6486002)(106356001)(10290500003)(107886003)(256004)(14444005)(26005)(11346002)(14454004)(446003)(76176011)(6346003)(5660300001)(10090500001)(966005)(110136005)(2616005)(66066001)(186003)(476003)(72206003)(2501003)(54906003)(575784001)(316002)(6436002)(86362001)(97736004)(53936002)(22452003)(6506007)(102836004)(6306002)(8676002)(6512007)(2900100001)(68736007)(305945005)(7736002)(217873002)(6116002)(1076002)(25786009)(2906002)(36756003)(4326008)(105586002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: MpTtlPxdqdEUjDZcxuoOid3/bDPnz7LV53eqoCYkhZkYVy1JXdfpUuR6Ac+lxmgsU7ie7/rQogpr7ZNSx1OFqCSojokhtIrInsl9V8Kn4tu3RzDi4e2eXMwkqLLSsVksznHEim4W5dh78QIT230TgzmCSevS0DfwuL7oTZRsf5SbaBEErJ1ttpO37kM3D/Do/+Qeq/P1KvoTmTK0Lse8Z0OwtqbFIrvnovWujGV6cJ1Xg4qiIvM/sQytlVjLhplDp4gKbY1p2+mg0rSApz3NJZXTtNN9OvJFUTGu+A1ba31CLec/ggT7T4b86xxGDBmlqPZSHZEDSGzH41Yda2PmbhDbLSi5itPZb9BDkBq14TQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d8d3de-3fc3-4637-07ad-08d6145a4ef7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:55.7322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit c6ea7e9747318e5a6774995f4f8e3e0f7c0fa8ba ]

Having the zload address at 0x8060.0000 means the size of the
uncompressed kernel cannot be bigger than around 6 MiB, as it is
deflated at address 0x8001.0000.

This limit is too small; a kernel with some built-in drivers and things
like debugfs enabled will already be over 6 MiB in size, and so will
fail to extract properly.

To fix this, we bump the zload address from 0x8060.0000 to 0x8100.0000.

This is fine, as all the boards featuring Ingenic JZ SoCs have at least
32 MiB of RAM, and use u-boot or compatible bootloaders which won't
hardcode the load address but read it from the uImage's header.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19787/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/jz4740/Platform | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/jz4740/Platform b/arch/mips/jz4740/Platform
index 28448d358c10..a2a5a85ea1f9 100644
--- a/arch/mips/jz4740/Platform
+++ b/arch/mips/jz4740/Platform
@@ -1,4 +1,4 @@
 platform-$(CONFIG_MACH_INGENIC)	+=3D jz4740/
 cflags-$(CONFIG_MACH_INGENIC)	+=3D -I$(srctree)/arch/mips/include/asm/mach=
-jz4740
 load-$(CONFIG_MACH_INGENIC)	+=3D 0xffffffff80010000
-zload-$(CONFIG_MACH_INGENIC)	+=3D 0xffffffff80600000
+zload-$(CONFIG_MACH_INGENIC)	+=3D 0xffffffff81000000
--=20
2.17.1
