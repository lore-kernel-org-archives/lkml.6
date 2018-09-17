Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FFAECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E7F208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fyRpqVSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E7F208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbeIQIzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:55:07 -0400
Received: from mail-eopbgr710116.outbound.protection.outlook.com ([40.107.71.116]:59328
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729486AbeIQI15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvGs5Cm/BzoQtT9P8g0uaTWVPG7cR4kMgCBWvHR4oxc=;
 b=fyRpqVSWqCJbH6nr6S8HvLdKSU++W7Zt58Yi8xyoeTMCVJaiDeJMhVSaxClyyj+dIO1LOE8+xUpyZIe+7QOSTz9Sp8Jc+8m/eX1gZL3q3Y/riIGRcL+iJoPLrH43HSgSViCw5Pk5LZ1dW8NzDiHkhNwgNcnqS/ypa62KY+NaCao=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0790.namprd21.prod.outlook.com (10.175.121.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Mon, 17 Sep 2018 03:02:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ethan Tuttle <ethan@ethantuttle.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 097/136] ARM: mvebu: declare asm symbols as
 character arrays in pmsu.c
Thread-Topic: [PATCH AUTOSEL 4.18 097/136] ARM: mvebu: declare asm symbols as
 character arrays in pmsu.c
Thread-Index: AQHUTjKxeF768D58vkajZHy8p+YUaA==
Date:   Mon, 17 Sep 2018 03:01:13 +0000
Message-ID: <20180917030006.245495-97-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0790;6:9RbS/Tkx9jo3K+OF05J1QH2uRnwRigqqI3ju4XSLGaOix6C+NSIMX9yqKfZSkdADSZtt6//uaQ15FPEf5QQppXnr/L5TenvxbZYf0kUClpKIymNcsKFNiGLVt+ti5BHP0KDgNJm7o6sZvprFT7eDWgxJsEbrY/SwesK/d1fx0RjXjLAZD+/NWzVybr7lYLRs7Op33q/B1OGAs1GDeQ0XNXECWq/rkwJPUMSqJLEjbFBQSK89L76D5zM0ZhAXuteDj0XgitXfq81Q+V+3dSKnCsKvbiN51y3OpacQ3rfKifVF585MGNra67qLELoNOGeq4ARZMsG+UTAK5oSBhxJhFv9Abnk6Q/jFpeYxDIUcsQvGwQjPIPx2OWedbpHFgE4TqzZyeKRaHMBljsQRRyE/ygNa0wwjo7HOfnSX2j2nzI4DsMQhvN7XhPSMcEtVpQKOZ1CK92qdTY+QkbKxN5uJzQ==;5:dyZPdcE0ee1af6VwUq3KK4Yi1uHLJ9Xtg71hpxTvunXPsnjI7sZPI+w4JEHD6MdEDEkGMoOwdKdG9+vB83vZh4VuEo0TgE1ALZ4ZpTwMFbLkk6ZuI4PwdUaViktA638PlAYa5rlxeSRnNUNAtUPOJhmbFncjm7gzEhcyJGnn5Ds=;7:LXIIPaVue3jQyy70bWgF1hYgtOvBL90XWJ/vi8lHZJrYvTIHBBKvXgQNDcBUVAbQBfH0yIvHeRbmPV+CM/Q25Y9xucVOFewVxnRuSKEx3Jf5m5W3njAK74jGPEhjY318mF/klL9rNCP4aT4MAQOxaB6xyeNxNaIwJuHdDHpoo/tGLj66Hc67Vbo9XA7+RPyTMBu91BD9inAshvpsxfq0xPWyHRpiJYJHzOz4Taqi1OYTl48HNu2lqZq5WEeO2ElI
x-ms-office365-filtering-correlation-id: 70f46c4b-154a-4408-305a-08d61c4a0587
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0790;
x-ms-traffictypediagnostic: CY4PR21MB0790:
x-microsoft-antispam-prvs: <CY4PR21MB07906900E8A16E0E7F4F0FB8FB1E0@CY4PR21MB0790.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0790;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0790;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(76176011)(22452003)(6666003)(110136005)(99286004)(6436002)(6486002)(2900100001)(2906002)(54906003)(6346003)(10090500001)(5660300001)(7736002)(6512007)(14444005)(217873002)(316002)(256004)(53936002)(36756003)(6506007)(25786009)(106356001)(26005)(86612001)(10290500003)(1076002)(68736007)(476003)(6116002)(3846002)(478600001)(5250100002)(11346002)(446003)(72206003)(2501003)(81156014)(81166006)(8676002)(14454004)(102836004)(107886003)(186003)(2616005)(575784001)(97736004)(86362001)(66066001)(305945005)(486006)(8936002)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0790;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 2jAv4E5FAGcSlkeiggpWgItCsXVOttB9tQssCibTMvoBHCOk5LYPGb5gm1pzNAwafPUxiyrR2eHDV+MYEZ35R/g4Wim7G/MEwHAsKHeSPhFx/kBwETns2ziJEgCM70NqHEbc6vtq8fg8I0Dj+wfPCZ5ODFk6bOhI28zl5qdJxWXUF5vh/F4++OUZzmT6JVWoszx+qY0+G6RcQmFiIjFLAFXiANp8zcjOJxmrCiTfxcNF8fr7a9TmK4FEf/4zUZrjvbIR7vgTW1FRt+LYNQy3f12ITuftJrkgjTGmgJxkkYBNkdOkezFOpxZN2OdvCtN0pxpe43EDnMY7VDhwaLX0HQT9mHUedZeA3ZjlgjG9jI8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f46c4b-154a-4408-305a-08d61c4a0587
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:13.2292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0790
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
