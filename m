Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4791CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097CF218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8IpbNL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbeLSO2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:28:19 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37203 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbeLSO2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:28:17 -0500
Received: by mail-ed1-f67.google.com with SMTP id h15so17137801edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 06:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y67YYkreYf+HX0Or3avL6iUUZdtlpP+B7v4wYPP9FbQ=;
        b=Y8IpbNL8cTUL+HfJWWDRXa9s4iedr0QUZURhtRqYbnQufPl+PJ472hTbq4uTuvbuB7
         2kTVIb8Vw+UGKihNSbKU2BmbBplIjNy2ZCgoW/eeYOj2azrI0OMjVAwD3pNv3flad0aa
         ybY1biJF7b2y4WhopkfMDAVIrMnUAM41xUOa8Gv+cnzhaiyGFjw5Y13aWXczkSdAROvS
         uLaHpcdc8e6HWiaIjm+Vs/H/ZxTV2jeGv+euTqOWY3PeWVj6/o/TMTu0mfUBsoRhGSX6
         SYYe51K5mRs508UUIV23vT6Ng4rFluXyhR46wgRtYEHC0wzYpDdi4DbijPGrmP440DJ/
         VO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y67YYkreYf+HX0Or3avL6iUUZdtlpP+B7v4wYPP9FbQ=;
        b=Iro5FkY/6emNXY5LWAmbdF1iSHlM7hzA0WWhA38VXvvkvnOR2+sT3P8MHod5WZ3n8d
         Js4+4VyI1qs5dKp7LlPfrgkw6YfPUwwnQXsCQR55BhgPIGXpY/Af1O1SeZjRk2hIV5iH
         Gb7ksXyFGQLsnVapGXI/58VJx3brINfEUgxxRwUKzDt6+EijhIlhefgKhNI5x+Pputbl
         lkwjqby3/wfns1CMpWvAJNsr38JUwqBb/CrQP+nA9uDo4vgnG1ddanMj8t5htgWnSR5M
         YaC6ioswYZUZ1QltZIo7dwYv/1A9rbDPzIR9/+C9XsjZJFyiuK3QmGtn5sObVL2jZql/
         f9bA==
X-Gm-Message-State: AA+aEWYegOxfuf7YaoqWXozQ/YtxkMj3KRU5wObNzD2/U4u+aq5yAPn5
        4Yg2T2OwGnKDFKLzOxJTBnY=
X-Google-Smtp-Source: AFSGD/XOGmZHGRM7x7vAldIA2a1M2GNCGNdH3dsXxpuc2Ky7WJW2g2CwWkDHWVGdNT0aRpunzR+/lQ==
X-Received: by 2002:a50:9e43:: with SMTP id z61mr20503807ede.90.1545229694837;
        Wed, 19 Dec 2018 06:28:14 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id c12sm5108934edi.52.2018.12.19.06.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 06:28:13 -0800 (PST)
Date:   Wed, 19 Dec 2018 14:28:13 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org,
        mhocko@suse.com, vbabka@suse.cz, pavel.tatashin@microsoft.com,
        rppt@linux.vnet.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm, page_alloc: Fix has_unmovable_pages for HugePages
Message-ID: <20181219142813.4d6kiuac64lazurd@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181217225113.17864-1-osalvador@suse.de>
 <20181219142528.yx6ravdyzcqp5wtd@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219142528.yx6ravdyzcqp5wtd@master>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 02:25:28PM +0000, Wei Yang wrote:
>On Mon, Dec 17, 2018 at 11:51:13PM +0100, Oscar Salvador wrote:
>>v1 -> v2:
>>	- Fix the logic for skipping pages by Michal
>>
>>---
>>>From e346b151037d3c37feb10a981a4d2a25018acf81 Mon Sep 17 00:00:00 2001
>>From: Oscar Salvador <osalvador@suse.de>
>>Date: Mon, 17 Dec 2018 14:53:35 +0100
>>Subject: [PATCH] mm, page_alloc: Fix has_unmovable_pages for HugePages
>>
>>While playing with gigantic hugepages and memory_hotplug, I triggered
>>the following #PF when "cat memoryX/removable":
>>
>><---
>>kernel: BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
>>kernel: #PF error: [normal kernel read fault]
>>kernel: PGD 0 P4D 0
>>kernel: Oops: 0000 [#1] SMP PTI
>>kernel: CPU: 1 PID: 1481 Comm: cat Tainted: G            E     4.20.0-rc6-mm1-1-default+ #18
>>kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
>>kernel: RIP: 0010:has_unmovable_pages+0x154/0x210
>>kernel: Code: 1b ff ff ff eb 32 48 8b 45 00 bf 00 10 00 00 a9 00 00 01 00 74 07 0f b6 4d 51 48 d3 e7 e8 c4 81 05 00 48 85 c0 49 89 c1 75 7e <41> 8b 41 08 83 f8 09 74 41 83 f8 1b 74 3c 4d 2b 64 24 58 49 81 ec
>>kernel: RSP: 0018:ffffc90000a1fd30 EFLAGS: 00010246
>>kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000009
>>kernel: RDX: ffffffff82aed4f0 RSI: 0000000000001000 RDI: 0000000000001000
>>kernel: RBP: ffffea0001800000 R08: 0000000000200000 R09: 0000000000000000
>>kernel: R10: 0000000000001000 R11: 0000000000000003 R12: ffff88813ffd45c0
>>kernel: R13: 0000000000060000 R14: 0000000000000001 R15: ffffea0000000000
>>kernel: FS:  00007fd71d9b3500(0000) GS:ffff88813bb00000(0000) knlGS:0000000000000000
>>kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>kernel: CR2: 0000000000000008 CR3: 00000001371c2002 CR4: 00000000003606e0
>>kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>kernel: Call Trace:
>>kernel:  is_mem_section_removable+0x7d/0x100
>>kernel:  removable_show+0x90/0xb0
>>kernel:  dev_attr_show+0x1c/0x50
>>kernel:  sysfs_kf_seq_show+0xca/0x1b0
>>kernel:  seq_read+0x133/0x380
>>kernel:  __vfs_read+0x26/0x180
>>kernel:  vfs_read+0x89/0x140
>>kernel:  ksys_read+0x42/0x90
>>kernel:  do_syscall_64+0x5b/0x180
>>kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>kernel: RIP: 0033:0x7fd71d4c8b41
>>kernel: Code: fe ff ff 48 8d 3d 27 9e 09 00 48 83 ec 08 e8 96 02 02 00 66 0f 1f 44 00 00 8b 05 ea fc 2c 00 48 63 ff 85 c0 75 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 57 f3 c3 0f 1f 44 00 00 55 53 48 89 d5 48 89
>>kernel: RSP: 002b:00007ffeab5f6448 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>>kernel: RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007fd71d4c8b41
>>kernel: RDX: 0000000000020000 RSI: 00007fd71d809000 RDI: 0000000000000003
>>kernel: RBP: 0000000000020000 R08: ffffffffffffffff R09: 0000000000000000
>>kernel: R10: 000000000000038b R11: 0000000000000246 R12: 00007fd71d809000
>>kernel: R13: 0000000000000003 R14: 00007fd71d80900f R15: 0000000000020000
>>kernel: Modules linked in: af_packet(E) xt_tcpudp(E) ipt_REJECT(E) xt_conntrack(E) nf_conntrack(E) nf_defrag_ipv4(E) ip_set(E) nfnetlink(E) ebtable_nat(E) ebtable_broute(E) bridge(E) stp(E) llc(E) iptable_mangle(E) iptable_raw(E) iptable_security(E) ebtable_filter(E) ebtables(E) iptable_filter(E) ip_tables(E) x_tables(E) kvm_intel(E) kvm(E) irqbypass(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) bochs_drm(E) ttm(E) drm_kms_helper(E) drm(E) aesni_intel(E) virtio_net(E) syscopyarea(E) net_failover(E) sysfillrect(E) failover(E) aes_x86_64(E) crypto_simd(E) sysimgblt(E) cryptd(E) pcspkr(E) glue_helper(E) parport_pc(E) fb_sys_fops(E) i2c_piix4(E) parport(E) button(E) btrfs(E) libcrc32c(E) xor(E) zstd_decompress(E) zstd_compress(E) raid6_pq(E) sd_mod(E) ata_generic(E) ata_piix(E) ahci(E) libahci(E) serio_raw(E) crc32c_intel(E) virtio_pci(E) virtio_ring(E) virtio(E) libata(E) sg(E) scsi_mod(E) autofs4(E)
>>kernel: CR2: 0000000000000008
>>kernel: ---[ end trace 49cade81474e40e7 ]---
>>kernel: RIP: 0010:has_unmovable_pages+0x154/0x210
>>kernel: Code: 1b ff ff ff eb 32 48 8b 45 00 bf 00 10 00 00 a9 00 00 01 00 74 07 0f b6 4d 51 48 d3 e7 e8 c4 81 05 00 48 85 c0 49 89 c1 75 7e <41> 8b 41 08 83 f8 09 74 41 83 f8 1b 74 3c 4d 2b 64 24 58 49 81 ec
>>kernel: RSP: 0018:ffffc90000a1fd30 EFLAGS: 00010246
>>kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000009
>>kernel: RDX: ffffffff82aed4f0 RSI: 0000000000001000 RDI: 0000000000001000
>>kernel: RBP: ffffea0001800000 R08: 0000000000200000 R09: 0000000000000000
>>kernel: R10: 0000000000001000 R11: 0000000000000003 R12: ffff88813ffd45c0
>>kernel: R13: 0000000000060000 R14: 0000000000000001 R15: ffffea0000000000
>>kernel: FS:  00007fd71d9b3500(0000) GS:ffff88813bb00000(0000) knlGS:0000000000000000
>>kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>kernel: CR2: 0000000000000008 CR3: 00000001371c2002 CR4: 00000000003606e0
>>kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>--->
>>
>>The reason is we do not pass the Head to page_hstate(), and so,
>>the call to compound_order() in page_hstate() returns 0, so
>>we end up checking all hstates's size to match PAGE_SIZE.
>>
>>Obviously, we do not find any hstate matching that size, and we
>>return NULL.
>>Then, we dereference that NULL pointer in hugepage_migration_supported()
>>and we got the #PF from above.
>>
>>Fix that by getting the head page before calling page_hstate().
>>
>>Also, since gigantic pages span several pageblocks, re-adjust the logic
>>for skipping pages.
>>
>>Signed-off-by: Oscar Salvador <osalvador@suse.de>
>>---
>> mm/page_alloc.c | 7 +++++--
>> 1 file changed, 5 insertions(+), 2 deletions(-)
>>
>>diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>index a6e7bfd18cde..90ad281f750c 100644
>>--- a/mm/page_alloc.c
>>+++ b/mm/page_alloc.c
>>@@ -8038,11 +8038,14 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>> 		 * handle each tail page individually in migration.
>> 		 */
>> 		if (PageHuge(page)) {
>>+			struct page *head = compound_head(page);
>>+			unsigned int skip_pages;
>> 
>>-			if (!hugepage_migration_supported(page_hstate(page)))
>>+			if (!hugepage_migration_supported(page_hstate(head)))
>> 				goto unmovable;
>> 
>>-			iter = round_up(iter + 1, 1<<compound_order(page)) - 1;
>>+			skip_pages = (1 << compound_order(head)) - (page - head);
>>+			iter = round_up(iter + 1, skip_pages) - 1;
>
>The comment of round_up says round up to next specified power of 2.  And
>second parameter must be a power of 2.
>
>Look skip_pages not satisfy this.
>

Maybe the first version from Oscar is correct, because round_up() does
the (page - head) calculation in it.

>> 			continue;
>> 		}
>> 
>>-- 
>>2.13.7
>
>-- 
>Wei Yang
>Help you, Help me

-- 
Wei Yang
Help you, Help me
