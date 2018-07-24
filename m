Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C760BECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB5920875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=contabo.de header.i=@contabo.de header.b="0EkFfXgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB5920875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=contabo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388571AbeGXIfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:35:43 -0400
Received: from mail.contabo.com ([91.205.175.50]:43218 "EHLO mail.contabo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388351AbeGXIfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=contabo.de;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lgtPtF2NKQgpSOvCzL1nYacAvclE8PGki1YgjH2vKjw=; b=0EkFfXgBOt2xWoauDIwskH7czd
        vBo6YSt3NGl80LoMv4pq3de27u8p+YkjWtvXaxm1WIdMkzNTeUSPLgvdhSmtUcopbIcheyvIVnh8P
        7AwJTOcbyLqS6GFSaK6AQAVku+IXDrueCCXaz0MXeDB/N31KFTYrst9OO4crOvOTSOlok3VHxvpvj
        GzHcFgyVsdqhtUeZrF9vnYSzFu3CWPtn7y9RT2kOQtpbBq55AUgolSMX2gc780nXyFB5lOrCoA/mA
        /6KRC1jsqqdGnCJ2ZC3Vn7WCdjC8JhWw3nqGVJBAxalIeyAXrMcWsz+uCGZvNeOOn644aDb3Rcsz9
        QB7trr/w==;
Received: from [178.238.239.246] (port=6686 helo=[192.168.178.123])
        by mail.contabo.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <tino.lehnig@contabo.de>)
        id 1fhrmE-0005nY-LG; Tue, 24 Jul 2018 09:30:34 +0200
Subject: Re: Zram writeback feature unstable with heavy swap utilization -
 BUG: Bad page state in process...
To:     Minchan Kim <minchan@kernel.org>
Cc:     ngupta@vflare.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <0516ae2d-b0fd-92c5-aa92-112ba7bd32fc@contabo.de>
 <20180724010342.GA195675@rodete-desktop-imager.corp.google.com>
From:   Tino Lehnig <tino.lehnig@contabo.de>
Message-ID: <d4f4b5a1-9e31-375d-0599-b6d8b0ebc9df@contabo.de>
Date:   Tue, 24 Jul 2018 09:30:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724010342.GA195675@rodete-desktop-imager.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mail.contabo.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - contabo.de
X-Get-Message-Sender-Via: mail.contabo.com: authenticated_id: tino.lehnig@contabo.de
X-Authenticated-Sender: mail.contabo.com: tino.lehnig@contabo.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The first build I used was from the master branch of the mainline 
kernel, somewhere between rc5 and rc6. I have just reproduced the bug 
with 4.17.9 and 4.18-rc6. Kernel messages below.

The bug does not appear on 4.14.57. I can test more versions if it helps.

On 07/24/2018 03:03 AM, Minchan Kim wrote:
> We didn't release v4.18 yet. Could you say what kernel tree/what version
> you used?

--

[  804.485321] BUG: Bad page state in process qemu-system-x86  pfn:1c4b08e
[  804.485403] page:ffffe809312c2380 count:0 mapcount:0 
mapping:0000000000000000 index:0x1
[  804.485483] flags: 0x17fffc000000008(uptodate)
[  804.485554] raw: 017fffc000000008 0000000000000000 0000000000000001 
00000000ffffffff
[  804.485632] raw: dead000000000100 dead000000000200 0000000000000000 
0000000000000000
[  804.485709] page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag set
[  804.485782] bad because of flags: 0x8(uptodate)
[  804.485852] Modules linked in: lz4 lz4_compress zram zsmalloc 
intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp 
kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul 
ghash_clmulni_intel pcb
c aesni_intel aes_x86_64 crypto_simd cryptd iTCO_wdt glue_helper 
iTCO_vendor_support intel_cstate binfmt_misc intel_uncore 
intel_rapl_perf pcspkr mei_me lpc_ich joydev sg mfd_core mei ioatdma 
shpchp wmi evdev ipmi_si ipmi_devintf ipmi_msgh
andler acpi_power_meter acpi_pad button ip_tables x_tables autofs4 ext4 
crc32c_generic crc16 mbcache jbd2 fscrypto hid_generic usbhid hid sd_mod 
ahci libahci xhci_pci ehci_pci libata igb xhci_hcd ehci_hcd crc32c_intel 
i2c_algo_bit scsi_mod
  i2c_i801 dca usbcore
