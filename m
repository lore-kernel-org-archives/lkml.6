Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D17ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2884A20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqsRvL8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2884A20BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387613AbeGLXkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 19:40:04 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37181 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733105AbeGLXkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 19:40:04 -0400
Received: by mail-oi0-f66.google.com with SMTP id k81-v6so58966918oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 16:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U6WHdTGn5G/SxjqKa4FXguuszgrrz13dAdr9MVorrhk=;
        b=TqsRvL8rqbarcvq8AOlZ12ssQCb65F+mGNFKXPqeyXTsY097T+qjeYs4cHmxRb4/yU
         L1FmEPOb+jbm4F4+EryK9bTq4VXJA3Jr3iMTQRuJiDoCxdSqSN+QVmp49zvtOtCf3soj
         moHUyquD4ZR1Y5IuZjMoyziYhpsU6dGLBRflU/T2XGfjYk91MDB0dgIW3Dnkg9wyCG4E
         TBkrwDvnXw2DF6ybLzridQyvRDJFHQhzBxXe8OVFc5tB3TBZR1XE8nxjAOHispKM/p9O
         1u/0UEIdQvX+ukb6DBdiAivwKO2YJEeYlQ6HUoHew5gOXZBip8/OoyXjydSQyGQm9Kge
         lffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U6WHdTGn5G/SxjqKa4FXguuszgrrz13dAdr9MVorrhk=;
        b=pLiwZEhw6GbJY7pXXCH6bf8k91Pc12uxJi5hY4D+GPoJmviK93TTyMjOutpcYddshg
         qUOxItcRMrnOQ0PflV/lkyweGVswkuarTsfQiOzklQT789Wo82WUnxxttl4t6Do47x3M
         jhkUHgZKaTyFhHm7hMBkp94zniZZa1g9IV/lGDAW5J2GQIHjjPYm/r0GaFvp9NaTfhOM
         M2T52fmMqJOSv1Uto+91qewbwXPyF29R1v0Pty9s9JPqX1Vf5fWHzQzks+YUiuKwOuuo
         pvt0S9UUC9UQ4LVD5HNMMR1dd1waPYVGgKqlx74bpg2oi8CYMWtVFv6uLHJnuIQgNeHp
         FRNw==
X-Gm-Message-State: AOUpUlHlTMnxXtNm4NCidlWY1T7Mo/QvM3H7nAAkElpqcaAg5LDkx3c9
        mv8w/ctksENPqAmLcimZtSgs6vgTkmdz8FUVbFSZPg==
X-Google-Smtp-Source: AAOMgpc7nwHOz4OmKkDSz+UaktbV17prJqafz6si9N92fXpZ9V0n+GRmfPEJ2G7GUL31+3kyrLMi7loSP5nV2qIlfVo=
X-Received: by 2002:aca:5754:: with SMTP id l81-v6mr4895794oib.100.1531438094941;
 Thu, 12 Jul 2018 16:28:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c984:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 16:28:14
 -0700 (PDT)
In-Reply-To: <CAMe9rOpBm71hnzG0wx=2qaWKHYNE30JJOT=Jt4i+Vqs3Xb4qBQ@mail.gmail.com>
References: <9548e10a-7403-425e-bf1f-b1eb9d055d99@intel.com>
 <CAMe9rOrHowBX06nihdRRmEqhV8v7cs+PwVY7JYQFpUFOnHC71A@mail.gmail.com>
 <f22ee1e2-9a35-697f-50ab-543ac1631c89@intel.com> <CAMe9rOpPwtPd-R+D9=iDYgbFtnP+=akWic-QBKwq9wKa7uadEQ@mail.gmail.com>
 <2022d212-62f2-a163-2493-abecfbafa07b@intel.com> <CAMe9rOqc0oVw+ZLXCM-nrtPb1OiPFBeHt+Lsx+6K6y=t3HSVhA@mail.gmail.com>
 <cbb38230-9c57-905b-3a11-e2717c5aa615@intel.com> <CAMe9rOqh9saaULM_+jNtzfYarbZScm+6KCEyibxxqn7GLvKwzA@mail.gmail.com>
 <CAMe9rOpV89jWhvAZtqOJnc0eXzRYiLF5pLWRcdb7-kKLigj4rQ@mail.gmail.com>
 <067e2d5d-1abf-efd4-cb50-992ba5ca6748@intel.com> <20180711183126.yo7eyqpd4ggb5kcr@codemonkey.org.uk>
 <9A6C6EEB-85D8-4F59-95ED-EB4DA5947BCA@amacapital.net> <f3e2ca08-e22d-f16c-1c2e-9fb1985771ef@intel.com>
 <CAMe9rOpBm71hnzG0wx=2qaWKHYNE30JJOT=Jt4i+Vqs3Xb4qBQ@mail.gmail.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 12 Jul 2018 16:28:14 -0700
