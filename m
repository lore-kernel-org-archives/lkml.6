Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68010C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 22:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F1121782
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 22:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHFLjTk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F1121782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbeHEAw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 20:52:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45193 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbeHEAw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 20:52:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id f12-v6so8738778wrv.12;
        Sat, 04 Aug 2018 15:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0Ppb79w6/p+8PKmVQ5PznU2Nm1vEqlcnCucxv1Ihqfc=;
        b=bHFLjTk6P1IY9fBEWVAtO5ubVH9lsu241PD53Id4vOHxyOGMxq1HYpwnMKeNx15uqT
         8942sio0sDVQOberxNMhcBj9AradGJwJdMB8RVgMjJPG8d2/7AKbXJR3oomzs5KjOiTt
         2qXqorNxrHFdWE1PSb8fw4utPKlQSGlAodQp0yI+zEiQI1xSHVes96xoAEJSl+rI9p6z
         x/vt6BUR29BqCYuBFYoXheYRetqYqCUC0E8RhnrKG9q+sh4+UDHmupTMfIe3n+yiFv9c
         AGwbBalKT4/xXcIErQZoRZ0Ouz9F1+jM/RDSSgKiHWJGtqugPF5YuReQoEEWPNMQ+14R
         4RFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Ppb79w6/p+8PKmVQ5PznU2Nm1vEqlcnCucxv1Ihqfc=;
        b=saUDeCPCtVVx2gBNWKir5Onwv+EOJSlBbuRnc/OGbRLSXw+3NNv7NrbXDIxC7Q1+r3
         05a3Axo34jbCCPRtD/QgOH4TLNxJRufGtn5SeM3nQAkvDEi9Yy9zZ8GxBytRciKPIpd7
         asdTDLX2itynsQ0QXc4o8DTUXWdmhowsilFpxriXozg49wcThJT+pk38JWARzmpkAJfb
         XsX6Adl9S6MnbYLEhY2MriA9yd236VGBZSMbiCENkBy+emEI+ZifNjPbK1n+gy6t4PjB
         +3tt3f+uvFtLVhNSzdluX1HpNsXfZb2xFgf7OzZlbwNk2rxlfMMGMf0M4dtb/SyI55Zt
         pXdg==
X-Gm-Message-State: AOUpUlH0HOR0mWpU2NVR9IaA6T16sX4vARs/5dyepgdLHtKwDFYkHbhS
        QAHKUpLcsvS5t54oJXKfirs=
X-Google-Smtp-Source: AAOMgpfjaghyYrTqvdCht+GXbLpkSvyu9Sn/UsTGTdpz5OWXHeq6c5hoSdjafX/Mo/+hn5U6HRZb8w==
X-Received: by 2002:adf:8ec2:: with SMTP id q60-v6mr5643255wrb.275.1533422999838;
        Sat, 04 Aug 2018 15:49:59 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 139-v6sm6134373wmp.4.2018.08.04.15.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 15:49:58 -0700 (PDT)
Date:   Sat, 4 Aug 2018 15:49:56 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH 4.4 106/124] netlink: Do not subscribe to non-existent
 groups
Message-ID: <20180804224956.GA5384@flashbox>
References: <20180804082702.434482435@linuxfoundation.org>
 <20180804082706.427556290@linuxfoundation.org>
 <20180804180734.GA25546@flashbox>
 <1533422007.2679.141.camel@arista.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <1533422007.2679.141.camel@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 04, 2018 at 11:33:27PM +0100, Dmitry Safonov wrote:
> On Sat, 2018-08-04 at 11:07 -0700, Nathan Chancellor wrote:
> > Hi Greg,
> 
> Hi Nathan,
> 
> > I am so sorry I didn't catch this in my initial report but this
> > commit
> > along with ba7aaf93ef2f ("netlink: Don't shift with UB on nlk-
> > >ngroups")
> > breaks mobile data on both the Pixel 2 XL and OnePlus 6. There is
> > signal
> > but it just never connects to 3G/LTE. Reverting those two commits
> > fixes
> > the issue.
> 
> Sorry for breaking your use-case,
> 

No apologies necessary, thank you for the quick response!

> > Nothing stands out to me in dmesg unfortunately and iven neither
> > device
> > is running a vanilla kernel, I cannot say if this is a problem in
> > mainline
> > or not but I just wanted to make you aware of it.
> 
> Could you provide the dmesg output for the attached debug diff?

dmesg output attached, please let me know if you need anything else.

> 
> -- 
> Thanks,
>              Dmitry

> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 7d860a22e5fb..0cddc35e1e87 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -1009,10 +1009,14 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
>  			return err;
>  	}
>  
> -	if (nlk->ngroups == 0)
> +	if (nlk->ngroups == 0) {
>  		groups = 0;
> -	else
> +	} else {
> +		if (groups != (groups & ((1ULL << nlk->ngroups) - 1)))
> +			pr_alert("%s: groups: %#lx ngroups: %u\n",
> +				current->comm, groups, nlk->ngroups);
>  		groups &= (1ULL << nlk->ngroups) - 1;
> +	}
>  
>  	bound = nlk->bound;
>  	if (bound) {

Cheers!
Nathan

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Initializing cgroup subsys schedtune
[    0.000000] Linux version 4.4.146-rc1-g93c31344 (nathan@flashbox) (gcc v=
ersion 8.2.1 20180804 (GCC)) #1 SMP PREEMPT Sat Aug 4 15:43:44 MST 2018
[    0.000000] Boot CPU: AArch64 Processor [51af8014]
[    0.000000] Machine: Qualcomm Technologies, Inc. MSM8998 v2.1
[    0.000000] Reserved memory: reserved region for node 'removed_regions@8=
5800000': base 0x0000000000000000, size 55 MiB
[    0.000000] Reserved memory: reserved region for node 'pil_ipa_gpu_regio=
n@95200000': base 0x0000000000000000, size 1 MiB
[    0.000000] Reserved memory: reserved region for node 'pil_slpi_region@9=
4300000': base 0x0000000000000000, size 15 MiB
[    0.000000] Reserved memory: reserved region for node 'pil_mba_region@94=
100000': base 0x0000000000000000, size 2 MiB
[    0.000000] Reserved memory: reserved region for node 'pil_video_region@=
93c00000': base 0x0000000000000000, size 5 MiB
[    0.000000] Reserved memory: reserved region for node 'modem_region@8cc0=
0000': base 0x0000000000000000, size 120 MiB
[    0.000000] Reserved memory: reserved region for node 'pil_adsp_region@0=
x8b200000': base 0x0000000000000000, size 26 MiB
[    0.000000] Reserved memory: reserved region for node 'spss_region@8ab00=
000': base 0x0000000000000000, size 7 MiB
[    0.000000] Reserved memory: reserved region for node 'alt_ramoops_regio=
n@b0e00000': base 0x0000000000000000, size 2 MiB
[    0.000000] Reserved memory: reserved region for node 'ramoops_region@b0=
000000': base 0x0000000000000000, size 2 MiB
[    0.000000] Reserved memory: reserved region for node 'ramoops_meta_regi=
on@affff000': base 0x0000000000000000, size 0 MiB
[    0.000000] Reserved memory: reserved region for node 'easel_mem@9600000=
0': base 0x0000000000000000, size 64 MiB
[    0.000000] Reserved memory: allocated memory for 'linux,cma' node: base=
 0x0000000000000000, size 32 MiB
[    0.000000] Reserved memory: created CMA memory pool at 0x00000000000000=
00, size 32 MiB
[    0.000000] Reserved memory: initialized node linux,cma, compatible id s=
hared-dma-pool
[    0.000000] Reserved memory: allocated memory for 'qseecom_region' node:=
 base 0x0000000000000000, size 20 MiB
[    0.000000] Reserved memory: created CMA memory pool at 0x00000000000000=
00, size 20 MiB
[    0.000000] Reserved memory: initialized node qseecom_region, compatible=
 id shared-dma-pool
[    0.000000] Reserved memory: allocated memory for 'adsp_region' node: ba=
se 0x0000000000000000, size 8 MiB
[    0.000000] Reserved memory: created CMA memory pool at 0x00000000000000=
00, size 8 MiB
[    0.000000] Reserved memory: initialized node adsp_region, compatible id=
 shared-dma-pool
[    0.000000] Reserved memory: allocated memory for 'sp_region' node: base=
 0x0000000000000000, size 8 MiB
[    0.000000] Reserved memory: created CMA memory pool at 0x00000000000000=
00, size 8 MiB
[    0.000000] Reserved memory: initialized node sp_region, compatible id s=
hared-dma-pool
[    0.000000] Reserved memory: allocated memory for 'secure_region' node: =
base 0x0000000000000000, size 92 MiB
[    0.000000] Reserved memory: created CMA memory pool at 0x00000000000000=
00, size 92 MiB
[    0.000000] Reserved memory: initialized node secure_region, compatible =
id shared-dma-pool
[    0.000000] Removed memory: created DMA memory pool at 0x000000000000000=
0, size 55 MiB
[    0.000000] Reserved memory: initialized node removed_regions@85800000, =
compatible id removed-dma-pool
[    0.000000] Removed memory: created DMA memory pool at 0x000000000000000=
0, size 7 MiB
[    0.000000] Reserved memory: initialized node spss_region@8ab00000, comp=
atible id removed-dma-pool
[    0.000000] Removed memory: created DMA memory pool at 0x000000000000000=
0, size 26 MiB
[    0.000000] Reserved memory: initialized node pil_adsp_region@0x8b200000=
, compatible id removed-dma-pool
[    0.000000] Removed memory: created DMA memory pool at 0x000000000000000=
0, size 120 MiB
[    0.000000] Reserved memory: initialized node modem_region@8cc00000, com=
patible id removed-dma-pool
[    0.000000] Removed memory: created DMA memory pool at 0x000000000000000=
0, size 5 MiB
[    0.000000] Reserved memory: initialized node pil_video_region@93c00000,=
 compatible id removed-dma-pool
[    0.000000] Removed memory: created DMA memory pool at 0x000000000000000=
0, size 2 MiB
[    0.000000] Reserved memory: initialized node pil_mba_region@94100000, c=
ompatible id removed-dma-pool
[    0.000000] Removed memory: created DMA memory pool at 0x000000000000000=
0, size 15 MiB
[    0.000000] Reserved memory: initialized node pil_slpi_region@94300000, =
compatible id removed-dma-pool
[    0.000000] Removed memory: created DMA memory pool at 0x000000000000000=
0, size 1 MiB
[    0.000000] Reserved memory: initialized node pil_ipa_gpu_region@9520000=
0, compatible id removed-dma-pool
[    0.000000] Removed memory: created DMA memory pool at 0x000000000000000=
0, size 0 MiB
[    0.000000] Reserved memory: initialized node ramoops_meta_region@affff0=
00, compatible id removed-dma-pool
[    0.000000] Removed memory: created DMA memory pool at 0x000000000000000=
0, size 2 MiB
[    0.000000] Reserved memory: initialized node ramoops_region@b0000000, c=
ompatible id removed-dma-pool
[    0.000000] Removed memory: created DMA memory pool at 0x000000000000000=
0, size 2 MiB
[    0.000000] Reserved memory: initialized node alt_ramoops_region@b0e0000=
0, compatible id removed-dma-pool
[    0.000000] On node 0 totalpages: 981439
[    0.000000] DMA zone: 7252 pages used for memmap
[    0.000000] DMA zone: 0 pages reserved
[    0.000000] DMA zone: 464127 pages, LIFO batch:31
[    0.000000] Normal zone: 8083 pages used for memmap
[    0.000000] Normal zone: 517312 pages, LIFO batch:31
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: Initializing psci_cpu_init
[    0.000000] psci: Initializing psci_cpu_init
[    0.000000] psci: Initializing psci_cpu_init
[    0.000000] psci: Initializing psci_cpu_init
[    0.000000] psci: Initializing psci_cpu_init
[    0.000000] psci: Initializing psci_cpu_init
[    0.000000] psci: Initializing psci_cpu_init
[    0.000000] PERCPU: Embedded 18 pages/cpu @0000000000000000 s42584 r0 d3=
1144 u73728
[    0.000000] pcpu-alloc: s42584 r0 d31144 u73728 alloc=3D18*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7=
=20
[    0.000000] CPU features: enabling workaround for Kryo2xx Silver erratum=
 845719
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 966104
[    0.000000] Kernel command line: rcupdate.rcu_expedited=3D1 androidboot.=
hardware=3Dtaimen lpm_levels.sleep_disabled=3D1 user_debug=3D31 msm_rtb.fil=
ter=3D0 ehci-hcd.park=3D3 service_locator.enable=3D1 swiotlb=3D2048 firmwar=
e_class.path=3D/vendor/firmware loop.max_part=3D7 raid=3Dnoautodetect usbco=
re.autosuspend=3D7 androidboot.dtbo_idx=3D12 buildvariant=3Duser androidboo=
t.revision=3Drev_10 androidboot.bootreason=3Dreboot androidboot.hardware.sk=
u=3DG011C bootcable.type=3D400MA androidboot.ddr_size=3D4096MB androidboot.=
ddr_info=3DSAMSUNG msm_poweroff.download_mode=3D0 androidboot.ramdump_enabl=
e=3D0 androidboot.hardware.display=3DMP androidboot.hardware.ufs=3D64GB,SAM=
SUNG androidboot.cid=3D00000000 androidboot.hardware.color=3DVB androidboot=
=2Ehardware.variant=3DGA00125-US androidboot.hardware.mid=3D2 androidboot.b=
oottime=3D1BLL:132,1BLE:618,2BLL:28,2BLE:190,AVB:395,KL:0,KD:368,ODT:143,SW=
:9997 androidboot.verifiedbootstate=3Dorange androidboot.keymaster=3D1 dm=
=3D"1 vroot none ro 1,0 5159992 verity 1 PARTUUID=3Dafdc0422-f919-8350-27ef=
-db5e6713a765 PARTUUID=3Da
[    0.000000] device-mapper: init: will configure 1 devices
[    0.000000] log_buf_len individual max cpu contribution: 131072 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 917504 bytes
[    0.000000] log_buf_len min size: 131072 bytes
[    0.000000] log_buf_len: 1048576 bytes
[    0.000000] early log buf free: 122152(93%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 =
bytes)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 by=
tes)
[    0.000000] software IO TLB [mem 0xf5800000-0xf5c00000] (4MB) mapped at =
[0000000000000000-0000000000000000]
[    0.000000] Memory: 3570632K/3925756K available (15934K kernel code, 170=
5K rwdata, 9092K rodata, 4032K init, 4498K bss, 191284K reserved, 163840K c=
ma-reserved)
[    0.000000] Virtual kernel memory layout:\x0a    modules : 0xffffff80000=
00000 - 0xffffff8008000000   (   128 MB)\x0a    vmalloc : 0xffffff800800000=
0 - 0xffffffbdbfff0000   (   246 GB)\x0a      .init : 0x0000000000000000 - =
0x0000000000000000   (  4032 KB)\x0a      .text : 0x0000000000000000 - 0x00=
00000000000000   ( 15936 KB)\x0a    .rodata : 0x0000000000000000 - 0x000000=
0000000000   (  9152 KB)\x0a      .data : 0x0000000000000000 - 0x0000000000=
000000   (  1706 KB)\x0a    vmemmap : 0xffffffbdc0000000 - 0xffffffbfc00000=
00   (     8 GB maximum)\x0a              0xffffffbdf2000000 - 0xffffffbdf5=
f93000   (    63 MB actual)\x0a    fixed   : 0xffffffbffe7fb000 - 0xffffffb=
ffec00000   (  4116 KB)\x0a    PCI I/O : 0xffffffbffee00000 - 0xffffffbfffe=
00000   (    16 MB)\x0a    memory  : 0xffffffcc80000000 - 0xffffffcd7e4c000=
0   (  4068 MB)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8, N=
odes=3D1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] \x09RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] NR_IRQS:64 nr_irqs:64 0
[    0.000000] mpm_init_irq_domain(): Cannot find irq controller for qcom,g=
pio-parent
[    0.000000] MPM 1 irq mapping errored -517
[    0.000000] \x09Offload RCU callbacks from all CPUs
[    0.000000] \x09Offload RCU callbacks from CPUs: 0-7.
[    0.000000] Architected cp15 and mmio timer(s) running at 19.20MHz (virt=
/virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cy=
cles: 0x46d987e47, max_idle_ns: 440795202767 ns
[    0.000003] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every =
4398046511078ns
[    0.000013] clocksource: Switched to clocksource arch_sys_counter
[    0.001696] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 38.40 BogoMIPS (lpj=3D19200)
[    0.001705] pid_max: default: 32768 minimum: 301
[    0.001825] Security Framework initialized
[    0.001832] Yama: becoming mindful.
[    0.001849] SELinux:  Initializing.
[    0.001922] SELinux:  Starting in permissive mode
[    0.001997] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.002050] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 b=
ytes)
[    0.002632] Initializing cgroup subsys freezer
[    0.003147] sched-energy: Sched-energy-costs installed from DT
[    0.003177] ASID allocator initialised with 32768 entries
[    0.003256] NOHZ: local_softirq_pending 02
[    0.004022] NOHZ: local_softirq_pending 02
[    0.046268] Brought up 8 CPUs
[    0.046279] SMP: Total of 8 processors activated.
[    0.046285] CPU features: detected feature: GIC system register CPU inte=
rface
[    0.046639] CPU: All CPU(s) started at EL1
[    0.046691] alternatives: patching kernel code
[    0.121111] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 1911260446275000 ns
[    0.121337] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    0.192378] pinctrl core: initialized pinctrl subsystem
[    0.194505] NET: Registered protocol family 16
[    0.198317] schedtune: init normalization constants...
[    0.198346] schedtune: CLUSTER[0-3]      min_pwr:     0 max_pwr:    66
[    0.198368] schedtune: CPU[0]            min_pwr:     0 max_pwr:   201
[    0.198388] schedtune: CPU[1]            min_pwr:     0 max_pwr:   201
[    0.198405] schedtune: CPU[2]            min_pwr:     0 max_pwr:   201
[    0.198422] schedtune: CPU[3]            min_pwr:     0 max_pwr:   201
[    0.198441] schedtune: CLUSTER[4-7]      min_pwr:     0 max_pwr:   203
[    0.198458] schedtune: CPU[4]            min_pwr:     0 max_pwr:  1683
[    0.198475] schedtune: CPU[5]            min_pwr:     0 max_pwr:  1683
[    0.198490] schedtune: CPU[6]            min_pwr:     0 max_pwr:  1683
[    0.198507] schedtune: CPU[7]            min_pwr:     0 max_pwr:  1683
[    0.198522] schedtune: SYSTEM            min_pwr:     0 max_pwr:  7805
[    0.198539] schedtune: using normalization constants mul: 212959942 sh1:=
 1 sh2: 12
[    0.198554] schedtune: configured to support 5 boost groups
[    0.200047] cpuidle: using governor menu
[    0.200102] cpuidle: using governor qcom
[    0.202444] vdso: 2 pages (1 code @ 0000000000000000, 1 data @ 000000000=
0000000)
[    0.202475] vdso32: 2 pages (1 code @ 0000000000000000, 1 data @ 0000000=
000000000)
[    0.202530] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.205156] DMA: preallocated 256 KiB pool for atomic allocations
[    0.205405] msm_smem_init: unable to create logging context
[    0.205486] msm_smd_init: unable to create SMD logging context
[    0.205503] msm_smd_init: unable to create SMSM logging context
[    0.205899] <CORE> glink_init: unable to create log context
[    0.206336] <CORE> glink_core_register_transport: unable to create log c=
ontext for [dsps:smd_trans]
[    0.206541] <CORE> glink_core_register_transport: unable to create log c=
ontext for [lpass:smd_trans]
[    0.206710] <CORE> glink_core_register_transport: unable to create log c=
ontext for [mpss:smd_trans]
[    0.206873] <CORE> glink_core_register_transport: unable to create log c=
ontext for [wcnss:smd_trans]
[    0.207076] <CORE> glink_core_register_transport: unable to create log c=
ontext for [rpm:smd_trans]
[    0.208947] Failed to create IPC log0
[    0.208964] Failed to create IPC log1
[    0.208977] Failed to create IPC log2
[    0.208988] Failed to create IPC log3
[    0.208999] Failed to create IPC log4
[    0.209354] exit: IPA_USB init success!
[    0.227061] unable to find DT imem restart info node
[    0.227088] restart_handler_init failure
[    0.229422] unable to find DT imem DLOAD mode node
[    0.231441] unable to find DT imem EDLOAD mode node
[    0.233888] spmi spmi-0: PMIC arbiter version v3 (0x30000000)
[    0.251392] sps:sps is ready.
[    0.259950] (NULL device *): msm_gsi_probe:2843 failed to create IPC log=
, continue...
[    0.264016] platform soc:qcom,msm-adsprpc-mem: assigned reserved memory =
node adsp_region
[    0.264898] msm_rpm_dev_probe: APSS-RPM communication over GLINK
[    0.279963] <CORE> glink_core_register_transport: unable to create log c=
ontext for [mpss:smem]
[    0.281123] <CORE> glink_core_register_transport: unable to create log c=
ontext for [lpass:smem]
[    0.282329] <CORE> glink_core_register_transport: unable to create log c=
ontext for [dsps:smem]
[    0.283274] <CORE> glink_core_register_transport: unable to create log c=
ontext for [rpm:smem]
[    0.283745] msm_rpm_trans_notify_state: glink config params: transport=
=3D(null), edge=3Drpm, name=3Drpm_requests
[    0.284289] <CORE> glink_core_register_transport: unable to create log c=
ontext for [spss:mailbox]
[    0.290541] platform 17300000.qcom,lpass: assigned reserved memory node =
pil_adsp_region@0x8b200000
[    0.291647] platform 4080000.qcom,mss: assigned reserved memory node mod=
em_region@8cc00000
[    0.295957] msm-thermal soc:qcom,msm-thermal: probe_psm:Failed reading n=
ode=3D/soc/qcom,msm-thermal, key=3Dqcom,pmic-sw-mode-temp. err=3D-22. KTM c=
ontinues
[    0.296098] msm_thermal:vdd_restriction_reg_init Defer regulator vdd-dig=
 probe
[    0.296118] msm_thermal:probe_vdd_rstr Err regulator init. err:-517. KTM=
 continues.
[    0.296144] msm-thermal soc:qcom,msm-thermal: probe_vdd_rstr:Failed read=
ing node=3D/soc/qcom,msm-thermal, key=3Dqcom,max-freq-level. err=3D-517. KT=
M continues
[    0.311390] platform 5c00000.qcom,ssc: assigned reserved memory node pil=
_slpi_region@94300000
[    0.312056] platform cce0000.qcom,venus: assigned reserved memory node p=
il_video_region@93c00000
[    0.312695] msm_watchdog 17817000.qcom,wdt: wdog absent resource not pre=
sent
[    0.313004] msm_watchdog 17817000.qcom,wdt: MSM Watchdog Initialized
[    0.313589] platform 1d0101c.qcom,spss: assigned reserved memory node sp=
ss_region@8ab00000
[    0.324414] msm_mpm_dev_probe(): Cannot get clk resource for XO: -517
[    0.360086] __of_mpm_init(): MPM driver mapping exists
[    0.371961] irq: no irq domain found for /soc/qcom,mdss_mdp@c900000 !
[    0.377816] i2c-msm-v2 c179000.i2c: probing driver i2c-msm-v2
[    0.378001] i2c-msm-v2 c179000.i2c: error on clk_get(core_clk):-517
[    0.378063] i2c-msm-v2 c179000.i2c: error probe() failed with err:-517
[    0.379148] i2c-msm-v2 c17a000.i2c: probing driver i2c-msm-v2
[    0.379302] i2c-msm-v2 c17a000.i2c: error on clk_get(core_clk):-517
[    0.379327] i2c-msm-v2 c17a000.i2c: error probe() failed with err:-517
[    0.380385] i2c-msm-v2 c1b5000.i2c: probing driver i2c-msm-v2
[    0.380537] i2c-msm-v2 c1b5000.i2c: error on clk_get(core_clk):-517
[    0.380561] i2c-msm-v2 c1b5000.i2c: error probe() failed with err:-517
[    0.381527] i2c-msm-v2 c1b6000.i2c: probing driver i2c-msm-v2
[    0.381678] i2c-msm-v2 c1b6000.i2c: error on clk_get(core_clk):-517
[    0.381702] i2c-msm-v2 c1b6000.i2c: error probe() failed with err:-517
[    0.383056] i2c-msm-v2 c1b7000.i2c: probing driver i2c-msm-v2
[    0.383211] i2c-msm-v2 c1b7000.i2c: error on clk_get(core_clk):-517
[    0.383235] i2c-msm-v2 c1b7000.i2c: error probe() failed with err:-517
[    0.392002] irq: no irq domain found for /soc/qcom,sde_kms@c900000 !
[    0.395705] platform soc:access_ramoops@0: assigned reserved memory node=
 ramoops_meta_region@affff000
[    0.396324] platform soc:access_ramoops@1: assigned reserved memory node=
 alt_ramoops_region@b0e00000
[    0.396927] platform soc:ramoops: assigned reserved memory node ramoops_=
region@b0000000
[    0.413844] console [pstore0] enabled
[    0.414117] pstore: Registered ramoops as persistent store backend
[    0.414314] ramoops: attached 0x200000@0xb0000000, ecc: 0/0
[    0.416668] bldr_log_init: can't find compatible 'htc,bldr_log'
[    0.434562] pm8998_l24: supplied by pm8998_l12
[    0.438038] msm-thermal soc:qcom,msm-thermal: probe_psm:Failed reading n=
ode=3D/soc/qcom,msm-thermal, key=3Dqcom,pmic-sw-mode-temp. err=3D-22. KTM c=
ontinues
[    0.438179] msm_thermal:vdd_restriction_reg_init Defer regulator vdd-gfx=
 probe
[    0.438186] msm_thermal:probe_vdd_rstr Err regulator init. err:-517. KTM=
 continues.
[    0.438194] msm-thermal soc:qcom,msm-thermal: probe_vdd_rstr:Failed read=
ing node=3D/soc/qcom,msm-thermal, key=3Dqcom,max-freq-level. err=3D-517. KT=
M continues
[    0.438609] msm_mpm_dev_probe(): Cannot get clk resource for XO: -517
[    0.439052] i2c-msm-v2 c179000.i2c: probing driver i2c-msm-v2
[    0.439105] i2c-msm-v2 c179000.i2c: error on clk_get(core_clk):-517
[    0.439115] i2c-msm-v2 c179000.i2c: error probe() failed with err:-517
[    0.439295] i2c-msm-v2 c17a000.i2c: probing driver i2c-msm-v2
[    0.439337] i2c-msm-v2 c17a000.i2c: error on clk_get(core_clk):-517
[    0.439345] i2c-msm-v2 c17a000.i2c: error probe() failed with err:-517
[    0.439532] i2c-msm-v2 c1b5000.i2c: probing driver i2c-msm-v2
[    0.439573] i2c-msm-v2 c1b5000.i2c: error on clk_get(core_clk):-517
[    0.439581] i2c-msm-v2 c1b5000.i2c: error probe() failed with err:-517
[    0.439736] i2c-msm-v2 c1b6000.i2c: probing driver i2c-msm-v2
[    0.439777] i2c-msm-v2 c1b6000.i2c: error on clk_get(core_clk):-517
[    0.439786] i2c-msm-v2 c1b6000.i2c: error probe() failed with err:-517
[    0.440052] i2c-msm-v2 c1b7000.i2c: probing driver i2c-msm-v2
[    0.440094] i2c-msm-v2 c1b7000.i2c: error on clk_get(core_clk):-517
[    0.440102] i2c-msm-v2 c1b7000.i2c: error probe() failed with err:-517
[    0.452632] branch_clk_handoff: gcc_mss_mnoc_bimc_axi_clk clock is enabl=
ed in HW even though ENABLE_BIT is not set
[    0.453126] qcom,gcc-8998 100000.qcom,gcc: Registered GCC clocks
[    0.462806] qcom,mmsscc-8998 c8c0000.qcom,mmsscc: Registered MMSS clocks.
[    0.464937] qcom,gpucc-8998 5065000.qcom,gpucc: Registered GPU clocks (b=
arring gfx3d clocks)
[    0.468075] msm-thermal soc:qcom,msm-thermal: probe_psm:Failed reading n=
ode=3D/soc/qcom,msm-thermal, key=3Dqcom,pmic-sw-mode-temp. err=3D-22. KTM c=
ontinues
[    0.468177] msm_thermal:vdd_restriction_reg_init Defer regulator vdd-gfx=
 probe
[    0.468183] msm_thermal:probe_vdd_rstr Err regulator init. err:-517. KTM=
 continues.
[    0.468191] msm-thermal soc:qcom,msm-thermal: probe_vdd_rstr:Failed read=
ing node=3D/soc/qcom,msm-thermal, key=3Dqcom,max-freq-level. err=3D-517. KT=
M continues
[    0.468426] cprh_kbss_read_fuse_data: apc0_pwrcl_corner: speed bin =3D 2
[    0.468435] cprh_msm8998_kbss_read_fuse_data: apc0_pwrcl_corner: CPR fus=
ing revision =3D 3
[    0.468551] cprh_kbss_calculate_open_loop_voltages: apc0_pwrcl_corner: f=
used   LowSVS: open-loop=3D 608000 uV
[    0.468558] cprh_kbss_calculate_open_loop_voltages: apc0_pwrcl_corner: f=
used      SVS: open-loop=3D 656000 uV
[    0.468564] cprh_kbss_calculate_open_loop_voltages: apc0_pwrcl_corner: f=
used      NOM: open-loop=3D 768000 uV
[    0.468572] cprh_kbss_calculate_open_loop_voltages: apc0_pwrcl_corner: f=
used TURBO_L1: open-loop=3D 876000 uV
[    0.468639] cprh_kbss_calculate_target_quotients: apc0_pwrcl_corner: fus=
ed   LowSVS: quot[11]=3D 604
[    0.468647] cprh_kbss_calculate_target_quotients: apc0_pwrcl_corner: fus=
ed      SVS: quot[11]=3D 722, quot_offset[11]=3D 115
[    0.468654] cprh_kbss_calculate_target_quotients: apc0_pwrcl_corner: fus=
ed      NOM: quot[11]=3D1036, quot_offset[11]=3D 310
[    0.468661] cprh_kbss_calculate_target_quotients: apc0_pwrcl_corner: fus=
ed TURBO_L1: quot[11]=3D1316, quot_offset[11]=3D 280
[    0.469926] cpr3_regulator_init_ctrl: apc0: Default CPR mode =3D full HW=
 closed-loop
[    0.470459] cprh_kbss_read_fuse_data: apc1_perfcl_corner: speed bin =3D 2
[    0.470468] cprh_msm8998_kbss_read_fuse_data: apc1_perfcl_corner: CPR fu=
sing revision =3D 3
[    0.470573] cprh_kbss_calculate_open_loop_voltages: apc1_perfcl_corner: =
fused   LowSVS: open-loop=3D 636000 uV
[    0.470580] cprh_kbss_calculate_open_loop_voltages: apc1_perfcl_corner: =
fused      SVS: open-loop=3D 636000 uV
[    0.470586] cprh_kbss_calculate_open_loop_voltages: apc1_perfcl_corner: =
fused      NOM: open-loop=3D 758000 uV
[    0.470593] cprh_kbss_calculate_open_loop_voltages: apc1_perfcl_corner: =
fused TURBO_L1: open-loop=3D 956000 uV
[    0.470609] cprh_kbss_calculate_open_loop_voltages: apc1_perfcl_corner: =
fuse corner 1 voltage=3D636000 uV < fuse corner 0 voltage=3D644000 uV; over=
riding: fuse corner 1 voltage=3D644000
[    0.470683] cprh_kbss_calculate_target_quotients: apc1_perfcl_corner: fu=
sed   LowSVS: quot[11]=3D1068
[    0.470691] cprh_kbss_calculate_target_quotients: apc1_perfcl_corner: fu=
sed      SVS: quot[11]=3D1068, quot_offset[11]=3D   0
[    0.470699] cprh_kbss_calculate_target_quotients: apc1_perfcl_corner: fu=
sed      NOM: quot[11]=3D1426, quot_offset[11]=3D 355
[    0.470706] cprh_kbss_calculate_target_quotients: apc1_perfcl_corner: fu=
sed TURBO_L1: quot[11]=3D1905, quot_offset[11]=3D 475
[    0.472309] cpr3_regulator_init_ctrl: apc1: Default CPR mode =3D full HW=
 closed-loop
[    0.472856] cpr3_msm8996_mmss_read_fuse_data: gfx_corner: CPR fusing rev=
ision =3D 2
[    0.472865] cpr3_msm8996_mmss_read_fuse_data: gfx_corner: CPR limitation=
 =3D none
