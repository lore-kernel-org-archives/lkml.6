Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488579-2-10719706317577721712
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
    t=1520488578; b=L4wmuVQy+3RkNAifo6SK4tpCvmhsspc1ip/VWdRM9EHoDG7
    D2xYwmDqTsvx8GOav8D1hXc6w/T4EY5nKZjaskRvblkCK7BUb1UdlW5ldebxjIGb
    qUaECf2OXBVqf7GHQgPRMlRjbXZoRQTRIdTSLUTgPmEWwGJCPDT9bdQuqM0//Ndc
    ZE+zGpvXM8aaBMcsHHKz8bbSeEYSiSn+lsNXtumUHiVZYCuv3Sm2TS7vc/WaDxx8
    wad4oNkhLeVmwcsfNMhERkHQvySefHesY6ZthEWScXAr55HZpcOuXF4lF1meIJWh
    HSONqkmyO9G0cgyoJtlVRdAJMHUYAxYMreRyL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488578; bh=R6+7sc
    Lb6yy/6jL1KnwPmCGfP5EHxtLqpdVkvE8IZ60=; b=Z4LhfKx/fBu+BztVpParrG
    piexs0z4iqgJcN5ckB3rDflG1K5iBOc2J75JLy9aFj/qXauKzsi/AgA3xijXtrI/
    rGOLhDQE/MhzeG4YQjk4pmdxavwDT5/bNIPl8EcZAc5YcjLd5VeJiKnk3Ha0NLGp
    7U8M6c/V0/YYeSSJ+aEre4hwxSC0WiqrnjdvGC2MJB0SPQGYXm+7DoP2VyjXGLOI
    8M9w4XTCUtthCd0HoSqYxxlnHCWv9FBhYnCXVwHb8BdnGbR/zaKW8FpAKBBeEMta
    4qeYvpho3dlYBzjTGj2VmEaDdHN4+fFnrG44OmJG12AcvkqYvahgiX7CTOZiXLmg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E/prK5rn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=E/prK5rn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966043AbeCHFDd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:03:33 -0500
Received: from mail-sn1nam01on0117.outbound.protection.outlook.com ([104.47.32.117]:16747
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966002AbeCHFDZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:25 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 137/190] x86/xen: split
 xen_smp_prepare_boot_cpu()
Thread-Topic: [PATCH AUTOSEL for 4.9 137/190] x86/xen: split
 xen_smp_prepare_boot_cpu()
Thread-Index: AQHTtppK7jXU1/GwF0mYLxjXm25kFg==
Date: Thu, 8 Mar 2018 04:59:52 +0000
Message-ID: <20180308045810.8041-137-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:Mr0E5LSzMiXJCAcHN+vBYqW+g2aiC7t4KiTT674yEVjHz3NxYESbQLswO5O5CjUCMt+Jx/zGyDuQaoQP5H9xHRMp12bLchEKcX2SrkzcQsAYCpLlZEkMVAosLqqIhwNJepD5cUJxJ+zZZQ+LQo7box8Lqh9Z/T1Y0b1uOTBepB1eSMHJF0ofiyNVDqx12OE3vr7KV/yCCb2E6YIWzWkIs99QdodqmdsKAsQkUmrwG/uKx4CUhxKiaz3+tG3TaBSA;20:eTeeDwCwrrw9uSYX9D8nSGbiUPCfPN0e5+PigMfIRF72PsxVl1QZVfVi5lgZ5vBAB+4lB6w3e6/1bWTAnNB4pEF2ODytOFRi6A5ghQ4OGdNhpbQzVMxvSHPsLz/ZuvWuwkKbX+7uODkhuuy7igKBRmJ0djGgJB8TOxwFKamcECY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf13c949-835e-478a-a09b-08d584b1e77f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10134BB3878E16453C5DD8E1FBDF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(76176011)(6506007)(107886003)(6486002)(22452003)(105586002)(2950100002)(6436002)(26005)(99286004)(53936002)(6666003)(97736004)(36756003)(3280700002)(102836004)(5660300001)(2501003)(68736007)(6512007)(186003)(2900100001)(59450400001)(106356001)(3660700001)(4326008)(2906002)(25786009)(5250100002)(14454004)(7736002)(10090500001)(66066001)(3846002)(305945005)(6116002)(316002)(10290500003)(478600001)(86612001)(8936002)(54906003)(72206003)(8676002)(86362001)(81166006)(110136005)(1076002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: GDOuBMhe2vUXNzfw1rae6mKz3z751+2Ky6qS+4L4QBobowynFPfrkvzwpfeZfLsnlMjCreoOQ1qSrFVb5SLXA65rnxPay1NzLVBjzlC5aw6pv5Aur3loVXVWGp+Z0JX0bNk34Xd+Mq64axASoB1llAuu769TYwTOourzFBVoACuqXznV9BnqYwOL22S4tIS6qf6SZUYeIMi5/8U89RyPjc0l1CcFBWRaeJZ0DDQ6srDR3XfxJmtZaYtgSpToptogs10wAN7bcKEcHNJz+D29GMFw0SFgM6Y+74rD6XxuGGSoFuuX7paobRZ0KjTuemHvGxyAHRbLh7UHt+2IENtmBQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf13c949-835e-478a-a09b-08d584b1e77f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:52.2549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Upstream commit a2d1078a35f9a38ae888aa6147e4ca32666154a1 ]

