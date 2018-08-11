Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB51C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 08:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9D0223E6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 08:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ks+y6vOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9D0223E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeHKKfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 06:35:10 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43404 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbeHKKfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 06:35:10 -0400
Received: by mail-qk0-f196.google.com with SMTP id z74-v6so7935875qkb.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 01:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PcWLAN+atwDcU2RuePCWuiwp/JR1bR56eaOYu+0fdeE=;
        b=Ks+y6vOMor+hdIBC1RQHOLTMnkZ753y3BQeZuyvTLR3YKhBuPcbKrVcIZFdpzKREcl
         WGA8DYmd1fTAkN3+Ljzob2fKF+XdpnkMTy1SEkQSsbDAAW5+Hq/+6gUdNAYiAgPXjLEz
         xOvveq8eI3On+2XxRdgLD1fIKanwoSJLyNXLUr5D6Vk38vO1JB2idBJ+f5nhjJ6JbAkR
         V3TMQ5EuDByRuYSMzJHhrD1BPvReKQA01ZbUrhfPT98FoLgTH1Sbz9uGQvnsyVc+beW0
         KdtKHP0V4b7iypVKLUOkSl7sO0Ggf2/f197hurfeYJ3JMUA5/DROsmPhFyfNPN6vjTk/
         hhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PcWLAN+atwDcU2RuePCWuiwp/JR1bR56eaOYu+0fdeE=;
        b=IDi8BK39QU15ax3y7F9ABF2AwcLnokp21dPffFll1jXESDIUf1y2GSwV3ZIWuGrmpk
         fBq3vYP+0LiUIQ9XVtbOJnJRCaz3xs3cdMhP/GQrZpIGWcatsbPyzssTsi2RDTE/BXY/
         n2LszKDR0mdyn2ymCHceVhIOKtr/PZESu2F3qN3TOtl151xvLFFy0LZXm/EqsQn0rKqH
         /CX2ymhwyIWjRbUqY2ZkwydoP4mluqXAf6QEHtCYeiXz6xyKZF3Camc2R1rp23SAIAl/
         eFr0gNjIuHkgfDUj7Ii1llBIY3qHazLjszoJKwtkUe4lB5WIhrvKDoN1NTc99dTsGqfe
         7l9A==
X-Gm-Message-State: AOUpUlHoCkxAm9X4SNZFHOaCDIWM5oeUE1gKUziRgu773Mmu+b5uSvjF
        /5kkodwQiWTJ3Ur+m2ks1t5Ng1Fy51GW8hrw7rw=
X-Google-Smtp-Source: AA+uWPzNsBemhq1KxmR4B6+xAsWpuHbAMCNIhaK5X3Ww+fCMvkmj0GGGLRytgYd9F8W0AOkfBzqt2g+cgVqzTq7Niog=
X-Received: by 2002:a37:6e82:: with SMTP id j124-v6mr8977923qkc.179.1533974508497;
 Sat, 11 Aug 2018 01:01:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Sat, 11 Aug 2018 01:01:48
 -0700 (PDT)
In-Reply-To: <20180809041856.1547-3-ravi.bangoria@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com> <20180809041856.1547-3-ravi.bangoria@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Sat, 11 Aug 2018 01:01:48 -0700
Message-ID: <CAPhsuW71ysLTafz2y=v_dY_=0BOn0MDL0TKD6eEBQ2ZQUTBuvw@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] Uprobe: Additional argument arch_uprobe to uprobe_write_opcode()
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     srikar@linux.vnet.ibm.com, Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 9:18 PM, Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
> Add addition argument 'arch_uprobe' to uprobe_write_opcode().
> We need this in later set of patches.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Reviewed-by: Song Liu <songliubraving@fb.com>

> ---
>  arch/arm/probes/uprobes/core.c | 2 +-
>  arch/mips/kernel/uprobes.c     | 2 +-
>  include/linux/uprobes.h        | 2 +-
>  kernel/events/uprobes.c        | 9 +++++----
>  4 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
> index d1329f1ba4e4..bf992264060e 100644
> --- a/arch/arm/probes/uprobes/core.c
> +++ b/arch/arm/probes/uprobes/core.c
> @@ -32,7 +32,7 @@ bool is_swbp_insn(uprobe_opcode_t *insn)
>  int set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
>              unsigned long vaddr)
>  {
> -       return uprobe_write_opcode(mm, vaddr,
> +       return uprobe_write_opcode(auprobe, mm, vaddr,
>                    __opcode_to_mem_arm(auprobe->bpinsn));
>  }
>
> diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
> index f7a0645ccb82..4aaff3b3175c 100644
> --- a/arch/mips/kernel/uprobes.c
> +++ b/arch/mips/kernel/uprobes.c
> @@ -224,7 +224,7 @@ unsigned long arch_uretprobe_hijack_return_addr(
>  int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
>         unsigned long vaddr)
>  {
> -       return uprobe_write_opcode(mm, vaddr, UPROBE_SWBP_INSN);
> +       return uprobe_write_opcode(auprobe, mm, vaddr, UPROBE_SWBP_INSN);
>  }
>
>  void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 0a294e950df8..bb9d2084af03 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -121,7 +121,7 @@ extern bool is_swbp_insn(uprobe_opcode_t *insn);
>  extern bool is_trap_insn(uprobe_opcode_t *insn);
>  extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
>  extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
> -extern int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
> +extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
>  extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
>  extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
>  extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 471eac896635..c0418ba52ba8 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -299,8 +299,8 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
>   * Called with mm->mmap_sem held for write.
>   * Return 0 (success) or a negative errno.
>   */
> -int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr,
> -                       uprobe_opcode_t opcode)
> +int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> +                       unsigned long vaddr, uprobe_opcode_t opcode)
>  {
>         struct page *old_page, *new_page;
>         struct vm_area_struct *vma;
> @@ -351,7 +351,7 @@ int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr,
>   */
>  int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
>  {
> -       return uprobe_write_opcode(mm, vaddr, UPROBE_SWBP_INSN);
> +       return uprobe_write_opcode(auprobe, mm, vaddr, UPROBE_SWBP_INSN);
>  }
>
>  /**
> @@ -366,7 +366,8 @@ int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned
>  int __weak
>  set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
>  {
> -       return uprobe_write_opcode(mm, vaddr, *(uprobe_opcode_t *)&auprobe->insn);
> +       return uprobe_write_opcode(auprobe, mm, vaddr,
> +                       *(uprobe_opcode_t *)&auprobe->insn);
>  }
>
>  static struct uprobe *get_uprobe(struct uprobe *uprobe)
> --
> 2.14.4
>
