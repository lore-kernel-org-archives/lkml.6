Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-591328-1526491330-2-12158236347825220383
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526491329; b=kbdzU79p4bCJXlqLN+/YwAjUM7eT/G8cPMsARhvEFQhi0Zg3bv
    x3rkratKf20Zi4+wQcNDo6x+giyzrhv7AdsSEy0g7MRE5za4EdMsaG6CXYmMYlFm
    88rFG/YvJFulhFqAIhoJVboAmWIgF9Sb/ka5tQ1cc3IU3P5YGpbHaTX/1gh4mEuy
    AEcklvrkMFFMWcfVRTX2YxQaBWliM0WnqyyfIxYlf+si89xEesEawIyNGccsob0b
    PhGSu9dn4sU4PBVbqhYjNCHr9udmdgjImAoi3Hxm5sGH4C6XAL/YbLIqAW41uEXN
    zRTYdD0A7MrvADTnuxsUNTkVLFvZD9Qpa5cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526491329; bh=bqPqv
    EyRjgjbcCaREbL55tS31MdvvXaO+Lt8GuVXX08=; b=SeatvZ061F2TY0J052Bg6
    VG34/eLBLfAhb6Ssss8FPA82ec+0sQSnz2SlBk56GxtdeBsQgygoXr2bFwQb6xT0
    M9t9tbURjgzVsNN1JFYLCzV2IssMDJAIsIJJ144AsbKeW+oGObrWVxGSBqqe7PO2
    kP1QKL9YrI9jrj9nwAPo+Inc1F4TOBV+ELrPOSAPUVqWTxlT3HDR0iw4N3EYKLdu
    NnuTxXQXj+Hmu5X8rnu2L4i1ehsbq7i3bZwB63su3bNl5EPooW6fJuDTP/i78HTJ
    eiEfhyFTlrHpc+Gcexli/AM79rp+FVWaKre+3xczSJLlgjEfwGnRgydhY0ZwF8Dm
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=n1OHIIfM
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject)
    header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=microsoft.com header.i=@microsoft.com header.b=n1OHIIfM
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject)
      header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEumyegTE82cedjZTsSVAAvWxANeKkqONXzkzAUyiSBAES5TEab/D4WcX2ulWAO9WrbsaPxzxSeqSWiSfVsK7doQIbh6ZlGWi6jBtlqPWgBjH8k1wf24
    GdpS+pI8nXrmBzC+k2wYP6RA4C7w4ZG+BubdnZuqS881/D+XvV4psOuRIlkEbgWTa3P6ILFXDiw59SQGIAm8yP3iuJ6daMe+S09ASjBPYzixATeSKoWgn7br
    wO6AjetxeI0if8SHQQRTXw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=R4fxTKrshSIA:10 a=LGqW9EbBbJ0A:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Odnh0R2cAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=DDOyTI_5AAAA:8 a=DfNHnWVPAAAA:8 a=20KFwNOVAAAA:8
    a=oGMlB6cnAAAA:8 a=yMhMjlubAAAA:8 a=eLbcN1g5g8BIasPobxwA:9 a=CjuIK1q_8ugA:10
    a=lNAA6UHySJB7qmBR1x20:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=_BcfOz0m4U4ohdxiHPKc:22 a=rjTVMONInIDnV1a_A2c_:22 a=NdAtdrkLVvyUPsUoGJp4:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: KY Srinivasan <kys@microsoft.com>
To: KY Srinivasan <kys@microsoft.com>, "x86@kernel.org" <x86@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>, Stephen Hemminger
 <sthemmin@microsoft.com>, "Michael Kelley (EOSG)"
 <Michael.H.Kelley@microsoft.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH V2 0/5] X86: Hyper-V: APIC enlightenments 
Thread-Topic: [PATCH V2 0/5] X86: Hyper-V: APIC enlightenments 
Thread-Index: AQHT425BhKYs4Ou9tEWJOIx3YOic36QyrOoQ
Date: Wed, 16 May 2018 17:21:58 +0000
Message-ID: <MW2PR2101MB111381CFB4F6D34410DB936DA0920@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180504060653.3240-1-kys@linuxonhyperv.com>
In-Reply-To: <20180504060653.3240-1-kys@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:2::53d]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB1081;
 7:TJKG5Hp5YBCbE0j0hripZTnxexeaaIYb/TvaMJHOJgu2QNzoHak+QbGdGmH/bg2w6FURWo7KA3jfjzw6FeDe/ejovYjcUkpkkq3hF1GPghHb9QI/sn8gB3WEFFdr7GrLeQcDX3YUjiwnmy6Lboos5OtoaX1JdYhlbC2HQWtjvB3LaLKd0+iQJO0kj+ynMTun15qlsSOMLzlp7GJOHl9caK8ZVsqaTH3w98IfoGhRStO95WYjqs1/PBhT1rQ6AA9s;
 20:ZwxlqtZN69nxhwiW1qggShvVD/6V7Jcs7CaB0y5E6NGiy6YwbFZ1rPDELq5/nl77ZOfjS3y9ZuP7dtJZPFVFAPY0h052ymfxGUUQEDGrQ5YTn8e2eK9ediMpuc8ET1iOJto9MQR9+G4hGDoMUWCzwzn0JeJf6b73P9FeA/GSNGY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7193020);
 SRVR:MW2PR2101MB1081;
