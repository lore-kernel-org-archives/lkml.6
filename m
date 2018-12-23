Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B9CC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 14:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38E521849
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 14:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="UZQd+vr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbeLWO6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 09:58:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44773 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbeLWO6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 09:58:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so9609349wrt.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 06:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y6scqON9KStlQnmh87N7ktbYjs+ArQwzAXpCvM+jErY=;
        b=UZQd+vr+FHB8k2FxAxU+hW45BJ+WlM/q4C4cjfMELqPM2rk6Jfj9TEeJpc7NoT/bIC
         5eX0e2/9SxxgujScDFExdJvouaZY7RBwLf+IZvWSaSyaIo/8lXtbdtc4sRCvsdXyXH11
         xLisGm/7BQ9gS97ezApPwEuDAkOjqTkL3JrURFn64l32Brs4KUPai90TCTjC81R6XGVZ
         P4R0QgtY6vL1TOPXsJbYnjZddKf8hACmAwuVUl58QMrfgM0EtkwQfOSHd7s22EvEoUqq
         WMYnLQju0JGfYpIsuLaTE6UlWE7VO+2LlvDDTXlp84ZgonWGsDl7JDBkq/phndsl8vSk
         YM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6scqON9KStlQnmh87N7ktbYjs+ArQwzAXpCvM+jErY=;
        b=Iv5fo83HlJTUT5niiErwqxe9cpRXDe4gt7c5GagiWrX1hrVMC729pRzol2wM8xU+N9
         fUwssDzrueKEJK10iEXrnb57HM5Js+LKaukDVNkD6lFbaBHYkExqOUjZdOiQn2NYz3pD
         KtaQaZOQQyi/hWXIHzSRW9oZP83P0xaAv+f49Yny9ykgfsOlPLCtY7uEnW0Rzti1DYvN
         bvrbEqDyYM37IXMQlh6y8Ba7/6ZKXs69IpcXZwl3/xPqSoS3HrR5C/Y0uQ5dcOoZVaWx
         hFqmGysi7Y9l8MS5S5aijCR+2yusSYmnJPRyDAjCa3SkkmO/dOgMlW3d64qcvEzbXhqc
         4TcQ==
X-Gm-Message-State: AJcUukfVEGTaHJuX7+uYHFsAcGkO51qpRa3j7OAqPLFJgkpP+I6fs22J
        xYkU0PsVEFq38d1iIiYKTQl3+X2uQHUE/StZIK8dWQ==
X-Google-Smtp-Source: ALg8bN6xQVUIj8PyiGEJkSO1dIigINps6TDf+6GgyzqlJnrxCJPk/8wr4HsiwAwfZZW4G+gjjvU08REazOotgyIEr0A=
X-Received: by 2002:adf:f785:: with SMTP id q5mr9494358wrp.9.1545577112835;
 Sun, 23 Dec 2018 06:58:32 -0800 (PST)
MIME-Version: 1.0
References: <CAAhSdy1danjgviJ2WGGEANQXFkzZzXUdCj+04dZ4eLjcVOt14A@mail.gmail.com>
 <mhng-d6686972-69e1-4355-8b30-e03893e24db6@palmer-si-x1c4>
In-Reply-To: <mhng-d6686972-69e1-4355-8b30-e03893e24db6@palmer-si-x1c4>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 23 Dec 2018 20:28:21 +0530
Message-ID: <CAAhSdy16jCvYZzSmec7FyWLB6y6djqj=KBKtj=17p_dNkaxjsg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Make BSS section as the last section in vmlinux.lds.S
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 2:10 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Mon, 17 Dec 2018 01:36:45 PST (-0800), anup@brainfault.org wrote:
> > On Mon, Nov 26, 2018 at 11:42 AM Anup Patel <anup@brainfault.org> wrote:
> >>
> >> The objcopy only emits loadable sections when creating flat kernel
> >> Image. To have minimal possible size of flat kernel Image, we should
> >> have all non-loadable sections after loadable sections.
> >>
> >> Currently, execption table section (loadable section) is after BSS
> >> section (non-loadable section) in the RISC-V vmlinux.lds.S. This
> >> is not optimal for having minimal flat kernel Image size hence this
> >> patch makes BSS section as the last section in RISC-V vmlinux.lds.S.
> >>
> >> In addition, we make BSS section aligned to 16byte instead of PAGE
> >> aligned which further reduces flat kernel Image size by few KBs.
> >>
> >> The flat kernel Image size of Linux-4.20-rc4 using GCC 8.2.0 is
> >> 8819980 bytes with current RISC-V vmlinux.lds.S and it reduces to
> >> 7991740 bytes with this patch applied using GCC 8.2.0. In summary,
> >> this patch reduces Linux-4.20-rc4 flat kernel Image size by 809 KB.
> >>
> >> Signed-off-by: Anup Patel <anup@brainfault.org>
> >> ---
> >>  arch/riscv/kernel/vmlinux.lds.S | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> >> index 65df1dfdc303..cc99eed44931 100644
> >> --- a/arch/riscv/kernel/vmlinux.lds.S
> >> +++ b/arch/riscv/kernel/vmlinux.lds.S
> >> @@ -74,8 +74,6 @@ SECTIONS
> >>                 *(.sbss*)
> >>         }
> >>
> >> -       BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
> >> -
> >>         EXCEPTION_TABLE(0x10)
> >>         NOTES
> >>
> >> @@ -83,6 +81,8 @@ SECTIONS
> >>                 *(.rel.dyn*)
> >>         }
> >>
> >> +       BSS_SECTION(0x10, 0x10, 0x10)
> >> +
> >>         _end = .;
> >>
> >>         STABS_DEBUG
> >> --
> >> 2.17.1
> >>
> >
> > Hi All,
> >
> > Any comment on this patch?
>
> Sorry, I haven't had a chance to look at it yet.  Aside from the macro issue
> mentioned by Nick it seems OK.

I have send v2 to address Nick's comment.

Regards,
Anup
