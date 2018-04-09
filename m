Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233441-2-16727716571712602680
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233440; b=Zs0UFurDFpcS9OaZaXW+2yOuJiLwzWppiczwNWRiQlqOOkDUbY
    zawKsSePsUj+t/WajVYs5H6jCCOhJFBalJqOoOpoH/KgnKKWZVrQO2286RXTBZMH
    JhImQCWbcPVq6rmIK8pPPdSNDVvS1DjeBdSpFl/MfpoZdKpj0RG6B7i4BiZj1qe6
    qfugfhIMEgl2VHwE8MwYprd1gXC3u4T3GDZ9t/ISOMUR7CJMx+K0aA/I7lRN2XWI
    vSuYJzv1x2OeUbkzOe1eP9V/GEK4tHI8LBOzyHA2SleWySg/iWoaRXJ+bC7HICNd
    sk52W9HePmbmS7Et4Sx97UPfZmCBunlKUdeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523233440; bh=7Fs6n
    ATmFYTQMtJyQXgE+0FKk07KYH51LqHvYJ6SUgc=; b=ulLD7d+5W6Dx3NhSpMVPU
    bc5tTlxRwzLseI5MpNTpNkLOkUZadVaUVj/X0aJfNf+vu9BtLdlf+ko2lwYz4YEV
    Jx/VO4PMFyO2PQUqZsApbHcbifbbrETnSTiIm22vHXz2GvZyc0LBiB6U/LCiEEcU
    Z0G98O8uPvWfQ6n8+WGLhKwlMDBnrkT0c7+Mu2wdqliPxF8VNCYIaxShPFJ0Tu9j
    p1ZvAgEqp3D8e4UWH0R3MTNRB3hIqTUPsqyZbNXVpiNWJubI8WyH4nKAUrJaiswO
    PzpZqMpLCVGygsOGZpygXtyCT3P/1wzvBu1lDP2+NEha2EVljhhKdLQV7iL6d0/t
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ep3/yT9R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ep3/yT9R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLzYWIqNGstI9Q9MfzoR8vjajEM7q2UYuv4dK/G+zT9NxLvlk2WINfL2FxxeoqNjttVopv4aJLzUAHSgiKAiyE2a6hlxbsmniJ8fs3kiu2bplQQZZ0Zm
    GR2Lg94wJcrmStPY+5Kq0SrUSpLcQyjyZUmHmENpYfrVW8+k5PBjroyVt25Fd+AD8ttvje6ebFCh/zFXtZIW7FUqHfVpOduB3l8hgalH1f6M72DleeyluHgn
    enSbnp7yVyJGrs+wtN3OQg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
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
Subject: [PATCH AUTOSEL for 4.14 075/161] x86/hyperv: Stop suppressing
 X86_FEATURE_PCID
Thread-Topic: [PATCH AUTOSEL for 4.14 075/161] x86/hyperv: Stop suppressing
 X86_FEATURE_PCID
Thread-Index: AQHTz5ibqoT8u80qk0qWNOukXmqRrA==
Date: Mon, 9 Apr 2018 00:20:47 +0000
Message-ID: <20180409001936.162706-75-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB1080;
 7:3F8NSH+iLQtZXzup2GdAXxzRhYArdtur0lE1+mPE6cWrfpe4TFEwHEFqBv46lCum4BfdDhe6Lr4uTo+e0GYjn5lu9yhAXsg18oNStAXiHlnUIwF/2egQbqQ9K3ig582PpKbuKh1XAe3UhJM/sNW/F76jIjNPYdYLSgnhyS2uTburfhmLnOoDXRAzClpeKOwYNOEtEXHOxyMz4or2m/r7kD2KO0JSYa+d25OZtWJgUoWClu9geVCt9mWBEWCUpgGh;
 20:SnoypWpq1SVsDKxVz55rQaa0A97CL8ZTKrT6DhPTAqkQN4+7A7TebTLnX9I9WnR1MEdPaJVz69tmIamO7OMBHVmUXCqETgQW5+Cy3gfLu+W3NvwBwJjdWr2T/fQg/LLN9tEbTUSYJVhvywXGYztYkWJ6PBgobP/rxiMPtc6WoVg=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b9378145-ac5f-4cce-0d87-08d59db02b4b
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1080EA77015E300C5AAC2660FBBF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);
 SRVR:DM5PR2101MB1080; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB1080;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(2501003)(5250100002)(15760500003)(8936002)(10090500001)(5660300001)(3660700001)(446003)(107886003)(14454004)(36756003)(6436002)(476003)(3280700002)(2616005)(11346002)(4326008)(6666003)(6306002)(53936002)(6512007)(22452003)(305945005)(10290500003)(316002)(102836004)(2906002)(6116002)(66066001)(6506007)(3846002)(7736002)(966005)(486006)(54906003)(110136005)(186003)(72206003)(26005)(1076002)(105586002)(2900100001)(6486002)(97736004)(478600001)(81156014)(81166006)(86612001)(8676002)(106356001)(99286004)(86362001)(76176011)(68736007)(25786009)(22906009)(217873001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB1080;
 H:DM5PR2101MB1032.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
x-microsoft-antispam-message-info: 5JesscRjC8y/W6vLlW4yIhcadrXjdK4eRzC5Ec+BNAPpcb/r71tl4EGT6PZwN05T+TYaSSTON05SS5Ytgc1v3mF/sKaNiT70wpaQNuOVFCI+470A7ycFZtkKjSDa5eJKzgvWQToj44RH3M4u82hGsBt6XO329Q+YrnU+Ciycd+TPhiuZR5KQBWnwjZ2PerrE4kbvVd8Mw3E0iBGQyaqWHaV3yu1PAagQo0ZdnfIRslmu70s3z2JEfRN8UeQOFDs93Zm4bA23//8FhPuX8FeBxSn0XIYquxKcClt/aJEtrdgCp03r4Yq8OcBWTkCZShq5fbp1BQfftUDRYRTqkg1GxPCDEN9sUzl4WGgAc3432rg2fSztrCqKHUyCwLcVy5slhACmDA9Wn9PqMiOMiUqUUxnL5h117JllkGIz9PFHBd8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9378145-ac5f-4cce-0d87-08d59db02b4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:47.8472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
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
