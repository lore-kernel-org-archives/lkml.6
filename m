Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7956C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2E620878
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RLrmNOax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2E620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935361AbeF1Tnh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:43:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55514 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934012AbeF1Tng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:43:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5SJhZV5119753;
        Thu, 28 Jun 2018 19:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=Svc3MMOqn1vjfVRR43XIwk2yto2i23qq+azxArkVF0g=;
 b=RLrmNOax22UFmA3Ib7CTDi+UHs15XHLgL8d0O7SWEhXw3LBj00RCKjzanN64vDSdnWEo
 sO3qXcrR1clmQNWqfycuP3QsTHjcMggFM+dRVoM80rdzJ8x1vTsrH/fHXBZ89EhEVBsB
 y0o+M41WRb+XLvu6JIvsiUbsWY8EQ+yBEQESe1MiyT7pbenHmO9m30sqNUge+wguNAv7
 J+v2iuBAWeAvFEzwXPTj+nKUU2gj/KNGrtpoQ+x5BZT3i/Om9RRAO1VFySbrlbdYGEzO
 rtvCDGE5tiu2RDyLdD8mAmmZfZ924Rr8G0I8dyzD5ZMZq4jKpC3TJ1+KNRDCCMnfV244 ng== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2jum0abqf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jun 2018 19:43:35 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5SJhWH2017542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jun 2018 19:43:32 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5SJhWjp012306;
        Thu, 28 Jun 2018 19:43:32 GMT
Received: from mail-oi0-f47.google.com (/209.85.218.47)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Jun 2018 12:43:32 -0700
Received: by mail-oi0-f47.google.com with SMTP id f79-v6so6289753oib.7;
        Thu, 28 Jun 2018 12:43:32 -0700 (PDT)
X-Gm-Message-State: APt69E2PrSdeyF1TDx+keudPmWioXWnSstMNEHbJ1CeMAghK+ZLi8jHT
        Y4an9GLDEUhmCPh01eS+WQzNytWyXNNB7eAV7qA=
X-Google-Smtp-Source: AAOMgpcOf4HDUIREOv1UIM0AAujGjFEmGAP5yu8jMfC6dZQj8sn9WBhg3BgX/NWS43pzNNbwFxgvZ+5/gj0J6QYz6i0=
X-Received: by 2002:aca:3243:: with SMTP id y64-v6mr6962653oiy.136.1530215011083;
 Thu, 28 Jun 2018 12:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-10-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
 <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com>
 <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de>
 <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com>
 <alpine.DEB.2.21.1806270947410.1587@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806281159590.1778@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806281159590.1778@nanos.tec.linutronix.de>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Thu, 28 Jun 2018 15:42:54 -0400
