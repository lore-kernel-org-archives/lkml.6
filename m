Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233133-2-8972122851229555846
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233132; b=t6QO3eAlIqktQVmpCSv219vxLG0p55I1XKLhqLwr3pRxgWI6vn
    S05PGGOSLUUMjQo1aAfMOyEJ1HQ2NyyUXs0lrTw5yinKstAZOZ4Axz3KrOYahGXH
    iNDIo0Ney1JTozaRfr/5qhne6B3jIjxxd6UiQOOgpNBX2XrLI4OYq1Q5JeC2JiEC
    cR0U5SectSOmRoxaot8S9Cvgku9yJBRfZe3Fvwfs1+ECSXy5N61tVLE4fBckaX86
    Mc1gNwIG5BZz4qNNKQDUXHBEyGiYrlzL1p4WrfpgGsZDMaDlM7nF6jV++WaeTVXQ
    Q88ri1bg8CuGx159MKYRBwvG7E6cuwhyjC/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523233132; bh=7Fs6n
    ATmFYTQMtJyQXgE+0FKk07KYH51LqHvYJ6SUgc=; b=odET1jfQwfus/V5mAac1x
    dr1MzevuL9vG4PT9x+lRDBscEX7Zv4bSN9BsdSJ7KSM/fWAua96tMYefB8k7zsSQ
    I6oUN56b9DVdSYx6Y/kzQHggb61pjX8vReg9M8QHW75a+AWVt8qlb0yqoUuPwFFB
    nwaQESIjCiv1lzHrGLClue3GInnPRfSIvKzUke3YdJrpRedh68E9BNMR5nDp3LCL
    m9hgzkaBpPP9o85zAE5+fvMhEy4DO48S/N+5IUsRpS4TqK5po0/D75LBWN8WBeTO
    UC+OVBbpoCpYOQoQHr0K4NOaC1vzhDMugtvTvsSmKK/6VeokD3qGszLjMM0McYyf
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nwKXz4Sm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nwKXz4Sm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPmWnw3RgxXhKHSaSKU05JIDLxLGpmQtYs/TXzXYYOnjJF3U1UOnuiRFmG+pvHhLKALe/pzNsINSdc+aiQmao/KUU4jtFRPqnttfobyWPmHV4nUTuvvt
    BqBxbEHD3DkdxbmgTHDqpL/BEvOXSCZcLVrIGIJ5jF0CDi8XmzHPurosD9BtkMn18XgIJDCLG4TNoHf2V2x3reLtJGMNzo20AkL17u/gr/6Zy3pg6NYzKpyb
    bW5oOZSbUW3aA79gh/28XQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=20KFwNOVAAAA:8
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=DDOyTI_5AAAA:8 a=W_74OEVURaC5T3cw8B8A:9
    a=RxRZKoE8Xjc6tsPY:21 a=kmib79klV2sqd964:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH AUTOSEL for 4.15 090/189] x86/hyperv: Stop suppressing
 X86_FEATURE_PCID
Thread-Topic: [PATCH AUTOSEL for 4.15 090/189] x86/hyperv: Stop suppressing
 X86_FEATURE_PCID
