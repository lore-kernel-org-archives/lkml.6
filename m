Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0000FC64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 14:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61A121871
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 14:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="bCkxpo2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbeLXO55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 09:57:57 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46769 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbeLXO55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 09:57:57 -0500
Received: by mail-ua1-f67.google.com with SMTP id v24so3898105uap.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 06:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=urADQiLgSF2VI5T7ctuf7Y7VNWHxgM6GsR/nEoGCKqk=;
        b=bCkxpo2i8nDKX3lfeE9U3QgyyVfDPgp5jKS6MRE2biKoynNQG/9BTBaa/1X1PDdHwf
         +MfJz1xS+irFadiOwsCdar08trJ8xGgt60k2Mrvb6ElQsZXunWWxsjIt9ds4Ss8CLUrH
         02jYVpSx7miix8OKKQsmbeRbW/hSNhPEtfJDNUTru+oE0B0ypEoBMHvnVOGIQhRzuMNW
         ShIdkWqCpcAlgjY5mEJ1sq1Y5u7QGtQn6AVzsIpG7WOe/ZEOalCeBPlc85jW7lkKgX6c
         WlTefHfLcZomXrNaIBw0agr5lm/OS0/AlT0xJrT2+MC+aLJvHWuN2ijYNsNyQdNtUdCo
         Gl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=urADQiLgSF2VI5T7ctuf7Y7VNWHxgM6GsR/nEoGCKqk=;
        b=icl5HK8BXT7/NLd6ZOr056zeQKrVe327W+BYRv4VInzyup7PDLmhZLPWgur6/L206G
         gnt2g3hKa5kcfRCQLigfYYGEEq/5XQ0bJupoyqQC1bLbbMtM5WUZY21WfsQZFdGWS/al
         a5vXjs2VevllTlrgM6VyhLVmtAIVcUmNo26NhGjQVIrnIpJ//1hei1GM0bD2F5gXMCqs
         EUOpDS+XCyHTlctLI7boVJ+STOdNxveoJMYQpt521OvEFMAVw6B8wxDwWAEsGF16h4wm
         vlk9IgMPf1d5jL8BUqDyaOQmCNsz0pyC57EqlVy/XUFBS8MYU7mT69kiBNTK9qjwZIYf
         LM+w==
X-Gm-Message-State: AJcUukfKGhZl0gsu6yGk+VzwgR1A8CqMXB7bBAk2Slt/k2KnMjR9vQ82
        t1QQ+UvGEKfiOXsvi9ek+Uz3+5nN25lv14RVeXP5xA==
X-Google-Smtp-Source: ALg8bN471E81KTk/vJM8KMAS3jVV9gOyieDvC8cRr1bMhJgZ6897RxTl5iaMxFrhzRT8qh9GDK9v++vVA502seQ99Fc=
X-Received: by 2002:ab0:4121:: with SMTP id j30mr4864670uad.65.1545663475880;
 Mon, 24 Dec 2018 06:57:55 -0800 (PST)
MIME-Version: 1.0
References: <20181116115055.7415-1-ahmedsoliman0x666@gmail.com> <20181116125858.yujwx5xkpg2kgyxe@kamzik.brq.redhat.com>
In-Reply-To: <20181116125858.yujwx5xkpg2kgyxe@kamzik.brq.redhat.com>
From:   Ahmed Soliman <ahmedsoliman@mena.vt.edu>
Date:   Mon, 24 Dec 2018 16:56:50 +0200
Message-ID: <CANBxJ=EeosO1EOfvQ6OFLps+D9ZQRBKTmByvcJ5r=h-4ahbekQ@mail.gmail.com>
Subject: Re: [PATCH V2] SelfTest: KVM: Drop Asserts for madvise
 MADV_NOHUGEPAGE failure
To:     Shuah Khan <shuah@kernel.org>, Andrew Jones <drjones@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hossam Hassan <7ossam9063@gmail.com>,
        Ahmed Lotfy <A7med.lotfey@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kind reminder to merge my patch into next

thanks.

On Fri, Nov 16, 2018 at 2:59 PM Andrew Jones <drjones@redhat.com> wrote:
>
> On Fri, Nov 16, 2018 at 01:50:55PM +0200, Ahmed Abd El Mawgood wrote:
> > From: Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
> >
> > madvise() returns -1 without CONFIG_TRANSPARENT_HUGEPAGE=y. That would
> > trigger asserts when checking for return value of madvice. Following
> > similar decision to [1]. I thought it is ok to assume that madvise()
> > MADV_NOHUGEPAGE failures implies that THP is not supported by host kernel.
> >
> > Other options was to check for Transparent Huge Page support in
> > /sys/kernel/mm/transparent_hugepage/enabled.
> >
> > -- links --
> > [1] https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg04514.html
> >
> > Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
> > ---
> >  tools/testing/selftests/kvm/lib/kvm_util.c | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > index 1b41e71283d5..437c5bb48061 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -586,14 +586,23 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
> >                                src_type == VM_MEM_SRC_ANONYMOUS_THP ?  huge_page_size : 1);
> >
> >       /* As needed perform madvise */
> > -     if (src_type == VM_MEM_SRC_ANONYMOUS || src_type == VM_MEM_SRC_ANONYMOUS_THP) {
> > +     if (src_type == VM_MEM_SRC_ANONYMOUS) {
> > +             /*
> > +              * Neglect madvise error because it is ok to not have THP
> > +              * support in this case.
> > +              */
> > +             madvise(region->host_mem, npages * vm->page_size,
> > +                     MADV_NOHUGEPAGE);
> > +     } else if (src_type == VM_MEM_SRC_ANONYMOUS_THP) {
> >               ret = madvise(region->host_mem, npages * vm->page_size,
> > -                          src_type == VM_MEM_SRC_ANONYMOUS ? MADV_NOHUGEPAGE : MADV_HUGEPAGE);
> > +                     MADV_HUGEPAGE);
> >               TEST_ASSERT(ret == 0, "madvise failed,\n"
> > -                         "  addr: %p\n"
> > -                         "  length: 0x%lx\n"
> > -                         "  src_type: %x",
> > -                         region->host_mem, npages * vm->page_size, src_type);
> > +                     "Does the kernel have CONFIG_TRANSPARENT_HUGEPAGE=y\n"
> > +                     "  addr: %p\n"
> > +                     "  length: 0x%lx\n"
> > +                     "  src_type: %x\n",
> > +                     region->host_mem, npages * vm->page_size,
> > +                     src_type);
> >       }
> >
> >       region->unused_phy_pages = sparsebit_alloc();
> > --
> > 2.18.1
> >
>
> Reviewed-by: Andrew Jones <drjones@redhat.com>



-- 
Junior Researcher, IoT and Cyber Security lab, SmartCI, Alexandria
University, & CIS @  VMI
