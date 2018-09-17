Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D696AECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D091214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D091214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbeIQVhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:37:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:2952 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbeIQVhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:37:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2018 09:09:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,386,1531810800"; 
   d="scan'208";a="75000925"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga006.jf.intel.com with ESMTP; 17 Sep 2018 09:09:34 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 17 Sep 2018 09:09:33 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.245]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.29]) with mapi id 14.03.0319.002;
 Mon, 17 Sep 2018 09:09:33 -0700
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v6 0/3] Harden spectrev2 userspace-userspace protection
Thread-Topic: [PATCH v6 0/3] Harden spectrev2 userspace-userspace protection
Thread-Index: AQHUSnfeT0puiyrK2E6YQSXOMBoQU6T0p9sQ
Date:   Mon, 17 Sep 2018 16:09:33 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC6732144EA58@ORSMSX107.amr.corp.intel.com>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809121055070.15880@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1809121055070.15880@cbobk.fhfr.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWI0ODQ2YjQtNDQ3Ni00YjdkLWI4ZjctZTMwMTlmMTJlOTc2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibVhrY3lwZUZDNGJcL3JKV1lvMkQ4ZGtmSlJCRnNJOW1qWVwvNnFFOFVCNjRaTGJmamhiaXZxS3BmWm5rWUYwbnlDIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: multipart/mixed;
        boundary="_002_99FC4B6EFCEFD44486C35F4C281DC6732144EA58ORSMSX107amrcor_"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_99FC4B6EFCEFD44486C35F4C281DC6732144EA58ORSMSX107amrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Jiri Kosina [mailto:jikos@kernel.org]
> Sent: Wednesday, September 12, 2018 2:05 AM
> To: Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>;
> Peter Zijlstra <peterz@infradead.org>; Josh Poimboeuf
> <jpoimboe@redhat.com>; Andrea Arcangeli <aarcange@redhat.com>;
> Woodhouse, David <dwmw@amazon.co.uk>; Andi Kleen <ak@linux.intel.com>;
> Tim Chen <tim.c.chen@linux.intel.com>; Schaufler, Casey
> <casey.schaufler@intel.com>
> Cc: linux-kernel@vger.kernel.org; x86@kernel.org
> Subject: [PATCH v6 0/3] Harden spectrev2 userspace-userspace protection
>=20
> Currently, linux kernel is basically not preventing userspace-userspace
> spectrev2 attack, because:
>=20
> - IBPB is basically unused (issued only for tasks that marked themselves
>   explicitly non-dumpable, which is absolutely negligible minority of all
>   software out there), therefore cross-process branch buffer posioning
>   using spectrev2 is possible
>=20
> - STIBP is completely unused, therefore cross-process branch buffer
>   poisoning using spectrev2 between processess running on two HT siblings
>   thread s is possible
>=20
> This patchset changes IBPB semantics, so that it's now applied whenever
> context-switching between processess that can't use ptrace() to achieve
> the same. This admittedly comes with extra overhad on a context switch;
> systems that don't care about could disable the mitigation using
> nospectre_v2 boot option.
> The IBPB implementaion is heavily based on original patches by Tim Chen.
>=20
> In addition to that, we unconditionally turn STIBP on so that HT siblings
> always have separate branch buffers.
>=20
> We've been carrying IBPB implementation with the same semantics in our
> (SUSE) trees since january disclosure; STIBP was more or less ignored up
> to today.
>=20
> v1->v2:
>         include IBPB changes
> v2->v3:
>         fix IBPB 'who can trace who' semantics
>         wire up STIBP flipping to SMT hotplug
> v3->v4:
> 	dropped ___ptrace_may_access(), as it's not needed
> 	fixed deadlock with LSM/audit/selinux (Andrea Arcangeli)
> 	statically patch out the ptrace check if !IBPB
>=20
> v4->v5:
> 	fix MSR writing logic (Thomas Gleixner, Josh Poimboeuf)
>=20
> v5->v6:
> 	propagate X86_FEATURE_RSB_CTXSW setting to sysfs
> 	propagate STIBP setting to sysfs (Thomas Gleixner)
> 	simplify arch_smt_update() (Thomas Gleixner)
>=20
> Jiri Kosina (3):
>       x86/speculation: apply IBPB more strictly to avoid cross-process da=
ta leak
>       x86/speculation: Enable cross-hyperthread spectre v2 STIBP mitigati=
on
>       x86/speculation: Propagate information about RSB filling mitigation=
 to sysfs
