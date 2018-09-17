Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AFEECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC462147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IlCp11j/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC462147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbeIQIcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:32:43 -0400
Received: from mail-sn1nam02on0110.outbound.protection.outlook.com ([104.47.36.110]:23375
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731337AbeIQIcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvkNrvqkK+IrXLFsI9r9Y7VrpGEYMTsawoCSsyIpxTg=;
 b=IlCp11j/aSfXOZo+lziNdRgciZRVkXdHI7pEbtwHS5elN8WfVt5hOb8zZIPYLRbuMF00pdvt6zaiM6IayYkym0DhRCk/EdaXLqJII91md+iknCGDD/r5+QZWHgEqKS43gPfv+SOqudF8CqVXB718S3BWOP/CVyz8eykHKwPnL9w=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0742.namprd21.prod.outlook.com (10.173.189.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Mon, 17 Sep 2018 03:07:07 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:07 +0000
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
Subject: [PATCH AUTOSEL 4.4 16/43] x86/entry/64: Add two more instruction
 suffixes
Thread-Topic: [PATCH AUTOSEL 4.4 16/43] x86/entry/64: Add two more instruction
 suffixes
Thread-Index: AQHUTjM3+poaoU+TmUqYdKUYRpgd3g==
Date:   Mon, 17 Sep 2018 03:04:58 +0000
Message-ID: <20180917030445.484-16-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0742;6:HPfpbVNwAG3YH1sUm4LECFScubQMsBS/oL9K3V60PAux4bStC8k5UYhqsurjAaZqqS6oo2bD4xUgf5qj9RnGN7WLbpYcwa7FvdZjZf+XNIfnrQ5B3lMCyJl0AKlBpWhEkJRNOLAbe16wyrInYp4Zp3DmS44JCFDE1Ts1/uvxbjSgJ9qaFN3QacjGmJWgHF1SaQeMXD0D6p6M9FjVYnB6oJLd0H/6SznBtlodrMZO9750Cyzvnvi8MOtB+36Lgv+FghSx5qFxG/HO+6GqxB1VyhLiQsaLF35i77tbhkTBjnZrCMPE05OgDggyNyDuHEtw1q28uY/N8aU39nbIHgma8Dr8l+NP7oDd9WL8FYje1aHnroLNIvU3eeTvXIhs6m8DNkoKVgKsm+rDq/Deozd43xpVHPamusNVg4mP7KeTx2j+WqjI2OgQ5jqLpbBIeA/UbcydbX1a5xCMzIP2l70mQw==;5:Gb0xgrDOeQLVjNrMycijUnK2zbI3AY5Rr09Jza9gDmdoPkhnzeucGSb6u/9JcF5G987ymwzamAc68fHI84/6lBJbooc9rty5gawECasYjc1BagDhzZx0iaHBFjgIy12hxQ0tixVlRhIXy8YyNtzHTL57aGJ7qllGKCkBGjwlPJM=;7:rZ6ZSZGMa9Nw6AjBjLaWr0DtFSREphTdQ4/pH2SnVAgs0qlofetB/C9/DtHOaOpOZ+lHUvziP42CbCwbKER+QH/LJtQFluCuI75xemLyQlroBpXqSt2zaOpQZnfd2kJQsgzCZRea1+ulRIBS//oF1Y9cjvS8pJmb5mg6F99BYkzTTRx/JkwLDmo+7YHGJynps3C1QXM/i4MnJe9XMSpacRADQ7VZ1Z4UuOQV8tezPUrN8uVLSD+kcHmsop6yWznU
x-ms-office365-filtering-correlation-id: 15d83608-d9db-4027-50c0-08d61c4aa6cc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0742;
x-ms-traffictypediagnostic: CY4PR21MB0742:
x-microsoft-antispam-prvs: <CY4PR21MB0742C8E9CA99D852D9FF2CE7FB1E0@CY4PR21MB0742.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0742;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0742;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(6486002)(6436002)(6512007)(6306002)(53936002)(4326008)(3846002)(39060400002)(217873002)(25786009)(2616005)(1076002)(6506007)(186003)(6346003)(11346002)(446003)(26005)(2900100001)(6116002)(486006)(102836004)(256004)(107886003)(476003)(86612001)(86362001)(2501003)(14454004)(97736004)(66066001)(76176011)(6666003)(316002)(54906003)(110136005)(99286004)(68736007)(10090500001)(22452003)(81156014)(2906002)(36756003)(8676002)(8936002)(81166006)(7736002)(305945005)(105586002)(5660300001)(106356001)(7416002)(10290500003)(478600001)(966005)(72206003)(5250100002)(357404004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0742;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: EjwuTvG+ukmKsW9vAFXX3U7vrD8Rs5py2hp/v0zeEomKt0wspSj4Fncxe7cWDN3/5VdDlQGb3b4b5Ieta+/A5xnru66aQoLxAAHisMyV1bGcbjYA+xFlWMoK8hQ8cNvbXIPp9P5pN9+atKoftAooVslr/SaHSNGEPVa22mJKsfcmBSfgeznIVBsyv7UhGt5NR7cYOMA75/1AwJ43NTS57wTxn2fYSpADkSAiKlp6stwEQdchM/cUSfuILDdXzJkA9bQqIHkAB/Op77xWheRRVe3iwF1Shfv5stPlcJ+4YZzyXCR1ZNeA5L6HOcsntit643o+yC/WNFiqRlmF65PwDhCRtNhh4Zea0FqV2I3UFmA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d83608-d9db-4027-50c0-08d61c4aa6cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:58.7111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0742
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
index 92b840c94f17..8be48b1d7596 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -90,7 +90,7 @@ ENDPROC(native_usergs_sysret64)
 .endm
=20
 .macro TRACE_IRQS_IRETQ_DEBUG
-	bt	$9, EFLAGS(%rsp)		/* interrupts off? */
+	btl	$9, EFLAGS(%rsp)		/* interrupts off? */
 	jnc	1f
 	TRACE_IRQS_ON_DEBUG
 1:
@@ -620,7 +620,7 @@ retint_kernel:
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
