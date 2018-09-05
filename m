Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3260EC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93E72086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93E72086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbeIENa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:30:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33506 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbeIENa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:30:26 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 11FEFD66;
        Wed,  5 Sep 2018 09:01:11 +0000 (UTC)
Date:   Wed, 5 Sep 2018 11:01:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.18 000/123] 4.18.6-stable review
Message-ID: <20180905090110.GC30538@kroah.com>
References: <20180903165719.499675257@linuxfoundation.org>
 <20180904162434.GA16396@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904162434.GA16396@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 09:24:34AM -0700, Guenter Roeck wrote:
> On Mon, Sep 03, 2018 at 06:55:44PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.18.6 release.
> > There are 123 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Sep  5 16:56:53 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Not directly related to v4.18.6-rc1. I have seen the following hang
> several times with v4.18.5. It happens on a quite regular basis after
> a suspend-resume cycle. CPU is Ryzen 1700X.
> 
> Guenter
> 
> ---
> [ 9990.754641] watchdog: BUG: soft lockup - CPU#5 stuck for 22s! [kworker/5:1:155]
> [ 9990.762549] Modules linked in: ipt_REJECT nf_reject_ipv4 xt_multiport sp5100_tco squashfs iptable_filter snd_hda_codec_hdmi binfmt_misc edac_mce_amd kvm snd_hda_codec_realtek irqbypass snd_hda_codec_generic snd_seq_midi snd_seq_midi_event crct10dif_pclmul ghash_clmulni_intel snd_rawmidi aesni_intel snd_hda_intel aes_x86_64 crypto_simd cryptd glue_helper snd_hda_codec snd_hda_core wmi_bmof snd_hwdep snd_seq snd_pcm k10temp snd_seq_device snd_timer snd soundcore sch_fq_codel parport_pc sunrpc ppdev lp parport ip_tables x_tables autofs4 hid_generic nouveau mxm_wmi video ttm drm_kms_helper usbhid syscopyarea sysfillrect hid sysimgblt igb fb_sys_fops dca drm i2c_algo_bit i2c_piix4 i2c_core r8169 ahci mii libahci wmi
> [ 9990.762589] CPU: 5 PID: 155 Comm: kworker/5:1 Tainted: G             L    4.18.5+ #1
> [ 9990.762591] Hardware name: Gigabyte Technology Co., Ltd. AB350M-Gaming 3/AB350M-Gaming 3-CF, BIOS F23 08/08/2018
> [ 9990.762596] Workqueue: events free_work
> [ 9990.762601] RIP: 0010:smp_call_function_many+0x208/0x270
> [ 9990.762601] Code: e8 0d d1 77 00 3b 05 cb f0 24 01 0f 83 86 fe ff ff 48 63 d0 49 8b 0c 24 48 03 0c d5 00 f7 11 a7 8b 51 18 83 e2 01 74 0a f3 90 <8b> 51 18 83 e2 01 75 f6 eb c7 0f b6 4d d0 4c 89 f2 4c 89 ee 44 89 
> [ 9990.762626] RSP: 0018:ffff95ebc3effd20 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [ 9990.762628] RAX: 000000000000000c RBX: ffff94eeded63cc8 RCX: ffff94eedef27bc0
> [ 9990.762629] RDX: 0000000000000001 RSI: 0000000000000100 RDI: ffff94eeded63cc8
> [ 9990.762630] RBP: ffff95ebc3effd60 R08: 00000000fffffff0 R09: 00000000000000ff
> [ 9990.762631] R10: ffff94eeded63ce8 R11: ffff94eeded63cc8 R12: ffff94eeded63cc0
> [ 9990.762632] R13: ffffffffa6076150 R14: 0000000000000000 R15: 0000000000000100
> [ 9990.762633] FS:  0000000000000000(0000) GS:ffff94eeded40000(0000) knlGS:0000000000000000
> [ 9990.762635] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 9990.762636] CR2: 0000000000a67000 CR3: 00000006f120c000 CR4: 00000000003406e0
> [ 9990.762637] Call Trace:
> [ 9990.762642]  ? load_new_mm_cr3+0xe0/0xe0
> [ 9990.762644]  on_each_cpu+0x2d/0x60
> [ 9990.762647]  flush_tlb_kernel_range+0x4b/0x80
> [ 9990.762648]  ? vunmap_page_range+0x1fe/0x310
> [ 9990.762650]  __purge_vmap_area_lazy+0x50/0xb0
> [ 9990.762652]  free_vmap_area_noflush+0x7d/0x90
> [ 9990.762654]  remove_vm_area+0x74/0x80
> [ 9990.762656]  __vunmap+0x3b/0xc0
> [ 9990.762657]  free_work+0x25/0x40
> [ 9990.762660]  process_one_work+0x15e/0x3f0
> [ 9990.762662]  worker_thread+0x4a/0x440
> [ 9990.762664]  kthread+0x105/0x140
> [ 9990.762666]  ? process_one_work+0x3f0/0x3f0
> [ 9990.762668]  ? kthread_destroy_worker+0x50/0x50
> [ 9990.762670]  ret_from_fork+0x22/0x40

Odd.  Do you see this on Linus's tree?

thanks,

greg k-h
