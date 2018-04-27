Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3823599-1524809490-2-5319833707214141584
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
    1524809489; b=iWDDrFyjmJjijrz8HZ7LOQm4PTk3ohnCvoo1msq6vXivTbRhGi
    ZOi8eEOX17oSKruCZVlHB8R3qmRIMGYWCUQ1cdWOqYavJPiLApSRCUVJA/5hLTst
    ayVAzcKmzyAPVRHo5K8bo0SQs4gjhnIaeZJjuFeO2gfrwoH1jU3QLcfsECCHUkRQ
    4XGgKhvkqxCGk9PHDNVSbfaCCL8Nn9r/4pMJ6SgVTWOnduFzKD0IQie4RDzM9oT6
    NOwvG9AkZg9Fa2Fx+p/4SLEhg/RZizPoYoQ/MBlHHbWY6IkbTpDbUsmfkBbzfrGD
    MXCB01EjBe4mHm1hLeNRg+N2hNUyGZO3Lu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524809489; bh=9DsDw
    G1WxeuoHBdsMOrUUE7a8DmmEsoGKP7C2DAg8V0=; b=nhsxXomAgEp3fUJeycJzt
    0qPypxGkzt5WkP8KbV5f8MiCGPx0+fF+6vsYrfAZIJOek6XshDQWnfwdZPliaW5n
    zPOD3SgNY3iC3VMiUS7cAvR5+qPXlwLv5yavdm62dggActKHotzO8lTPFXq/Euy0
    heo+U+XbnNWPFqzZVWW002WzYvtC7ycwjcwt2j2d2L66j6Vaw5XDADdYsKejtsEt
    maZ0gCAZwnLso1rHiriyO+Hop+CfoeBIOUkCCSGRIyYRDmh5ncCp/W9hx7320yX7
    5EW6FnS2b2jrw3RK7wwDolTcXHU1tgM2LsSCA/NjGqzzVIFcxrZ7hYb1ciN8UFl7
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fuPvK11F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fuPvK11F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
X-CM-Envelope: MS4wfDYtiPDB2WmlnH5NE40KKAgozKWfc54/4xyJo97W3urL5RyJ7dEvtE03ve6ySvfZuYHEdAoAE5l9ao4jHnAy4W+WH0Qln7V0m3U8B6T3Jd4WTUWufkwH
    kuJfbTzgP4BLNl6kTNLb1K6g27hw01a89XYIBWrI0wIZ970uNQC9trjzienTD7UwucTwEzYZaJIYO9VcOj8eyu2WuBVZ3ze+ytQSadwG2RIRSHDAYMyGxmFB
    15/HLA99vy6wV7kOJtv+XA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=2_GqYZIPIjsA:10 a=P6MAjPsMllQA:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=DDOyTI_5AAAA:8 a=DfNHnWVPAAAA:8 a=20KFwNOVAAAA:8
    a=oGMlB6cnAAAA:8 a=Odnh0R2cAAAA:8 a=9HAh1oLsx4lBsO9bjgwA:9
    a=SQfKkDsCKQBFOkhy:21 a=priwg6WY3vhThofV:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=_BcfOz0m4U4ohdxiHPKc:22
    a=rjTVMONInIDnV1a_A2c_:22 a=NdAtdrkLVvyUPsUoGJp4:22 a=lNAA6UHySJB7qmBR1x20:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: KY Srinivasan <kys@microsoft.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH 2/5] X86: Hyper-V: Enable IPI enlightenments
