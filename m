Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754537AbeD2XCJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 19:02:09 -0400
Received: from scorn.kernelslacker.org ([45.56.101.199]:59912 "EHLO
        scorn.kernelslacker.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754352AbeD2XCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 19:02:06 -0400
Date: Sun, 29 Apr 2018 19:02:02 -0400
From: Dave Jones <davej@codemonkey.org.uk>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Paul Menzel <pmenzel+linux-random-number@molgen.mpg.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180429230202.rcsjtnp2jhbqyag2@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Paul Menzel <pmenzel+linux-random-number@molgen.mpg.de>,
        linux-kernel@vger.kernel.org
References: <42c1b84b-ab1f-5577-6304-e0985a637cf9@molgen.mpg.de>
 <20180424135621.GD4189@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424135621.GD4189@thunk.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Note: SpamAssassin invocation failed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 09:56:21AM -0400, Theodore Y. Ts'o wrote:

 > Can you tell me a bit about your system?  What distribution, what
 > hardware is present in your sytsem (what architecture, what
 > peripherals are attached, etc.)?
 > 
 > There's a reason why we made this --- we were declaring the random
 > number pool to be fully intialized before it really was, and that was
 > a potential security concern.  It's not as bad as the weakness
 > discovered by Nadia Heninger in 2012.  (See https://factorable.net for
 > more details.)  However, this is not one of those things where we like
 > to fool around.
 > 
 > So I want to understand if this is an issue with a particular hardware
 > configuration, or whether it's just a badly designed Linux init system
 > or embedded setup, or something else.  After all, you wouldn't want
 > the NSA spying on all of your network traffic, would you?  :-)

Why do we continue to print this stuff out when crng_init=1 though ?

(This from debian stable, on a pretty basic atom box, but similar
dmesg's on everything else I've put 4.17-rc on so far)

