Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E21CC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 03:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAE620C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 03:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAE620C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeIYJoA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 05:44:00 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39192 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbeIYJn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 05:43:59 -0400
Received: by mail-it1-f196.google.com with SMTP id w200-v6so5229287itc.4;
        Mon, 24 Sep 2018 20:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FHHwzBW7g3qOnNhrt/f9DbTQ5B0XU0w/gTZNaswBLkU=;
        b=REAGCY34IbqTtuqGFbiRoCpXCQjxGH/O1VEQj8dz9uc/YFDc9efE099jYWHe1R/IAl
         xwUvyQ8lcAdnwJf30PY/7C3JRcLh1Y8Bl2SwLfT10V04erd1ETu+wbzLyRIY7rQoe+tx
         qEoz4GmEO+aCTREnUlAxgZd32nYJjLCWxZLnVJMJP1/sp9Ejt4g1qbcNGg/ujmZS5grj
         9nxgbYcV2efT50JKTgD7dNIGKNY633H2AToUFG7SUtJ5X8UozFW07WeK6NUIaOX42NCg
         d1PKzYPimoiL0GG1LQ6WmPAIYAJ+bfck9XSY3d9uEwAmvU4tkZDiyut+P3DD3L5Vm2jw
         xTNA==
X-Gm-Message-State: ABuFfojBIrxWX7/TFE6Eih13nQCe2E2WdSxF5G9cQ4pcaUinl5zh5rbv
        rjxaxclXEtkSbR6Pfu+FWeXsuKBjCWV0hg==
X-Google-Smtp-Source: ACcGV63FPqr2KN4dua8ziQVL7Y4qxRGktXRzMSmvU/PYp/XpqwLvfnWu7ilWbvGYk3T6eJw7XuYNNQ==
X-Received: by 2002:a02:98db:: with SMTP id c27-v6mr305751jak.24.1537846712023;
        Mon, 24 Sep 2018 20:38:32 -0700 (PDT)
