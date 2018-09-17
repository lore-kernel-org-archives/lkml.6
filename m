Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C5BECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C174F2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="X/skvbHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C174F2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbeIQI3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:31 -0400
Received: from mail-eopbgr710114.outbound.protection.outlook.com ([40.107.71.114]:1680
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728972AbeIQI3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFiVpv1R36kTLjJ1/1r2sDt26btQErpRlIAtEEDyJDA=;
 b=X/skvbHf+E5t+71chk8EmRfenYTtXrxlaJCKdRdZwYiYPUr2AIBchJyY0AmOpOHWcyvCKQOPS8SRvOEdBDrAaWJzGEym1uezcK7ELcyXcju0S09dJlkNHC7H/F8+ViXCVO6W71dwTYkeuf6kbyKTMV8koHEyAv/wnll907Ep7bg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:11 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:11 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jan Beulich <JBeulich@suse.com>, Jan Beulich <jbeulich@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 32/87] x86/entry/64: Add two more instruction
 suffixes
Thread-Topic: [PATCH AUTOSEL 4.14 32/87] x86/entry/64: Add two more
 instruction suffixes
Thread-Index: AQHUTjLn8phYbrlLBEiME+irhSkFCg==
Date:   Mon, 17 Sep 2018 03:02:44 +0000
Message-ID: <20180917030220.245686-32-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0776;6:1HTfndq0urZt8oCePL+5RmQv/I3EtD/9I8/59D23w/Aq9oqR7UhijT1zw9g4wJTMWCEN5yvmEAubtGxPHbCtJhbB6S6C5ugDPp8Qt7xuR6wVLl3XQlBM/RciX5LNQQwQBKW79ZUnyQbb6oLifh8EDcEpW3YivsTy2p0nq/wUdm3l5FhgJSUhmRi4q3O7J/2AXnempb5VSdfOE5XhKvpB+dBdzopoWi/F0udg45aHENvSrc6BHWvJ/OpIySgEr98tGY9roLf5Fg4fjo2i1IKEinA/1t+0Zl1WLr21aSzri7QRICGLm664QEt/sslRDAmMobL5byOj4w3DNMmuAjHgplzhW0GQFBVUlVyww0GwxBg1B20G5+6WbqFpTJMDhGZWyOVaUCe8O1zZ15PegSwTUnvrq+e4KSATIMNYQIxnYuz8uSgbQgElVl1vModn5bESmWt2q8u2XcqxeMN33HeYug==;5:XIJhWm2NvD/bgU0ejB8eOCZfAYI92+z+E1oG9B+ShIPsrt2rNZVb2PEOtk39Dj/lvNg79BF2H4JWik331I33DSnHq2p3GndRI5EKfZwDVZfjvApxCCLcrZDTBKEUGATfu6h8JqH8overrozRNXq36z4BM1v4dNYJG81rJc1uVCo=;7:Ai7ZWoTI6tylijGYsMYaGUiYNI9mv7K5aqw1qPEMQBAHnuIIdOCOYevD3q+06IK8bUIdkJsOseaAy962yk7y/Z9AIye42CvSd3hN8X2EtrHU79T6AMaj8bntHzt/ze9b+epACo6hJI+HnpnMSwSpJeaBGuYo55s+wLHONZKcYzw7KGTkrhlalWXp8TPOpM43OyHnDuR8E/4ZPoVSs3JQhgvkAfeEpS+VxHf1p5Z7vs06H9YJgzEcYkLVneSZkIQ1
x-ms-office365-filtering-correlation-id: aa4cc6f1-8056-4f4c-8c5f-08d61c4a3e56
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0776;
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB0776A1322AFAFFBCF04705B7FB1E0@CY4PR21MB0776.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0776;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0776;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(5250100002)(53936002)(966005)(72206003)(14454004)(102836004)(478600001)(4326008)(6346003)(2501003)(25786009)(6666003)(10290500003)(110136005)(54906003)(6436002)(66066001)(8936002)(316002)(107886003)(76176011)(2906002)(217873002)(6116002)(3846002)(22452003)(6506007)(486006)(5660300001)(7736002)(2616005)(11346002)(446003)(97736004)(476003)(6486002)(105586002)(6306002)(81166006)(99286004)(186003)(81156014)(7416002)(575784001)(2900100001)(8676002)(86612001)(68736007)(86362001)(26005)(36756003)(305945005)(256004)(39060400002)(106356001)(6512007)(1076002)(10090500001)(357404004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: cUgBb5agSBDcCvJLOhW8BVEo91LDLOjUguauFTezK1pz9jNG9keIi5MblXRuL4mVJOVCdUDPXyYP+TiEjCEy5pxH+Z1jglwsHVEijU+JoTmR63BEnqSA15DVYSfzxTnPhgrD4UOkpc5xRRWKGBwL8WOVu5YkvLwa8Yi1y7U9e5UzxlzqVkOd7Buw8GWNcyFkdNv4tAppkv6P2X7WRCPjpozSGzfKPa8TcJqghsXpqe+a0ovMWMVpAuVFgsfAGFyYkPL9Jj1lrSNEO0n7PaRMUww8/7Hg7ZjGCDgeSEsFepgaYxHks/HSAlOVvAVVqN5q+toNRTmWysfZgdZRdlTCXCCvGggHYj5w/YX9wooOdYY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4cc6f1-8056-4f4c-8c5f-08d61c4a3e56
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:44.2906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Beulich <JBeulich@suse.com>

[ Upstream commit 6709812f094d96543b443645c68daaa32d3d3e77 ]

Sadly, other than claimed in:

  a368d7fd2a ("x86/entry/64: Add instruction suffix")

... there are two more instances which want to be adjusted.

As said there, omitting suffixes from instructions in AT&T mode is bad
practice when operand size cannot be determined by the assembler from
register operands, and is likely going to be warned about by upstream
gas in the future (mine does already).

Add the other missing suffixes here as well.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/5B3A02DD02000078001CFB78@prv1-mh.provo.novel=
l.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/entry/entry_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 0fae7096ae23..164cd7529f0b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -88,7 +88,7 @@ END(native_usergs_sysret64)
 .endm
=20
 .macro TRACE_IRQS_IRETQ_DEBUG
-	bt	$9, EFLAGS(%rsp)		/* interrupts off? */
+	btl	$9, EFLAGS(%rsp)		/* interrupts off? */
 	jnc	1f
 	TRACE_IRQS_ON_DEBUG
 1:
@@ -630,7 +630,7 @@ retint_kernel:
 #ifdef CONFIG_PREEMPT
 	/* Interrupts are off */
 	/* Check if we need preemption */
-	bt	$9, EFLAGS(%rsp)		/* were interrupts off? */
+	btl	$9, EFLAGS(%rsp)		/* were interrupts off? */
 	jnc	1f
 0:	cmpl	$0, PER_CPU_VAR(__preempt_count)
 	jnz	1f
--=20
2.17.1
