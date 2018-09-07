Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C99C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFB320857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZwiJ5cIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFB320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbeIGFT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:19:26 -0400
Received: from mail-cys01nam02on0134.outbound.protection.outlook.com ([104.47.37.134]:20941
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728144AbeIGFTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIclNX57bRjHAM9wMxoQ70UrlkQ/TJaLUwMbFQjfLZo=;
 b=ZwiJ5cILBeLhEoP+OMx+F28QzCh78yvB3pH/SWPIEHm2j5EF9cUV2hVHXwZNPvy2LT6CSScTPZPxapMxuBXlLmuPRpJCIprDURmgyeesbZmMNc7Nh6IIBWByaMWB6cdELaSDVAMtIJVtITF836wsSdw3FSX3id5D95hZ3Vjbxa0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0694.namprd21.prod.outlook.com (10.175.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Cercueil <paul@crapouillou.net>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 28/43] MIPS: jz4740: Bump zload address
Thread-Topic: [PATCH AUTOSEL 4.9 28/43] MIPS: jz4740: Bump zload address
Thread-Index: AQHURkMeKxZBEZBIn0i7swPhyxHZiQ==
Date:   Fri, 7 Sep 2018 00:38:38 +0000
Message-ID: <20180907003816.57852-28-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0694;6:6lUZxCCLFJXh629H2ThLRsigVuMqMCNitIUiak/A7s/XrcntXo/bdNu8O2keWyUAjnxjOiMs7/FvyflWpj1Gc/N6wBTQxakmQ6owVnrbEzRnZPSYTmf4+kwRuZTRpOHBTZvztfnUk/vDSaqyMgnEkN5mnqwSDfSA+WKteAajvUSLZ7xpdU+y55JTvugOD5hNL0+DEllY6vOt5kn8sorRZRnXnKwVYF3NJRtfpkSN+H5OrzUuYrD3FtJWCrWj+f2mEhkSShw0UvixU9SPFUtBZxRVYGlujHM4yR4/JwJYONvPw6BjPpzutpBJvyESY3JJbUYap24ds9ENseXh7hfXNFiyXb/gH9fDUnZ+S766CD0nfXtPXRh+8QYakKPSzEc1poce2WYlpbB8R2KbpndDwevOJ9MEMc/UaOdd2OU4O88xZgubWGZyAKTHAw+ISQPPYb/ekYA9UwlJiBZbiey7PA==;5:uY2DFgc34kLhh0bRmp4r0Ud/RsdSFUrJTqj5KHNUdJJHY7KdDTQNLj6ydNL0SIJKsEi7TaUdy2lFDWXEKOs/JHjpY4JppaZ8T8pBniGSweoymrz5i8K+oQKus6dGvlttqjyBwJbVW3OSVIei1jS1F5i3v53JXTfWU3H0bR/HBlE=;7:AF9BzaICZbRjx1AXSCB9RBXKBRD2Z647SlLh5FlDI/jqJhmk+P4jxNKOozKnJoP1XW0m/CQBVX8PZ6ielOT827M7ZYvFYAWzS/u5QRKdK3w5l4oKx/bi1GbeO33uQvpIuYOgP2W9V/cMcrcsIh90g+0rn4i630ZM8A+SJV+yhDtLVwRIgRCIYsaibbAEkbJxM2qwZ5+50KyYtvU6O6O2Sbo0Hi1/rouoS6IbCyx5+Qz4VOs4qhyimtNrgfJZbcTT
x-ms-office365-filtering-correlation-id: f6c9d1d4-7bfb-4436-8a03-08d6145a9fd7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0694;
x-ms-traffictypediagnostic: CY4PR21MB0694:
x-microsoft-antispam-prvs: <CY4PR21MB069456AE9C710C20B8038C58FB000@CY4PR21MB0694.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0694;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0694;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(2906002)(575784001)(186003)(86362001)(6666003)(110136005)(107886003)(54906003)(36756003)(25786009)(4326008)(256004)(14444005)(2616005)(6506007)(6486002)(6346003)(6436002)(6512007)(6306002)(446003)(476003)(11346002)(486006)(86612001)(2900100001)(5660300001)(102836004)(26005)(66066001)(53936002)(68736007)(7736002)(81166006)(81156014)(8676002)(10090500001)(8936002)(6116002)(3846002)(99286004)(105586002)(76176011)(106356001)(5250100002)(22452003)(14454004)(316002)(1076002)(2501003)(305945005)(217873002)(97736004)(10290500003)(966005)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0694;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: CeV6Wy0Me1s0fklgqiMGijhExQOVK3HEvjcQzlgsHsH/kmFiXjJyj5JiJSGLl1yO8L4oMdthqAu1okhm0r94zbZRPW9j1RL3x7x1QrCom9x8xTXlhrW7BKd0rXoi2v14jqqs1PANgL0NtWYey3u1+ecWB6oJ/mrG5KXB6C7LzWmWzXFxgdGCLg4akzg0MZfChpZDaxkbTQZaofjNJD7iCX+lk9TNpNqf+h8mBfaywxWjuX2nR6zqgMB5StbGy09whxgvH6U/dNfr9EDZz6wcmDTWqWc7/uR+vXkJQqvaE8+5ITR/3OYzgadvy0nuAwpGGaCfTAoHF3FcQ9pdojevof4Qxu6tsMkyv7O/xot7yAg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c9d1d4-7bfb-4436-8a03-08d6145a9fd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:38.8814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0694
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
