Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520117851-2-9641829125308718911
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
    t=1520117850; b=e1j+OabV7pEFPl4QqfSzdW5E6axVBXMw0zfy8msWHlUoLOu
    uL3hpLlIHbzH+y1EdjdUXsnO07MF+0kp/7Qh858jgUYaXszM3TNwq08jLAaTe+fU
    bBLLpwj6UOekNOOm6xJJUt72t7zoLcwC4b0DLiyMXz/pmJzLigTk2P6txdSu+MMa
    9UNe4hPNTB1v+GdIQ7oMlv5gG4cwTUxPuSvDidHu3GtZvABblu1eThBQrCBgHpfv
    sMiNPugdqmjw9xaFsGORakynflqt5+7WCgsoPOMo8PxtHXJX+wpL60b5BlXRKlzQ
    GFASMwR1qJ4VZLLwq7lcFnpKTrGZYLmCLalns6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117850; bh=8iGUl7
    75LWAk4VsnXK6V4wmkWvqf33BARedWKi4kLQ8=; b=Rzd9lru+NLeikqb1knQocx
    cWgU4Ek84eSh9tM8qibEIn0DRH4ZHjSpAyGYbO3iFUwaxz3VgzgHBh2bvXHJ+F4j
    82wQsDBzrvSsKeDyWlpG44IdQ6OTWhXQzPF+OrK2qhbw4VRmURKHPNqer0LvuGOE
    TsXGRoGcg+kB7Hmupm+YPCzoRCGgTneFjgvPtrZyDmUdzFeML0CCMvMctKL8q4p5
    vxb8ECz1YJA1+yYsFWz8iCe+Dls9zxWPSklREiPNmvnq/WDv8wYBZzoGeI0YkRvO
    yd5TdbL6G/Qrx1QwSzKLg4bsaOMftsKHCSYOmau8hmPaDEpEcXk1jfRG2kJruozw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IoUTb6N2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IoUTb6N2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934409AbeCCW5N (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:57:13 -0500
Received: from mail-cys01nam02on0109.outbound.protection.outlook.com ([104.47.37.109]:30112
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935346AbeCCWk6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:58 -0500
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
Subject: [PATCH AUTOSEL for 3.18 02/63] kretprobes: Ensure probe location is
 at function entry
Thread-Topic: [PATCH AUTOSEL for 3.18 02/63] kretprobes: Ensure probe location
 is at function entry
Thread-Index: AQHTsz+amFwbxH91EU2dKUr4HpJ2WQ==
Date: Sat, 3 Mar 2018 22:33:08 +0000
Message-ID: <20180303223228.27323-2-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB344;7:v6/2jcDq62rH2sDqtbrM6HYsZ2vmtnA1aS4UPZMcZG6l/lF+GfUmQRG3db4/osJyKw4rIBJVuR8eAq89wFo9RF7RL5+wrUjTp9C+K1xJrA7n7l1I2Fk02GuqB5RBmF+dLsw8uDvayLzAKRZo0DYFoTe0noGbkeuL7TRVMnuj5NuXBzutGbEoIBXSvQAv9jate4/JBUdzrD/4WZyzQNI7P4x+BSFvRbnoLgUI8rBhLj+PnWuUEWEDf0rKjiTfeimp
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9b7059ce-8970-4a62-de8e-08d58157d338
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB344;
x-ms-traffictypediagnostic: MWHSPR01MB344:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB34453E4CDA97682F45BA2E1FBC40@MWHSPR01MB344.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(65623756079841)(42068640409301)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHSPR01MB344;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB344;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(39380400002)(189003)(199004)(59450400001)(8676002)(5660300001)(5250100002)(2501003)(6506007)(575784001)(7736002)(36756003)(25786009)(3846002)(6116002)(966005)(97736004)(305945005)(2900100001)(76176011)(6436002)(10090500001)(26005)(8936002)(186003)(81166006)(102836004)(81156014)(106356001)(86362001)(10290500003)(3660700001)(2906002)(99286004)(14454004)(86612001)(105586002)(478600001)(4326008)(6486002)(53936002)(107886003)(68736007)(316002)(54906003)(110136005)(6512007)(72206003)(3280700002)(22452003)(2950100002)(1076002)(6306002)(6666003)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB344;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: v+X7VNwU5b7XElKWGf4iAtyMXXIIwxNdEzLhMQxhZXTW5rA8OOvl1Elby4N7nWJAXGXJf0f3ep+hElrfE3m+1RMbwDUhH1lngyFuY/zhPCZG57XfTMD+90BiYmN1+TbOPIkDxznvwoS6YGTTRfNZtlcWYag83RAUAbJ9MSzf9/g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7059ce-8970-4a62-de8e-08d58157d338
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:09.0128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB344
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
index 8c0ff78ff45a..1b19416203f0 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -266,6 +266,7 @@ extern int arch_init_kprobes(void);
 extern void show_registers(struct pt_regs *regs);
 extern void kprobes_inc_nmissed_count(struct kprobe *p);
 extern bool arch_within_kprobe_blacklist(unsigned long addr);
+extern bool arch_function_offset_within_entry(unsigned long offset);
=20
 struct kprobe_insn_cache {
 	struct mutex mutex;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 0d2f0e7c7605..12d069a3d6a8 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1823,12 +1823,25 @@ static int pre_handler_kretprobe(struct kprobe *p, =
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
