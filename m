Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517680873-2-6064104669951608420
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
    t=1517680872; b=AmH9lbHDKyR0ouLAuRnV6VU8VQKAkLNJyUiBo+WcWdTGv4m
    JKP9l6zTb6RORhTGS24gBJ/y8UVcEeeYLkUbKtL1sM9KuAyuHHy/F3eM9Y0OYyiN
    UKWPQwtNDvsbnXTGHA2bJ8kIh44VP0ey8o4eUVSWSbsrFcnhulvAnhs0ER54V3/7
    YrvpL5a40ecuoh12+d4NsfCX2O9dGVO7Wl4V25iQ/NzHaJDKdKQx+A4XXBpAftbE
    0UL8tEMyoAWw/n5nji9u+Cgek1sVC8iuaP3h5mEfebhKCQ8Y/TnzyFP5bPHKElhj
    Ast3z1x7nQMyO2TPqBom96w+J9ng1FYxEPVTxIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517680872; bh=iYRoQZ
    qQhsPjjJ+DL4lggxnulfjr9NTJqMEg4zgHfSo=; b=bSg3L1hqWCItJcw/5NTaON
    z1SXJBHnVlqAM4RwhRLOTW+f1wHRgAHu9hNBS85zdvpoVtsrnTDuF/Q7fyShARy/
    3KPkd0yQBF0OrZafZeJjR23ZtWaX+EtNWHyyKclc8pkCoKuAxsruiOUzxfqwlb8Z
    KBEpVhc/qZW0f0HBedjnTW0y+mYArsTmapmuUq5bp7Yk6BVqjzOHUlRnksqy2Kek
    wb5qZXbSLiR0dd/8aCZRe2oqU8Dg++1sW3vJf7upgeWydJNCKLcxZFUHVycg+nj4
    ux54zngww1GCMoiWhW76eQjImbFxHd2bUWiTCO5R71XDvYZR2umTGCIrOCla6inA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X1QuL6og x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X1QuL6og x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752790AbeBCSAv (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:00:51 -0500
Received: from mail-bn3nam01on0138.outbound.protection.outlook.com ([104.47.33.138]:24890
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752701AbeBCSAh (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:00:37 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <james.l.morris@oracle.com>,
        Aleksa Sarai <asarai@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 002/110] exec: avoid gcc-8 warning for
 get_task_comm
Thread-Topic: [PATCH AUTOSEL for 4.14 002/110] exec: avoid gcc-8 warning for
 get_task_comm
Thread-Index: AQHTnRjeVAhaflsiyEOekqP+FhUEyw==
Date: Sat, 3 Feb 2018 18:00:26 +0000
Message-ID: <20180203180015.29073-2-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1043;7:6XiaaNVSnhoOsQdRLH48DO2u1JGSrAmLX5vQdM+iRQ9fihGDSdOLQjqmSto85mfeVywjZaZKD3YhA+uVhAbBZu/+IjypQ1imPfDvBgK/gRi2oFi1sHO6YkK3L7B+eOCGJ4N1GiFNuSUTy5/MxgNUYkTNFqquMFu1jistdQZurANNUX2FFrT4V8ptE8AYRqgmnGF6rBBtJquL44+JrPwwKYiEjeUAMPiSmEUHnNo6dt1iDH0WXf2CEWGkeh5WVXnL
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(59450400001)(10290500003)(186003)(6486002)(14454004)(1076002)(102836004)(6306002)(6506007)(76176011)(26005)(6346003)(66066001)(10090500001)(5250100002)(36756003)(6512007)(2501003)(110136005)(99286004)(966005)(54906003)(478600001)(7416002)(53936002)(72206003)(6436002)(316002)(305945005)(7736002)(2950100002)(2906002)(5660300001)(4326008)(106356001)(86362001)(97736004)(25786009)(22452003)(2900100001)(3846002)(107886003)(8676002)(8936002)(6116002)(3280700002)(105586002)(81156014)(81166006)(3660700001)(86612001)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1043;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f589e0f7-e9b0-4a13-ccf8-08d56b300170
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1043;
x-ms-traffictypediagnostic: BL0PR2101MB1043:
x-microsoft-antispam-prvs: <BL0PR2101MB1043DA5752AD43EF4F99604FFBF80@BL0PR2101MB1043.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1043;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1043;
x-forefront-prvs: 05724A8921
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: MBbTuUXYRn4qyKd+eaH2bFFr8tMYDIclYvxYKuoaWRVrvXsxb16j6ja+qp8TGGp84VOVgn7a+FltNxAQLvJ/Dg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f589e0f7-e9b0-4a13-ccf8-08d56b300170
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:26.4408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1043
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 3756f6401c302617c5e091081ca4d26ab604bec5 ]

gcc-8 warns about using strncpy() with the source size as the limit:

  fs/exec.c:1223:32: error: argument to 'sizeof' in 'strncpy' call is the s=
ame expression as the source; did you mean to use the size of the destinati=
on? [-Werror=3Dsizeof-pointer-memaccess]

This is indeed slightly suspicious, as it protects us from source
arguments without NUL-termination, but does not guarantee that the
destination is terminated.

This keeps the strncpy() to ensure we have properly padded target
buffer, but ensures that we use the correct length, by passing the
actual length of the destination buffer as well as adding a build-time
check to ensure it is exactly TASK_COMM_LEN.

There are only 23 callsites which I all reviewed to ensure this is
currently the case.  We could get away with doing only the check or
passing the right length, but it doesn't hurt to do both.

Link: http://lkml.kernel.org/r/20171205151724.1764896-1-arnd@arndb.de
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Kees Cook <keescook@chromium.org>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: James Morris <james.l.morris@oracle.com>
Cc: Aleksa Sarai <asarai@suse.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/exec.c             | 7 +++----
 include/linux/sched.h | 6 +++++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index acec119fcc31..0da4d748b4e6 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1216,15 +1216,14 @@ killed:
 	return -EAGAIN;
 }
=20
-char *get_task_comm(char *buf, struct task_struct *tsk)
+char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *tsk)
 {
-	/* buf must be at least sizeof(tsk->comm) in size */
 	task_lock(tsk);
-	strncpy(buf, tsk->comm, sizeof(tsk->comm));
+	strncpy(buf, tsk->comm, buf_size);
 	task_unlock(tsk);
 	return buf;
 }
-EXPORT_SYMBOL_GPL(get_task_comm);
+EXPORT_SYMBOL_GPL(__get_task_comm);
=20
 /*
  * These functions flushes out all traces of the currently running executa=
ble
diff --git a/include/linux/sched.h b/include/linux/sched.h
index fdf74f27acf1..41354690e4e3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1502,7 +1502,11 @@ static inline void set_task_comm(struct task_struct =
*tsk, const char *from)
 	__set_task_comm(tsk, from, false);
 }
=20
-extern char *get_task_comm(char *to, struct task_struct *tsk);
+extern char *__get_task_comm(char *to, size_t len, struct task_struct *tsk=
);
+#define get_task_comm(buf, tsk) ({			\
+	BUILD_BUG_ON(sizeof(buf) !=3D TASK_COMM_LEN);	\
+	__get_task_comm(buf, sizeof(buf), tsk);		\
+})
=20
 #ifdef CONFIG_SMP
 void scheduler_ipi(void);
--=20
2.11.0
