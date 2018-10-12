Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F98C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E6820865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VpvLH3fR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E6820865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbeJLUMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:12:20 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10579 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbeJLUMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:12:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc096250000>; Fri, 12 Oct 2018 05:40:05 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 12 Oct 2018 05:40:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 12 Oct 2018 05:40:02 -0700
Received: from [10.21.132.143] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 12 Oct
 2018 12:40:00 +0000
Subject: Re: PROBLEM: brcmfmac driver crashes on resuming if no firmware is
 loaded
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <arend.vanspriel@broadcom.com>
CC:     linux-tegra <linux-tegra@vger.kernel.org>
References: <abf41feb-266f-eca5-72bc-6ee6fed207be@nvidia.com>
Message-ID: <f7141681-6f23-96ac-adef-8e8b30376a09@nvidia.com>
Date:   Fri, 12 Oct 2018 13:39:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <abf41feb-266f-eca5-72bc-6ee6fed207be@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539348005; bh=UexMfqUejzmBrezW2pMtD09siFhOphf8ecMbgwF8U3A=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=VpvLH3fR5GeuDAPKU/Mx7qCbC2Ea8PiPlO65OTe3DdBKMKlCRn7PEHzOceGQoqATA
         KLarLyJDDh0Nffu5C3QC/s7btcHxDffqZjy6GF1nSyRGy1F5l3BLGhXngJPhVakgfD
         G+8n5tsjDHUIPUi8JbL3jVIla3ppNdkMRIeIkNycINcxKxpc0hp/xgAhTpqZ3uak0w
         8ZNTcTgerru2VDzsPLT83We2oEYX+oDrwtv9vEncBWJghDqDi3zO3i4LTvWIReOL7S
         yFUYjhIoSmQeakU9aKd6YAO+x7hedyg+ONZX9Mu8uWls0QdC1FfPHK5A3G2qnwgCft
         5kO9EBBeJncFw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correcting stable address ...