X-Gmail-Original-Message-ID: <CAGM2read-NcUjssuUPHaf=qhdidT8f7cRNOs_GjdPnuOVvi-Lw@mail.gmail.com>
Message-ID: <CAGM2read-NcUjssuUPHaf=qhdidT8f7cRNOs_GjdPnuOVvi-Lw@mail.gmail.com>
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
To:     tglx@linutronix.de
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8938 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=865
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806280219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 11:23 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, 28 Jun 2018, Thomas Gleixner wrote:
> > I still want to document the unholy mess of what is initialized and
> > available when. We have 5 hypervisors and 3 different points in early boot
> > where the calibrate_* callbacks are overwritten. The XEN PV one is actually
> > post tsc_init_early() for whatever reason.
> >
> > That's all completely obscure and any attempt of moving tsc_early_init()
> > earlier than where it is now is just lottery.
> >
> > The other issue is that double calibration, e.g. doing the PIT thing twice
> > is just consuming boot time for no value.
> >
> > All of that has been duct taped over time and we really don't want yet
> > another thing glued to it just because we can.
>
> So here is the full picture of the TSC/CPU calibration maze:
>
> Compile time setup:
>         native_calibrate_tsc
>                 CPUID based frequency read out with magic fixups
>                 for broken CPUID implementations
>
>         native_calibrate_cpu
>                 Try the following:
>
>                 1) CPUID based (different leaf than the TSC one)
>                 2) MSR based
>                 3) Quick PIT calibration
>                 4) PIT/HPET/PMTIMER calibration (slow) and only
>                    available in tsc_init(). Could be made working
>                    post x86_dtb_init().
>
>
> Boot sequence:
>
>   start_kernel()
>
>         INTEL_MID:
>                 x86_intel_mid_early_setup()
>                 calibrate_tsc = intel_mid_calibrate_tsc
>
>                 intel_mid_calibrate_tsc() { return 0; }
>
>   setup_arch()
>
>         x86_init.oem.arch_setup();
>           INTEL_MID:
>                 intel_mid_arch_setup()
>
>                 PENWELL:
>                    x86_platform.calibrate_tsc = mfld_calibrate_tsc;
>
>                    MSR based magic. Value would be available right away.
>
>                 TANGIER:
>                    x86_platform.calibrate_tsc = tangier_calibrate_tsc;
>
>                    Different MSR based magic. Value would be available
>                    right away.
>
>         ....
>
>         init_hypervisor_platform()
>            vmware:
>                    Retrieves frequency and store it for the
>                    calibration function
>
>                    khz = vmware_get_khz_magic()
>                    vmware_tsc_khz = khz
>                    calibrate_cpu = vmware_get_tsc_khz
>                    calibrate_tsc = vmware_get_tsc_khz
>                    preset_lpj(khz)
>
>            hyperv:
>                    if special hyperv MSRs are available:
>
>                       calibrate_cpu = hv_get_tsc_khz
>                       calibrate_tsc = hv_get_tsc_khz
>
>                    MSR is readable already in this function
>
>            jailhouse:
>
>                    Frequency is available in this function and store
>                    in a variable for the calibration function
>
>                    calibrate_cpu        = jailhouse_get_tsc
>                    calibrate_tsc        = jailhouse_get_tsc
>
>         ...
>
>         kvmclock_init()
>
>                 if (magic_conditions)
>                         calibrate_tsc = kvm_get_tsc_khz
>                         calibrate_cpu = kvm_get_tsc_khz
>
>                         kvm_get_preset_lpj()
>                            khz = kvm_get_tsc_khz()
>                            preset_lpj(khz);
>
>         tsc_early_delay_calibrate()
>             tsc_khz = calibrate_tsc()
>             cpu_khz = calibrate_cpu()
>
>             ....
>             set_lpj(tsc_khz);
>
>
>         x86_init.paging.pagetable_init()
>            xen_pagetable_init()
>               xen_setup_shared_info()
>                  xen_hvm_init_time_ops()
>                     if (XENFEAT_hvm_safe_pvclock)
>                         calibrate_tsc = xen_tsc_khz
>
>                         PV clock based access
>
>         tsc_init()
>             tsc_khz = calibrate_tsc()
>             cpu_khz = calibrate_cpu()
>
>
> Putting this into a table:
>
> Platform        tsc_early_delay_calibrate()     tsc_init()
> -----------------------------------------------------------------------
>
> Generic         native_calibrate_tsc()          native_calibrate_tsc()
>                 native_calibrate_cpu()          native_calibrate_cpu()
>                 (Cannot do HPET/PMTIMER)
>
> -----------------------------------------------------------------------
>
> INTEL_MID       intel_mid_calibrate_tsc()       intel_mid_calibrate_tsc()
> Generic         native_calibrate_cpu()          native_calibrate_cpu()
>
> INTEL_MID       mfld_calibrate_tsc()            mfld_calibrate_tsc()
> PENWELL         native_calibrate_cpu()          native_calibrate_cpu()
>
> INTEL_MID       tangier_calibrate_tsc()         tangier_calibrate_tsc()
> TANGIER         native_calibrate_cpu()          native_calibrate_cpu()
>
> -----------------------------------------------------------------------
>
> VNWARE          vmware_get_tsc_khz()            vmware_get_tsc_khz()
>                 vmware_get_tsc_khz()            vmware_get_tsc_khz()
>
> HYPERV          hv_get_tsc_khz()                hv_get_tsc_khz()
>                 hv_get_tsc_khz()                hv_get_tsc_khz()
>
>
> JAILHOUSE       jailhouse_get_tsc()             jailhouse_get_tsc()
>                 jailhouse_get_tsc()             jailhouse_get_tsc()
>
>
> KVM             kvm_get_tsc_khz()               kvm_get_tsc_khz()
>                 kvm_get_tsc_khz()               kvm_get_tsc_khz()
>
> ------------------------------------------------------------------------
>
> XEN             native_calibrate_tsc()          xen_tsc_khz()
>                 native_calibrate_cpu()          native_calibrate_cpu()
>
> ------------------------------------------------------------------------
>
> The only platform which cannot use the special TSC calibration routine
> in the early calibration is XEN because it's initialized just _after_ the
> early calibration runs.
>
> For enhanced fun the early calibration stuff was moved from right after
> init_hypervisor_platform() to the place where it is now in commit
> ccb64941f375a6 ("x86/timers: Move simple_udelay_calibration() past
> kvmclock_init()") to speed up KVM boot time by avoiding the PIT
> calibration. I have no idea why it wasn't just moved past the XEN
> initialization a few lines further down, especially as the change was done
> by a XEN maintainer :) Boris?
>
> The other HV guests all do more or less the same thing and return the same
> value for cpu_khz and tsc_khz via the calibration indirection despite the
> value being known in the init_platform() function already.
>
> The generic initilizaiton does everything twice, which makes no sense,
> except for the unlikely case were no fast functions are available and the
> quick PIT calibration fails (PMTIMER/HPET) are not available in early
> calibration. HPET
>
> The INTEL MID stuff is wierd and not really obvious. AFAIR those systems
> don't have PIT or such, so they need to rely on the MSR/CPUID mechanisms to
> work, but that's just working because and not for obvious reasons. Andy,
> can you shed some light on that stuff?
>
> So some of this just works by chance, things are done twice and pointlessly
> (XEN). This really wants to be cleaned up and well documented which the
> requirements of each platform are, especially the Intel-MID stuff needs
> that.

Hi Thomas,

In addition to above, we have xen hvm:

setup_arch()
    ...
    init_hypervisor_platform();
        x86_init.hyper.init_platform();
            xen_hvm_guest_init()
                xen_hvm_init_time_ops();
    ...
    tsc_early_delay_calibrate();
        tsc_khz = x86_platform.calibrate_tsc(); == xen_tsc_khz()
    ...

Which works early.

So, what should we do with xen, which seems to be the only platform
that would provide different tsc frequency early and late, because of
different calibration method?

Thank you,
Pavel
