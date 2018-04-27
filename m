Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3800878-1524810275-2-12973374858590132584
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524810274; b=BM9o2nl/kTnMdAtkO16GdEnKNCEwzjlPCm1oP54iKgbh54ZcVo
    LtcP8IHmMJyqFSMg/b+nvov/MglBHDgfpkyP4uLf+qm0lWdYJ38pqMHfwZRBS2KP
    aRJhE/lL4Sm15PYGVvUjB20QtNFfnUNzW2+LjI4x2+0Ao+LxWmtKiZNp0iXvtPI2
    Xzhd5NlClB4hc/jz3yE8DDaBdC3OZ8h22jcJxI0Zn/w+grnAgFY1EQKYHt2zm+FV
    QokqC0OG754wkjI8IDnjvxENUlJlo+NsVkWWtfMpF09WTudOLQ19fLAjL+IvB4Jd
    fRbEKNHMhRNoggbmtqBemuNac1JmXUaN4wEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524810274; bh=TpL5H
    XnTzpg6Vsdc9BubaVFG2QZTI7xdG45YaHwQMIs=; b=Ztu2qLqASrtwDZGUfQqP0
    c+Gzme9aU/UjLUeV8cEkTjOjiizgFCMiKO50Bpm66208DoKj2QLLMtzV4qei6cgE
    VpxhA+nHE+EkLxt6TzGHRszh4SCO0UhWdtHpT5+cVx8aVsRSaX473rKEbmB2yhNo
    /9GJCJoOmav+EwTTFNvnWtMf61Rn5+R/x3QDON2UxW5qOwZX62+Q513mv8SpjoZS
    lmleHOqfCntpdRac8RGUAz5hsY9pHy3kLKUDlIimw3SIUMIVJaeMf/ZeTh4xjvk2
    El6S7gf8DKgRSa8GxteXt1SMiP4A5AdDwh+I/6N5TiqGDarEKAG3YPufxpt3KVaW
    Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GL30GuYA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GL30GuYA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
X-CM-Envelope: MS4wfEVZ41Ha8QlCOgCZGll0iyzX8SebA52NLs5XQv9xyLEEa5byiJXxPl2bqO5z18Al281gqODKElcsA7d6vEBNMlEtrFbopMJlghNXPpiUbUWGDBQ4iUoR
    juZFo1glnheey/JE6gS4GlToMCrxXPuC40yuiBjzR+uw8v7+7Y29Idubg9ZMkV05k1cbE51jVNYTcC+aTB27PFCV/CjhKMO+x/5mKMR2NF0jBxbugH2dFr8V
    AVpQxpx31qlNIle28AW3qQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=2_GqYZIPIjsA:10 a=P6MAjPsMllQA:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=DDOyTI_5AAAA:8 a=DfNHnWVPAAAA:8 a=20KFwNOVAAAA:8
    a=oGMlB6cnAAAA:8 a=Odnh0R2cAAAA:8 a=6oxIMIWSAe7vDM4YaP0A:9
    a=GG-dIKL_kbPGUJrk:21 a=ezPHPedHrx019D7a:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=_BcfOz0m4U4ohdxiHPKc:22
    a=rjTVMONInIDnV1a_A2c_:22 a=NdAtdrkLVvyUPsUoGJp4:22 a=lNAA6UHySJB7qmBR1x20:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: KY Srinivasan <kys@microsoft.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH 3/5] X86: Hyper-V: Enhanced IPI enlightenment
Thread-Topic: [PATCH 3/5] X86: Hyper-V: Enhanced IPI enlightenment
Thread-Index: AQHT3MEtznURKON6iESarilPj8v1lqQTnwqAgACErqA=
Date: Fri, 27 Apr 2018 06:24:21 +0000
Message-ID: <MW2PR2101MB111348D79C56945B695A04C8A08D0@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180425181110.8683-1-kys@linuxonhyperv.com>
 <20180425181250.8740-1-kys@linuxonhyperv.com>
 <20180425181250.8740-3-kys@linuxonhyperv.com>
 <alpine.DEB.2.21.1804270009080.1596@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1804270009080.1596@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:3d34:9b63:3fe:d485]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB0940;
 7:dHL59BI31vMuDZ5fTfZSeSCO3CEm9Uh/DdoL/MB6JHj6q9l36RIFEeDkGB89H0q7sAuDdc+3I/5B6luSuRmh7+G791eYFI7ZfkLoJc/4pZikwXy4XFTYapvn/v6BP/zRL4cac06nouZ360VRzItg2YG1cX7e2Dr9zCXlvWJ7zufGCq/u/0VHqAs6P5MFmZyFpKZBXwfFHLJfiCy1BmY+6dTDnwFhke2Am39AwJcIMrPwY4tlux1WEhrZAnuk03cx;
 20:XK0aWhIXlZJxmhRvgp/QPn9FcRY3HTp6stLKi0m35xs7+I8GKbuUWSw+fI8t98jgZeToX92+GzUIMzAKn/V2O/hcF0ER9YtN6pv9Zv9H7T7TKp/XF+3lEeAzKVVYanPeta4dsJ3WGoA77JFuiXkRkG7DyNEpD2lIf/zFDH4H8mc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:MW2PR2101MB0940;
