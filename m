Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523246551-2-17105065264348388843
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246550; b=DVh1uyHvgqDNbKFN4u+67cMZb7i/BP9Lq0eJjwVF+5cKGGMgMM
    0zG0eAra+ApgSuRlcFtNG8T2y320N0ja4TN+DrnPfWPn0xt6ecQNJhcgyRHR+erx
    yZsSLeRQ4E3L9R8kIBXEADy2ZIM+rE0cIGUj7WirZtSqTxu9fvWJcHRKSyLcU7z4
    Ss1GS86Lr4ig5LenJLtEHo/uWt5rHMSUSsRT6fQwp73oYsWiHhmfu7u+v4ehq/Ts
    Ngk6fZYFwHz7GZw+hmt5uX973/wPC4xhA7+O82+8XTECXbnTWjv5ysuuQ3VX/s54
    0n32jqFLqlhSkPCpa+BnyTpUVvtKDb994L2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246550; bh=b7oU7pltBO
    ZygvXAKvHbxgpZEobg5oLqR7ozaae1wAs=; b=RFt7SWVlgbQbGLHMU+arKVHvF/
    aSVT5UQN+WMJnrS58UU9vuUF2qPJJewiFJioSRTXmxzhjxKVrZ6m9MABqoWERvij
    NOIssJ2P8RYVdpWJa0KFFJajATFyEwYgWBe+9aqDFxskLtRlmKBNFvW0zyikGPJH
    AOwoF7ZS15HI76huw12qtdElTp9unvvA6wUxgw64+uMMJfbtiEdj95WgIxsWmw1F
    V3GR8aWJ0jQcvXYLXCKUozip1B8nf25yBI2u4opMzNunLGW68O01zbq/AiyJO/2L
    Q9rfibhQWhHzejIGoizbCXiCNo4jFhgapoHrrbJfT9btFfgFdbXQoOZ4VL8w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CwneYLaG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CwneYLaG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNpVO+AwXKBZc5N36SbUdB+2o/00eWBzfjOt4H7iWO/us6cSx6LI+VHNAMpRUjFWcbtC/gRwF1nuWS+FU6mHknPxb9vEN6gc/c/POo5EaAiSXaThKWv1
    UbwjtDTt2uEll8c+ZJSUi0kBHqB9+Inz2OTEhoLc94gi+i2nZdpDzEJJpoCqb9n7lC4pc+DLI0FTqcRiS20Nl4Fct55aYL/kYSY+SWWoOtAtN4JHEzaJ0SjD
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=PHq6YzTAAAAA:8 a=yMhMjlubAAAA:8
    a=Mms6TfDC60qSBSoaxZkA:9 a=yQPeTgZ93WLvhUjq:21 a=GqJSaBoOKzVJ2F6P:21
    a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753364AbeDIASB (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:18:01 -0400
Received: from mail-co1nam03on0107.outbound.protection.outlook.com ([104.47.40.107]:43410
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753331AbeDIAR7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Vladimir Murzin <vladimir.murzin@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 052/189] ARM: 8738/1: Disable
 CONFIG_DEBUG_VIRTUAL for NOMMU
Thread-Topic: [PATCH AUTOSEL for 4.15 052/189] ARM: 8738/1: Disable
 CONFIG_DEBUG_VIRTUAL for NOMMU
Thread-Index: AQHTz5gkj7QvW1DtdkOIMoTR+QG0pQ==
Date: Mon, 9 Apr 2018 00:17:27 +0000
Message-ID: <20180409001637.162453-52-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:x/HlxY6DxMbeXu8JLXPR93XhikbZcpoqT0vySE8BDzX68ExJyhBmgi91yJN3G2Zp0bmJTOYmxuIX5KoMUjxbOqP/kUthc7/+1+C6NwEOO1GXfQ5nEGLgAcvCp58GCBZcv2Uhb+mpiutco17q3B+C42q/KANsEaOSSwH490vcPtxYvNh7907qB3ycj/Ahwnav3xg6L+TF8v8vFVdc4EeNX9M/ShC4jH1N/kXtCo/R2odoFIUAgSr6P28fI9jFKfqH;20:43DeBi97kP0R7xXlWNnEAuXf5zO2VbbhVnali8RLmFfZxjSf7liTKayo3gbSmfZNFrzwbOssvf7werD0hECuSFvhk7Ikho27Ji03J0G3aB8R+RRYcDzzmyjpsrAZ80GN4O2nCm8hsF+JMF+D5ZoOJIEpH8QG1xnuKyvp6iGgTP0=
X-MS-Office365-Filtering-Correlation-Id: 41f49a43-4840-4a44-51e5-08d59daf563a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1046EF3DF23D22E1F25B4D68FBBF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(36756003)(186003)(11346002)(446003)(476003)(2616005)(7736002)(5660300001)(26005)(10290500003)(478600001)(106356001)(6666003)(68736007)(10090500001)(54906003)(3846002)(59450400001)(22452003)(6116002)(86612001)(110136005)(99286004)(86362001)(72206003)(305945005)(76176011)(102836004)(6506007)(486006)(316002)(3280700002)(3660700001)(81166006)(81156014)(8676002)(2906002)(14454004)(2900100001)(97736004)(6486002)(8936002)(1076002)(6512007)(6436002)(105586002)(25786009)(4326008)(2501003)(5250100002)(53936002)(66066001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Jdy2wPl14AHVZwswVrpZaKkuNd+jLbkx/IRRw+TmFBsqfYSeExBPeDKAIKuQhqxAy05xk1LjZcgxq3N204yGE2MnMF8y3JgHbjd1Z6EE77fCJTTbXBxh66LrUbX4J4TCGQxkJqVsbYCnS8jhDbdAbV7Lcey/YxSnAhTSRxg5zmvIh0ZBl6yjG/UuM1Za0Tv5xXv6zC8bJts+plPNaA0scVmxNzffxQCKPJfN1gWYkBLRXNgjxgxZ63mbhCBMBaF0BCvns5oF/dWcegIbQzqe3euqtKiMaTsXI6XHkD+BHxb8rPG1Zzmk6w04lPWiVNxN1F3JY+bUIxSDdwmytFF9ylPdQ5mn81Ca2Xt0NbKkpn2IpLuHfP04fXFFmHuDC6uhXcuLyXghC9lXicMolig1gbTnRgcFY9wMzhTF2J5J2Yw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f49a43-4840-4a44-51e5-08d59daf563a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:27.1191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vladimir Murzin <vladimir.murzin@arm.com>

[ Upstream commit c7780ab56c091a9ba95a3278e6e1d9c73afb5052 ]

While running MPS2 platform (NOMMU) with DTB placed below PHYS_OFFSET
following warning poped up:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at arch/arm/mm/physaddr.c:42 __virt_to_phys+0x2f/0x4=
0
virt_to_phys used for non-linear address: 00004000 (0x4000)
CPU: 0 PID: 0 Comm: swapper Not tainted 4.15.0-rc1-5a31bf2-clean+ #2767
Hardware name: MPS2 (Device Tree Support)
[<2100bf39>] (unwind_backtrace) from [<2100b3ff>] (show_stack+0xb/0xc)
[<2100b3ff>] (show_stack) from [<2100e697>] (__warn+0x87/0xac)
[<2100e697>] (__warn) from [<2100e6db>] (warn_slowpath_fmt+0x1f/0x28)
[<2100e6db>] (warn_slowpath_fmt) from [<2100c603>] (__virt_to_phys+0x2f/0x4=
0)
[<2100c603>] (__virt_to_phys) from [<2116a499>] (early_init_fdt_reserve_sel=
f+0xd/0x24)
[<2116a499>] (early_init_fdt_reserve_self) from [<2116222d>] (arm_memblock_=
init+0xb5/0xf8)
[<2116222d>] (arm_memblock_init) from [<21161cad>] (setup_arch+0x38b/0x50e)
[<21161cad>] (setup_arch) from [<21160455>] (start_kernel+0x31/0x280)
[<21160455>] (start_kernel) from [<00000000>] (  (null))
random: get_random_bytes called from init_oops_id+0x17/0x2c with crng_init=
=3D0
---[ end trace 0000000000000000 ]---

Platforms without MMU support run with 1:1 (i.e. linear) memory
mapping, so disable CONFIG_DEBUG_VIRTUAL.

Fixes: e377cd8221eb ("ARM: 8640/1: Add support for CONFIG_DEBUG_VIRTUAL")
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 51c8df561077..2c7e23e206da 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -4,7 +4,7 @@ config ARM
 	default y
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_DISCARD_MEMBLOCK if !HAVE_ARCH_PFN_VALID
-	select ARCH_HAS_DEBUG_VIRTUAL
+	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_SET_MEMORY
--=20
2.15.1
