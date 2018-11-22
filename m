Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3028BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC80620824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JDAKN3xG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC80620824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406450AbeKWEVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:21:20 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39929 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406436AbeKWEVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:21:20 -0500
Received: by mail-it1-f193.google.com with SMTP id m15so14817598itl.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 09:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D2mPpAdzEUjRsP3tiFBkCRVA+eY0Zrenpnfw3UgI3Lw=;
        b=JDAKN3xGG/TQIO//97b9kqn3uotN7+CdwlP0aTNyvXJGOL+HGQbRTU6RkORyJkCJRq
         I9Qlqe793VMdUWlmKg6gEodrTrQNJSpdBFw4hskHCrjpC9U9fQ4REpJDnbWhPi+BiFD2
         zA9g6rS3kYXL7iD/eZGSPlsLuZIoowmI0umT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2mPpAdzEUjRsP3tiFBkCRVA+eY0Zrenpnfw3UgI3Lw=;
        b=YYoO2+E+ZcEInKHYF0yQslfzqxnCHRjdl6D8LmC0oM0F38ZpS2ThB3ZYsWFcE5NdU5
         a8WDBBPakYrf4VrewSXUNi0WFvP1tReixvc6RplYX/iamORWCL7CxVyQfYN4pQGtT6Io
         xjN4JnsIlTO9pwlF6xuc+e8H1w5G4BQVfh8Q8lfVgKTfTnBiO/XREwN0rPTosl34cirN
         GXnpZVgVSZKmiFxehsQyggNPw9z/M4BY3mBk2c7wYNziY1Kek6k3q8AZcfM3iHyfpPjL
         T9CtuLe7E4+eXNt4vxLUC7CY8qoq3eMkXHnj8ePMeHbxxxT7+LOmRlt/tq5yXdRg4Q+D
         JzkA==
X-Gm-Message-State: AA+aEWYKDJH9yBWA1ypVHwxicwvpcHbpBkgb04IoFqOPV9pAYKCox7YV
        DeG9GzZUMzBw3xhTGRYUpRA86ghytKPo22tb4ewVzw==
X-Google-Smtp-Source: AFSGD/VHuIP6BHuNNA5/7d9Skowu/zZfJ2fE1541R+8jjaC01bN9qEN6d/+nQaK6m024yKxxy926P+DLJLJWE/nLGSU=
X-Received: by 2002:a02:4c9:: with SMTP id 192mr9992420jab.2.1542908456959;
 Thu, 22 Nov 2018 09:40:56 -0800 (PST)
MIME-Version: 1.0
References: <20181119162513.16562-1-vincent.whitchurch@axis.com>
 <20181122120154.GH3505@e103592.cambridge.arm.com> <20181122122411.6ydftk7bjlrefwa5@axis.com>
 <20181122162849.GA8856@linux-8ccs>