x-ms-traffictypediagnostic: MW2PR2101MB0940:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0940F88ACA3387FA30F9D884A08D0@MW2PR2101MB0940.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(198206253151910); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);
 SRVR:MW2PR2101MB0940; BCL:0; PCL:0; RULEID:; SRVR:MW2PR2101MB0940;
x-forefront-prvs: 0655F9F006
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(396003)(376002)(366004)(39380400002)(346002)(189003)(199004)(13464003)(6916009)(2900100001)(55016002)(446003)(11346002)(81156014)(81166006)(186003)(8936002)(102836004)(8676002)(486006)(6506007)(10090500001)(476003)(53546011)(8990500004)(7696005)(106356001)(33656002)(46003)(99286004)(93886005)(97736004)(76176011)(3660700001)(105586002)(478600001)(305945005)(68736007)(7416002)(54906003)(25786009)(6116002)(10290500003)(3280700002)(7736002)(5250100002)(316002)(9686003)(6436002)(6246003)(86362001)(4326008)(86612001)(14454004)(229853002)(53936002)(74316002)(22452003)(2906002)(5660300001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB0940;
 H:MW2PR2101MB1113.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: UrymhsIW9xytA9uAP6iMwY664O+0JWpvTc4IenZX+THbrKOkka8UYBw4c37xO88NyM4qlRNk7WcZNkexuKJI35Xjf0Bpks7RxGX13QbHbXgwMR8uRd13Ovyw3sIvtx8FmOU3lxpoggSd7bHCVk5pDfmi1kpAJ6kMl6Y09pQUc7zy+2C2ZyTi8HnleMZ+ZTty
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 45bf6fa6-a104-4e18-1070-08d5ac0783e8
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bf6fa6-a104-4e18-1070-08d5ac0783e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2018 06:24:21.8414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0940
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
> Sent: Thursday, April 26, 2018 3:17 PM
> To: KY Srinivasan <kys@microsoft.com>
> Cc: x86@kernel.org; gregkh@linuxfoundation.org; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> apw@canonical.com; jasowang@redhat.com; hpa@zytor.com; Stephen
> Hemminger <sthemmin@microsoft.com>; Michael Kelley (EOSG)
> <Michael.H.Kelley@microsoft.com>; vkuznets@redhat.com
> Subject: Re: [PATCH 3/5] X86: Hyper-V: Enhanced IPI enlightenment
> 
> On Wed, 25 Apr 2018, kys@linuxonhyperv.com wrote:
> >
> > +struct ipi_arg_ex {
> > +	u32 vector;
> > +	u32  reserved;
> > +	struct hv_vpset vp_set;
> 
> Please align that in tabular fashion for easy of reading
> 
> 	u32		vector;
> 	u32  		reserved;
> 	struct hv_vpset	vp_set;
> 
> > +};
> > +
> >  static struct apic orig_apic;
> >
> >  static u64 hv_apic_icr_read(void)
> > @@ -97,6 +103,40 @@ static void hv_apic_eoi_write(u32 reg, u32 val)
> >   * IPI implementation on Hyper-V.
> >   */
> >
> > +static int __send_ipi_mask_ex(const struct cpumask *mask, int vector)
> > +{
> > +	int nr_bank = 0;
> > +	struct ipi_arg_ex **arg;
> > +	struct ipi_arg_ex *ipi_arg;
> > +	int ret = 1;
> > +	unsigned long flags;
> 
> This is really horrible to read.
> 
> 	struct ipi_arg_ex *ipi_arg;
> 	struct ipi_arg_ex **arg;
> 	unsigned long flags;
> 	bool ret = false;
> 	int nr_bank = 0;
> 
> is really more conveniant for quick reading.
> 
> So the other more limited function has a lot more sanity checks vs. vector
> number and other things. Why are they not required here? Comment
> please.

Yes, I will add the comments. This function is called from the other function
after all the sanity checks have been done and hence are not replicated here.
> 
> > +	local_irq_save(flags);
> > +	arg = (struct ipi_arg_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
> > +
> > +	ipi_arg = *arg;
> > +	if (unlikely(!ipi_arg))
> > +		goto ipi_mask_ex_done;
> > +
> > +	ipi_arg->vector = vector;
> > +	ipi_arg->reserved = 0;
> > +	ipi_arg->vp_set.valid_bank_mask = 0;
> > +
> > +	if (!cpumask_equal(mask, cpu_present_mask)) {
> > +		ipi_arg->vp_set.format = HV_GENERIC_SET_SPARCE_4K;
> > +		nr_bank = cpumask_to_vpset(&(ipi_arg->vp_set), mask);
> 
> nr_bank really confused me. bank_nr is what you mean, not number of
> banks,
> right?
It is the number of banks. The hypercall used here is a variable length
hypercall.

Regards,

K. Y  
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