[  804.485890] CPU: 17 PID: 1165 Comm: qemu-system-x86 Not tainted 4.17.9 #1
[  804.485891] Hardware name: Supermicro Super Server/X10SRL-F, BIOS 
2.0b 05/02/2017
[  804.485891] Call Trace:
[  804.485899]  dump_stack+0x5c/0x7b
[  804.485902]  bad_page+0xba/0x120
[  804.485905]  get_page_from_freelist+0x1016/0x1250
[  804.485908]  __alloc_pages_nodemask+0xfa/0x250
[  804.485911]  alloc_pages_vma+0x7c/0x1c0
[  804.485915]  __handle_mm_fault+0xcf6/0x1110
[  804.485918]  handle_mm_fault+0xfc/0x1f0
[  804.485921]  __get_user_pages+0x12f/0x670
[  804.485923]  get_user_pages_unlocked+0x148/0x1f0
[  804.485945]  __gfn_to_pfn_memslot+0xff/0x390 [kvm]
[  804.485959]  try_async_pf+0x67/0x200 [kvm]
[  804.485971]  tdp_page_fault+0x132/0x290 [kvm]
[  804.485975]  ? vmexit_fill_RSB+0xc/0x30 [kvm_intel]
[  804.485987]  kvm_mmu_page_fault+0x59/0x140 [kvm]
[  804.485999]  kvm_arch_vcpu_ioctl_run+0x9b3/0x1990 [kvm]
[  804.486003]  ? futex_wake+0x94/0x170
[  804.486012]  ? kvm_vcpu_ioctl+0x388/0x5d0 [kvm]
[  804.486021]  kvm_vcpu_ioctl+0x388/0x5d0 [kvm]
[  804.486024]  ? __switch_to+0x395/0x450
[  804.486026]  ? __switch_to+0x395/0x450
[  804.486029]  do_vfs_ioctl+0xa2/0x620
[  804.486030]  ? __x64_sys_futex+0x88/0x180
[  804.486032]  ksys_ioctl+0x70/0x80
[  804.486034]  __x64_sys_ioctl+0x16/0x20
[  804.486037]  do_syscall_64+0x55/0x100
[  804.486039]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  804.486041] RIP: 0033:0x7f82db677dd7
[  804.486042] RSP: 002b:00007f82c1ffa8b8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[  804.486044] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 
00007f82db677dd7
[  804.486044] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 
0000000000000014
[  804.486045] RBP: 000055b592a1ddf0 R08: 000055b5914bb3d0 R09: 
00000000ffffffff
[  804.486046] R10: 00007f82c1ffa670 R11: 0000000000000246 R12: 
0000000000000000
[  804.486047] R13: 00007f82e0cc6000 R14: 0000000000000000 R15: 
000055b592a1ddf0
[  804.486048] Disabling lock debugging due to kernel taint

--