Thread-Topic: [PATCH 2/5] X86: Hyper-V: Enable IPI enlightenments
Thread-Index: AQHT3MEu4uYWJdgpmkipM8S1SvacPaQTnMUAgACBqNA=
Date: Fri, 27 Apr 2018 06:11:17 +0000
Message-ID: <MW2PR2101MB11131D0D8C0B985B68308C25A08D0@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180425181110.8683-1-kys@linuxonhyperv.com>
 <20180425181250.8740-1-kys@linuxonhyperv.com>
 <20180425181250.8740-2-kys@linuxonhyperv.com>
 <alpine.DEB.2.21.1804262350040.1596@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1804262350040.1596@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:3d34:9b63:3fe:d485]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB1065;
 7:H0CupVo9XfVx0Q5CgXfEU2aloPE/RSXEBchyYP1IcuVromCvTCDW93uHLMcn8cx9dWxmfVlUxDFb+1pzz+tSvNuXjQD/UuIK8CxgfEDAADZQO9HnIHJ05jXlb/mtkLC8q5yvZU99p8qFijem0wAi/kS1Qea8YsGo+jtL+SvC0DRbNiUcKZYgSEXNxmUaUJkMKFgNjy1XnuOpb2A1UAy4KA+vKdoiaPRuNBS79NO0byvzaVB3soPC3V7Rz7twljs2;
 20:Bv/kWN+ZRI7gsez5FA8x3+FkDSWEVc/vG6iH//w1ZrR3qg1hrps6IJ40jpII/gO73cOOUNEVdJnG3AWN9MZm3w/0AnX8BMQPDcZTAj68OCsWa8qmhNDhUzwnVrznYXHdFFd0FSc8bQFvP893t4RvdUHOPnEkpWnXQRd5is1G94o=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7193020);
 SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106583A4037159314A1F6370A08D0@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(9452136761055)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);
 SRVR:MW2PR2101MB1065; BCL:0; PCL:0; RULEID:; SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0655F9F006
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(396003)(39380400002)(376002)(346002)(366004)(13464003)(189003)(199004)(11346002)(81166006)(97736004)(81156014)(6116002)(476003)(3280700002)(59450400001)(46003)(446003)(6436002)(2906002)(486006)(8936002)(8676002)(5250100002)(55016002)(2900100001)(186003)(33656002)(9686003)(68736007)(6246003)(10090500001)(3660700001)(14454004)(102836004)(4326008)(8990500004)(54906003)(25786009)(99286004)(305945005)(316002)(5660300001)(76176011)(106356001)(22452003)(93886005)(6506007)(7416002)(478600001)(86362001)(86612001)(10290500003)(74316002)(53936002)(7736002)(6916009)(105586002)(7696005)(53546011)(229853002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1065;
 H:MW2PR2101MB1113.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: FJCMcFGM17yhZ5r7FZg/qtJ5afVYyxJ3V+j6UkH2vkDugQtnyIXXvfrM/N9Dut+U8k2M8A8wvo47DPMiHX91x8VjKP5ek9Hdp7Pg1dTuSDC7sOpTGSrDNIK+GspYaYtEztrvkrq11lGvBPYZQdPBX+Sn8fbXM2HnBfjKCDdldUbIhWiqMfJwYWXbnkvY9YVr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 60d109e8-9715-470c-e8f9-08d5ac05b050
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d109e8-9715-470c-e8f9-08d5ac05b050
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2018 06:11:17.3568 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
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
> Sent: Thursday, April 26, 2018 3:09 PM
> To: KY Srinivasan <kys@microsoft.com>
> Cc: x86@kernel.org; gregkh@linuxfoundation.org; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> apw@canonical.com; jasowang@redhat.com; hpa@zytor.com; Stephen
> Hemminger <sthemmin@microsoft.com>; Michael Kelley (EOSG)
> <Michael.H.Kelley@microsoft.com>; vkuznets@redhat.com
> Subject: Re: [PATCH 2/5] X86: Hyper-V: Enable IPI enlightenments
> 
> On Wed, 25 Apr 2018, kys@linuxonhyperv.com wrote:
> > +static int __send_ipi_mask(const struct cpumask *mask, int vector)
> > +{
> > +	int cur_cpu, vcpu;
> > +	struct ipi_arg_non_ex **arg;
> > +	struct ipi_arg_non_ex *ipi_arg;
> > +	int ret = 1;
> 
> So this indicates whether __send_ipi_mask() can send to @mask or not. So
> please make it a bool and let it return false when it does not work, true
> otherwise. If you had used -Exxxx then it would have been more obvious,
> but
> this is really a boolean decision.

Agreed.
> 
> > +	unsigned long flags;
> > +
> > +	if (cpumask_empty(mask))
> > +		return 0;
> > +
> > +	if (!hv_hypercall_pg)
> > +		return ret;
> > +
> > +	if ((vector < HV_IPI_LOW_VECTOR) || (vector >
> HV_IPI_HIGH_VECTOR))
> > +		return ret;
> > +
> > +	local_irq_save(flags);
> > +	arg = (struct ipi_arg_non_ex
> **)this_cpu_ptr(hyperv_pcpu_input_arg);
> > +
> > +	ipi_arg = *arg;
> > +	if (unlikely(!ipi_arg))
> > +		goto ipi_mask_done;
> > +
> > +
> 
> Stray newline
> 
> > +	ipi_arg->vector = vector;
> > +	ipi_arg->reserved = 0;
> > +	ipi_arg->cpu_mask = 0;
> > +
> > +	for_each_cpu(cur_cpu, mask) {
> > +		vcpu = hv_cpu_number_to_vp_number(cur_cpu);
> > +		if (vcpu >= 64)
> > +			goto ipi_mask_done;
> 
> This is completely magic and deserves a comment.
> 
> > +
> > +		__set_bit(vcpu, (unsigned long *)&ipi_arg->cpu_mask);
> > +	}
> > +
> > +	ret = hv_do_hypercall(HVCALL_SEND_IPI, ipi_arg, NULL);
> > +
> > +ipi_mask_done:
> > +	local_irq_restore(flags);
> > +	return ret;
> > +}
> 
> ....
> 
> >  static int hv_cpu_init(unsigned int cpu)
> >  {
> >  	u64 msr_vp_index;
> >  	struct hv_vp_assist_page **hvp =
> &hv_vp_assist_page[smp_processor_id()];
> > +	void **input_arg;
> > +
> > +	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	*input_arg = page_address(alloc_page(GFP_ATOMIC));
> 
> This is called from the cpu hotplug thread and there is no need for an
> atomic allocation. Please use GFP_KERNEL.
> 
> >  	hv_get_vp_index(msr_vp_index);
> >
> > @@ -217,6 +224,10 @@ static int hv_cpu_die(unsigned int cpu)
> >  {
> >  	struct hv_reenlightenment_control re_ctrl;
> >  	unsigned int new_cpu;
> > +	void **input_arg;
> > +
> > +	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	free_page((unsigned long)*input_arg);
> 
> Hrm. Again this is called from the CPU hotplug thread when the cou is about
> to go down. But you can be scheduled out after free() and before disabling
> the assist thing below and the pointer persist. There is no guarantee that
> nothing sends an IPI anymore after this point.
> 
> So you have two options here:
> 
>   1) Disable interrupts, get the pointer, set the per cpu pointer to NULL,
>      reenable interruots and free the page
I will implement this approach.
> 
>   2) Keep the page around and check for it in the CPU UP path and avoid the
>      allocation when the CPU comes online again.
> 
> >  	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
> >  		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
> > @@ -260,6 +271,12 @@ void __init hyperv_init(void)
> >  	if ((ms_hyperv.features & required_msrs) != required_msrs)
> >  		return;
> >
> > +	/* Allocate the per-CPU state for the hypercall input arg */
> > +	hyperv_pcpu_input_arg = alloc_percpu(void  *);
> > +
> > +	if (hyperv_pcpu_input_arg == NULL)
> > +		return;
> 
> Huch. When that allocation fails, you return and ignore the rest of the
> function which has been there before. Weird decision.
I should have explained this. Failure of this allocation means that we would not have the
per-cpu hypercall input page which in turn would mean that we would not be able to invoke
any hypercalls. 

Regards,

K. Y

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