[    0.473130] cpr3_msm8996_mmss_calculate_open_loop_voltages: gfx_corner: =
fuse_corner[0] open-loop=3D 596000 uV
[    0.473137] cpr3_msm8996_mmss_calculate_open_loop_voltages: gfx_corner: =
fuse_corner[1] open-loop=3D 658000 uV
[    0.473144] cpr3_msm8996_mmss_calculate_open_loop_voltages: gfx_corner: =
fuse_corner[2] open-loop=3D 782000 uV
[    0.473150] cpr3_msm8996_mmss_calculate_open_loop_voltages: gfx_corner: =
fuse_corner[3] open-loop=3D 934000 uV
[    0.473262] cpr3_regulator_init_ctrl: gfx: Default CPR mode =3D closed-l=
oop
[    0.474400] i2c-msm-v2 c179000.i2c: probing driver i2c-msm-v2
[    0.474462] AXI: msm_bus_scale_register_client(): msm_bus_scale_register=
_client: Bus driver not ready.
[    0.474468] i2c-msm-v2 c179000.i2c: msm_bus_scale_register_client(mstr-i=
d:86):0 (not a problem)
[    0.474827] AXI: msm_bus_scale_register_client(): msm_bus_scale_register=
_client: Bus driver not ready.
[    0.475146] i2c-msm-v2 c17a000.i2c: probing driver i2c-msm-v2
[    0.475201] AXI: msm_bus_scale_register_client(): msm_bus_scale_register=
_client: Bus driver not ready.
[    0.475207] i2c-msm-v2 c17a000.i2c: msm_bus_scale_register_client(mstr-i=
d:86):0 (not a problem)
[    0.475455] AXI: msm_bus_scale_register_client(): msm_bus_scale_register=
_client: Bus driver not ready.
[    0.475700] i2c-msm-v2 c1b5000.i2c: probing driver i2c-msm-v2
[    0.475756] AXI: msm_bus_scale_register_client(): msm_bus_scale_register=
_client: Bus driver not ready.
[    0.475763] i2c-msm-v2 c1b5000.i2c: msm_bus_scale_register_client(mstr-i=
d:84):0 (not a problem)
[    0.476003] AXI: msm_bus_scale_register_client(): msm_bus_scale_register=
_client: Bus driver not ready.
[    0.476344] i2c-msm-v2 c1b6000.i2c: probing driver i2c-msm-v2
[    0.476400] AXI: msm_bus_scale_register_client(): msm_bus_scale_register=
_client: Bus driver not ready.
[    0.476406] i2c-msm-v2 c1b6000.i2c: msm_bus_scale_register_client(mstr-i=
d:84):0 (not a problem)
[    0.476629] AXI: msm_bus_scale_register_client(): msm_bus_scale_register=
_client: Bus driver not ready.
[    0.476942] i2c-msm-v2 c1b7000.i2c: probing driver i2c-msm-v2
[    0.476997] AXI: msm_bus_scale_register_client(): msm_bus_scale_register=
_client: Bus driver not ready.
[    0.477003] i2c-msm-v2 c1b7000.i2c: msm_bus_scale_register_client(mstr-i=
d:84):0 (not a problem)
[    0.477327] AXI: msm_bus_scale_register_client(): msm_bus_scale_register=
_client: Bus driver not ready.
[    0.478044] gfx3d_clk_src: set OPP pair(257000000 Hz: 656000 uV) on 5000=
000.qcom,kgsl-3d0
[    0.478300] gfx3d_clk_src: set OPP pair(710000000 Hz: 904000 uV) on 5000=
000.qcom,kgsl-3d0
[    0.481398] qcom,gfxcc-8998 5065000.qcom,gfxcc: Completed registering al=
l GPU clocks
[    0.483777] cpu-clock-osm 179c0000.qcom,cpu-clock-8998: using pwrcl spee=
d bin 0 and pvs_ver 0
[    0.483803] cpu-clock-osm 179c0000.qcom,cpu-clock-8998: using perfcl spe=
ed bin 2 and pvs_ver 0
[    0.487129] add_opp: Set OPP pair (300000000 Hz, 644000 uv) on cpu0
[    0.488059] add_opp: Set OPP pair (1900800000 Hz, 880000 uv) on cpu0
[    0.488118] add_opp: Set OPP pair (300000000 Hz, 644000 uv) on cpu1
[    0.488993] add_opp: Set OPP pair (1900800000 Hz, 880000 uv) on cpu1
[    0.489069] add_opp: Set OPP pair (300000000 Hz, 644000 uv) on cpu2
[    0.489953] add_opp: Set OPP pair (1900800000 Hz, 880000 uv) on cpu2
[    0.490008] add_opp: Set OPP pair (300000000 Hz, 644000 uv) on cpu3
[    0.490889] add_opp: Set OPP pair (1900800000 Hz, 880000 uv) on cpu3
[    0.490955] add_opp: Set OPP pair (300000000 Hz, 640000 uv) on cpu4
[    0.492205] add_opp: Set OPP pair (2457600000 Hz, 980000 uv) on cpu4
[    0.492263] add_opp: Set OPP pair (300000000 Hz, 640000 uv) on cpu5
[    0.493502] add_opp: Set OPP pair (2457600000 Hz, 980000 uv) on cpu5
[    0.493557] add_opp: Set OPP pair (300000000 Hz, 640000 uv) on cpu6
[    0.494802] add_opp: Set OPP pair (2457600000 Hz, 980000 uv) on cpu6
[    0.494857] add_opp: Set OPP pair (300000000 Hz, 640000 uv) on cpu7
[    0.496110] add_opp: Set OPP pair (2457600000 Hz, 980000 uv) on cpu7
[    0.496553] cpu_clock_osm_driver_probe: OSM driver inited
[    0.496630] msm-thermal soc:qcom,msm-thermal: probe_psm:Failed reading n=
ode=3D/soc/qcom,msm-thermal, key=3Dqcom,pmic-sw-mode-temp. err=3D-22. KTM c=
ontinues
[    0.496785] msm-thermal soc:qcom,msm-thermal: probe_ocr:Failed reading n=
ode=3D/soc/qcom,msm-thermal, key=3Dqcom,pmic-opt-curr-temp err:-22. KTM con=
tinues
[    0.496795] msm-thermal soc:qcom,msm-thermal: probe_vdd_mx:Failed readin=
g node=3D/soc/qcom,msm-thermal, key=3Dqcom,mx-restriction-temp. KTM continu=
es
[    0.497067] msm-thermal soc:qcom,msm-thermal: probe_freq_mitigation:Fail=
ed reading node=3D/soc/qcom,msm-thermal, key=3Dqcom,limit-temp. err=3D-22. =
KTM continues
[    0.497078] msm-thermal soc:qcom,msm-thermal: msm_thermal:Failed reading=
 node=3D/soc/qcom,msm-thermal, key=3Dqcom,rpm-phase-resource-type err=3D-22=
=2E KTM continues
[    0.497087] msm-thermal soc:qcom,msm-thermal: msm_thermal:Failed reading=
 node=3D/soc/qcom,msm-thermal, key=3Dqcom,gfx-sensor-id. err=3D-22. KTM con=
tinues
[    0.504427] qcom,qpnp-pin 800f000.qcom,spmi:qcom,pm8005@4:gpios: qpnp_pi=
n_probe: no device nodes specified in topology
[    0.504437] qcom,qpnp-pin: probe of 800f000.qcom,spmi:qcom,pm8005@4:gpio=
s failed with error -22
[    0.505248] socinfo_print: v0.11, id=3D292, ver=3D2.1, raw_id=3D94, raw_=
ver=3D2, hw_plat=3D8, hw_plat_ver=3D10\x0a accessory_chip=3D0, hw_plat_subt=
ype=3D0, pmic_model=3D65556, pmic_die_revision=3D131072 foundry_id=3D3 seri=
al_number=3D4293049564 num_pmics=3D3
[    0.505258] msm_bus_fabric_init_driver
[    0.516594] msm_bus_dev_init_qos: Skipping QOS init for 1
[    0.516622] msm-bus-type fab-mnoc: Error: Failed to get regulator clk-ca=
mss-ahb-no-rate:-517
[    0.516639] msm-bus-type fab-mnoc: Error: Failed to get regulator clk-ca=
mss-ahb-no-rate:-517
[    0.516662] fab-mnoc supply clk-mdss-ahb-no-rate not found, using dummy =
regulator
[    0.516694] fab-mnoc supply clk-mdss-axi-no-rate not found, using dummy =
regulator
[    0.516726] msm-bus-type fab-mnoc: Error: Failed to get regulator clk-ca=
mss-ahb-no-rate:-517
[    0.516740] msm-bus-type fab-mnoc: Error: Failed to get regulator clk-ca=
mss-ahb-no-rate:-517
[    0.516753] msm-bus-type fab-mnoc: Error: Failed to get regulator clk-ca=
mss-ahb-no-rate:-517
[    0.516765] msm-bus-type fab-mnoc: Error: Failed to get regulator clk-ca=
mss-ahb-no-rate:-517
[    0.516777] msm-bus-type fab-mnoc: Error: Failed to get regulator clk-ca=
mss-ahb-no-rate:-517
[    0.516788] msm_bus_dev_init_qos: Skipping QOS init for 727
[    0.517977] SCSI subsystem initialized
[    0.518186] usbcore: registered new interface driver usbfs
[    0.518209] usbcore: registered new interface driver hub
[    0.518276] usbcore: registered new device driver usb
[    0.518377] soc:usb_nop_phy supply vcc not found, using dummy regulator
[    0.518605] qcom,qpnp-power-on 800f000.qcom,spmi:qcom,pm8998@0:qcom,powe=
r-on@800: PMIC@SID0 Power-on reason: Triggered from Hard Reset and 'cold' b=
oot
[    0.518628] qcom,qpnp-power-on 800f000.qcom,spmi:qcom,pm8998@0:qcom,powe=
r-on@800: PMIC@SID0: Power-off reason: Triggered from PS_HOLD (PS_HOLD/MSM =
controlled shutdown)
[    0.518777] input: qpnp_pon as /devices/virtual/input/input0
[    0.519264] qcom,qpnp-power-on 800f000.qcom,spmi:qcom,pm8998@0:qcom,powe=
r-on@800: qcom,report-key:true
[    0.519292] qcom,qpnp-power-on 800f000.qcom,spmi:qcom,pmi8998@2:qcom,pow=
er-on@800: No PON config. specified
[    0.519334] qcom,qpnp-power-on 800f000.qcom,spmi:qcom,pmi8998@2:qcom,pow=
er-on@800: PMIC@SID2 Power-on reason: Triggered from PON1 (secondary PMIC) =
and 'cold' boot
[    0.519357] qcom,qpnp-power-on 800f000.qcom,spmi:qcom,pmi8998@2:qcom,pow=
er-on@800: PMIC@SID2: Power-off reason: Triggered from GP1 (Keypad_Reset1)
[    0.519389] qcom,qpnp-power-on 800f000.qcom,spmi:qcom,pmi8998@2:qcom,pow=
er-on@800: qcom,report-key:false
[    0.519540] media: Linux media interface: v0.10
[    0.519561] Linux video capture interface: v2.00
[    0.519587] EDAC MC: Ver: 3.0.0
[    0.520177] cpufreq: driver msm up and running
[    0.520528] platform soc:qcom,ion:qcom,ion-heap@22: assigned reserved me=
mory node adsp_region
[    0.520661] platform soc:qcom,ion:qcom,ion-heap@27: assigned reserved me=
mory node qseecom_region
[    0.520781] platform soc:qcom,ion:qcom,ion-heap@13: assigned reserved me=
mory node sp_region
[    0.520903] platform soc:qcom,ion:qcom,ion-heap@10: assigned reserved me=
mory node secure_region
[    0.521179] ION heap system created
[    0.521250] ION heap adsp created at 0x0000000000000000 with size 800000
[    0.521255] ION heap qsecom created at 0x0000000000000000 with size 1400=
000
[    0.521261] ION heap spss created at 0x0000000000000000 with size 800000
[    0.521266] ION heap secure_display created at 0x0000000000000000 with s=
ize 5c00000
[    0.521274] ION heap secure_heap created
[    0.545027] ION heap easel_mem created at 0x0000000000000000 with size 4=
000000
[    0.545462] PMIC@SID0: PM8998 v2.0 options: 0, 0, 0, 0
[    0.545547] PMIC@SID2: PMI8998 v2.1 options: 0, 0, 0, 0
[    0.545627] PMIC@SID4: PM8005 v2.0 options: 0, 0, 0, 0
[    0.546243] ipa ipa_smmu_wlan_cb_probe:5136 could not alloc iommu domain
[    0.546320] IPA smmu_info.s1_bypass=3D1 smmu_info.fast_map=3D0
[    0.546608] ipa ipa_smmu_wlan_cb_probe:5136 could not alloc iommu domain
[    0.547778] gdsc_vfe0: supplied by gdsc_camss_top
[    0.547868] gdsc_vfe1: supplied by gdsc_camss_top
[    0.547960] gdsc_cpp: supplied by gdsc_camss_top
[    0.548259] gdsc_gpu_gx: supplied by gfx_corner
[    0.548773] mdss_pll_probe: MDSS pll label =3D MDSS DSI 0 PLL
[    0.548778] mdss_pll_probe: mdss_pll_probe: label=3DMDSS DSI 0 PLL PLL S=
SC enabled
[    0.561291] dp_pll_lock_status: dp_pll_lock_status: C_READY status is no=
t high. Status=3D0
[    0.562273] mdss_pll_probe: MDSS pll label =3D MDSS DSI 1 PLL
[    0.562283] mdss_pll_probe: mdss_pll_probe: label=3DMDSS DSI 1 PLL PLL S=
SC enabled
[    0.564755] mdss_pll_probe: MDSS pll label =3D MDSS DP PLL
[    0.565811] mdss_pll_probe: MDSS pll label =3D MDSS HDMI PLL
[    0.583452] arm-smmu cd00000.arm,smmu-mmss: found 20 context interrupt(s=
) but have 17 context banks. assuming 17 context interrupts.
[    0.588653] iommu: Adding device soc:usb_audio_qmi_dev to group 0
[    0.588748] iommu: Adding device 1c00000.qcom,pcie to group 1
[    0.588827] iommu: Adding device 18800000.qcom,icnss to group 2
[    0.588950] iommu: Adding device soc:iommu_test_device to group 3
[    0.589448] iommu: Adding device soc:qcom,msm-audio-ion to group 4
[    0.589674] iommu: Adding device c900000.qcom,sde_kms to group 5
[    0.590063] iommu: Adding device 1e00000.qcom,ipa:ipa_smmu_ap to group 6
[    0.590078] iommu: Adding device 1e00000.qcom,ipa:ipa_smmu_wlan to group=
 7
[    0.590090] iommu: Adding device 1e00000.qcom,ipa:ipa_smmu_uc to group 8
[    0.590523] dev-cpufreq: No tables parsed from DT.
[    0.590582] Advanced Linux Sound Architecture Driver Initialized.
[    0.590817] Bluetooth: 0000000000000000
[    0.590829] NET: Registered protocol family 31
[    0.590833] Bluetooth: 0000000000000000
[    0.590838] Bluetooth: 0000000000000000
[    0.590844] Bluetooth: 0000000000000000
[    0.590855] Bluetooth: 0000000000000000
[    0.590969] cfg80211: World regulatory domain updated:
[    0.590973] cfg80211:  DFS Master region: unset
[    0.590976] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenn=
a_gain, max_eirp), (dfs_cac_time)
[    0.590981] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (N/A, 2=
000 mBm), (N/A)
[    0.590985] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (N/A, 2=
000 mBm), (N/A)
[    0.590988] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (N/A, 2=
000 mBm), (N/A)
[    0.590992] cfg80211:   (5170000 KHz - 5250000 KHz @ 80000 KHz), (N/A, 2=
000 mBm), (N/A)
[    0.590995] cfg80211:   (5250000 KHz - 5330000 KHz @ 80000 KHz), (N/A, 2=
000 mBm), (N/A)
[    0.590998] cfg80211:   (5490000 KHz - 5710000 KHz @ 80000 KHz), (N/A, 2=
000 mBm), (N/A)
[    0.591001] cfg80211:   (5735000 KHz - 5835000 KHz @ 80000 KHz), (N/A, 2=
000 mBm), (N/A)
[    0.591004] cfg80211:   (57240000 KHz - 63720000 KHz @ 2160000 KHz), (N/=
A, 0 mBm), (N/A)
[    0.591110] pcie:pcie_init.
[    0.591115] pcie_init: unable to create IPC log context for pcie0-short
[    0.591119] pcie_init: unable to create IPC log context for pcie0-long
[    0.591122] pcie_init: unable to create IPC log context for pcie0-dump
[    0.591125] pcie_init: unable to create IPC log context for pcie1-short
[    0.591128] pcie_init: unable to create IPC log context for pcie1-long
[    0.591131] pcie_init: unable to create IPC log context for pcie1-dump
[    0.591134] pcie_init: unable to create IPC log context for pcie2-short
[    0.591138] pcie_init: unable to create IPC log context for pcie2-long
[    0.591140] pcie_init: unable to create IPC log context for pcie2-dump
[    0.591492] 1c00000.qcom,pcie supply vreg-3.3 not found, using dummy reg=
ulator
[    0.591585] 1c00000.qcom,pcie supply gdsc-smmu not found, using dummy re=
gulator
[    0.591958] msm_pcie_get_resources: PCIe: RC0 can't get tcsr resource.
[    0.591980] msm_pcie_probe: PCIe: RC0 could not get pinctrl sleep state
[    0.593579] qpnp_labibb_regulator_probe: LAB/IBB registered successfully=
, lab_vreg enable=3D0 ibb_vreg enable=3D0 swire_control=3D0
[    0.595843] ipa ipa3_pre_init:4315 failed to create IPC log, continue...
[    0.596220] ipa ipa3_uc_state_check:302 uC interface not initialized
[    0.598036] ipa ipa3_set_resorce_groups_min_max_limits:3412 skip configu=
ring ipa_rx_hps_clients from HLOS
[    0.598738] ipa ipa3_uc_state_check:302 uC interface not initialized
[    0.600715] clocksource: Switched to clocksource arch_sys_counter
[    0.602862] NET: Registered protocol family 2
[    0.603264] TCP established hash table entries: 32768 (order: 6, 262144 =
bytes)
[    0.603451] TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
[    0.603537] TCP: Hash tables configured (established 32768 bind 32768)
[    0.603609] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    0.603646] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
[    0.603760] NET: Registered protocol family 1
[    0.603784] PCI: CLS 0 bytes, default 64
[    0.604150] Trying to unpack rootfs image as initramfs...
[    0.724914] Freeing initrd memory: 9916K
[    0.725764] hw perfevents: enabled with armv8_pmuv3 PMU driver, 7 counte=
rs available
[    0.729339] audit: initializing netlink subsys (disabled)
[    0.729402] audit: type=3D2000 audit(0.728:1): initialized
[    0.729532] Initialise system trusted keyring
[    0.729629] vmscan: error setting kswapd cpu affinity mask
[    0.732757] VFS: Disk quotas dquot_6.6.0
[    0.732820] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.733326] Registering sdcardfs 0.1
[    0.733467] fuse init (API version 7.23)
[    0.733570] SELinux:  Registering netfilter hooks
[    0.733832] pfk_ecryptfs [pfk_ecryptfs_init]: PFK ecryptfs inited succes=
sfully
[    0.733838] pfk_ext4 [pfk_ext4_init]: PFK EXT4 inited successfully
[    0.733843] pfk [pfk_init]: Driver initialized successfully
[    0.737114] Key type asymmetric registered
[    0.737122] Asymmetric key parser 'x509' registered
[    0.737134] io scheduler noop registered
[    0.737197] io scheduler cfq registered (default)
[    0.737203] io scheduler test-iosched registered
[    0.737207] io scheduler maple registered
[    0.739803] msm_dss_get_res_byname: 'vbif_nrt_phys' resource not found
[    0.739816] mdss_mdp_probe+0x1e8/0x14e0->msm_dss_ioremap_byname: 'vbif_n=
rt_phys' msm_dss_get_res_byname failed
[    0.740716] No change in context(0=3D=3D0), skip
[    0.742097] mdss_mdp_pipe_addr_setup: type:0 ftchid:-1 xinid:0 num:0 rec=
t:0 ndx:0x1 prio:0
[    0.742104] mdss_mdp_pipe_addr_setup: type:0 ftchid:-1 xinid:4 num:1 rec=
t:0 ndx:0x2 prio:1
[    0.742109] mdss_mdp_pipe_addr_setup: type:0 ftchid:-1 xinid:8 num:2 rec=
t:0 ndx:0x4 prio:2
[    0.742115] mdss_mdp_pipe_addr_setup: type:0 ftchid:-1 xinid:12 num:8 re=
ct:0 ndx:0x100 prio:3
[    0.742155] mdss_mdp_pipe_addr_setup: type:2 ftchid:-1 xinid:1 num:6 rec=
t:0 ndx:0x40 prio:4
[    0.742162] mdss_mdp_pipe_addr_setup: type:2 ftchid:-1 xinid:1 num:6 rec=
t:1 ndx:0x40 prio:4
[    0.742169] mdss_mdp_pipe_addr_setup: type:2 ftchid:-1 xinid:5 num:7 rec=
t:0 ndx:0x80 prio:5
[    0.742175] mdss_mdp_pipe_addr_setup: type:2 ftchid:-1 xinid:5 num:7 rec=
t:1 ndx:0x80 prio:5
[    0.742181] mdss_mdp_pipe_addr_setup: type:2 ftchid:-1 xinid:9 num:12 re=
ct:0 ndx:0x1000 prio:6
[    0.742187] mdss_mdp_pipe_addr_setup: type:2 ftchid:-1 xinid:9 num:12 re=
ct:1 ndx:0x1000 prio:6
[    0.742192] mdss_mdp_pipe_addr_setup: type:2 ftchid:-1 xinid:13 num:13 r=
ect:0 ndx:0x2000 prio:7
[    0.742198] mdss_mdp_pipe_addr_setup: type:2 ftchid:-1 xinid:13 num:13 r=
ect:1 ndx:0x2000 prio:7
[    0.742217] mdss_mdp_pipe_addr_setup: type:3 ftchid:-1 xinid:2 num:10 re=
ct:0 ndx:0x400 prio:0
[    0.742223] mdss_mdp_pipe_addr_setup: type:3 ftchid:-1 xinid:10 num:11 r=
ect:0 ndx:0x800 prio:1
[    0.742232] mdss_mdp_parse_dt_handler: Error from prop qcom,mdss-pipe-sw=
-reset-off : u32 array read
[    0.742284] mdss_mdp_parse_dt_handler: Error from prop qcom,mdss-ib-fact=
or-overlap : u32 array read
[    0.742701] xlog_status: enable:0, panic:1, dump:2
[    0.743111] iommu: Adding device c900000.qcom,mdss_mdp:qcom,smmu_mdp_uns=
ec_cb to group 9
[    0.743342] iommu: Adding device c900000.qcom,mdss_mdp:qcom,smmu_mdp_sec=
_cb to group 10
[    0.743476] mdss_mdp_probe: mdss version =3D 0x30000001, bootloader disp=
lay is on, num 1, intf_sel=3D0x00000100
[    0.744466] mdss_smmu_probe: iommu v2 domain[0] mapping and clk register=
 successful!
[    0.744617] mdss_smmu_probe: iommu v2 domain[2] mapping and clk register=
 successful!
[    0.746172] mdss_dsi_ctrl_probe: DSI Ctrl name =3D MDSS DSI CTRL->0
[    0.746423] mdss_dsi_find_panel_of_node: cmdline:0:qcom,mdss_dsi_sw43402=
_dsc_qhd_cmd:1:none:cfg:single_dsi panel_name:qcom,mdss_dsi_sw43402_dsc_qhd=
_cmd
[    0.746647] mdss_dsi_panel_init: Panel Name =3D SW43402 cmd mode dsc dsi=
 panel
[    0.746727] mdss_dsi_panel_timing_from_dt: found new timing "qcom,mdss_d=
si_sw43402_dsc_qhd_cmd" (0000000000000000)
[    0.746746] mdss_dsi_panel_get_dsc_cfg_np: cannot find dsc config node:
[    0.746799] mdss_dsi_parse_topology_config: cfg_node name config0 lm_spl=
it:720x720 pp_split:no
[    0.746870] mdss_dsi_parse_partial_update_caps: partial_update_enabled=
=3D0
[    0.746877] mdss_dsi_parse_panel_features: ulps feature enabled
[    0.746885] mdss_dsi_parse_panel_features: ulps during suspend feature d=
isabled
[    0.746892] mdss_dsi_parse_dms_config: dynamic switch feature enabled: 0
[    0.746941] mdss_dsi_set_refresh_rate_range:2624, Unable to read min ref=
resh rate
[    0.746949] mdss_dsi_set_refresh_rate_range:2639, Unable to read max ref=
resh rate
[    0.746953] dyn_fps: min =3D 60, max =3D 60
[    0.747139] c994000.qcom,mdss_dsi_ctrl0 supply wqhd-vddio not found, usi=
ng dummy regulator
[    0.747199] mdss_dsi_parse_ctrl_params:4435 Unable to read qcom,display-=
id, data=3D0000000000000000,len=3D20
[    0.747233] mdss_dsi_parse_gpio_params:4473: ERR_FG gpio not specified
[    0.747257] mdss_dsi_parse_gpio_params: bklt_en gpio not specified
[    0.747317] mdss_dsi_parse_gpio_params: lcd vcl gpio not specified
[    0.747405] msm_dss_get_res_byname: 'dsi_phy_regulator' resource not fou=
nd
[    0.747424] mdss_dsi_retrieve_ctrl_resources+0xc4/0x230->msm_dss_ioremap=
_byname: 'dsi_phy_regulator' msm_dss_get_res_byname failed
[    0.747432] mdss_dsi_retrieve_ctrl_resources: ctrl_base=3D00000000000000=
00 ctrl_size=3D400 phy_base=3D0000000000000000 phy_size=3D7c0
[    0.747599] dsi_panel_device_register: Continuous splash enabled
[    0.747662] Unable to find fb node for device: c994000.qcom,mdss_dsi_ctr=
l0
[    0.747795] mdss_register_panel: adding framebuffer device c994000.qcom,=
mdss_dsi_ctrl0
[    0.754536] request disp ERR_DETECT irq
[    0.754706] mdss_dsi_ctrl_probe: Dsi Ctrl->0 initialized, DSI rev:0x2000=
0000, PHY rev:0x3
[    0.754838] mdss_dsi_status_init: DSI status check interval:3000
[    0.755579] mdss_register_panel: adding framebuffer device soc:qcom,mdss=
_wb_panel
[    0.755919] mdss_fb_probe: fb0: split_mode:1 left:720 right:720
[    0.756248] mdss_fb_register: FrameBuffer[0] 1440x2880 registered succes=
sfully!
[    0.756873] mdss_mdp_splash_parse_dt: mem reservation for splash screen =
fb not present
[    0.756880] mdss_mdp_splash_parse_dt: no rsvd mem found in DT for splash=
 screen
[    0.756885] mdss_mdp_splash_init: splash memory reserve failed
[    0.756923] mdss_fb_probe: fb1: split_mode:0 left:0 right:0
[    0.756971] mdss_fb_register: FrameBuffer[1] 640x480 registered successf=
ully!
[    0.757140] mdss_mdp_splash_parse_dt: splash mem child node is not prese=
nt
[    0.757891] glink_loopback_server_init: unable to create log context
[    0.758483] msm_smp2p_init: unable to create log context
[    0.759028] qmi_log_init: Unable to create QMI IPC logging for Req/Resp
[    0.759034] logging for Indications: Unable to create QMI IPC qmi_log_in=
it
[    0.759808] spcom [spcom_init]: spcom driver Ver 1.0 23-Nov-2015.
[    0.759959] spcom [spcom_probe]: Driver Initialization ok.
[    0.760185] apr_init: Unable to create ipc log context
[    0.760198] audio_notifer_reg_service: service SSR_MODEM is in use
[    0.765261] memshare_child soc:qcom,memshare:qcom,client_1: for memshare=
_GPS segments only will be dumped.
[    0.765504] memshare_child soc:qcom,memshare:qcom,client_2: for memshare=
_FTM segments only will be dumped.
[    0.765603] memshare_child soc:qcom,memshare:qcom,client_3: for memshare=
_DIAG segments only will be dumped.
[    0.765635] In memshare_probe, Memshare probe success
[    0.766215] subsys-pil-tz soc:qcom,ipa_fws@1e08000: for ipa_fws segments=
 only will be dumped.
[    0.767027] subsys-pil-tz cce0000.qcom,venus: for venus segments only wi=
ll be dumped.
[    0.767213] subsys-pil-tz 1d0101c.qcom,spss: for spss segments only will=
 be dumped.
[    0.767459] subsys-pil-tz soc:qcom,kgsl-hyp: for a540_zap segments only =
will be dumped.
[    0.768156] pil-q6v5-mss 4080000.qcom,mss: No pas_id found.
[    0.768710] icnss: Unable to create log context
[    0.768715] icnss: Unable to create log long context
[    0.771250] icnss 18800000.qcom,icnss: for wcss_msa0 segments only will =
be dumped.
[    0.771382] icnss: Platform driver probed successfully
[    0.771955] qiib_driver_data_init: unable to create logging context
[    0.773728] uart_tx_gpio is not available
[    0.773735] uart_rx_gpio is not available
[    0.773740] uart_cts_gpio is not available
[    0.773744] uart_rfr_gpio is not available
[    0.774187] msm_serial_hs c171000.uart: msm_hs_probe: error creating log=
ging context
[    0.774496] sps: BAM device 0x0000000000000000 is not registered yet.
[    0.774510] sps_register_bam_device : unable to create IPC Logging 0 for=
 bam 0x0000000000000000
[    0.774516] sps_register_bam_device : unable to create IPC Logging 1 for=
 bam 0x0000000000000000
[    0.774523] sps_register_bam_device : unable to create IPC Logging 2 for=
 bam 0x0000000000000000
[    0.774528] sps_register_bam_device : unable to create IPC Logging 3 for=
 bam 0x0000000000000000
[    0.774535] sps_register_bam_device : unable to create IPC Logging 4 for=
 bam 0x0000000000000000
[    0.774540] sps:BAM 0x0000000000000000 is registered.
[    0.774672] msm_serial_hs c171000.uart: msm_hs_probe: error creating tx =
logging context
[    0.774679] msm_serial_hs c171000.uart: msm_hs_probe: error creating rx =
logging context
[    0.774685] msm_serial_hs c171000.uart: msm_hs_probe: error creating usr=
 logging context
[    0.775777] c171000.uart: ttyHS0 at MMIO 0xc171000 (irq =3D 361, base_ba=
ud =3D 460800) is a MSM HS UART
[    0.776573] msm_serial_hs module loaded
[    0.776588] smd_tty_log_init: Unable to create IPC log
[    0.777659] random: nonblocking pool is initialized
[    0.777759] diag: Failed to create IPC logging context
[    0.789961] iommu: Adding device 5040000.qcom,kgsl-iommu:gfx3d_user to g=
roup 11
[    0.790278] iommu: Adding device 5040000.qcom,kgsl-iommu:gfx3d_secure to=
 group 12
[    0.816749] Boeffla WL blocker: driver version 1.1.0 started
[    0.821981] brd: module loaded
[    0.824768] loop: module loaded
[    0.825086] zram: Added device: zram0
[    0.826099] QSEECOM: qseecom_probe: qseecom.qsee_version =3D 0x1001000
[    0.826131] QSEECOM: qseecom_retrieve_ce_data: Device does not support P=
FE
[    0.826142] QSEECOM: qseecom_probe: no-clock-support=3D0x1
[    0.826152] QSEECOM: qseecom_probe: qseecom.qsee_reentrancy_support =3D 2
[    0.826482] QSEECOM: qseecom_probe: qseecom.whitelist_support =3D 1
[    0.829445] thermal thermal_zone0: failed to read out thermal zone (-5)
[    0.829633] thermal thermal_zone1: failed to read out thermal zone (-5)
[    0.829809] thermal thermal_zone2: failed to read out thermal zone (-5)
[    0.830031] thermal thermal_zone3: failed to read out thermal zone (-5)
[    0.830041] mnh_thermal soc:mnh_thermal: mnh_thermal_probe: initialized
[    0.830226] misc easelcomm-client: registered at misc device minor 59
[    0.831153] fpc1020 soc:fp_fpc1020: found pin control fpc1020_reset_reset
[    0.831163] fpc1020 soc:fp_fpc1020: found pin control fpc1020_reset_acti=
ve
[    0.831170] fpc1020 soc:fp_fpc1020: found pin control fpc1020_irq_active
[    0.831207] fpc1020 soc:fp_fpc1020: Selected 'fpc1020_reset_reset'
[    0.831229] fpc1020 soc:fp_fpc1020: Selected 'fpc1020_irq_active'
[    0.831497] fpc1020 soc:fp_fpc1020: Selected 'fpc1020_reset_active'
[    0.831744] fpc1020 soc:fp_fpc1020: Selected 'fpc1020_reset_reset'
[    0.836912] fpc1020 soc:fp_fpc1020: Selected 'fpc1020_reset_active'
[    0.842041] fpc1020 soc:fp_fpc1020: IRQ after reset 1
[    0.842048] fpc1020 soc:fp_fpc1020: fpc1020_probe: ok
[    0.842127] fpc1020_init OK
[    0.842882] misc access-metadata: registered 'metadata' 10:58, (1000@0x0=
000000000000000)
[    0.842977] misc access-ramoops: registered 'ramoops' 10:57, (200000@0x0=
000000000000000)
[    0.843451] i2c-msm-v2 c1b5000.i2c: msm_bus_scale_register_client(mstr-i=
d:84):0xe (ok)
[    0.846498] prom_parse: Bad cell count for /soc/i2c@c1b5000/qcom,smb138x=
@8
[    0.846511] prom_parse: Bad cell count for /soc/i2c@c1b5000/qcom,smb138x=
@8
[    0.848637] PMIC@SID0: (null) v2.1 options: 0, 0, 0, 0
[    0.848658] prom_parse: Bad cell count for /soc/i2c@c1b5000/qcom,smb138x=
@8
[    0.848832] prom_parse: Bad cell count for /soc/i2c@c1b5000/qcom,smb138x=
@8
[    0.849040] prom_parse: Bad cell count for /soc/i2c@c1b5000/qcom,smb138x=
@8
[    0.849049] prom_parse: Bad cell count for /soc/i2c@c1b5000/qcom,smb138x=
@8
[    0.849129] I2C PMIC: i2c_pmic_probe: I2C PMIC probe successful
[    0.850291] nq-nci 8-0028: nqx_probe: probing NFCC NQxxx exited successf=
ully
[    0.851534] qce 1de0000.qcedev: Qualcomm Crypto 5.3.4 device found @0x1d=
e0000
[    0.851543] qce 1de0000.qcedev: CE device =3D 0x0\x0aIO base, CE =3D 0x0=
000000000000000\x0aConsumer (IN) PIPE 2,    Producer (OUT) PIPE 3\x0aIO bas=
e BAM =3D 0x0000000000000000\x0aBAM IRQ 62\x0aEngines Availability =3D 0x20=
11053
[    0.851587] sps_register_bam_device : unable to create IPC Logging 0 for=
 bam 0x0000000000000000
[    0.851595] sps_register_bam_device : unable to create IPC Logging 1 for=
 bam 0x0000000000000000
[    0.851604] sps_register_bam_device : unable to create IPC Logging 2 for=
 bam 0x0000000000000000
[    0.851610] sps_register_bam_device : unable to create IPC Logging 3 for=
 bam 0x0000000000000000
[    0.851618] sps_register_bam_device : unable to create IPC Logging 4 for=
 bam 0x0000000000000000
