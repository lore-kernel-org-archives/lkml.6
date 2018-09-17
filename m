Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCD9ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006D82147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="I+I4rn2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006D82147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbeIQIb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:57 -0400
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:15104
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729627AbeIQIbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/1NGHqcUwji0ICHWx4B6IofjCPe98Ot65og6v8dh/g=;
 b=I+I4rn2dWKAQsJWR3UtxIv0EN3EfYFlePyKRIqFufZOMhF3lNZ4llEH/+Uf0iONkMo+SRZGwOdadkUZLGyPkwGsGggAEYcdpUsXUKv1Ef3mXS7tNkJTbRRQ/got1gh29a0sbHoL4xB3McjWZIV/50vYespVs0hmN6qUVQDVPWNQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0742.namprd21.prod.outlook.com (10.173.189.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Mon, 17 Sep 2018 03:06:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:22 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ethan Tuttle <ethan@ethantuttle.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 45/57] ARM: mvebu: declare asm symbols as
 character arrays in pmsu.c
Thread-Topic: [PATCH AUTOSEL 4.9 45/57] ARM: mvebu: declare asm symbols as
 character arrays in pmsu.c
Thread-Index: AQHUTjMb2XR9/PsV1E2cH7JOgVr8hA==
Date:   Mon, 17 Sep 2018 03:04:10 +0000
Message-ID: <20180917030340.378-45-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0742;6:zf/LFxcRMCAfbdpjb79E2KVCbNaia0ZbfZtukQs98mNvdA7JGkWQowjeO8RFDiAaitmI7HMZ2XjhH4rwDfsf+q7qHuNIj86R96hspqYh29ozMvMjyyL8M7AbzsStAqdR9/+7k7S4g+hApnTs+baCO4cpux88TZGpYeRkFAFynOpX8+7vc4EutCln+cTfsG5OuKBkViMsNefWyt3AjgiEGeI0DeOcYbbWJSBdeY+VWtULecH8IxIwEeczukQ/F90aa7O4bEYtsNHo38F89oGGD9WS4L1IgpjNK6r3K55Unx2bVYueG00BGa/L4Rpzpqf4Qg3Hn3XLV+m4nTklkUDuHYPwURHCBXYzdlB691LBG83G05TOU0MikriMeMpyIUeyuUgislDV2HnZjfJZTPBrAw4mzqVLOgGYkSCR8XwE+mbbrfc/XuzXVAiWQbSj/c52KR9dMRAXnyy0S/pagd2CpQ==;5:+Z1lgyspZ/nlQEw9b8KWHyyIRjp+gXbo9znefL6WyMcx5ZmEemzuP6Wo7giZNzPX22/fni2UlKNoJ6Dv6OUB72pwbGBwfirEQM09nfDiR0mMnS5EoJVGD9P/4biGAEbDe3OeNuXpl+X83KAigWdkYabJ02Ng2+GwlNzq1NOD3ls=;7:EExPApZ+xSVTL64qGUS1x+u69OdPqLQF7brH0x+4eJZgdmNCcC/SL7bf2mRP4eaqs1ajrslxePft6yeqvamI8mnDuFcE7tPzT5oz3vj9R58G2WQ9O71Ap3N9VEbm/6i68Ynx9LAxTVXto64pDFnDdn3v1kMR26klYs2GM6lsypYswduoSFKKBEH7dnmCDbkVTcsiBGh5/8VdUEZI3XTNsd7UfsZtdtQFtPSFSs6UYfUyfnlDEO9nI57x4ZQxm56T
x-ms-office365-filtering-correlation-id: 31b828f6-106a-4e76-e645-08d61c4a8c56
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0742;
x-ms-traffictypediagnostic: CY4PR21MB0742:
x-microsoft-antispam-prvs: <CY4PR21MB07429AD52FCA800B846BA311FB1E0@CY4PR21MB0742.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0742;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0742;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(6486002)(6436002)(6512007)(53936002)(4326008)(3846002)(217873002)(25786009)(2616005)(1076002)(14444005)(6506007)(186003)(6346003)(11346002)(446003)(26005)(2900100001)(6116002)(486006)(102836004)(256004)(107886003)(476003)(86612001)(575784001)(86362001)(2501003)(14454004)(97736004)(66066001)(76176011)(6666003)(316002)(54906003)(110136005)(99286004)(68736007)(10090500001)(22452003)(81156014)(2906002)(36756003)(8676002)(8936002)(81166006)(7736002)(305945005)(105586002)(5660300001)(106356001)(10290500003)(478600001)(72206003)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0742;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: PE/X5zMOo97MtUKHBMS2GvnrJWojuQno8Btq8DMVsuuuV6vFvCHgLggGLB7JDLax864XqJURl24/KXgPXuD7ylY7bmAMWItJyUr2ADnldUJOvnLJCIXunwlMj6nZ9cvAG3J1kfjHcYpIiIXSrCNfkIrIFuolOfK3HQiQeWQ0YGGnOIazFZq4snSRMB4crc0BK4MKB4WGehoOokQR4aSS/RISUJeQKOVE4IX9P5nlXd79FMYzjgT0ISx9fxG5rsJ95bl0DAv8kEMwW/0jUeo4unzNgHEC5dVI6offQaP0WYTj18iAYR8ej2o8Ad+iyx7yWEFmFQju7Dhbcqj/esmajvgnhHhk3ihl6qlTe2q2cVo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b828f6-106a-4e76-e645-08d61c4a8c56
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:10.6958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0742
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
index f39bd51bce18..faaf7c3aaf9f 100644
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
