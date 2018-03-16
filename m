Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932807AbeCPCHJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 22:07:09 -0400
Received: from mail-by2nam01on0048.outbound.protection.outlook.com ([104.47.34.48]:9536
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932673AbeCPCHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 22:07:07 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
To: =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
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
Thread-Index: AQHTskILuZji7/Bk102D2H4qsWfG7aPIP9+AgAC1isCABtYfAIACZngQ
Date: Fri, 16 Mar 2018 02:07:04 +0000
Message-ID: <CY4PR12MB17684690F29A45DC86BBE98395D70@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1520007456-85293-1-git-send-email-babu.moger@amd.com>
 <1520007456-85293-4-git-send-email-babu.moger@amd.com>
 <20180309181233.GO12290@flask>
 <CY4PR12MB1768CC12C6685127A947D02795DD0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <20180314132613.GB28943@flask>
In-Reply-To: <20180314132613.GB28943@flask>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com;
x-originating-ip: [2600:1700:270:e9d0:aca6:ba18:d477:ecd9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1318;7:vWiBUD95hSULcHusvZG+zn4IbLwbnO/5jMoyqTkmZFLCx6ikTnNaijDpMZZKgdFuHGjBdIjk0De/yMEaMslF+wnC9OWOnPTkNFtS82XpQ4F59YGgonSsqU6/9aI7pQk08wUa1pQSiraZgxgxB/9dh4HsbI7ABXaxS+sm6Ab4cb1IWIjp6e09YxJXVfS50ur6a379LKTKCSJQ1qswUJZoGQlY5bbFcmK99G9tKHqr77awDaUtFAcPG7Zb27Oe93oF;20:CbJJGiQ8VU9k6V5xjRKdo+lMaplBQsGp9d1Ev5hOOH+OQtvi2/sQRNvLR5rHkbrn6gxv0DVTTtGtQUX4PoHhiPgLX1UjNesa4D1XVOkVs5q38dAS80daAMtJxNIe5zeOWoDS4XYwuVWxsT0CDLZKvWcGnjtZbIedioDje04WbC/Z/kxa3rqH5SGjAo01fcRgQUgIhhrVjmhf8YaJle16l6uBB3Q3r2r8kcMPt7yqnehn682hBIA09tqBN2W7eYnl
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3996fb3-014b-49cd-c18e-08d58ae29d2e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1318;
x-ms-traffictypediagnostic: CY4PR12MB1318:
x-microsoft-antispam-prvs: <CY4PR12MB13185840FD4FB1D123F36DBE95D70@CY4PR12MB1318.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(944501244)(52105095)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR12MB1318;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1318;
x-forefront-prvs: 0613912E23
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(376002)(366004)(346002)(43544003)(51914003)(377424004)(189003)(199004)(13464003)(305945005)(74316002)(7736002)(72206003)(4326008)(9686003)(2906002)(25786009)(6436002)(3280700002)(5250100002)(106356001)(55016002)(33656002)(102836004)(81166006)(93886005)(46003)(81156014)(59450400001)(8676002)(54906003)(53546011)(186003)(8936002)(105586002)(6506007)(86362001)(229853002)(14454004)(316002)(478600001)(2950100002)(6916009)(2900100001)(76176011)(7696005)(68736007)(53936002)(6246003)(6116002)(3660700001)(5660300001)(97736004)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1318;H:CY4PR12MB1768.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: wJWq85gVxxGEA2eMXXSubtfYUkOAihhkrv3n8jepp27/a9ZI9j9b/PhgxlA+7ep8ah2HrSN5bi+gXoczKwkOkrug3mJahm9cSUKFKb16UvxHL414oJ2NyEPKTejONkWvcP3oCowl6Ev3y3znlnstwqWtzXGaeBeKQSBWxFn5IsfIzoTnRJRww4qb8X0gvVwmcm3VyWkMQyJP8KjJ57VgAWvRl6uskwaNUhbmth+9kp5vnvx7AdV8H5YyKJyjN3V3+aH4k2at9evVll5Vf1cwkhG0JP4KluyeLVdCiu0fooHZ82yPB9ErOQFQPw7AMaeeIxr3SpM78WWXJaQcrXAQJw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3996fb3-014b-49cd-c18e-08d58ae29d2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2018 02:07:04.6184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1318
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2G27EDR010822



> -----Original Message-----
> From: Radim Krčmář <rkrcmar@redhat.com>
> Sent: Wednesday, March 14, 2018 8:26 AM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: joro@8bytes.org; tglx@linutronix.de; mingo@redhat.com;
> hpa@zytor.com; x86@kernel.org; pbonzini@redhat.com;
> kvm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [RFC 3/3] arch/x86/kvm: SVM: Introduce pause loop exit logic in
> SVM
> 
> 2018-03-10 05:07+0000, Moger, Babu:
> > Radim,
> >  Thanks for the comments. Taken care of most of the comments.
> >  I have few questions/comments. Please see inline.
> >
> > > -----Original Message-----
> > > From: Radim Krčmář <rkrcmar@redhat.com>
> > > Sent: Friday, March 9, 2018 12:13 PM
> > > To: Moger, Babu <Babu.Moger@amd.com>
> > > Cc: joro@8bytes.org; tglx@linutronix.de; mingo@redhat.com;
> > > hpa@zytor.com; x86@kernel.org; pbonzini@redhat.com;
> > > kvm@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [RFC 3/3] arch/x86/kvm: SVM: Introduce pause loop exit
> logic in
> > > SVM
> > >
> > > 2018-03-02 11:17-0500, Babu Moger:
> > > > Bring the PLE(pause loop exit) logic to AMD svm driver.
> > > > We have noticed it help in situations where numerous pauses are
> > > generated
> > > > due to spinlock or other scenarios. Tested it with idle=poll and noticed
> > > > pause interceptions go down considerably.
> > > >
> > > > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > > > ---
> > > > @@ -1046,6 +1095,58 @@ static int avic_ga_log_notifier(u32 ga_tag)
> > > >  	return 0;
> > > >  }
> > > >
> > > > +static void grow_ple_window(struct kvm_vcpu *vcpu)
> > > > +{
> > > > +	struct vcpu_svm *svm = to_svm(vcpu);
> > > > +	struct vmcb_control_area *control = &svm->vmcb->control;
> > > > +	int old = control->pause_filter_count;
> > > > +
> > > > +	control->pause_filter_count = __grow_ple_window(old,
> > > > +							pause_filter_count,
> > > > +							ple_window_grow,
> > > > +
> > > 	ple_window_actual_max);
> > > > +
> > > > +	if (control->pause_filter_count != old)
> > > > +		mark_dirty(svm->vmcb, VMCB_INTERCEPTS);
> > > > +
> > > > +	trace_kvm_ple_window_grow(vcpu->vcpu_id,
> > > > +				  control->pause_filter_count, old);
> > >
> > > Please move the tracing into __shrink_ple_window to share the code.
> > > This probably belongs to patch [2/3].
> >
> > I will have to pass vcpu_id, and have to make few changes to display old
> and new values.
> > I am afraid it might add few more extra instructions.
> 
> Right, vcpu_id isn't available in that function.
> Keeping it like this is ok.
> 
> > >
> > > > +/*
> > > > + * ple_window_actual_max is computed to be one
> grow_ple_window()
> > > below
> > > > + * ple_window_max. (See __grow_ple_window for the reason.)
> > > > + * This prevents overflows, because ple_window_max is int.
> > > > + * ple_window_max effectively rounded down to a multiple of
> > > ple_window_grow in
> > > > + * this process.
> > > > + * ple_window_max is also prevented from setting control-
> > > >pause_filter_count <
> > > > + * pause_filter_count.
> > > > + */
> > > > +static void update_ple_window_actual_max(void)
> > > > +{
> > > > +	ple_window_actual_max =
> > > > +		__shrink_ple_window(max(ple_window_max,
> > > pause_filter_count),
> > >
> > > (I have no idea what I was thinking when I wrote that for VMX. :[
> > >  I'll write a patch to get rid of ple_window_actual_max, because its
> > >  benefits are really minuscule and the logic is complicated.)
> >
> > If you are thinking of just straight forward removal, I can take care of it.
> 
> And tweaking the overflow handling to account for that.  Go ahead if
> you'd like to.

Ok. Will add new patch to the series to handle this. Thanks.

> 
> > >
> > > > +				    pause_filter_count,
> > > > +				    ple_window_grow, SHRT_MIN);
> > > > +}
> > > >  static __init int svm_hardware_setup(void)
> > > >  {
> > > >  	int cpu;
> > > > @@ -1309,7 +1412,11 @@ static void init_vmcb(struct vcpu_svm *svm)
> > > >  	svm->vcpu.arch.hflags = 0;
> > > >
> > > >  	if (boot_cpu_has(X86_FEATURE_PAUSEFILTER)) {
> > > > -		control->pause_filter_count = 3000;
> > > > +		control->pause_filter_count = pause_filter_count;
> > > > +		if (boot_cpu_has(X86_FEATURE_PFTHRESHOLD))
> > > > +			control->pause_filter_thresh = pause_filter_thresh;
> > > > +		else
> > > > +			pause_filter_thresh = 0;
> > >
> > > Please move this to hardware_setup and also clear pause_filter_count if
> >
> > Moving this to hardware_setup will be a problem.  We don't have access to
> svm data structure in hardware_setup.
> 
> I mean just the pause_filter_thresh = 0 and pause_filter_count = 0 logic

Sure. Will take care.

> based on boot_cpu_has (it's weird if the user-visible parameters are
> corrected after starting a VM);  VMCB configuration stays,
> 
> thanks.
