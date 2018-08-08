Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78ABC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D97721742
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D97721742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbeHHON5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:13:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:44990 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726733AbeHHON5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:13:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D065BB017;
        Wed,  8 Aug 2018 11:54:32 +0000 (UTC)
Subject: Re: general protection fault with prefetch_freepointer
To:     Paul Menzel <pmenzel+linux-mm@molgen.mpg.de>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>
References: <333cfb75-1769-c67f-c56f-c9458368751a@molgen.mpg.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
 cqmP8roqufIAj+Ohhzs=
Message-ID: <4fcc1694-6c29-8c49-1183-fbfb832bf513@suse.cz>
Date:   Wed, 8 Aug 2018 13:54:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <333cfb75-1769-c67f-c56f-c9458368751a@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/2018 04:31 PM, Paul Menzel wrote:
> Dear Linux,
> 
> 
> Loading the amdgpu module on Ryzen 3 2{2,4}00G (Raven) systems sometimes
> causes a general protection fault [1]. At least on my system I am unable
> to reliably reproduce the issue.
> 
> ```
> [   35.265941] kfd kfd: kgd2kfd_probe failed
> [   35.537445] general protection fault: 0000 [#1] SMP NOPTI
> [   35.543209] CPU: 0 PID: 367 Comm: systemd-udevd Not tainted 4.18.0-rc5+ #1
> [   35.550371] Hardware name: MSI MS-7A37/B350M MORTAR (MS-7A37), BIOS 1.G1 05/17/2018
> [   35.558562] RIP: 0010:prefetch_freepointer+0x10/0x20
> [   35.563881] Code: 89 d3 e8 c3 fe 4a 00 85 c0 0f 85 31 75 00 00 48 83 c4 08 5b 5d 41 5c 41 5d c3 0f 1f 44 00 00 48 85 f6 74 13 8b 47 20 48 01 c6 <48> 33 36 48 33 b7 38 01 00 00 0f 18 0e c3 66 90 0f 1f 44 00 00 48 
> [   35.584215] RSP: 0018:ffff9c3181f77560 EFLAGS: 00010202
> [   35.589849] RAX: 0000000000000000 RBX: 4b2c8be0a60f6ab9 RCX: 0000000000000ccc
> [   35.597492] RDX: 0000000000000ccb RSI: 4b2c8be0a60f6ab9 RDI: ffff8d5b1e406e80
> [   35.605166] RBP: ffff8d5b1e406e80 R08: ffff8d5b1e824f00 R09: ffffffffc0a45423
> [   35.612808] R10: fffff1b60fff64c0 R11: ffff9c3181f77520 R12: 00000000006080c0
> [   35.620451] R13: 0000000000000230 R14: ffff8d5b1e406e80 R15: ffff8d5b0c304400
> [   35.628116] FS:  00007fb194e4b8c0(0000) GS:ffff8d5b1e800000(0000) knlGS:0000000000000000
> [   35.636771] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   35.642931] CR2: 000055c0661d60d0 CR3: 000000040b9ee000 CR4: 00000000003406f0
> [   35.650566] Call Trace:
> [   35.653198]  kmem_cache_alloc_trace+0xb5/0x1c0
> [   35.658077]  ? dal_ddc_service_create+0x38/0x110 [amdgpu]
> [   35.663962]  dal_ddc_service_create+0x38/0x110 [amdgpu]
> ```

./scripts/decodecode:

All code
========
   0:   89 d3                   mov    %edx,%ebx
   2:   e8 c3 fe 4a 00          callq  0x4afeca
   7:   85 c0                   test   %eax,%eax
   9:   0f 85 31 75 00 00       jne    0x7540
   f:   48 83 c4 08             add    $0x8,%rsp
  13:   5b                      pop    %rbx
  14:   5d                      pop    %rbp
  15:   41 5c                   pop    %r12
  17:   41 5d                   pop    %r13
  19:   c3                      retq   
  1a:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
  1f:   48 85 f6                test   %rsi,%rsi
  22:   74 13                   je     0x37
  24:   8b 47 20                mov    0x20(%rdi),%eax
  27:   48 01 c6                add    %rax,%rsi
  2a:*  48 33 36                xor    (%rsi),%rsi <- HERE
  2d:   48 33 b7 38 01 00 00    xor    0x138(%rdi),%rsi
  34:   0f 18 0e                prefetcht0 (%rsi)
  37:   c3                      retq   
  38:   66 90                   xchg   %ax,%ax
  3a:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
  3f:   48                      rex.W