Received: from mail-it1-f174.google.com (mail-it1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id z195-v6sm478693iof.71.2018.09.24.20.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 20:38:30 -0700 (PDT)
Received: by mail-it1-f174.google.com with SMTP id h3-v6so13617199ita.2;
        Mon, 24 Sep 2018 20:38:30 -0700 (PDT)
X-Received: by 2002:a24:ad2e:: with SMTP id c46-v6mr1209191itf.82.1537846710225;
 Mon, 24 Sep 2018 20:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180924113103.337261320@linuxfoundation.org> <20180924113116.349047480@linuxfoundation.org>
 <20180925013548.GA28493@roeck-us.net>
In-Reply-To: <20180925013548.GA28493@roeck-us.net>
From:   =?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>
Date:   Tue, 25 Sep 2018 11:38:16 +0800
X-Gmail-Original-Message-ID: <CAFk6z8PzPo9Uza_pwxo=tm9nWWgax2GJMktUmYu_1QrJGJpy6A@mail.gmail.com>
Message-ID: <CAFk6z8PzPo9Uza_pwxo=tm9nWWgax2GJMktUmYu_1QrJGJpy6A@mail.gmail.com>
Subject: Re: [PATCH 4.9 111/111] MIPS: VDSO: Drop gic_get_usm_range() usage
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        paul.burton@imgtec.com, jason@lakedaemon.net, marc.zyngier@arm.com,
        tglx@linutronix.de, linux-mips@linux-mips.org, ralf@linux-mips.org,
        SZ Lin <sz.lin@moxa.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Guenter Roeck <linux@roeck-us.net> 於 2018年9月25日 週二 上午9:36寫道：
>
> On Mon, Sep 24, 2018 at 01:53:18PM +0200, Greg Kroah-Hartman wrote:
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
> >
>
> This patch breaks v4.4.y and v4.9.y builds.
> It includes asm/mips-cps.h which doesn't exist in those releases.

I am sorry for my fault, thanks for your report.

Since the patch b025d51873d5fe6 "MIPS: CM: Specify register size when
generating accessors" which created asm/mips-cps.h is not a bug-fixed
patch, hence I will not backport this header.

Hi Greg,

Could you please help to revert this commit? This commit was intended
to fix dependency of 70d7783 "MIPS: VDSO: Match data page cache
colouring when D$ aliases", but I saw 70d7783 was merged before this
commit; therefore, I don't think it is necessary to keep this commit.

I apology for any inconvenience caused, and I will be more careful next time.

SZ Lin (林上智)

>
> Building mips:malta_defconfig:smp:initrd ... failed
> ------------
> Error log:
> arch/mips/kernel/vdso.c:23:26: fatal error: asm/mips-cps.h: No such file or directory
>
> Guenter
>
> > ------------------
> >
> > From: Paul Burton <paul.burton@imgtec.com>
> >
> > commit 00578cd864d45ae4b8fa3f684f8d6f783dd8d15d upstream.
> >
> > We don't really need gic_get_usm_range() to abstract discovery of the
> > address of the GIC user-visible section now that we have access to its
> > base address globally.
> >
> > Switch to calculating it ourselves, which will allow us to stop
> > requiring the irqchip driver to care about a counter exposed to userland
> > for use via the VDSO.
> >
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: linux-mips@linux-mips.org
> > Patchwork: https://patchwork.linux-mips.org/patch/17040/
> > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> > Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  arch/mips/kernel/vdso.c |   15 +++++----------
> >  1 file changed, 5 insertions(+), 10 deletions(-)
> >
> > --- a/arch/mips/kernel/vdso.c
> > +++ b/arch/mips/kernel/vdso.c
> > @@ -13,7 +13,6 @@
> >  #include <linux/err.h>
> >  #include <linux/init.h>
> >  #include <linux/ioport.h>
> > -#include <linux/irqchip/mips-gic.h>
> >  #include <linux/kernel.h>
> >  #include <linux/mm.h>
> >  #include <linux/sched.h>
> > @@ -21,6 +20,7 @@
> >  #include <linux/timekeeper_internal.h>
> >
> >  #include <asm/abi.h>
> > +#include <asm/mips-cps.h>
> >  #include <asm/page.h>
> >  #include <asm/vdso.h>
> >
> > @@ -101,9 +101,8 @@ int arch_setup_additional_pages(struct l
> >  {
> >       struct mips_vdso_image *image = current->thread.abi->vdso;
> >       struct mm_struct *mm = current->mm;
> > -     unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr;
> > +     unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr, gic_pfn;
> >       struct vm_area_struct *vma;
> > -     struct resource gic_res;
> >       int ret;
> >
> >       if (down_write_killable(&mm->mmap_sem))
> > @@ -127,7 +126,7 @@ int arch_setup_additional_pages(struct l
> >        * only map a page even though the total area is 64K, as we only need
> >        * the counter registers at the start.
> >        */
> > -     gic_size = gic_present ? PAGE_SIZE : 0;
> > +     gic_size = mips_gic_present() ? PAGE_SIZE : 0;
> >       vvar_size = gic_size + PAGE_SIZE;
> >       size = vvar_size + image->size;
> >
> > @@ -168,13 +167,9 @@ int arch_setup_additional_pages(struct l
> >
> >       /* Map GIC user page. */
> >       if (gic_size) {
> > -             ret = gic_get_usm_range(&gic_res);
> > -             if (ret)
> > -                     goto out;
> > +             gic_pfn = virt_to_phys(mips_gic_base + MIPS_GIC_USER_OFS) >> PAGE_SHIFT;
> >
> > -             ret = io_remap_pfn_range(vma, base,
> > -                                      gic_res.start >> PAGE_SHIFT,
> > -                                      gic_size,
> > +             ret = io_remap_pfn_range(vma, base, gic_pfn, gic_size,
> >                                        pgprot_noncached(PAGE_READONLY));
> >               if (ret)
> >                       goto out;
> >
> >
