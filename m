Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbeC1VOL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 17:14:11 -0400
Received: from mail-sn1nam01on0044.outbound.protection.outlook.com ([104.47.32.44]:15136
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752447AbeC1VOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 17:14:09 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
To: =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>
CC: "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 5/5] KVM: SVM: Implement pause loop exit logic in SVM
Thread-Topic: [PATCH v2 5/5] KVM: SVM: Implement pause loop exit logic in SVM
Thread-Index: AQHTvWaz2NOsI7DuJ0Oj6ElmMltSFaPmLHWAgAALztA=
Date: Wed, 28 Mar 2018 21:14:06 +0000
Message-ID: <CY4PR12MB17680EEFE942F21483A47E4095A30@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1521232646-79580-1-git-send-email-babu.moger@amd.com>
 <1521232646-79580-6-git-send-email-babu.moger@amd.com>
 <20180328203036.GK26753@flask>
In-Reply-To: <20180328203036.GK26753@flask>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com;
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1926;7:OLYTfb8ZyvqcYxLl298wReJeZDOVqPalRlbrkEjYXPeqa5HSxrcEHij+/3iT5OWRVOt9vHVZsyh9dTf4sMq/Hje+IDM5veaY6YnHS/EBdC5zq/a8g6K45YTslIUcDkxQge1duZpUXHEVdeyZ0RHyGseIUbdkdUTBFJrCciZNfMSRqL0aa86KcOsL6oYiSTGUG+aP3bFuEFxcrGdG6cD0j390Hm4M6oc82YOZg1MAtp87fCqqLKedoUeN+8wj1Sp7;20:zOE18BsKjlCuXL9YWh66n7wsinKruVeaWrL7oQyLKdGsQw6qKdeAdPYWCFGGGplCrr8Sp/XB9lkpn9zAP0XFtybS3y2BO/kNH6l9SK1VkDGbSWsro9xdTqQzbYCE+qXXwhtTPJmZwu6VOIWaUUqY/9h8IBuzxAvYhEKHaeFd8rO54Xb5+sNaVqo6K0YaP60c/2WtMhHNcJShjoBgDwMw1cpqyUdJmsUu0GzeGVC5mAK/TfLnnvObkVkyfC7X4je3
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aec07374-6071-42a5-ecdc-08d594f0d6f9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1926;
x-ms-traffictypediagnostic: CY4PR12MB1926:
x-microsoft-antispam-prvs: <CY4PR12MB19267105DC0EB001602D211D95A30@CY4PR12MB1926.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(9452136761055)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR12MB1926;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1926;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(366004)(39380400002)(39860400002)(13464003)(189003)(199004)(377424004)(4326008)(5660300001)(99286004)(316002)(2900100001)(54906003)(7736002)(478600001)(6916009)(33656002)(229853002)(305945005)(6246003)(25786009)(74316002)(53546011)(6506007)(66066001)(5250100002)(53936002)(76176011)(486005)(476003)(11346002)(26005)(486005)(105586002)(81156014)(102836004)(186003)(446003)(72206003)(2906002)(14454004)(68736007)(3660700001)(3280700002)(6116002)(7696005)(3846002)(8676002)(6436002)(81166006)(86362001)(8936002)(55016002)(9686003)(106356001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1926;H:CY4PR12MB1768.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: HMHwbfICo0q+etKL0jTNElwcr7g3LoGkofPc3aZYsbFygQvX0Ir7B05+Y/FSMoEallbuN37Vtw75S6svZv6jCrDAjdCN5SkHRJ9CZmZ29PHSo/5WP/Ic7LOic3TmimIs28CLcplRDd6fyylIr63s62sFn4TJFd8TJ4TALbSoY8QoxAGV7nj7ubBK6mZFqsakg/9iS/6ps33JL0+NremOJb+lb1H8U43PAj0h8cOriqtbOlNDZpAxe02uWcecxYbsbkWYIK1Mxc1NpGvnNE8salkQqoAgdRTWPeZQCo/8OKECO/Qi9b7l119BMSFjmec1t/A/qLGk4CtUAbgEeOhoSA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec07374-6071-42a5-ecdc-08d594f0d6f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 21:14:06.1933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1926
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2SLEGrC006279


> -----Original Message-----
> From: Radim Krèmáø <rkrcmar@redhat.com>
> Sent: Wednesday, March 28, 2018 3:31 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: joro@8bytes.org; tglx@linutronix.de; mingo@redhat.com;
> hpa@zytor.com; x86@kernel.org; pbonzini@redhat.com;
> kvm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 5/5] KVM: SVM: Implement pause loop exit logic in
> SVM
> 
> 2018-03-16 16:37-0400, Babu Moger:
> > Bring the PLE(pause loop exit) logic to AMD svm driver.
> >
> > While testing, we found this helping in situations where numerous
> > pauses are generated. Without these patches we could see continuos
> > VMEXITS due to pause interceptions. Tested it on AMD EPYC server with
> > boot parameter idle=poll on a VM with 32 vcpus to simulate extensive
> > pause behaviour. Here are VMEXITS in 10 seconds interval.
> >
> > #VMEXITS 	Before the change  After the change
> > Pauses                  810199                  504
> > Total                   882184                  325415
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> > diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> > @@ -1046,6 +1094,42 @@ static int avic_ga_log_notifier(u32 ga_tag)
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
> > +
> 	pause_filter_count_grow,
> > +
> 	pause_filter_count_max);
> > +
> > +	if (control->pause_filter_count != old)
> > +		mark_dirty(svm->vmcb, VMCB_INTERCEPTS);
> > +
> > +	trace_kvm_ple_window_grow(vcpu->vcpu_id,
> > +				  control->pause_filter_count, old);
> > +}
> > +
> > +static void shrink_ple_window(struct kvm_vcpu *vcpu)
> > +{
> > +	struct vcpu_svm *svm = to_svm(vcpu);
> > +	struct vmcb_control_area *control = &svm->vmcb->control;
> > +	int old = control->pause_filter_count;
> > +
> > +	control->pause_filter_count =
> > +				__shrink_ple_window(old,
> > +						    pause_filter_count,
> > +						    pause_filter_count_shrink,
> > +						    0);
> 
> I've used pause_filter_count as minumum here as well and in all patches
> used 'unsigned int' instead of 'uint' in the code too match the rest of
> the kernel.
> 
> The series is in kvm/queue, please look at the changes and tell me if
> you'd like something done differently, thanks.

Ok. Looks good to me. Thanks.
