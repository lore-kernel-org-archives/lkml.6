Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95404C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3908B21522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="itGrqe42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3908B21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbeITIaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:25 -0400
Received: from mail-dm3nam03on0120.outbound.protection.outlook.com ([104.47.41.120]:36173
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387611AbeITIaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2xp3+lhQTLr6h2CaJy7elA1oWUHNgmNkWnH3mL25qU=;
 b=itGrqe42y8in9J70/Cc3QtkhzEsS0D8lpSstYRwUQIcDJoyh8v34T994qHISS7HV7YW4MK4Wa86fpvRxux0hMSeLEfbYWNWSJxZvoS1zYuHs8GWggLcwiDd97J9aZP2u5UW/Sbqj0pHfXphDgdh4i1dO3mbqsKow3XKuZyPwMsk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0119.namprd21.prod.outlook.com (10.173.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:48:35 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 56/56] x86/pti: Fix section mismatch
 warning/error
Thread-Topic: [PATCH AUTOSEL 4.18 56/56] x86/pti: Fix section mismatch
 warning/error
Thread-Index: AQHUUIxbOVYmBH6fakCrCARuy2EHPQ==
Date:   Thu, 20 Sep 2018 02:48:06 +0000
Message-ID: <20180920024716.58490-56-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0119;6:lHOD6mPxiHGt1vHJ49+8sELJmtzyQ5a+Su6JoHRwPznKHuSg4bXKP4x9ljYCl8lXxttYBSnm47tGT5bOQvyvNCEcYadQGpoLC3EA27xrQtm+rGqGu4mErOBkm7kfdWLfg3GYa96h5OxshmNkzQ/oJghOyz2ZNQ01NHu1f6ZA+7jBKbgqSiE/33r1wDO3L2Ed551cBaoNWXtR21izZn4Icd5pfDBdvRTL7MS7TmS1LRhE1RXur5SxZ9o88vJLZOiRH9wciYi3z6I+WuKCqyoBkf0Rkd5zs3/Nhr84Wl+I1By+M+NV3l2+qT4CQLSbbjPpbil3rf2lHP9pgBLP5c9dabtHR3sL0ZUgzPoGWhru9Q/Lpt8hJC1B5jzynAi+4/+ZzXXavomxA4ecE2VfwoKt7xX4UJToK1GdsOK74Eq/VbWQS5zgZf2r15ItNDJfMwmjaRVnfoNADSwIx+GMoRxrHQ==;5:3VXRLWmlxBQPQFTbiavUhp485KbPA/HacFa4hA13xc+jPCpZ+psmJtwHARzbEii4Lmfx7RcYc46IImmPAkpB9wwcDYXZe/YdnI/xdVxhjNKSeHbwDM3qpIrL2upikFpQ3aZJX3fuc7VBKqyIgtev7vwRBhtWqyLmSZPTRS0Tz6I=;7:C8uzEcvEiy+ylUtQN9sdN7sZF5F/fCWUhePCdqWMD5rA0sKwvgFMH91/mN35anjhnqIXxhQEPLZtrDQGGf2P06Q/o5v8twkB3083JhQGFKx5/LzPiK71fANnjRDh1T2k9k3AkKB9EUipYPDfjMvpyCrB7qZ5vyJGoMYgOCzIo/10jNqi2YE10lYquge1hd+mDWlKi3lgQTMqS5JNDymgB+Ak4Q70vr83dlleMApnFLgNdw9x2VeYqzlLWJqpyg7v
x-ms-office365-filtering-correlation-id: 875a59d5-6ad5-4e93-f22e-08d61ea38f8b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0119;
x-ms-traffictypediagnostic: CY4PR21MB0119:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB011925EF801FC8C26C4EC02DFB130@CY4PR21MB0119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0119;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0119;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(966005)(5660300001)(54906003)(1076002)(478600001)(10090500001)(72206003)(22452003)(107886003)(110136005)(316002)(68736007)(4326008)(76176011)(3846002)(6116002)(25786009)(14454004)(106356001)(99286004)(6666003)(105586002)(102836004)(6506007)(5250100002)(186003)(2501003)(26005)(6486002)(6436002)(53936002)(6512007)(6306002)(66066001)(486006)(476003)(2616005)(10290500003)(11346002)(446003)(97736004)(36756003)(2900100001)(2906002)(8936002)(305945005)(217873002)(7736002)(86362001)(8676002)(86612001)(256004)(71200400001)(14444005)(71190400001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0119;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GRbLgmdLFTnMXqJojZYxZGTQCZ5LSuSyKq/KXMKYQ7QxYRFtQMQLTyxsbLqpivHkCk56kskFM5F7The9+8jLTqoHjkixPlSSFYoNMcD0dFN28ycMa2Tg0WWtbpJzKqo90NWkkE+PcjRK/QlcibD42jnoSODup3MZ/Dijwl0cNJXrXkY2Sy+Bt682+isfDqwagqnuktUVYsZyQXdEVl6/OiGi6OxpXHgZJLGwZjqeLwmvXLwhy5OYfUw+3qiLuMjjLqEI3+zT58sKsxkxmJ7xSxsFBa51U0Ji2HoOdaanyY+4aw6e/tqKOBVaJYCcCQW5Dgx86usRUVOxOvwGeaIRZmHUs14XW0u5vQ/1QDrHSvI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 875a59d5-6ad5-4e93-f22e-08d61ea38f8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:06.9291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit ff924c5a1ec7548825cc2d07980b03be4224ffac ]

Fix the section mismatch warning in arch/x86/mm/pti.c:

WARNING: vmlinux.o(.text+0x6972a): Section mismatch in reference from the f=
unction pti_clone_pgtable() to the function .init.text:pti_user_pagetable_w=
alk_pte()
The function pti_clone_pgtable() references
the function __init pti_user_pagetable_walk_pte().
This is often because pti_clone_pgtable lacks a __init
annotation or the annotation of pti_user_pagetable_walk_pte is wrong.
FATAL: modpost: Section mismatches detected.

Fixes: 85900ea51577 ("x86/pti: Map the vsyscall page if needed")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/43a6d6a3-d69d-5eda-da09-0b1c88215a2a@infrad=
ead.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/mm/pti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 946455e9cfef..3ce60d123f5d 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -235,7 +235,7 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long=
 address)
  *
  * Returns a pointer to a PTE on success, or NULL on failure.
  */
-static __init pte_t *pti_user_pagetable_walk_pte(unsigned long address)
+static pte_t *pti_user_pagetable_walk_pte(unsigned long address)
 {
 	gfp_t gfp =3D (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
 	pmd_t *pmd =3D pti_user_pagetable_walk_pmd(address);
--=20
2.17.1
