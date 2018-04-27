Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3800878-1524810698-2-3537738455283084005
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524810697; b=BUc0z5hHtQVqI7nVmYwoSWClve1Cqe/QZSOcHldo1iDQvYoXpv
    oSL4/mYO5+tH62CzonFPXh5irUMvWYXcAgIompJ62+rrSbuk4bUy/aTBaPhdeCjJ
    ME4JVOwJAXTuVnFPbQJq/VKm2bmdrNijmnvn4HVY5I1dvOpw+41pGBo47XvUMMSL
    3Po0I9WDZcvx4EIEIazKhbd60DCnqvS/eyiR5vTm01v3G5TFrbA4cmmKFmEO5fNu
    z7TwUGNaWWv9uFOPw/bwjCjyCodDW2RbyuDMjUpByV1poAU9A7hhaBO7KJcXO62s
    jZVq18ITP0/rkQrCjac/yl7bH0HwXL8OGcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524810697; bh=L4rQH
    juBPJa4ksPwKJYpQ29dlkd0k9Akj4unIPv3+94=; b=IPQ1jKkkMSFjM/NPp1zzb
    RijmLa2nZzHGvBiY+Vm1FfASRL3lmofB2FcRuoe1Q+e750e/hoCQNMWcKVFlQG0X
    LZ9JZOf7ZaneV16JM7XqlR2iEC0NVBCAmMFq3w1nRuEGQVNICMCFK8QeqoDd5VSB
    SSNXIBx+THPLNF1j0/EdGkcm5Td3PGN7zLDOSnWJwrg2w+5AakfW54r1vZjqSSYo
    H/+b7cLUApOOicvDreYv+UvNmudZGILFSXOCZtk82obkpMMJLJY0ylBU/lysf9rG
    LJOdWGE6tZOMbFhg9tJZvztMIUC4cvis9mRYII+ZrwpW2g/X81hi2t0RaV2E1Z9P
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N2bFwtcB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N2bFwtcB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHwz2jcpj07fqRIJmWrun884iORZJ5rVeu+ZOoevZd5AeKn14mNBUjLV9V4NWUvYer0JLgQB92QnXEC5yL1WBDGYhME4Ybq0piF98JjtFSh79KZ+B22b
    f2NC91QSrzZdgqbqwrgvp91OKs41HxYHA4oNwngMgc/K8aUd34SmV935WBAdUaZs1ZS3wteRQxjIJ1lMXobfOD7knF/xumazhfL5pw9gQiJmdm527Qs0TV0Y
    TKbZXk4iEisr4M2eDRgdxw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=2_GqYZIPIjsA:10 a=P6MAjPsMllQA:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=DDOyTI_5AAAA:8 a=DfNHnWVPAAAA:8 a=20KFwNOVAAAA:8
    a=oGMlB6cnAAAA:8 a=Odnh0R2cAAAA:8 a=agmDuBVc95zh06AGJQwA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=_BcfOz0m4U4ohdxiHPKc:22
    a=rjTVMONInIDnV1a_A2c_:22 a=NdAtdrkLVvyUPsUoGJp4:22 a=lNAA6UHySJB7qmBR1x20:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: KY Srinivasan <kys@microsoft.com>
To: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>, "x86@kernel.org"
 <x86@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>, Stephen Hemminger
 <sthemmin@microsoft.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH 2/5] X86: Hyper-V: Enable IPI enlightenments
Thread-Topic: [PATCH 2/5] X86: Hyper-V: Enable IPI enlightenments
Thread-Index: AQHT3MEu4uYWJdgpmkipM8S1SvacPaQTqZCAgAB/KHA=
Date: Fri, 27 Apr 2018 06:31:24 +0000
Message-ID: <MW2PR2101MB1113169BD526E9EA58ED400FA08D0@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180425181110.8683-1-kys@linuxonhyperv.com>
 <20180425181250.8740-1-kys@linuxonhyperv.com>
 <20180425181250.8740-2-kys@linuxonhyperv.com>
 <DM5PR2101MB1030AB156060230FB7A8BFCADC8E0@DM5PR2101MB1030.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB1030AB156060230FB7A8BFCADC8E0@DM5PR2101MB1030.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:3d34:9b63:3fe:d485]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB0985;
 7:sueCIkOiKVwos0tjB8xOu28BTHL56WQBk7UoH90VClOP7Y7r9HYno6wqRfxTn2+gxiCj+5Qan1N6gG4Y0zZMM7dnq4WYS/NUYxD6wpVJUZr6eHcarTo2z4i7DnMYPxEmPbKBAifW/lFO2YY/XuWsEIsuLkojUsA6CjEkJHQvXLaqj1YoKzkWQuYOH2LbpqKy0iuCWhr8veRdadBNMpTBD7HqlHw6RXdS6rxSqh8wAmSWrXNkSMMeRw6We58UAe6c;
 20:tS1rzKPgL1aZ1XW7OQP3+ajAoyg7xlkpffC9TVCCwTq/fdwL8YZBih8ZAJhpvN1CKoUTNSxc39YdfSm5CEzq0nmT628sjNMzU0/g9omkR9Gq8299sCdzcKbVatcez6IQRETpqVRFwTv+3QnohREAiVPbKpIMaTpJzK9hR9MeFXA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7193020);
 SRVR:MW2PR2101MB0985;