x-ms-traffictypediagnostic: MW2PR2101MB1081:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10811491BA7D237A8B3DA490A0920@MW2PR2101MB1081.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(198206253151910); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699015);
 SRVR:MW2PR2101MB1081; BCL:0; PCL:0; RULEID:; SRVR:MW2PR2101MB1081;
x-forefront-prvs: 0674DC6DD3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(396003)(39380400002)(39860400002)(376002)(13464003)(189003)(199004)(55016002)(316002)(9686003)(22452003)(5660300001)(10090500001)(4743002)(68736007)(229853002)(3660700001)(53936002)(6246003)(53546011)(6506007)(99286004)(33656002)(7416002)(7696005)(2201001)(76176011)(59450400001)(86362001)(86612001)(478600001)(5250100002)(102836004)(25786009)(2900100001)(10290500003)(2501003)(46003)(8990500004)(74316002)(105586002)(11346002)(446003)(2906002)(476003)(106356001)(97736004)(6436002)(3280700002)(6116002)(486006)(1511001)(7736002)(8676002)(81156014)(8936002)(81166006)(14454004)(305945005)(110136005)(921003)(1121003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1081;
 H:MW2PR2101MB1113.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: Acmq+Oimn1erDWupQUFV0u0xfz4ZcqAuA8ij8GBZFainstx0wNq8L2WCNdi8sPlplIwKErz0Ze4EpfOXVWuJyogBzDi7XMIRoqkYHt6htcM+hG2ChUAD8A4FJpcmFLdKJzY6Q20puwkzxraWDztYe5UyOJjwilfRg1npyNZ44dG+a8U8MBGRI5gVA+E2wSN6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3bf3cca9-98c0-4aed-d0a7-08d5bb5187d8
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf3cca9-98c0-4aed-d0a7-08d5bb5187d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2018 17:21:58.7660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1081
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: kys@linuxonhyperv.com <kys@linuxonhyperv.com>
> Sent: Thursday, May 3, 2018 11:07 PM
> To: x86@kernel.org; gregkh@linuxfoundation.org; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> apw@canonical.com; jasowang@redhat.com; tglx@linutronix.de;
> hpa@zytor.com; Stephen Hemminger <sthemmin@microsoft.com>; Michael
> Kelley (EOSG) <Michael.H.Kelley@microsoft.com>; vkuznets@redhat.com
> Cc: KY Srinivasan <kys@microsoft.com>
> Subject: [PATCH V2 0/5] X86: Hyper-V: APIC enlightenments
> 
> From: "K. Y. Srinivasan" <kys@microsoft.com>
> 
> Implement APIC related enlightenments.
> 
> V2: Addressed comments from Thomas Gleixner <tglx@linutronix.de>
> and Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>.

Thomas,

I think I have addressed all your comments;
let me know if you have any additional comments on this patch set.

Regards,

K. Y
> 
> K. Y. Srinivasan (5):
>   X86: Hyper-V: Enlighten APIC access
>   X86: Hyper-V: Enable IPI enlightenments
>   X86: Hyper-V: Enhanced IPI enlightenment
>   X86: Hyper-V: Consolidate code for converting cpumask to vpset
>   X86: Hyper-V: Consolidate the allocation of the hypercall input page
> 
>  arch/x86/hyperv/Makefile           |   2 +-
>  arch/x86/hyperv/hv_apic.c          | 259
> +++++++++++++++++++++++++++++++++++++
>  arch/x86/hyperv/hv_init.c          |  32 ++++-
>  arch/x86/hyperv/mmu.c              |  75 ++---------
>  arch/x86/include/asm/hyperv-tlfs.h |  30 ++++-
>  arch/x86/include/asm/mshyperv.h    |  39 +++++-
>  6 files changed, 365 insertions(+), 72 deletions(-)
>  create mode 100644 arch/x86/hyperv/hv_apic.c
> 
> --
> 2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
