Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51E6C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D28E2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D28E2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbeJ3HiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 03:38:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46566 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730417AbeJ3HiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 03:38:01 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 84EAB33F3;
        Mon, 29 Oct 2018 22:47:12 +0000 (UTC)
Date:   Mon, 29 Oct 2018 15:47:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jonas Bonn <jonas@southpole.se>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <lftan@altera.com>,
        Mark Salter <msalter@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [LKP] [mm] 68c37ccedc:
 BUG:kernel_hang_in_early-boot_stage,last_printk:early_console_in_setup_code
Message-Id: <20181029154711.df59cb8d6150a55f5cfef67d@linux-foundation.org>
In-Reply-To: <20181029131501.GP24195@shao2-debian>
References: <20181029131501.GP24195@shao2-debian>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2018 21:15:01 +0800 kernel test robot <rong.a.chen@intel.com> wrote:

> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 68c37ccedcde10514898f4ba3b28c0de85c590d1 ("mm: nobootmem: remove bootmem allocation APIs")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu host -smp 2 -m 2G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
>
> +-----------------------------------------------------------------------------+------------+------------+
> |                                                                             | 6881a1e729 | 68c37ccedc |
> +-----------------------------------------------------------------------------+------------+------------+
> | boot_successes                                                              | 4          | 0          |
> | boot_failures                                                               | 0          | 4          |
> | BUG:kernel_hang_in_early-boot_stage,last_printk:early_console_in_setup_code | 0          | 4          |
> +-----------------------------------------------------------------------------+------------+------------+

Well that's irritating.

Does the problem remain when the entire patch series is applied?

mm-remove-config_no_bootmem.patch
mm-remove-config_no_bootmem-fix.patch
mm-remove-config_have_memblock.patch
mm-remove-config_have_memblock-fix.patch
mm-remove-config_have_memblock-fix-2.patch
mm-remove-config_have_memblock-fix-3.patch
mm-remove-bootmem-allocator-implementation.patch
mm-nobootmem-remove-dead-code.patch
memblock-rename-memblock_alloc_nid_try_nid-to-memblock_phys_alloc.patch
memblock-remove-_virt-from-apis-returning-virtual-address.patch
memblock-replace-alloc_bootmem_align-with-memblock_alloc.patch
memblock-replace-alloc_bootmem_low-with-memblock_alloc_low.patch
memblock-replace-__alloc_bootmem_node_nopanic-with-memblock_alloc_try_nid_nopanic.patch
memblock-replace-alloc_bootmem_pages_nopanic-with-memblock_alloc_nopanic.patch
memblock-replace-alloc_bootmem_low-with-memblock_alloc_low-2.patch
memblock-replace-__alloc_bootmem_nopanic-with-memblock_alloc_from_nopanic.patch
memblock-add-align-parameter-to-memblock_alloc_node.patch
memblock-replace-alloc_bootmem_pages_node-with-memblock_alloc_node.patch
memblock-replace-__alloc_bootmem_node-with-appropriate-memblock_-api.patch
memblock-replace-alloc_bootmem_node-with-memblock_alloc_node.patch
memblock-replace-alloc_bootmem_low_pages-with-memblock_alloc_low.patch
memblock-replace-alloc_bootmem_pages-with-memblock_alloc.patch
memblock-replace-__alloc_bootmem-with-memblock_alloc_from.patch
memblock-replace-alloc_bootmem-with-memblock_alloc.patch
mm-nobootmem-remove-bootmem-allocation-apis.patch
memblock-replace-free_bootmem_node-with-memblock_free.patch
memblock-replace-free_bootmem_late-with-memblock_free_late.patch
memblock-rename-free_all_bootmem-to-memblock_free_all.patch
memblock-rename-__free_pages_bootmem-to-memblock_free_pages.patch
mm-remove-nobootmem.patch
memblock-replace-bootmem_alloc_-with-memblock-variants.patch
mm-remove-include-linux-bootmemh.patch
mm-remove-include-linux-bootmemh-fix.patch
mm-remove-include-linux-bootmemh-fix-2.patch
mm-remove-include-linux-bootmemh-fix-3.patch
docs-boot-time-mm-remove-bootmem-documentation.patch

