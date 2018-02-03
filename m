Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517683617-2-12390030107587572160
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683617; b=T1CBW1yjocmIlGws8mAEx9mArbujLSYlOpHksGzxusKTIca
    jEbWkSNc/i4eG1x5NnIig2QEyhqYlhU6TjxJqpEM/He7H61fqRSN2QrErbzPpadN
    3n+pCaPr3ANXjsPJ82SwOm76YnBratzrr2bSSdU9FFNk2N99BFmOB3y4Z9jffLlG
    3ZSVlEuG28r4NgkTdHzMOYyifScY2C9WM2xV5Xq4rBbwIZisBi21rlFNpGswaj/S
    xe7++2d6uwIwsgNsKpxeRFXSPXc3KOKJb+NcnQuaKzB2gp9mhvk1vKAlr+WJZeif
    Fp8h4UhMVltHniE7mjlfOkUNDusEPS7V472xu3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683617; bh=CCNF3g
    iUxfrm4UP3GX5Vti0h2xDWSj4xqE8hlZQtX2g=; b=ZFi9Gi/IPWjnuvereGfmbA
    aP4zAXED5k/rPsq+bhTyHTV6rKn7+0Bz8k+SLp8JJiU6dgYrEriA5J6DzNRNZUD7
    9myG2y40F6x5Hk3Bpd/jNzXH3qXKrUsZ7azOHx5LABUZe+bwJt0QbEVyGhuJ1BzY
    pJ4oPkvRGGbMJ61nqPtCmITGKjfh0hz79PuTUhkAWPcXGcxNbPyoD0KqaPAfLe36
    zl7raOkrZbH1PuWJpGG+9O6bQ21BimcTr76ckGNVzFse7X4FXDT/WdW/1aAvX3OI
    F2yu5kDPZWIt+b6L96aHVojhhZlHdfRF5qPYbMt4dahHdd9E22Z28t1A38A8MdbA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nXi5FG0l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nXi5FG0l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755164AbeBCSqv (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:46:51 -0500
Received: from mail-cys01nam02on0100.outbound.protection.outlook.com ([104.47.37.100]:41422
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752887AbeBCSB1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:01:27 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 026/110] x86/stacktrace: Make zombie stack
 traces reliable
Thread-Topic: [PATCH AUTOSEL for 4.14 026/110] x86/stacktrace: Make zombie
 stack traces reliable
Thread-Index: AQHTnRjnQM2qb6J8PU6b0fMKf8JPLA==
Date: Sat, 3 Feb 2018 18:00:40 +0000
Message-ID: <20180203180015.29073-26-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1090;7:3BnWLlgQKeraEsVpjNSf+lGjoxautbp1+f9qvsAjRVudU5vADl9j5+UA7KBN0ayM9JpUarTS2bgCDzH3KW4V3p52KDvM3Gs6DdFWBXvPN3d5HMjL8DNu1hCsnnNwuD0FdW4sndVVVqjOV+sDBXRk3opLd5EOmPRYK6UPCFXUAJGcEFcaGPdgbNaqsaksUTNDk0ItvgEsPpVIEBOQTsqSfZEA4NCt0phcX1aWlrpJgeWWEgovDI+QO3OP2DQc9aaa
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f44c351d-5311-4b42-220a-08d56b300b06
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1090;
x-ms-traffictypediagnostic: BL0PR2101MB1090:
x-microsoft-antispam-prvs: <BL0PR2101MB1090B0510A122015DC9807D9FBF80@BL0PR2101MB1090.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(9452136761055)(42068640409301)(211171220733660);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1090;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1090;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(2900100001)(5660300001)(316002)(25786009)(4326008)(14454004)(2950100002)(478600001)(966005)(575784001)(107886003)(72206003)(22452003)(10290500003)(186003)(3660700001)(86612001)(76176011)(86362001)(53936002)(3280700002)(106356001)(6436002)(6486002)(59450400001)(81166006)(81156014)(2501003)(6506007)(97736004)(6306002)(26005)(7736002)(6512007)(6346003)(102836004)(105586002)(68736007)(8936002)(5250100002)(305945005)(36756003)(1076002)(6116002)(3846002)(8676002)(110136005)(66066001)(54906003)(2906002)(10090500001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1090;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: Mrc/3dKbvKMjjlnCiePfKe5KJw7IAKNd/YUI+RbgvmVRHQMC0F4dON92dmscaRj0+ZnxR9+OuA1ayLJ4GwEShw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f44c351d-5311-4b42-220a-08d56b300b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:40.6752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1090
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Josh Poimboeuf <jpoimboe@redhat.com>

[ Upstream commit 6454b3bdd138dfc640deb5e7b9a0668fca2d55dd ]

Commit:

  1959a60182f4 ("x86/dumpstack: Pin the target stack when dumping it")

changed the behavior of stack traces for zombies.  Before that commit,
/proc/<pid>/stack reported the last execution path of the zombie before
it died:

  [<ffffffff8105b877>] do_exit+0x6f7/0xa80
  [<ffffffff8105bc79>] do_group_exit+0x39/0xa0
  [<ffffffff8105bcf0>] __wake_up_parent+0x0/0x30
  [<ffffffff8152dd09>] system_call_fastpath+0x16/0x1b
  [<00007fd128f9c4f9>] 0x7fd128f9c4f9
  [<ffffffffffffffff>] 0xffffffffffffffff

After the commit, it just reports an empty stack trace.

The new behavior is actually probably more correct.  If the stack
refcount has gone down to zero, then the task has already gone through
do_exit() and isn't going to run anymore.  The stack could be freed at
any time and is basically gone, so reporting an empty stack makes sense.

However, save_stack_trace_tsk_reliable() treats such a missing stack
condition as an error.  That can cause livepatch transition stalls if
there are any unreaped zombies.  Instead, just treat it as a reliable,
empty stack.

Reported-and-tested-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: live-patching@vger.kernel.org
Fixes: af085d9084b4 ("stacktrace/x86: add function for detecting reliable s=
tack traces")
Link: http://lkml.kernel.org/r/e4b09e630e99d0c1080528f0821fc9d9dbaeea82.151=
3631620.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/stacktrace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 60244bfaf88f..4565f31bd398 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -160,8 +160,12 @@ int save_stack_trace_tsk_reliable(struct task_struct *=
tsk,
 {
 	int ret;
=20
+	/*
+	 * If the task doesn't have a stack (e.g., a zombie), the stack is
+	 * "reliably" empty.
+	 */
 	if (!try_get_task_stack(tsk))
-		return -EINVAL;
+		return 0;
=20
 	ret =3D __save_stack_trace_reliable(trace, tsk);
=20
--=20
2.11.0
