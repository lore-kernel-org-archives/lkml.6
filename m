Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB77C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822A621726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfAWKeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:34:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbfAWKd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:33:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AF5AA5C9;
        Wed, 23 Jan 2019 10:33:58 +0000 (UTC)
Received: from [10.36.117.3] (ovpn-117-3.ams2.redhat.com [10.36.117.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70CBC1716C;
        Wed, 23 Jan 2019 10:33:57 +0000 (UTC)
Subject: Re: [PATCH] mm,memory_hotplug: Fix scan_movable_pages for gigantic
 hugepages
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com
References: <20190122154407.18417-1-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <5368e2b4-5aca-40dd-fe18-67d861a04a29@redhat.com>
Date:   Wed, 23 Jan 2019 11:33:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190122154407.18417-1-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 23 Jan 2019 10:33:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.01.19 16:44, Oscar Salvador wrote:
> This is the same sort of error we saw in [1].
> 
> Gigantic hugepages crosses several memblocks, so it can be
> that the page we get in scan_movable_pages() is a page-tail
> belonging to a 1G-hugepage.
> If that happens, page_hstate()->size_to_hstate() will return NULL,
> and we will blow up in hugepage_migration_supported().
> 
> The splat is as follows:
> 
> kernel: BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> kernel: #PF error: [normal kernel read fault]
> kernel: PGD 0 P4D 0
> kernel: Oops: 0000 [#1] SMP PTI
> kernel: CPU: 1 PID: 1350 Comm: bash Tainted: G            E     5.0.0-rc1-mm1-1-default+ #27
> kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
> kernel: RIP: 0010:__offline_pages+0x6ae/0x900
> kernel: Code: 48 c7 c6 d0 3e a4 81 e8 44 c8 ad ff 49 8b 04 24 bf 00 10 00 00 a9 00 00 01 00 74 09 41 0f b6 4c 24 51 48 d3 e7 e8 42 2a c1 ff <8b> 40 08 83 f8 09 0f 84 b0 fc ff ff 83 f8 12 0f 84 a7 fc ff ff 83
> kernel: RSP: 0018:ffffc900008e3d20 EFLAGS: 00010246
> kernel: RAX: 0000000000000000 RBX: ffffea0000000000 RCX: 0000000000000009
> kernel: RDX: ffffffff825c64f0 RSI: 0000000000001000 RDI: 0000000000001000
> kernel: RBP: ffffc900008e3d68 R08: 0000000000200000 R09: 00000000000001e4
> kernel: R10: 0000000000000058 R11: ffffffff8254a854 R12: ffffea0004200000
> kernel: R13: 0000000000108000 R14: 0000000000110000 R15: 0000000000000000
> kernel: FS:  00007ff172339b80(0000) GS:ffff88803eb00000(0000) knlGS:0000000000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 0000000000000008 CR3: 0000000038d78006 CR4: 00000000003606a0
> kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> kernel: Call Trace:
> kernel:  ? klist_next+0x79/0xe0
> kernel:  memory_subsys_offline+0x42/0x60
> kernel:  device_offline+0x80/0xa0
> kernel:  state_store+0xab/0xc0
> kernel:  kernfs_fop_write+0x102/0x180
> kernel:  __vfs_write+0x26/0x190
> kernel:  ? set_close_on_exec+0x49/0x70
> kernel:  vfs_write+0xad/0x1b0
> kernel:  ksys_write+0x42/0x90
> kernel:  do_syscall_64+0x5b/0x180
> kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> kernel: RIP: 0033:0x7ff1719febe4
> kernel: Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 80 00 00 00 00 8b 05 4a fc 2c 00 48 63 ff 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 55 53 48 89 d5 48 89 f3 48 83
> kernel: RSP: 002b:00007ffd50b7ddc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> kernel: RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007ff1719febe4
> kernel: RDX: 0000000000000008 RSI: 00005556e9216b20 RDI: 0000000000000001
> kernel: RBP: 00005556e9216b20 R08: 000000000000000a R09: 0000000000000000
> kernel: R10: 000000000000000a R11: 0000000000000246 R12: 0000000000000008
> kernel: R13: 0000000000000001 R14: 00007ff171cca720 R15: 0000000000000008
> kernel: Modules linked in: af_packet(E) xt_tcpudp(E) ipt_REJECT(E) xt_conntrack(E) nf_conntrack(E) nf_defrag_ipv4(E) ip_set(E) nfnetlink(E) ebtable_nat(E) ebtable_broute(E) bridge(E) stp(E) llc(E) iptable_mangle(E) iptable_raw(E) iptable_security(E) ebtable_filter(E) ebtables(E) iptable_filter(E) ip_tables(E) x_tables(E) kvm_intel(E) kvm(E) irqbypass(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) bochs_drm(E) ttm(E) aesni_intel(E) drm_kms_helper(E) aes_x86_64(E) crypto_simd(E) cryptd(E) glue_helper(E) drm(E) virtio_net(E) syscopyarea(E) sysfillrect(E) net_failover(E) sysimgblt(E) pcspkr(E) failover(E) i2c_piix4(E) fb_sys_fops(E) parport_pc(E) parport(E) button(E) btrfs(E) libcrc32c(E) xor(E) zstd_decompress(E) zstd_compress(E) xxhash(E) raid6_pq(E) sd_mod(E) ata_generic(E) ata_piix(E) ahci(E) libahci(E) libata(E) crc32c_intel(E) serio_raw(E) virtio_pci(E) virtio_ring(E) virtio(E) sg(E) scsi_mod(E) autofs4(E)
> kernel: CR2: 0000000000000008
> kernel: ---[ end trace bdb71590872849fb ]---
> kernel: RIP: 0010:__offline_pages+0x6ae/0x900
> kernel: Code: 48 c7 c6 d0 3e a4 81 e8 44 c8 ad ff 49 8b 04 24 bf 00 10 00 00 a9 00 00 01 00 74 09 41 0f b6 4c 24 51 48 d3 e7 e8 42 2a c1 ff <8b> 40 08 83 f8 09 0f 84 b0 fc ff ff 83 f8 12 0f 84 a7 fc ff ff 83
> kernel: RSP: 0018:ffffc900008e3d20 EFLAGS: 00010246
> kernel: RAX: 0000000000000000 RBX: ffffea0000000000 RCX: 0000000000000009
> kernel: RDX: ffffffff825c64f0 RSI: 0000000000001000 RDI: 0000000000001000
> kernel: RBP: ffffc900008e3d68 R08: 0000000000200000 R09: 00000000000001e4
> kernel: R10: 0000000000000058 R11: ffffffff8254a854 R12: ffffea0004200000
> kernel: R13: 0000000000108000 R14: 0000000000110000 R15: 0000000000000000
> kernel: FS:  00007ff172339b80(0000) GS:ffff88803eb00000(0000) knlGS:0000000000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 0000000000000008 CR3: 0000000038d78006 CR4: 00000000003606a0
> kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> Fix this by getting the head page and testing against it.
> 
> [1] https://patchwork.kernel.org/patch/10739963/
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/memory_hotplug.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index ec22c86d9f89..25aee4f04a72 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1335,12 +1335,17 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
>  			if (__PageMovable(page))
>  				return pfn;
>  			if (PageHuge(page)) {
> -				if (hugepage_migration_supported(page_hstate(page)) &&
> -				    page_huge_active(page))
> +				struct page *head = compound_head(page);
> +
> +				if (hugepage_migration_supported(page_hstate(head)) &&
> +				    page_huge_active(head))
>  					return pfn;
> -				else
> -					pfn = round_up(pfn + 1,
> -						1 << compound_order(page)) - 1;
> +				else {

If you use {} for the else case, please also do so for the if case.

Apart from that this looks good to me

Reviewed-by: David Hildenbrand <david@redhat.com>

> +					unsigned long skip;
> +
> +					skip = (1 << compound_order(head)) - (page - head);
> +					pfn += skip - 1;
> +				}
>  			}
>  		}
>  	}
> 


-- 

Thanks,

David / dhildenb