x-ms-traffictypediagnostic: MW2PR2101MB0985:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0985C4BEF88D7CD04A9DB1FDA08D0@MW2PR2101MB0985.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(198206253151910); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);
 SRVR:MW2PR2101MB0985; BCL:0; PCL:0; RULEID:; SRVR:MW2PR2101MB0985;
x-forefront-prvs: 0655F9F006
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(396003)(376002)(346002)(39380400002)(366004)(189003)(199004)(13464003)(10090500001)(110136005)(55016002)(9686003)(14454004)(8990500004)(6436002)(3660700001)(6116002)(86612001)(33656002)(2906002)(25786009)(3280700002)(53936002)(81156014)(8676002)(478600001)(81166006)(8936002)(6246003)(68736007)(5660300001)(7696005)(76176011)(6506007)(7736002)(102836004)(305945005)(53546011)(74316002)(10290500003)(2900100001)(1511001)(7416002)(99286004)(22452003)(316002)(446003)(97736004)(11346002)(106356001)(2501003)(5250100002)(486006)(229853002)(46003)(86362001)(93886005)(575784001)(476003)(105586002)(2201001)(921003)(1121003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB0985;
 H:MW2PR2101MB1113.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: gnwkc+NtQOp8GcpdljieUYHGGYMyBwuSLEekl2l1Jay+xsNWrZCFUWMAZO4aM7WyHcveN3nD+bKialXCrfVxfZxRteclQAy213op+z8wAdzh4ZH038JPY1RNZ/RvmJcmFOGNZeF5vZQxRWdpsmBRelm8Hl/FVmtHr3FAVq5amUlys+e2iYmEcDphB/vZyoZi
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0a4750cd-f41b-4781-718d-08d5ac087f90
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4750cd-f41b-4781-718d-08d5ac087f90
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2018 06:31:24.1330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0985
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
> From: Michael Kelley (EOSG)
> Sent: Thursday, April 26, 2018 3:55 PM
> To: KY Srinivasan <kys@microsoft.com>; x86@kernel.org;
> gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> jasowang@redhat.com; tglx@linutronix.de; hpa@zytor.com; Stephen
> Hemminger <sthemmin@microsoft.com>; vkuznets@redhat.com
> Subject: RE: [PATCH 2/5] X86: Hyper-V: Enable IPI enlightenments
> 
> > -----Original Message-----
> > From: kys@linuxonhyperv.com <kys@linuxonhyperv.com>
> > Sent: Wednesday, April 25, 2018 11:13 AM
> > To: x86@kernel.org; gregkh@linuxfoundation.org; linux-
> kernel@vger.kernel.org;
> > devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> jasowang@redhat.com;
> > tglx@linutronix.de; hpa@zytor.com; Stephen Hemminger
> <sthemmin@microsoft.com>;
> > Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>;
> vkuznets@redhat.com
> > Cc: KY Srinivasan <kys@microsoft.com>
> > Subject: [PATCH 2/5] X86: Hyper-V: Enable IPI enlightenments
> >
> > From: "K. Y. Srinivasan" <kys@microsoft.com>
> >
> > Hyper-V supports hypercalls to implement IPI; use them.
> >
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > ---
> >  arch/x86/hyperv/hv_apic.c          | 125
> +++++++++++++++++++++++++++++++++++++
> >  arch/x86/hyperv/hv_init.c          |  17 +++++
> >  arch/x86/include/asm/hyperv-tlfs.h |   9 +++
> >  arch/x86/include/asm/mshyperv.h    |   1 +
> >  4 files changed, 152 insertions(+)
> >
> > diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> > index e0a5b36208fc..7f3322ecfb01 100644
> > --- a/arch/x86/hyperv/hv_apic.c
> > +++ b/arch/x86/hyperv/hv_apic.c
> > @@ -30,6 +30,14 @@
> >  #include <linux/slab.h>
> >  #include <linux/cpuhotplug.h>
> >
> > +struct ipi_arg_non_ex {
> > +	u32 vector;
> > +	u32 reserved;
> > +	u64 cpu_mask;
> > +};
> 
> I think we'd like to put structures like this, which are defined in the
> Hyper-V Top Level Functional Spec, in hyperv-tlfs.h.  Also, the 5.0b
> version of the TLFS, which is latest, shows this structure on page 100:
> 
> 	u32 vector;
> 	u8  targetvtl;
> 	u8  reserved[3];
> 	u64 cpu_mask;
> 

Good point. I will make the necessary adjustments.

Regards,

K. Y
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
