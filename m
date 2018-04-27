Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3800878-1524808364-2-4849598509630347780
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
    1524808363; b=GfglI40gFPUadV4FtMP2LlobvX/Apie6tux19wx+LEMMp13XPV
    Gk27tvN46C0NoTDXgVZY2O+fla9rWovVW96rjxoUUSkUPZ9HOOECQLaZn2Eaw9uX
    43LBDZsSDT+XzAACV1R7k93lJmQ3SNcdrcoJklnd8eIBCg3inwCjmUEE+k5ORgI9
    8RyCvV8g/ta8/dgYwxbIWn2QPbhqN7HLTL/qrW6nfd9bh5eWAvrEWFALbA7mmxjy
    G714T8xd5awCKIPYX8fuk4DHIj404z3HDuvOQtYeUwkGrHpXdKKw3pvmGErtgvoA
    g0aM7FNXqIWTmhCZzk8gv8+sTdkouo9RPEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524808363; bh=mREMk
    P8UPt8EsZE/P7jw07pAVdxjOreZ41KbPpS//d0=; b=I2i7ma7EPCz0rueddwbi/
    QNQtoVrzowNXFDfJdBIHmsgi9xKHMKTVtJdR+2fwsGvHf2k8orOYAylN22uvAxH8
    CfMXmryDQvQGdCydo1mwRw+7g6GyY4p0gh8sMxSaI0OCHYSAi3lw8pWrZF2Dj3ds
    /FvziMXFCwy2Mcvay7ifUIMTm3rol6EUMT922/uTHZVe8UlrHTFmVmV2oZrAuZet
    cLGJa8gQ8l6m+r76yuwH/hHK7ihbrhwBC5Yase+4m3Knb/0stzY2wXJkiFTL63FE
    wW20amtJbWUSYmIDoONhAVGTStviv7BBDHfcElg0a0mKzP35hiLQnASaqob/K5Ae
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Tg6jaEAW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Tg6jaEAW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
X-CM-Envelope: MS4wfJPqtRDVm8JFDzNCLEKxK7++0uUXRY44mjQizoavmEmMRLZpKGJkdP93WVR4qLXxtjrnkirr5zcRUcCVrrAF5wSFVkgsazB7K+hDbFCcL8dy64UXQ2pr
    yIEcn3HN57Zyjhigg2yVLuJHwKQcy+SQeg2aio4KtuZcy1Yflwg598OsqmxLLknL+vEG2puopQPjI1bojTqOaHyaT3bZwPyODiwqve2OoXQzmKH0NtGeMQOg
    O8bbS4EG+XpUKjsdWEPJyQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=2_GqYZIPIjsA:10 a=P6MAjPsMllQA:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=DDOyTI_5AAAA:8 a=DfNHnWVPAAAA:8 a=20KFwNOVAAAA:8
    a=oGMlB6cnAAAA:8 a=Odnh0R2cAAAA:8 a=Z_Pjs2FIf0wGbC9dtPgA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=_BcfOz0m4U4ohdxiHPKc:22
    a=rjTVMONInIDnV1a_A2c_:22 a=NdAtdrkLVvyUPsUoGJp4:22 a=lNAA6UHySJB7qmBR1x20:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: KY Srinivasan <kys@microsoft.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH 1/5] X86: Hyper-V: Enlighten APIC access
Thread-Topic: [PATCH 1/5] X86: Hyper-V: Enlighten APIC access
Thread-Index: AQHT3MEt4bId0VfgvUSyGyqrvfSnAKQTl0wAgACE5mA=
Date: Fri, 27 Apr 2018 05:52:32 +0000
Message-ID: <MW2PR2101MB11133176E3843487485599A7A08D0@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180425181110.8683-1-kys@linuxonhyperv.com>
 <20180425181250.8740-1-kys@linuxonhyperv.com>
 <alpine.DEB.2.21.1804262342140.1596@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1804262342140.1596@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:3d34:9b63:3fe:d485]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB1131;
 7:0ORAO6WJnLtml1nDqQlenCiqDiFvMZoykYJAvQ7MXicEYa+k6qFVE9CFJXAGUPOHK1PuLntoiex03D+A7BRhHA7wd05GXAwUJx2I7yZLvQJCP/L6V6Ghhu/f/s3U65jfcxl9mcC5ts6oIDP7yrOM7qlA7W6Of46OtLn3GfkAHgodiBNSrjoqAnku5v4ijt8dOnYxuDvXSpVvrSQNBS3rhbz3Olo70Wb/JOz8xkLJDikUfxwEK5JyCdkBerMmI8xD;
 20:YoP2mzw1B7V+g8LUOz1OluK6MmAZNSO8v92HxwLidV0UeHeJbXO62Zln7AJa249d4SclcmrCIo6A62jP8FWhZ3SYGLXoPHrG1cm3IpqqXH1/rBsKVqco3R1tvUTcGOorBdNZ36ojLjGcwbq8vAsbgPSfWMKFVIzi/B6Ba1zBlAI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);
 SRVR:MW2PR2101MB1131;
