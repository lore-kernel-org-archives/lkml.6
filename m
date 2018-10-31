Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BD8ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5E520821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FQfHNsD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5E520821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbeJaMOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:14:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbeJaMOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pHhSpw7zNNFLM9r5/FJ0pdAYJslev0EuKBNVhbQTOKk=; b=FQfHNsD0K6uXcqcWnJKHxveEZ
        K9owKxgdGaYHlOZwh/tFjtib13k/VQsDuaccIUKIRq/yWeVf3sBoaTkgUd3Iav6g09Gn1UL6zx5n+
        fjdVKp81lnB2+ENLGj47d33JgaCFdo6dl5qeXH6OElLekPnPr2Ezhn67McvzAqYWmsQjbZeP0yXJG
        T3AGLgHX2vSwuf6Xj0pPt82qsM0C9brBtCZn5y6Cfocmtcp7Kz1vOLK0VE7l8PtJT1C+cD5Yx6B6s
        t6E5/a6fJwiG/nODAsymgqBjgtQBwTiowPmCI7bfEQsOzzk11nx4Yw1ceBFovK+rxO17dPt+6liSj
        BToLz/vUw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHh1m-0000G0-8u; Wed, 31 Oct 2018 03:18:42 +0000
Date:   Tue, 30 Oct 2018 20:18:42 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+4fd0c066d82852499145@syzkaller.appspotmail.com>
Cc:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, zwisler@kernel.org
Subject: Re: WARNING in get_unlocked_entry
Message-ID: <20181031031842.GI10491@bombadil.infradead.org>
References: <000000000000c9000f05797370e4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c9000f05797370e4@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 08:00:03AM -0700, syzbot wrote:
> syzbot found the following crash on:
> 
> HEAD commit:    4b42745211af Merge tag 'armsoc-soc' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1187d06d400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=93932074d01b4a5
> dashboard link: https://syzkaller.appspot.com/bug?extid=4fd0c066d82852499145
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.

Hmmpf.  Would have been nice if syzbot had caught this during its tests
of the -next tree ...

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4fd0c066d82852499145@syzkaller.appspotmail.com
> 
> EXT4-fs (sda1): Cannot specify journal on remount
> EXT4-fs (sda1): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
> EXT4-fs (sda1): warning: refusing change of dax flag with busy inodes while
> remounting
> WARNING: CPU: 0 PID: 12870 at fs/dax.c:227 get_unlocked_entry+0x3ac/0x4d0
> fs/dax.c:227
> Kernel panic - not syncing: panic_on_warn set ...
> 
> CPU: 0 PID: 12870 Comm: syz-executor3 Not tainted 4.19.0+ #87
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x244/0x39d lib/dump_stack.c:113
>  panic+0x238/0x4e7 kernel/panic.c:184
>  __warn.cold.8+0x20/0x4a kernel/panic.c:536
>  report_bug+0x254/0x2d0 lib/bug.c:186
>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
>  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:966
> RIP: 0010:get_unlocked_entry+0x3ac/0x4d0 fs/dax.c:227
> Code: e8 31 ff 83 e0 01 48 89 c6 48 89 85 10 ff ff ff e8 09 18 96 ff 48 8b
> 85 10 ff ff ff 48 85 c0 0f 85 34 fe ff ff e8 c4 16 96 ff <0f> 0b e8 bd 16 96
> ff 48 b8 00 00 00 00 00 fc ff df 48 03 85 f8 fe
> RSP: 0018:ffff88018025e7b8 EFLAGS: 00010012
> RAX: 0000000000040000 RBX: ffff88018025ead8 RCX: ffffc90008983000
> RDX: 0000000000000341 RSI: ffffffff81e94d3c RDI: 0000000000000007
> RBP: ffff88018025e8c8 R08: ffff88017f862280 R09: ffffed003004bd08
> R10: ffffed003004bd08 R11: 0000000000000003 R12: dffffc0000000000
> R13: ffffea0005e01040 R14: ffff88018025e800 R15: ffff88018025e8a0
>  grab_mapping_entry fs/dax.c:447 [inline]

OK, so I'd like to know what value actually got loaded into 'entry'.
Maybe my x86-fu is weak, but I don't understand how this register dump
correlates with the instructions I'm seeing.

Here's the C code:

                entry = xas_load(xas);
                if (!entry || xa_is_internal(entry) ||
                                WARN_ON_ONCE(!xa_is_value(entry)) ||
                                !dax_is_locked(entry))
                        return entry;


I downloaded the .config that syzbot was using and built fs/dax.o.
Disassembling it, I get:

                                WARN_ON_ONCE(!xa_is_value(entry)) ||
    5e53:       31 ff                   xor    %edi,%edi
    5e55:       83 e0 01                and    $0x1,%eax
    5e58:       48 89 c6                mov    %rax,%rsi
    5e5b:       48 89 85 10 ff ff ff    mov    %rax,-0xf0(%rbp)
    5e62:       e8 00 00 00 00          callq  5e67 <get_unlocked_entry+0x397>
                        5e63: R_X86_64_PLT32    __sanitizer_cov_trace_const_cmp8
-0x4
    5e67:       48 8b 85 10 ff ff ff    mov    -0xf0(%rbp),%rax
    5e6e:       48 85 c0                test   %rax,%rax
    5e71:       0f 85 34 fe ff ff       jne    5cab <get_unlocked_entry+0x1db>
    5e77:       e8 00 00 00 00          callq  5e7c <get_unlocked_entry+0x3ac>
                        5e78: R_X86_64_PLT32    __sanitizer_cov_trace_pc-0x4
    5e7c:       0f 0b                   ud2    

That ud2 is the WARN_ON trigger.  It's at offset 0x3ac from the start of
get_unlocked_entry() so it matches the dump.

The key is 'test %rax,%rax' at 5e6e.  If that passes, we jump to 5cab
where we do xa_to_value() in order to implement dax_is_locked().  So is
'entry' actually 0x0000000000040000 like the dump says?

That's where I get confused.  The previous insn (5e67) loads rax from what
I presume is the stack, having previously stored it there at insn 535b.
But insn 5e51 should have reduced %rax to just 0 or 1 in the low bit of
the register.  So clearly I have my understanding of x86 insns confused.
If someone could help me out here, I'd be grateful.