>=20
>  arch/x86/kernel/cpu/bugs.c | 60
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++------
>  arch/x86/mm/tlb.c          | 31 ++++++++++++++++++++-----------
>  include/linux/ptrace.h     |  4 ++++
>  kernel/cpu.c               | 11 ++++++++++-
>  kernel/ptrace.c            | 12 ++++++++----
>  5 files changed, 96 insertions(+), 22 deletions(-)
>=20
> --
> Jiri Kosina
> SUSE Labs

The locking issue with SELinux has a simple fix as below.
The other LSMs don't manifest this issue. With the change to
SELinux the call to security_ptrace_access_check() can and
should be made unconditionally.

Patch is attached, whitespace damaged (known problem) patch:

SELinux: Handle audit locking for PTRACE_MODE_IBPB

The SELinux audit code locking cannot be used from the
task switching code, which is where PTRACE_MODE_IBPB comes
from. As this is a system check, not a user action, audit
is not needed, and would generate noise. Use the unaudited
check for this case.

Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
---
 kernel/ptrace.c          | 4 +---
 security/selinux/hooks.c | 5 +++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 5c5e7cb597cd..202a4d9c2af7 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -330,9 +330,7 @@ int __ptrace_may_access(struct task_struct *task, unsig=
ned int mode)
               !ptrace_has_cap(mm->user_ns, mode))))
            return -EPERM;

