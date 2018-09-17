Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619ABECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7A12147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lXJG/U2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7A12147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbeIQIeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:34:36 -0400
Received: from mail-bn3nam01on0100.outbound.protection.outlook.com ([104.47.33.100]:24062
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731569AbeIQIdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CliTBFmvSUxXh7zdSZ4JSALZ8nk/lu0uZRLEsIo6B5E=;
 b=lXJG/U2gPQtpDn5qUZUkHWtEHZsxuyiayBSyjSt+p2wVG9Uwaxx9n5wpTyXTW04NnJu1wp19PVCDzxjKg0vVDCmbzwdJ8uSdfZ/7tng60H3/e/l5+XmTUk3PI83RjeKfOc0wgelr4ULhmzm2dfakglTE6BMko0cTzYYh8qmKsHE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Mon, 17 Sep 2018 03:07:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ethan Tuttle <ethan@ethantuttle.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 23/29] ARM: mvebu: declare asm symbols as
 character arrays in pmsu.c
Thread-Topic: [PATCH AUTOSEL 3.18 23/29] ARM: mvebu: declare asm symbols as
 character arrays in pmsu.c
Thread-Index: AQHUTjNXWJQ1oQFJS0OJiQmm4OU+uA==
Date:   Mon, 17 Sep 2018 03:05:51 +0000
Message-ID: <20180917030533.592-23-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:Hu4ZhONow++V76IrrSgIrD78uIsdjGxHvCXR+Lcegpxkg++leAWnl5RCMoeWj9iW1W4+qW+jLRP/pE+Vs4qyFfkUv7Blflj2F/t7Uuvl97T2r94A1XJczq0d5m5HBDpdPsXbf11qqldFyz7aK9/3jIPNaLOI7RUPCLyVqmNk/lPL6IgZuhyIEXTsfmJa0HcaCze4E4v/+bBRR9gvM8Hycz6VLZ9EkYmWH47H6a1MkbR1QeW4btXElbPXBMwOAqegArzpOAqcRhwgEvcFtbJgPDQ53BJ+LiXXrA74LZg8FVGpfISsxCRzH6p7RVdcp80KER/YgjOdmDj6mc2sBQX1qtz59ioqH7zIYbUM3EEWvmGi6WVpveoAG3AbZ+b588HsPx63Xi4rtu6JynrDePUuCsy8wwghm1gPpupNCYL1BCFbHGdI/rlOY8R+muMqnqxmxNX22tuyIM6ZP8TYRfc1xQ==;5:fOo8VXTvZGXJIihJDIrg5ddpn3FgRTJxytEq2XynSLJjY3cZAVGj4GyB/VvaKo3iyYD2b8eGXCTARJLsdhapSstcJn5vxdeeqU6gMJTaz4hkLldtbdWoWPVHRo8NRWvvYk+QP3htnL20/uKqUx7fkwDotDrmb4RtyzuCwP3SXuw=;7:Q9VLRxCfkI3H21+3i4IAnnJ9/9Qhxw9juHTGHqPwEX0wH6FjENJh9/GXd20o64rqDNUc880uXmgH0YWfZy7kuvwKyVS0vF/l24rLPsgmupiDk68REfcOKFJbRsB5+V16bo/VXpLVx+IcaSRUftQ67C3kvyXngOD+fUgws2J+Ry9FUPrza07UbQKxHKPKq0vHYDv+7b+ZoJ1HjCRPJscocjF3DL2UPVmhYty2mv0aJhrqRtYVNgDw8cMxfBGHug+u
x-ms-office365-filtering-correlation-id: 87806ac8-6a13-4572-24fd-08d61c4ac471
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821F22F1F929777290AAB02FB1E0@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(376002)(136003)(366004)(189003)(199004)(5250100002)(53936002)(14454004)(10090500001)(6436002)(97736004)(68736007)(7736002)(8936002)(305945005)(105586002)(106356001)(36756003)(10290500003)(81166006)(81156014)(72206003)(6486002)(8676002)(99286004)(6512007)(478600001)(2501003)(2906002)(446003)(217873002)(14444005)(256004)(2616005)(66066001)(6666003)(2900100001)(4326008)(107886003)(86612001)(5660300001)(3846002)(575784001)(86362001)(110136005)(54906003)(186003)(316002)(22452003)(102836004)(6506007)(25786009)(26005)(11346002)(476003)(76176011)(486006)(6116002)(6346003)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: BP52qclGeBMK9C9DNYOiRxLZQnwlzy0gNW1SlI7G7aU4ct7hXZKqyfkaIQv2MPmzSVmAvzINP6HD2PFCx5FasYvSJfiw2S8qBqU82IarF0/Svj8zFep0jQsquvbPidppW/G6wvUv7Qqxmx0WpNRx2hiCF26mJXV2zAtPVRMtIYp//7HZbGlmnS8G5fAjzAqmvnrIWw8ThAeFvutguBmV5HuMqediCKYLi5kg29DWWVruSY1LxK8NlO54iIlul8X2ShQlkFHZxxkagsX8qK3W3XaNagnd0XDzMhHPtj5FurEy9bWGoawG/63qlKep/Ya+9XEgWvhECBICzJ4LvIZt6IzKoLod4AkhvnWdTDlyoSY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87806ac8-6a13-4572-24fd-08d61c4ac471
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:51.6389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
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
index 6f8a85c5965c..7bbe32e56bbc 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -117,8 +117,8 @@ void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boo=
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
@@ -131,7 +131,7 @@ int mvebu_setup_boot_addr_wa(unsigned int crypto_eng_ta=
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
