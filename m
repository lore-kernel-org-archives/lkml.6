Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932823AbeCJFHZ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 00:07:25 -0500
Received: from mail-sn1nam01on0064.outbound.protection.outlook.com ([104.47.32.64]:56448
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750733AbeCJFHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 00:07:22 -0500
From: "Moger, Babu" <Babu.Moger@amd.com>
To: =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>
CC: "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 3/3] arch/x86/kvm: SVM: Introduce pause loop exit logic in
 SVM
Thread-Topic: [RFC 3/3] arch/x86/kvm: SVM: Introduce pause loop exit logic in
 SVM
Thread-Index: AQHTskILuZji7/Bk102D2H4qsWfG7aPIP9+AgAC1isA=
Date: Sat, 10 Mar 2018 05:07:20 +0000
Message-ID: <CY4PR12MB1768CC12C6685127A947D02795DD0@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1520007456-85293-1-git-send-email-babu.moger@amd.com>
 <1520007456-85293-4-git-send-email-babu.moger@amd.com>
 <20180309181233.GO12290@flask>
In-Reply-To: <20180309181233.GO12290@flask>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com;
x-originating-ip: [2600:1700:270:e9d0:2ccc:a3d7:fed3:a8a7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1623;7:QaNnNZqqaFSNOHWxKiXNwgDpdzbBfCRm8hDMgw1nmWMMoiq5u5DTHleinR7KQkMc94hZ6mIyzZDgiQEz68cPVn1mFiiqiWITJTTLqi2uCeYOBT8j6YKKylaV9ChZEKKzJTosQ0PERpfkguW+TXgVlZhBFzhi4jH6faXpQVsKGym8qKk7394Bpcjm875s8TzWnXhOycJR6r7wC0j6keAdhXIlLB+xjvhLNntscCuehZl7CPdP2yg/06DWY8Hgge+z;20:dKsGt5RDRvq7lDF4kmZz0411PpbmwiD7dKKuBdrqqO7A+Y3y+7P1/3RL2M/EkNed/NNbg7wT4J2C2idL4L+Ig4SA57HYOnjwVSWCf6/cB4/18sqV7TpnlX+s6ifjDUflXqLRGtpDdDP7otunL7m/XYWJ28TBgogjZRGvWXmC3Um5TLSH5EjChyUjz5UEexKX5Hi0+Ha+y0yANriZ4DuRz/MAljoPN8SgzYBOzGkz+ftSgfMMQWhmE/xjIjTlK2/G
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 537f4546-8758-4d2f-e47c-08d58644cd5f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1623;
x-ms-traffictypediagnostic: CY4PR12MB1623:
x-microsoft-antispam-prvs: <CY4PR12MB1623429C03E696718512985195DD0@CY4PR12MB1623.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR12MB1623;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1623;
x-forefront-prvs: 06070568C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(396003)(376002)(39380400002)(51914003)(377424004)(13464003)(199004)(189003)(43544003)(4326008)(3280700002)(106356001)(5660300001)(186003)(46003)(6436002)(55016002)(72206003)(97736004)(86362001)(53936002)(6116002)(76176011)(9686003)(2906002)(6246003)(2900100001)(68736007)(316002)(54906003)(229853002)(14454004)(105586002)(2950100002)(102836004)(478600001)(6506007)(33656002)(7696005)(8936002)(53546011)(74316002)(8676002)(25786009)(7736002)(305945005)(5250100002)(81156014)(6916009)(3660700001)(81166006)(59450400001)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1623;H:CY4PR12MB1768.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 6ftp8fbX01lt32HX07snaAPTNkP7WEGIj1cdN9Oyd5etEWAaMdOszA5mYlGOOmi7ZEQzweE4tuQF8asW5O94D0dnpZwW3ovXaL+kmHJnSPC5tPMHZCN/gSBym70ywhvjdREKajVPpyxxfC8FxsekGr02BXywDfmA/rOIZ7UlPtceyrXBNVEtEM6BXsNp+CXM12A0IW22TacSWnp5vikUmC7or2P/ZUkmP+s1qF8LtS6gKtUFPPp7xuuAu9x1k1Qlz10lT1DjEpHNyWQ9lddT5qk1bm15z64dSIrrLgu7bjKDh0EG3SoF8IyCeWtj7smIxOKbzmzOIxaSFEUJYRwyQg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537f4546-8758-4d2f-e47c-08d58644cd5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2018 05:07:20.2586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1623
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2A57W3q021551

Radim,
 Thanks for the comments. Taken care of most of the comments.
 I have few questions/comments. Please see inline.

> -----Original Message-----
> From: Radim Krèmáø <rkrcmar@redhat.com>
> Sent: Friday, March 9, 2018 12:13 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: joro@8bytes.org; tglx@linutronix.de; mingo@redhat.com;
> hpa@zytor.com; x86@kernel.org; pbonzini@redhat.com;
> kvm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [RFC 3/3] arch/x86/kvm: SVM: Introduce pause loop exit logic in
> SVM
> 
> 2018-03-02 11:17-0500, Babu Moger:
> > Bring the PLE(pause loop exit) logic to AMD svm driver.
> > We have noticed it help in situations where numerous pauses are
> generated
> > due to spinlock or other scenarios. Tested it with idle=poll and noticed
> > pause interceptions go down considerably.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  arch/x86/kvm/svm.c | 114
> ++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  arch/x86/kvm/x86.h |   1 +
> >  2 files changed, 114 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> > index 50a4e95..30bc851 100644
> > --- a/arch/x86/kvm/svm.c
> > +++ b/arch/x86/kvm/svm.c
> > @@ -263,6 +263,55 @@ struct amd_svm_iommu_ir {
> >  static bool npt_enabled;
> >  #endif
> >
> > +/*
> > + * These 2 parameters are used to config the controls for Pause-Loop
> Exiting:
> > + * pause_filter_thresh: On processors that support Pause
> filtering(indicated
> > + *	by CPUID Fn8000_000A_EDX), the VMCB provides a 16 bit pause filter
> > + *	count value. On VMRUN this value is loaded into an internal counter.
> > + *	Each time a pause instruction is executed, this counter is
> decremented
> > + *	until it reaches zero at which time a #VMEXIT is generated if pause
> > + *	intercept is enabled. Refer to  AMD APM Vol 2 Section 15.14.4 Pause
> > + *	Intercept Filtering for more details.
> > + *	This also indicate if ple logic enabled.
> > + *
> > + * pause_filter_count: In addition, some processor families support
> advanced
> 
> The comment has thresh/count flipped.

Good catch. Thanks

> 
> > + *	pause filtering (indicated by CPUID Fn8000_000A_EDX) upper bound
> on
> > + *	the amount of time a guest is allowed to execute in a pause loop.
> > + *	In this mode, a 16-bit pause filter threshold field is added in the
> > + *	VMCB. The threshold value is a cycle count that is used to reset the
> > + *	pause counter. As with simple pause filtering, VMRUN loads the
> pause
> > + *	count value from VMCB into an internal counter. Then, on each
> pause
> > + *	instruction the hardware checks the elapsed number of cycles since
> > + *	the most recent pause instruction against the pause filter threshold.
> > + *	If the elapsed cycle count is greater than the pause filter threshold,
> > + *	then the internal pause count is reloaded from the VMCB and
> execution
> > + *	continues. If the elapsed cycle count is less than the pause filter
> > + *	threshold, then the internal pause count is decremented. If the
> count
> > + *	value is less than zero and PAUSE intercept is enabled, a #VMEXIT is
> > + *	triggered. If advanced pause filtering is supported and pause filter
> > + *	threshold field is set to zero, the filter will operate in the simpler,
> > + *	count only mode.
> > + */
> > +
> > +static int pause_filter_thresh = KVM_DEFAULT_PLE_GAP;
> > +module_param(pause_filter_thresh, int, S_IRUGO);
> 
> I think it was a mistake to put signed values in VMX ...
> Please use unsigned variants and also properly sized.
> (The module param type would be "ushort" instead of "int".)

Sure. Will take care.
> 
> > +static int pause_filter_count = KVM_DEFAULT_PLE_WINDOW;
> > +module_param(pause_filter_count, int, S_IRUGO);
> 
> We are going to want a different default for pause_filter_count, because
> they have a different meaning.  On Intel, it's the number of cycles, on
> AMD, it's the number of PAUSE instructions.
> 
> The AMD's 3k is a bit high in comparison to Intel's 4k, but I'd keep 3k
> unless we have other benchmark results.

Ok. Testing with pause_filter_count = 3k for AMD. If everything goes fine, will make these changes.

> 
> > +static int ple_window_grow = KVM_DEFAULT_PLE_WINDOW_GROW;
> 
> The naming would be nicer with a consistent prefix.  We're growing
> pause_filter_count, so pause_filter_count_grow is easier to understand.
> (Albeit unwieldy.)

Sure. Will take care.

> 
> > +module_param(ple_window_grow, int, S_IRUGO);
> 
> (This is better as unsigned too ... VMX should have had that.)

Yes. Will fix it.

> 
> > @@ -1046,6 +1095,58 @@ static int avic_ga_log_notifier(u32 ga_tag)
> >  	return 0;
> >  }
> >
> > +static void grow_ple_window(struct kvm_vcpu *vcpu)
> > +{
> > +	struct vcpu_svm *svm = to_svm(vcpu);
> > +	struct vmcb_control_area *control = &svm->vmcb->control;
> > +	int old = control->pause_filter_count;
> > +
> > +	control->pause_filter_count = __grow_ple_window(old,
> > +							pause_filter_count,
> > +							ple_window_grow,
> > +
> 	ple_window_actual_max);
> > +
> > +	if (control->pause_filter_count != old)
> > +		mark_dirty(svm->vmcb, VMCB_INTERCEPTS);
> > +
> > +	trace_kvm_ple_window_grow(vcpu->vcpu_id,
> > +				  control->pause_filter_count, old);
> 
> Please move the tracing into __shrink_ple_window to share the code.
> This probably belongs to patch [2/3].

I will have to pass vcpu_id, and have to make few changes to display old and new values.
I am afraid it might add few more extra instructions.

> 
> > +/*
> > + * ple_window_actual_max is computed to be one grow_ple_window()
> below
> > + * ple_window_max. (See __grow_ple_window for the reason.)
> > + * This prevents overflows, because ple_window_max is int.
> > + * ple_window_max effectively rounded down to a multiple of
> ple_window_grow in
> > + * this process.
> > + * ple_window_max is also prevented from setting control-
> >pause_filter_count <
> > + * pause_filter_count.
> > + */
> > +static void update_ple_window_actual_max(void)
> > +{
> > +	ple_window_actual_max =
> > +		__shrink_ple_window(max(ple_window_max,
> pause_filter_count),
> 
> (I have no idea what I was thinking when I wrote that for VMX. :[
>  I'll write a patch to get rid of ple_window_actual_max, because its
>  benefits are really minuscule and the logic is complicated.)

If you are thinking of just straight forward removal, I can take care of it.

> 
> > +				    pause_filter_count,
> > +				    ple_window_grow, SHRT_MIN);
> > +}
> >  static __init int svm_hardware_setup(void)
> >  {
> >  	int cpu;
> > @@ -1309,7 +1412,11 @@ static void init_vmcb(struct vcpu_svm *svm)
> >  	svm->vcpu.arch.hflags = 0;
> >
> >  	if (boot_cpu_has(X86_FEATURE_PAUSEFILTER)) {
> > -		control->pause_filter_count = 3000;
> > +		control->pause_filter_count = pause_filter_count;
> > +		if (boot_cpu_has(X86_FEATURE_PFTHRESHOLD))
> > +			control->pause_filter_thresh = pause_filter_thresh;
> > +		else
> > +			pause_filter_thresh = 0;
> 
> Please move this to hardware_setup and also clear pause_filter_count if

Moving this to hardware_setup will be a problem.  We don't have access to svm data structure in hardware_setup.

> X86_FEATURE_PAUSEFILTER is not present.

Sure. Will clear pause_filter_count if X86_FEATURE_PAUSEFILTER is not present.
> 
> >  		set_intercept(svm, INTERCEPT_PAUSE);
> 
> The intercept should then be disabled iff pause_filter_count == 0.

Yes, will disable intercept if pause_filter_count is zero.

> 
> The functionality looks correct,
> 
> thanks!