-       if (!(mode & PTRACE_MODE_NOACCESS_CHK))
-               return security_ptrace_access_check(task, mode);
-       return 0;
+       return security_ptrace_access_check(task, mode);
 }

 bool ptrace_may_access(struct task_struct *task, unsigned int mode)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 161a4f29f860..30d21142e9fe 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2215,7 +2215,12 @@ static int selinux_ptrace_access_check(struct task_s=
truct *child,
 {
        u32 sid =3D current_sid();
        u32 csid =3D task_sid(child);
+       struct av_decision avd;

+       if (mode =3D=3D PTRACE_MODE_IBPB)
+               return avc_has_perm_noaudit(&selinux_state, sid, csid,
+                                           SECCLASS_PROCESS, PROCESS__PTRA=
CE,
+                                           0, &avd);
        if (mode & PTRACE_MODE_READ)
                return avc_has_perm(&selinux_state,
                                    sid, csid, SECCLASS_FILE, FILE__READ, N=
ULL);


--_002_99FC4B6EFCEFD44486C35F4C281DC6732144EA58ORSMSX107amrcor_
Content-Type: application/octet-stream; name="casey-jiri-v6.patch"
Content-Description: casey-jiri-v6.patch
Content-Disposition: attachment; filename="casey-jiri-v6.patch"; size=1634;
	creation-date="Mon, 17 Sep 2018 15:47:57 GMT";
	modification-date="Mon, 17 Sep 2018 15:47:57 GMT"
Content-Transfer-Encoding: base64

U0VMaW51eDogSGFuZGxlIGF1ZGl0IGxvY2tpbmcgZm9yIFBUUkFDRV9NT0RFX0lCUEIKClRoZSBT
RUxpbnV4IGF1ZGl0IGNvZGUgbG9ja2luZyBjYW5ub3QgYmUgdXNlZCBmcm9tIHRoZQp0YXNrIHN3
aXRjaGluZyBjb2RlLCB3aGljaCBpcyB3aGVyZSBQVFJBQ0VfTU9ERV9JQlBCIGNvbWVzCmZyb20u
IEFzIHRoaXMgaXMgYSBzeXN0ZW0gY2hlY2ssIG5vdCBhIHVzZXIgYWN0aW9uLCBhdWRpdAppcyBu
b3QgbmVlZGVkLCBhbmQgd291bGQgZ2VuZXJhdGUgbm9pc2UuIFVzZSB0aGUgdW5hdWRpdGVkCmNo
ZWNrIGZvciB0aGlzIGNhc2UuCgpTaWduZWQtb2ZmLWJ5OiBDYXNleSBTY2hhdWZsZXIgPGNhc2V5
LnNjaGF1ZmxlckBpbnRlbC5jb20+Ci0tLQoga2VybmVsL3B0cmFjZS5jICAgICAgICAgIHwgNCAr
LS0tCiBzZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMgfCA1ICsrKysrCiAyIGZpbGVzIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9rZXJuZWwvcHRy
YWNlLmMgYi9rZXJuZWwvcHRyYWNlLmMKaW5kZXggNWM1ZTdjYjU5N2NkLi4yMDJhNGQ5YzJhZjcg
MTAwNjQ0Ci0tLSBhL2tlcm5lbC9wdHJhY2UuYworKysgYi9rZXJuZWwvcHRyYWNlLmMKQEAgLTMz
MCw5ICszMzAsNyBAQCBpbnQgX19wdHJhY2VfbWF5X2FjY2VzcyhzdHJ1Y3QgdGFza19zdHJ1Y3Qg
KnRhc2ssIHVuc2lnbmVkIGludCBtb2RlKQogCSAgICAgICAhcHRyYWNlX2hhc19jYXAobW0tPnVz
ZXJfbnMsIG1vZGUpKSkpCiAJICAgIHJldHVybiAtRVBFUk07CiAKLQlpZiAoIShtb2RlICYgUFRS
QUNFX01PREVfTk9BQ0NFU1NfQ0hLKSkKLQkJcmV0dXJuIHNlY3VyaXR5X3B0cmFjZV9hY2Nlc3Nf
Y2hlY2sodGFzaywgbW9kZSk7Ci0JcmV0dXJuIDA7CisJcmV0dXJuIHNlY3VyaXR5X3B0cmFjZV9h
Y2Nlc3NfY2hlY2sodGFzaywgbW9kZSk7CiB9CiAKIGJvb2wgcHRyYWNlX21heV9hY2Nlc3Moc3Ry
dWN0IHRhc2tfc3RydWN0ICp0YXNrLCB1bnNpZ25lZCBpbnQgbW9kZSkKZGlmZiAtLWdpdCBhL3Nl
Y3VyaXR5L3NlbGludXgvaG9va3MuYyBiL3NlY3VyaXR5L3NlbGludXgvaG9va3MuYwppbmRleCAx
NjFhNGYyOWY4NjAuLjMwZDIxMTQyZTlmZSAxMDA2NDQKLS0tIGEvc2VjdXJpdHkvc2VsaW51eC9o
b29rcy5jCisrKyBiL3NlY3VyaXR5L3NlbGludXgvaG9va3MuYwpAQCAtMjIxNSw3ICsyMjE1LDEy
IEBAIHN0YXRpYyBpbnQgc2VsaW51eF9wdHJhY2VfYWNjZXNzX2NoZWNrKHN0cnVjdCB0YXNrX3N0
cnVjdCAqY2hpbGQsCiB7CiAJdTMyIHNpZCA9IGN1cnJlbnRfc2lkKCk7CiAJdTMyIGNzaWQgPSB0
YXNrX3NpZChjaGlsZCk7CisJc3RydWN0IGF2X2RlY2lzaW9uIGF2ZDsKIAorCWlmIChtb2RlID09
IFBUUkFDRV9NT0RFX0lCUEIpCisJCXJldHVybiBhdmNfaGFzX3Blcm1fbm9hdWRpdCgmc2VsaW51
eF9zdGF0ZSwgc2lkLCBjc2lkLAorCQkJCQkgICAgU0VDQ0xBU1NfUFJPQ0VTUywgUFJPQ0VTU19f
UFRSQUNFLAorCQkJCQkgICAgMCwgJmF2ZCk7CiAJaWYgKG1vZGUgJiBQVFJBQ0VfTU9ERV9SRUFE
KQogCQlyZXR1cm4gYXZjX2hhc19wZXJtKCZzZWxpbnV4X3N0YXRlLAogCQkJCSAgICBzaWQsIGNz
aWQsIFNFQ0NMQVNTX0ZJTEUsIEZJTEVfX1JFQUQsIE5VTEwpOwo=

--_002_99FC4B6EFCEFD44486C35F4C281DC6732144EA58ORSMSX107amrcor_--
