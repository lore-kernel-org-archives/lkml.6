Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-426418-1522856837-2-9841846464889776966
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522856836; b=nzeuWojygAAfkGTxHAOnrKvJq72at4gKBiSvIVh7HJY6B/LZRV
    J9uXXKR4s+boI3aKh5bbVqRTr7veTF4zT13G9Qq0az0+/cOZrO+hj8ARGk0ATFsX
    6oIDnGz6wpz7sy3SI5WLI8UvBGn7VBlkNOZoEutebIClA3HUww2ZlCwYH6PA/Fzu
    ETHJSlTkRaVkNyH5HNDlMC+VNAvT0z3ofxS8XI4sGREeuRCnnHmhiOPNsJrBr3zf
    Z/FW+5H8uzX8ZPMJpjl3oX8j4XqOVxPcDDRn3x/bzimxDsdlbqAz9E5gOO9/jnPi
    +cMGX9V3VCXxrKZQ0guqPH6bD9HRQYK458BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522856836; bh=mfEIz
    fkHCxNDBQ97LSWRJz4CKVd3k1Yct1AujJJolTk=; b=wwRlb6fmpco/FPdlXvQc2
    +MBBVgnaOx+1ThGBfCUrw8ObXfltAKEfQoYb/p1VkTSBe63FJ9zR3NhH2sx8DIzH
    3LEuFTxNxEM2Wm7BeFYvPCxetXQJ+O1wcO9t4Yw5cDDrXew43IL7ZelD0tZA/sZg
    R9U7fRuA3lbAPwt5q3RDZHEDrD6+8DJIjN1XwfZtvlUAl/0Dl5ghr/QLnOlifUJK
    m2m7fFudo9ZBQQBqhcks4sWjN/LKk8Tcnin0aFd5B3OHYxaakFcGr7we7urDPz8f
    g8vqGy+BfDUNcv9s841yTgNNHe6HXoeeOXiTgRta4eMOujQGLqXNPo3PC1OsVmlC
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=I+Gv8Xog x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=I+Gv8Xog x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDTZo5L88AGa2rHgeUm++eVxO9zei29wlhAyWJXUmS0Tc/Hggg5cnj4h53CiE2vTkeAnMUKKgi/IH0Ts7ak0zaPtIkl4OcjIqUz0V7O+CJLmRxhyFl5R
    lSQrePovBlnoHiLncR4SvNvF98XTNgfIreYIueXJpv3RrRF2rw15Yqhk0/2p7AAvYTZFD7GEckKfycM+IX6/BiUN0J8KiDHnrIv3rcBVIBXgY7/O0YvyZdd9
    z5r4FrOtUF/P/4hIOMqhUQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=Xzo3Qd75PJMA:10 a=KmlfMRa0bMIA:10
    a=vsqQXT3U9rAA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=DDOyTI_5AAAA:8 a=DfNHnWVPAAAA:8
    a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=D19gQVrFAAAA:8 a=poEthR6WssKxFhCzc9YA:9
    a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
    a=_BcfOz0m4U4ohdxiHPKc:22 a=rjTVMONInIDnV1a_A2c_:22 a=W4TVW4IDbPiebHqcZpNg:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v2 char-misc 1/1] x86/hyperv: Add interrupt handler
 annotations
Thread-Topic: [PATCH v2 char-misc 1/1] x86/hyperv: Add interrupt handler
 annotations
Thread-Index: AQHTy46r2zHDLe9OVEGvzyWeLTm/y6PwQ1mAgAAxeOA=
Date: Wed, 4 Apr 2018 15:47:03 +0000
Message-ID: <DM5PR2101MB10306FD0D4DD653D7878C2BEDCA40@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <1522789148-1787-1-git-send-email-mikelley@microsoft.com>
 <20180404081629.GA22277@kroah.com>
