Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C515DECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CA4208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="D4mti9vc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CA4208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbeIQIn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:43:27 -0400
Received: from mail-eopbgr710091.outbound.protection.outlook.com ([40.107.71.91]:43296
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729390AbeIQIbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T1pWTIBxYuibVDtIjs93kIWBHRqhX+WrFe8yxBWJNg=;
 b=D4mti9vcrub8DDjTW/+jnAx3/eeg1QNPwLmoxVbDWNT6OaFjdKB1QhU703TcRoblAw3eqHPkIdfahFUhKl4CQ2GsYdUqoIKTPyGHzJxoWf+4/1fpTOC4PhxTCFC9/bb1hyA0nXHPmaodlqbna1GFHERFawSC1PwDn7g9Th8USxo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.6; Mon, 17 Sep 2018 03:05:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:43 +0000
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
Subject: [PATCH AUTOSEL 4.9 23/57] x86/entry/64: Add two more instruction
 suffixes
Thread-Topic: [PATCH AUTOSEL 4.9 23/57] x86/entry/64: Add two more instruction
 suffixes
Thread-Index: AQHUTjMTXmpsYMNcPE6gUfdAls2QFw==
Date:   Mon, 17 Sep 2018 03:03:57 +0000
Message-ID: <20180917030340.378-23-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:VmIStJK0ln3NZKEpyRxEQg2NLt8rzb1Tnwo7VzIltAR0Qd8ZnCok6iDwpW3ZMgFlFX/nTu1LXd4thOy6t1pe/1HfUNKS4/TY+wrzafzgyuooO/yuWGQLEATnMn+K3BsbCg+RMDFqzmowIOfhbv+N5C4kJAYuZO+ij0FKwhh3L+8V8si8lDPUJp5KT4qnjgmThrfRaTf0M5PQ3EaLqFu0TixUCaoT+oNs+z11SNrKdsDuPsuuor+mkYPdKgs4kiY14EeXczUvy1TUAtXIfBXcbQC19BJ2C5Dq8Img4vlWVn1MfchrS6t7Df19AmlYXh8FDoi91ZhYGeoaXIRC7gK9CfzjnwZyBESZnwHiTTcjP1qTDQPB0J5PrKcfnm3PIM1wva8G1csRaL+DvRXX0dONkyIDOL7uDlm6byF9KY0EWVPwSKblSWfbC9OTT5981IcsUfJ/GYwOUd9ywDLGF+MlVA==;5:OUREGF6BnF1ET1k+ywIOFxuxCEAhKe6P712qAySKrRflv7P4qJJJbKGq9vNxjqWM8sIVGzGnRUUjlx8kyr+sla8L8asiv0pLG2diM2zGZTnQeqfjQPy0QlkW21iNcquHoF6veIXVnkLxveZF4dXJQUbMsPvdBe3Q5eVXvG0blaY=;7:71f13DsrlLDsSxk0VTN7Xc5pWMsheqOFou/4DvnlgAnDAN8V1w1n7JguuY5V6fVc8h8dBGn5hU1bya6Ij4j/Q/YHFzj+HI19q9FexzMToggupuIglVEHYceCXuM95AaGe8zWQxEddj355VubXA39jRwEuRFOiJg2xAqDpWaqpLnEjRa6Za5CDHhPumJNLK7EFGm/CLqZedt/haUtyg/avL/HkEkelEv20ZO5YIPL2Y67pRCKxuCxMSLkEkIuagyY
x-ms-office365-filtering-correlation-id: 12a9aab6-01b1-48ba-d134-08d61c4a74fd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB07576B1416B590FAF6C3A98EFB1E0@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(7416002)(8936002)(68736007)(476003)(10290500003)(446003)(53936002)(11346002)(6512007)(486006)(86612001)(6436002)(6306002)(1076002)(256004)(6486002)(2616005)(81156014)(81166006)(7736002)(8676002)(217873002)(478600001)(305945005)(3846002)(6116002)(86362001)(4326008)(106356001)(66066001)(186003)(36756003)(99286004)(76176011)(102836004)(107886003)(26005)(2906002)(5660300001)(110136005)(54906003)(10090500001)(22452003)(72206003)(2900100001)(316002)(14454004)(97736004)(105586002)(6506007)(966005)(25786009)(6346003)(6666003)(5250100002)(39060400002)(2501003)(357404004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 5yYhojEiz0yHUHktQMDGNV+QKT140QSDTYMpMVQSRyDlwm62MFmnSQfFIxN50mYgpy+Tt6FahT9wsQ6UaBu7KUpkJ0YmezEmKQviTd+gPbnZ1bnYnRyKr9FG1uyMGNq1dI3QpjB13aqXomxlDuyROp9uXPw4XvlMOzZQDwOC17NdbMo6FMS86VrEtWVcVv94PNoeyR68e9U5Mb9MLZiNYFnGGrOmYtjHzQgZgWoLLKAEvjluszELSXzj1wxvup7MP92d7Yc4XQ8UQci1JtUKpZfDMzFSQ+c+1qCQAYHwoEbFqW1iRj7MZx2vVR39cgzXms5dZvV+JWQsC7tdNV+JABdmSiQ5FaztrGv4Nana+FU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a9aab6-01b1-48ba-d134-08d61c4a74fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:57.7272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
index 76c1d85e749b..870e941c1947 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -91,7 +91,7 @@ ENDPROC(native_usergs_sysret64)
 .endm
=20
 .macro TRACE_IRQS_IRETQ_DEBUG
-	bt	$9, EFLAGS(%rsp)		/* interrupts off? */
+	btl	$9, EFLAGS(%rsp)		/* interrupts off? */
 	jnc	1f
 	TRACE_IRQS_ON_DEBUG
 1:
@@ -485,7 +485,7 @@ retint_kernel:
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
