Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21204ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53E8214C3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gGWMSVUC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53E8214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbeIQIaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:23 -0400
Received: from mail-dm3nam03on0114.outbound.protection.outlook.com ([104.47.41.114]:30720
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730434AbeIQIaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvGs5Cm/BzoQtT9P8g0uaTWVPG7cR4kMgCBWvHR4oxc=;
 b=gGWMSVUCh9Beu214zlAdbMiUKuW5FOBSrEoM8X9zDx2WTc2EnwIZkfaP8wvsnD6/KwSFtsY2iYB/PBWP//aiXoKK5CIrwSle6Lv0+YeTDUktwaflRRsP5JiOEkNX3Ti85+IdM6g40T9kRkniCBcSJFSYJeFdqTi5U+8Yo/uThGo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ethan Tuttle <ethan@ethantuttle.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 68/87] ARM: mvebu: declare asm symbols as
 character arrays in pmsu.c
Thread-Topic: [PATCH AUTOSEL 4.14 68/87] ARM: mvebu: declare asm symbols as
 character arrays in pmsu.c
Thread-Index: AQHUTjL1ffy+vFIHRke1VqsBK1t8fg==
Date:   Mon, 17 Sep 2018 03:03:08 +0000
Message-ID: <20180917030220.245686-68-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0774;6:JHmvBl3R6jL9g55FO00CV/jp9f4Yv60QuIN9/68P/TYkJsXQb+3LfgzeJNT11NIXD0Sl608vbW6u0Asp6rIja6jsM7FYtOZzT9qLzZFPkeBq7iheJBJDU0StoQrxC4E0l9Y1djq3ut21mErLUontUt0Nu1TdW1I9UJBLFcRHwIK/28jkBM4DEgH0tK0LXnn15J0KtU0aSoJjPEB2talBex7si75OHA9o9pT1I+m8PoZuzOy/LeiYP92oYoOSs4W7A7M2EiZvDwCgNj/dJJUbvo1aXBuF58LveNX/LHyDtTG2RT9uIfrKQSRe9wC7s3p0IAzun5EH/EDKVRYxwO24aKHa7riXTEpSMXHFwn+65+ex94sCLSt7sK5m2l2bxh3mA18DSAAqzpiOJ0OUqvDKH+cMPVqGA7YfdiG+1NlZVkEoe6JoNUNJWLwiDfyzzt90l1zTyred/cnJwkNrQfMaXg==;5:Xgsde8mMfkk06w+f+NC/IR0qAyUG0ccTB8p6KbMp7y+xYXpOTOxs3NY779/54jDtc7GWTPT1+LbJCtt0Wf3hQuoY2i/t1ad0xsPT8ck7/xVruDU7YiTq/7niCR1OJUXzy9M4uRBAdvzMcG8SN/pgYgp8DND+2/3a015C+WoLrCo=;7:6AMLpum7tqLFWR4iV0fjPRl3CXr/JYft5p5w4f+WwWjBKygvUf+3qw4ik7XTZKxjhYvu43aAK6ktl/ioYbOKE6eYplhobtk0PXjA4z67sco8zkI/USLfnOm57zzu5CXXUAqIWzrm8K/t2n+LKUO9lpV2u8UXtNjgDp5nS4sdKgqGeWIIOmYCIx9bmOUIYbAth3fWJx52apuZqMIoP4hxu2iNJOPm/oPX+6e6o7W5l3aeP3ybXIfcFX2Tw307kT6U
x-ms-office365-filtering-correlation-id: ed5911d6-b94a-4dcc-0783-08d61c4a593c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:
x-microsoft-antispam-prvs: <CY4PR21MB0774AD4E0CC2D9159ABD6FC1FB1E0@CY4PR21MB0774.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0774;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0774;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(54906003)(105586002)(316002)(4326008)(6116002)(1076002)(14454004)(305945005)(7736002)(22452003)(81156014)(66066001)(81166006)(99286004)(8936002)(8676002)(3846002)(478600001)(72206003)(53936002)(10290500003)(68736007)(106356001)(6512007)(25786009)(76176011)(110136005)(11346002)(476003)(2616005)(446003)(6436002)(486006)(6506007)(86612001)(10090500001)(102836004)(575784001)(86362001)(6346003)(186003)(26005)(36756003)(97736004)(2906002)(256004)(14444005)(2900100001)(6486002)(217873002)(107886003)(2501003)(6666003)(5250100002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: eHSqd/RPY+ThqS+fgPSBCE+hfIp/pRxE2eBw+GnMoDjB4cNthMlDyzkcLwuB/Rr/pHtXMv22PDdD49BGO9eMYJJDr9e0Ridf7+imJ3MPTJ8ElNBUsysUP/M9AnT2kbceCnCShgaaLpPT7cprO47QBWzbEd97BJnEtQaSRq1nh9xJUKxGmPME3iilq9QetEEZC9JsEbdjR9zUr5nESzRXC6r+8jWhsxU0nKWrgiIcCoYzMcNnZ29Z8yjjT9C2nvCV8i+ngpyUnQ24OCdppm1iwKZyLePBq/ltNr6JXs3/lSMJwSxVr0h8uUmA9+x6hRiQ3C9RLO0ZGG21jtC5i+Pg2XYm2xq3iEfb/EsdAmGfbm8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5911d6-b94a-4dcc-0783-08d61c4a593c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:08.1966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ethan Tuttle <ethan@ethantuttle.com>

[ Upstream commit d0d378ff451a66e486488eec842e507d28145813 ]

With CONFIG_FORTIFY_SOURCE, memcpy uses the declared size of operands to
detect buffer overflows.  If src or dest is declared as a char, attempts to
copy more than byte will result in a fortify_panic().

Address this problem in mvebu_setup_boot_addr_wa() by declaring
mvebu_boot_wa_start and mvebu_boot_wa_end as character arrays.  Also remove
a couple addressof operators to avoid "arithmetic on pointer to an
incomplete type" compiler error.

See commit 54a7d50b9205 ("x86: mark kprobe templates as character arrays,
not single characters") for a similar fix.

Fixes "detected buffer overflow in memcpy" error during init on some mvebu
systems (armada-370-xp, armada-375):

(fortify_panic) from (mvebu_setup_boot_addr_wa+0xb0/0xb4)
(mvebu_setup_boot_addr_wa) from (mvebu_v7_cpu_pm_init+0x154/0x204)
(mvebu_v7_cpu_pm_init) from (do_one_initcall+0x7c/0x1a8)
(do_one_initcall) from (kernel_init_freeable+0x1bc/0x254)
(kernel_init_freeable) from (kernel_init+0x8/0x114)
(kernel_init) from (ret_from_fork+0x14/0x2c)

Signed-off-by: Ethan Tuttle <ethan@ethantuttle.com>
Tested-by: Ethan Tuttle <ethan@ethantuttle.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-mvebu/pmsu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 27a78c80e5b1..73d5d72dfc3e 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -116,8 +116,8 @@ void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boo=
t_addr)
 		PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
 }
=20
-extern unsigned char mvebu_boot_wa_start;
-extern unsigned char mvebu_boot_wa_end;
+extern unsigned char mvebu_boot_wa_start[];
+extern unsigned char mvebu_boot_wa_end[];
=20
 /*
  * This function sets up the boot address workaround needed for SMP
@@ -130,7 +130,7 @@ int mvebu_setup_boot_addr_wa(unsigned int crypto_eng_ta=
rget,
 			     phys_addr_t resume_addr_reg)
 {
 	void __iomem *sram_virt_base;
-	u32 code_len =3D &mvebu_boot_wa_end - &mvebu_boot_wa_start;
+	u32 code_len =3D mvebu_boot_wa_end - mvebu_boot_wa_start;
=20
 	mvebu_mbus_del_window(BOOTROM_BASE, BOOTROM_SIZE);
 	mvebu_mbus_add_window_by_id(crypto_eng_target, crypto_eng_attribute,
--=20
2.17.1
