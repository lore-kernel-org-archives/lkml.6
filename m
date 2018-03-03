Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520121910-2-3796195520771335171
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121909; b=OM9bGGj1b7/5pHIpiZ2Lu2hcLd2P0P4gxpPkZFHKhTebfMS
    luda1/HwHIpyQs3W/IV3aCK4C8N+rzndetAQb1Q6qBzbAKTisPqA5Ofyte2carHK
    syKIQVzu9zVKwc9AQIQ5zbgkl6foZ7O4Ak5IlhYKuQc+5QZGXVbF2N45OlrWtGZK
    D2rnNZ5CQ/rCIPCay8TbRPFqtUlc5+VkAD58OS5pUcmNS544SzA2LNG6bTGoLVOw
    PcCaEHm7cPJbCyWFIZRRoi2+OuAswprjMXj+6+9ADNqqD7m3O7m8g3lOoHbOIWSF
    Fz9u1mgikVFys6ULwRTNbtRwHayjmhc7zar9bHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121909; bh=j2GyNV
    WPMS2SJMmGZuW9QEYkXdc2CkJ2FCHVsM4F7H0=; b=BXfaNFJOV5uRJKUCwfoRWX
    e5/UaRbxxFvTDx/jSPF2q+4Kf9k8qMWHVEeaEYjAQfDo3R3B9U99GPdUK08nip4r
    0I9Sr/HKaU0lYuUdLHQQxQpzuaQ/4J/GJHS4oR5NYYW/mHO/tZTbqyNeCYzKsSzC
    yFdrSLOpe3BdAHBb7wIrENTfJ2saGUA7Lv9/yHDLgCHCSG7HY2tGh4dUBtTW5nha
    rwVC5lIu4oIaqj1OG6bZXq+hDjpR6gjUAQlEQfX4MDzrAZ1htnU74rNO6lXIlHaY
    NSrAdGDm9W5Hw1wIbW5o4c0XHI91oneu6NW2TpTUYebPzxCYSOvqFfN3EqMrqL9A
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UUR5xqIA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UUR5xqIA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932516AbeCDAEs (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:04:48 -0500
Received: from mail-sn1nam01on0113.outbound.protection.outlook.com ([104.47.32.113]:58832
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933579AbeCCWbW (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:22 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Xunlei Pang <xlpang@redhat.com>, Borislav Petkov <bp@suse.de>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 024/219] x86/mce: Handle broadcasted MCE
 gracefully with kexec
Thread-Topic: [PATCH AUTOSEL for 4.9 024/219] x86/mce: Handle broadcasted MCE
 gracefully with kexec
Thread-Index: AQHTsz7o4St1KjASoUSgEQKNPoODmw==
Date: Sat, 3 Mar 2018 22:28:09 +0000
Message-ID: <20180303222716.26640-24-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:ytEN/UpkOLp3+VPGqlafAVRs1+VHibJ+0O9nUew8jGB9xzjEAq0BpQ7XCxDEgUkCo9AlpoKyypfv6wXq+hi8nY/0WwCjN0Y+M/kG1ihQBGaaFdHWlMI/K9+nFlOt0MXi8KLwLJQKdHywPLGnUO3K7EWdowHQABqgo1EZd+qKA80iknANTAc/ufPAhhiZGd25s8nIHiFTTp9V+nMsgiETySJC9OsnIAEKNSve7wIMWIBf9SskQXq8j+yyirKsHZnz
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c8d81519-814d-46e6-c7c4-08d581567c3c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09708071D7352AB0718DBB69FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(258649278758335)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(575784001)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(966005)(7736002)(8676002)(6512007)(6306002)(81156014)(305945005)(72206003)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: wHERh0ua41c9kgDawFBh7xKS3mOWRe+xoU85hfBhNU/KNLkt2q9CZCa820OpDYeFx+MfinRW/gIpt/ddRsvIOwdtkILsNWI08LLizPtRllvqRxn4eArL4W8kTDmtZhmAP6JP52sy6qo6CFQqHt7lZBZcGUQzfFG61BP+ZwA2boQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d81519-814d-46e6-c7c4-08d581567c3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:09.6037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Xunlei Pang <xlpang@redhat.com>

[ Upstream commit 5bc329503e8191c91c4c40836f062ef771d8ba83 ]

When we are about to kexec a crash kernel and right then and there a
broadcasted MCE fires while we're still in the first kernel and while
the other CPUs remain in a holding pattern, the #MC handler of the
first kernel will timeout and then panic due to never completing MCE
synchronization.

Handle this in a similar way as to when the CPUs are offlined when that
broadcasted MCE happens.

[ Boris: rewrote commit message and comments. ]

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Xunlei Pang <xlpang@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Tony Luck <tony.luck@intel.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: kexec@lists.infradead.org
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/1487857012-9059-1-git-send-email-xlpang@redh=
at.com
Link: http://lkml.kernel.org/r/20170313095019.19351-1-bp@alien8.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/include/asm/reboot.h    |  1 +
 arch/x86/kernel/cpu/mcheck/mce.c | 18 ++++++++++++++++--
 arch/x86/kernel/reboot.c         |  5 +++--
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
index 2cb1cc253d51..fc62ba8dce93 100644
--- a/arch/x86/include/asm/reboot.h
+++ b/arch/x86/include/asm/reboot.h
@@ -15,6 +15,7 @@ struct machine_ops {
 };
=20
 extern struct machine_ops machine_ops;
+extern int crashing_cpu;
=20
 void native_machine_crash_shutdown(struct pt_regs *regs);
 void native_machine_shutdown(void);
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/=
mce.c
index fe5cd6ea1f0e..b0cc7bd26ab5 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -48,6 +48,7 @@
 #include <asm/tlbflush.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
+#include <asm/reboot.h>
=20
 #include "mce-internal.h"
=20
@@ -1078,9 +1079,22 @@ void do_machine_check(struct pt_regs *regs, long err=
or_code)
 	 * on Intel.
 	 */
 	int lmce =3D 1;
+	int cpu =3D smp_processor_id();
=20
-	/* If this CPU is offline, just bail out. */
-	if (cpu_is_offline(smp_processor_id())) {
+	/*
+	 * Cases where we avoid rendezvous handler timeout:
+	 * 1) If this CPU is offline.
+	 *
+	 * 2) If crashing_cpu was set, e.g. we're entering kdump and we need to
+	 *  skip those CPUs which remain looping in the 1st kernel - see
+	 *  crash_nmi_callback().
+	 *
+	 * Note: there still is a small window between kexec-ing and the new,
+	 * kdump kernel establishing a new #MC handler where a broadcasted MCE
+	 * might not get handled properly.
+	 */
+	if (cpu_is_offline(cpu) ||
+	    (crashing_cpu !=3D -1 && crashing_cpu !=3D cpu)) {
 		u64 mcgstatus;
=20
 		mcgstatus =3D mce_rdmsrl(MSR_IA32_MCG_STATUS);
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index ce020a69bba9..03f21dbfaa9d 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -769,10 +769,11 @@ void machine_crash_shutdown(struct pt_regs *regs)
 #endif
=20
=20
+/* This is the CPU performing the emergency shutdown work. */
+int crashing_cpu =3D -1;
+
 #if defined(CONFIG_SMP)
=20
-/* This keeps a track of which one is crashing cpu. */
-static int crashing_cpu;
 static nmi_shootdown_cb shootdown_callback;
=20
 static atomic_t waiting_for_crash_ipi;
--=20
2.14.1