rsi contains 4b2c8be0a60f6ab9, so reading from that clearly bogus
address faults. Dunno though why CR2 is 000055c0661d60d0 as that
should contain the same value. The XORs suggests you have
CONFIG_SLAB_FREELIST_HARDENED enabled, I wonder does the bug
reproduce with that disabled?

mov    0x20(%rdi),%eax is reading s->offset, so RDI=ffff8d5b1e406e80
is kmem_cache pointer, RAX=0 means offset was 0. This means
RSI=4b2c8be0a60f6ab9 is "object" parameter of prefetch_freepointer(),
i.e. the "next_object" variable in slab_alloc_node(), obtained from
the previous object. But I don't know much about SLUB internals to be
honest.

> Do you have more ideas, how to debug that? The progress in bug report
> kind of stalled as people have run out of ideas.
> 
> I thought about a hardware/firmware problem, but then searching for the
> error, I found the stack trace with Linux 4.17.2 from Fedora [2][3].
> This looks a little similar, but can of course be something totally
> different.
 
Hmm I have looked at the splats in all the bugs you referenced and the
Code part always has the de-obfuscation XORs. Then in comment 36 of
[1] jian-hong says the problem disappeared, and in comment 40 posts
a config that has CONFIG_SLAB_FREELIST_HARDENED disabled. Earlier
posting of his config has it enabled and confirms the disassembly.
Very suspicious, huh.

> general protection fault: 0000 [#1] SMP PTI
> Modules linked in: sctp netlink_diag nfsv3 nfnetlink_queue nfnetlink_log nfnetlink cfg80211 rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache rfcomm fuse hidp xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 xt_conntrack tun devlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack bridge stp llc bnep it87 hwmon_vid btrfs xor zstd_compress raid6_pq libcrc32c zstd_decompress xxhash intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm gpio_ich iTCO_wdt iTCO_vendor_support ppdev irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate intel_uncore intel_rapl_perf btusb btrtl btbcm btintel bluetooth snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel
>  snd_hda_codec ecdh_generic rfkill snd_hda_core snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer i2c_i801 lpc_ich mei_me mei shpchp snd soundcore parport_pc parport nfsd binfmt_misc nfs_acl lockd auth_rpcgss grace sunrpc i915 crc32c_intel i2c_algo_bit drm_kms_helper serio_raw drm r8169 sata_via mii video
> CPU: 0 PID: 2690 Comm: nfsd Not tainted 4.17.2-200.fc28.x86_64 #1
> Hardware name: Gigabyte Technology Co., Ltd. H81M-S2PV/H81M-S2PV, BIOS F8 06/19/2014
> RIP: 0010:prefetch_freepointer+0x10/0x20
> RSP: 0018:ffffa33fca4ebc58 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: 49f929d076783c7f RCX: 0000000000000f2a
> RDX: 0000000000000f29 RSI: 49f929d076783c7f RDI: ffff8da88c9ffe00
> RBP: ffff8da88c9ffe00 R08: ffff8da89ee2b100 R09: 0000000000000004
> R10: 0000000000000000 R11: 000000000000002c R12: 00000000014080c0
> R13: ffffffffc07e0ac1 R14: ffff8da4bc958ae1 R15: ffff8da88c9ffe00
> FS:  0000000000000000(0000) GS:ffff8da89ee00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00002001a1783000 CR3: 000000012920a001 CR4: 00000000000606f0
> Call Trace:
>  kmem_cache_alloc+0xb4/0x1d0
>  ? nfsd4_free_file_rcu+0x20/0x20 [nfsd]
> ```
> 
> Help on how to debug this is appreciated.
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: https://bugs.freedesktop.org/show_bug.cgi?id=105684
> [2]: https://bugzilla.redhat.com/show_bug.cgi?id=1600482
> [3]: https://retrace.fedoraproject.org/faf/reports/2243945/
> 