[    0.851623] sps:BAM 0x0000000000000000 is registered.
[    0.851832] sps:BAM 0x0000000000000000 (va:0x0000000000000000) enabled: =
ver:0x27, number of pipes:16
[    0.852209] QCE50: qce_sps_init:  Qualcomm MSM CE-BAM at 0x0000000001dc4=
000 irq 62
[    0.865850] qcrypto 1de0000.qcrypto: Qualcomm Crypto 5.3.4 device found =
@0x1de0000
[    0.865861] qcrypto 1de0000.qcrypto: CE device =3D 0x0\x0aIO base, CE =
=3D 0x0000000000000000\x0aConsumer (IN) PIPE 4,    Producer (OUT) PIPE 5\x0=
aIO base BAM =3D 0x0000000000000000\x0aBAM IRQ 62\x0aEngines Availability =
=3D 0x2011053
[    0.866367] QCE50: qce_sps_init:  Qualcomm MSM CE-BAM at 0x0000000001dc4=
000 irq 62
[    0.876988] qcrypto 1de0000.qcrypto: qcrypto-ecb-aes
[    0.877215] qcrypto 1de0000.qcrypto: qcrypto-cbc-aes
[    0.877346] qcrypto 1de0000.qcrypto: qcrypto-ctr-aes
[    0.877474] qcrypto 1de0000.qcrypto: qcrypto-ecb-des
[    0.877600] qcrypto 1de0000.qcrypto: qcrypto-cbc-des
[    0.877728] qcrypto 1de0000.qcrypto: qcrypto-ecb-3des
[    0.877899] qcrypto 1de0000.qcrypto: qcrypto-cbc-3des
[    0.878034] qcrypto 1de0000.qcrypto: qcrypto-xts-aes
[    0.878184] qcrypto 1de0000.qcrypto: qcrypto-sha1
[    0.878308] qcrypto 1de0000.qcrypto: qcrypto-sha256
[    0.878432] qcrypto 1de0000.qcrypto: qcrypto-aead-hmac-sha1-cbc-aes
[    0.878554] qcrypto 1de0000.qcrypto: qcrypto-aead-hmac-sha1-cbc-des
[    0.878684] qcrypto 1de0000.qcrypto: qcrypto-aead-hmac-sha1-cbc-3des
[    0.878811] qcrypto 1de0000.qcrypto: qcrypto-aead-hmac-sha256-cbc-aes
[    0.878937] qcrypto 1de0000.qcrypto: qcrypto-aead-hmac-sha256-cbc-des
[    0.879059] qcrypto 1de0000.qcrypto: qcrypto-aead-hmac-sha256-cbc-3des
[    0.879226] qcrypto 1de0000.qcrypto: qcrypto-hmac-sha1
[    0.879349] qcrypto 1de0000.qcrypto: qcrypto-hmac-sha256
[    0.879471] qcrypto 1de0000.qcrypto: qcrypto-aes-ccm
[    0.879592] qcrypto 1de0000.qcrypto: qcrypto-rfc4309-aes-ccm
[    0.882765] qcom_ice_get_pdevice: found ice device 0000000000000000
[    0.882777] qcom_ice_get_pdevice: matching platform device 0000000000000=
000
[    0.883447] scm_call failed: func id 0x42000c02, ret: -2, syscall return=
s: 0xfffffffffffffffc, 0x0, 0x0
[    0.883682] ufshcd-qcom 1da4000.ufshc: ufs_qcom_parse_reg_info: Unable t=
o find qcom,vddp-ref-clk-supply regulator, assuming enabled
[    0.884719] scsi host0: ufshcd
[    0.889426] qcom_ice 1db0000.ufsice: QC ICE 3.0.65 device found @0x00000=
00000000000
[    0.893756] pn81a spi1.0: pn81a_probe: device tree set '8-0028' as eSE p=
ower controller
[    0.893801] pn81a spi1.0: pn81a_probe: eSE is configured
[    0.894841] sps: BAM device 0x0000000000000000 is not registered yet.
[    0.894853] sps_register_bam_device : unable to create IPC Logging 0 for=
 bam 0x0000000000000000
[    0.894860] sps_register_bam_device : unable to create IPC Logging 1 for=
 bam 0x0000000000000000
[    0.894869] sps_register_bam_device : unable to create IPC Logging 2 for=
 bam 0x0000000000000000
[    0.894875] sps_register_bam_device : unable to create IPC Logging 3 for=
 bam 0x0000000000000000
[    0.894884] sps_register_bam_device : unable to create IPC Logging 4 for=
 bam 0x0000000000000000
[    0.894890] sps:BAM 0x0000000000000000 is registered.
[    0.895507] sps:BAM 0x0000000000000000 (va:0x0000000000000000) enabled: =
ver:0x19, number of pipes:18
[    0.896158] Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)
[    0.897158] tun: Universal TUN/TAP device driver, 1.6
[    0.897166] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    0.897217] PPP generic driver version 2.4.2
[    0.897271] PPP BSD Compression module registered
[    0.897280] PPP Deflate Compression module registered
[    0.897305] PPP MPPE Compression module registered
[    0.897314] NET: Registered protocol family 24
[    0.898122] CLD80211: Initializing
[    0.898819] msm_sharedmem: sharedmem_register_qmi: qmi init successful
[    0.906714] msm_sharedmem: msm_sharedmem_probe: Device created for clien=
t 'rmtfs'
[    0.908242] ufshcd-qcom 1da4000.ufshc: ufshcd_print_pwr_info:[RX, TX]: g=
ear=3D[1, 1], lane[1, 1], pwr[SLOWAUTO_MODE, SLOWAUTO_MODE], rate =3D 0
[    0.909159] branch_clk_set_rate: Cannot scale gcc_rx1_usb2_clkref_clk cl=
ock while HW gating is enabled. Use corresponding hw_ctl_clk to scale it
[    0.910707] msm-dwc3 a800000.ssusb: unable to get dbm device
[    0.911542] usbcore: registered new interface driver usb-storage
[    0.913534] qpnp-pdphy 800f000.qcom,spmi:qcom,pmi8998@2:qcom,usb-pdphy@1=
700: usbpd_create failed: -517
[    0.914487] [Touch] touch_get_device_type =3D [1]
[    0.914494] [Touch] touch_device_init, sw49408 start
[    0.914918] fts_touch 5-0049: Failed to get tspid gpio
[    0.914927] fts_touch 5-0049: Failed to get tspid2 gpio
[    0.914982] fts_touch 5-0049: irq_gpio =3D 125
[    0.914994] fts_touch 5-0049: client->irq =3D 499
[    0.915000] fts_touch 5-0049: Failed to get grip_area property
[    0.915008] fts_touch 5-0049: Failed to get vdd_gpio gpio
[    0.915026] fts_touch 5-0049: Failed to get vio_gpio gpio
[    0.915205] input: s2w_pwrkey as /devices/virtual/input/input1
[    0.915224] fts_touch 5-0049: FTS Support Hover Event
[    0.915256] fts_touch 5-0049: switch_gpio =3D 75
[    0.915322] fts_touch 5-0049: fts_power_ctrl: on
[    0.915685] input: wake_gesture as /devices/virtual/input/input2
[    0.915753] drv2624 6-005a: drv2624_i2c_probe enter
[    0.915871] drv2624 6-005a: Looking up ti,irq-gpio property in node /soc=
/i2c@c17a000/drv2624@5a failed -2
[    0.919951] drv2624 6-005a: drv2624_i2c_probe, ID status (0x3)
[    0.920257] i2c-msm-v2 c17a000.i2c: msm_bus_scale_register_client(mstr-i=
d:86):0x12 (ok)
[    0.921885] drv2624 6-005a: dev_init_platform_data, LRA =3D 155, drive_t=
ime=3D0x1b
[    0.923532] drv2624 6-005a: drv2624 probe succeeded
[    0.924176] [LASER] stmvl53l0_init: Enter
[    0.924185] [LASER] stmvl53l0_init_i2c: Enter
[    0.924211] [LASER] stmvl53l0_init_i2c: End with rc:0
[    0.924217] [LASER] stmvl53l0_init: End
[    0.925042] [LASER] stmvl53l0_probe: Enter++
[    0.925065] [LASER] Laser_parse_dt: calib_file =3D /persist/ldaf_cal
[    0.925071] [LASER] Laser_parse_dt: pwdn_gpio =3D 0
[    0.925104] [LASER] Laser_parse_dt: pwdn_gpio =3D 39
[    0.925209] qcom,qpnp-rtc 800f000.qcom,spmi:qcom,pm8998@0:qcom,pm8998_rt=
c: rtc core: registered qpnp_rtc as rtc0
[    0.925260] [LASER] Laser_parse_dt: laser_irq_gpio =3D 62
[    0.925351] [LASER] Laser_parse_dt: Laser_parse_dt: sensor cali_size =3D=
 0
[    0.925474] [LASER] stmvl53l0_read_calibration: Could not read calibrati=
on from /persist/ldaf_cal
[    0.925480] [LASER] stmvl53l0_parse_vdd: Enter++
[    0.925561] 9-0029 supply vdd not found, using dummy regulator
[    0.925580] i2c /dev entries driver
[    0.925610] [LASER] stmvl53l0_parse_vdd: End--
[    0.925617] [LASER] Laser_pinctrl_init: Enter++
[    0.926040] iommu: Adding device soc:qcom,cam_smmu:msm_cam_smmu_cb1 to g=
roup 13
[    0.926285] [LASER] Laser_pinctrl_init: End--
[    0.926295] [LASER] stmvl53l0_setup: Enter++
[    0.926314] [LASER] stmvl53l0_setup: register_irq: 259
[    0.926325] CAM-SMMU cam_smmu_populate_sids:2326 __debug cnt =3D 8, cb->=
name: :vfe sid [0] =3D 3072\x0a,
[    0.926336] CAM-SMMU cam_smmu_populate_sids:2326 __debug cnt =3D 8, cb->=
name: :vfe sid [1] =3D 3073\x0a,
[    0.926343] CAM-SMMU cam_smmu_populate_sids:2326 __debug cnt =3D 8, cb->=
name: :vfe sid [2] =3D 3074\x0a,
[    0.926459] CAM-SMMU cam_smmu_populate_sids:2326 __debug cnt =3D 8, cb->=
name: :vfe sid [3] =3D 3075\x0a,
[    0.926460] iommu: Adding device soc:qcom,cam_smmu:msm_cam_smmu_cb2 to g=
roup 14
[    0.926539] CAM-SMMU cam_smmu_populate_sids:2326 __debug cnt =3D 2, cb->=
name: :cpp sid [0] =3D 2560\x0a,
[    0.926547] [LASER] stmvl53l0_setup: interrupt is hooked
[    0.926686] iommu: Adding device soc:qcom,cam_smmu:msm_cam_smmu_cb3 to g=
roup 15
[    0.926751] CAM-SMMU cam_smmu_populate_sids:2326 __debug cnt =3D 2, cb->=
name: :camera_fd sid [0] =3D 2561\x0a,
[    0.926793] input: STM VL53L0 proximity sensor as /devices/virtual/input=
/input3
[    0.926873] iommu: Adding device soc:qcom,cam_smmu:msm_cam_smmu_cb4 to g=
roup 16
[    0.926934] [LASER] stmvl53l0_setup: Misc device registration name:9-0029
[    0.927049] CAM-SMMU cam_smmu_populate_sids:2326 __debug cnt =3D 2, cb->=
name: :jpeg_enc0 sid [0] =3D 2048\x0a,
[    0.927049] iommu: Adding device soc:qcom,cam_smmu:msm_cam_smmu_cb5 to g=
roup 17
[    0.927125] CAM-SMMU cam_smmu_populate_sids:2326 __debug cnt =3D 2, cb->=
name: :jpeg_dma sid [0] =3D 2049\x0a,
[    0.927512] i2c-msm-v2 c1b7000.i2c: msm_bus_scale_register_client(mstr-i=
d:84):0x13 (ok)
[    0.927963] [LASER] stmvl53l0_setupAPIFunctions: read REVISION_ID: 0x10\=
x0a API_VERSION: 1.1.20.2
[    0.927969] [LASER] stmvl53l0_setupAPIFunctions: to setup API cut 1.1
[    0.927983] [LASER] stmvl53l0_init_client: Enter
[    0.927989] [LASER] stmvl53l0_init_client: Call of VL53L0_DataInit
[    0.930460] CAM-SOC msm_camera_get_reg_base:864 err: mem resource csiphy=
_clk_mux not found
[    0.930471] csiphy_probe: no mem resource?
[    0.930827] CAM-SOC msm_camera_get_reg_base:864 err: mem resource csiphy=
_clk_mux not found
[    0.930834] csiphy_probe: no mem resource?
[    0.931196] CAM-SOC msm_camera_get_reg_base:864 err: mem resource csiphy=
_clk_mux not found
[    0.931202] csiphy_probe: no mem resource?
[    0.933168] msm_actuator_platform_probe:1968 msm_actuator_platform_probe=
: No/Error Actuator GPIOs
[    0.933608] msm_eeprom_platform_probe failed 1712
[    0.934262] msm_eeprom_platform_probe failed 1782
[    0.934825] msm_camera_pinctrl_init:1265 Getting pinctrl handle failed
[    0.934832] msm_ois_platform_probe:1251 ERR:msm_ois_platform_probe: Erro=
r in reading OIS pinctrl
[    0.934870] qcom,ois: probe of ca0c000.qcom,cci:qcom,ois@20 failed with =
error -22
[    0.936503] i2c-msm-v2 c179000.i2c: msm_bus_scale_register_client(mstr-i=
d:86):0x15 (ok)
[    0.936795] fts_touch 5-0049: FTS Enable WBCRC
[    0.939446] [LASER] stmvl53l0_init_client: Call of VL53L0_StaticInit
[    0.940687] MSM-CPP cpp_init_hardware:1138 CPP HW Version: 0x60010000
[    0.940702] MSM-CPP cpp_init_hardware:1156 stream_cnt:0
[    0.941045] MSM-CPP cpp_release_hardware:1219 cpp hw release done
[    0.941761] CAM-SOC msm_camera_get_reg_base:864 err: mem resource vfe_fu=
se not found
[    0.941771] CAM-SOC msm_camera_get_res_size:907 err: mem resource vfe_fu=
se not found
[    0.942365] CAM-SOC msm_camera_get_reg_base:864 err: mem resource vfe_fu=
se not found
[    0.942372] CAM-SOC msm_camera_get_res_size:907 err: mem resource vfe_fu=
se not found
[    0.944857] __msm_jpeg_init:1537] Jpeg Device id 0
[    0.946522] msm_fd_hw_set_dt_parms_by_name: Error property does not exist
[    0.950736] iommu: Adding device cc00000.qcom,vidc:non_secure_cb to grou=
p 18
[    0.953646] iommu: Adding device cc00000.qcom,vidc:firmware_cb to group =
19
[    0.953762] iommu: Adding device cc00000.qcom,vidc:secure_bitstream_cb t=
o group 20
[    0.956254] iommu: Adding device cc00000.qcom,vidc:secure_pixel_cb to gr=
oup 21
[    0.957384] iommu: Adding device cc00000.qcom,vidc:secure_non_pixel_cb t=
o group 22
[    0.960666] c880000.qcom,vmem supply vdd not found, using dummy regulator
[    0.961721] msm_vidc_vmem: Up and running with 4 banks of memory from [?=
?? 0x00000000-0x3287834948 flags 0xffffffccf3044018]
[    0.962831] sde_mdp_parse_dt_prop_len: <SDEROT_INFO> prop qcom,mdss-rot-=
xin-id : doesn't exist in device tree
[    0.963109] iommu: Adding device c900000.qcom,mdss_rotator:qcom,smmu_rot=
_unsec_cb to group 23
[    0.963357] iommu: Adding device c900000.qcom,mdss_rotator:qcom,smmu_rot=
_sec_cb to group 24
[    0.963757] No change in context(0=3D=3D0), skip
[    0.965077] sde_rotator_evtlog_create_debugfs: evtlog_status: enable:0, =
panic:1, dump:2
[    0.965117] sde_rotator c900000.qcom,mdss_rotator: <SDEROT_INFO> SDE v4l=
2 rotator probe success
[    0.966194] sde_smmu_probe: <SDEROT_INFO> iommu v2 domain[0] mapping and=
 clk register successful!
[    0.966372] sde_smmu_probe: <SDEROT_INFO> iommu v2 domain[1] mapping and=
 clk register successful!
[    0.969829] thermal thermal_zone4: failed to read out thermal zone (-19)
[    0.970166] thermal thermal_zone5: failed to read out thermal zone (-19)
[    0.970648] PMI: smblib_get_prop_usb_port_temp: Couldn't get USB thermal=
 zone rc=3D-19
[    0.970797] PMI: smblib_get_prop_usb_port_temp: Couldn't get USB thermal=
 zone rc=3D-19
[    0.970805] PMI: port_overheat_work: Couldn't get USB port temp rc=3D-19
[    0.978801] QPNP SMB2 probed successfully usb:present=3D1 type=3D0 batt:=
present =3D 1 health =3D 1 charge =3D 1
[    0.978996] [LASER] stmvl53l0_read_calibration: Could not read calibrati=
on from /persist/ldaf_cal
[    0.979027] [LASER] stmvl53l0_init_client: failed: no calibration data
[    0.979036] [LASER] stmvl53l0_setup: support ver. 1.1.20.2(1.0.5.1) enab=
led
[    0.979043] [LASER] stmvl53l0_setup: End--
[    0.979129] [LASER] stmvl53l0_probe: Success--
[    0.980434] PMI: smblib_get_prop_usb_port_temp: Couldn't get USB thermal=
 zone rc=3D-19
[    0.981382] fts_touch 5-0049: get_pure_autotune_status: PureAutotune : 1=
 (E)
[    0.981393] fts_touch 5-0049: IC Firmware Version: 0x2064 [v0.44] IC Con=
fig Version: 0x0228 IC Main Version: 0x002C AFE Version: 0x07
[    0.981400] fts_touch 5-0049: product id: [51 59 02]
[    0.981407] fts_touch 5-0049: Chip revision: 0, fpc: 5, t_sensor: 1, sit=
e: 1, inspector_no: 104
[    0.981413] fts_touch 5-0049: date : 17.12.10 03:10:46
[    0.981578] [BATT] err:htc_battery_probe: This is not the Pixel 2, baili=
ng out...
[    0.981587] [BATT] at 981575885 (1970-01-01 00:00:00.981564687 UTC)
[    0.981602] [BATT] htc_battery_init done.
[    0.981778] lge_battery: bm_init: Couldn't get pl_psy
[    0.981786] lge_battery: lge_battery_probe: bm_init fail
[    0.981852] fts_touch 5-0049: FTS Chip ID : 36 70
[    0.982201] qpnp_adc_get_devicetree_data: Loaded custom map for usb_port=
_temp
[    0.982524] qpnp_vadc_read: Error reading vadc_hc channel 21
[    0.982531] thermal thermal_zone6: failed to read out thermal zone (-517)
[    1.004628] ufshcd-qcom 1da4000.ufshc: ufshcd_print_pwr_info:[RX, TX]: g=
ear=3D[3, 3], lane[2, 2], pwr[FAST MODE, FAST MODE], rate =3D 2
[    1.005660] msm_lmh_dcvs:lmh_activate_trip lmh_activate_trip: disable no=
t supported
[    1.006147] msm_lmh_dcvs:lmh_activate_trip lmh_activate_trip: disable no=
t supported
[    1.006509] scsi 0:0:0:49488: Well-known LUN    SAMSUNG  KLUCG4J1ED-B0C1=
  0200 PQ: 0 ANSI: 6
[    1.006561] device-mapper: uevent: version 1.0.3
[    1.006659] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised:=
 dm-devel@redhat.com
[    1.007180] device-mapper: verity-avb: AVB error handler initialized wit=
h vbmeta device: PARTUUID=3Dded99946-e56c-7846-cd11-3fd1bb248842
[    1.007189] device-mapper: req-crypt: dm-req-crypt successfully initaliz=
ed.\x0a
[    1.007398] bt_power_populate_dt_pinfo: bt-reset-gpio not provided in de=
vice tree
[    1.008357] scsi 0:0:0:49456: Well-known LUN    SAMSUNG  KLUCG4J1ED-B0C1=
  0200 PQ: 0 ANSI: 6
[    1.008963] hidraw: raw HID events driver (C) Jiri Kosina
[    1.009035] usbcore: registered new interface driver usbhid
[    1.009039] usbhid: USB HID core driver
[    1.009123] ashmem: initialized
[    1.009525] qpnp_coincell_charger_show_state: enabled=3DY, voltage=3D320=
0 mV, resistance=3D800 ohm
[    1.012638] bimc-bwmon 1008000.qcom,cpu-bwmon: BW HWmon governor registe=
red.
[    1.012662] scsi 0:0:0:49476: Well-known LUN    SAMSUNG  KLUCG4J1ED-B0C1=
  0200 PQ: 0 ANSI: 6
[    1.014742] scsi 0:0:0:0: Direct-Access     SAMSUNG  KLUCG4J1ED-B0C1  02=
00 PQ: 0 ANSI: 6
[    1.015816] probe: Failed to create IPC log context
[    1.016342] scsi 0:0:0:1: Direct-Access     SAMSUNG  KLUCG4J1ED-B0C1  02=
00 PQ: 0 ANSI: 6
[    1.017916] scsi 0:0:0:2: Direct-Access     SAMSUNG  KLUCG4J1ED-B0C1  02=
00 PQ: 0 ANSI: 6
[    1.019351] [smem]htc_radio_smem_init.
[    1.019439] scsi 0:0:0:3: Direct-Access     SAMSUNG  KLUCG4J1ED-B0C1  02=
00 PQ: 0 ANSI: 6
[    1.019541] usbcore: registered new interface driver snd-usb-audio
[    1.019924] scsi 0:0:0:4: Direct-Access     SAMSUNG  KLUCG4J1ED-B0C1  02=
00 PQ: 0 ANSI: 6
[    1.020492] scsi 0:0:0:5: Direct-Access     SAMSUNG  KLUCG4J1ED-B0C1  02=
00 PQ: 0 ANSI: 6
[    1.020665] fts_touch 5-0049: FTS Initialized
[    1.020732] input: touchscreen as /devices/soc/c179000.i2c/i2c-5/5-0049/=
input/input4
[    1.020740] fts_touch 5-0049: fts_input_open
[    1.020744] fts_touch 5-0049: fts_start_device already power on
[    1.020747] fts_touch 5-0049: FTS cmd after wakeup : h0
[    1.020786] fts_touch 5-0049: installing direct irq on GPIO 125
[    1.020898] power_supply touch: touch: Found supply : dc
[    1.020905] power_supply touch: touch: Found supply : usb
[    1.020911] power_supply touch: touch: Found supply : main
[    1.020916] power_supply touch: touch: Found supply : pc_port
[    1.020921] power_supply touch: touch: Found supply : battery
[    1.021438] fts_touch 5-0049: [FTS] Received Force Cal Event [ 0 ]
[    1.022031] scsi 0:0:0:6: Direct-Access     SAMSUNG  KLUCG4J1ED-B0C1  02=
00 PQ: 0 ANSI: 6
[    1.022644] tas2557s 7-004d: tas2557_i2c_probe enter
[    1.027858] sdc: sdc1
[    1.028299] sdd: sdd1 sdd2
[    1.029687] sdb: sdb1
[    1.029952] sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8 sda9 sda10 sda1=
1 sda12 sda13
[    1.031788] sdg: sdg1
[    1.032252] sdf: sdf1 sdf2 sdf3
[    1.032588] sde: sde1 sde2 sde3 sde4 sde5 sde6 sde7 sde8 sde9 sde10 sde1=
1 sde12 sde13 sde14 sde15 sde16 sde17 sde18 sde19 sde20 sde21 sde22 sde23 s=
de24 sde25 sde26 sde27 sde28 sde29 sde30 sde31 sde32 sde33 sde34 sde35 sde3=
6 sde37 sde38 sde39 sde40 sde41
[    1.033326] tas2557s 7-004d: PG2.1 found
[    1.033488] tas2557s 7-004d: tas2557_register_codec, enter
[    1.033538] tas2557s 7-004d: tas2557_register_misc, leave
[    1.033543] tas2557s 7-004d: tiload_driver_init
[    1.033555] tas2557s 7-004d: allocated Major Number: 229
[    1.033596] tas2557s 7-004d: Registered TiLoad driver, Major number: 229
[    1.039220] msm-dai-tdm soc:qcom,msm-dai-tdm-pri-rx: msm_dai_tdm_q6_prob=
e: dev_name: soc:qcom,msm-dai-tdm-pri-rx group_id: 0x9100
[    1.039332] msm-dai-q6-tdm soc:qcom,msm-dai-tdm-pri-rx:qcom,msm-dai-q6-t=
dm-pri-rx-0: msm_dai_q6_tdm_dev_probe: dev_name: soc:qcom,msm-dai-tdm-pri-r=
x:qcom,msm-dai-q6-tdm-pri-rx-0 dev_id: 0x9000
[    1.039340] msm-dai-q6-tdm soc:qcom,msm-dai-tdm-pri-rx:qcom,msm-dai-q6-t=
dm-pri-rx-0: msm_dai_q6_tdm_dev_probe: Custom tdm header not supported
[    1.039354] msm-dai-tdm soc:qcom,msm-dai-tdm-pri-tx: msm_dai_tdm_q6_prob=
e: dev_name: soc:qcom,msm-dai-tdm-pri-tx group_id: 0x9101
[    1.039453] msm-dai-q6-tdm soc:qcom,msm-dai-tdm-pri-tx:qcom,msm-dai-q6-t=
dm-pri-tx-0: msm_dai_q6_tdm_dev_probe: dev_name: soc:qcom,msm-dai-tdm-pri-t=
x:qcom,msm-dai-q6-tdm-pri-tx-0 dev_id: 0x9001
[    1.039460] msm-dai-q6-tdm soc:qcom,msm-dai-tdm-pri-tx:qcom,msm-dai-q6-t=
dm-pri-tx-0: msm_dai_q6_tdm_dev_probe: Custom tdm header not supported
[    1.039472] msm-dai-tdm soc:qcom,msm-dai-tdm-sec-rx: msm_dai_tdm_q6_prob=
e: dev_name: soc:qcom,msm-dai-tdm-sec-rx group_id: 0x9110
[    1.039571] msm-dai-q6-tdm soc:qcom,msm-dai-tdm-sec-rx:qcom,msm-dai-q6-t=
dm-sec-rx-0: msm_dai_q6_tdm_dev_probe: dev_name: soc:qcom,msm-dai-tdm-sec-r=
x:qcom,msm-dai-q6-tdm-sec-rx-0 dev_id: 0x9010
[    1.039579] msm-dai-q6-tdm soc:qcom,msm-dai-tdm-sec-rx:qcom,msm-dai-q6-t=
dm-sec-rx-0: msm_dai_q6_tdm_dev_probe: Custom tdm header not supported
[    1.039591] msm-dai-tdm soc:qcom,msm-dai-tdm-sec-tx: msm_dai_tdm_q6_prob=
e: dev_name: soc:qcom,msm-dai-tdm-sec-tx group_id: 0x9111
[    1.039693] msm-dai-q6-tdm soc:qcom,msm-dai-tdm-sec-tx:qcom,msm-dai-q6-t=
dm-sec-tx-0: msm_dai_q6_tdm_dev_probe: dev_name: soc:qcom,msm-dai-tdm-sec-t=
x:qcom,msm-dai-q6-tdm-sec-tx-0 dev_id: 0x9011
[    1.039701] msm-dai-q6-tdm soc:qcom,msm-dai-tdm-sec-tx:qcom,msm-dai-q6-t=
dm-sec-tx-0: msm_dai_q6_tdm_dev_probe: Custom tdm header not supported
[    1.039715] msm-dai-tdm soc:qcom,msm-dai-tdm-tert-rx: msm_dai_tdm_q6_pro=
be: dev_name: soc:qcom,msm-dai-tdm-tert-rx group_id: 0x9120
[    1.039813] msm-dai-q6-tdm soc:qcom,msm-dai-tdm-tert-rx:qcom,msm-dai-q6-=
tdm-tert-rx-0: msm_dai_q6_tdm_dev_probe: dev_name: soc:qcom,msm-dai-tdm-ter=
t-rx:qcom,msm-dai-q6-tdm-tert-rx-0 dev_id: 0x9020
[    1.039820] msm-dai-q6-tdm soc:qcom,msm-dai-tdm-tert-rx:qcom,msm-dai-q6-=
tdm-tert-rx-0: msm_dai_q6_tdm_dev_probe: Custom tdm header not supported
[    1.039833] msm-dai-tdm soc:qcom,msm-dai-tdm-tert-tx: msm_dai_tdm_q6_pro=
be: dev_name: soc:qcom,msm-dai-tdm-tert-tx group_id: 0x9121
[    1.039928] msm-dai-q6-tdm soc:qcom,msm-dai-tdm-tert-tx:qcom,msm-dai-q6-=
tdm-tert-tx-0: msm_dai_q6_tdm_dev_probe: dev_name: soc:qcom,msm-dai-tdm-ter=
t-tx:qcom,msm-dai-q6-tdm-tert-tx-0 dev_id: 0x9021
[    1.039936] msm-dai-q6-tdm soc:qcom,msm-dai-tdm-tert-tx:qcom,msm-dai-q6-=
tdm-tert-tx-0: msm_dai_q6_tdm_dev_probe: Custom tdm header not supported
[    1.039949] msm-dai-tdm soc:qcom,msm-dai-tdm-quat-rx: msm_dai_tdm_q6_pro=
be: dev_name: soc:qcom,msm-dai-tdm-quat-rx group_id: 0x9130
[    1.040059] msm-dai-q6-tdm soc:qcom,msm-dai-tdm-quat-rx:qcom,msm-dai-q6-=
tdm-quat-rx-0: msm_dai_q6_tdm_dev_probe: dev_name: soc:qcom,msm-dai-tdm-qua=
t-rx:qcom,msm-dai-q6-tdm-quat-rx-0 dev_id: 0x9030
[    1.040067] msm-dai-q6-tdm soc:qcom,msm-dai-tdm-quat-rx:qcom,msm-dai-q6-=
tdm-quat-rx-0: msm_dai_q6_tdm_dev_probe: Custom tdm header not supported
[    1.040080] msm-dai-tdm soc:qcom,msm-dai-tdm-quat-tx: msm_dai_tdm_q6_pro=
be: dev_name: soc:qcom,msm-dai-tdm-quat-tx group_id: 0x9131
[    1.040187] msm-dai-q6-tdm soc:qcom,msm-dai-tdm-quat-tx:qcom,msm-dai-q6-=
tdm-quat-tx-0: msm_dai_q6_tdm_dev_probe: dev_name: soc:qcom,msm-dai-tdm-qua=
t-tx:qcom,msm-dai-q6-tdm-quat-tx-0 dev_id: 0x9031
[    1.040195] msm-dai-q6-tdm soc:qcom,msm-dai-tdm-quat-tx:qcom,msm-dai-q6-=
tdm-quat-tx-0: msm_dai_q6_tdm_dev_probe: Custom tdm header not supported
[    1.046186] fts_touch 5-0049: [FTS] Received Basic Autotune Protection E=
vent [ 0 ]
[    1.046193] fts_touch 5-0049: [FTS] Received Force Cal Done Event
[    1.048149] bcm15602 9-0008: bcm15602_resetb_irq_handler: completing res=
et
[    1.048321] bcm15602 9-0008: Part: 0x5602, Rev: 2, Vendor Rev: 0x21
[    1.048477] bcm15602 9-0008: Last reboot reason: normal
[    1.050357] msm8998-asoc-snd 1711a000.sound-tavil: ASoC: platform (null)=
 not registered
[    1.050563] GACT probability NOT on
[    1.050573] Mirror/redirect action on
[    1.050588] u32 classifier
[    1.050591] Actions configured
[    1.050610] Netfilter messages via NETLINK v0.30.
[    1.050634] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[    1.050818] ctnetlink v0.93: registering with nfnetlink.
[    1.051224] xt_time: kernel timezone is -0000
[    1.051308] wireguard: allowedips self-tests: pass
[    1.051732] wireguard: nonce counter self-tests: pass
[    1.067788] wireguard: curve25519 self-tests: pass
[    1.067915] wireguard: poly1305 self-tests: pass
[    1.068263] wireguard: chacha20poly1305 self-tests: pass
[    1.068758] wireguard: blake2s self-tests: pass
[    1.293064] wireguard: ratelimiter self-tests: pass
[    1.293101] wireguard: WireGuard 0.0.20180802 loaded. See www.wireguard.=
com for information.
[    1.293106] wireguard: Copyright (C) 2015-2018 Jason A. Donenfeld <Jason=
@zx2c4.com>. All Rights Reserved.
[    1.293163] IPv4 over IPsec tunneling driver
[    1.293469] ip_tables: (C) 2000-2006 Netfilter Core Team
[    1.293580] arp_tables: (C) 2002 David S. Miller
[    1.293636] Initializing XFRM netlink socket
[    1.293856] NET: Registered protocol family 10
[    1.294417] mip6: Mobile IPv6
[    1.294429] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    1.294758] sit: IPv6 over IPv4 tunneling driver
[    1.295082] NET: Registered protocol family 17
[    1.295095] NET: Registered protocol family 15
[    1.295138] bridge: automatic filtering via arp/ip/ip6tables has been de=
precated. Update your scripts to load br_netfilter if you need this.
[    1.295145] Ebtables v2.0 registered
[    1.295216] l2tp_core: L2TP core driver, V2.0
[    1.295224] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[    1.295229] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[    1.295265] l2tp_netlink: L2TP netlink interface
[    1.295281] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[    1.295286] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
[    1.295901] NET: Registered protocol family 27
[    1.295925] IPC_RTR: ipc_router_create_log_ctx: Unable to create IPC log=
ging for [local_IPCRTR]
[    1.301065] subsys-pil-tz 17300000.qcom,lpass: for adsp segments only wi=
ll be dumped.
[    1.302781] subsys-pil-tz 5c00000.qcom,ssc: for slpi segments only will =
be dumped.
[    1.303356] pil-q6v5-mss 4080000.qcom,mss: No pas_id found.
[    1.303839] platform 4080000.qcom,mss:qcom,mba-mem@0: assigned reserved =
memory node pil_mba_region@94100000
[    1.304238] pil-q6v5-mss 4080000.qcom,mss: for modem segments only will =
be dumped.
[    1.306568] sps_register_bam_device : unable to create IPC Logging 0 for=
 bam 0x0000000000000000
[    1.306573] sps_register_bam_device : unable to create IPC Logging 1 for=
 bam 0x0000000000000000
[    1.306580] sps_register_bam_device : unable to create IPC Logging 2 for=
 bam 0x0000000000000000
[    1.306583] sps_register_bam_device : unable to create IPC Logging 3 for=
 bam 0x0000000000000000
[    1.306589] sps_register_bam_device : unable to create IPC Logging 4 for=
 bam 0x0000000000000000
[    1.306591] sps:BAM 0x0000000000000000 is registered.
[    1.307057] Invalid index Defaulting curr to 0
[    1.308306] qpnp-pdphy 800f000.qcom,spmi:qcom,pmi8998@2:qcom,usb-pdphy@1=
700: usbpd_create failed: -517
[    1.315265] thermal thermal_zone37: failed to read out thermal zone (-19)
[    1.316532] spmi spmi-0: cleanup_irq apid=3D36 sid=3D0x2 per=3D0x41 irq=
=3D6
[    1.317602] qcom,fg-gen3 800f000.qcom,spmi:qcom,pmi8998@2:qpnp,fg: Start=
 WAR to set SP_SAT_CC_CLR_AUTO_BIT
[    1.317931] qcom,fg-gen3 800f000.qcom,spmi:qcom,pmi8998@2:qpnp,fg: WAR: =
0x13 reg value: 0xbf
[    1.317965] qcom,fg-gen3 800f000.qcom,spmi:qcom,pmi8998@2:qpnp,fg: WAR: =
Bit 3 has been set, no WAR needed
[    1.318063] FG: comp_temp_by_chg_current: failed to get POWER_SUPPLY_PRO=
P_CURRENT_NOW rc =3D -61
[    1.318069] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    1.318074] FG: fg_gen3_probe: battery SOC:96 voltage: 4294666uV temp: 2=
70 id: 0KOhms
[    1.325048] FG: fg_psy_get_property: unsupported property 4
[    1.325155] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    1.325248] SMB138X: smb138x_parallel_get_prop: parallel power supply ge=
t prop 4 not supported
[    1.325365] SMB138X: smb138x_probe: SMB138X probed successfully mode=3D1
[    1.325780] lge_battery: bm_init: Battery id is zero, deferring probe!
[    1.325786] lge_battery: lge_battery_probe: bm_init fail
[    1.327036] FG: fg_get_time_to_full: battery profile is not loaded
[    1.327783] SMB138X: smb138x_get_prop_charger_temp: Couldnt read chg tem=
p at 1th iteration rc =3D -61
[    1.328939] SMB138X: smb138x_get_prop_connector_health: Couldn't read co=
nnector temperature rc=3D-61
[    1.334043] SMB138X: smb138x_parallel_get_prop: parallel power supply ge=
t prop 4 not supported
[    1.335972] msm8998-asoc-snd 1711a000.sound-tavil: ASoC: platform (null)=
 not registered