[    0.000000] random: get_random_bytes called from start_kernel+0x96/0x519 with crng_init=0
[    0.000000] random: get_random_u64 called from __kmem_cache_create+0x39/0x450 with crng_init=0
[    0.000000] random: get_random_u64 called from cache_random_seq_create+0x76/0x120 with crng_init=0
[    0.151401] calling  initialize_ptr_random+0x0/0x36 @ 1
[    0.151527] initcall initialize_ptr_random+0x0/0x36 returned 0 after 0 usecs
[    0.294661] calling  prandom_init+0x0/0xbd @ 1
[    0.294763] initcall prandom_init+0x0/0xbd returned 0 after 0 usecs
[    1.430529] _warn_unseeded_randomness: 165 callbacks suppressed
[    1.430540] random: get_random_u64 called from __kmem_cache_create+0x39/0x450 with crng_init=0
[    1.430860] random: get_random_u64 called from cache_random_seq_create+0x76/0x120 with crng_init=0
[    1.452240] random: get_random_u64 called from copy_process.part.67+0x1ae/0x1e60 with crng_init=0
[    2.954901] _warn_unseeded_randomness: 54 callbacks suppressed
[    2.954910] random: get_random_u64 called from __kmem_cache_create+0x39/0x450 with crng_init=0
[    2.955185] random: get_random_u64 called from cache_random_seq_create+0x76/0x120 with crng_init=0
[    2.957701] random: get_random_u64 called from __kmem_cache_create+0x39/0x450 with crng_init=0
[    6.017364] _warn_unseeded_randomness: 88 callbacks suppressed
[    6.017373] random: get_random_u64 called from __kmem_cache_create+0x39/0x450 with crng_init=0
[    6.042652] random: get_random_u64 called from cache_random_seq_create+0x76/0x120 with crng_init=0
[    6.060333] random: get_random_u64 called from __kmem_cache_create+0x39/0x450 with crng_init=0
[    6.951978] calling  prandom_reseed+0x0/0x2a @ 1
[    6.960627] initcall prandom_reseed+0x0/0x2a returned 0 after 105 usecs
[    7.371745] _warn_unseeded_randomness: 37 callbacks suppressed
[    7.371759] random: get_random_u64 called from arch_pick_mmap_layout+0x64/0x130 with crng_init=0
[    7.395926] random: get_random_u64 called from load_elf_binary+0x4ae/0x1720 with crng_init=0
[    7.411549] random: get_random_u32 called from arch_align_stack+0x37/0x50 with crng_init=0
[    7.553379] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    7.563210] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    7.571498] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    8.449679] _warn_unseeded_randomness: 154 callbacks suppressed
[    8.449691] random: get_random_u64 called from copy_process.part.67+0x1ae/0x1e60 with crng_init=0
[    8.483097] random: get_random_u64 called from arch_pick_mmap_layout+0x64/0x130 with crng_init=0
[    8.497999] random: get_random_u64 called from load_elf_binary+0x4ae/0x1720 with crng_init=0
[    9.353904] random: fast init done
[    9.770384] _warn_unseeded_randomness: 187 callbacks suppressed
[    9.770398] random: get_random_u32 called from bucket_table_alloc+0x84/0x1b0 with crng_init=1
[    9.791514] random: get_random_u32 called from new_slab+0x174/0x680 with crng_init=1
[    9.834909] random: get_random_u64 called from copy_process.part.67+0x1ae/0x1e60 with crng_init=1
[   10.802200] _warn_unseeded_randomness: 168 callbacks suppressed
[   10.802214] random: get_random_u64 called from arch_pick_mmap_layout+0x64/0x130 with crng_init=1
[   10.802276] random: get_random_u64 called from load_elf_binary+0x4ae/0x1720 with crng_init=1
[   10.802289] random: get_random_u32 called from arch_align_stack+0x37/0x50 with crng_init=1
[   11.821109] _warn_unseeded_randomness: 160 callbacks suppressed
[   11.821122] random: get_random_u64 called from copy_process.part.67+0x1ae/0x1e60 with crng_init=1
[   11.863770] random: get_random_u32 called from bucket_table_alloc+0x84/0x1b0 with crng_init=1
[   11.869384] random: get_random_u32 called from new_slab+0x174/0x680 with crng_init=1
[   12.843237] _warn_unseeded_randomness: 260 callbacks suppressed
[   12.843251] random: get_random_u64 called from arch_pick_mmap_layout+0x64/0x130 with crng_init=1
[   12.875369] random: get_random_u64 called from copy_process.part.67+0x1ae/0x1e60 with crng_init=1
[   12.898152] random: get_random_u32 called from bucket_table_alloc+0x84/0x1b0 with crng_init=1
[   13.858256] _warn_unseeded_randomness: 245 callbacks suppressed
[   13.858271] random: get_random_u32 called from new_slab+0x174/0x680 with crng_init=1
[   13.866366] random: get_random_u32 called from arch_setup_additional_pages+0x79/0xb0 with crng_init=1
[   13.895379] random: get_random_u32 called from new_slab+0x174/0x680 with crng_init=1
[   14.896395] _warn_unseeded_randomness: 301 callbacks suppressed
[   14.896409] random: get_random_u64 called from copy_process.part.67+0x1ae/0x1e60 with crng_init=1
[   14.921096] random: get_random_u64 called from arch_pick_mmap_layout+0x64/0x130 with crng_init=1
[   14.935596] random: get_random_u64 called from load_elf_binary+0x4ae/0x1720 with crng_init=1
[   15.924405] _warn_unseeded_randomness: 152 callbacks suppressed
[   15.924419] random: get_random_u64 called from arch_pick_mmap_layout+0x64/0x130 with crng_init=1
[   15.942457] random: get_random_u64 called from load_elf_binary+0x4ae/0x1720 with crng_init=1
[   15.953995] random: get_random_u32 called from arch_align_stack+0x37/0x50 with crng_init=1
[   19.295109] _warn_unseeded_randomness: 25 callbacks suppressed
[   19.295142] random: get_random_u32 called from new_slab+0x174/0x680 with crng_init=1
[   20.319905] random: get_random_bytes called from flow_hash_from_keys+0x14c/0x2b0 with crng_init=1
[   21.323229] random: get_random_u64 called from copy_process.part.67+0x1ae/0x1e60 with crng_init=1
[   21.351464] random: get_random_u64 called from arch_pick_mmap_layout+0x64/0x130 with crng_init=1
[   21.366761] random: get_random_u64 called from load_elf_binary+0x4ae/0x1720 with crng_init=1
[   22.367243] _warn_unseeded_randomness: 420 callbacks suppressed
[   22.367282] random: get_random_u64 called from arch_pick_mmap_layout+0x64/0x130 with crng_init=1
[   22.367306] random: get_random_u64 called from load_elf_binary+0x4ae/0x1720 with crng_init=1
[   22.367329] random: get_random_u32 called from arch_align_stack+0x37/0x50 with crng_init=1
[   23.378128] _warn_unseeded_randomness: 283 callbacks suppressed
[   23.378141] random: get_random_u64 called from arch_pick_mmap_layout+0x64/0x130 with crng_init=1
[   23.378164] random: get_random_u64 called from load_elf_binary+0x4ae/0x1720 with crng_init=1
[   23.378176] random: get_random_u32 called from arch_align_stack+0x37/0x50 with crng_init=1
[   24.381404] _warn_unseeded_randomness: 246 callbacks suppressed
[   24.381417] random: get_random_u64 called from arch_pick_mmap_layout+0x64/0x130 with crng_init=1
[   24.396831] random: get_random_u64 called from load_elf_binary+0x4ae/0x1720 with crng_init=1
[   24.418850] random: get_random_u32 called from new_slab+0x174/0x680 with crng_init=1
[   25.391285] _warn_unseeded_randomness: 320 callbacks suppressed
[   25.391298] random: get_random_u64 called from arch_pick_mmap_layout+0x64/0x130 with crng_init=1
[   25.417982] random: get_random_u64 called from load_elf_binary+0x4ae/0x1720 with crng_init=1
[   25.434112] random: get_random_u32 called from arch_align_stack+0x37/0x50 with crng_init=1
[   26.463997] _warn_unseeded_randomness: 182 callbacks suppressed
[   26.464009] random: get_random_u64 called from copy_process.part.67+0x1ae/0x1e60 with crng_init=1
[   26.700479] random: get_random_u64 called from arch_pick_mmap_layout+0x64/0x130 with crng_init=1
[   26.728446] random: get_random_u64 called from load_elf_binary+0x4ae/0x1720 with crng_init=1
[   28.393318] _warn_unseeded_randomness: 86 callbacks suppressed
[   28.393331] random: get_random_bytes called from inet6_ehashfn+0x14c/0x1c0 with crng_init=1
[   28.414841] random: get_random_bytes called from inet6_ehashfn+0x191/0x1c0 with crng_init=1
[   28.430781] random: get_random_bytes called from inet_ehashfn+0xe3/0x110 with crng_init=1
[   33.345320] _warn_unseeded_randomness: 82 callbacks suppressed
[   33.345334] random: get_random_bytes called from secure_tcp_ts_off+0x83/0xb0 with crng_init=1
[   33.346074] random: get_random_bytes called from secure_tcp_seq+0x9c/0xc0 with crng_init=1
[   33.349477] random: get_random_u64 called from copy_process.part.67+0x1ae/0x1e60 with crng_init=1
[   34.352703] _warn_unseeded_randomness: 78 callbacks suppressed
[   34.352716] random: get_random_u64 called from arch_pick_mmap_layout+0x64/0x130 with crng_init=1
[   34.353348] random: get_random_u64 called from load_elf_binary+0x4ae/0x1720 with crng_init=1
[   34.353716] random: get_random_u32 called from arch_align_stack+0x37/0x50 with crng_init=1
[   36.444658] _warn_unseeded_randomness: 32 callbacks suppressed
[   36.444670] random: get_random_u64 called from copy_process.part.67+0x1ae/0x1e60 with crng_init=1
[   36.453636] random: get_random_u64 called from arch_pick_mmap_layout+0x64/0x130 with crng_init=1
[   36.454025] random: get_random_u64 called from load_elf_binary+0x4ae/0x1720 with crng_init=1
[   37.939280] _warn_unseeded_randomness: 53 callbacks suppressed
[   37.939292] random: get_random_u32 called from new_slab+0x174/0x680 with crng_init=1
[   42.179988] random: get_random_u32 called from neigh_hash_alloc+0x7b/0xc0 with crng_init=1
[   44.202043] random: get_random_u32 called from new_slab+0x174/0x680 with crng_init=1
[   46.035713] random: get_random_u64 called from copy_process.part.67+0x1ae/0x1e60 with crng_init=1
[   46.067589] random: get_random_u64 called from arch_pick_mmap_layout+0x64/0x130 with crng_init=1
[   46.085148] random: get_random_u64 called from load_elf_binary+0x4ae/0x1720 with crng_init=1
[   47.198815] _warn_unseeded_randomness: 7 callbacks suppressed
[   47.207534] random: get_random_bytes called from __prandom_timer+0x24/0x90 with crng_init=1
[   53.127055] random: get_random_u64 called from arch_pick_mmap_layout+0x64/0x130 with crng_init=1
[   53.145929] random: get_random_u64 called from load_elf_binary+0x4ae/0x1720 with crng_init=1
[   53.165246] random: get_random_u32 called from arch_align_stack+0x37/0x50 with crng_init=1
[   54.177186] _warn_unseeded_randomness: 75 callbacks suppressed
[   54.177198] random: get_random_u32 called from new_slab+0x174/0x680 with crng_init=1
[   54.245759] random: get_random_u64 called from copy_process.part.67+0x1ae/0x1e60 with crng_init=1
[   54.276658] random: get_random_u64 called from arch_pick_mmap_layout+0x64/0x130 with crng_init=1
[   55.339125] _warn_unseeded_randomness: 113 callbacks suppressed
[   55.339137] random: get_random_u64 called from arch_pick_mmap_layout+0x64/0x130 with crng_init=1
[   55.365379] random: get_random_u64 called from load_elf_binary+0x4ae/0x1720 with crng_init=1
[   55.383400] random: get_random_u32 called from arch_align_stack+0x37/0x50 with crng_init=1
[   61.772814] _warn_unseeded_randomness: 6 callbacks suppressed
[   61.772827] random: get_random_u64 called from arch_pick_mmap_layout+0x64/0x130 with crng_init=1
[   61.798504] random: get_random_u64 called from load_elf_binary+0x4ae/0x1720 with crng_init=1
[   61.816345] random: get_random_u32 called from arch_align_stack+0x37/0x50 with crng_init=1
[   77.460681] _warn_unseeded_randomness: 6 callbacks suppressed
[   77.460694] random: get_random_u64 called from arch_pick_mmap_layout+0x64/0x130 with crng_init=1
[   77.487010] random: get_random_u64 called from load_elf_binary+0x4ae/0x1720 with crng_init=1
[   77.504121] random: get_random_u32 called from arch_align_stack+0x37/0x50 with crng_init=1
[   80.717699] _warn_unseeded_randomness: 5 callbacks suppressed
[   80.717714] random: get_random_u32 called from new_slab+0x174/0x680 with crng_init=1
[   99.514633] random: get_random_u32 called from neigh_hash_alloc+0x7b/0xc0 with crng_init=1
[  125.914405] random: get_random_bytes called from __prandom_timer+0x24/0x90 with crng_init=1
[  137.252356] random: get_random_u32 called from new_slab+0x174/0x680 with crng_init=1
[  165.806247] random: crng init done
[  165.815049] random: 7 urandom warning(s) missed due to ratelimiting
