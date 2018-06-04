Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752276AbeFDJIp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:08:45 -0400
Received: from mail-hk2apc01on0106.outbound.protection.outlook.com ([104.47.124.106]:51744
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752192AbeFDJIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:08:41 -0400
From: Tianyu Lan <Tianyu.Lan@microsoft.com>
CC: Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: [RFC Patch 3/3] KVM/x86: Add tlb_remote_flush callback support for
 vmcs
Thread-Topic: [RFC Patch 3/3] KVM/x86: Add tlb_remote_flush callback support
 for vmcs
Thread-Index: AQHT++OdAN2+GrZK4EuBP0Cwrph5uQ==
Date: Mon, 4 Jun 2018 09:08:34 +0000
Message-ID: <20180604090749.489-4-Tianyu.Lan@microsoft.com>
References: <20180604090749.489-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180604090749.489-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0094;7:YkExAxxpXXHlqImYUaLo3egp3+KGAK4dIPOhIvYlKWLnj7/QrcOJ8i0O9vRWjwWFbyh9MYMT2igsVcemwD122Du3KxUcJqJ0fdzf6EQ/z7CNdqZo0UosS8gcSrcJlK+skuXSaHrgI0jRGlIwBO9uHKEbZ/N96sR3uPqc0oOxHBOx6F4pYWk7ZBRhJ2j8LxWghYkIaL06Ymr6Cr7wQfPTYxW8oFatwnokLoNWPtGkLrbsUKIdkK37aro7VilGR5jU;20:HQ4hHogq+VhLbdsrMl40Qvxwo6nNEXp57QGKUC1r4BHzHV55WTD3+efr5uZLgXr5p4+MpbjmbZngserXWB/GvKA2oFJDQ21ix7kC/1wI+gxiiK4WSd08OlC4E909Lo+TW+zEQguQtbXLkEdvMTaSGF0HL7ui3bHGv0yjZu0udW0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7193020);SRVR:SG2P15301MB0094;
x-ms-traffictypediagnostic: SG2P15301MB0094:
x-microsoft-antispam-prvs: <SG2P15301MB00949249016B75A5A145DD7492670@SG2P15301MB0094.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0094;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0094;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(376002)(346002)(189003)(199004)(1076002)(5250100002)(6436002)(10290500003)(2906002)(6486002)(3846002)(53936002)(6116002)(86362001)(86612001)(36756003)(25786009)(72206003)(478600001)(6512007)(10090500001)(109986005)(76176011)(106356001)(99286004)(68736007)(5660300001)(81166006)(81156014)(4326008)(6506007)(26005)(8936002)(8676002)(105586002)(7736002)(446003)(2616005)(11346002)(97736004)(14454004)(305945005)(2900100001)(66066001)(3660700001)(3280700002)(486006)(476003)(1671002)(22452003)(316002)(102836004)(59246006)(54906003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0094;H:SG2P15301MB0062.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: upbnA8MrwbbOi9aUp/oQdkctTIY+Q6r8KqIf+nqapd47XAkNH7s4hKQn1sPPM4qUhRfUis17E3hAci2GM0UXhsWu/aVFRElSgRO16H4Gs3zJkL5lkIGyPWl5OlgdbK8YMU72mO7Vs7dxkvkhxP632tukhgWjsIuYlx9N/vIxzRqJ9HpVGxOX1s+6/y24GDty
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 003f1d7b-0355-4443-6549-08d5c9fac01b
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003f1d7b-0355-4443-6549-08d5c9fac01b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 09:08:34.0133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0094
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w5498o3K032358

Register tlb_remote_flush callback for vmcs when hyperv capability of
nested guest mapping flush is detected. The interface can help to reduce
overhead when flush ept table among vcpus for nested VM. The tradition way
is to send IPIs to all affected vcpus and executes INVEPT on each vcpus.
It will trigger several vmexits for IPI and INVEPT emulation. Hyperv provides
such hypercall to do flush for all vcpus.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/vmx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index e50beb76d846..6cb241c05690 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4737,6 +4737,17 @@ static inline void __vmx_flush_tlb(struct kvm_vcpu *vcpu, int vpid,
 	}
 }
 
+static int vmx_remote_flush_tlb(struct kvm *kvm)
+{
+	struct kvm_vcpu *vcpu = kvm_get_vcpu(kvm, 0);
+
+	if (!VALID_PAGE(vcpu->arch.mmu.root_hpa))
+		return -1;
+
+	return hyperv_flush_guest_mapping(construct_eptp(vcpu,
+		vcpu->arch.mmu.root_hpa));
+}
+
 static void vmx_flush_tlb(struct kvm_vcpu *vcpu, bool invalidate_gpa)
 {
 	__vmx_flush_tlb(vcpu, to_vmx(vcpu)->vpid, invalidate_gpa);
@@ -7495,6 +7506,10 @@ static __init int hardware_setup(void)
 	if (enable_ept && !cpu_has_vmx_ept_2m_page())
 		kvm_disable_largepages();
 
+	if (ms_hyperv.nested_features & HV_X64_NESTED_GUSET_MAPPING_FLUSH
+	    && enable_ept)
+		kvm_x86_ops->tlb_remote_flush = vmx_remote_flush_tlb;
+
 	if (!cpu_has_vmx_ple()) {
 		ple_gap = 0;
 		ple_window = 0;
-- 
2.14.3
