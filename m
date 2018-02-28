Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934738AbeB1Qcr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:32:47 -0500
Received: from mail-am5eur02hn0205.outbound.protection.outlook.com ([104.47.4.205]:44460
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752615AbeB1QOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 11:14:22 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com;
Date: Wed, 28 Feb 2018 19:14:06 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Andrey Smetanin <asmetanin@virtuozzo.com>,
        "Denis V . Lunev" <den@openvz.org>
Subject: Re: [PATCH 3/3] x86/kvm/hyper-v: inject #GP only when invalid SINTx
 vector is unmasked
Message-ID: <20180228161405.GC2376@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Andrey Smetanin <asmetanin@virtuozzo.com>,
        "Denis V . Lunev" <den@openvz.org>
References: <20180228134401.6544-1-vkuznets@redhat.com>
 <20180228134401.6544-4-vkuznets@redhat.com>
 <20180228151843.GB2376@rkaganb.sw.ru>
 <87lgfdgm8w.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lgfdgm8w.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0901CA0044.eurprd09.prod.outlook.com
 (2603:10a6:3:45::12) To DB6PR0801MB1974.eurprd08.prod.outlook.com
 (2603:10a6:4:75::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44173cfb-c666-419d-24e8-08d57ec64d4a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DB6PR0801MB1974;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1974;3:YP/LYZ53Qykt6oaXukgADZDgO0BGRsG8e9+krapKOM5FaWFYl7joetfUf8lcf4ouMcG9i05b7v0fWjwf8ayFKYu7LDuOA1BqRQz0opMjtxlEEzi5i2AqrE48PrWAND+1F35YoSFZYXjR92lVwWXPnhnaqCCNeCY2PsESpYQy+Hd+EMXFlXkMiy75KeWsy1MsA+h4htRmRcJeVJHEW44f5qQ4DHld8bmTQzl6MID7rzWsG/2+PVca0yrPVYALD/9m;25:uMe0Jl30pPWJFAY4hwEq8uDwD+rwcMBFhmz8PM+MougcsiYlxlIOgP2VQH0vVHGl0nGaP4Mc2QI6d8TZhq4ASnLARS1aAdYO3mZyezxdwvdCpU3btUgOWiaeJuctIA9XfvR0PomImof5mEtO7u9h/mYkzkmJnxkcqUxjxKlwHJw22EYvTZpjhXBScZcH7yHtSOEkEA5wcjUUbCoRilHIHsZWclNFEN6HiWn8baelUrGGps8b0FyunopNRYGaQ9p8Yl1U88HNXcmD1DM537aqKG+9vqvIqS2LuW1FB8V0zeG7iJnZicPaDbpChobEtzu+Zzl6yL4tDIpBoQW3AkQIhw==;31:llGoZFrak9bq5q6kGnq/V4pQrSwKh0o4aVn3AXHsDHucseXvY0ZvloFF43EQGOiNNDdrK6FfgEYpjodCt0wP6CcCOnxFM1BWa0fL6KP95qZ2UwSgAmEyLcKi7MCneTNalielLJvUagm0RRLPGf+s8OTPXLPqdeVbkD+gNFIoezTIgcfKFkn2bCOs8MJ1NxlUYd3b8mRALCbB/Sn11Z5wmPCQrr3NPB+g1VKGn1JE3zw=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1974:|DB6PR0801MB1974:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1974;20:W3kSvilQRQaMiMgplPKRO87QEMBu2vAoWsmNWFDMczScYEhjKJsfQ3pI2klDh7e//y28zQhW6DqmgNOOznGTc5yutWc9MIDdAuXmKfI3AslTjvrWGmHCL5CjSi/W77K7/UpHmJfgH/Q2rdskYhBCUz7IEYKHhTS9ygTezSJqiiURrPwq69GIfDTaZnxDlTCzQv1cTNhNzBeYwhVI11+Ba5GQmg1PuOpaTz8dkH4jmmFfYjdDSeLo0LynUheUrK1Btmxspaq5QZ+shmSLhXDeGfd/PwAdVfR1xhAFNhW9bTA7bcI9dFjtmn0yrPsVulnQRGM38ax9nYEu7ZAqnDkqNxI0RKir8zYY2EZ165jHDWiQ+vHmKu56ZMzpST17dfvLAMnEnskFLvUZajZeWs9E5DXNgwThEGZdt0ft16B/+0Yj2/2SdtTM9Vh9XAm8/jhZXITkHBb0fR0Bbv5wuApGpZ5ochxXfU1ciYFIf+EG+bZZKfoJU1CbVnrB6bPPB1Gd;4:eWLF9LBMJifA1mZIZzW0BI7kqu/uqXeoSQ2QfTJ1EgQ8fMtN1efLMwTwtJ63RNKDEVuygxJs2sEgOPawHN5L2OWZ0dLPqREokI2wskSK21zsAX8Lf2EPeuHgONQI1UtbfRYdNhjLf6ujKNmt4TBoUTkbOLgLVzmrSMc6fal2TuAgBQs746285lOxLqYM4Kbttq8NtgRAuwZnk6sTBPA6QcXnfLgU3SknjOB1ka6ehw+kPKxyXjiKzW+LIssZXBDuZ7PUViPppp5Nh+pxf9hwvKvDoqBlBx7wS3wfczKpSQK4rbMlhEwaeCiGb8NhGvU5
X-Microsoft-Antispam-PRVS: <DB6PR0801MB19749C0DFD8FA72476C8D2C1C9C70@DB6PR0801MB1974.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231220)(944501161)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041288)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DB6PR0801MB1974;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1974;
X-Forefront-PRVS: 0597911EE1
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(366004)(39850400004)(376002)(396003)(39380400002)(346002)(199004)(189003)(54094003)(7696005)(5660300001)(2950100002)(45080400002)(68736007)(106356001)(36756003)(478600001)(8936002)(305945005)(6916009)(105586002)(93886005)(97736004)(81156014)(8676002)(33656002)(81166006)(7736002)(66066001)(229853002)(6116002)(3846002)(47776003)(26005)(16586007)(53416004)(4326008)(76176011)(55016002)(53936002)(16526019)(2906002)(9686003)(69596002)(59450400001)(6246003)(52116002)(186003)(316002)(23726003)(1076002)(8666007)(55236004)(107886003)(86362001)(54906003)(6506007)(50466002)(6666003)(58126008)(25786009)(386003)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:DB6PR0801MB1974;H:rkaganb.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0801MB1974;23:KDpR+bt12kqngVOiU6tJBEgzXesEYMoCtehrRFJ?=
 =?us-ascii?Q?yGdFO2azoCbN9oMaIoF9DH8GmM6f4uYc6Iih0Zjl4KS0cQTHFutT9Io3kury?=
 =?us-ascii?Q?GP4gfbUOV3e1QIypMjPlcoE9UMglARjWQTRa0CVYWJbzj1+4gdJ1TW3smqT0?=
 =?us-ascii?Q?ZHC3jODpNxUH24DVau3fkcR8owiJKSA2qTDsl1mT0i2Kyd/gF6LxR2lwj1mT?=
 =?us-ascii?Q?bj/aGspEKSOg6NIVaoSuVJwQPCxcSl+6H2cpV6LAqgP1e93bHeMiQrzZPDbg?=
 =?us-ascii?Q?KR9xTkqrAXxFaCIVP4XUBxabm6Ydu+0FGUI8akYJYBHA9TF6IbNwc9I7yxxF?=
 =?us-ascii?Q?KVGG6HxqgWP+yoiIwAdgzAIV6TxeiGDp+nBeGFCH6GP+FSteSNzhMvyKU3cS?=
 =?us-ascii?Q?L048y6ngVVLtZ2dA/CV8EwY/VQLz1bpwgKgRSB3sbT+1K/OIXOE6EkN2efN6?=
 =?us-ascii?Q?kcTitywIJH3E+4XuNO1QAGXalQ8DgWnNlSB4NJOU6iqY/ww/756xa2XJ0oDx?=
 =?us-ascii?Q?WoZYN0wVjHz9fwMWEVSLPJu3gpwGT92tHk/tUALAJDyLVmgAbSC/1p426UC8?=
 =?us-ascii?Q?RsAbSSVY+D541ZfFfcdb8vnI/yMD06N+fTYp2PuyGT1io1Y3XSzvoOQ69gYx?=
 =?us-ascii?Q?vaQQYE7r8kFGzQdKB9mSok+TyGM3Gi0tcfMP2lfuebs6MDAWC1ZQrgRq6eLC?=
 =?us-ascii?Q?YNuusGXtjU7UFMbcqMT7eKvqM99q8J/miPbOB47LxYyIucl8pDA2z4FtmAKG?=
 =?us-ascii?Q?bg1WGl7ZpPSqaxm7G2vYTqYOydotgeWtQ4oC4DpnWC3nTdwy/4QPNY3fLI/D?=
 =?us-ascii?Q?2iebBdtf2/tKvK1/TH/gJi273fGlIAftFA8rJm7J0iAM7TaF/svI/lYrgPKB?=
 =?us-ascii?Q?a2ejFLjohEDepj92jvbTZ7dAZzfI3dABmogu1pRx2xkyu00i9dtVdu1DTTcS?=
 =?us-ascii?Q?NNF/3erZ+Pt7LNtco7PZQAhD+khRlDkkRQWePItLIIBWm/VMvIRpvNxM1t8z?=
 =?us-ascii?Q?jkqdU5MFJ9JtJijpowEQcVI4/cBaqf8wrvW4gtYRayphzr1lWN3Nq4Jszs0i?=
 =?us-ascii?Q?jn9KORnf5qQ7DFFgh8l/QACBHS9aDltyg1d2/dsql2QXb6+hRplNo98X3lzO?=
 =?us-ascii?Q?QuXzXFc8kiCfZR3li3zi/OiTGZITXSXWiOl+eT/o0rrcmYsaM4YxrSdccTiA?=
 =?us-ascii?Q?L/K22IfzBuQFvTdI7tcZkw6dqnNrlnGioXVXBh7mA5xLIHEEPsfMt6CCPQC3?=
 =?us-ascii?Q?51irRlGtlc3b2ds2LBQtq9SZpgE5kesSY1Gy6gBSBrat7rRJzKRPMtr5sfs7?=
 =?us-ascii?Q?SKvXHFKoUr42MSc+stryuBm9HzZU8EUZxJ3lWe+cSz13YR8yfe7lXVSCAiKw?=
 =?us-ascii?Q?xD2GowGstDx86sQNaOoy1thiJQzK9wmDgIVnqb0IxjpPRwSYGzAr4uHhcZX5?=
 =?us-ascii?Q?Qvt2jT8PLUWvlxHvVZDa88duLB/srY98KzaHBp9Vt2MM8TKWdmg97?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1974;23:QL6ncyGDndBZb+l1QTz5OfVSJwlfBZ/kuXFodXL8akwWVTUEoQf+xvtKZl5pq7rUsI07LklODRABDGsCfbQswb2+Ek6S2qix2pglzdojXVWrvKAmsgXKnH+me9dMWwMAg1c5fDnDx1AVUMfMCuVpNw==;6:QMdebbAZ6f1UBleJYlQJw6a0/6fAntX4u94jfHyxQ2sTXymAIPL1U2i/tPsY7c9J5Ngz6EH9b0fNyyaOCL+F29mtXbKwLfq7D33Qd2KnboKHANQdydZ3RzQAAI+c3SkQo+W7E6/882ujEovgCCKSgcm2ThU7Wq0qaP9lbi76BcWQdGAThtJrYnhl7WAsYEv4zWkwP0PFutpCl88E063ATEHVwB3keRkSplOL5sfDzox/4cTU0JPTFWo59b3SnVn8kfyFqVGrKIdteeX3XEQFrGj0meSkpezBEbv9oobOlObWc/dxoCAWf6lR1fxtV16L8Z2eXjwoO3H+RHFAaZCUoDB1j6RjQVMky0fYGroS+4k=;5:LmP8JOCwjI9ZR6zLkTGycmYjFVgccxF2vpaFKI7dbbEtcEptF6moT1wbPrzJv+AQyDKBAlGC2Xp4ZIJBEJLxspB0/wrNwXp37R2Nz4XKslD9DyR7pE2ZJA81THZrjGqAyPOCpBpM3vWa31qbf5tlcCJPS2dWu41cy/W+wBfSlRU=
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1974;7:4sn+9ZAYm5823Co9DOAE8LOQd5rC/FX13uEE31v4yoOUBt7pZzA4P3V/CqFamQrvW2k8w9AaUa1p1p/obXsiRaALtYOazT68AMAs1/2JDbHkyeUrmK77zqmBW7PRqmUSAoAVaLs3RDnTnZb0sqfcdocTLWYfeodH0swjBw9yMrxzbj2TBM+oh2QX28x+/1D2G5f5LSePd9cBgsQCfpc6iDmz6+YD0OSTBsOSQ+ZXDV2yQNngIsE9VvKzO6q7oWHU;20:Y3FtNwmiibkubvMmkWT2iHUcCw2M0TrXuGhlsiu37+DO5GspMOJa0J57ltJJ/zYplCED17SpqXGDM9VdBA8S0TYtqCzb0juqZoScMdVliFkPmoZL/78EXOPhhZBPpAUjotpfr20sQKsDx/anWCovPbQUCjtHJ6SYEM2bc9YkoO8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2018 16:14:09.8903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44173cfb-c666-419d-24e8-08d57ec64d4a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1974
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 04:35:59PM +0100, Vitaly Kuznetsov wrote:
> Roman Kagan <rkagan@virtuozzo.com> writes:
> 
> > On Wed, Feb 28, 2018 at 02:44:01PM +0100, Vitaly Kuznetsov wrote:
> >> Hyper-V 2016 on KVM with SynIC enabled doesn't boot with the following
> >> trace:
> >> 
> >>     kvm_entry:            vcpu 0
> >>     kvm_exit:             reason MSR_WRITE rip 0xfffff8000131c1e5 info 0 0
> >>     kvm_hv_synic_set_msr: vcpu_id 0 msr 0x40000090 data 0x10000 host 0
> >>     kvm_msr:              msr_write 40000090 = 0x10000 (#GP)
> >>     kvm_inj_exception:    #GP (0x0)
> >
> > I don't remember having seen this...  Does this happen with the mainline
> > QEMU, which doesn't set the SintPollingModeAvailable (17) bit in cpuid
> > 0x40000003:edx?
> 
> Yes, you need to have Hyper-V role enabled, kvm-intel modules needs to
> be loaded with 'nesting' support enabled.

Thanks, reproduced now.

> >> 
> >> KVM acts according to the following statement from TLFS:
> >> 
> >> "
> >> 11.8.4 SINTx Registers
> >> ...
> >> Valid values for vector are 16-255 inclusive. Specifying an invalid
> >> vector number results in #GP.
> >> "
> >> 
> >> However, I checked and genuine Hyper-V doesn't #GP when we write 0x10000
> >> to SINTx. I checked with Microsoft and they confirmed that if either the
> >> Masked bit (bit 16) or the Polling bit (bit 18) is set to 1, then they
> >> ignore the value of Vector. Make KVM act accordingly.
> >
> > I wonder if that cpuid setting affects this behavior?  Also curious what
> > exactly the guest is trying to achieve writing this bogus value?
> 
> The value is actually the default value which is supposed to be there:
> 
> "At virtual processor creation time, the default value of all SINTx
> (synthetic interrupt source) registers is 0x0000000000010000." so I
> guess this is just an intialization procedure.

Oh, sorry, I trapped on that polling thing throughout the patch so I
missed that the value you observe has actually only the masked bit set,
which is indeed the initial value (no idea why the guest *writes* it
though, it's the hypervisor's responsibility to put it there on vCPU
reset).

> >> 
> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> ---
> >>  arch/x86/include/uapi/asm/hyperv.h | 1 +
> >>  arch/x86/kvm/hyperv.c              | 7 ++++++-
> >>  2 files changed, 7 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/arch/x86/include/uapi/asm/hyperv.h b/arch/x86/include/uapi/asm/hyperv.h
> >> index 62c778a303a1..a492dc357bd7 100644
> >> --- a/arch/x86/include/uapi/asm/hyperv.h
> >> +++ b/arch/x86/include/uapi/asm/hyperv.h
> >> @@ -326,6 +326,7 @@ typedef struct _HV_REFERENCE_TSC_PAGE {
> >>  #define HV_SYNIC_SIEFP_ENABLE		(1ULL << 0)
> >>  #define HV_SYNIC_SINT_MASKED		(1ULL << 16)
> >>  #define HV_SYNIC_SINT_AUTO_EOI		(1ULL << 17)
> >> +#define HV_SYNIC_SINT_POLLING		(1ULL << 18)
> >>  #define HV_SYNIC_SINT_VECTOR_MASK	(0xFF)
> >>  
> >>  #define HV_SYNIC_STIMER_COUNT		(4)
> >> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> >> index 6d14f808145d..d3d866c32976 100644
> >> --- a/arch/x86/kvm/hyperv.c
> >> +++ b/arch/x86/kvm/hyperv.c
> >> @@ -95,9 +95,14 @@ static int synic_set_sint(struct kvm_vcpu_hv_synic *synic, int sint,
> >>  			  u64 data, bool host)
> >>  {
> >>  	int vector, old_vector;
> >> +	bool masked, polling;
> >>  
> >>  	vector = data & HV_SYNIC_SINT_VECTOR_MASK;
> >> -	if (vector < HV_SYNIC_FIRST_VALID_VECTOR && !host)
> >> +	masked = data & HV_SYNIC_SINT_MASKED;
> >> +	polling = data & HV_SYNIC_SINT_POLLING;
> >> +
> >> +	if (vector < HV_SYNIC_FIRST_VALID_VECTOR &&
> >> +	    !host && !masked && !polling)
> >>  		return 1;
> >>  	/*
> >>  	 * Guest may configure multiple SINTs to use the same vector, so
> >
> > I'm not sure this is enough to implement the polling mode: per spec,
> >
> 
> Oh, no, I wasn't trying to -- and by the way we don't currently announce
> SintPollingModeAvailable so guests are not supposed to do that. This is
> rather a future proof to 'not forget'.
> 
> >> Setting the polling bit will have the effect of unmasking an interrupt
> >> source, except that an actual interrupt is not generated.
> >
> > However, if the guest sets a valid vector and the masked bit cleared,
> > we'll consider it a usual SINT and add to masks and inject interrupts,
> > etc, regardless of the polling bit.
> >
> > I must admit I'm confused by the above quote from the spec: is the
> > polling bit supposed to come together with the masked bit?  If so, then
> > we probably should validate it here (but your logs indicate otherwise).
> > In general I'm missing the utility of this mode: why should an interrupt
> > controller be involved in polling at all?
> 
> "Setting the polling bit will have the effect of unmasking an interrupt
> source, except that an actual interrupt is not generated."
> 
> So, as I understand it, setting polling bit makes Vector value
> irrelevant - the interrupt is not generated so I *assume* we may see
> writes with zero Vector and polling bit set. But again, we're not
> implementing polling mode for now, I can just drop it from the patch if
> you think it is confusing.

I'd suggest indeed to leave polling out for now, as it seems to be a
different matter from the one being resolved by this patch (unless, of
course, there *are* known cases with invalid vector && !masked &&
polling).

Thanks,
Roman.
