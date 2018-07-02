Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0436AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BD423E3B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sv7kLQ0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BD423E3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754073AbeGBIJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:09:25 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:36695 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752795AbeGBIJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:09:21 -0400
Received: by mail-ua0-f196.google.com with SMTP id y8-v6so9528075uan.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DhD+3mCJ/XOt2jFEjX67GJRwOPFZz7Ycik60Xq0c0kk=;
        b=Sv7kLQ0pQxXLxsQ7cMzrI3J65fN9zQyDKRF1fpj5zm72qfhz0NuGoRS9HRmuFDXUrX
         Gu+LbF7A+sJpnX2uzNanf2x0iSkDIo/gqGAR4XcCfzA1kxRT897GyfgA1canD4SCpnkj
         R0JsE71ousFYZlLWQk6sy2ExLm5IZBaaXXoZisLB8y8qsw3tm1RNoCg3Sg57Oj9QY9Ji
         ViFJ+A4Xkk5UVxAswsD4vIOllmEe16af9x8isUh73G8gP0bOcCA32vpKwRD4zzrgaj46
         28kuJGC90Kkux7SM4UXPm0PXDhfbYYUCIOTUHgduBCD8IXf9cSiuL6bZo6qNtn7a5+K6
         F+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DhD+3mCJ/XOt2jFEjX67GJRwOPFZz7Ycik60Xq0c0kk=;
        b=LBHLJ60TymLfb6MivPAtqIcSmGS3xpHrXdGGU92lEE7iIbax7U5ot9Ck3T/vzFGp+D
         5XH7z9U3BTgeRn74szElvvQQHm5Vj4RPfp/id9yuyH1jc6hTd8yiHtMt4ZCzKC4b6UE0
         BDMWYdoeCskI6CXMVfCkpX/H7uwWvNtRdc6MInAfpCU5nNLvp1E5ahJEQbb2/gn7hKCR
         DI43wZZxsDfp0vRAgN35DpuzUZl8rNPUA89v1Q9L3YYv3r2PlIyjiFcr5cAOvdIX86uB
         bY/b1JVEQYeQwato4+BKI3kn/Idr0AwyjVWzUi1AsTdsL+viw7UQojmcpXC0GWyyafWP
         UBLQ==
X-Gm-Message-State: APt69E1gdQPY9EOKNws4D7aGeZv9Gw/JTxF/pWuTeoMi18ahSiKC8Z+8
        qUKNPeBYsvuvJPjMwZ0fO54el9eCDuPvT3F41To=
X-Google-Smtp-Source: AAOMgpdR/AVL/PVstDSIdN6jt966l9IyWgSQQozGsuc7hR0FE0fdYxqKjVXnlWFd6uMTMbvZfhMW6L6r/bW8y7yYtVM=
X-Received: by 2002:ab0:4fda:: with SMTP id t26-v6mr7057823uah.1.1530518960493;
 Mon, 02 Jul 2018 01:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180628104927.9130-1-greentime@andestech.com> <20180629084615.GA6236@guoren>
In-Reply-To: <20180629084615.GA6236@guoren>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Mon, 2 Jul 2018 16:08:44 +0800
Message-ID: <CAEbi=3dj4mXVSOBq4g_jaGp0oXTZ2Ai9CU=ZP+cbxpYQXepJiA@mail.gmail.com>
Subject: Re: [PATCH 1/2] nds32: To implement these icache invalidation APIs
 since nds32 cores don't snoop data cache. This issue is found by Guo Ren.
 Based on the Documentation/core-api/cachetlb.rst and it says:
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Greentime <greentime@andestech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guo Ren <ren_guo@c-sky.com> =E6=96=BC 2018=E5=B9=B46=E6=9C=8829=E6=97=A5 =
=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:46=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Jun 28, 2018 at 06:49:27PM +0800, Greentime Hu wrote:
> > +void flush_icache_page(struct vm_area_struct *vma, struct page *page)
> > +{
> > +     unsigned long flags;
> > +     local_irq_save(flags);
> > +     cpu_cache_wbinval_page((unsigned long)page_address(page),
> > +                            vma->vm_flags & VM_EXEC);
> > +     local_irq_restore(flags);
> > +}
> > +EXPORT_SYMBOL(flush_icache_page);
> > +
> I'm afraid that the page_address(page) will return NULL for non-mapped pa=
ge.
>
> So I use kmap_atomic/kunmap_atomic here.
>
> ref: https://github.com/c-sky/csky-linux/blob/master/arch/csky/abiv2/cach=
eflush.c
>
> > +void flush_icache_user_range(struct vm_area_struct *vma, struct page *=
page,
> > +                          unsigned long addr, int len)
> > +{
> > +     unsigned long _addr =3D (unsigned long) page_address(page) + (add=
r & ~PAGE_MASK);
> > +     flush_icache_range(_addr, _addr + len);
> > +}
>
> The same as above.

Thank you, Ren.
I will prepare the next version patch  to use
kmap_atomic/kunmap_atomic to fix this issue.
