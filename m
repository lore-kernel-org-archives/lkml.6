Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489940-2-12916571251553655023
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520489939; b=htyCNUIti+CHEGNkzvy1KG16Alf462XX6vE+WQkRfgRUrJy
    naNml44DBIBOzIFEh8/Jm7ETXIvvP2hjIxBiwtS+KaQBTmHetxAVgv22P+asrIA+
    CrZE4zPk86Xel3epDoUR3CUDs42ihvWMz6ECyR5XNKgiFyJoH9XyYgtnBVmUMU0n
    DykVMqIwvqvFjYKZtiHUOuLu/Ueq2vRdPaQlGUSOJIKC+kuOxpOZgA6QtKLFVG1m
    rKdRdSyDQScNw3pJewdl3iMaibfZxDcarLXrrFbm6viyzkmIj4AIIUDQ8vovU9ev
    Gee3dZD/HGM5JunwgRHiWCcLd6usXz7H1AijJxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489939; bh=s36UCK
    NJwA71JeNWxFjCJCit7Cpllcxba4YhmHxRCXk=; b=wWC5uTGrTd1IptmQCMZy50
    QR7lsga12Pro81u/W6LDWnuENSuj4jwShVvDbX01q/2tjphXFaHXPIJsijmTiD+x
    KoLXVmgPW0/KhitoaYJ9Tv757/kWctLrTuz3mW3eDaC7rwU3c9B+Tuj1zq+gjABS
    MMKJnI0UExGl0x1gtmtonjMgSuNLqWWWKgpBucQClwMFKijLsZ/i4KKjuhJcBxJJ
    zzfO6hJ8Otixgf88pTTp7aL45o1V5TCcoRUTezc4im5Tqh70z+TkgrWzW3k6CNZl
    AG2P2Hd4Vtu2282DlERGNYxQHeRtaaqKzBO3BEYEfTDzsD6UmdKtAOF9WoMQLz9Q
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RT8glVJu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RT8glVJu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965607AbeCHFBA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:01:00 -0500
Received: from mail-sn1nam01on0095.outbound.protection.outlook.com ([104.47.32.95]:45505
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935408AbeCHFA4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:56 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tiantian Feng <fengtiantian@huawei.com>,
        Xishi Qiu <qiuxishi@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 052/190] x86/reboot: Turn off KVM when halting
 a CPU
Thread-Topic: [PATCH AUTOSEL for 4.9 052/190] x86/reboot: Turn off KVM when
 halting a CPU
Thread-Index: AQHTtpo0M3e84zd8XU+ZhTJdvGQkJQ==
Date: Thu, 8 Mar 2018 04:59:14 +0000
Message-ID: <20180308045810.8041-52-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:5q407ed1b1QhqjuUUvm6DtmEOloS0CxvIFiYjT4lrNVNxfKLR8no6KddZ+rH//slT/vHchR2ze0B8KioF7V2qVsaXb4/48mGrgVEd5q/gE9AcYgcUPPoYOurxxqPAHuDIf3pII9hlGUGKoNgEdMPqKMh3IcEkYk/KqusvSsXvB55TxT3BLq7SKXmfwJt8SQUtzKUg9FCunKC23pCUoIuvmbeTf+HbLGV7tU8JCSdh9/FFUNyhzj5KjFVAOsbCdS2;20:wGsUNVAOvNXLOlRUvaVPkFk8xXaA8XOp390p1f08lD/XoJBqYPkfNsuXHj6VzPTz6F+t1cD/CnUgj+SiytiIcB2trfp6us6IKyibhF+KVOsdqTBUspO2ayFUXiTLG8MQj5DtQvDeEThhVqeag0gSaW7gDUkIOMPELqSr8rGN7gg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4dc49001-932e-41af-b1f1-08d584b18d1f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1109539896E12DDECB73B0F1FBDF0@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(50582790962513)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(199004)(189003)(3660700001)(5250100002)(102836004)(6436002)(2501003)(81166006)(8936002)(6486002)(81156014)(53936002)(6306002)(6512007)(8676002)(6506007)(5660300001)(86612001)(76176011)(10290500003)(86362001)(4326008)(105586002)(25786009)(10090500001)(7416002)(26005)(2900100001)(316002)(106356001)(97736004)(54906003)(305945005)(7736002)(186003)(36756003)(22452003)(110136005)(14454004)(966005)(72206003)(6116002)(3846002)(68736007)(3280700002)(66066001)(2906002)(2950100002)(478600001)(6666003)(99286004)(1076002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Rq2hjEpaMq0iZCm6clkVXti9k4rsQsxlXgoFA5HHKSXiTEBhrMR8/R57P3v7O9ke6gai379JtZxZfeByyM5GBSmCtOpUQYHOtwCTQVGVvQXtDZPAQaxQzjPiopSEsD8JEvVKw+duvQ1Ci6xCgEteHQ9MjklXDx/NMDbKlXm5c2jmeEFAtYRJLX35Jmhp8anhk83jJdR9fM/UpvUQgDOXtPYP5eLf03dHHthrB2n9ND+0Ldgcry195u4xj/obscaJyewhMfdRwexWpXwEL4oXzOtKSq5zDnRvURy3b4eNif8sScgQ3f5U1YRmAgTpN+FRlbkBgrSrFVMaeLWqWmxwbA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc49001-932e-41af-b1f1-08d584b18d1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:14.7774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tiantian Feng <fengtiantian@huawei.com>

[ Upstream commit fba4f472b33aa81ca1836f57d005455261e9126f ]

A CPU in VMX root mode will ignore INIT signals and will fail to bring
up the APs after reboot.  Therefore, on a panic we disable VMX on all
CPUs before rebooting or triggering kdump.

Do this when halting the machine as well, in case a firmware-level reboot
does not perform a cold reset for all processors.  Without doing this,
rebooting the host may hang.

Signed-off-by: Tiantian Feng <fengtiantian@huawei.com>
Signed-off-by: Xishi Qiu <qiuxishi@huawei.com>
[ Rewritten commit message. ]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kvm@vger.kernel.org
Link: http://lkml.kernel.org/r/20170419161839.30550-1-pbonzini@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index ca699677e288..ea217caa731c 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -33,6 +33,7 @@
 #include <asm/mce.h>
 #include <asm/trace/irq_vectors.h>
 #include <asm/kexec.h>
+#include <asm/virtext.h>
=20
 /*
  *	Some notes on x86 processor bugs affecting SMP operation:
@@ -162,6 +163,7 @@ static int smp_stop_nmi_callback(unsigned int val, stru=
ct pt_regs *regs)
 	if (raw_smp_processor_id() =3D=3D atomic_read(&stopping_cpu))
 		return NMI_HANDLED;
=20
+	cpu_emergency_vmxoff();
 	stop_this_cpu(NULL);
=20
 	return NMI_HANDLED;
@@ -174,6 +176,7 @@ static int smp_stop_nmi_callback(unsigned int val, stru=
ct pt_regs *regs)
 asmlinkage __visible void smp_reboot_interrupt(void)
 {
 	ipi_entering_ack_irq();
+	cpu_emergency_vmxoff();
 	stop_this_cpu(NULL);
 	irq_exit();
 }
--=20
2.14.1