[    1.336045] SMB138X: smb138x_get_prop_charger_temp: Couldnt read chg tem=
p at 1th iteration rc =3D -61
[    1.336251] ipa ipa3_smp2p_probe:5520 failed to enable irq wake
[    1.337053] SMB138X: smb138x_get_prop_connector_health: Couldn't read co=
nnector temperature rc=3D-61
[    1.337677] Invalid index Defaulting curr to 0
[    1.339540] lge_battery: bm_init: Battery id is zero, deferring probe!
[    1.339548] lge_battery: lge_battery_probe: bm_init fail
[    1.347878] msm8998-asoc-snd 1711a000.sound-tavil: ASoC: platform (null)=
 not registered
[    1.349347] msm-dwc3 a800000.ssusb: dwc3_msm_resume: exiting lpm
[    1.349630] lge_battery: bm_init: Battery id is zero, deferring probe!
[    1.349668] lge_battery: lge_battery_probe: bm_init fail
[    1.354471] msm-dwc3 a800000.ssusb: DWC3 exited from low power mode
[    1.354495] msm-dwc3 a800000.ssusb: dwc3_msm_suspend: Calling suspend 19=
96
[    1.355660] msm-dwc3 a800000.ssusb: DWC3 in low power mode
[    1.361275] msm8998-asoc-snd 1711a000.sound-tavil: ASoC: platform (null)=
 not registered
[    1.361998] Registered cp15_barrier emulation handler
[    1.362020] Registered setend emulation handler
[    1.362210] registered taskstats version 1
[    1.362217] Loading compiled-in X.509 certificates
[    1.363480] Loaded X.509 cert 'Easel: 2d9cb8fb66a52266cb3b00b3e3db335fad=
f908e4'
[    1.363885] kcal_ctrl_init: registered
[    1.363895] msm_smem 86000000.qcom,smem: for smem segments only will be =
dumped.
[    1.363978] spss_utils [spss_init]: spss-utils driver Ver 1.2 13-Jan-201=
7.
[    1.364123] spss_utils [spss_probe]: Initialization completed ok, firmwa=
re_name [spss2p].
[    1.364700] fastrpc soc:qcom,msm-adsprpc-mem: for adsp_rh segments only =
will be dumped.
[    1.364829] iommu: Adding device soc:qcom,msm_fastrpc:qcom,msm_fastrpc_c=
pz_cb1 to group 25
[    1.365725] iommu: Adding device soc:qcom,msm_fastrpc:qcom,msm_fastrpc_c=
ompute_cb1 to group 26
[    1.366175] iommu: Adding device soc:qcom,msm_fastrpc:qcom,msm_fastrpc_c=
ompute_cb2 to group 27
[    1.366575] iommu: Adding device soc:qcom,msm_fastrpc:qcom,msm_fastrpc_c=
ompute_cb3 to group 28
[    1.366972] iommu: Adding device soc:qcom,msm_fastrpc:qcom,msm_fastrpc_c=
ompute_cb4 to group 29
[    1.367379] iommu: Adding device soc:qcom,msm_fastrpc:qcom,msm_fastrpc_c=
ompute_cb6 to group 30
[    1.367776] iommu: Adding device soc:qcom,msm_fastrpc:qcom,msm_fastrpc_c=
ompute_cb7 to group 31
[    1.368171] iommu: Adding device soc:qcom,msm_fastrpc:qcom,msm_fastrpc_c=
ompute_cb8 to group 32
[    1.369162] lge_battery: bm_init: Battery id is zero, deferring probe!
[    1.369169] lge_battery: lge_battery_probe: bm_init fail
[    1.377365] msm8998-asoc-snd 1711a000.sound-tavil: ASoC: platform (null)=
 not registered
[    1.377806] ngd_msm_ctrl 171c0000.slim: error creating ipc_logging conte=
xt
[    1.378197] lge_battery: bm_init: Battery id is zero, deferring probe!
[    1.378205] lge_battery: lge_battery_probe: bm_init fail
[    1.382622] msm_pcie_enable: PCIe: Assert the reset of endpoint of RC0.
[    1.386078] msm_pcie_enable: PCIe RC0 PHY is ready!
[    1.386758] msm8998-asoc-snd 1711a000.sound-tavil: ASoC: platform (null)=
 not registered
[    1.387096] msm_pcie_enable: PCIe: Release the reset of endpoint of RC0.
[    1.387423] misc mnh_sm: mnh_sm_ready_irq_handler: mnh device is ready t=
o boot
[    1.403475] msm_pcie_enable: PCIe RC0 link initialized
[    1.403549] PCI host bridge /soc/qcom,pcie@01c00000 ranges:
[    1.403559] No bus range found for /soc/qcom,pcie@01c00000, using [bus 0=
0-ff]
[    1.403572] IO 0x1b030000..0x1b04ffff -> 0x1b030000
[    1.403581] MEM 0x1b100000..0x1bffffff -> 0x1b100000
[    1.403687] pci-msm 1c00000.qcom,pcie: PCI host bridge to bus 0000:00
[    1.403695] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.403704] pci_bus 0000:00: root bus resource [io  0x0000-0x1ffff] (bus=
 address [0x1b030000-0x1b04ffff])
[    1.403711] pci_bus 0000:00: root bus resource [mem 0x00000000-0x00effff=
f]
[    1.403748] pci 0000:00:00.0: [17cb:0105] type 01 class 0x060400
[    1.403824] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[    1.403921] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    1.404080] iommu: Adding device 0000:00:00.0 to group 33
[    1.404109] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00])=
, reconfiguring
[    1.404280] pci 0000:01:00.0: [8086:3140] type 00 class 0x000000
[    1.404415] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit=
 pref]
[    1.404476] pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x007fffff 64bit]
[    1.404537] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x003fffff 64bit=
 pref]
[    1.404590] pci 0000:01:00.0: setting pcie class
[    1.404734] pci 0000:01:00.0: supports D1 D2
[    1.404740] pci 0000:01:00.0: PME# supported from D0 D1 D3hot D3cold
[    1.404906] iommu: Adding device 0000:01:00.0 to group 34
[    1.404926] pci_bus 0000:01: busn_res: [bus 00-fe] end is updated to 01
[    1.404983] pci 0000:00:00.0: BAR 8: assigned [mem 0x00000000-0x007fffff]
[    1.404992] pci 0000:00:00.0: BAR 9: assigned [mem 0x00000000-0x005fffff=
 64bit pref]
[    1.405001] pci 0000:00:00.0: BAR 0: assigned [mem 0x00000000-0x00000fff=
 64bit]
[    1.405058] pci 0000:01:00.0: BAR 2: assigned [mem 0x00000000-0x007fffff=
 64bit]
[    1.405110] pci 0000:01:00.0: BAR 4: assigned [mem 0x00000000-0x003fffff=
 64bit pref]
[    1.405161] pci 0000:01:00.0: BAR 0: assigned [mem 0x00000000-0x00000fff=
 64bit pref]
[    1.405213] pci 0000:00:00.0: PCI bridge to [bus 00]
[    1.405233] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x007fffff]
[    1.405249] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x005fffff=
 64bit pref]
[    1.405394] pci 0000:00:00.0: enabling device (0000 -> 0002)
[    1.405419] mnh_pci 0000:01:00.0: enabling device (0000 -> 0002)
[    1.406043] mnh_pci 0000:01:00.0: vector :10 , msi_num:10, irq:755
[    1.406183] mnh_pci 0000:01:00.0: request irq:756
[    1.406277] mnh_pci 0000:01:00.0: request irq:757
[    1.406367] mnh_pci 0000:01:00.0: request irq:758
[    1.406466] mnh_pci 0000:01:00.0: request irq:759
[    1.406557] mnh_pci 0000:01:00.0: request irq:760
[    1.406647] mnh_pci 0000:01:00.0: request irq:763
[    1.406744] mnh_pci 0000:01:00.0: request irq:764
[    1.408595] mnh_pci 0000:01:00.0: attached to IOMMU
[    1.408734] lge_battery: bm_init: Battery id is zero, deferring probe!
[    1.408740] lge_battery: lge_battery_probe: bm_init fail
[    1.417091] msm8998-asoc-snd 1711a000.sound-tavil: ASoC: platform (null)=
 not registered
[    1.429181] msm_pcie_disable: PCIe: Assert the reset of endpoint of RC0.
[    1.429215] misc mnh_sm: mnh_sm_ready_irq_handler: mnh device is ready t=
o suspend
[    1.431076] misc mnh_sm: MNH SM initialized successfully
[    1.431114] ngd_msm_ctrl 17240000.slim: error creating ipc_logging conte=
xt
[    1.431182] lge_battery: bm_init: Battery id is zero, deferring probe!
[    1.431188] lge_battery: lge_battery_probe: bm_init fail
[    1.439500] RNDIS_IPA module is loaded.
[    1.439750] msm8998-asoc-snd 1711a000.sound-tavil: ASoC: platform (null)=
 not registered
[    1.439957] [KEY] gpio_keys_setup_key, error=3D-524, debounce(15, 15)
[    1.439982] [KEY] keycode =3D 115, gpio =3D 126, irq =3D 323
[    1.439987] [KEY] gpio_keys_setup_key, error=3D-524, debounce(15, 15)
[    1.440004] [KEY] keycode =3D 222, gpio =3D 124, irq =3D 321
[    1.440076] input: gpio-keys as /devices/soc/soc:gpio_keys/input/input5
[    1.440193] lge_battery: bm_init: Battery id is zero, deferring probe!
[    1.440200] lge_battery: lge_battery_probe: bm_init fail
[    1.440251] qcom,qpnp-rtc 800f000.qcom,spmi:qcom,pm8998@0:qcom,pm8998_rt=
c: setting system clock to 1970-01-04 18:32:34 UTC (325954)
[    1.444930] lmh_lite:lmh_parse_sensor Registering sensor:[GLM_soc]
[    1.445102] lmh_lite:lmh_parse_sensor Registering sensor:[LLM_cp1-]
[    1.445239] lmh_lite:lmh_parse_sensor Registering sensor:[LLM_cp0-]
[    1.445417] soc:qcom,lmh supply vdd-apss not found, using dummy regulator
[    1.445465] lmh_lite:lmh_get_sensor_devicetree Error getting ODCM thresh=
=2E err:-22
[    1.448995] msm8998-asoc-snd 1711a000.sound-tavil: ASoC: platform (null)=
 not registered
[    1.449032] parse_cpu_levels: idx 1 503
[    1.449037] parse_cpu_levels: idx 2 1744
[    1.449040] parse_cpu_levels: idx 2 2222
[    1.449100] parse_cpu_levels: idx 1 1301
[    1.449103] parse_cpu_levels: idx 2 1820
[    1.449106] parse_cpu_levels: idx 2 1999
[    1.449115] calculate_residency: residency < 0 for LPM
[    1.449397] lge_battery: bm_init: Battery id is zero, deferring probe!
[    1.449404] lge_battery: lge_battery_probe: bm_init fail
[    1.457958] msm8998-asoc-snd 1711a000.sound-tavil: ASoC: platform (null)=
 not registered
[    1.458382] lge_battery: bm_init: Battery id is zero, deferring probe!
[    1.458388] lge_battery: lge_battery_probe: bm_init fail
[    1.458850] rmnet_ipa3 started initialization
[    1.460790] qcom,cc-debug-8998 162000.qcom,debugcc: Registered debug mux
[    1.463212] gfx_mem_acc_corner: disabling
[    1.463245] apc0_pwrcl_corner: disabling
[    1.463249] apc1_perfcl_corner: disabling
[    1.463691] regulator_proxy_consumer_remove_all: removing regulator prox=
y consumer requests
[    1.463830] clock_late_init: Removing enables held for handed-off clocks
[    1.466842] ALSA device list:
[    1.466847] No soundcards found.
[    1.466908] Warning: unable to open an initial console.
[    1.467318] msm8998-asoc-snd 1711a000.sound-tavil: ASoC: platform (null)=
 not registered
[    1.468147] Freeing unused kernel memory: 4032K
[    1.468161] lge_battery: bm_init: Battery id is zero, deferring probe!
[    1.468169] lge_battery: lge_battery_probe: bm_init fail
[    1.472503] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    1.477825] msm8998-asoc-snd 1711a000.sound-tavil: ASoC: platform (null)=
 not registered
[    1.479417] EXT4-fs (sda7): mounted filesystem without journal. Opts: (n=
ull)
[    1.499741] EXT4-fs (sde14): mounted filesystem without journal. Opts: (=
null)
[    1.588229] init: init first stage started!
[    1.588366] init: Using Android DT directory /proc/device-tree/firmware/=
android/
[    1.589158] init: [libfs_mgr]fs_mgr_read_fstab_default(): failed to find=
 device default fstab
[    1.598724] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    1.601078] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    1.606552] EXT4-fs (sda4): mounted filesystem with ordered data mode. O=
pts: barrier=3D1
[    1.606596] init: [libfs_mgr]__mount(source=3D/dev/block/platform/soc/1d=
a4000.ufshc/by-name/persist,target=3D/persist,type=3Dext4)=3D0: Success
[    1.608006] init: [libfs_mgr]Returning avb_handle with status: 0
[    1.609295] init: [libfs_mgr]Loading verity table: '1 /dev/block/platfor=
m/soc/1da4000.ufshc/by-name/vendor_a /dev/block/platform/soc/1da4000.ufshc/=
by-name/vendor_a 4096 4096 125961 125961 sha1 4b6ef3874cd11e523f903fc4a4add=
60ebe9860ec 5133f927d2940fe71a004c2ee25489353ac451a7382c9ed8f65f7bce8f40135=
0 10 use_fec_from_device /dev/block/platform/soc/1da4000.ufshc/by-name/vend=
or_a fec_roots 2 fec_blocks 126955 fec_start 126955 restart_on_corruption i=
gnore_zero_blocks'
[    1.613078] EXT4-fs (dm-0): mounted filesystem without journal. Opts: ba=
rrier=3D1
[    1.613120] init: [libfs_mgr]__mount(source=3D/dev/block/dm-0,target=3D/=
vendor,type=3Dext4)=3D0: Success
[    1.613179] init: Skipped setting INIT_AVB_VERSION (not in recovery mode)
[    1.613250] init: Loading SELinux policy
[    1.616510] SELinux: 16384 avtab hash slots, 39645 rules.
[    1.623560] SELinux: 16384 avtab hash slots, 39645 rules.
[    1.623571] SELinux:  1 users, 4 roles, 1564 types, 0 bools, 1 sens, 102=
4 cats
[    1.623575] SELinux:  93 classes, 39645 rules
[    1.625745] SELinux:  Completing initialization.
[    1.625750] SELinux:  Setting up existing superblocks.
[    1.662020] audit: type=3D1403 audit(325954.719:2): policy loaded auid=
=3D4294967295 ses=3D4294967295
[    1.662244] selinux: SELinux: Loaded policy from /sepolicy\x0a
[    1.662363] audit: type=3D1404 audit(325954.720:3): enforcing=3D1 old_en=
forcing=3D0 auid=3D4294967295 ses=3D4294967295
[    1.666882] selinux: SELinux: Loaded file_contexts\x0a
[    1.668784] init: init second stage started!
[    1.673722] of_batterydata_get_best_profile: lge_blt35_tocad_3620mah fou=
nd
[    1.678203] init: Using Android DT directory /proc/device-tree/firmware/=
android/
[    1.680199] selinux: SELinux: Loaded file_contexts\x0a
[    1.680212] init: Running restorecon...
[    1.684306] init: waitid failed: No child processes
[    1.686041] init: Couldn't load property file '/odm/default.prop': open(=
) failed: No such file or directory: No such file or directory
[    1.686846] init: Created socket '/dev/socket/property_service', mode 66=
6, user 0, group 0
[    1.687250] init: Forked subcontext for 'u:r:vendor_init:s0' with pid 577
[    1.687461] init: Forked subcontext for 'u:r:vendor_init:s0' with pid 578
[    1.687528] init: Parsing file /init.rc...
[    1.687760] init: Added '/init.magisk.rc' to import list
[    1.687769] init: Added '/init.environ.rc' to import list
[    1.687776] init: Added '/init.usb.rc' to import list
[    1.687786] init: Added '/init.taimen.rc' to import list
[    1.687794] init: Added '/vendor/etc/init/hw/init.taimen.rc' to import l=
ist
[    1.687801] init: Added '/init.usb.configfs.rc' to import list
[    1.687809] init: Added '/init.zygote64_32.rc' to import list
[    1.688419] init: Parsing file /init.magisk.rc...
[    1.688471] init: Parsing file /init.environ.rc...
[    1.688511] init: Parsing file /init.usb.rc...
[    1.688690] init: Parsing file /init.taimen.rc...
[    1.688706] init: Unable to read config file '/init.taimen.rc': open() f=
ailed: No such file or directory
[    1.688717] init: /init.rc: 10: Could not import file '/init.taimen.rc':=
 No such file or directory
[    1.690070] init: Parsing file /vendor/etc/init/hw/init.taimen.rc...
[    1.690709] init: Added '/vendor/etc/init/hw/init.taimen.usb.rc' to impo=
rt list
[    1.691631] init: /vendor/etc/init/hw/init.taimen.rc: 745: Unable to dec=
ode GID for 'qcom_diag': getpwnam failed: No such file or directory
[    1.691990] init: Parsing file /vendor/etc/init/hw/init.taimen.usb.rc...
[    1.692188] init: Added '/vendor/etc/init/hw/init.wahoo.usb.rc' to impor=
t list
[    1.692377] init: Parsing file /vendor/etc/init/hw/init.wahoo.usb.rc...
[    1.692614] init: Parsing file /init.usb.configfs.rc...
[    1.692843] init: Parsing file /init.zygote64_32.rc...
[    1.692940] init: Parsing directory /system/etc/init...
[    1.693275] init: Parsing file /system/etc/init/android.hidl.allocator@1=
=2E0-service.rc...
[    1.693456] init: Parsing file /system/etc/init/atrace.rc...
[    1.693767] init: Parsing file /system/etc/init/audioserver.rc...
[    1.693959] init: Parsing file /system/etc/init/blank_screen.rc...
[    1.694132] init: Parsing file /system/etc/init/bootanim.rc...
[    1.694307] init: Parsing file /system/etc/init/bootstat.rc...
[    1.694543] init: Parsing file /system/etc/init/bufferhubd.rc...
[    1.694724] init: Parsing file /system/etc/init/cameraserver.rc...
[    1.694903] init: Parsing file /system/etc/init/cppreopts.rc...
[    1.695105] init: Parsing file /system/etc/init/drmserver.rc...
[    1.695279] init: Parsing file /system/etc/init/dumpstate.rc...
[    1.695462] init: Parsing file /system/etc/init/gatekeeperd.rc...
[    1.695631] init: Parsing file /system/etc/init/healthd.rc...
[    1.695803] init: Parsing file /system/etc/init/hwservicemanager.rc...
[    1.695986] init: Parsing file /system/etc/init/incidentd.rc...
[    1.696175] init: Parsing file /system/etc/init/installd.rc...
[    1.696464] init: Parsing file /system/etc/init/keystore.rc...
[    1.696638] init: Parsing file /system/etc/init/lmkd.rc...
[    1.696810] init: Parsing file /system/etc/init/logd.rc...
[    1.696994] init: Parsing file /system/etc/init/mdnsd.rc...
[    1.697173] init: Parsing file /system/etc/init/mediadrmserver.rc...
[    1.697347] init: Parsing file /system/etc/init/mediaextractor.rc...
[    1.697534] init: Parsing file /system/etc/init/mediametrics.rc...
[    1.697704] init: Parsing file /system/etc/init/mediaserver.rc...
[    1.697879] init: Parsing file /system/etc/init/mtpd.rc...
[    1.698055] init: Parsing file /system/etc/init/netd.rc...
[    1.698233] init: Parsing file /system/etc/init/otapreopt.rc...
[    1.698405] init: Parsing file /system/etc/init/perfetto.rc...
[    1.698620] init: Parsing file /system/etc/init/performanced.rc...
[    1.698794] init: Parsing file /system/etc/init/racoon.rc...
[    1.698968] init: Parsing file /system/etc/init/recovery-persist.rc...
[    1.699136] init: Parsing file /system/etc/init/recovery-refresh.rc...
[    1.699300] init: Parsing file /system/etc/init/servicemanager.rc...
[    1.699483] init: Parsing file /system/etc/init/statsd.rc...
[    1.699673] init: Parsing file /system/etc/init/storaged.rc...
[    1.699841] init: Parsing file /system/etc/init/surfaceflinger.rc...
[    1.700036] init: Parsing file /system/etc/init/thermalservice.rc...
[    1.700204] init: Parsing file /system/etc/init/tombstoned.rc...
[    1.700374] init: Parsing file /system/etc/init/uncrypt.rc...
[    1.700559] init: Parsing file /system/etc/init/update_engine.rc...
[    1.700737] init: Parsing file /system/etc/init/update_verifier.rc...
[    1.700918] init: Parsing file /system/etc/init/usbd.rc...
[    1.701087] init: Parsing file /system/etc/init/vdc.rc...
[    1.701244] init: Parsing file /system/etc/init/virtual_touchpad.rc...
[    1.701418] init: Parsing file /system/etc/init/vold.rc...
[    1.701591] init: Parsing file /system/etc/init/vr_hwc.rc...
[    1.701763] init: Parsing file /system/etc/init/wait_for_keymaster.rc...
[    1.701931] init: Parsing file /system/etc/init/wifi-events.rc...
[    1.702156] init: Parsing file /system/etc/init/wificond.rc...
[    1.702365] init: Parsing file /product/etc/init...
[    1.702382] init: Unable to read config file '/product/etc/init': open()=
 failed: No such file or directory
[    1.702399] init: Parsing file /odm/etc/init...
[    1.702412] init: Unable to read config file '/odm/etc/init': open() fai=
led: No such file or directory
[    1.702423] init: Parsing directory /vendor/etc/init...
[    1.702514] init: Parsing file /vendor/etc/init/android.hardware.audio@2=
=2E0-service.rc...
[    1.703178] init: Parsing file /vendor/etc/init/android.hardware.biometr=
ics.fingerprint@2.1-service.fpc.rc...
[    1.703523] init: Parsing file /vendor/etc/init/android.hardware.bluetoo=
th@1.0-service-qti.rc...
[    1.703907] init: Parsing file /vendor/etc/init/android.hardware.boot@1.=
0-service.rc...
[    1.704266] init: Parsing file /vendor/etc/init/android.hardware.camera.=
provider@2.4-service.rc...
[    1.704611] init: Parsing file /vendor/etc/init/android.hardware.cas@1.0=
-service.rc...
[    1.704968] init: Parsing file /vendor/etc/init/android.hardware.configs=
tore@1.1-service.rc...
[    1.705314] init: Parsing file /vendor/etc/init/android.hardware.context=
hub@1.0-service.rc...
[    1.705657] init: Parsing file /vendor/etc/init/android.hardware.drm@1.0=
-service.rc...
[    1.706031] init: Parsing file /vendor/etc/init/android.hardware.drm@1.1=
-service.clearkey.rc...
[    1.706389] init: Parsing file /vendor/etc/init/android.hardware.drm@1.1=
-service.widevine.rc...
[    1.706759] init: Parsing file /vendor/etc/init/android.hardware.dumpsta=
te@1.0-service.wahoo.rc...
[    1.707245] init: Parsing file /vendor/etc/init/android.hardware.gatekee=
per@1.0-service-qti.rc...
[    1.707595] init: Parsing file /vendor/etc/init/android.hardware.gnss@1.=
0-service-qti.rc...
[    1.707937] init: Parsing file /vendor/etc/init/android.hardware.graphic=
s.allocator@2.0-service.rc...
[    1.708333] init: Parsing file /vendor/etc/init/android.hardware.graphic=
s.composer@2.1-service.rc...
[    1.708705] init: Parsing file /vendor/etc/init/android.hardware.health@=
2.0-service.wahoo.rc...
[    1.709066] init: Parsing file /vendor/etc/init/android.hardware.keymast=
er@3.0-service-qti.rc...
[    1.709407] init: Parsing file /vendor/etc/init/android.hardware.light@2=
=2E0-service.rc...
[    1.709853] init: Parsing file /vendor/etc/init/android.hardware.media.o=
mx@1.0-service.rc...
[    1.710205] init: Parsing file /vendor/etc/init/android.hardware.memtrac=
k@1.0-service.rc...
[    1.710566] init: Parsing file /vendor/etc/init/android.hardware.nfc@1.1=
-service.rc...
[    1.710908] init: Parsing file /vendor/etc/init/android.hardware.oemlock=
@1.0-service.rc...
[    1.711292] init: Parsing file /vendor/etc/init/android.hardware.power@1=
=2E2-service.wahoo-libperfmgr.rc...
[    1.711666] init: Parsing file /vendor/etc/init/android.hardware.sensors=
@1.0-service.rc...
[    1.712038] init: Parsing file /vendor/etc/init/android.hardware.usb@1.1=
-service.wahoo.rc...
[    1.712389] init: Parsing file /vendor/etc/init/android.hardware.vibrato=
r@1.2-service.wahoo.rc...
[    1.712729] init: Parsing file /vendor/etc/init/android.hardware.vr@1.0-=
service.wahoo.rc...
[    1.713093] init: Parsing file /vendor/etc/init/android.hardware.wifi@1.=
0-service.rc...
[    1.713464] init: Parsing file /vendor/etc/init/esed.rc...
[    1.713828] init: Parsing file /vendor/etc/init/hostapd.android.rc...
[    1.714325] init: Parsing file /vendor/etc/init/init-taimen.rc...
[    1.714699] init: Parsing file /vendor/etc/init/init.taimen.diag.rc...
[    1.715119] init: Parsing file /vendor/etc/init/init.taimen.logging.rc...
[    1.715459] init: Parsing file /vendor/etc/init/rild.rc...
[    1.715808] init: Parsing file /vendor/etc/init/vndservicemanager.rc...
[    1.716200] init: processing action (early-init) from (/init.rc:15)
[    1.718266] init: starting service 'ueventd'...
[    1.718757] init: processing action (early-init) from (/vendor/etc/init/=
hw/init.taimen.rc:37)
[    1.719441] audit: type=3D1400 audit(325954.777:4): avc:  denied  { sys_=
admin } for  pid=3D579 comm=3D"ueventd" capability=3D21  scontext=3Du:r:uev=
entd:s0 tcontext=3Du:r:ueventd:s0 tclass=3Dcapability permissive=3D0
[    1.722129] ueventd: ueventd started!
[    1.722296] init: starting service 'vendor.insmod_sh'...
[    1.722823] init: processing action (wait_for_coldboot_done) from (<Buil=
tin Action>:0)
[    1.724711] selinux: SELinux: Loaded file_contexts\x0a
[    1.724770] ueventd: Parsing file /ueventd.rc...
[    1.726161] ueventd: Parsing file /vendor/ueventd.rc...
[    1.727644] ueventd: Parsing file /odm/ueventd.rc...
[    1.727677] ueventd: Unable to read config file '/odm/ueventd.rc': open(=
) failed: No such file or directory
[    1.727760] ueventd: Parsing file /ueventd.taimen.rc...
[    1.727784] ueventd: Unable to read config file '/ueventd.taimen.rc': op=
en() failed: No such file or directory
[    1.734229] audit: type=3D1400 audit(325954.792:5): avc:  denied  { sys_=
admin } for  pid=3D581 comm=3D"init.insmod.sh" capability=3D21  scontext=3D=
u:r:init-insmod-sh:s0 tcontext=3Du:r:init-insmod-sh:s0 tclass=3Dcapability =
permissive=3D0
[    1.758348] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    1.759861] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    1.765876] audit: type=3D1400 audit(325954.823:6): avc:  denied  { sys_=
admin } for  pid=3D582 comm=3D"getprop" capability=3D21  scontext=3Du:r:ini=
t-insmod-sh:s0 tcontext=3Du:r:init-insmod-sh:s0 tclass=3Dcapability permiss=
ive=3D0
[    1.772625] ueventd: firmware: loading 'drv2624.bin' for '/devices/soc/c=
17a000.i2c/i2c-6/6-005a/firmware/drv2624.bin'
[    1.774093] ueventd: loading /devices/soc/c17a000.i2c/i2c-6/6-005a/firmw=
are/drv2624.bin took 1ms
[    1.774123] drv2624 6-005a: drv2624_firmware_load, firmware good
[    1.778431] audit: type=3D1400 audit(325954.836:7): avc:  denied  { sys_=
admin } for  pid=3D585 comm=3D"insmod" capability=3D21  scontext=3Du:r:init=
-insmod-sh:s0 tcontext=3Du:r:init-insmod-sh:s0 tclass=3Dcapability permissi=
ve=3D0
[    1.793721] SMB138X: smb138x_get_prop_charger_temp: Couldnt read chg tem=
p at 1th iteration rc =3D -61
[    1.793948] audit: type=3D1400 audit(325954.851:8): avc:  denied  { sys_=
admin } for  pid=3D586 comm=3D"insmod" capability=3D21  scontext=3Du:r:init=
-insmod-sh:s0 tcontext=3Du:r:init-insmod-sh:s0 tclass=3Dcapability permissi=
ve=3D0
[    1.794727] SMB138X: smb138x_get_prop_connector_health: Couldn't read co=
nnector temperature rc=3D-61
[    1.795748] ueventd: firmware: loading 'tas2557s_PG21_uCDSP.bin' for '/d=
evices/soc/c1b5000.i2c/i2c-7/7-004d/firmware/tas2557s_PG21_uCDSP.bin'
[    1.797077] tas2557s 7-004d: tas2557_fw_ready:
[    1.797089] ueventd: loading /devices/soc/c1b5000.i2c/i2c-7/7-004d/firmw=
are/tas2557s_PG21_uCDSP.bin took 1ms
[    1.797998] tas2557s 7-004d: TAS2557 calibration file size =3D 550
[    1.798003] tas2557s 7-004d: FW Size       =3D 550
[    1.798008] tas2557s 7-004d: Checksum      =3D 0x0000
[    1.798011] tas2557s 7-004d: PPC Version   =3D 0x0000
[    1.798024] tas2557s 7-004d: FW  Version    =3D 0x0000
[    1.798028] tas2557s 7-004d: Driver Version=3D 0x0100
[    1.798031] tas2557s 7-004d: Timestamp     =3D 623
[    1.798034] tas2557s 7-004d: DDC Name      =3D Calibration Data File
[    1.798038] tas2557s 7-004d: Description   =3D Calibration Data File for=
 TAS2557 Dual Mono
[    1.798043] tas2557s 7-004d: TAS2557 calibration: 1 calibrations
[    1.798050] tas2557s 7-004d: FW Size       =3D 51609
[    1.798054] tas2557s 7-004d: Checksum      =3D 0x35E64F0F
[    1.798057] tas2557s 7-004d: PPC Version   =3D 0x5C000
[    1.798060] tas2557s 7-004d: FW  Version    =3D 0x1010000
[    1.798064] tas2557s 7-004d: Driver Version=3D 0x0300
[    1.798067] tas2557s 7-004d: Timestamp     =3D 1501470973
[    1.798070] tas2557s 7-004d: DDC Name      =3D tas2557s_PG21_uCDSP
[    1.798073] tas2557s 7-004d: Description   =3D TI SmartAmp
[    1.798141] tas2557s 7-004d: find default configuration 0
[    1.802771] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    1.805191] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    1.812237] audit: type=3D1400 audit(325954.870:9): avc:  denied  { sys_=
admin } for  pid=3D588 comm=3D"insmod" capability=3D21  scontext=3Du:r:init=
-insmod-sh:s0 tcontext=3Du:r:init-insmod-sh:s0 tclass=3Dcapability permissi=
ve=3D0
[    1.814379] tas2557s 7-004d: load program 0 (Tuning Mode)
[    1.814386] tas2557s 7-004d: TAS2557 load data: Tuning Mode Program, Blo=
cks =3D 3, Block Type =3D 13
[    1.820081] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    1.823636] audit: type=3D1400 audit(325954.881:10): avc:  denied  { sys=
_admin } for  pid=3D591 comm=3D"insmod" capability=3D21  scontext=3Du:r:ini=
t-insmod-sh:s0 tcontext=3Du:r:init-insmod-sh:s0 tclass=3Dcapability permiss=
ive=3D0
[    1.824586] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    1.827423] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    1.830970] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    1.835445] fts_touch 5-0049: [FTS] Received Charger Connected Event
[    1.901220] SMB138X: smb138x_parallel_get_prop: parallel power supply ge=
t prop 4 not supported
[    1.907873] ueventd: Coldboot took 0.178 seconds
[    1.915862] init: wait for '/dev/.coldboot_done' took 193ms
[    1.916011] init: Command 'wait_for_coldboot_done' action=3Dwait_for_col=
dboot_done (<Builtin Action>:0) took 193ms and succeeded
[    1.916393] init: processing action (MixHwrngIntoLinuxRng) from (<Builti=
n Action>:0)
[    1.916761] init: Mixed 512 bytes from /dev/hw_random into /dev/urandom
[    1.916799] init: processing action (SetMmapRndBits) from (<Builtin Acti=
on>:0)
[    1.917396] init: processing action (SetKptrRestrict) from (<Builtin Act=
ion>:0)
[    1.917489] init: processing action (keychord_init) from (<Builtin Actio=
n>:0)
[    1.917558] keychord: using input dev qpnp_pon for fevent
[    1.917566] keychord: using input dev s2w_pwrkey for fevent
[    1.917578] keychord: using input dev gpio-keys for fevent
[    1.917656] init: processing action (console_init) from (<Builtin Action=
>:0)
[    1.917717] init: processing action (init) from (/init.rc:42)
[    1.918211] init: Command 'copy /default.prop /dev/urandom' action=3Dini=
t (/init.rc:47) took 0ms and failed: Could not read input file '/default.pr=
op': open() failed: Too many symbolic links encountered
[    1.918523] init: Service 'vendor.insmod_sh' (pid 581) exited with statu=
s 0
[    1.937481] init: Command 'mount cgroup2 cg2_bpf /dev/cg2_bpf nodev noex=
ec nosuid' action=3Dinit (/init.rc:226) took 0ms and failed: mount() failed=
: No such device
[    1.940706] Registered swp emulation handler
[    1.941301] init: processing action (init) from (/init.environ.rc:2)
[    1.941338] init: processing action (init) from (/vendor/etc/init/hw/ini=
t.taimen.rc:43)
[    1.942319] init: Command 'write /sys/devices/soc/${ro.boot.bootdevice}/=
clkscale_enable 0' action=3Dinit (/vendor/etc/init/hw/init.taimen.rc:45) to=
ok 0ms and failed: Unable to write to file '/sys/devices/soc/1da4000.ufshc/=
clkscale_enable': open() failed: Permission denied
[    1.942619] init: Command 'write /sys/module/lpm_levels/parameters/sleep=
_disabled Y' action=3Dinit (/vendor/etc/init/hw/init.taimen.rc:47) took 0ms=
 and failed: Unable to write to file '/sys/module/lpm_levels/parameters/sle=