On 12/10/18 13:37, Jon Hunter wrote:
> [1.] One line summary of the problem:
>      brcmfmac driver crashes on resuming if no firmware is loaded
> 
> [2.] Full description of the problem/report:
>      In stable-v4.4, if the brcmfmac driver fails to load the required
>      firmware on boot for an SDIO based device, then the driver fails
>      to remove one of  the two devices it registered during probe with
>      the kernel. If the kernel then enters suspend, on resume the
>      kernel tries to resume the device registered by brcmfmac driver
>      and crashes due to a NULL pointer deference (see 6 below). 
> 
>      This issue is seen in stable-v4.4 but not in stable-v4.9 and I
>      believe is fixed by commit 7a51461fc2da ("brcmfmac: unbind all
>      devices upon failure in firmware callback"). Unfortunately, this
>      fix is dependent on other changes and so is not easily
>      back-ported AFAICT.
> 
>      This issue is seen on Tegra20 Ventana and Tegra30 Cardhu.
> 
> [3.] Keywords (i.e., modules, networking, kernel):
>      BROADCOM BRCM80211
> 
> [4.] Kernel information
> [4.1.] Kernel version (from /proc/version):
>        Linux version 4.4.160-rc1-00116-g5826f1d1ce56
> [4.2.] Kernel .config file:
>        Generated using tegra_defconfig
> 
> [5.] Most recent kernel version which did not have the bug:
>      Not seen in current mainline or -next.
> 
> [6.] Output of Oops.. message (if applicable) with symbolic information
> 
> [   51.941094] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> 
> [   51.949836] pgd = eee54000
> 
> [   51.952771] [00000000] *pgd=2db16831, *pte=00000000, *ppte=00000000
> 
> [   51.959722] Internal error: Oops: 17 [#1] SMP ARM
> 
> [   51.964774] Modules linked in: snd_soc_tegra_wm8903 snd_soc_wm8903 snd_soc_tegra_utils snd_soc_core snd_pcm_dmaengine snd_pcm brcmfmac brcmutil cfg80211 snd_timer snd soundcore ac97_bus snd_soc_tegra20_das
> 
> [   51.984922] CPU: 1 PID: 512 Comm: rtcwake Not tainted 4.4.160-rc1-00116-g5826f1d1ce56 #1
> 
> [   51.993577] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> 
> [   52.000303] task: eefa3900 ti: ed93c000 task.ti: ed93c000
> 
> [   52.006294] PC is at brcmf_ops_sdio_resume+0x10/0x5c [brcmfmac]
> 
> [   52.012672] LR is at pm_generic_resume+0x2c/0x38
> 
> [   52.017641] pc : [<bf12bbb8>]    lr : [<c06502d4>]    psr: 60000113
> 
> [   52.017641] sp : ed93ddb8  ip : eed72e74  fp : c0f4a2d8
> 
> [   52.029914] r10: c0fa7580  r9 : 00000010  r8 : 00000000
> 
> [   52.035522] r7 : 00000010  r6 : eed7303c  r5 : 00000001  r4 : c06502a8
> 
> [   52.042514] r3 : 00000000  r2 : 00000002  r1 : eed73008  r0 : eed73008
> 
> [   52.049511] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> 
> [   52.057156] Control: 10c5387d  Table: 2ee5404a  DAC: 00000051
> 
> [   52.063319] Process rtcwake (pid: 512, stack limit = 0xed93c220)
> 
> [   52.069761] Stack: (0xed93ddb8 to 0xed93e000)
> 
> [   52.074450] dda0:                                                       c06502a8 c06502d4
> 
> [   52.083225] ddc0: c0cae914 c0653674 17c10408 c027fc00 eed72e08 eed73008 00000001 c0653cdc
> 
> [   52.091993] dde0: eed73070 eed73008 c0fa7548 c0fa7578 c104ce7c c0655018 c0f4a2d8 c0654ee8
> 
> [   52.100757] de00: 0ea73a40 0000000c 0ea73a40 0000000c 0e3050d8 00000010 00000003 00000000
> 
> [   52.109529] de20: c0f1650c c10109f4 c0f170a4 00000000 00000000 c06552e8 c10109f4 c02870b0
> 
> [   52.118399] de40: 00000000 c028a464 c0d3b71c ed93de6c c0f49314 c02cd350 00000003 c10109f4
> 
> [   52.127166] de60: 00000003 00000000 00000003 edbb45c0 00000004 00000000 00000000 c0287540
> 
> [   52.135933] de80: 00000003 c0c8401c c1010a04 c02862fc 00000004 ee8f86e0 edbb45c0 edbb4fcc
> 
> [   52.144698] dea0: 00000004 ed93df80 00028290 c048c684 00000004 c036dec8 c036de84 edbb4fc0
> 
> [   52.169613] dec0: edbb45c0 c036d70c 00000000 00000000 000081a4 c0a0113c 00028290 eee13b40
> 
> [   52.194484] dee0: ed93df80 00000004 00028290 00000000 00000005 c030f990 c0f1ba64 ed93dfb0
> 
> [   52.219219] df00: 00002710 000001ff b6fb42e4 c020a29c 5a9fd343 0b532b80 5a9fd343 0b532b80
> 
> [   52.244031] df20: 0000050e 00000000 eee13b40 becb54b8 00028128 00028128 000000c5 eee13b40
> 
> [   52.268893] df40: eee13b40 00028290 ed93df80 00000004 00000004 c031018c 0000000f 000081a4
> 
> [   52.293765] df60: 00000001 00000000 00000000 eee13b40 eee13b40 00000004 00028290 c0310994
> 
> [   52.318818] df80: 00000000 00000000 5a9fd343 00000004 00028290 00028128 00000004 c0210c44
> 
> [   52.343980] dfa0: ed93c000 c0210a80 00000004 00028290 00000004 00028290 00000004 00000000
> 
> [   52.369292] dfc0: 00000004 00028290 00028128 00000004 00014f40 00026180 00014ca4 00000005
> 
> [   52.394701] dfe0: 00000000 becb5a1c b6f3479b b6f700d6 000f0030 00000004 00000000 00000000
> 
> [   52.420294] [<bf12bbb8>] (brcmf_ops_sdio_resume [brcmfmac]) from [<c06502d4>] (pm_generic_resume+0x2c/0x38)
> 
> [   52.447649] [<c06502d4>] (pm_generic_resume) from [<c0653674>] (dpm_run_callback+0x1c/0x58)
> 
> [   52.474009] [<c0653674>] (dpm_run_callback) from [<c0653cdc>] (device_resume+0x98/0x260)
> 
> [   52.500177] [<c0653cdc>] (device_resume) from [<c0655018>] (dpm_resume+0x100/0x228)
> 
> [   52.525931] [<c0655018>] (dpm_resume) from [<c06552e8>] (dpm_resume_end+0xc/0x18)
> 
> [   52.551807] [<c06552e8>] (dpm_resume_end) from [<c02870b0>] (suspend_devices_and_enter+0x124/0x420)
> 
> [   52.579701] [<c02870b0>] (suspend_devices_and_enter) from [<c0287540>] (pm_suspend+0x194/0x254)
> 
> [   52.607599] [<c0287540>] (pm_suspend) from [<c02862fc>] (state_store+0x6c/0xbc)
> 
> [   52.634364] [<c02862fc>] (state_store) from [<c048c684>] (kobj_attr_store+0x14/0x20)
> 
> [   52.661518] [<c048c684>] (kobj_attr_store) from [<c036dec8>] (sysfs_kf_write+0x44/0x48)
> 
> [   52.688909] [<c036dec8>] (sysfs_kf_write) from [<c036d70c>] (kernfs_fop_write+0xbc/0x1b0)
> 
> [   52.716566] [<c036d70c>] (kernfs_fop_write) from [<c030f990>] (__vfs_write+0x24/0xd8)
> 
> [   52.743917] [<c030f990>] (__vfs_write) from [<c031018c>] (vfs_write+0x94/0x154)
> 
> [   52.770230] [<c031018c>] (vfs_write) from [<c0310994>] (SyS_write+0x40/0x94)
> 
> [   52.795713] [<c0310994>] (SyS_write) from [<c0210a80>] (ret_fast_syscall+0x0/0x48)
> 
> [   52.821478] Code: e92d4010 e590218c e5903058 e3520002 (e5934000) 
> 
> [   52.845762] ---[ end trace d797b5b1ce195377 ]---
> 

-- 
nvpublic