x-ms-traffictypediagnostic: MW2PR2101MB1131:
x-microsoft-antispam-prvs: <MW2PR2101MB1131C24D204DF65105F75BF1A08D0@MW2PR2101MB1131.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(198206253151910); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:MW2PR2101MB1131; BCL:0; PCL:0; RULEID:; SRVR:MW2PR2101MB1131;
x-forefront-prvs: 0655F9F006
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39860400002)(366004)(346002)(376002)(39380400002)(199004)(189003)(13464003)(7416002)(97736004)(186003)(33656002)(7736002)(316002)(6916009)(22452003)(105586002)(106356001)(14454004)(76176011)(7696005)(476003)(99286004)(446003)(5250100002)(6346003)(11346002)(5660300001)(59450400001)(6116002)(486006)(102836004)(6506007)(53546011)(9686003)(53936002)(4326008)(55016002)(305945005)(10090500001)(8936002)(229853002)(2906002)(478600001)(6246003)(10290500003)(74316002)(3280700002)(46003)(54906003)(8990500004)(81156014)(6436002)(86612001)(81166006)(8676002)(3660700001)(25786009)(68736007)(2900100001)(86362001)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1131;
 H:MW2PR2101MB1113.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com;
x-microsoft-antispam-message-info: nyavMqoUOj00+3hVU3BOQT2oc9/e/GXUSJWnTZq6LT2RRv8krOpgByAnYIF7wAus9o/i5uJYCNwysh/BgDlo0jyJ9pLXtSOYAURcHCnaJZciGWk/wJhss7UwFHWFOwXcyxx/g1ePjxxxPEDM+NVMTQ0gwCMroTbXyvGn5+USs/zrx7vBhQANjB9/HBPmKAzw
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 70eb52b6-af5c-4613-01d1-08d5ac03119e
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70eb52b6-af5c-4613-01d1-08d5ac03119e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2018 05:52:32.1649 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1131
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
Cc: "olaf@aepfle.de" <olaf@aepfle.de>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "apw@canonical.com" <apw@canonical.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Thursday, April 26, 2018 2:49 PM
> To: KY Srinivasan <kys@microsoft.com>
> Cc: x86@kernel.org; gregkh@linuxfoundation.org; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> apw@canonical.com; jasowang@redhat.com; hpa@zytor.com; Stephen
> Hemminger <sthemmin@microsoft.com>; Michael Kelley (EOSG)
> <Michael.H.Kelley@microsoft.com>; vkuznets@redhat.com
> Subject: Re: [PATCH 1/5] X86: Hyper-V: Enlighten APIC access
> 
> On Wed, 25 Apr 2018, kys@linuxonhyperv.com wrote:
> > --- /dev/null
> > +++ b/arch/x86/hyperv/hv_apic.c
> > @@ -0,0 +1,98 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> Thanks for putting the license identifier in.
> 
> > +
> > +/*
> > + * Hyper-V specific APIC code.
> > + *
> > + * Copyright (C) 2018, Microsoft, Inc.
> > + *
> > + * Author : K. Y. Srinivasan <kys@microsoft.com>
> 
> But can you please check with your lawyers whether you can avoid the
> pointless boilerplate? The SPDX identifier should cover it.

I will consult with MSFT legal on this.
> 
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License version 2 as
> published
> > + * by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD
> TITLE or
> > + * NON INFRINGEMENT.  See the GNU General Public License for more
> > + * details.
> > + *
> > + */
> > +
> > +#include <linux/types.h>
> > +#include <asm/hypervisor.h>
> > +#include <asm/mshyperv.h>
> > +#include <linux/version.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/mm.h>
> > +#include <linux/clockchips.h>
> > +#include <linux/hyperv.h>
> > +#include <linux/slab.h>
> > +#include <linux/cpuhotplug.h>
> 
> We usually order the includes
> 
> #include <linux/....>
> ...
> #include <linux/....>
> 
> #include <asm/....>
> #include <asm/....>
> 
> 
> > -void hyperv_init(void);
> > +void __init hyperv_init(void);
> >  void hyperv_setup_mmu_ops(void);
> >  void hyper_alloc_mmu(void);
> >  void hyperv_report_panic(struct pt_regs *regs, long err);
> > @@ -269,14 +269,16 @@ void hyperv_reenlightenment_intr(struct pt_regs
> *regs);
> >  void set_hv_tscchange_cb(void (*cb)(void));
> >  void clear_hv_tscchange_cb(void);
> >  void hyperv_stop_tsc_emulation(void);
> > +void hv_apic_init(void);
> >  #else /* CONFIG_HYPERV */
> > -static inline void hyperv_init(void) {}
> > +static __init  inline void hyperv_init(void) {}
> 
> The __init on the empty inline function is pointless.
> 
> Other than the few nits. This looks well done!

Thanks Thomas. I will address all the issues you have brought up in
the next version.

Regards,

K. Y
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