Message-ID: <CAMe9rOoX-x-YezXc_1EE9F0Nv3_SuzN+paXsTO11gcTykMr4Tw@mail.gmail.com>
Subject: Re: Kernel 4.17.4 lockup
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Dave Jones <davej@codemonkey.org.uk>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 7:44 AM, H.J. Lu <hjl.tools@gmail.com> wrote:
> On Wed, Jul 11, 2018 at 4:14 PM, Dave Hansen <dave.hansen@intel.com> wrot=
e:
>> On 07/11/2018 04:07 PM, Andy Lutomirski wrote:
>>> Could the cause be an overflow of the IRQ stack?  I=E2=80=99ve been mea=
ning
>>> to put guard pages on all the special stacks for a while. Let me see
>>> if I can do that in the next couple days.
>>
>> But what would that overflow into?  Wouldn't it most likely be another
>> interrupt stack since they're all allocated together?
>>
>> This looks more like thread stack corruption.
>
> I tried netconsole and got this:
>
> [29369.552998] ------------[ cut here ]------------
> [29369.560996] kernel BUG at mm/page_alloc.c:2019!
> [29369.568980] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
> [29369.576892] Modules linked in: netconsole xt_CHECKSUM
> ipt_MASQUERADE nf_nat_masquerade_ipv4 tun nf_conntrack_netbios_ns
> nf_conntrack_broadcast xt_CT ip6t_rpfilter ip6t_REJECT nf_reject_ipv6
> xt_conntrack devlink ip_set nfnetlink ebtable_nat ebtable_broute
> bridge stp llc ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6
> nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat
> nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack
> libcrc32c iptable_mangle iptable_raw iptable_security ebtable_filter
> ebtables ip6table_filter ip6_tables sunrpc vfat fat intel_powerclamp
> coretemp kvm_intel kvm irqbypass intel_cstate intel_uncore
> snd_hda_codec_realtek snd_hda_codec_generic iTCO_wdt
> iTCO_vendor_support gpio_ich snd_hda_intel joydev snd_hda_codec
> snd_hda_core snd_hwdep mxm_wmi snd_seq snd_seq_device
> [29369.627745]  snd_pcm pcspkr snd_timer snd i2c_i801 soundcore
> lpc_ich i5500_temp i7core_edac shpchp wmi acpi_cpufreq ata_generic
> pata_acpi radeon crc32c_intel i2c_algo_bit drm_kms_helper
> firewire_ohci firewire_core ttm crc_itu_t drm e1000e pata_marvell
> [29369.645472] CPU: 1 PID: 3896 Comm: expect Tainted: G          I
>   4.17.5+ #7
> [29369.654333] Hardware name:  /DX58SO, BIOS
> SOX5810J.86A.5600.2013.0729.2250 07/29/2013
> [29369.663320] RIP: 0010:move_freepages_block+0x246/0x4b0
> [29369.672238] RSP: 0018:ffff8800b61f7178 EFLAGS: 00010002
> [29369.681064] RAX: ffff8801af3d7000 RBX: ffffea00033c8000 RCX: 000000000=
0000000
> [29369.690011] RDX: dffffc0000000000 RSI: ffffea00033cc000 RDI: ffffffff8=
31d8ec0
> [29369.698992] RBP: ffff8801af3d7680 R08: ffff8800b61f73c8 R09: ffffed003=
5e7af78
> [29369.708025] R10: ffffed0035e7af78 R11: ffff8801af3d7bc3 R12: ffff8800b=
61f7228
>
> before machine looked up.

4.17.6:

[24707.152017] kernel BUG at mm/page_alloc.c:2019!
[24707.157304] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
[24707.162573] Modules linked in: netconsole xt_CHECKSUM
ipt_MASQUERADE nf_nat_masquerade_ipv4 tun nf_conntrack_netbios_ns
nf_conntrack_broadcast xt_CT ip6t_rpfilter ip6t_REJECT nf_reject_ipv6
xt_conntrack devlink ip_set nfnetlink ebtable_nat ebtable_broute
bridge stp llc ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6
nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat
nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack
libcrc32c iptable_mangle iptable_raw iptable_security ebtable_filter
ebtables ip6table_filter ip6_tables sunrpc vfat fat intel_powerclamp
coretemp kvm_intel kvm irqbypass intel_cstate intel_uncore
snd_hda_codec_realtek iTCO_wdt mxm_wmi gpio_ich iTCO_vendor_support
snd_hda_codec_generic snd_hda_intel snd_hda_codec joydev snd_hda_core
snd_hwdep snd_seq snd_seq_device
[24707.196565]  snd_pcm pcspkr snd_timer snd i2c_i801 lpc_ich
soundcore i7core_edac i5500_temp shpchp wmi acpi_cpufreq ata_generic
pata_acpi radeon i2c_algo_bit drm_kms_helper crc32c_intel
firewire_ohci ttm firewire_core crc_itu_t drm pata_marvell e1000e
[24707.208944] CPU: 3 PID: 23661 Comm: cc1plus Tainted: G          I
    4.17.6+ #11
[24707.215277] Hardware name:  /DX58SO, BIOS
SOX5810J.86A.5600.2013.0729.2250 07/29/2013
[24707.221715] RIP: 0010:move_freepages_block+0x246/0x4b0
[24707.228145] RSP: 0018:ffff880170387818 EFLAGS: 00010002
[24707.234614] RAX: ffff8801af3d7000 RBX: ffffea00033c8000 RCX: 00000000000=
00000
[24707.241158] RDX: dffffc0000000000 RSI: ffffea00033cf000 RDI: ffffffff831=
d9380
[24707.247735] RBP: ffff8801af3d7680 R08: ffff880170387a68 R09: ffffed0035e=
7af78
[24707.254233] R10: ffffed0035e7af78 R11: ffff8801af3d7bc3 R12: ffff8801703=
878c8
[24707.260650] R13: ffff8801af3d7680 R14: 0000000000000800 R15: 00000000000=
00000
[24707.267015] FS:  00007f18c4310c80(0000) GS:ffff880176ec0000(0000)
knlGS:0000000000000000
[24707.273381] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[24707.279656] CR2: 00007f18c42a0000 CR3: 000000016b982000 CR4: 00000000000=
006e0
[24707.285919] Call Trace:
[24707.292076]  ? unwind_next_frame+0x793/0x850
[24707.298199]  steal_suitable_fallback+0x1f2/0x2a0
[24707.304344]  ? ftrace_ops_trampoline+0x4c/0x80
[24707.310425]  ? move_freepages_block+0x4b0/0x4b0
[24707.316423]  ? is_bpf_text_address+0xa/0x20
[24707.322325]  ? kernel_text_address+0x100/0x110
[24707.328105]  ? find_suitable_fallback+0xd0/0x100
[24707.333828]  get_page_from_freelist+0x189c/0x2540
[24707.339471]  ? __isolate_free_page+0x2c0/0x2c0
[24707.345011]  ? unlazy_walk+0xb8/0x160
[24707.350539]  __alloc_pages_nodemask+0x1b0/0x3c0
[24707.355912]  ? __alloc_pages_slowpath+0x1240/0x1240
[24707.361193]  ? path_mountpoint+0x8d0/0x8d0
[24707.366500]  ? deactivate_slab.isra.61+0x200/0x500
[24707.371712]  ? policy_node+0x56/0x60
[24707.376838]  new_slab+0x288/0x790
[24707.381853]  ? __kasan_slab_free+0x143/0x180
[24707.386795]  ___slab_alloc+0x3b4/0x550
[24707.391606]  ? getname_flags+0x6c/0x2a0
[24707.396435]  ? getname_flags+0x6c/0x2a0
[24707.401241]  __slab_alloc+0x1c/0x30
[24707.406059]  kmem_cache_alloc+0x223/0x260
[24707.410913]  getname_flags+0x6c/0x2a0
[24707.415772]  ? __ia32_sys_fstat+0x30/0x30
[24707.420655]  user_path_at_empty+0x1d/0x40
[24707.425551]  vfs_statx+0xb9/0x140
[24707.430489]  ? vfs_statx_fd+0x80/0x80
[24707.435307]  __do_sys_newlstat+0x77/0xd0
[24707.440144]  ? __ia32_sys_newstat+0x30/0x30
[24707.445005]  ? do_sys_open+0x16b/0x290
[24707.449881]  do_syscall_64+0x7d/0x1c0
[24707.454778]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[24707.459716] RIP: 0033:0x7f18c43ff049
[24707.464670] RSP: 002b:00007fff75c7aaa8 EFLAGS: 00000246 ORIG_RAX:
0000000000000006
[24707.469625] RAX: ffffffffffffffda RBX: 00007fff75c7bbd0 RCX: 00007f18c43=
ff049


--=20
H.J.