ep_disabled': open() failed: Permission denied
[    1.942702] init: wait for '/dev/block/platform/soc/1da4000.ufshc' took =
0ms
[    1.945922] init: starting service 'vendor.qseecomd'...
[    1.946823] init: Command 'symlink /sdcard /storage/sdcard0' action=3Din=
it (/vendor/etc/init/hw/init.taimen.rc:59) took 0ms and failed: symlink() f=
ailed: Permission denied
[    1.946964] msm_thermal:store_cc_enabled Core control disabled
[    1.966445] init: processing action (ro.boot.revision=3D* && init) from =
(/vendor/etc/init/init-taimen.rc:31)
[    1.966579] init: processing action (MixHwrngIntoLinuxRng) from (<Builti=
n Action>:0)
[    1.966841] init: Mixed 512 bytes from /dev/hw_random into /dev/urandom
[    1.966875] init: processing action (late-init) from (/init.rc:279)
[    1.966905] init: processing action (late-init) from (/system/etc/init/a=
trace.rc:3)
[    1.968118] init: processing action (queue_property_triggers) from (<Bui=
ltin Action>:0)
[    1.968146] init: processing action (fs) from (/vendor/etc/init/hw/init.=
taimen.rc:162)
[    1.968388] init: starting service 'hwservicemanager'...
[    1.971711] init: [libfs_mgr]__mount(source=3D/dev/block/platform/soc/1d=
a4000.ufshc/by-name/modem_a,target=3D/firmware,type=3Dvfat)=3D0: Success
[    1.972292] init: Parsing file /product/etc/init...
[    1.972316] init: Unable to read config file '/product/etc/init': open()=
 failed: No such file or directory
