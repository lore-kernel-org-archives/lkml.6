Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA254C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851A7206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbfAIO6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:58:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:38742 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731723AbfAIO6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:58:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E36F4AE0F;
        Wed,  9 Jan 2019 14:57:57 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     yamada.masahiro@socionext.com, aou@eecs.berkeley.edu,
        alankao@andestech.com, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, deepa.kernel@gmail.com,
        linux-riscv@lists.infradead.org, Jim Wilson <jimw@sifive.com>
Subject: Re: [PATCH] riscv: remove redundant kernel-space generic-y
References: <CAK7LNAT+5eOFc64SG2SKCOThVVsz6S2NPBpemdcjCcZX_zds2Q@mail.gmail.com>
        <mhng-aacb9594-f17b-4728-91f7-e2804e6a3dbc@palmer-si-x1c4>
X-Yow:  ...Just enough time to do my LIBERACE impression...
Date:   Wed, 09 Jan 2019 15:57:54 +0100
In-Reply-To: <mhng-aacb9594-f17b-4728-91f7-e2804e6a3dbc@palmer-si-x1c4>
        (Palmer Dabbelt's message of "Tue, 08 Jan 2019 12:17:19 -0800 (PST)")
Message-ID: <mvmd0p5g9ot.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 08 2019, Palmer Dabbelt <palmer@sifive.com> wrote:

> On Fri, 04 Jan 2019 07:03:20 PST (-0800), yamada.masahiro@socionext.com wrote:
>> On Fri, Jan 4, 2019 at 11:16 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>>>
>>> On Sun, 16 Dec 2018 06:11:11 PST (-0800), yamada.masahiro@socionext.com wrote:
>>> > This commit removes redundant generic-y defines in
>>> > arch/riscv/include/asm/Kbuild.
>>> >
>>> > [1] It is redundant to define the same generic-y in both
>>> >     arch/$(ARCH)/include/asm/Kbuild and
>>> >     arch/$(ARCH)/include/uapi/asm/Kbuild.
>>> >
>>> >     Remove the following generic-y:
>>> >
>>> >       errno.h
>>> >       fcntl.h
>>> >       ioctl.h
>>> >       ioctls.h
>>> >       ipcbuf.h
>>> >       mman.h
>>> >       msgbuf.h
>>> >       param.h
>>> >       poll.h
>>> >       posix_types.h
>>> >       resource.h
>>> >       sembuf.h
>>> >       setup.h
>>> >       shmbuf.h
>>> >       signal.h
>>> >       socket.h
>>> >       sockios.h
>>> >       stat.h
>>> >       statfs.h
>>> >       swab.h
>>> >       termbits.h
>>> >       termios.h
>>> >       types.h
>>> >
>>> > [2] It is redundant to define generic-y when arch-specific
>>> >     implementation exists in arch/$(ARCH)/include/asm/*.h
>>> >
>>> >     Remove the following generic-y:
>>> >
>>> >       cacheflush.h
>>> >       dma-mapping.h
>>> >       module.h
>>> >
>>> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> > ---
>>> >
>>> >  arch/riscv/include/asm/Kbuild | 26 --------------------------
>>> >  1 file changed, 26 deletions(-)
>>> >
>>> > diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
>>> > index 6a646d9..f7068f3 100644
>>> > --- a/arch/riscv/include/asm/Kbuild
>>> > +++ b/arch/riscv/include/asm/Kbuild
>>> > @@ -1,5 +1,4 @@
>>> >  generic-y += bugs.h
>>> > -generic-y += cacheflush.h
>>> >  generic-y += checksum.h
>>> >  generic-y += compat.h
>>> >  generic-y += cputime.h
>>> > @@ -7,18 +6,12 @@ generic-y += device.h
>>> >  generic-y += div64.h
>>> >  generic-y += dma.h
>>> >  generic-y += dma-contiguous.h
>>> > -generic-y += dma-mapping.h
>>> >  generic-y += emergency-restart.h
>>> > -generic-y += errno.h
>>> >  generic-y += exec.h
>>> >  generic-y += fb.h
>>> > -generic-y += fcntl.h
>>> >  generic-y += hardirq.h
>>> >  generic-y += hash.h
>>> >  generic-y += hw_irq.h
>>> > -generic-y += ioctl.h
>>> > -generic-y += ioctls.h
>>> > -generic-y += ipcbuf.h
>>> >  generic-y += irq_regs.h
>>> >  generic-y += irq_work.h
>>> >  generic-y += kdebug.h
>>> > @@ -27,34 +20,15 @@ generic-y += kvm_para.h
>>> >  generic-y += local.h
>>> >  generic-y += local64.h
>>> >  generic-y += mm-arch-hooks.h
>>> > -generic-y += mman.h
>>> > -generic-y += module.h
>>> > -generic-y += msgbuf.h
>>> >  generic-y += mutex.h
>>> > -generic-y += param.h
>>> >  generic-y += percpu.h
>>> > -generic-y += poll.h
>>> > -generic-y += posix_types.h
>>> >  generic-y += preempt.h
>>> > -generic-y += resource.h
>>> >  generic-y += scatterlist.h
>>> >  generic-y += sections.h
>>> > -generic-y += sembuf.h
>>> >  generic-y += serial.h
>>> > -generic-y += setup.h
>>> > -generic-y += shmbuf.h
>>> >  generic-y += shmparam.h
>>> > -generic-y += signal.h
>>> > -generic-y += socket.h
>>> > -generic-y += sockios.h
>>> > -generic-y += stat.h
>>> > -generic-y += statfs.h
>>> > -generic-y += swab.h
>>> > -generic-y += termbits.h
>>> > -generic-y += termios.h
>>> >  generic-y += topology.h
>>> >  generic-y += trace_clock.h
>>> > -generic-y += types.h
>>> >  generic-y += unaligned.h
>>> >  generic-y += user.h
>>> >  generic-y += vga.h
>>>
>>> Thanks.  These just sort of collected there because I hadn't trimmed them.  Is
>>> there a script that checks these?
>>
>>
>> No script is available for now, but
>> I'd like to turn on warnings to catch some cases:
>> https://patchwork.kernel.org/patch/10746823/
>>
>>
>> BTW, can I apply this to my tree
>> along with other cleanups?
>
> Acked-by: Palmer Dabbelt <palmer@sifive.com>

arch/riscv/include/asm/dma-mapping.h no longer exists.

In file included from ./include/linux/skbuff.h:34,
                 from ./include/net/net_namespace.h:36,
                 from ./include/linux/inet.h:46,
                 from ./include/linux/sunrpc/msg_prot.h:204,
                 from ./include/linux/sunrpc/auth.h:16,
                 from ./include/linux/nfs_fs.h:31,
                 from init/do_mounts.c:22:
./include/linux/dma-mapping.h:261:10: fatal error: asm/dma-mapping.h: No such file or directory
 #include <asm/dma-mapping.h>
          ^~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.build:277: init/do_mounts.o] Error 1

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
