Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FA5ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300B92147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nn7J8Atp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300B92147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbeIQI75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:59:57 -0400
Received: from mail-eopbgr710095.outbound.protection.outlook.com ([40.107.71.95]:52685
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728878AbeIQI03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqrQIHs9n5GfZs8qJcEi8Dtcw9ERCcNQi5Gm+ilmycM=;
 b=nn7J8AtphTXyoR7GJmW5UIB0TFP55JEaS25vaQlGk9GXYROlED2Mrh52c9cXs0FYxi8vdN36cBlWHMtzJSQ+9Bd4dbRbp3W3akJC3FG9YJY4jfHwM/DLpwUo6AI+zEWx5ivmDPpv1BpzGCrOZQu8OHh2YOzmRNiJBVuJFAVKZbM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:01:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:10 +0000
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
Subject: [PATCH AUTOSEL 4.18 045/136] x86/entry/64: Add two more instruction
 suffixes
Thread-Topic: [PATCH AUTOSEL 4.18 045/136] x86/entry/64: Add two more
 instruction suffixes
Thread-Index: AQHUTjKdX15w+wQBS0yjkq96oGbzlg==
Date:   Mon, 17 Sep 2018 03:00:40 +0000
Message-ID: <20180917030006.245495-45-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:lG7qDVLMNtyUCxvj2ctSMjq8Ilgjg4VsR7t2FbEUeqyq3O86T/FIWzqMcLM8am8Knv7ddi8MZbPWGawt9InYBlRXIHxKrhLXKEekyu2NPvpQYqeLMRi8Qi6kmbDFblQT/ut3eVZYEEp+l1X9mvfMLCOmTsNW86Uf/wQX0vLwATkW3Bz0Rt+dQnADMFNRl5g2IjdcA1b9kVEy5hTvNCzgPfeCEK4wl7dU7iaG9iWvaYamRmmy8WNkxwbB0DZ6Q/q3E/y0HrkVZFJDYRPlsfbgmhTV6do48ZKCQ9O3Azp9Lk2heSCbXTpsG2Zi3qi+SrbTaYT7kBg9Pb7Al21FHa4Ytvznaainzqxl3UUqILTabZA/VQYceJDvxQuq/vzFU7a+taML5VjM2Zpz2LqERK7/p11i4fsIBxHFCVJ78dgCQNGwDadFPcIQC96+eAgYhA//zOhz/JD+lUawRcdBD0Jbrg==;5:Bt3U6BsJ5fgRZJRaw3y0qn/Ji52nClaQWHF3JxCUaTw5liXuSL9CkVwWphhCAIL6r1jw0h3hI2wrkI5/btWXobs7cBkS7cMK2OFTXCGNIfpmtvqO7AmQvZReFkxJUHenMBy83tjlKdNeQ8uZ6MurrzGD3W8TN1AuSsDPdnEHfBE=;7:kW2fI3Rs9k6jRrvr6eEJwukU4lmS/nrYn+SeCC3Ft5xZfRQmeFZWqNCb7nku5MBzcIIhyYHuQDvvX4VG+6jCd35msSdEBjPeUfiXA6kDBOKHYvzAtITyElyybQ4bqQR+h7MzMBnTEK7Z6I83VrsTuYnsVUFSjud/2EUOhNNRFzrkd5gwkOYgmWI0Eb48HeQjULIMFUEYAC1FtFFI+q/nSUpKLyT4wRt3oEtQ7QhFleGVlltPAzCXDznl1652O/1T
x-ms-office365-filtering-correlation-id: 6f788855-dd4e-47a3-a280-08d61c49d23d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB0167DA283648CF69F3B6D00AFB1E0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(6116002)(1076002)(86612001)(4326008)(97736004)(53936002)(2900100001)(7736002)(107886003)(106356001)(10290500003)(81166006)(105586002)(68736007)(3846002)(39060400002)(99286004)(305945005)(36756003)(8936002)(2906002)(7416002)(217873002)(54906003)(86362001)(110136005)(25786009)(316002)(5660300001)(6306002)(102836004)(66066001)(76176011)(478600001)(446003)(11346002)(2616005)(8676002)(486006)(476003)(6346003)(186003)(26005)(6666003)(6506007)(966005)(6512007)(5250100002)(6436002)(10090500001)(6486002)(72206003)(14454004)(256004)(2501003)(22452003)(81156014)(357404004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: fhfANJoZ2t9GfbPqXh3U3AvnGWten7xSS/C1j2pVqs/12133/C7MQGdYVTaIskiwpEsWePrB2d6wAgGdvSEYu+wZbQwyoFNaZFqnd/trN8JZD1isXuuyp94gefuoMTgQlmu9L6bmlYsvbHqjnjmW1ykGJrYgUyT7vLFHYGVanhNOYaxwsQ5PDXYFdaqeu4hAJ2NeA3hKMU7Bs0zIWoXqzNwPM0fcy+bIVtYXWsunI1Bct+YicjQQpqrN8nNKz0hZgrzeZRjYzSa5FTLaXEPMB8CT7GkVDGs7clmJquYhjHHS2iZ3WmEbunpoHyBTWjcnQumZr2oqrJwg4Kctc5olqyHOV5w38MoG1mjqR2zrZQg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f788855-dd4e-47a3-a280-08d61c49d23d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:40.7296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
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
index 8ae7ffda8f98..0ab33af41fbd 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -92,7 +92,7 @@ END(native_usergs_sysret64)
 .endm
=20
 .macro TRACE_IRQS_IRETQ_DEBUG
-	bt	$9, EFLAGS(%rsp)		/* interrupts off? */
+	btl	$9, EFLAGS(%rsp)		/* interrupts off? */
 	jnc	1f
 	TRACE_IRQS_ON_DEBUG
 1:
@@ -701,7 +701,7 @@ retint_kernel:
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