Thread-Index: AQHTz5g15HDkqLJsS0OmaDtuGWKt9Q==
Date: Mon, 9 Apr 2018 00:17:56 +0000
Message-ID: <20180409001637.162453-90-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB1128;
 7:/GWfbmz4REF1KeL7djRiGjCercRyn+pfd+HHHsZB9sW8rggkEH8HVB8h6Tn4lAc7SjJT82RkeEg0oLsgSpebguj+Gq1Dj4AmCb6kzdVh9UI5pO45uuNtaQtTwv3OqknyweiZuFa8AcpwdpUFwxH6zXuF2yL0O54jbTver6ffJ32cfzPzLid0fRTjXhdN1NlCs4258LHIGI+wnb0c5ehLl1D8Qft1WU74uDo91uUNMJyOZIfBqXfFfWXUky8XJpHM;
 20:u6HwcYJ6tc/s1kXvXqg0YZKDvp3ra3gq9tKMcES5d5t/1q9gU0M/TcFvv9qV4AxB4eJVCB3uftJDh49TsSvfAXzP4zEpzyVho4DSu+uG/pCmVuXE4gEmHQdJg7bEf3ecwDJ9kWOLa60tKu0S5mZSmcLwEobDYmQywW3uIsJzl8w=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: fb2aef26-456a-4179-d43a-08d59daf740b
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR2101MB1128;
x-ms-traffictypediagnostic: DM5PR2101MB1128:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1128177ECA52FA5E72A405BBFBBF0@DM5PR2101MB1128.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:DM5PR2101MB1128; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB1128;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(39380400002)(199004)(189003)(66066001)(86362001)(3660700001)(3280700002)(2900100001)(25786009)(36756003)(6506007)(76176011)(2906002)(6486002)(86612001)(99286004)(102836004)(1076002)(7736002)(97736004)(2616005)(446003)(486006)(11346002)(476003)(26005)(305945005)(6666003)(6512007)(4326008)(6306002)(107886003)(15760500003)(478600001)(6436002)(5660300001)(10290500003)(5250100002)(22452003)(316002)(105586002)(186003)(8676002)(110136005)(966005)(54906003)(72206003)(53936002)(2501003)(68736007)(14454004)(6116002)(8936002)(3846002)(81156014)(10090500001)(106356001)(81166006)(22906009)(217873001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB1128;
 H:DM5PR2101MB1032.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
x-microsoft-antispam-message-info: 3O4MJlHyKIAR3SHpnPlza90TE7MiKs2f5QQ/Sj1hLX0U2NA3YuN2clRm+JCLcx3MAznBR6CWSAKsXvbXzuEvw7tUqpp9eoDhiSsjA4HbzxkSGfawTBFtVm0/eCTRr4at5/cWELejPIxX7Rwz52kpDEdfq64zMcjCktpQ1nKe2kRyLYq1CBVVm2rTf7QIg0Uwl12igx7Kj1phrGeHBId5jBzHsn/WfC0BxfS/robNzmCXyxDAd/2PRWomiDf49YZPhhV09UZglzYGCFWCU+e1jPzi0B9t5rZnJusesPPdCTF8vhiV1b+8ZPHh+0ChZui07nxSIZh9bu2zcAAREiUo/yHryAkeeum14IraOjEQcXwBS6L7kKlIAplTaNV31h0TtEJslRxMvYjazo2/iUlZfFN/6QD2nRZ0VnbOUeqW+yw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2aef26-456a-4179-d43a-08d59daf740b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:56.8665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1128
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Aditya Bhandari <adityabh@microsoft.com>, "Michael
 Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 Andy Lutomirski <luto@kernel.org>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 David Zhang <dazhan@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Upstream commit 617ab45c9a8900e64a78b43696c02598b8cad68b ]

When hypercall-based TLB flush was enabled for Hyper-V guests PCID feature
was deliberately suppressed as a precaution: back then PCID was never
exposed to Hyper-V guests and it wasn't clear what will happen if some day
it becomes available. The day came and PCID/INVPCID features are already
exposed on certain Hyper-V hosts.

>From TLFS (as of 5.0b) it is unclear how TLB flush hypercalls combine with
PCID. In particular the usage of PCID is per-cpu based: the same mm gets
different CR3 values on different CPUs. If the hypercall does exact
matching this will fail. However, this is not the case. David Zhang
explains:

 "In practice, the AddressSpace argument is ignored on any VM that supports
  PCIDs.

  Architecturally, the AddressSpace argument must match the CR3 with PCID
  bits stripped out (i.e., the low 12 bits of AddressSpace should be 0 in
  long mode). The flush hypercalls flush all PCIDs for the specified
  AddressSpace."

With this, PCID can be enabled.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David Zhang <dazhan@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: devel@linuxdriverproject.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Aditya Bhandari <adityabh@microsoft.com>
Link: https://lkml.kernel.org/r/20180124103629.29980-1-vkuznets@redhat.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/hyperv/mmu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 9cc9e1c1e2db..56c9ebac946f 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -137,7 +137,12 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 	}
 
 	if (info->mm) {
+		/*
+		 * AddressSpace argument must match the CR3 with PCID bits
+		 * stripped out.
+		 */
 		flush->address_space = virt_to_phys(info->mm->pgd);
+		flush->address_space &= CR3_ADDR_MASK;
 		flush->flags = 0;
 	} else {
 		flush->address_space = 0;
@@ -219,7 +224,12 @@ static void hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 	}
 
 	if (info->mm) {
+		/*
+		 * AddressSpace argument must match the CR3 with PCID bits
+		 * stripped out.
+		 */
 		flush->address_space = virt_to_phys(info->mm->pgd);
+		flush->address_space &= CR3_ADDR_MASK;
 		flush->flags = 0;
 	} else {
 		flush->address_space = 0;
@@ -278,8 +288,6 @@ void hyperv_setup_mmu_ops(void)
 	if (!(ms_hyperv.hints & HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED))
 		return;
 
-	setup_clear_cpu_cap(X86_FEATURE_PCID);
-
 	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED)) {
 		pr_info("Using hypercall for remote TLB flush\n");
 		pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others;
-- 
2.15.1
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