In-Reply-To: <20180404081629.GA22277@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-04-04T15:46:59.3288523Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [12.130.117.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB0869;
 7:HpllYzaSFWX3uA+icJoKo6MMfJGJHJjB08HV8wQAbFzTtjRpcv5DS21INNhTfcZoNNn96TEvhUDZrOW7GZZ8/IaQnzSiT4T8O4MNfU/H5mEDlIrHPXldpAR+lmEJfLWJNfie/KOV30uoNsPYjutqli3C6pJ+xvppi3PGs/CdvwQH7wqVLPJlyMMBCsrZJoUyp/qC5vDvbzW2TKMrjmDBZ/j3AQshA0z8War7gdB/gnkQ0tkuBoCiPEvto9q87E8d;
 20:GV7oblrGKYaXRbYnjsXjrFKk+85UtA04h7drvcDNcvSJ26KaumypDXfr8arwhIDTYaJQzbds6tCga/HuKa7dxhxU7KbTGWjphTf315x+X87Baf3ga6mS7+gdnl2i3uKQ0X1w8M29CgUAI84xUgK6WX2x3DdG0EEOVL2IKSVSVXw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7967f83c-a3f3-48bd-a1bb-08d59a434ff8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0869EC859BF7A180102E1273DCA40@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:DM5PR2101MB0869; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB0869;
x-forefront-prvs: 0632519F33
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39380400002)(39860400002)(346002)(396003)(376002)(199004)(189003)(13464003)(7696005)(6246003)(102836004)(316002)(59450400001)(22452003)(76176011)(33656002)(3280700002)(3660700001)(6506007)(486006)(53546011)(2906002)(54906003)(2900100001)(107886003)(8990500004)(10090500001)(74316002)(305945005)(106356001)(7736002)(97736004)(5660300001)(10290500003)(6436002)(6116002)(3846002)(6916009)(86612001)(14454004)(86362001)(229853002)(966005)(53936002)(6306002)(9686003)(105586002)(26005)(186003)(66066001)(5250100002)(8676002)(81166006)(99286004)(81156014)(8936002)(478600001)(476003)(68736007)(11346002)(4326008)(72206003)(446003)(25786009)(55016002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB0869;
 H:DM5PR2101MB1030.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
x-microsoft-antispam-message-info: v1p0hYtw34VSi4roj3SM092eAGE5UOBf485DDazqoXz3f8MM/33EVNB+7LpMKxwYXXJO8TZWk3gN+52Ux06bcCv7d6+k/tELTnZ3JnB72lYu/skU6ia46mBlQq2FdZh9qZPdr2h7JA/dNpOvwBatYqnY8Dt1lGSd2ykAKAh9UZWEEBfkT6VbYjOlMI5l20cAkUOYfhG4nSQXJTV7lRZ/hIZx6slsGERi6zV4GI8LsC0XyZNV6vH2hmsh17mp5j0uZK7hlNAXLIWpwRgXpFVN7xPIaKfXEC4l3pjFB/hAFv5KhqDkaCrh7M17P7TUeAlyQfGURQOFuDkNggpapctWO2vSi95lVnH9aZ0lwFhHZjxp1oNoKSlSOOuosTEBBUBZT41BWO//ozzejW0AO4Oi+kuLhhM7gcVA+TgsfevAaPQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7967f83c-a3f3-48bd-a1bb-08d59a434ff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2018 15:47:03.6255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
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
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
 "apw@canonical.com" <apw@canonical.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "leann.ogasawara@canonical.com" <leann.ogasawara@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, April 4, 2018 1:16 AM
> To: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
> Cc: linux-kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> apw@canonical.com; vkuznets@redhat.com; jasowang@redhat.com;
> leann.ogasawara@canonical.com; marcelo.cerri@canonical.com; Stephen Hemminger
> <sthemmin@microsoft.com>; KY Srinivasan <kys@microsoft.com>
> Subject: Re: [PATCH v2 char-misc 1/1] x86/hyperv: Add interrupt handler annotations
> 
> On Tue, Apr 03, 2018 at 01:59:08PM -0700, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mikelley@microsoft.com>
> >
> > Add standard interrupt handler annotations to
> > hyperv_vector_handler().
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> > Changes in v2:
> > * Fixed From: line
> > ---
> >  arch/x86/kernel/cpu/mshyperv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index 4488cf0..20f6849 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -41,7 +41,7 @@ static void (*hv_stimer0_handler)(void);
> >  static void (*hv_kexec_handler)(void);
> >  static void (*hv_crash_handler)(struct pt_regs *regs);
> >
> > -void hyperv_vector_handler(struct pt_regs *regs)
> > +__visible void __irq_entry hyperv_vector_handler(struct pt_regs *regs)
> 
> What bug does this solve?  What is wrong with the existing markings?
> What does __visible and __irq_entry give us that we don't already have
> and we need?
> 
> Are you really using LTO that requires this marking to prevent the code
> from being removed?

Thomas Gleixner commented on Vitaly Kuznetsov's Hyper-V reenlightenment patch
that the interrupt handler should have these annotations: see
https://lkml.org/lkml/2018/1/14/145

I put the same annotations on the interrupt handler for stimer0 Direct Mode,
So this change makes the hyperv_vector_handler() consistent with
hv_stimer0_vector_handler() in the same source file.  It does not fix any
immediate bug -- it's for consistency and alignment with what is apparently
standard practice.

Not sure what LTO is ...

Michael

> 
> thanks,
> 
> greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
