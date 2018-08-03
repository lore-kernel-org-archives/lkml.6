Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE30C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A79215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBsNOdV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A79215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbeHCCVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 22:21:45 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:56050 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbeHCCVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 22:21:45 -0400
Received: by mail-it0-f66.google.com with SMTP id d10-v6so6167615itj.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 17:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fi3dVBaghTivq3SLwzEEOAsKb+FgXMFgJLCkGux5dO0=;
        b=KBsNOdV+lh92Kwg2kxrkOcmN/xf2aATacppNQzZWlvXI1PscyYo8OKDVBvq0t488/v
         1ielRDBoidKcF8SVlkX7thcjStFYyixGk9G68w6LxyuIErRbXcbQV4Z7Ml989w1700os
         D9E3fU8UwGMHRA5nIW2pjMj1u+g9vnBnOjbD9TxwyFWfA1zQ0eNfj4e5LFwkKARUvn+p
         s8ygEUrGsWOqV80ldDeAnyeGtm2nS35fHQBj7QcxTmjiZYYkFBrjh1nC9QvKHd6w6lHq
         /W86bLheyJQQNRqqva57XdBSa+VTkgONhqCoSbOv8P1VA+YRjL23z2nwzK/axYiEW//o
         29Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fi3dVBaghTivq3SLwzEEOAsKb+FgXMFgJLCkGux5dO0=;
        b=ZY0uAeL/oL0a/ZfW8VmycDGNCWNq0uvHKV3tvICj3xVo8Op/0OWCMHVeY6FjbqwMnJ
         tc/d0OzWQXskWrm1YQrcwaYsAzGDIHvJ8vNZw47UhRKVinJqiiAy8Htw1xNpaKW0u5UI
         QC3/SIuTQBEsLNIkqp1ysekGlvxd4bksLDWAvnXxFbSj1JUxX7dXXGGIWQ4KmpI/lM2/
         hvgFr1YSNEy7gsWGNp8NAMZ5lzd4YHb11z9XeBoSz3HCD0YffsSB8YBOHtAskcOFQk98
         084FGDk7MbFPSidQflpTFac4C1Z4XVHV6SmsIYB4rYWqY6nkJneAOpjQ9RahNArJr5uo
         onBw==
X-Gm-Message-State: AOUpUlELBFWDpUoH8BXfLTLiLXsza+SXC64+6ul5yYl5Z1yfFL+IK5dc
        m4J7euzYe+ZSHHqygXdphL/oH4p8wjnLxbr5bxI=
X-Google-Smtp-Source: AAOMgpfJMDcdPsKCpLdoxyWzAaeMj2s0sWvZh9vAWJhySPn8rt1srtxB5h72y3ovH6fphPs6iY+QYZ2GOlrSoD2OnbY=
X-Received: by 2002:a24:4ecb:: with SMTP id r194-v6mr4690235ita.39.1533256088032;
 Thu, 02 Aug 2018 17:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <1533223376-10130-1-git-send-email-zong@andestech.com> <27367ec8-fc26-c678-1883-299a084a5328@wdc.com>
In-Reply-To: <27367ec8-fc26-c678-1883-299a084a5328@wdc.com>
From:   Zong Li <zongbox@gmail.com>
Date:   Fri, 3 Aug 2018 08:27:57 +0800
Message-ID: <CA+ZOyaiyaVqgba-pLABJgZHVTep8LXiiLQnT+dtCppdvJy36Zw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Add preprocessor directives for boot_sec_cpu
To:     atish.patra@wdc.com
Cc:     Zong Li <zong@andestech.com>, Palmer Dabbelt <palmer@sifive.com>,
        aou@eecs.berkeley.edu, hch@infradead.org,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        greentime@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atish Patra <atish.patra@wdc.com> =E6=96=BC 2018=E5=B9=B48=E6=9C=883=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=882:14=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 8/2/18 8:23 AM, Zong Li wrote:
> > The boot_sec_cpu is for hutplug CPU on SMP system. It should
> > be conditional compiling. Otherwise, it causes undefined reference
> > to `smp_callin' when compiling uniprocessor kernel.
> >
> > Signed-off-by: Zong Li <zong@andestech.com>
> > ---
> >   arch/riscv/kernel/head.S | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index 11066d5..9b6f601 100644
> > --- a/arch/riscv/kernel/head.S
> > +++ b/arch/riscv/kernel/head.S
> > @@ -154,6 +154,7 @@ END(_start)
> >   .section .text
> >   .global boot_sec_cpu
> >
> > +#ifdef CONFIG_HOTPLUG_CPU
> >   boot_sec_cpu:
> >       /* clear all pending flags */
> >       csrw sip, zero
> > @@ -162,6 +163,7 @@ boot_sec_cpu:
> >       fence
> >
> >       tail smp_callin
> > +#endif
> >
> >   __PAGE_ALIGNED_BSS
> >       /* Empty zero page */
> >
>
> Thanks for the fix. If you don't mind, I would like to merge it on top
> of my cpu hotplug patch and resubmit together to avoid confusion.
>
OK, just take it:)