[    1.972337] init: Parsing file /odm/etc/init...
[    1.972353] init: Unable to read config file '/odm/etc/init': open() fai=
led: No such file or directory
[    1.974470] capability: warning: `qseecomd' uses 32-bit capabilities (le=
gacy support in use)
[    1.975781] scm_call failed: func id 0x72000206, ret: -1, syscall return=
s: 0x0, 0x0, 0x0
[    1.976696] scm_call failed: func id 0x72000206, ret: -1, syscall return=
s: 0x0, 0x0, 0x0
[    1.980302] init: processing action (fs) from (/system/etc/init/logd.rc:=
18)
[    1.980530] init: processing action (fs) from (/system/etc/init/wifi-eve=
nts.rc:17)
[    1.980586] init: processing action (post-fs) from (/init.rc:312)
[    1.981465] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    1.982064] scm_call failed: func id 0x72000206, ret: -1, syscall return=
s: 0x0, 0x0, 0x0
[    1.982074] init: Couldn't load property file '/odm/build.prop': open() =
failed: No such file or directory: No such file or directory
[    1.983961] init: Couldn't load property file '/factory/factory.prop': o=
pen() failed: No such file or directory: No such file or directory
[    1.984590] init: /recovery not specified in fstab
[    1.984611] scm_call failed: func id 0x72000206, ret: -1, syscall return=
s: 0x0, 0x0, 0x0
[    1.984737] init: starting service 'logd'...
[    1.985950] init: starting service 'servicemanager'...
[    1.986549] init: Created socket '/dev/socket/logd', mode 666, user 1036=
, group 1036
[    1.986788] init: starting service 'vndservicemanager'...
[    1.986913] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    1.987058] init: Created socket '/dev/socket/logdr', mode 666, user 103=
6, group 1036
[    1.987546] init: Created socket '/dev/socket/logdw', mode 222, user 103=
6, group 1036
[    1.987601] init: Command 'chown system cache /cache' action=3Dpost-fs (=
/init.rc:339) took 0ms and failed: lchown() failed: Read-only file system
[    1.987640] init: Command 'chmod 0770 /cache' action=3Dpost-fs (/init.rc=
:340) took 0ms and failed: fchmodat() failed: Read-only file system
[    1.987726] selinux: SELinux: Could not set context for /cache:  Read-on=
ly file system\x0a
[    1.988795] init: Opened file '/proc/kmsg', flags 0
[    1.988840] init: Opened file '/dev/kmsg', flags 1
[    1.989221] selinux: SELinux:  Could not stat /metadata: No such file or=
 directory.\x0a
[    1.989764] init: processing action (post-fs) from (/vendor/etc/init/hw/=
init.taimen.rc:221)
[    1.990885] scm_call failed: func id 0x72000206, ret: -1, syscall return=
s: 0x0, 0x0, 0x0
[    1.991772] init: Wait for property took 1ms
[    1.991799] init: processing action (post-fs) from (/system/etc/init/rec=
overy-refresh.rc:1)
[    1.991939] init: starting service 'exec 1 (/system/bin/recovery-refresh=
)'...
[    1.992407] init: processing action (late-fs) from (/init.rc:377)
[    1.993700] init: starting service 'vendor.boot-hal-1-0'...
[    1.994574] init: starting service 'vendor.gatekeeper-1-0'...
[    1.995800] init: starting service 'vendor.keymaster-3-0'...
[    1.996320] init: processing action (late-fs) from (/vendor/etc/init/hw/=
init.taimen.rc:198)
[    1.996811] init: starting service 'vendor.devstart_sh'...
[    1.997433] init: starting service 'surfaceflinger'...
[    1.998007] init: starting service 'bootanim'...
[    1.998980] init: starting service 'vendor.hwcomposer-2-1'...
[    1.999970] init: Created socket '/dev/socket/pdx/system/vr/display/clie=
nt', mode 666, user 1000, group 1003
[    2.000935] init: Created socket '/dev/socket/pdx/system/vr/display/mana=
ger', mode 666, user 1000, group 1003
[    2.001059] init: starting service 'vendor.configstore-hal'...
[    2.001193] init: Created socket '/dev/socket/pdx/system/vr/display/vsyn=
c', mode 666, user 1000, group 1003
[    2.005690] adsp-loader soc:qcom,msm-adsp-loader: adsp_loader_do: schedu=
ling work to load ADSP fw
[    2.005878] sensors-ssc soc:qcom,msm-ssc-sensors: slpi_loader_do: schedu=
ling work to load SLPI fw
[    2.006971] init: starting service 'vendor.gralloc-2-0'...
[    2.007059] subsys-restart: __subsystem_get(): Changing subsys fw_name t=
o slpi_v2
[    2.007564] subsys-pil-tz 17300000.qcom,lpass: adsp: loading from 0x0000=
000000000000 to 0x0000000000000000
[    2.007682] subsys-pil-tz 5c00000.qcom,ssc: slpi: loading from 0x0000000=
000000000 to 0x0000000000000000
[    2.014357] init: Service 'exec 1 (/system/bin/recovery-refresh)' (pid 6=
17) exited with status 254
[    2.017328] logd.auditd: start
[    2.029041] type=3D1400 audit(325955.082:16): avc: denied { sys_admin } =
for pid=3D637 comm=3D"grep" capability=3D21 scontext=3Du:r:init-qcom-devsta=
rt-sh:s0 tcontext=3Du:r:init-qcom-devstart-sh:s0 tclass=3Dcapability permis=
sive=3D0
[    2.030937] type=3D1400 audit(325955.082:16): avc: denied { sys_admin } =
for pid=3D637 comm=3D"grep" capability=3D21 scontext=3Du:r:init-qcom-devsta=
rt-sh:s0 tcontext=3Du:r:init-qcom-devstart-sh:s0 tclass=3Dcapability permis=
sive=3D0
[    2.030964] type=3D1400 audit(325955.088:17): avc: denied { sys_admin } =
for pid=3D638 comm=3D"sed" capability=3D21 scontext=3Du:r:init-qcom-devstar=
t-sh:s0 tcontext=3Du:r:init-qcom-devstart-sh:s0 tclass=3Dcapability permiss=
ive=3D0
[    2.035468] init: Wait for property took 27ms
[    2.037083] init: [libfs_mgr]superblock s_max_mnt_count:65535,/dev/block=
/platform/soc/1da4000.ufshc/by-name/userdata
[    2.037187] init: [libfs_mgr]Filesystem on /dev/block/platform/soc/1da40=
00.ufshc/by-name/userdata was not cleanly shutdown; state flags: 0x1, incom=
pat feature flags: 0x102c6
[    2.037744] SMB138X: smb138x_parallel_get_prop: parallel power supply ge=
t prop 4 not supported
[    2.039120] EXT4-fs (sda13): Ignoring removed nomblk_io_submit option
[    2.050283] type=3D1400 audit(325955.088:17): avc: denied { sys_admin } =
for pid=3D638 comm=3D"sed" capability=3D21 scontext=3Du:r:init-qcom-devstar=
t-sh:s0 tcontext=3Du:r:init-qcom-devstart-sh:s0 tclass=3Dcapability permiss=
ive=3D0
[    2.050302] type=3D1400 audit(325955.108:18): avc: denied { sys_admin } =
for pid=3D643 comm=3D"setprop" capability=3D21 scontext=3Du:r:init-qcom-dev=
start-sh:s0 tcontext=3Du:r:init-qcom-devstart-sh:s0 tclass=3Dcapability per=
missive=3D0
[    2.094311] usbpd0: Log buffer index 37 is NULL
[    2.162342] mdss_fb_blank_sub: mdss_fb_open+0xac/0x1b0 mode:0
[    2.302873] subsys-pil-tz 5c00000.qcom,ssc: slpi: Brought out of reset
[    2.341220] subsys-pil-tz 5c00000.qcom,ssc: Subsystem error monitoring/h=
andling services are up
[    2.341334] sensors-ssc soc:qcom,msm-ssc-sensors: slpi_load_fw: SLPI ima=
ge is loaded
[    2.341740] subsys-pil-tz 5c00000.qcom,ssc: slpi: Power/Clock ready inte=
rrupt received
[    2.341864] IPC_RTR: ipc_router_create_log_ctx: Unable to create IPC log=
ging for [dsps_IPCRTR]
[    2.349320] tas2557s 7-004d: TAS2557 load data: Tuning Mode Program, Blo=
cks =3D 3, Block Type =3D 1
[    2.355635] tas2557s 7-004d: TAS2557 load data: Tuning Mode Program, Blo=
cks =3D 3, Block Type =3D 8
[    2.365658] tas2557s 7-004d: TAS2557 load data: MusicPlayback, Blocks =
=3D 4, Block Type =3D 4
[    2.367112] tas2557s 7-004d: TAS2557 load data: MusicPlayback, Blocks =
=3D 4, Block Type =3D 11
[    2.368562] tas2557s 7-004d: TAS2557 load data: MusicPlayback, Blocks =
=3D 4, Block Type =3D 3
[    2.382193] EXT4-fs (sda13): recovery complete
[    2.382612] EXT4-fs (sda13): mounted filesystem with ordered data mode. =
Opts: errors=3Dremount-ro,nomblk_io_submit
[    2.382724] init: [libfs_mgr]check_fs(): mount(/dev/block/platform/soc/1=
da4000.ufshc/by-name/userdata,/data,ext4)=3D0: Success
[    2.450170] subsys-pil-tz 17300000.qcom,lpass: adsp: Brought out of reset
[    2.460898] apr_tal_link_state_cb: edge[lpass] link state[0]
[    2.462231] subsys-pil-tz 17300000.qcom,lpass: Subsystem error monitorin=
g/handling services are up
[    2.462395] subsys-pil-tz 17300000.qcom,lpass: adsp: Power/Clock ready i=
nterrupt received
[    2.464140] subsys-pil-tz soc:qcom,kgsl-hyp: a540_zap: loading from 0x00=
00000000000000 to 0x0000000000000000
[    2.465884] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:269
[    2.466780] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:269
[    2.474791] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:269
[    2.479479] init: [libfs_mgr]check_fs(): unmount(/data) succeeded
[    2.479768] init: [libfs_mgr]Running /system/bin/e2fsck on /dev/block/pl=
atform/soc/1da4000.ufshc/by-name/userdata
[    2.500627] IPC_RTR: ipc_router_create_log_ctx: Unable to create IPC log=
ging for [lpass_IPCRTR]
[    2.502486] sysmon-qmi: sysmon_clnt_svc_arrive: Connection established b=
etween QMI handle and adsp's SSCTL service
[    2.506217] diag: In socket_open_client, socket not initialized for LPAS=
S_CMD
[    2.506506] type=3D1400 audit(325955.108:18): avc: denied { sys_admin } =
for pid=3D643 comm=3D"setprop" capability=3D21 scontext=3Du:r:init-qcom-dev=
start-sh:s0 tcontext=3Du:r:init-qcom-devstart-sh:s0 tclass=3Dcapability per=
missive=3D0
[    2.506573] type=3D1400 audit(325955.564:19): avc: denied { create } for=
 pid=3D89 comm=3D"kworker/u16:2" scontext=3Du:r:kernel:s0 tcontext=3Du:r:ke=
rnel:s0 tclass=3Dsocket permissive=3D0
[    2.507924] diag: In diag_send_feature_mask_update, control channel is n=
ot open, p: 1, 0000000000000000
[    2.509432] subsys-pil-tz soc:qcom,kgsl-hyp: a540_zap: Brought out of re=
set
[    2.510446] sysmon-qmi: sysmon_clnt_svc_arrive: Connection established b=
etween QMI handle and slpi's SSCTL service
[    2.510805] type=3D1400 audit(325955.564:19): avc: denied { create } for=
 pid=3D89 comm=3D"kworker/u16:2" scontext=3Du:r:kernel:s0 tcontext=3Du:r:ke=
rnel:s0 tclass=3Dsocket permissive=3D0
[    2.510867] type=3D1400 audit(325955.568:20): avc: denied { sys_admin } =
for pid=3D662 comm=3D"e2fsck" capability=3D21 scontext=3Du:r:fsck:s0 tconte=
xt=3Du:r:fsck:s0 tclass=3Dcapability permissive=3D0
[    2.515000] diag: In socket_open_client, socket not initialized for SENS=
ORS_CMD
[    2.515122] type=3D1400 audit(325955.568:20): avc: denied { sys_admin } =
for pid=3D662 comm=3D"e2fsck" capability=3D21 scontext=3Du:r:fsck:s0 tconte=
xt=3Du:r:fsck:s0 tclass=3Dcapability permissive=3D0
[    2.515141] type=3D1400 audit(325955.572:21): avc: denied { create } for=
 pid=3D106 comm=3D"kworker/u16:3" scontext=3Du:r:kernel:s0 tcontext=3Du:r:k=
ernel:s0 tclass=3Dsocket permissive=3D0
[    2.517756] diag: In diag_send_feature_mask_update, control channel is n=
ot open, p: 3, 0000000000000000
[    2.533663] sps_register_bam_device : unable to create IPC Logging 0 for=
 bam 0x0000000000000000
[    2.533675] sps_register_bam_device : unable to create IPC Logging 1 for=
 bam 0x0000000000000000
[    2.533684] sps_register_bam_device : unable to create IPC Logging 2 for=
 bam 0x0000000000000000
[    2.533687] sps_register_bam_device : unable to create IPC Logging 3 for=
 bam 0x0000000000000000
[    2.533693] sps_register_bam_device : unable to create IPC Logging 4 for=
 bam 0x0000000000000000
[    2.533759] sps:BAM 0x0000000000000000 (va:0x0000000000000000) enabled: =
ver:0x19, number of pipes:19
[    2.533764] sps:BAM 0x0000000000000000 is registered.
[    2.537902] sps_register_bam_device : unable to create IPC Logging 0 for=
 bam 0x0000000000000000
[    2.537916] sps_register_bam_device : unable to create IPC Logging 1 for=
 bam 0x0000000000000000
[    2.537920] sps_register_bam_device : unable to create IPC Logging 2 for=
 bam 0x0000000000000000
[    2.537926] sps_register_bam_device : unable to create IPC Logging 3 for=
 bam 0x0000000000000000
[    2.537929] sps_register_bam_device : unable to create IPC Logging 4 for=
 bam 0x0000000000000000
[    2.538006] sps:BAM 0x0000000000000000 (va:0x0000000000000000) enabled: =
ver:0x19, number of pipes:31
[    2.538030] sps:BAM 0x0000000000000000 is registered.
[    2.538413] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:269
[    2.539147] slimbus sb-1: of_slim: invalid E-addr
[    2.539266] wcd-slim tasha-slim-pgd: Platform data from device tree
[    2.539335] wcd-slim tasha-slim-pgd: msm_cdc_dt_parse_vreg_info: cdc-vdd=
-buck: vol=3D[1800000 1800000]uV, curr=3D[650000]uA, ond 0
[    2.539353] wcd-slim tasha-slim-pgd: msm_cdc_dt_parse_vreg_info: cdc-buc=
k-sido: vol=3D[1800000 1800000]uV, curr=3D[250000]uA, ond 0
[    2.539370] wcd-slim tasha-slim-pgd: msm_cdc_dt_parse_vreg_info: cdc-vdd=
-tx-h: vol=3D[1800000 1800000]uV, curr=3D[25000]uA, ond 0
[    2.539387] wcd-slim tasha-slim-pgd: msm_cdc_dt_parse_vreg_info: cdc-vdd=
-rx-h: vol=3D[1800000 1800000]uV, curr=3D[25000]uA, ond 0
[    2.539407] lge_battery: bm_check_status: wake_locked: present[1] chg_st=
ate[1] vbus[0]
[    2.539407] wcd-slim tasha-slim-pgd: msm_cdc_dt_parse_vreg_info: cdc-vdd=
px-1: vol=3D[1800000 1800000]uV, curr=3D[10000]uA, ond 0
[    2.539421] lge_battery: lge_battery_probe: Battery manager driver probe=
 success!
[    2.539756] wcd-slim tasha-slim-pgd: wcd9xxx_slim_probe: probing for wcd=
 type: 2, name: tasha-slim-pgd
[    2.545330] tas2557s 7-004d: TAS2557 load data: MusicPlayback, Blocks =
=3D 4, Block Type =3D 10
[    2.549777] msm8998-asoc-snd 1711a000.sound-tavil: ASoC: CODEC DAI tavil=
_vifeedback not registered
[    2.566618] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:269
[    2.566755] msm-dwc3 a800000.ssusb: dwc3_msm_resume: exiting lpm
[    2.569836] msm-dwc3 a800000.ssusb: DWC3 exited from low power mode
[    2.572443] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:269
[    2.683862] wcd-slim tasha-slim-pgd: wcd9xxx_slim_probe: failed to get s=
limbus tasha-slim-pgd logical address: -6
[    2.686162] wcd-slim tavil-slim-pgd: Platform data from device tree
[    2.686357] wcd-slim tavil-slim-pgd: msm_cdc_dt_parse_vreg_info: cdc-vdd=
-buck: vol=3D[1800000 1800000]uV, curr=3D[650000]uA, ond 0
[    2.686462] wcd-slim tavil-slim-pgd: msm_cdc_dt_parse_vreg_info: cdc-buc=
k-sido: vol=3D[1800000 1800000]uV, curr=3D[250000]uA, ond 0
[    2.686566] wcd-slim tavil-slim-pgd: msm_cdc_dt_parse_vreg_info: cdc-vdd=
-tx-h: vol=3D[1800000 1800000]uV, curr=3D[25000]uA, ond 0
[    2.686670] wcd-slim tavil-slim-pgd: msm_cdc_dt_parse_vreg_info: cdc-vdd=
-rx-h: vol=3D[1800000 1800000]uV, curr=3D[25000]uA, ond 0
[    2.686780] wcd-slim tavil-slim-pgd: msm_cdc_dt_parse_vreg_info: cdc-vdd=
px-1: vol=3D[1800000 1800000]uV, curr=3D[10000]uA, ond 0
[    2.687692] wcd-slim tavil-slim-pgd: wcd9xxx_slim_probe: probing for wcd=
 type: 4, name: tavil-slim-pgd
[    2.696609] tas2557s 7-004d: TAS2557 load data: Calibration Data, Blocks=
 =3D 2, Block Type =3D 3
[    2.699179] tas2557s 7-004d: TAS2557 load data: Calibration Data, Blocks=
 =3D 2, Block Type =3D 10
[    2.734621] slimbus:1 laddr:0xcf, EAPC:0x1:0x50
[    2.735001] wcd-slim tavil-slim-pgd: wcd9xxx_slim_device_up: slim device=
 up, dev_up =3D 1
[    2.735243] slimbus:1 laddr:0xce, EAPC:0x0:0x50
[    2.737512] wcd-slim tavil-slim-pgd: wcd934x_get_codec_info: wcd9xxx chi=
p id major 0x108, minor 0x1
[    2.737567] wcd9xxx_core_res_init: num_irqs =3D 32, num_irq_regs =3D 4
[    2.772309] msm8998-asoc-snd 1711a000.sound-tavil: ASoC: CODEC DAI tavil=
_vifeedback not registered
[    2.773484] mdss_fb_blank_sub: mdss_fb_blank+0x98/0x1b0 mode:0
[    2.773497] fts_touch 5-0049: fts_resume power state : 0
[    2.773499] fts_touch 5-0049: fts_resume: calling resume from active sta=
te, skipping
[    2.773693] lge_battery: bm_vote_fcc_update: vote id[1], set cur[1000000]
[    2.789190] sps:BAM 0x0000000000000000 (va:0x0000000000000000) enabled: =
ver:0x19, number of pipes:18
[    2.792013] tavil_codec tavil_codec: tavil_soc_codec_probe()
[    2.794864] tavil_codec tavil_codec: tavil_dsd_init: DSD unsupported for=
 this codec version
[    2.795073] wcd-dsp-mgr soc:qcom,wcd-dsp-mgr: for wdsp segments only wil=
l be dumped.
[    2.798247] wcd-dsp-mgr soc:qcom,wcd-dsp-mgr: bound tavil_codec (ops 0xf=
fffff91fb5a6b80)
[    2.798530] wcd-dsp-mgr soc:qcom,wcd-dsp-mgr: bound spi2.0 (ops 0xffffff=
91fb5aa420)
[    2.798549] wcd-dsp-mgr soc:qcom,wcd-dsp-mgr: bound soc:qcom,glink-spi-x=
prt-wdsp (ops 0xffffff91fb4674c0)
[    2.810133] msm-pcm-routing soc:qcom,msm-pcm-routing: ASoC: no dapm matc=
h for MI2S_TX --> MI2S_TX --> MultiMedia10 Mixer
[    2.810149] msm-pcm-routing soc:qcom,msm-pcm-routing: ASoC: Failed to ad=
d route MI2S_TX -> MI2S_TX -> MultiMedia10 Mixer
[    2.810395] msm-pcm-routing soc:qcom,msm-pcm-routing: ASoC: no dapm matc=
h for AUX_PCM_TX --> AUX_PCM_TX --> MultiMedia10 Mixer
[    2.810402] msm-pcm-routing soc:qcom,msm-pcm-routing: ASoC: Failed to ad=
d route AUX_PCM_TX -> AUX_PCM_TX -> MultiMedia10 Mixer
[    2.810494] msm-pcm-routing soc:qcom,msm-pcm-routing: ASoC: no dapm matc=
h for SEC_AUX_PCM_TX --> SEC_AUX_PCM_TX --> MultiMedia10 Mixer
[    2.810500] msm-pcm-routing soc:qcom,msm-pcm-routing: ASoC: Failed to ad=
d route SEC_AUX_PCM_TX -> SEC_AUX_PCM_TX -> MultiMedia10 Mixer
[    2.810594] msm-pcm-routing soc:qcom,msm-pcm-routing: ASoC: no dapm matc=
h for TERT_AUX_PCM_TX --> TERT_AUX_PCM_TX --> MultiMedia10 Mixer
[    2.810600] msm-pcm-routing soc:qcom,msm-pcm-routing: ASoC: Failed to ad=
d route TERT_AUX_PCM_TX -> TERT_AUX_PCM_TX -> MultiMedia10 Mixer
[    2.810697] msm-pcm-routing soc:qcom,msm-pcm-routing: ASoC: no dapm matc=
h for QUAT_AUX_PCM_TX --> QUAT_AUX_PCM_TX --> MultiMedia10 Mixer
[    2.810704] msm-pcm-routing soc:qcom,msm-pcm-routing: ASoC: Failed to ad=
d route QUAT_AUX_PCM_TX -> QUAT_AUX_PCM_TX -> MultiMedia10 Mixer
[    2.810950] msm-pcm-routing soc:qcom,msm-pcm-routing: ASoC: no dapm matc=
h for TERT_MI2S_TX --> TERT_MI2S_TX --> MultiMedia10 Mixer
[    2.810957] msm-pcm-routing soc:qcom,msm-pcm-routing: ASoC: Failed to ad=
d route TERT_MI2S_TX -> TERT_MI2S_TX -> MultiMedia10 Mixer
[    2.811050] msm-pcm-routing soc:qcom,msm-pcm-routing: ASoC: no dapm matc=
h for INT2_MI2S_TX --> INT2_MI2S_TX --> MultiMedia10 Mixer
[    2.811058] msm-pcm-routing soc:qcom,msm-pcm-routing: ASoC: Failed to ad=
d route INT2_MI2S_TX -> INT2_MI2S_TX -> MultiMedia10 Mixer
[    2.811138] msm-pcm-routing soc:qcom,msm-pcm-routing: ASoC: no dapm matc=
h for INT3_MI2S_TX --> INT3_MI2S_TX --> MultiMedia10 Mixer
[    2.811145] msm-pcm-routing soc:qcom,msm-pcm-routing: ASoC: Failed to ad=
d route INT3_MI2S_TX -> INT3_MI2S_TX -> MultiMedia10 Mixer
[    3.143107] msm_audrx_init: dev_namesoc:qcom,msm-dai-q6:qcom,msm-dai-q6-=
sb-0-rx
[    3.165207] apr_tal_notify_state: Channel state[0]
[    3.175350] msm8998-asoc-snd 1711a000.sound-tavil: ASoC: no source widge=
t found for Handset 2nd Mic
[    3.175360] msm8998-asoc-snd 1711a000.sound-tavil: ASoC: Failed to add r=
oute Handset 2nd Mic -> direct -> MIC BIAS3
[    3.175406] msm8998-asoc-snd 1711a000.sound-tavil: ASoC: no source widge=
t found for Handset 3rd Mic
[    3.175413] msm8998-asoc-snd 1711a000.sound-tavil: ASoC: Failed to add r=
oute Handset 3rd Mic -> direct -> MIC BIAS4
[    3.175935] msm8998-asoc-snd 1711a000.sound-tavil: ASoC: no sink widget =
found for SpkrLeft IN
[    3.175942] msm8998-asoc-snd 1711a000.sound-tavil: ASoC: Failed to add r=
oute SPK1 OUT -> direct -> SpkrLeft IN
[    3.175989] msm8998-asoc-snd 1711a000.sound-tavil: ASoC: no sink widget =
found for SpkrRight IN
[    3.175996] msm8998-asoc-snd 1711a000.sound-tavil: ASoC: Failed to add r=
oute SPK2 OUT -> direct -> SpkrRight IN
[    3.184602] msm8998-asoc-snd 1711a000.sound-tavil: Sound card msm8998-ta=
vil-taimen-snd-card registered
[    3.760532] IPC_RTR: msm_ipc_router_smd_driver_register Already driver r=
egistered IPCRTR
[    3.760543] IPC_RTR: msm_ipc_router_smd_driver_register Already driver r=
egistered IPCRTR
[    4.431913] e2fsck: e2fsck 1.43.3 (04-Sep-2016)\x0a
[    4.432196] e2fsck: Pass 1: Checking inodes, blocks, and sizes\x0a
[    4.432268] e2fsck: Inode 2229649 extent tree (at level 1) could be shor=
ter.  Fix? yes\x0a
[    4.432327] e2fsck: \x0a
[    4.432386] e2fsck: Pass 1E: Optimizing extent trees\x0a
[    4.432444] e2fsck: Pass 2: Checking directory structure\x0a
[    4.432503] e2fsck: Pass 3: Checking directory connectivity\x0a
[    4.432562] e2fsck: Pass 4: Checking reference counts\x0a
[    4.432619] e2fsck: Pass 5: Checking group summary information\x0a
[    4.432681] e2fsck: [QUOTA WARNING] Usage inconsistent for ID 10162:actu=
al (347222016, 2977) !=3D expected (347226112, 2977)\x0a
[    4.432739] e2fsck: Update quota info for quota type 0? yes\x0a
[    4.432795] e2fsck: \x0a
[    4.432855] e2fsck: [QUOTA WARNING] Usage inconsistent for ID 10162:actu=
al (51445760, 350) !=3D expected (51449856, 350)\x0a
[    4.432914] e2fsck: Update quota info for quota type 1? yes\x0a
[    4.432969] e2fsck: \x0a
[    4.433089] e2fsck: \x0a
[    4.433154] e2fsck: /dev/block/platform/soc/1da4000.ufshc/by-name/userda=
ta: ***** FILE SYSTEM WAS MODIFIED *****\x0a
[    4.433221] e2fsck: /dev/block/platform/soc/1da4000.ufshc/by-name/userda=
ta: 124509/3481600 files (8.1% non-contiguous), 4175554/13902843 blocks\x0a
[    4.433288] e2fsck: e2fsck terminated by exit(1)\x0a
[    4.433833] init: [libfs_mgr]e2fsck returned status 0x100
[    4.434949] init: [libfs_mgr]superblock s_max_mnt_count:65535,/dev/block=
/platform/soc/1da4000.ufshc/by-name/userdata
[    4.459479] EXT4-fs (sda13): mounted filesystem with ordered data mode. =
Opts: errors=3Dpanic,barrier=3D1,noauto_da_alloc
[    4.459828] init: [libfs_mgr]__mount(source=3D/dev/block/platform/soc/1d=
a4000.ufshc/by-name/userdata,target=3D/data,type=3Dext4)=3D0: Success
[    4.460449] init: [libfs_mgr]/data is file encrypted
[    4.462712] init: Keyring created with id 84938200 in process 1
[    4.463543] init: Command 'mount_all /vendor/etc/fstab.${ro.hardware} --=
late' action=3Dlate-fs (/vendor/etc/init/hw/init.taimen.rc:213) took 2427ms=
 and succeeded
[    4.470081] init: starting service 'vendor.time_daemon'...
[    4.475987] init: processing action (late-fs) from (/vendor/etc/init/ini=
t-taimen.rc:1)
[    4.478085] init: Service 'vendor.devstart_sh' (pid 621) exited with sta=
tus 0
[    4.479529] type=3D1400 audit(325955.572:21): avc: denied { create } for=
 pid=3D106 comm=3D"kworker/u16:3" scontext=3Du:r:kernel:s0 tcontext=3Du:r:k=
ernel:s0 tclass=3Dsocket permissive=3D0
[    4.479552] type=3D1400 audit(325957.536:22): avc: denied { sys_admin } =
for pid=3D695 comm=3D"time_daemon" capability=3D21 scontext=3Du:r:time_daem=
on:s0 tcontext=3Du:r:time_daemon:s0 tclass=3Dcapability permissive=3D0
[    4.482279] init: Received control message 'start' for 'bootanim' from p=
id: 622 (/system/bin/surfaceflinger)
[    4.487751] init: processing action (post-fs-data) from (/init.rc:385)
[    4.489150] init: starting service 'vold'...
[    4.494831] init: starting service 'exec 2 (/system/bin/vdc --wait crypt=
fs enablefilecrypto)'...
[    4.496431] init: SVC_EXEC pid 697 (uid 0 gid 0+0 context default) start=
ed; waiting...
[    4.501233] type=3D1400 audit(325957.536:22): avc: denied { sys_admin } =
for pid=3D695 comm=3D"time_daemon" capability=3D21 scontext=3Du:r:time_daem=
on:s0 tcontext=3Du:r:time_daemon:s0 tclass=3Dcapability permissive=3D0
[    4.501259] type=3D1400 audit(325957.559:23): avc: denied { sys_admin } =
for pid=3D697 comm=3D"vdc" capability=3D21 scontext=3Du:r:vdc:s0 tcontext=
=3Du:r:vdc:s0 tclass=3Dcapability permissive=3D0
[    4.566976] vdc: Waited 40ms for vold
[    4.586956] init: Service 'exec 2 (/system/bin/vdc --wait cryptfs enable=
filecrypto)' (pid 697) exited with status 0 waiting took 0.091000 seconds
[    4.588230] init: Setting policy on /data/bootchart
[    4.590516] init: Policy for /data/bootchart set to 557bb22475fd11a5 mod=
es 127/126
[    4.594919] init: Setting policy on /data/misc
[    4.595349] init: Found policy 557bb22475fd11a5 at /data/misc which matc=
hes expected value
[    4.620288] init: Setting policy on /data/local
[    4.620743] init: Found policy 557bb22475fd11a5 at /data/local which mat=
ches expected value
[    4.627672] init: Setting policy on /data/vendor
[    4.628143] init: Found policy 557bb22475fd11a5 at /data/vendor which ma=
tches expected value
[    4.628511] init: Not setting policy on /data/vendor_ce
[    4.629337] init: Not setting policy on /data/vendor_de
[    4.631109] init: Not setting policy on /data/data
[    4.632216] init: Setting policy on /data/app-private
[    4.632599] init: Policy for /data/app-private set to 557bb22475fd11a5 m=
odes 127/126
[    4.632800] init: Setting policy on /data/app-ephemeral
[    4.633160] init: Policy for /data/app-ephemeral set to 557bb22475fd11a5=
 modes 127/126
[    4.634133] init: Setting policy on /data/app-asec
[    4.634422] init: Policy for /data/app-asec set to 557bb22475fd11a5 mode=
s 127/126
[    4.634743] init: Setting policy on /data/app-lib
[    4.635084] init: Policy for /data/app-lib set to 557bb22475fd11a5 modes=
 127/126
[    4.635937] init: Setting policy on /data/app
[    4.637103] init: Found policy 557bb22475fd11a5 at /data/app which match=
es expected value
[    4.638305] init: Setting policy on /data/property
[    4.638615] init: Found policy 557bb22475fd11a5 at /data/property which =
matches expected value
[    4.638972] init: Setting policy on /data/tombstones
[    4.639289] init: Found policy 557bb22475fd11a5 at /data/tombstones whic=
h matches expected value
[    4.640817] init: Setting policy on /data/dalvik-cache
[    4.641277] init: Found policy 557bb22475fd11a5 at /data/dalvik-cache wh=
ich matches expected value
[    4.642281] init: Setting policy on /data/ota
[    4.642646] init: Policy for /data/ota set to 557bb22475fd11a5 modes 127=
/126
[    4.643765] init: Setting policy on /data/ota_package
[    4.644177] init: Policy for /data/ota_package set to 557bb22475fd11a5 m=
odes 127/126
[    4.645322] init: Setting policy on /data/resource-cache
[    4.645710] init: Found policy 557bb22475fd11a5 at /data/resource-cache =
which matches expected value
[    4.645888] init: Not setting policy on /data/lost+found
[    4.646240] init: Setting policy on /data/drm
[    4.646628] init: Found policy 557bb22475fd11a5 at /data/drm which match=
es expected value
[    4.646956] init: Setting policy on /data/mediadrm
[    4.647353] init: Policy for /data/mediadrm set to 557bb22475fd11a5 mode=
s 127/126
[    4.647711] init: Setting policy on /data/anr
[    4.648076] init: Found policy 557bb22475fd11a5 at /data/anr which match=
es expected value
[    4.648483] init: Setting policy on /data/nfc
[    4.648813] init: Found policy 557bb22475fd11a5 at /data/nfc which match=
es expected value
[    4.649728] init: Setting policy on /data/backup
[    4.650098] init: Found policy 557bb22475fd11a5 at /data/backup which ma=
tches expected value
[    4.650448] init: Setting policy on /data/ss
[    4.650822] init: Policy for /data/ss set to 557bb22475fd11a5 modes 127/=
126
[    4.650959] init: Setting policy on /data/system
[    4.651178] init: Found policy 557bb22475fd11a5 at /data/system which ma=
tches expected value
[    4.652361] init: Not setting policy on /data/system_de
[    4.652491] init: Not setting policy on /data/system_ce
[    4.652600] init: Not setting policy on /data/misc_de
[    4.652711] init: Not setting policy on /data/misc_ce
[    4.652816] init: Not setting policy on /data/user
[    4.652926] init: Not setting policy on /data/user_de
[    4.653283] init: Not setting policy on /data/media
[    4.653983] init: Setting policy on /data/media/obb
[    4.654305] init: Found policy 557bb22475fd11a5 at /data/media/obb which=
 matches expected value
[    4.654452] init: Setting policy on /data/cache
[    4.654792] init: Found policy 557bb22475fd11a5 at /data/cache which mat=
ches expected value
[    4.655745] init: starting service 'exec 3 (/system/bin/vdc --wait crypt=
fs init_user0)'...
[    4.656359] init: SVC_EXEC pid 718 (uid 0 gid 0+0 context default) start=
ed; waiting...
[    4.657439] type=3D1400 audit(325957.559:23): avc: denied { sys_admin } =
for pid=3D697 comm=3D"vdc" capability=3D21 scontext=3Du:r:vdc:s0 tcontext=
=3Du:r:vdc:s0 tclass=3Dcapability permissive=3D0
[    4.657451] type=3D1400 audit(1533422720.571:24): avc: denied { sys_admi=
n } for pid=3D718 comm=3D"vdc" capability=3D21 scontext=3Du:r:vdc:s0 tconte=
xt=3Du:r:vdc:s0 tclass=3Dcapability permissive=3D0
[    4.667131] vdc: Waited 0ms for vold
[    4.688334] type=3D1400 audit(1533422720.571:24): avc: denied { sys_admi=
n } for pid=3D718 comm=3D"vdc" capability=3D21 scontext=3Du:r:vdc:s0 tconte=
xt=3Du:r:vdc:s0 tclass=3Dcapability permissive=3D0
[    4.688357] type=3D1400 audit(1533422720.602:25): avc: denied { sys_admi=
n } for pid=3D721 comm=3D"vold_prepare_su" capability=3D21 scontext=3Du:r:v=
old_prepare_subdirs:s0 tcontext=3Du:r:vold_prepare_subdirs:s0 tclass=3Dcapa=
bility permissive=3D0
[    4.710354] init: Service 'exec 3 (/system/bin/vdc --wait cryptfs init_u=
ser0)' (pid 718) exited with status 0 waiting took 0.054000 seconds
[    4.710689] selinux: SELinux: Skipping restorecon_recursive(/data)\x0a
[    4.710931] init: starting service 'exec 4 (/system/bin/tzdatacheck /sys=
tem/usr/share/zoneinfo /data/misc/zoneinfo)'...
[    4.711447] init: SVC_EXEC pid 723 (uid 1000 gid 1000+0 context default)=
 started; waiting...
[    4.724315] init: Service 'exec 4 (/system/bin/tzdatacheck /system/usr/s=
hare/zoneinfo /data/misc/zoneinfo)' (pid 723) exited with status 0 waiting =
took 0.013000 seconds
[    4.724424] init: processing action (post-fs-data) from (/init.magisk.rc=
:1)
[    4.727005] init: starting service 'magisk_startup'...
[    4.860576] logd: logdr: UID=3D0 GID=3D0 PID=3D728 n tail=3D0 logMask=3D=
19 pid=3D0 start=3D0ns timeout=3D0ns
[    4.884089] logd: logdr: UID=3D0 GID=3D0 PID=3D732 n tail=3D0 logMask=3D=
1 pid=3D0 start=3D0ns timeout=3D0ns
[    4.910360] logd: logdr: UID=3D0 GID=3D0 PID=3D737 n tail=3D0 logMask=3D=
4 pid=3D0 start=3D0ns timeout=3D0ns
[    4.926601] logd: logdr: UID=3D0 GID=3D0 PID=3D739 n tail=3D0 logMask=3D=
10 pid=3D0 start=3D0ns timeout=3D0ns
[    4.939539] logd: logdr: UID=3D0 GID=3D0 PID=3D745 b tail=3D0 logMask=3D=
15 pid=3D0 start=3D0ns timeout=3D0ns
[    4.944706] EXT4-fs (loop8): mounted filesystem with ordered data mode. =
Opts: (null)
[    4.945535] type=3D1400 audit(1533422720.602:25): avc: denied { sys_admi=
n } for pid=3D721 comm=3D"vold_prepare_su" capability=3D21 scontext=3Du:r:v=
old_prepare_subdirs:s0 tcontext=3Du:r:vold_prepare_subdirs:s0 tclass=3Dcapa=
bility permissive=3D0
[    4.945547] type=3D1400 audit(1533422720.859:26): avc: denied { check_co=
ntext } for pid=3D727 comm=3D"magisk.bin" scontext=3Du:r:magisk:s0 tcontext=
=3Du:object_r:kernel:s0 tclass=3Dsecurity permissive=3D1
[    4.981589] init: wait for '/dev/.magisk.unblock' took 253ms
[    4.981644] init: Command 'wait /dev/.magisk.unblock 10' action=3Dpost-f=
s-data (/init.magisk.rc:6) took 253ms and succeeded
[    4.981715] init: Service 'magisk_startup' (pid 724) exited with status 0
[    4.981855] init: processing action (post-fs-data) from (/init.usb.rc:6)
[    4.982786] init: Setting policy on /data/adb
[    4.982858] init: Found policy 557bb22475fd11a5 at /data/adb which match=
es expected value
[    4.982874] init: processing action (post-fs-data) from (/vendor/etc/ini=
t/hw/init.taimen.rc:250)
[    4.983163] init: starting service 'netd'...
[    4.984992] init: Created socket '/dev/socket/netd', mode 660, user 0, g=
roup 1000
[    4.985450] init: start_waiting_for_property("sys.time.set", "true"): al=
ready set
[    4.985470] init: processing action (post-fs-data) from (/system/etc/ini=
t/bootstat.rc:7)
[    4.985694] init: Created socket '/dev/socket/dnsproxyd', mode 660, user=
 0, group 3003
[    4.986319] init: Created socket '/dev/socket/mdns', mode 660, user 0, g=
roup 1000
[    4.986859] init: processing action (post-fs-data) from (/system/etc/ini=
t/incidentd.rc:21)
[    4.986918] init: Created socket '/dev/socket/fwmarkd', mode 660, user 0=
, group 3003
[    4.987324] init: processing action (post-fs-data) from (/system/etc/ini=
t/otapreopt.rc:3)
[    4.987470] init: starting service 'exec 5 (/system/bin/otapreopt_slot)'=
=2E..
[    4.988111] init: SVC_EXEC pid 752 (uid 0 gid 0+0 context default) start=
ed; waiting...
[    4.990156] type=3D1400 audit(1533422720.859:26): avc: denied { check_co=
ntext } for pid=3D727 comm=3D"magisk.bin" scontext=3Du:r:magisk:s0 tcontext=
=3Du:object_r:kernel:s0 tclass=3Dsecurity permissive=3D1
[    4.990184] type=3D1400 audit(1533422720.903:27): avc: denied { sys_admi=
n } for pid=3D751 comm=3D"netd" capability=3D21 scontext=3Du:r:netd:s0 tcon=
text=3Du:r:netd:s0 tclass=3Dcapability permissive=3D0
[    4.991257] type=3D1400 audit(1533422720.903:27): avc: denied { sys_admi=
n } for pid=3D751 comm=3D"netd" capability=3D21 scontext=3Du:r:netd:s0 tcon=
text=3Du:r:netd:s0 tclass=3Dcapability permissive=3D0
[    4.991271] type=3D1400 audit(1533422720.905:28): avc: denied { sys_admi=
n } for pid=3D752 comm=3D"otapreopt_slot" capability=3D21 scontext=3Du:r:ot=
apreopt_slot:s0 tcontext=3Du:r:otapreopt_slot:s0 tclass=3Dcapability permis=
sive=3D0
[    5.000146] type=3D1400 audit(1533422720.905:28): avc: denied { sys_admi=
n } for pid=3D752 comm=3D"otapreopt_slot" capability=3D21 scontext=3Du:r:ot=
apreopt_slot:s0 tcontext=3Du:r:otapreopt_slot:s0 tclass=3Dcapability permis=
sive=3D0
[    5.000170] type=3D1400 audit(1533422720.911:29): avc: denied { sys_admi=
n } for pid=3D753 comm=3D"getprop" capability=3D21 scontext=3Du:r:otapreopt=
_slot:s0 tcontext=3Du:r:otapreopt_slot:s0 tclass=3Dcapability permissive=3D0
[    5.027540] init: Service 'exec 5 (/system/bin/otapreopt_slot)' (pid 752=
) exited with status 0 waiting took 0.039000 seconds
[    5.028079] selinux: SELinux: Skipping restorecon_recursive(/data/dalvik=
-cache/arm)\x0a
[    5.028335] selinux: SELinux: Skipping restorecon_recursive(/data/dalvik=
-cache/arm64)\x0a
[    5.028380] selinux: SELinux:  Could not stat /data/dalvik-cache/mips: N=
o such file or directory.\x0a
[    5.028418] selinux: SELinux:  Could not stat /data/dalvik-cache/mips64:=
 No such file or directory.\x0a
[    5.028449] selinux: SELinux:  Could not stat /data/dalvik-cache/x86: No=
 such file or directory.\x0a
[    5.028479] selinux: SELinux:  Could not stat /data/dalvik-cache/x86_64:=
 No such file or directory.\x0a
[    5.028518] init: processing action (post-fs-data) from (/system/etc/ini=
t/recovery-persist.rc:1)
[    5.028977] init: starting service 'exec 6 (/system/bin/recovery-persist=
)'...
[    5.029498] init: processing action (post-fs-data) from (/system/etc/ini=
t/statsd.rc:25)
[    5.030346] init: processing action (post-fs-data) from (/vendor/etc/ini=
t/esed.rc:6)
[    5.031882] init: starting service 'vendor.ese_load'...
[    5.032909] init: processing action (post-fs-data) from (/vendor/etc/ini=
t/hostapd.android.rc:9)
[    5.035509] init: processing action (post-fs-data) from (/vendor/etc/ini=
t/init.taimen.logging.rc:1)
[    5.036617] init: processing action (ro.crypto.state=3Dencrypted && ro.c=
rypto.type=3Dfile && zygote-start) from (/init.rc:575)
[    5.036961] init: starting service 'update_verifier_nonencrypted'...
[    5.038346] init: SVC_EXEC pid 761 (uid 0 gid 2001+1 context default) st=
arted; waiting...
[    5.038480] init: Service 'exec 6 (/system/bin/recovery-persist)' (pid 7=
58) exited with status 0
[    5.049646] update_verifier: Started with arg 1: nonencrypted
[    5.052283] update_verifier: Booting slot 0: isSlotMarkedSuccessful=3D1
[    5.052300] update_verifier: Leaving update_verifier.
[    5.053260] init: Service 'update_verifier_nonencrypted' (pid 761) exite=
d with status 0 waiting took 0.015000 seconds
[    5.053902] init: starting service 'zygote'...
[    5.054986] init: starting service 'zygote_secondary'...
[    5.055279] init: Created socket '/dev/socket/zygote', mode 660, user 0,=
 group 1000
[    5.056228] init: processing action (zygote-start) from (/vendor/etc/ini=
t/hw/init.taimen.rc:268)
[    5.056480] init: Created socket '/dev/socket/zygote_secondary', mode 66=
0, user 0, group 1000
[    5.057255] init: Setting policy on /data/tombstones
[    5.057437] init: Found policy 557bb22475fd11a5 at /data/tombstones whic=
h matches expected value
[    5.062162] init: Not setting policy on /data/media
[    5.069652] init: Setting policy on /data/hostapd
[    5.070683] init: Policy for /data/hostapd set to 557bb22475fd11a5 modes=
 127/126
[    5.071198] wlan: Loading driver v5.2.1.1J.1 ()
[    5.072791] wlan_hdd_state wlan major(227) initialized
[    5.072798] wlan: driver loaded
[    5.074198] init: Setting policy on /data/connectivity
[    5.074726] init: Policy for /data/connectivity set to 557bb22475fd11a5 =
modes 127/126
[    5.075301] init: Setting policy on /data/dpm
[    5.075757] init: Found policy 557bb22475fd11a5 at /data/dpm which match=
es expected value
[    5.085381] init: processing action (load_persist_props_action) from (/i=
nit.rc:269)
[    5.129492] pn81a spi1.0: ese_open: NFC controller found
[    5.130677] nq-nci 8-0028: setting ese_gpio high
[    5.182393] init: Init cannot set 'ro.persistent_properties.ready' to 't=
rue': Read-only property was already set
[    5.182460] init: Command 'load_persist_props' action=3Dload_persist_pro=
ps_action (/init.rc:270) took 97ms and succeeded
[    5.182534] init: Service 'vendor.ese_load' (pid 759) exited with status=
 1
[    5.182796] init: starting service 'logd-reinit'...
[    5.183376] init: processing action (firmware_mounts_complete) from (/in=
it.rc:275)
[    5.183423] init: processing action (early-boot) from (/vendor/etc/init/=
hw/init.taimen.rc:403)
[    5.183565] init: start_waiting_for_property("sys.qcom.devup", "1"): alr=
eady set
[    5.183634] init: start_waiting_for_property("sys.all.modules.ready", "1=
"): already set
[    5.184712] init: [libfs_mgr]Failed to query DM_TABLE_STATUS for vroot: =
No such device or address
[    5.187053] init: processing action (early-boot) from (/vendor/etc/init/=
hw/init.wahoo.usb.rc:17)
[    5.187238] init: Command 'mount configfs none /config' action=3Dearly-b=
oot (/vendor/etc/init/hw/init.wahoo.usb.rc:18) took 0ms and failed: mount()=
 failed: Device or resource busy
[    5.188873] Mass Storage Function, version: 2009/09/11
[    5.188885] LUN: removable file: (no medium)
[    5.191409] logd.daemon: reinit
[    5.194464] init: Service 'logd-reinit' (pid 788) exited with status 0
[    5.195274] file system registered
[    5.196970] f_cdev_alloc: port_name:at_usb0 (0000000000000000) portno:(0)
[    5.197973] f_cdev_alloc: port_name:at_usb1 (0000000000000000) portno:(1)
[    5.202897] init: processing action (early-boot) from (/system/etc/init/=
installd.rc:5)
[    5.207679] init: processing action (boot) from (/init.rc:582)
[    5.210528] init: starting service 'vendor.thermal-engine'...
[    5.211529] init: starting service 'hidl_memory'...
[    5.211631] init: Created socket '/dev/socket/thermal-send-client', mode=
 666, user 1000, group 1000
[    5.211930] init: Created socket '/dev/socket/thermal-recv-client', mode=
 660, user 1000, group 1000
[    5.212222] init: starting service 'healthd'...
[    5.212282] init: Created socket '/dev/socket/thermal-recv-passive-clien=
t', mode 666, user 1000, group 1000
[    5.212790] init: starting service 'vr_hwc'...
[    5.213865] init: starting service 'vendor.audio-hal-2-0'...
[    5.218011] init: starting service 'vendor.bluetooth-1-0'...
[    5.220789] init: starting service 'vendor.camera-provider-2-4'...
[    5.222315] init: starting service 'vendor.cas-hal-1-0'...
[    5.223397] init: starting service 'vendor.contexthub-hal-1-0'...
[    5.223629] init: couldn't write 798 to /dev/cpuset/camera-daemon/tasks:=
 No such file or directory
[    5.224442] init: starting service 'vendor.drm-hal-1-0'...
[    5.227562] init: starting service 'vendor.drm-clearkey-hal-1-1'...
[    5.229117] init: starting service 'vendor.drm-widevine-hal-1-1'...
[    5.231590] init: starting service 'vendor.dumpstate-1-0'...
[    5.232877] init: starting service 'vendor.gnss_service'...
[    5.234229] init: starting service 'vendor.health-hal-2-0'...
[    5.236376] init: starting service 'vendor.light-hal-2-0'...
[    5.238010] init: Opened file '/dev/kmsg', flags 1
[    5.240476] init: starting service 'vendor.memtrack-hal-1-0'...
[    5.244570] init: starting service 'nfc_hal_service'...
[    5.247293] init: starting service 'vendor.oemlock_hal'...
[    5.251418] init: starting service 'vendor.oemlock_bridge'...
[    5.255153] init: starting service 'vendor.power-hal-1-2'...
[    5.257078] init: starting service 'vendor.sensors-hal-1-0'...
[    5.260052] init: starting service 'vendor.usb-hal-1-1'...
[    5.262411] init: starting service 'vendor.vibrator-1-2'...
[    5.263863] init: Created socket '/dev/socket/oemlock', mode 666, user 1=
000, group 1000
[    5.264439] init: starting service 'vendor.vr-wahoo-1-0'...
[    5.266058] init: starting service 'vendor.wifi_hal_legacy'...
[    5.268177] init: starting service 'vendor.esed'...
[    5.269737] init: Command 'class_start hal' action=3Dboot (/init.rc:677)=
 took 59ms and succeeded
[    5.273794] init: starting service 'vendor.msm_irqbalance'...
[    5.278504] init: starting service 'vendor.per_mgr'...
[    5.281169] init: starting service 'vendor.sensors'...
[    5.282511] init: starting service 'vendor.irsc_util'...
[    5.286208] init: starting service 'vendor.rmt_storage'...
[    5.290257] init: starting service 'vendor.tftp_server'...
[    5.293580] init: starting service 'vendor.pd_mapper'...
[    5.294564] init: starting service 'audioserver'...
[    5.295479] init: starting service 'bufferhubd'...
[    5.296289] init: starting service 'lmkd'...
[    5.300292] init: starting service 'performanced'...
[    5.301183] init: starting service 'thermalservice'...
[    5.301857] init: starting service 'virtual_touchpad'...
[    5.302281] healthd: Unknown power supply type 'Wipower'
[    5.302331] healthd: Unknown power supply type 'BMS'
[    5.302433] healthd: Unknown power supply type 'Main'
[    5.302508] healthd: Unknown power supply type 'Parallel'
[    5.302520] init: processing action (boot) from (/init.usb.rc:21)
[    5.302649] init: processing action (persist.sys.usb.config=3D* && boot)=
 from (/init.usb.rc:102)
[    5.302682] init: processing action (boot) from (/vendor/etc/init/hw/ini=
t.taimen.rc:445)
[    5.304691] init: Created socket '/dev/socket/lmkd', mode 660, user 1000=
, group 1000
[    5.305161] init: Created socket '/dev/socket/msm_irqbalance', mode 660,=
 user 0, group 1000
[    5.324794] init: Created socket '/dev/socket/pdx/system/buffer_hub/clie=
nt', mode 660, user 1000, group 1000
[    5.332313] init: Service 'vendor.irsc_util' (pid 823) exited with statu=
s 0
[    5.333178] init: processing action (boot) from (/vendor/etc/init/hw/ini=
t.wahoo.usb.rc:57)
[    5.333429] init: processing action (boot) from (/system/etc/init/bootst=
at.rc:61)
[    5.333453] init: processing action (boot) from (/system/etc/init/dumpst=
ate.rc:1)
[    5.333528] init: processing action (boot) from (/vendor/etc/init/androi=
d.hardware.dumpstate@1.0-service.wahoo.rc:7)
[    5.333638] init: processing action (boot) from (/vendor/etc/init/androi=
d.hardware.usb@1.1-service.wahoo.rc:6)
[    5.334000] nq-nci 8-0028: setting ese_gpio high
[    5.334156] init: processing action (boot) from (/vendor/etc/init/init-t=
aimen.rc:27)
[    5.334342] init: processing action (enable_property_trigger) from (<Bui=
ltin Action>:0)
[    5.334499] init: processing action (security.perf_harden=3D1) from (/in=
it.rc:736)
[    5.334736] init: processing action (sys.listeners.registered=3Dtrue) fr=
om (/vendor/etc/init/hw/init.taimen.rc:246)
[    5.338669] init: Created socket '/dev/socket/pdx/system/performance/cli=
ent', mode 666, user 1000, group 1000
[    5.368126] init: starting service 'vendor.ipastart_sh'...
[    5.368728] init: processing action (init.svc.zygote=3Drunning) from (/v=
endor/etc/init/hw/init.taimen.rc:520)
[    5.369099] init: starting service 'vendor.folio_daemon'...
[    5.369421] healthd: Unknown power supply type 'Wipower'
[    5.369465] healthd: Unknown power supply type 'BMS'
[    5.369571] healthd: Unknown power supply type 'Main'
[    5.369658] healthd: Unknown power supply type 'Parallel'
[    5.369694] init: processing action (persist.sys.ssr.restart_level=3D*) =
=66rom (/vendor/etc/init/hw/init.taimen.rc:541)
[    5.373575] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    5.374071] healthd: battery l=3D96 v=3D4369 t=3D27.0 h=3D2 st=3D2 c=3D-=
402 fc=3D3680000 cc=3D25 chg=3Du
[    5.374399] init: starting service 'vendor.ssr_setup'...
[    5.375143] init: processing action (init.svc.vendor.per_mgr=3Drunning) =
=66rom (/vendor/etc/init/hw/init.taimen.rc:628)
[    5.377442] servloc: service_locator_svc_arrive: Connection established =
with the Service locator
[    5.377457] servloc: init_service_locator: Service locator initialized
[    5.377678] servloc: service_locator_send_msg: No matching domains found
[    5.377683] servloc: service_locator_send_msg: No matching domains found
[    5.377687] error locating audio-PD
[    5.377690] audio-PDs matched:0
[    5.377691] servloc: service_locator_send_msg: No matching domains found
[    5.377701] audio_pdr_locator_callback: Service avs/audio returned inval=
id total domains 0
[    5.377701] audio_notifer_reg_service: service SSR_ADSP is in use
[    5.377702] error locating audio-PD
[    5.377706] audio-PDs matched:0
[    5.381486] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    5.381914] healthd: battery l=3D96 v=3D4369 t=3D27.0 h=3D2 st=3D2 c=3D-=
402 fc=3D3680000 cc=3D25 chg=3Du
[    5.382818] init: starting service 'vendor.per_proxy'...
[    5.383533] init: processing action (ro.boot.bootreason=3D*) from (/syst=
em/etc/init/bootstat.rc:4)
[    5.383692] init: processing action (persist.traced.enable=3D1) from (/s=
ystem/etc/init/perfetto.rc:48)
[    5.385575] init: starting service 'traced'...
[    5.386520] init: starting service 'traced_probes'...
[    5.387458] init: processing action (ro.boot.slot_suffix=3D*) from (/sys=
tem/etc/init/update_engine.rc:8)
[    5.387489] init: processing action (sys.all.modules.ready=3D1) from (/v=
endor/etc/init/init-taimen.rc:37)
[    5.388135] fts_touch 5-0049: [fw_update] try:1
[    5.388149] fts_touch 5-0049: fts_fw_update : firmware name : ftm4_fw.ftb
[    5.391360] fts_touch 5-0049: fts_fw_compare: bin_fw_ver_addr_1 =3D 0x00=
01CA7C , bin_fw_ver_addr_2 =3D 0x0001CA7D
[    5.391379] fts_touch 5-0049: fts_fw_compare : binary[0.44.0] device[0.4=
4.0] -> update: 0
[    5.391386] fts_touch 5-0049: fts_fw_update : skip fw_upgrade(ic_fw_ver =
=3D=3D bin_fw_ver)
[    5.392837] init: Opened file '/dev/kmsg', flags 1
[    5.393662] init: processing action (persist.vendor.charge.stop.level=3D=
* && sys.all.modules.ready=3D1) from (/vendor/etc/init/init-taimen.rc:44)
[    5.395194] init: processing action (persist.vendor.charge.start.level=
=3D* && sys.all.modules.ready=3D1) from (/vendor/etc/init/init-taimen.rc:47)
[    5.396219] init: processing action (nonencrypted) from (/init.rc:681)
[    5.396291] init: Could not start service 'flash_recovery' as part of cl=
ass 'main': Cannot find '/system/bin/install-recovery.sh': No such file or =
directory
[    5.398340] init: Created socket '/dev/socket/traced_consumer', mode 666=
, user 0, group 0
[    5.399006] ipa ipa3_uc_state_check:302 uC interface not initialized
[    5.399154] init: starting service 'vendor.adsprpcd'...
[    5.399158] init: Created socket '/dev/socket/traced_producer', mode 666=
, user 0, group 0
[    5.404916] init: starting service 'vendor.imsqmidaemon'...
[    5.405966] init: Could not start service 'vendor.qmuxd' as part of clas=
s 'main': Cannot find '/vendor/bin/qmuxd': No such file or directory
[    5.408937] init: starting service 'vendor.cnd'...
[    5.412302] init: Created socket '/dev/socket/ims_qmid', mode 660, user =
1000, group 1001
[    5.415187] init: starting service 'vendor.netmgrd'...
[    5.421572] init: starting service 'vendor.port-bridge'...
[    5.423711] subsys-pil-tz soc:qcom,ipa_fws@1e08000: ipa_fws: loading fro=
m 0x0000000000000000 to 0x0000000000000000
[    5.425308] init: starting service 'vendor.ipacm'...
[    5.429477] init: starting service 'vendor.qti'...
[    5.456760] init: starting service 'cameraserver'...
[    5.462895] 'opened /dev/adsprpc-smd c 228 0'
[    5.463560] init: starting service 'drm'...
[    5.469085] init: couldn't write 936 to /dev/cpuset/camera-daemon/tasks:=
 No such file or directory
[    5.473665] init: starting service 'incidentd'...
[    5.476183] subsys-restart: __subsystem_get(): Changing subsys fw_name t=
o modem
[    5.477710] init: starting service 'installd'...
[    5.480202] init: starting service 'keystore'...
[    5.483965] init: starting service 'mediadrm'...
[    5.484148] ueventd: firmware: loading 'modem.mdt' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.mdt'
[    5.486276] msm_thermal:set_enabled enabled =3D 0
[    5.486511] init: starting service 'mediaextractor'...
[    5.486916] msm_thermal:store_cpus_offlined "thermal-engine"(PID:923) re=
quest cpus offlined mask 0
[    5.488681] init: starting service 'mediametrics'...
[    5.489111] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.mdt took 5ms
[    5.489310] pil-q6v5-mss 4080000.qcom,mss: modem: loading from 0x0000000=
000000000 to 0x0000000000000000
[    5.491657] init: starting service 'media'...
[    5.514886] init: starting service 'statsd'...
[    5.518121] init: starting service 'storaged'...
[    5.519289] ueventd: firmware: loading 'mba.mbn' for '/devices/soc/40800=
00.qcom,mss/firmware/mba.mbn'
[    5.520103] init: starting service 'wificond'...
[    5.522600] init: Failed to open file '/d/mmc0/mmc0:0001/ext_csd': No su=
ch file or directory
[    5.525702] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mba.=
mbn took 28ms
[    5.525936] init: starting service 'vendor.media.omx'...
[    5.529610] init: starting service 'vendor.ril-daemon'...
[    5.530544] init: Command 'class_start main' action=3Dnonencrypted (/ini=
t.rc:682) took 134ms and succeeded
[    5.531270] init: Service 'vendor.ssr_setup' (pid 871) exited with statu=
s 0
[    5.531703] init: starting service 'magisk_service'...
[    5.532693] init: starting service 'vendor.init-elabel-sh'...
[    5.537808] init: Created socket '/dev/socket/statsdw', mode 222, user 1=
066, group 1066
[    5.545484] ueventd: firmware: loading 'msadp' for '/devices/soc/4080000=
=2Eqcom,mss/firmware/msadp'
[    5.545715] ueventd: firmware: could not find firmware for msadp
[    5.546440] pil-q6v5-mss 4080000.qcom,mss: Debug policy not present - ms=
adp. Continue.
[    5.546476] pil-q6v5-mss 4080000.qcom,mss: Loading MBA and DP (if presen=
t) from 0x0000000000000000 to 0x0000000000000000 size 100000
[    5.547661] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/msad=
p took 2ms
[    5.550410] init: starting service 'vendor.init-radio-sh'...
[    5.552957] init: starting service 'vendor.cnss-daemon'...
[    5.559225] init: starting service 'vendor.loc_launcher'...
[    5.569409] subsys-pil-tz soc:qcom,ipa_fws@1e08000: ipa_fws: Brought out=
 of reset
[    5.570719] init: starting service 'vendor.chre'...
[    5.571320] ipa ipa3_uc_state_check:302 uC interface not initialized
[    5.573799] init: starting service 'gatekeeperd'...
[    5.576921] init: starting service 'tombstoned'...
[    5.579049] init: starting service 'update_engine'...
[    5.590649] ipa ipa3_uc_state_check:302 uC interface not initialized
[    5.592730] gsi soc:qcom,msm_gsi: gsi_register_device:766 GSI irq is wak=
e enabled 43
[    5.595309] init: Created socket '/dev/socket/chre', mode 660, user 0, g=
roup 1000
[    5.597162] init: starting service 'usbd'...
[    5.606568] init: Created socket '/dev/socket/tombstoned_crash', mode 66=
6, user 1000, group 1000
[    5.607247] init: Created socket '/dev/socket/tombstoned_intercept', mod=
e 666, user 1000, group 1000
[    5.607769] init: Created socket '/dev/socket/tombstoned_java_trace', mo=
de 666, user 1000, group 1000
[    5.611234] init: starting service 'fps_hal'...
[    5.620274] init: Command 'class_start late_start' action=3Dnonencrypted=
 (/init.rc:683) took 88ms and succeeded
[    5.621743] pil-q6v5-mss 4080000.qcom,mss: MBA boot done
[    5.625936] init: processing action (init.svc.mediadrm=3Drunning) from (=
/vendor/etc/init/android.hardware.drm@1.1-service.widevine.rc:1)
[    5.638962] init: Service 'vendor.ipastart_sh' (pid 864) exited with sta=
tus 0
[    5.639375] init: Service 'vendor.init-elabel-sh' (pid 974) exited with =
status 0
[    5.640179] init: starting service 'vendor.move_data_sh'...
[    5.644638] init: processing action (vendor.ims.QMI_DAEMON_STATUS=3D1) f=
rom (/vendor/etc/init/hw/init.taimen.rc:723)
[    5.660238] ueventd: firmware: loading 'modem.b02' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b02'
[    5.661110] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b02 took 0ms
[    5.678061] 'opened /dev/sdsprpc-smd c 228 2'
[    5.679806] init: starting service 'vendor.imsdatadaemon'...
[    5.695755] init: Created socket '/dev/socket/ims_datad', mode 660, user=
 1000, group 1001
[    5.698744] init: Service 'vendor.move_data_sh' (pid 999) exited with st=
atus 0
[    5.712933] type=3D1400 audit(1533422720.911:29): avc: denied { sys_admi=
n } for pid=3D753 comm=3D"getprop" capability=3D21 scontext=3Du:r:otapreopt=
_slot:s0 tcontext=3Du:r:otapreopt_slot:s0 tclass=3Dcapability permissive=3D0
[    5.712957] type=3D1400 audit(1533422721.626:49): avc: denied { sys_admi=
n } for pid=3D1012 comm=3D"iptables-wrappe" capability=3D21 scontext=3Du:r:=
netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability =
permissive=3D0
[    5.732554] ueventd: firmware: loading 'modem.b03' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b03'
[    5.734302] init: Service 'magisk_service' (pid 973) exited with status 0
[    5.738390] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b03 took 5ms
[    5.742989] init: Received control message 'start' for 'adbd' from pid: =
989 (/system/bin/usbd)
[    5.743046] init: starting service 'adbd'...
[    5.749641] init: Created socket '/dev/socket/adbd', mode 660, user 1000=
, group 1000
[    5.751480] init: Service 'usbd' (pid 989) exited with status 0
[    5.755314] ueventd: firmware: loading 'modem.b04' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b04'
[    5.758811] type=3D1400 audit(1533422721.626:49): avc: denied { sys_admi=
n } for pid=3D1012 comm=3D"iptables-wrappe" capability=3D21 scontext=3Du:r:=
netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability =
permissive=3D0
[    5.758833] type=3D1400 audit(1533422721.672:50): avc: denied { sys_admi=
n } for pid=3D1033 comm=3D"adbd" capability=3D21 scontext=3Du:r:adbd:s0 tco=
ntext=3Du:r:adbd:s0 tclass=3Dcapability permissive=3D0
[    5.771387] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b04 took 16ms
[    5.782919] ueventd: firmware: loading 'modem.b05' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b05'
[    5.783510] IPA driver initialization was successful.
[    5.783526] rmnet_ipa3 started initialization
[    5.783533] IPA SSR support =3D True
[    5.783538] IPA ipa-loaduC =3D True
[    5.783542] IPA SG support =3D True
[    5.783547] IPA Napi Enable =3D False
[    5.783552] using default for wan-rx-desc-size =3D 256
[    5.794834] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b05 took 11ms
[    5.797814] netmgrd: groups: 0x40000000 ngroups: 64
[    5.799993] ueventd: firmware: loading 'modem.b06' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b06'
[    5.803535] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b06 took 3ms
[    5.807153] ipa ipa3_uc_state_check:307 uC is not loaded
[    5.809487] rmnet_ipa completed initialization
[    5.809725] type=3D1400 audit(1533422721.672:50): avc: denied { sys_admi=
n } for pid=3D1033 comm=3D"adbd" capability=3D21 scontext=3Du:r:adbd:s0 tco=
ntext=3Du:r:adbd:s0 tclass=3Dcapability permissive=3D0
[    5.809743] type=3D1400 audit(1533422721.723:51): avc: denied { sys_admi=
n } for pid=3D1059 comm=3D"tc-wrapper-1.0" capability=3D21 scontext=3Du:r:n=
etutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability p=
ermissive=3D0
[    5.815284] read descriptors
[    5.815396] read strings
[    5.821005] ueventd: firmware: loading 'modem.b07' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b07'
[    5.829554] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b07 took 8ms
[    5.831165] type=3D1400 audit(1533422721.723:51): avc: denied { sys_admi=
n } for pid=3D1059 comm=3D"tc-wrapper-1.0" capability=3D21 scontext=3Du:r:n=
etutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability p=
ermissive=3D0
[    5.831190] type=3D1400 audit(1533422721.744:52): avc: denied { sys_admi=
n } for pid=3D1059 comm=3D"tc" capability=3D21 scontext=3Du:r:netutils_wrap=
per:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permissive=3D0
[    5.835216] QSEECOM: qseecom_load_app: App (fpctzappfingerprint) does'nt=
 exist, loading apps for first time
[    5.842564] ueventd: firmware: loading 'modem.b08' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b08'
[    5.848612] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b08 took 6ms
[    5.861483] type=3D1400 audit(1533422721.744:52): avc: denied { sys_admi=
n } for pid=3D1059 comm=3D"tc" capability=3D21 scontext=3Du:r:netutils_wrap=
per:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permissive=3D0
[    5.861507] type=3D1400 audit(1533422721.775:53): avc: denied { sys_admi=
n } for pid=3D1080 comm=3D"tc-wrapper-1.0" capability=3D21 scontext=3Du:r:n=
etutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability p=
ermissive=3D0
[    5.861975] ueventd: firmware: loading 'modem.b09' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b09'
[    5.880803] init: Received control message 'interface_start' for 'androi=
d.hardware.camera.provider@2.4::ICameraProvider/legacy/0' from pid: 606 (/s=
ystem/bin/hwservicemanager)
[    5.880832] init: Could not find service hosting interface android.hardw=
are.camera.provider@2.4::ICameraProvider/legacy/0
[    5.887693] init: Received control message 'interface_start' for 'androi=
d.hardware.camera.provider@2.4::ICameraProvider/legacy/0' from pid: 606 (/s=
ystem/bin/hwservicemanager)
[    5.887719] init: Could not find service hosting interface android.hardw=
are.camera.provider@2.4::ICameraProvider/legacy/0
[    5.907552] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b09 took 45ms
[    5.921045] ueventd: firmware: loading 'modem.b10' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b10'
[    5.921550] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b10 took 0ms
[    5.928687] ueventd: firmware: loading 'modem.b11' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b11'
[    5.945802] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b11 took 17ms
[    5.946598] QSEECOM: qseecom_load_app: App with id 196611 (fpctzappfinge=
rprint) now loaded
[    5.947773] ueventd: firmware: loading 'modem.b12' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b12'
[    5.950166] input: uinput-fpc as /devices/virtual/input/input6
[    5.961387] msm_qti_pp_get_rms_value_control, back not active to query r=
ms be_idx:3
[    5.964930] msm_pm_qos_add_request: add request
[    5.965956] msm_voice_sound_focus_get: Error getting Sound Focus Params,=
 err=3D-22
[    5.966299] msm_voice_source_tracking_get: Error getting Source Tracking=
 Params, err=3D-22
[    5.966409] msm_audio_get_copp_idx_from_port_id: Invalid FE, exiting
[    5.966414] msm_audio_sound_focus_get: Could not get copp idx for port_i=
d=3D16385
[    5.966507] msm_audio_get_copp_idx_from_port_id: Invalid FE, exiting
[    5.966513] msm_audio_source_tracking_get: Could not get copp idx for po=
rt_id=3D16385
[    5.966606] msm_voice_sound_focus_get: Error getting Sound Focus Params,=
 err=3D-22
[    5.966694] msm_voice_source_tracking_get: Error getting Source Tracking=
 Params, err=3D-22
[    5.966785] msm_audio_get_copp_idx_from_port_id: Invalid FE, exiting
[    5.966789] msm_audio_sound_focus_get: Could not get copp idx for port_i=
d=3D4101
[    5.966887] msm_audio_get_copp_idx_from_port_id: Invalid FE, exiting
[    5.966891] msm_audio_source_tracking_get: Could not get copp idx for po=
rt_id=3D4101
[    5.966981] msm_voice_sound_focus_get: Error getting Sound Focus Params,=
 err=3D-22
[    5.967044] input: uinput-folio as /devices/virtual/input/input7
[    5.967094] msm_voice_source_tracking_get: Error getting Source Tracking=
 Params, err=3D-22
[    5.967192] msm_audio_get_copp_idx_from_port_id: Invalid FE, exiting
[    5.967196] msm_audio_sound_focus_get: Could not get copp idx for port_i=
d=3D4149
[    5.967287] msm_audio_get_copp_idx_from_port_id: Invalid FE, exiting
[    5.967291] msm_audio_source_tracking_get: Could not get copp idx for po=
rt_id=3D4149
[    5.967862] core_get_license_status: cmdrsp_license_result.result =3D 0x=
15 for module 0x131ff
[    5.968481] msm-ext-disp-audio-codec-rx soc:qcom,msm_ext_disp:qcom,msm-e=
xt-disp-audio-codec-rx: msm_ext_disp_audio_type_get: codec_data, get_audio_=
edid_blk() or get_intf_id is NULL
[    5.971361] tas2557s 7-004d: tas2557_calibration_get =3D 0
[    5.974911] msm_sensor_fill_eeprom_subdevid_by_name:216 Eeprom userspace=
 probe for onsemi_lc898123f40xc
[    5.978054] msm_dai_q6_ext_disp_drift_get:  afe port not started. status=
_mask =3D 0
[    5.978406] msm_dai_q6_ext_disp_drift_get:  afe port not started. status=
_mask =3D 0
[    5.979950] msm_pcm_volume_ctl_get substream runtime not found
[    5.980064] msm_pcm_compress_ctl_get substream runtime not found
[    5.980249] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    5.980664] msm_pcm_volume_ctl_get substream runtime not found
[    5.980856] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    5.981064] msm_pcm_volume_ctl_get substream runtime not found
[    5.981163] msm_pcm_volume_ctl_get substream runtime not found
[    5.981823] msm_compr_audio_effects_config_get: stream or effects inacti=
ve
[    5.982043] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    5.982874] msm_pcm_volume_ctl_get substream runtime not found
[    5.982975] msm_pcm_compress_ctl_get substream runtime not found
[    5.983186] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    5.983504] msm_compr_audio_effects_config_get: stream or effects inacti=
ve
[    5.983696] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    5.984536] msm_pcm_volume_ctl_get substream runtime not found
[    5.984739] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    5.984935] msm_pcm_volume_ctl_get substream runtime not found
[    5.985046] msm_pcm_volume_ctl_get substream runtime not found
[    5.986752] msm_pcm_volume_ctl_get substream runtime not found
[    5.986946] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    5.987158] msm_compr_audio_effects_config_get: stream or effects inacti=
ve
[    5.987348] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    5.987946] msm_compr_audio_effects_config_get: stream or effects inacti=
ve
[    5.988146] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    5.988747] msm_compr_audio_effects_config_get: stream or effects inacti=
ve
[    5.988940] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    5.989554] msm_compr_audio_effects_config_get: stream or effects inacti=
ve
[    5.989747] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    5.990359] msm_compr_audio_effects_config_get: stream or effects inacti=
ve
[    5.990548] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    5.991162] msm_compr_audio_effects_config_get: stream or effects inacti=
ve
[    5.991350] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    5.991850] msm_pcm_volume_ctl_get substream or runtime not found
[    6.002214] msm_cci_init:1428: hw_version =3D 0x10060000
[    6.002508] msm_sensor_power_up: [08-04 22:45:21.916] imx362
[    6.002518] imx362 probe succeeded
[    6.003409] msm_sensor_power_down: [08-04 22:45:21.917] imx362
[    6.007405] audit_log_lost: 17 callbacks suppressed
[    6.007419] audit: audit_lost=3D33 audit_rate_limit=3D5 audit_backlog_li=
mit=3D64
[    6.007427] audit: rate limit exceeded
[    6.019119] msm-dwc3 a800000.ssusb: Avail curr from USB =3D 100
[    6.024725] init: Service 'vendor.init-radio-sh' (pid 978) exited with s=
tatus 0
[    6.028176] msm_sensor_fill_eeprom_subdevid_by_name:216 Eeprom userspace=
 probe for primax_g802l
[    6.040804] msm_cci_init:1428: hw_version =3D 0x10060000
[    6.041014] msm_sensor_power_up: [08-04 22:45:21.954] imx179
[    6.041034] imx179 probe succeeded
[    6.041597] msm_sensor_power_down: [08-04 22:45:21.955] imx179
[    6.054882] msm_csid_init: CSID_VERSION =3D 0x30050000
[    6.055653] msm_csid_irq CSID0_IRQ_STATUS_ADDR =3D 0x800
[    6.056406] msm_csid_init: CSID_VERSION =3D 0x30050000
[    6.057167] msm_csid_irq CSID2_IRQ_STATUS_ADDR =3D 0x800
[    6.060593] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b12 took 112ms
[    6.061782] ueventd: firmware: loading 'modem.b13' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b13'
[    6.064920] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b13 took 3ms
[    6.067764] ueventd: firmware: loading 'modem.b14' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b14'
[    6.068881] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b14 took 1ms
[    6.069868] ueventd: firmware: loading 'modem.b16' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b16'
[    6.071404] SELinux: 65536 avtab hash slots, 174043 rules.
[    6.074650] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b16 took 4ms
[    6.075473] ueventd: firmware: loading 'modem.b17' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b17'
[    6.103369] SELinux: 65536 avtab hash slots, 174043 rules.
[    6.103381] SELinux:  1 users, 4 roles, 1564 types, 0 bools, 1 sens, 102=
4 cats
[    6.103386] SELinux:  93 classes, 174043 rules
[    6.117172] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    6.117642] healthd: battery l=3D96 v=3D4292 t=3D27.0 h=3D2 st=3D2 c=3D1=
03 fc=3D3680000 cc=3D25 chg=3Du
[    6.117753] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    6.118246] healthd: battery l=3D96 v=3D4292 t=3D27.0 h=3D2 st=3D2 c=3D1=
03 fc=3D3680000 cc=3D25 chg=3Du
[    6.172200] android_work: sent uevent USB_STATE=3DCONNECTED
[    6.175994] android_work: sent uevent USB_STATE=3DDISCONNECTED
[    6.188917] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b17 took 113ms
[    6.255867] ueventd: firmware: loading 'modem.b18' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b18'
[    6.272704] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b18 took 16ms
[    6.336260] android_work: sent uevent USB_STATE=3DCONNECTED
[    6.340649] configfs-gadget gadget: high-speed config #1: b
[    6.340777] msm-dwc3 a800000.ssusb: Avail curr from USB =3D 500
[    6.340994] android_work: sent uevent USB_STATE=3DCONFIGURED
[    6.358638] msm_qti_pp_get_rms_value_control, back not active to query r=
ms be_idx:3
[    6.363288] msm_voice_sound_focus_get: Error getting Sound Focus Params,=
 err=3D-22
[    6.363390] msm_voice_source_tracking_get: Error getting Source Tracking=
 Params, err=3D-22
[    6.363483] msm_audio_get_copp_idx_from_port_id: Invalid FE, exiting
[    6.363486] msm_audio_sound_focus_get: Could not get copp idx for port_i=
d=3D16385
[    6.363582] msm_audio_get_copp_idx_from_port_id: Invalid FE, exiting
[    6.363585] msm_audio_source_tracking_get: Could not get copp idx for po=
rt_id=3D16385
[    6.363676] msm_voice_sound_focus_get: Error getting Sound Focus Params,=
 err=3D-22
[    6.363766] msm_voice_source_tracking_get: Error getting Source Tracking=
 Params, err=3D-22
[    6.363857] msm_audio_get_copp_idx_from_port_id: Invalid FE, exiting
[    6.363860] msm_audio_sound_focus_get: Could not get copp idx for port_i=
d=3D4101
[    6.363949] msm_audio_get_copp_idx_from_port_id: Invalid FE, exiting
[    6.363952] msm_audio_source_tracking_get: Could not get copp idx for po=
rt_id=3D4101
[    6.364058] msm_voice_sound_focus_get: Error getting Sound Focus Params,=
 err=3D-22
[    6.364159] msm_voice_source_tracking_get: Error getting Source Tracking=
 Params, err=3D-22
[    6.364249] msm_audio_get_copp_idx_from_port_id: Invalid FE, exiting
[    6.364252] msm_audio_sound_focus_get: Could not get copp idx for port_i=
d=3D4149
[    6.364344] msm_audio_get_copp_idx_from_port_id: Invalid FE, exiting
[    6.364347] msm_audio_source_tracking_get: Could not get copp idx for po=
rt_id=3D4149
[    6.365173] core_get_license_status: cmdrsp_license_result.result =3D 0x=
15 for module 0x131ff
[    6.365596] msm-ext-disp-audio-codec-rx soc:qcom,msm_ext_disp:qcom,msm-e=
xt-disp-audio-codec-rx: msm_ext_disp_audio_type_get: codec_data, get_audio_=
edid_blk() or get_intf_id is NULL
[    6.366958] tas2557s 7-004d: tas2557_calibration_get =3D 0
[    6.369763] msm_cci_init:1428: hw_version =3D 0x10060000
[    6.369964] ueventd: firmware: loading 'modem.b20' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b20'
[    6.371439] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b20 took 1ms
[    6.372133] ueventd: firmware: loading 'modem.b21' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b21'
[    6.373485] msm_dai_q6_ext_disp_drift_get:  afe port not started. status=
_mask =3D 0
[    6.373841] msm_dai_q6_ext_disp_drift_get:  afe port not started. status=
_mask =3D 0
[    6.375396] msm_pcm_volume_ctl_get substream runtime not found
[    6.375497] msm_pcm_compress_ctl_get substream runtime not found
[    6.375686] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    6.376145] msm_pcm_volume_ctl_get substream runtime not found
[    6.376446] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    6.376640] msm_pcm_volume_ctl_get substream runtime not found
[    6.376735] msm_pcm_volume_ctl_get substream runtime not found
[    6.377004] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b21 took 4ms
[    6.377414] msm_compr_audio_effects_config_get: stream or effects inacti=
ve
[    6.377617] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    6.378071] ueventd: firmware: loading 'modem.b22' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b22'
[    6.378474] msm_pcm_volume_ctl_get substream runtime not found
[    6.378571] msm_pcm_compress_ctl_get substream runtime not found
[    6.378758] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    6.379100] msm_compr_audio_effects_config_get: stream or effects inacti=
ve
[    6.379295] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    6.380136] msm_pcm_volume_ctl_get substream runtime not found
[    6.380333] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    6.380519] msm_pcm_volume_ctl_get substream runtime not found
[    6.380613] msm_pcm_volume_ctl_get substream runtime not found
[    6.382568] msm_pcm_volume_ctl_get substream runtime not found
[    6.382762] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    6.382959] msm_compr_audio_effects_config_get: stream or effects inacti=
ve
[    6.383158] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    6.383759] msm_compr_audio_effects_config_get: stream or effects inacti=
ve
[    6.383946] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    6.384559] msm_compr_audio_effects_config_get: stream or effects inacti=
ve
[    6.384756] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    6.385386] msm_compr_audio_effects_config_get: stream or effects inacti=
ve
[    6.385574] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    6.386276] msm_compr_audio_effects_config_get: stream or effects inacti=
ve
[    6.386487] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    6.387108] msm_compr_audio_effects_config_get: stream or effects inacti=
ve
[    6.387295] msm_adsp_stream_callback_get: ASM Stream PP Event Data Unava=
ilable
[    6.387797] msm_pcm_volume_ctl_get substream or runtime not found
[    6.442214] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b22 took 64ms
[    6.443264] ueventd: firmware: loading 'modem.b23' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b23'
[    6.446916] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b23 took 3ms
[    6.448116] ueventd: firmware: loading 'modem.b24' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b24'
[    6.451741] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b24 took 3ms
[    6.452201] ueventd: firmware: loading 'modem.b25' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b25'
[    6.455502] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b25 took 3ms
[    6.456267] ueventd: firmware: loading 'modem.b26' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b26'
[    6.459646] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b26 took 3ms
[    6.460593] ueventd: firmware: loading 'modem.b27' for '/devices/soc/408=
0000.qcom,mss/firmware/modem.b27'
[    6.464906] ueventd: loading /devices/soc/4080000.qcom,mss/firmware/mode=
m.b27 took 4ms
[    6.484253] wcdcal_hwdep_ioctl_shared: incorrect firmware size 154 for v=
bat
[    6.687923] selinux: avc:  received policyload notice (seqno=3D2)\x0a
[    6.907714] pil-q6v5-mss 4080000.qcom,mss: modem: Brought out of reset
[    7.034704] apr_tal_link_state_cb: edge[mpss] link state[0]
[    7.036337] IPC_RTR: ipc_router_create_log_ctx: Unable to create IPC log=
ging for [mpss_IPCRTR]
[    7.039346] pil-q6v5-mss 4080000.qcom,mss: Subsystem error monitoring/ha=
ndling services are up
[    7.039449] pil-q6v5-mss 4080000.qcom,mss: modem: Power/Clock ready inte=
rrupt received
[    7.040817] ipa-wan ipa3_ssr_notifier_cb:2548 ipa3_ssr_notifier_cb:2548 =
IPA received MPSS AFTER_POWERUP
[    7.040824] ipa-wan ipa3_ssr_notifier_cb:2553 IPA AFTER_POWERUP handling=
 is complete
[    7.139897] service-notifier: root_service_service_arrive: Connection es=
tablished between QMI handle and 180 service
[    7.140925] sysmon-qmi: sysmon_clnt_svc_arrive: Connection established b=
etween QMI handle and modem's SSCTL service
[    7.202553] msm_cci_init:1428: hw_version =3D 0x10060000
[    7.276471] diag: In socket_open_client, socket not initialized for MODE=
M_CMD
[    7.276635] type=3D1400 audit(1533422721.775:53): avc: denied { sys_admi=
n } for pid=3D1080 comm=3D"tc-wrapper-1.0" capability=3D21 scontext=3Du:r:n=
etutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability p=
ermissive=3D0
[    7.276652] type=3D1400 audit(1533422723.190:125): avc: denied { create =
} for pid=3D6 comm=3D"kworker/u16:0" scontext=3Du:r:kernel:s0 tcontext=3Du:=
r:kernel:s0 tclass=3Dsocket permissive=3D0
[    7.277114] diag: In socket_open_client, socket not initialized for MODE=
M_DCI_CMD
[    7.277343] diag: In diag_send_feature_mask_update, control channel is n=
ot open, p: 0, 0000000000000000
[    7.277516] type=3D1400 audit(1533422723.190:125): avc: denied { create =
} for pid=3D6 comm=3D"kworker/u16:0" scontext=3Du:r:kernel:s0 tcontext=3Du:=
r:kernel:s0 tclass=3Dsocket permissive=3D0
[    7.277530] type=3D1400 audit(1533422723.191:126): avc: denied { create =
} for pid=3D477 comm=3D"kworker/u16:8" scontext=3Du:r:kernel:s0 tcontext=3D=
u:r:kernel:s0 tclass=3Dsocket permissive=3D0
[    7.289968] Sending QMI_IPA_INIT_MODEM_DRIVER_REQ_V01
[    7.380510] ipa-wan ipa3_handle_indication_req:152 not send indication
[    7.385598] ipa ipa3_uc_state_check:307 uC is not loaded
[    7.387382] ipa ipa3_uc_wdi_event_log_info_handler:370 WDI stats ofst=3D=
0x47130
[    7.387400] ipa ipa3_uc_ntn_event_log_info_handler:39 NTN feature missin=
g 0x9
[    7.387418] ipa ipa3_uc_state_check:307 uC is not loaded
[    7.388391] QMI_IPA_INIT_MODEM_DRIVER_REQ_V01 response received
[    7.389033] ipa ipa3_uc_state_check:307 uC is not loaded
[    7.406261] MSM-CPP cpp_init_hardware:1138 CPP HW Version: 0x60010000
[    7.406278] MSM-CPP cpp_init_hardware:1156 stream_cnt:0
[    7.415825] IPC_RTR: process_new_server_msg: Server 00001002 create reje=
cted, version =3D 0
[    7.416599] MSM-CPP cpp_release_hardware:1219 cpp hw release done
[    7.725104] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    7.725944] healthd: battery l=3D96 v=3D4339 t=3D27.0 h=3D2 st=3D2 c=3D-=
207 fc=3D3680000 cc=3D25 chg=3Du
[    7.790010] imsdatadaemon: groups: 0x40000000 ngroups: 64
[    7.793256] IPC_RTR: msm_ipc_router_send_to: permission failure for cnss=
-daemon
[    7.793279] IPC_RTR: msm_ipc_router_sendmsg: Send_to failure -1
[    7.808462] misc mnh_sm: mnh_sm_set_state: request state 0
[    7.808476] misc mnh_sm: mnh_sm_set_state: finished state 0
[    7.811856] misc mnh_sm: mnh_sm_set_state: request state 0
[    7.811872] misc mnh_sm: mnh_sm_set_state: finished state 0
[    7.815765] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    7.816149] healthd: battery l=3D96 v=3D4339 t=3D27.0 h=3D2 st=3D2 c=3D-=
207 fc=3D3680000 cc=3D25 chg=3Du
[    7.816334] msm_pm_qos_update_request: update request 100
[    7.816351] msm_pm_qos_update_request: update request -1
[    7.817152] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    7.817604] healthd: battery l=3D96 v=3D4339 t=3D27.0 h=3D2 st=3D2 c=3D-=
207 fc=3D3680000 cc=3D25 chg=3Du
[    7.822661] msm_csid_init: CSID_VERSION =3D 0x30050000
[    7.823357] msm_csid_irq CSID0_IRQ_STATUS_ADDR =3D 0x800
[    7.828799] MSM-CPP cpp_init_hardware:1138 CPP HW Version: 0x60010000
[    7.828828] MSM-CPP cpp_init_hardware:1156 stream_cnt:0
[    7.839618] init: Received control message 'interface_start' for 'androi=
d.frameworks.sensorservice@1.0::ISensorManager/default' from pid: 606 (/sys=
tem/bin/hwservicemanager)
[    7.839669] init: Could not find service hosting interface android.frame=
works.sensorservice@1.0::ISensorManager/default
[    7.840355] init: Received control message 'interface_start' for 'androi=
d.frameworks.sensorservice@1.0::ISensorManager/default' from pid: 606 (/sys=
tem/bin/hwservicemanager)
[    7.840403] init: Could not find service hosting interface android.frame=
works.sensorservice@1.0::ISensorManager/default
[    7.858836] msm_cci_init:1428: hw_version =3D 0x10060000
[    7.859004] msm_sensor_power_up: [08-04 22:45:23.772] imx362
[    7.881795] msm_stopGyroThread:251 [OISDBG] msm_stopGyroThread:E
[    7.881808] msm_stopGyroThread:261 [OISDBG] invalid timer state =3D 0
[    7.881811] msm_stopGyroThread:262 [OISDBG] msm_stopGyroThread:X
[    7.885191] MSM-CPP cpp_release_hardware:1219 cpp hw release done
[    7.886906] [OISFW]:msm_sensor_checkfw=20
[    7.886928] [OISFW]:checkFWUpdate 1. sid =3D 26
[    7.893050] init: processing action (sys.uidcpupower=3D*) from (/vendor/=
etc/init/hw/init.taimen.rc:805)
[    7.931358] init: processing action (sys.sysctl.extra_free_kbytes=3D*) f=
rom (/init.rc:726)
[    7.944860] service-notifier: root_service_service_ind_cb: Indication re=
ceived from msm/modem/wlan_pd, state: 0x1fffffff, trans-id: 1
[    7.945162] service-notifier: send_ind_ack: Indication ACKed for transid=
 1, service msm/modem/wlan_pd, instance 180!
[    7.948125] icnss: QMI Server Connected: state: 0x981
[    7.987329] [OISFW]:checkHWFWversion
[    7.987555] [OISFW]:checkHWFWversion 0x8000 =3D  0x090e0819.
[    7.987561] [OISFW]:checkHWFWversion FW_version =3D  0x19.
[    7.987564] [OISFW]checkHWFWversion: No need to update.
[    7.987704] [OISFW]:checkFWUpdate 0x8000 =3D  0x090e0819
[    7.987712] [OISFW]:checkFWUpdate 2. sid =3D 26
[    7.987718] [OISFW]:checkFWUpdate rc =3D 0
[    7.987818] [VCMFW]: msm_sensor_checkvcmfw:E sid =3D 26
[    7.987823] [VCMFW]: msm_sensor_checkvcmfw:E addr_type =3D 2
[    7.987827] [VCMFW]:checkVCMFWUpdate :E
[    7.987832] [VCMFW]:checkVCMFWUpdate addr_type =3D 1
[    7.987836] [VCMFW]:checkVCMFWUpdate sid =3D 114
[    7.999405] [VCMFW]:checkVCMFWUpdate UlReadVal =3D  0x60720600
[    7.999740] [VCMFW]checkVCMFWUpdate: No need to update AF FW
[    7.999744] [VCMFW]:checkVCMFWUpdate :X
[    7.999748] [VCMFW]: msm_sensor_checkvcmfw:X sid =3D 26
[    7.999751] [VCMFW]: msm_sensor_checkvcmfw:X addr_type =3D 2
[    7.999830] msm_sensor_power_down: [08-04 15:45:23.913] imx362
[    8.007102] IPC_RTR: process_new_server_msg: Server 00001003 create reje=
cted, version =3D 0
[    8.022194] msm_pm_qos_update_request: update request 100
[    8.022211] msm_pm_qos_update_request: update request -1
[    8.023356] msm_csid_init: CSID_VERSION =3D 0x30050000
[    8.024047] msm_csid_irq CSID2_IRQ_STATUS_ADDR =3D 0x800
[    8.027785] MSM-CPP cpp_init_hardware:1138 CPP HW Version: 0x60010000
[    8.027804] MSM-CPP cpp_init_hardware:1156 stream_cnt:0
[    8.029149] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    8.029415] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[    8.029478] healthd: battery l=3D96 v=3D4339 t=3D27.0 h=3D2 st=3D2 c=3D-=
207 fc=3D3680000 cc=3D25 chg=3Du
[    8.030006] healthd: battery l=3D96 v=3D4339 t=3D27.0 h=3D2 st=3D2 c=3D-=
207 fc=3D3680000 cc=3D25 chg=3Du
[    8.047084] msm_cci_init:1428: hw_version =3D 0x10060000
[    8.047293] msm_sensor_power_up: [08-04 15:45:23.961] imx179
[    8.060071] msm_sensor_power_down: [08-04 15:45:23.974] imx179
[    8.065889] MSM-CPP cpp_release_hardware:1219 cpp hw release done
[    8.179241] init: processing action (vendor.ims.DATA_DAEMON_STATUS=3D1) =
=66rom (/vendor/etc/init/hw/init.taimen.rc:738)
[    8.181138] init: starting service 'vendor.ims_rtp_daemon'...
[    8.183560] init: starting service 'vendor.imsrcsservice'...
[    8.244724] rild: groups: 0x40000000 ngroups: 64
[    8.311287] read descriptors
[    8.311302] read strings
[    8.311343] read descriptors
[    8.311349] read strings
[    8.316417] ip_local_port_range: prefer different parity for start/end v=
alues.
[    8.323099] acc_open
[    8.323116] acc_release
[    8.327444] type=3D1400 audit(1533422723.191:126): avc: denied { create =
} for pid=3D477 comm=3D"kworker/u16:8" scontext=3Du:r:kernel:s0 tcontext=3D=
u:r:kernel:s0 tclass=3Dsocket permissive=3D0
[    8.327471] type=3D1400 audit(1533422724.241:127): avc: denied { sys_adm=
in } for pid=3D1500 comm=3D"ndc-wrapper-1.0" capability=3D21 scontext=3Du:r=
:netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability=
 permissive=3D0
[    8.338360] type=3D1400 audit(1533422724.241:127): avc: denied { sys_adm=
in } for pid=3D1500 comm=3D"ndc-wrapper-1.0" capability=3D21 scontext=3Du:r=
:netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability=
 permissive=3D0
[    8.338388] type=3D1400 audit(1533422724.252:128): avc: denied { sys_adm=
in } for pid=3D1500 comm=3D"ndc" capability=3D21 scontext=3Du:r:netutils_wr=
apper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permissive=
=3D0
[    8.348976] type=3D1400 audit(1533422724.252:128): avc: denied { sys_adm=
in } for pid=3D1500 comm=3D"ndc" capability=3D21 scontext=3Du:r:netutils_wr=
apper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permissive=
=3D0
[    8.349000] type=3D1400 audit(1533422724.262:129): avc: denied { sys_adm=
in } for pid=3D1503 comm=3D"iptables-wrappe" capability=3D21 scontext=3Du:r=
:netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability=
 permissive=3D0
[    8.365720] type=3D1400 audit(1533422724.262:129): avc: denied { sys_adm=
in } for pid=3D1503 comm=3D"iptables-wrappe" capability=3D21 scontext=3Du:r=
:netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability=
 permissive=3D0
[    8.365753] type=3D1400 audit(1533422724.279:130): avc: denied { sys_adm=
in } for pid=3D1506 comm=3D"iptables-wrappe" capability=3D21 scontext=3Du:r=
:netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability=
 permissive=3D0
[    8.386419] type=3D1400 audit(1533422724.279:130): avc: denied { sys_adm=
in } for pid=3D1506 comm=3D"iptables-wrappe" capability=3D21 scontext=3Du:r=
:netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability=
 permissive=3D0
[    8.386448] type=3D1400 audit(1533422724.300:131): avc: denied { sys_adm=
in } for pid=3D1511 comm=3D"iptables-wrappe" capability=3D21 scontext=3Du:r=
:netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability=
 permissive=3D0
[    8.395186] nq-nci 8-0028: setting ese_gpio high
[    8.402701] type=3D1400 audit(1533422724.300:131): avc: denied { sys_adm=
in } for pid=3D1511 comm=3D"iptables-wrappe" capability=3D21 scontext=3Du:r=
:netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability=
 permissive=3D0
[    8.402724] type=3D1400 audit(1533422724.316:132): avc: denied { sys_adm=
in } for pid=3D1511 comm=3D"iptables" capability=3D21 scontext=3Du:r:netuti=
ls_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permis=
sive=3D0
[    8.409230] ipa ipa3_assign_policy:3329 get close-by 8192
[    8.409240] ipa ipa3_assign_policy:3335 set rx_buff_sz 7808
[    8.409244] ipa ipa3_assign_policy:3357 set aggr_limit 6
[    8.411687] type=3D1400 audit(1533422724.316:132): avc: denied { sys_adm=
in } for pid=3D1511 comm=3D"iptables" capability=3D21 scontext=3Du:r:netuti=
ls_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permis=
sive=3D0
[    8.411713] type=3D1400 audit(1533422724.325:133): avc: denied { sys_adm=
in } for pid=3D1519 comm=3D"iptables-wrappe" capability=3D21 scontext=3Du:r=
:netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability=
 permissive=3D0
[    8.414839] ipa-wan ipa3_wwan_ioctl:1699 dev(rmnet_data0) register to IPA
[    8.419884] type=3D1400 audit(1533422724.325:133): avc: denied { sys_adm=
in } for pid=3D1519 comm=3D"iptables-wrappe" capability=3D21 scontext=3Du:r=
:netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability=
 permissive=3D0
[    8.419907] type=3D1400 audit(1533422724.333:134): avc: denied { sys_adm=
in } for pid=3D1519 comm=3D"iptables" capability=3D21 scontext=3Du:r:netuti=
ls_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permis=
sive=3D0
[    8.429255] audit: audit_lost=3D96 audit_rate_limit=3D5 audit_backlog_li=
mit=3D64
[    8.429267] audit: rate limit exceeded
[    8.500392] init: processing action (sys.retaildemo.enabled=3D0) from (/=
vendor/etc/init/hw/init.taimen.rc:894)
[    8.510562] init: processing action (persist.vendor.charge.stop.level=3D=
* && sys.all.modules.ready=3D1) from (/vendor/etc/init/init-taimen.rc:44)
[    8.511609] init: processing action (persist.vendor.charge.start.level=
=3D* && sys.all.modules.ready=3D1) from (/vendor/etc/init/init-taimen.rc:47)
[    8.552998] ipa-wan ipa3_wwan_ioctl:1699 dev(rmnet_data1) register to IPA
[    8.702703] sdcardfs version 2.0
[    8.702718] sdcardfs: dev_name -> /data/media
[    8.702722] sdcardfs: options -> fsuid=3D1023,fsgid=3D1023,multiuser,der=
ive_gid,default_normal,mask=3D6,userid=3D0,gid=3D1015
[    8.702726] sdcardfs: mnt -> 0000000000000000
[    8.702779] sdcardfs: mounted on top of /data/media type ext4
[    8.703399] Remount options were mask=3D23,gid=3D9997 for vfsmnt 0000000=
000000000.
[    8.703409] sdcardfs : options - debug:1
[    8.703413] sdcardfs : options - gid:9997
[    8.703415] sdcardfs : options - mask:23
[    8.703755] Remount options were mask=3D7,gid=3D9997 for vfsmnt 00000000=
00000000.
[    8.703766] sdcardfs : options - debug:1
[    8.703769] sdcardfs : options - gid:9997
[    8.703772] sdcardfs : options - mask:7
[    8.775795] ipa-wan ipa3_wwan_ioctl:1699 dev(rmnet_data2) register to IPA
[    8.790914] qpnp_led.red: b:00 on:50 off:0
[    8.790966] qpnp_led.green: b:00 on:50 off:0
[    8.791002] qpnp_led.blue: b:00 on:50 off:0
[    8.791073] qpnp_led.red: b:00 on:50 off:0
[    8.792558] qpnp_led.green: b:00 on:50 off:0
[    8.792601] qpnp_led.blue: b:00 on:50 off:0
[    8.792686] qpnp_led.red: b:00 on:50 off:0
[    8.792723] qpnp_led.green: b:00 on:50 off:0
[    8.792757] qpnp_led.blue: b:00 on:50 off:0
[    8.934296] msm_vidc: info: Opening video instance: 0000000000000000, 1
[    8.941211] subsys-restart: __subsystem_get(): Changing subsys fw_name t=
o venus
[    8.947669] subsys-pil-tz cce0000.qcom,venus: venus: loading from 0x0000=
000000000000 to 0x0000000000000000
[    8.998099] ipa-wan ipa3_wwan_ioctl:1699 dev(rmnet_data3) register to IPA
[    9.024398] subsys-pil-tz cce0000.qcom,venus: venus: Brought out of reset
[    9.057613] msm_vidc: info: Closed video instance: 0000000000000000
[    9.063240] msm_vidc: info: Opening video instance: 0000000000000000, 1
[    9.073800] msm_vidc: info: Closed video instance: 0000000000000000
[    9.091190] msm_vidc: info: Opening video instance: 0000000000000000, 1
[    9.097237] msm_vidc: info: Closed video instance: 0000000000000000
[    9.111957] msm_vidc: info: Opening video instance: 0000000000000000, 1
[    9.120969] msm_vidc: info: Closed video instance: 0000000000000000
[    9.126706] msm_vidc: info: Opening video instance: 0000000000000000, 1
[    9.136322] msm_vidc: info: Closed video instance: 0000000000000000
[    9.159192] msm_vidc: info: Opening video instance: 0000000000000000, 1
[    9.165730] msm_vidc: info: Closed video instance: 0000000000000000
[    9.172306] msm_vidc: info: Opening video instance: 0000000000000000, 1
[    9.179838] msm_vidc: info: Closed video instance: 0000000000000000
[    9.193769] msm_vidc: info: Opening video instance: 0000000000000000, 1
[    9.201031] msm_vidc: info: Closed video instance: 0000000000000000
[    9.205980] msm_vidc: info: Opening video instance: 0000000000000000, 1
[    9.213348] msm_vidc: info: Closed video instance: 0000000000000000
[    9.217535] ipa-wan ipa3_wwan_ioctl:1699 dev(rmnet_data4) register to IPA
[    9.230565] bt_ioctl: BT_CMD_PWR_CTRL pwr_cntrl:0
[    9.230583] bt_ioctl: BT chip state is already :0 no change d\x0a
[    9.230636] bt_ioctl: BT_CMD_PWR_CTRL pwr_cntrl:1
[    9.232477] msm_vidc: info: Opening video instance: 0000000000000000, 0
[    9.249100] msm_hs_resource_on(): startup_locked=3D1
[    9.377799] ipa-wan ipa3_wwan_ioctl:1699 dev(rmnet_data5) register to IPA
[    9.379425] type=3D1400 audit(1533422724.333:134): avc: denied { sys_adm=
in } for pid=3D1519 comm=3D"iptables" capability=3D21 scontext=3Du:r:netuti=
ls_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permis=
sive=3D0
[    9.379454] type=3D1400 audit(1533422725.293:219): avc: denied { sys_adm=
in } for pid=3D1958 comm=3D"iptables" capability=3D21 scontext=3Du:r:netuti=
ls_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permis=
sive=3D0
[    9.382704] msm_hs_resource_on(): startup_locked=3D1
[    9.388721] type=3D1400 audit(1533422725.293:219): avc: denied { sys_adm=
in } for pid=3D1958 comm=3D"iptables" capability=3D21 scontext=3Du:r:netuti=
ls_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permis=
sive=3D0
[    9.388747] type=3D1400 audit(1533422725.302:220): avc: denied { sys_adm=
in } for pid=3D1966 comm=3D"iptables-wrappe" capability=3D21 scontext=3Du:r=
:netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability=
 permissive=3D0
[    9.400300] type=3D1400 audit(1533422725.302:220): avc: denied { sys_adm=
in } for pid=3D1966 comm=3D"iptables-wrappe" capability=3D21 scontext=3Du:r=
:netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability=
 permissive=3D0
[    9.400318] type=3D1400 audit(1533422725.314:221): avc: denied { sys_adm=
in } for pid=3D1966 comm=3D"iptables" capability=3D21 scontext=3Du:r:netuti=
ls_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permis=
sive=3D0
[    9.415167] type=3D1400 audit(1533422725.314:221): avc: denied { sys_adm=
in } for pid=3D1966 comm=3D"iptables" capability=3D21 scontext=3Du:r:netuti=
ls_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permis=
sive=3D0
[    9.415195] type=3D1400 audit(1533422725.329:222): avc: denied { sys_adm=
in } for pid=3D1983 comm=3D"iptables-wrappe" capability=3D21 scontext=3Du:r=
:netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability=
 permissive=3D0
[    9.425863] type=3D1400 audit(1533422725.329:222): avc: denied { sys_adm=
in } for pid=3D1983 comm=3D"iptables-wrappe" capability=3D21 scontext=3Du:r=
:netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability=
 permissive=3D0
[    9.425889] type=3D1400 audit(1533422725.339:223): avc: denied { sys_adm=
in } for pid=3D1983 comm=3D"iptables" capability=3D21 scontext=3Du:r:netuti=
ls_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permis=
sive=3D0
[    9.448070] audit: audit_lost=3D180 audit_rate_limit=3D5 audit_backlog_l=
imit=3D64
[    9.448086] audit: rate limit exceeded
[    9.450552] Loc_hal: groups: 0x40000000 ngroups: 64
[    9.592661] ipa-wan ipa3_wwan_ioctl:1699 dev(rmnet_data6) register to IPA
[    9.617162] msm_vidc: info: Closed video instance: 0000000000000000
[    9.630733] msm_vidc: info: Opening video instance: 0000000000000000, 0
[    9.638231] msm_vidc: info: Closed video instance: 0000000000000000
[    9.646338] msm_vidc: info: Opening video instance: 0000000000000000, 0
[    9.653796] msm_vidc: info: Closed video instance: 0000000000000000
[    9.657172] msm_vidc: info: Opening video instance: 0000000000000000, 0
[    9.663228] msm_vidc: info: Closed video instance: 0000000000000000
[    9.668074] msm_vidc: info: Opening video instance: 0000000000000000, 0
[    9.676122] msm_vidc: info: Closed video instance: 0000000000000000
[    9.740757] ipa-wan ipa3_wwan_ioctl:1699 dev(rmnet_data7) register to IPA
[   10.166039] HTB: quantum of class 10001 is big. Consider r2q change.
[   10.184300] HTB: quantum of class 10010 is big. Consider r2q change.
[   10.287876] init: Service 'bootanim' (pid 623) exited with status 0
[   10.388316] mdss_fb_set_backlight: backlight sent to panel :86
[   10.403244] init: processing action (sys.boot_completed=3D1) from (/init=
=2Erc:720)
[   10.403684] init: processing action (sys.boot_completed=3D1) from (/vend=
or/etc/init/hw/init.taimen.rc:573)
[   10.406018] mdss_fb_set_backlight: backlight sent to panel :83
[   10.406690] init: starting service 'vendor.power_sh'...
[   10.408815] init: Command 'write /sys/devices/soc/${ro.boot.bootdevice}/=
clkscale_enable 1' action=3Dsys.boot_completed=3D1 (/vendor/etc/init/hw/ini=
t.taimen.rc:578) took 0ms and failed: Unable to write to file '/sys/devices=
/soc/1da4000.ufshc/clkscale_enable': open() failed: Permission denied
[   10.410216] init: Command 'write /sys/module/lpm_levels/parameters/sleep=
_disabled N' action=3Dsys.boot_completed=3D1 (/vendor/etc/init/hw/init.taim=
en.rc:580) took 0ms and failed: Unable to write to file '/sys/module/lpm_le=
vels/parameters/sleep_disabled': open() failed: Permission denied
[   10.413559] type=3D1400 audit(1533422725.339:223): avc: denied { sys_adm=
in } for pid=3D1983 comm=3D"iptables" capability=3D21 scontext=3Du:r:netuti=
ls_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permis=
sive=3D0
[   10.413582] type=3D1400 audit(1533422725.405:288): avc: denied { sys_adm=
in } for pid=3D2234 comm=3D"init.power.sh" capability=3D21 scontext=3Du:r:i=
nit_power:s0 tcontext=3Du:r:init_power:s0 tclass=3Dcapability permissive=3D0
[   10.415936] init: processing action (sys.boot_completed=3D1 && sys.logbo=
otcomplete=3D1) from (/system/etc/init/bootstat.rc:70)
[   10.416275] init: starting service 'exec 7 (/system/bin/bootstat --set_s=
ystem_boot_reason --record_boot_complete --record_boot_reason --record_time=
_since_factory_reset -l)'...
[   10.416820] init: processing action (sys.boot_completed=3D1 && sys.wifit=
racing.started=3D0) from (/system/etc/init/wifi-events.rc:20)
[   10.417154] selinux: SELinux: Could not get canonical path for /sys/kern=
el/debug/tracing/instances/wifi restorecon: No such file or directory.\x0a
[   10.418770] init: processing action (sys.boot_completed=3D1) from (/vend=
or/etc/init/init-taimen.rc:16)
[   10.419982] type=3D1400 audit(1533422725.405:288): avc: denied { sys_adm=
in } for pid=3D2234 comm=3D"init.power.sh" capability=3D21 scontext=3Du:r:i=
nit_power:s0 tcontext=3Du:r:init_power:s0 tclass=3Dcapability permissive=3D0
[   10.420042] type=3D1400 audit(1533422725.411:289): avc: denied { sys_adm=
in } for pid=3D2236 comm=3D"ip6tables-wrapp" capability=3D21 scontext=3Du:r=
:netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability=
 permissive=3D0
[   10.420536] init: processing action (persist.sys.zram_enabled=3D1 && sys=
-boot-completed-set) from (/vendor/etc/init/hw/init.taimen.rc:625)
[   10.421728] mdss_fb_set_backlight: backlight sent to panel :80
[   10.421934] zram0: detected capacity change from 0 to 536870912
[   10.428407] type=3D1400 audit(1533422725.411:289): avc: denied { sys_adm=
in } for pid=3D2236 comm=3D"ip6tables-wrapp" capability=3D21 scontext=3Du:r=
:netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability=
 permissive=3D0
[   10.428439] type=3D1400 audit(1533422725.420:290): avc: denied { sys_adm=
in } for pid=3D2236 comm=3D"ip6tables" capability=3D21 scontext=3Du:r:netut=
ils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permi=
ssive=3D0
[   10.428606] logd: logdr: UID=3D1000 GID=3D1007 PID=3D2235 n tail=3D0 log=
Mask=3D80 pid=3D0 start=3D0ns timeout=3D0ns
[   10.431664] type=3D1400 audit(1533422725.420:290): avc: denied { sys_adm=
in } for pid=3D2236 comm=3D"ip6tables" capability=3D21 scontext=3Du:r:netut=
ils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permi=
ssive=3D0
[   10.431696] type=3D1400 audit(1533422725.423:291): avc: denied { sys_adm=
in } for pid=3D2245 comm=3D"mkswap" capability=3D21 scontext=3Du:r:toolbox:=
s0 tcontext=3Du:r:toolbox:s0 tclass=3Dcapability permissive=3D0
[   10.438047] type=3D1400 audit(1533422725.423:291): avc: denied { sys_adm=
in } for pid=3D2245 comm=3D"mkswap" capability=3D21 scontext=3Du:r:toolbox:=
s0 tcontext=3Du:r:toolbox:s0 tclass=3Dcapability permissive=3D0
[   10.438073] type=3D1400 audit(1533422725.429:292): avc: denied { sys_adm=
in } for pid=3D2256 comm=3D"setprop" capability=3D21 scontext=3Du:r:init_po=
wer:s0 tcontext=3Du:r:init_power:s0 tclass=3Dcapability permissive=3D0
[   10.438980] mdss_fb_set_backlight: backlight sent to panel :78
[   10.451040] mkswap: Swapspace size: 524284k, UUID=3D382e28a7-1fa1-4702-8=
0cc-198cc852da5e
[   10.451481] Adding 524284k swap on /dev/block/zram0.  Priority:-1 extent=
s:1 across:524284k SS
[   10.454869] mdss_fb_set_backlight: backlight sent to panel :75
[   10.455834] init: processing action (sys.post_boot.parsed=3D1) from (/ve=
ndor/etc/init/hw/init.taimen.rc:567)
[   10.456348] init: Service 'exec 7 (/system/bin/bootstat --set_system_boo=
t_reason --record_boot_complete --record_boot_reason --record_time_since_fa=
ctory_reset -l)' (pid 2235) exited with status 0
[   10.457447] audit: audit_lost=3D245 audit_rate_limit=3D5 audit_backlog_l=
imit=3D64
[   10.457459] audit: rate limit exceeded
[   10.467153] init: Service 'vendor.power_sh' (pid 2234) exited with statu=
s 0
[   10.470853] mdss_fb_set_backlight: backlight sent to panel :72
[   10.487564] mdss_fb_set_backlight: backlight sent to panel :70
[   10.503972] mdss_fb_set_backlight: backlight sent to panel :67
[   10.507869] HTB: quantum of class 10001 is big. Consider r2q change.
[   10.515529] NOHZ: local_softirq_pending 08
[   10.520366] mdss_fb_set_backlight: backlight sent to panel :64
[   10.528663] HTB: quantum of class 10010 is big. Consider r2q change.
[   10.537002] mdss_fb_set_backlight: backlight sent to panel :62
[   10.555312] mdss_fb_set_backlight: backlight sent to panel :59
[   10.561893] EXT4-fs (loop8): errors=3Dremount-ro for active namespaces o=
n umount 2
[   10.563383] init: Untracked pid 2311 exited with status 0
[   10.570716] mdss_fb_set_backlight: backlight sent to panel :57
[   10.587245] mdss_fb_set_backlight: backlight sent to panel :54
[   10.602875] mdss_fb_set_backlight: backlight sent to panel :51
[   10.619572] mdss_fb_set_backlight: backlight sent to panel :49
[   10.635803] mdss_fb_set_backlight: backlight sent to panel :46
[   10.652471] mdss_fb_set_backlight: backlight sent to panel :43
[   10.668722] mdss_fb_set_backlight: backlight sent to panel :41
[   10.685250] mdss_fb_set_backlight: backlight sent to panel :38
[   10.701720] mdss_fb_set_backlight: backlight sent to panel :35
[   10.718444] mdss_fb_set_backlight: backlight sent to panel :34
[   10.734895] mdss_fb_set_backlight: backlight sent to panel :33
[   11.141673] NOHZ: local_softirq_pending 08
[   11.314157] NOHZ: local_softirq_pending 08
[   11.634765] NOHZ: local_softirq_pending 08
[   11.674058] icnss: WLAN FW is ready: 0xd87
[   11.680645] wlan: probing driver v5.2.1.1J.1
[   11.680670] ipa ipa3_uc_reg_rdyCB:1719 bad parm. inout=3D000000000000000=
0=20
[   11.685668] ipa ipa3_uc_reg_rdyCB:1719 bad parm. inout=3D000000000000000=
0=20
[   11.687347] R0: [kworker/u16:4][503305882] [15:45:26.681038]  wlan: [350=
:I :HDD] hdd_wlan_start_modules: 2160: Wlan transition (UNINITIALIZED -> CL=
OSED)
[   11.687365] R0: [kworker/u16:4][503306263] [15:45:26.681058]  wlan: [350=
:I :HDD] hdd_wlan_start_modules: 2164: Wlan transition (CLOSED -> OPENED)
[   11.687788] ipa ipa3_uc_reg_rdyCB:1719 bad parm. inout=3D000000000000000=
0=20
[   11.687819] R0: [kworker/u16:4][503314944] [15:45:26.681510]  wlan: [350=
:W :HIF] hif_snoc_enable_bus: device_init_wakeup already done
[   11.735616] type=3D1400 audit(1533422725.429:292): avc: denied { sys_adm=
in } for pid=3D2256 comm=3D"setprop" capability=3D21 scontext=3Du:r:init_po=
wer:s0 tcontext=3Du:r:init_power:s0 tclass=3Dcapability permissive=3D0
[   11.735643] type=3D1400 audit(1533422726.727:304): avc: denied { sys_adm=
in } for pid=3D2447 comm=3D"ip6tables-wrapp" capability=3D21 scontext=3Du:r=
:netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability=
 permissive=3D0
[   11.737739] IPC_RTR: process_new_server_msg: Server 00001003 create reje=
cted, version =3D 0
[   11.741352] R0: [kworker/u16:4][504342670] [15:45:26.735038]  wlan: [350=
:I :HDD] hdd_napi_create: 131: napi instances were created. Map=3D0x602
[   11.741384] R0: [kworker/u16:4][504343433] [15:45:26.735078]  wlan: [350=
:E :QDF] cds_get_context: Module ID 21 context is Null
[   11.741644] type=3D1400 audit(1533422726.727:304): avc: denied { sys_adm=
in } for pid=3D2447 comm=3D"ip6tables-wrapp" capability=3D21 scontext=3Du:r=
:netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability=
 permissive=3D0
[   11.741674] type=3D1400 audit(1533422726.733:305): avc: denied { sys_adm=
in } for pid=3D2447 comm=3D"ip6tables" capability=3D21 scontext=3Du:r:netut=
ils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permi=
ssive=3D0
[   11.744010] R0: [cds_mc_thread][504393800] [15:45:26.737701]  wlan: [245=
0:I :QDF] cds_mc_thread: MC Thread 2450 (cds_mc_thread) starting up
[   11.744253] R0: [kworker/u16:4][504398522] [15:45:26.737947]  wlan: [350=
:E :QDF] cds_get_context: Module ID 21 context is Null
[   11.745176] R0: [kworker/u16:4][504416187] [15:45:26.738867]  wlan: [350=
:E :QDF] ol_if_dfs_attach: called; ptr=3D0000000000000000, radar_info=3D000=
0000000000000\x0a
[   11.749710] type=3D1400 audit(1533422726.733:305): avc: denied { sys_adm=
in } for pid=3D2447 comm=3D"ip6tables" capability=3D21 scontext=3Du:r:netut=
ils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permi=
ssive=3D0
[   11.749737] type=3D1400 audit(1533422726.741:306): avc: denied { sys_adm=
in } for pid=3D2453 comm=3D"ip6tables-wrapp" capability=3D21 scontext=3Du:r=
:netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability=
 permissive=3D0
[   11.756703] type=3D1400 audit(1533422726.741:306): avc: denied { sys_adm=
in } for pid=3D2453 comm=3D"ip6tables-wrapp" capability=3D21 scontext=3Du:r=
:netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability=
 permissive=3D0
[   11.756731] type=3D1400 audit(1533422726.748:307): avc: denied { sys_adm=
in } for pid=3D2453 comm=3D"ip6tables" capability=3D21 scontext=3Du:r:netut=
ils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permi=
ssive=3D0
[   11.762495] R0: [kworker/u16:4][504748638] [15:45:26.756183]  wlan: [350=
:E :QDF] Target Ready! TX resource : 2 size:2184, MaxMsgsPerHTCBundle =3D 1
[   11.762515] R0: [kworker/u16:4][504749144] [15:45:26.756208]  wlan: [350=
:E :QDF] SVS Index : 1 TX : 0x100 : alloc:2
[   11.762527] R0: [kworker/u16:4][504749389] [15:45:26.756221]  wlan: [350=
:E :QDF] SVC:0x0001, ULpipe:0 DLpipe:2 id:0 Ready
[   11.762965] R0: [kworker/u16:4][504757772] [15:45:26.756658]  wlan: [350=
:I :HTT] full_reorder_offloaded 1
[   11.762976] R0: [kworker/u16:4][504758000] [15:45:26.756669]  wlan: [350=
:I :HTT] ce_classify 1
[   11.763112] R0: [kworker/u16:4][504760487] [15:45:26.756799]  wlan: [350=
:E :QDF] SVC:0x0300, ULpipe:4 DLpipe:1 id:1 Ready
[   11.763123] R0: [kworker/u16:4][504760814] [15:45:26.756816]  wlan: [350=
:E :QDF] SVC:0x0300 ep:1 TX flow control disabled
[   11.763176] R0: [kworker/u16:4][504761829] [15:45:26.756869]  wlan: [350=
:I :HIF] hif_map_service_to_pipe: ul pipe is NOT updated for service 769
[   11.763186] R0: [kworker/u16:4][504762031] [15:45:26.756879]  wlan: [350=
:E :QDF] SVC:0x0301, ULpipe:0 DLpipe:9 id:2 Ready
[   11.763194] R0: [kworker/u16:4][504762195] [15:45:26.756888]  wlan: [350=
:E :QDF] SVC:0x0301 ep:2 TX flow control disabled
[   11.763203] R0: [kworker/u16:4][504762362] [15:45:26.756897]  wlan: [350=
:I :HIF] hif_map_service_to_pipe: ul pipe is NOT updated for service 769
[   11.763252] R0: [kworker/u16:4][504763297] [15:45:26.756945]  wlan: [350=
:I :HIF] hif_map_service_to_pipe: ul pipe is NOT updated for service 770
[   11.763262] R0: [kworker/u16:4][504763498] [15:45:26.756956]  wlan: [350=
:E :QDF] SVC:0x0302, ULpipe:0 DLpipe:10 id:3 Ready
[   11.763271] R0: [kworker/u16:4][504763663] [15:45:26.756964]  wlan: [350=
:E :QDF] SVC:0x0302 ep:3 TX flow control disabled
[   11.763280] R0: [kworker/u16:4][504763832] [15:45:26.756973]  wlan: [350=
:I :HIF] hif_map_service_to_pipe: ul pipe is NOT updated for service 770
[   11.763501] R0: [kworker/u16:4][504768061] [15:45:26.757194]  wlan: [350=
:I :HIF] hif_map_service_to_pipe: ul pipe is NOT updated for service 1536
[   11.763512] R0: [kworker/u16:4][504768284] [15:45:26.757205]  wlan: [350=
:E :QDF] SVC:0x0600, ULpipe:0 DLpipe:11 id:4 Ready
[   11.763520] R0: [kworker/u16:4][504768454] [15:45:26.757214]  wlan: [350=
:E :QDF] SVC:0x0600 ep:4 TX flow control disabled
[   11.763600] R0: [kworker/u16:4][504769967] [15:45:26.757293]  wlan: [350=
:E :QDF] SVC:0x0100, ULpipe:3 DLpipe:2 id:5 Ready
[   11.763887] R0: [kworker/u16:4][504775483] [15:45:26.757580]  wlan: [350=
:E :QDF] HTC using TX credit flow control
[   11.764242] R0: [cds_mc_thread][504782286] [15:45:26.757934]  wlan: [245=
0:I :WMA] wma_rx_service_ready_event: Firmware build version : 22188219
[   11.764256] R0: [cds_mc_thread][504782578] [15:45:26.757950]  wlan: [245=
0:W :WMA] wma_rx_service_ready_event: Board version is unknown!
[   11.764269] R0: [cds_mc_thread][504782801] [15:45:26.757961]  wlan: [245=
0:I :TRX] ol_tx_set_desc_global_pool_size: 762: Global pool size: 3600\x0a
[   11.765277] type=3D1400 audit(1533422726.748:307): avc: denied { sys_adm=
in } for pid=3D2453 comm=3D"ip6tables" capability=3D21 scontext=3Du:r:netut=
ils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permi=
ssive=3D0
[   11.765298] type=3D1400 audit(1533422726.757:308): avc: denied { sys_adm=
in } for pid=3D2455 comm=3D"tc-wrapper-1.0" capability=3D21 scontext=3Du:r:=
netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability =
permissive=3D0
[   11.770742] audit: audit_lost=3D255 audit_rate_limit=3D5 audit_backlog_l=
imit=3D64
[   11.770751] audit: rate limit exceeded
[   11.789558] HTB: quantum of class 10001 is big. Consider r2q change.
[   11.790797] R0: [cds_mc_thread][505292104] [15:45:26.784487]  wlan: [245=
0:I :HDD] hdd_update_tgt_cfg: 1698: hw_mac is zero
[   11.790921] R0: [cds_mc_thread][505294541] [15:45:26.784614]  wlan: [245=
0:I :HDD] hdd_update_wiphy_vhtcap: 1086: Updated wiphy vhtcap:0x3817bfa, CS=
NAntSupp:3, NumSoundDim:1
[   11.790931] R0: [cds_mc_thread][505294738] [15:45:26.784625]  wlan: [245=
0:I :HDD] hdd_nan_datapath_target_config: 109: enable_nan_datapath: 1
[   11.805227] HTB: quantum of class 10010 is big. Consider r2q change.
[   11.819168] R0: [kworker/u16:4][505836749] [15:45:26.812855]  wlan: [350=
:I :HTT] HTT: full reorder offload enabled
[   11.868151] R0: [kworker/u16:4][506777230] [15:45:26.861838]  wlan: [350=
:I :HDD] hdd_wlan_start_modules: 2231: Wlan transition (now OPENED)
[   11.868168] Host SW:5.2.1.1J.1, FW:2.2.1.537.0, HW:WCN3990_V2.1
[   11.869366] cfg80211: Regulatory domain changed to country: US
[   11.869377] cfg80211:  DFS Master region: FCC
[   11.869381] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenn=
a_gain, max_eirp), (dfs_cac_time)
[   11.869388] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (N/A, 3=
000 mBm), (N/A)
[   11.869394] cfg80211:   (5170000 KHz - 5250000 KHz @ 80000 KHz, 160000 K=
Hz AUTO), (N/A, 3000 mBm), (N/A)
[   11.869399] R0: [kworker/u16:4][506801325] [15:45:26.863093]  wlan: [350=
:I :HDD] hdd_ipa_uc_register_uc_ready:802: UC Ready
[   11.869401] cfg80211:   (5250000 KHz - 5330000 KHz @ 80000 KHz, 160000 K=
Hz AUTO), (N/A, 2400 mBm), (0 s)
[   11.869406] cfg80211:   (5490000 KHz - 5730000 KHz @ 160000 KHz), (N/A, =
2400 mBm), (0 s)
[   11.869410] cfg80211:   (5735000 KHz - 5835000 KHz @ 80000 KHz), (N/A, 3=
000 mBm), (N/A)
[   11.869414] cfg80211:   (57240000 KHz - 70200000 KHz @ 2160000 KHz), (N/=
A, 4000 mBm), (N/A)
[   11.869431] R0: [kworker/u16:4][506801938] [15:45:26.863125]  wlan: [350=
:I :HDD] hdd_free_mac_address_lists: 9363: Resetting MAC address lists
[   11.869442] R0: [kworker/u16:4][506802148] [15:45:26.863136]  wlan: [350=
:I :HDD] hdd_platform_wlan_mac: 9475: provisioned MAC Addr [0]b4:f7:a1:c0:c=
4:e4
[   11.869453] R0: [kworker/u16:4][506802368] [15:45:26.863147]  wlan: [350=
:I :HDD] hdd_platform_wlan_mac: 9497: derived MAC Addr [0]b6:f7:a1:c0:c4:e4
[   11.869642] R0: [kworker/u16:4][506805994] [15:45:26.863336]  wlan: [350=
:I :HDD] wlan_hdd_get_provisioned_intf_addr: 2766: Assigning MAC from provi=
sioned listb4:f7:a1:c0:c4:e4
[   11.869691] R0: [kworker/u16:4][506806935] [15:45:26.863385]  wlan: [350=
:I :HDD] hdd_set_tso_flags: 2600: TSO Enabled
[   11.871185] R0: [kworker/u16:4][506835580] [15:45:26.864877]  wlan: [350=
:I :HDD] hdd_open_adapter: 4153: Disabling queues
[   11.871621] R0: [kworker/u16:4][506843959] [15:45:26.865313]  wlan: [350=
:I :HDD] hdd_open_adapter: 4271: wlan0 interface created. iftype: 0
[   11.871635] R0: [kworker/u16:4][506844225] [15:45:26.865327]  wlan: [350=
:E :HDD] wlan_hdd_get_provisioned_intf_addr: 2762: No free provisioned Addr=
esses
[   11.871646] R0: [kworker/u16:4][506844467] [15:45:26.865340]  wlan: [350=
:I :HDD] wlan_hdd_get_derived_intf_addr: 2748: Assigning MAC from derived l=
istb6:f7:a1:c0:c4:e4
[   11.871687] R0: [kworker/u16:4][506845259] [15:45:26.865381]  wlan: [350=
:I :HDD] hdd_set_tso_flags: 2600: TSO Enabled
[   11.872986] R0: [kworker/u16:4][506870151] [15:45:26.866677]  wlan: [350=
:I :HDD] hdd_open_adapter: 4153: Disabling queues
[   11.873151] R0: [kworker/u16:4][506873211] [15:45:26.866837]  wlan: [350=
:I :HDD] hdd_open_adapter: 4271: p2p0 interface created. iftype: 7
[   12.315717] NOHZ: local_softirq_pending 08
[   12.635974] NOHZ: local_softirq_pending 08
[   12.875438] NOHZ: local_softirq_pending 08
[   13.145672] NOHZ: local_softirq_pending 08
[   19.734919] type=3D1400 audit(1533422726.757:308): avc: denied { sys_adm=
in } for pid=3D2455 comm=3D"tc-wrapper-1.0" capability=3D21 scontext=3Du:r:=
netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability =
permissive=3D0
[   19.735116] type=3D1400 audit(1533422734.726:316): avc: denied { sys_adm=
in } for pid=3D2501 comm=3D"tc-wrapper-1.0" capability=3D21 scontext=3Du:r:=
netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability =
permissive=3D0
[   19.779570] type=3D1400 audit(1533422734.726:316): avc: denied { sys_adm=
in } for pid=3D2501 comm=3D"tc-wrapper-1.0" capability=3D21 scontext=3Du:r:=
netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability =
permissive=3D0
[   19.779636] type=3D1400 audit(1533422734.771:317): avc: denied { sys_adm=
in } for pid=3D2501 comm=3D"tc" capability=3D21 scontext=3Du:r:netutils_wra=
pper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permissive=
=3D0
[   19.803513] HTB: quantum of class 10010 is big. Consider r2q change.
[   19.815168] type=3D1400 audit(1533422734.771:317): avc: denied { sys_adm=
in } for pid=3D2501 comm=3D"tc" capability=3D21 scontext=3Du:r:netutils_wra=
pper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permissive=
=3D0
[   19.815222] type=3D1400 audit(1533422734.806:318): avc: denied { sys_adm=
in } for pid=3D2502 comm=3D"tc-wrapper-1.0" capability=3D21 scontext=3Du:r:=
netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability =
permissive=3D0
[   19.835623] type=3D1400 audit(1533422734.806:318): avc: denied { sys_adm=
in } for pid=3D2502 comm=3D"tc-wrapper-1.0" capability=3D21 scontext=3Du:r:=
netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability =
permissive=3D0
[   19.835671] type=3D1400 audit(1533422734.827:319): avc: denied { sys_adm=
in } for pid=3D2502 comm=3D"tc" capability=3D21 scontext=3Du:r:netutils_wra=
pper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permissive=
=3D0
[   19.858607] type=3D1400 audit(1533422734.827:319): avc: denied { sys_adm=
in } for pid=3D2502 comm=3D"tc" capability=3D21 scontext=3Du:r:netutils_wra=
pper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability permissive=
=3D0
[   19.858654] type=3D1400 audit(1533422734.850:320): avc: denied { sys_adm=
in } for pid=3D2503 comm=3D"tc-wrapper-1.0" capability=3D21 scontext=3Du:r:=
netutils_wrapper:s0 tcontext=3Du:r:netutils_wrapper:s0 tclass=3Dcapability =
permissive=3D0
[   19.871557] audit: audit_lost=3D262 audit_rate_limit=3D5 audit_backlog_l=
imit=3D64
[   19.871580] audit: rate limit exceeded
[   19.884449] HTB: quantum of class 10010 is big. Consider r2q change.
[   20.025707] HTB: quantum of class 10010 is big. Consider r2q change.
[   20.363950] HTB: quantum of class 10010 is big. Consider r2q change.
[   20.441669] HTB: quantum of class 10010 is big. Consider r2q change.
[   20.504323] HTB: quantum of class 10010 is big. Consider r2q change.
[   21.889778] R0: [kworker/2:2][699192160] [15:45:36.883449]  wlan: [1015:=
F :HDD] hdd_wlan_stop_modules: 10388: stop WLAN module: entering driver sta=
tus=3D1
[   21.889857] R0: [kworker/2:2][699193782] [15:45:36.883534]  wlan: [1015:=
I :HDD] hdd_wlan_stop_modules: 10420: Present Driver Status: 1
[   21.891712] R0: [kworker/2:2][699229315] [15:45:36.885385]  wlan: [1015:=
I :WMI] WMI Stop\x0a
[   21.918846] R0: [kworker/2:2][699750284] [15:45:36.912518]  wlan: [1015:=
I :TRX] Global Pool
[   21.962182] R0: [cds_mc_thread][700582562] [15:45:36.955866]  wlan: [245=
0:I :QDF] cds_mc_thread: MC thread signaled to shutdown
[   21.962215] R0: [cds_mc_thread][700583290] [15:45:36.955904]  wlan: [245=
0:I :QDF] cds_mc_thread: MC Thread exiting!!!!
[   21.962662] R0: [cds_ol_rx_threa][700591213] [15:45:36.956316]  wlan: [2=
451:I :QDF] cds_ol_rx_thread: Shutting down OL RX Thread
[   21.968799] R0: [kworker/2:2][700709676] [15:45:36.962486]  wlan: [1015:=
E :QDF] cds_remove_timer_from_sys_msg: 1251: gp_cds_sched_context is null
[   21.968839] R0: [kworker/2:2][700710475] [15:45:36.962528]  wlan: [1015:=
E :QDF] cds_remove_timer_from_sys_msg: 1251: gp_cds_sched_context is null
[   21.968871] R0: [kworker/2:2][700711091] [15:45:36.962560]  wlan: [1015:=
E :QDF] cds_remove_timer_from_sys_msg: 1251: gp_cds_sched_context is null
[   22.014945] R0: [kworker/2:2][701595666] [15:45:37.008632]  wlan: [1015:=
E :QDF] cds_get_context: Module ID 21 context is Null
[   22.016086] R0: [kworker/2:2][701617648] [15:45:37.009776]  wlan: [1015:=
I :HDD] hdd_wlan_stop_modules: 10508: Wlan transition (now CLOSED)
[   22.016104] R0: [kworker/2:2][701618004] [15:45:37.009795]  wlan: [1015:=
F :HDD] hdd_wlan_stop_modules: 10515: stop WLAN module: exit driver status=
=3D3
[   32.612295] lge_battery: bm_check_step_charging: STATE[0->2] CUR[2400000=
] VOL[4368885]
[   32.612679] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[   32.612740] lge_battery: bm_watch_work: PRESENT:1, CHG_STAT:1, THM_STAT:=
2, BAT_TEMP:270, BAT_VOLT:4368885, VOTE_CUR:1000000, SET_CUR:1000000=20
[   62.692703] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[   62.692871] lge_battery: bm_watch_work: PRESENT:1, CHG_STAT:1, THM_STAT:=
2, BAT_TEMP:270, BAT_VOLT:4368885, VOTE_CUR:1000000, SET_CUR:1000000=20
[   65.328456] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[   65.332264] healthd: battery l=3D96 v=3D4369 t=3D27.0 h=3D2 st=3D2 c=3D-=
370 fc=3D3680000 cc=3D25 chg=3Du
[   65.392474] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[   65.397921] healthd: battery l=3D96 v=3D4369 t=3D27.0 h=3D2 st=3D2 c=3D-=
370 fc=3D3680000 cc=3D25 chg=3Du
[   88.273912] mdss_fb_set_backlight: backlight sent to panel :32
[   88.284376] mdss_fb_set_backlight: backlight sent to panel :31
[   90.555785] mdss_fb_set_backlight: backlight sent to panel :29
[   90.579514] mdss_fb_set_backlight: backlight sent to panel :26
[   90.595214] mdss_fb_set_backlight: backlight sent to panel :23
[   90.611600] mdss_fb_set_backlight: backlight sent to panel :20
[   90.628404] mdss_fb_set_backlight: backlight sent to panel :18
[   90.645190] mdss_fb_set_backlight: backlight sent to panel :15
[   90.668826] mdss_fb_set_backlight: backlight sent to panel :13
[   92.768670] FG: fg_get_battery_temp: batt temperature original:300, tune=
d:270
[   92.768753] lge_battery: bm_watch_work: PRESENT:1, CHG_STAT:1, THM_STAT:=
2, BAT_TEMP:270, BAT_VOLT:4369129, VOTE_CUR:1000000, SET_CUR:1000000=20
[   93.093363] mdss_fb_set_backlight: backlight sent to panel :0
[   93.129625] fts_touch 5-0049: fts_suspend power state : 0
[   93.129631] fts_touch 5-0049: fts_stop_device lowpower flag:0
[   93.130931] fts_touch 5-0049: fts_suspend: switch i2c to SLPI (set to 1)
[   93.145871] mdss_fb_blank_sub: mdss_fb_blank+0x98/0x1b0 mode:4
[   93.277923] lge_battery: bm_vote_fcc_update: vote id[2], set cur[2400000]

--TB36FDmn/VVEgNH/--
