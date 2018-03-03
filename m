Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520119300-2-6562464434833765799
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
    t=1520119300; b=Lof9KGF6CGc7ADLNOCconwZcWzcq76semJIP2KcIkpzBQE2
    euPqwhBL4wOQvjgCJ39gwwLMYYoVyCRVi4mpI60TkqkIutfOMcam1cYsK1MXWORF
    UvNEgqr2MHDJEOU6BMAYRavW4ig7Hqlh3OZeRmEefZ9F91+yiEf47yByY+NnLfPo
    e2mHYpfA/AjiNLzerZIQjT3lytK/t3SFpPwTxuk7YtDi8YldjYHQdpp4CG7S5myr
    F9e4Kon758UDFTIYtiguWbwPkKPxJo52UQokI5XVkCypv+wK4fs/BKYhTOyc6GXX
    7HlCv6u6tZdM7VQ9bk8LChHiGWe2uRpCEjwRpSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119300; bh=Dlfr63
    CP3UPJGS+IoAbfg/S1ForJv366ds59pgel/Sw=; b=CeXefErFduVyRKw0f2zmWX
    tCZws8X67Y2PxYzuPyJjBCmq6EIRRg4Ap52/aU57LewglrgdnBUa1GAI0bmF50xN
    v1EE7ccWre4GbnnwwB+JmJuU/ote7TawBItmK5RK6DrmThLNgM4eLbBDesBhvmIG
    oUSDGlkiTN0fu1YFm7hkyqz+oWy/lr5IIwP9gu2/4zNmRivnzw2CuTxgOKIEqz8t
    0N4FOwTIUJ8Hdkms/ObYlDy8YbzwzGghK3u0HLvdgSfQRAC+SyFHjyRXh7P3pwC+
    T0EHJT4wWpvUJvarrWHIG6uCm+4xFqYrT1i07cp06qn78+JfhlLLh/YAmTZv7sUA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FkuDfZZf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FkuDfZZf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbeCCXVM (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:21:12 -0500
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:45128
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932373AbeCCWh4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:56 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 002/115] kretprobes: Ensure probe location is
 at function entry
Thread-Topic: [PATCH AUTOSEL for 4.4 002/115] kretprobes: Ensure probe
 location is at function entry
Thread-Index: AQHTsz9HDS4qD1Aj3EKTA+b72Tcx+Q==
Date: Sat, 3 Mar 2018 22:30:48 +0000
Message-ID: <20180303223010.27106-2-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1100;7:OsTI/kdd818yZl/u2TuK2zNq2Db4UMiBWcIJmZsgPfyiIGwCv6g/ZxJNrK31JXm204SecST5+Ki9hEgylTqBylh/OmjIEw1diwGVTVMffm86CDdd8C9WMshwqdYBrIgQ5vGBxqUFNIQdZlRPSd/Dvx4JHjW3HHdK8hffssvUaIY6LfMVaoVVdSBn5aM15QsaWMbfWiFSRFvAB3i3+ZsW4fhvEjwHu15TPTX1SOmzlykmy9bNcRauSJjSlNn0EJIg
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b851328a-dee5-4a77-ccea-08d58157667a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1100;
x-ms-traffictypediagnostic: MW2PR2101MB1100:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB11002C6343AD5F68C11158FAFBC40@MW2PR2101MB1100.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(65623756079841)(42068640409301)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1100;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1100;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(396003)(366004)(346002)(199004)(189003)(22452003)(97736004)(7736002)(5250100002)(105586002)(2906002)(6506007)(72206003)(966005)(66066001)(59450400001)(4326008)(305945005)(10290500003)(186003)(3280700002)(102836004)(2950100002)(6666003)(2501003)(478600001)(26005)(2900100001)(10090500001)(53936002)(8676002)(25786009)(81166006)(81156014)(575784001)(54906003)(86362001)(6436002)(106356001)(110136005)(68736007)(36756003)(316002)(6512007)(5660300001)(107886003)(8936002)(1076002)(6486002)(3660700001)(99286004)(6306002)(76176011)(3846002)(86612001)(14454004)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1100;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Ejhb0sJWalGRvlNi+f6tyf7QSWkW1ZrtiKdjqDZJHwhZ65GAuvFAySJ3RsaRsFde1hWiWc5UmMTcv38Xdr1Ke6A/lcEEJaqFjN8oexSJVZiVVCzlTtZvysJL5Gv/qi0UG68CtlgTCyoeowzhpDicdZSSW+b/qbkfuHNKyvknjFg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b851328a-dee5-4a77-ccea-08d58157667a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:48.2915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1100
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

[ Upstream commit 90ec5e89e393c76e19afc845d8f88a5dc8315919 ]

kretprobes can be registered by specifying an absolute address or by
specifying offset to a symbol. However, we need to ensure this falls at
function entry so as to be able to determine the return address.

Validate the same during kretprobe registration. By default, there
should not be any offset from a function entry, as determined through a
kallsyms_lookup(). Introduce arch_function_offset_within_entry() as a
way for architectures to override this.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/f1583bc4839a3862cfc2acefcc56f9c8837fa2ba.148=
7770934.git.naveen.n.rao@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/linux/kprobes.h |  1 +
 kernel/kprobes.c        | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e23392517db9..56a998f34bdd 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -266,6 +266,7 @@ extern int arch_init_kprobes(void);
 extern void show_registers(struct pt_regs *regs);
 extern void kprobes_inc_nmissed_count(struct kprobe *p);
 extern bool arch_within_kprobe_blacklist(unsigned long addr);
+extern bool arch_function_offset_within_entry(unsigned long offset);
=20
 extern bool within_kprobe_blacklist(unsigned long addr);
=20
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 695763516908..f6232bbbc0e3 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1834,12 +1834,25 @@ static int pre_handler_kretprobe(struct kprobe *p, =
struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(pre_handler_kretprobe);
=20
+bool __weak arch_function_offset_within_entry(unsigned long offset)
+{
+	return !offset;
+}
+
 int register_kretprobe(struct kretprobe *rp)
 {
 	int ret =3D 0;
 	struct kretprobe_instance *inst;
 	int i;
 	void *addr;
+	unsigned long offset;
+
+	addr =3D kprobe_addr(&rp->kp);
+	if (!kallsyms_lookup_size_offset((unsigned long)addr, NULL, &offset))
+		return -EINVAL;
+
+	if (!arch_function_offset_within_entry(offset))
+		return -EINVAL;
=20
 	if (kretprobe_blacklist_size) {
 		addr =3D kprobe_addr(&rp->kp);
--=20
2.14.1