Split xen_smp_prepare_boot_cpu() into xen_pv_smp_prepare_boot_cpu() and
xen_hvm_smp_prepare_boot_cpu() to support further splitting of smp.c.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/xen/smp.c | 49 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index 137afbbd0590..a11540e51f62 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -299,35 +299,46 @@ static void __init xen_filter_cpu_maps(void)
=20
 }
=20
-static void __init xen_smp_prepare_boot_cpu(void)
+static void __init xen_pv_smp_prepare_boot_cpu(void)
 {
 	BUG_ON(smp_processor_id() !=3D 0);
 	native_smp_prepare_boot_cpu();
=20
-	if (xen_pv_domain()) {
-		if (!xen_feature(XENFEAT_writable_page_tables))
-			/* We've switched to the "real" per-cpu gdt, so make
-			 * sure the old memory can be recycled. */
-			make_lowmem_page_readwrite(xen_initial_gdt);
+	if (!xen_feature(XENFEAT_writable_page_tables))
+		/* We've switched to the "real" per-cpu gdt, so make
+		 * sure the old memory can be recycled. */
+		make_lowmem_page_readwrite(xen_initial_gdt);
=20
 #ifdef CONFIG_X86_32
-		/*
-		 * Xen starts us with XEN_FLAT_RING1_DS, but linux code
-		 * expects __USER_DS
-		 */
-		loadsegment(ds, __USER_DS);
-		loadsegment(es, __USER_DS);
+	/*
+	 * Xen starts us with XEN_FLAT_RING1_DS, but linux code
+	 * expects __USER_DS
+	 */
+	loadsegment(ds, __USER_DS);
+	loadsegment(es, __USER_DS);
 #endif
=20
-		xen_filter_cpu_maps();
-		xen_setup_vcpu_info_placement();
-	}
+	xen_filter_cpu_maps();
+	xen_setup_vcpu_info_placement();
+
+	/*
+	 * The alternative logic (which patches the unlock/lock) runs before
+	 * the smp bootup up code is activated. Hence we need to set this up
+	 * the core kernel is being patched. Otherwise we will have only
+	 * modules patched but not core code.
+	 */
+	xen_init_spinlocks();
+}
+
+static void __init xen_hvm_smp_prepare_boot_cpu(void)
+{
+	BUG_ON(smp_processor_id() !=3D 0);
+	native_smp_prepare_boot_cpu();
=20
 	/*
 	 * Setup vcpu_info for boot CPU.
 	 */
-	if (xen_hvm_domain())
-		xen_vcpu_setup(0);
+	xen_vcpu_setup(0);
=20
 	/*
 	 * The alternative logic (which patches the unlock/lock) runs before
@@ -733,7 +744,7 @@ static irqreturn_t xen_irq_work_interrupt(int irq, void=
 *dev_id)
 }
=20
 static const struct smp_ops xen_smp_ops __initconst =3D {
-	.smp_prepare_boot_cpu =3D xen_smp_prepare_boot_cpu,
+	.smp_prepare_boot_cpu =3D xen_pv_smp_prepare_boot_cpu,
 	.smp_prepare_cpus =3D xen_smp_prepare_cpus,
 	.smp_cpus_done =3D xen_smp_cpus_done,
=20
@@ -772,5 +783,5 @@ void __init xen_hvm_smp_init(void)
 	smp_ops.cpu_die =3D xen_cpu_die;
 	smp_ops.send_call_func_ipi =3D xen_smp_send_call_function_ipi;
 	smp_ops.send_call_func_single_ipi =3D xen_smp_send_call_function_single_i=
pi;
-	smp_ops.smp_prepare_boot_cpu =3D xen_smp_prepare_boot_cpu;
+	smp_ops.smp_prepare_boot_cpu =3D xen_hvm_smp_prepare_boot_cpu;
 }
--=20
2.14.1