In-Reply-To: <20181122162849.GA8856@linux-8ccs>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 22 Nov 2018 18:40:45 +0100
Message-ID: <CAKv+Gu_vAKhQ2oakTeJNwP_F6dhqKe2ZwjAR13wrVKfL5aS4Fw@mail.gmail.com>
Subject: Re: [PATCH 1/2] module: Overwrite st_size instead of st_info
To:     Jessica Yu <jeyu@kernel.org>
Cc:     vincent.whitchurch@axis.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018 at 17:29, Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Vincent Whitchurch [22/11/18 13:24 +0100]:
> >On Thu, Nov 22, 2018 at 12:01:54PM +0000, Dave Martin wrote:
> >> On Mon, Nov 19, 2018 at 05:25:12PM +0100, Vincent Whitchurch wrote:
> >> > st_info is currently overwritten after relocation and used to store the
> >> > elf_type().  However, we're going to need it fix kallsyms on ARM's
> >> > Thumb-2 kernels, so preserve st_info and overwrite the st_size field
> >> > instead.  st_size is neither used by the module core nor by any
> >> > architecture.
> >> >
> >> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> >> > ---
> >> > v4: Split out to separate patch.  Use st_size instead of st_other.
> >> > v1-v3: See PATCH 2/2
> >> >
> >> >  kernel/module.c | 4 ++--
> >> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/kernel/module.c b/kernel/module.c
> >> > index 49a405891587..3d86a38b580c 100644
> >> > --- a/kernel/module.c
> >> > +++ b/kernel/module.c
> >> > @@ -2682,7 +2682,7 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
> >> >
> >> >    /* Set types up while we still have access to sections. */
> >> >    for (i = 0; i < mod->kallsyms->num_symtab; i++)
> >> > -          mod->kallsyms->symtab[i].st_info
> >> > +          mod->kallsyms->symtab[i].st_size
> >> >                    = elf_type(&mod->kallsyms->symtab[i], info);
> >> >
> >> >    /* Now populate the cut down core kallsyms for after init. */
> >> > @@ -4061,7 +4061,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
> >> >            kallsyms = rcu_dereference_sched(mod->kallsyms);
> >> >            if (symnum < kallsyms->num_symtab) {
> >> >                    *value = kallsyms->symtab[symnum].st_value;
> >> > -                  *type = kallsyms->symtab[symnum].st_info;
> >> > +                  *type = kallsyms->symtab[symnum].st_size;
> >> >                    strlcpy(name, symname(kallsyms, symnum), KSYM_NAME_LEN);
> >> >                    strlcpy(module_name, mod->name, MODULE_NAME_LEN);
> >> >                    *exported = is_exported(name, *value, mod);
> >>
> >> This is fine if st_size is really unused, but how sure are you of that?
> >>
> >> grepping for st_size throws up some hits that appear ELF-related, but
> >> I've not investigated them in detail.
> >>
> >> (The fact that struct stat has an identically named field throws up
> >> a load of false positives too.)
> >
> >$ git describe --tags
> >v4.20-rc3-93-g92b419289cee
> >
> >$ rg -m1 '[\.>]st_size'  --iglob '!**/tools/**' --iglob '!**/vdso*' --iglob '!**/scripts/**' --iglob '!**/usr/**' --iglob '!**/samples/**' | cat
> >| kernel/kexec_file.c: if (sym->st_size != size) {
> >
> >Symbols in kexec kernel.
> >
> >| fs/stat.c:   tmp.st_size = stat->size;
> >| Documentation/networking/tls.txt:  sendfile(sock, file, &offset, stat.st_size);
> >| net/9p/client.c:             ret->st_rdev, ret->st_size, ret->st_blksize,
> >| net/9p/protocol.c:                                   &stbuf->st_rdev, &stbuf->st_size,
> >| fs/9p/vfs_inode_dotl.c:              i_size_write(inode, stat->st_size);
> >| fs/hostfs/hostfs_user.c:     p->size = buf->st_size;
> >| arch/powerpc/boot/mktree.c:  nblks = (st.st_size + IMGBLK) / IMGBLK;
> >| arch/alpha/kernel/osf_sys.c: tmp.st_size     = lstat->size;
> >| arch/x86/ia32/sys_ia32.c:        __put_user(stat->size, &ubuf->st_size) ||
> >
> >Not Elf_Sym.
> >
> >| arch/x86/kernel/machine_kexec_64.c:                   sym->st_size);
> >
> >Symbols in kexec kernel.
> >
> >| arch/sparc/boot/piggyback.c: st4(buffer + 12, s.st_size);
> >| arch/sparc/kernel/sys_sparc32.c:     err |= put_user(stat->size, &statbuf->st_size);
> >| arch/um/os-Linux/file.c:             .ust_size    = src->st_size,    /* total size, in bytes */
> >| arch/um/os-Linux/start_up.c: size = (buf.st_size + UM_KERN_PAGE_SIZE) & ~(UM_KERN_PAGE_SIZE - 1);
> >| arch/s390/kernel/compat_linux.c:     tmp.st_size = stat->size;
> >| arch/arm/kernel/sys_oabi-compat.c:   tmp.st_size = stat->size;
> >| arch/mips/boot/compressed/calc_vmlinuz_load_addr.c:  vmlinux_size = (uint64_t)sb.st_size;
> >| drivers/net/ethernet/marvell/sky2.c:         hw->st_idx = RING_NEXT(hw->st_idx, hw->st_size);
> >
> >Not Elf_Sym.
>
> [ added Miroslav to CC, just in case he would like to check :) ]
>
> I have just double checked as well, and am fairly certain that the
> Elf_Sym st_size field is not used to apply module relocations in any
> arches, and it is not used in the core module loader nor in the module
> kallsyms code. We'd like to avoid overwriting st_info in any case, to
> fix kallsyms on Thumb-2 and also so that livepatch won't run into any
> issues with delayed relocations, should livepatch support ever expand
> to arches (e.g., arm) that rely on st_info for module relocations.
>

Also note that st_size cannot be relied upon in general, since we
overwrite the addresses of undefined symbols in a module's symbol
table when resolve them against ksyms, while the st_size field is kept
at 0. At relocation time, we don't really distinguish anymore between
local and external module symbols, and so relying on st_size to be
accurate would definitely break things.