[  170.707761] BUG: Bad page state in process qemu-system-x86  pfn:1901199
[  170.707842] page:ffffe453e4046640 count:0 mapcount:0 
mapping:0000000000000000 index:0x1
[  170.707923] flags: 0x17fffc000000008(uptodate)
[  170.707996] raw: 017fffc000000008 dead000000000100 dead000000000200 
0000000000000000
[  170.708074] raw: 0000000000000001 0000000000000000 00000000ffffffff 
0000000000000000
[  170.708151] page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag set
[  170.708225] bad because of flags: 0x8(uptodate)
[  170.708295] Modules linked in: lz4 lz4_compress zram zsmalloc 
intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp 
kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul 
ghash_clmulni_intel iTCO_wdt iTCO_vendor_support binfmt_misc pcbc 
aesni_intel aes_x86_64 crypto_simd cryptd glue_helper intel_cstate 
mei_me intel_uncore lpc_ich intel_rapl_perf pcspkr joydev sg mfd_core 
mei ioatdma wmi evdev ipmi_si ipmi_devintf ipmi_msghandler 
acpi_power_meter acpi_pad pcc_cpufreq button ip_tables x_tables autofs4 
ext4 crc32c_generic crc16 mbcache jbd2 fscrypto hid_generic usbhid hid 
sd_mod ahci libahci libata xhci_pci ehci_pci crc32c_intel xhci_hcd 
ehci_hcd scsi_mod i2c_i801 igb i2c_algo_bit dca usbcore
[  170.708344] CPU: 8 PID: 1031 Comm: qemu-system-x86 Not tainted 
4.18.0-rc6 #1
[  170.708345] Hardware name: Supermicro Super Server/X10SRL-F, BIOS 
2.0b 05/02/2017
[  170.708346] Call Trace:
[  170.708354]  dump_stack+0x5c/0x7b
[  170.708357]  bad_page+0xba/0x120
[  170.708360]  get_page_from_freelist+0x1016/0x1250
[  170.708364]  __alloc_pages_nodemask+0xfa/0x250
[  170.708368]  alloc_pages_vma+0x7c/0x1c0
[  170.708371]  do_swap_page+0x347/0x920
[  170.708375]  ? do_huge_pmd_anonymous_page+0x461/0x6f0
[  170.708377]  __handle_mm_fault+0x7b4/0x1110
[  170.708380]  ? call_function_interrupt+0xa/0x20
[  170.708383]  handle_mm_fault+0xfc/0x1f0
[  170.708385]  __get_user_pages+0x12f/0x690
[  170.708387]  get_user_pages_unlocked+0x148/0x1f0
[  170.708415]  __gfn_to_pfn_memslot+0xff/0x3c0 [kvm]
[  170.708433]  try_async_pf+0x87/0x230 [kvm]
[  170.708450]  tdp_page_fault+0x132/0x290 [kvm]
[  170.708455]  ? vmexit_fill_RSB+0xc/0x30 [kvm_intel]
[  170.708470]  kvm_mmu_page_fault+0x74/0x570 [kvm]
[  170.708474]  ? vmexit_fill_RSB+0xc/0x30 [kvm_intel]
[  170.708477]  ? vmexit_fill_RSB+0x18/0x30 [kvm_intel]
[  170.708480]  ? vmexit_fill_RSB+0xc/0x30 [kvm_intel]
[  170.708484]  ? vmexit_fill_RSB+0x18/0x30 [kvm_intel]
[  170.708487]  ? vmexit_fill_RSB+0xc/0x30 [kvm_intel]
[  170.708490]  ? vmexit_fill_RSB+0x18/0x30 [kvm_intel]
[  170.708493]  ? vmexit_fill_RSB+0xc/0x30 [kvm_intel]
[  170.708497]  ? vmexit_fill_RSB+0x18/0x30 [kvm_intel]
[  170.708500]  ? vmexit_fill_RSB+0xc/0x30 [kvm_intel]
[  170.708503]  ? vmexit_fill_RSB+0x18/0x30 [kvm_intel]
[  170.708506]  ? vmexit_fill_RSB+0xc/0x30 [kvm_intel]
[  170.708510]  ? vmx_vcpu_run+0x375/0x620 [kvm_intel]
[  170.708526]  kvm_arch_vcpu_ioctl_run+0x9b3/0x1990 [kvm]
[  170.708529]  ? futex_wake+0x94/0x170
[  170.708542]  ? kvm_vcpu_ioctl+0x388/0x5d0 [kvm]
[  170.708555]  kvm_vcpu_ioctl+0x388/0x5d0 [kvm]
[  170.708558]  ? __handle_mm_fault+0x7c4/0x1110
[  170.708561]  do_vfs_ioctl+0xa2/0x630
[  170.708563]  ? __x64_sys_futex+0x88/0x180
[  170.708565]  ksys_ioctl+0x70/0x80
[  170.708568]  ? exit_to_usermode_loop+0xca/0xf0
[  170.708570]  __x64_sys_ioctl+0x16/0x20
[  170.708572]  do_syscall_64+0x55/0x100
[  170.708574]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  170.708577] RIP: 0033:0x7fc9e4889dd7
[  170.708577] Code: 00 00 00 48 8b 05 c1 80 2b 00 64 c7 00 26 00 00 00 
48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 91 80 2b 00 f7 d8 64 89 01 48
[  170.708610] RSP: 002b:00007fc9c27fb8b8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[  170.708612] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 
00007fc9e4889dd7
[  170.708613] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 
0000000000000015
[  170.708614] RBP: 000055dbb5f263e0 R08: 000055dbb34f03d0 R09: 
00000000ffffffff
[  170.708616] R10: 00007fc9c27fb670 R11: 0000000000000246 R12: 
0000000000000000
[  170.708617] R13: 00007fc9e9ed5000 R14: 0000000000000000 R15: 
000055dbb5f263e0
[  170.708618] Disabling lock debugging due to kernel taint

--
Kind regards,

Tino Lehnig
