Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586D8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238D5217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="lajsVGxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeLRIXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:23:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41645 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRIXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:23:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so14900546wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=juX3lDoH7A5it30MWKVRBo5WuBz2pCJl9gskcMHPCiM=;
        b=lajsVGxxldceawDDkpcCgG3vh5Kpr8QYrp1CSkqFZQcpoHILBy+P1RhIDX6CcUjQsV
         p1aixERN75JLkdnkCkAA3nfc6sDu6Ex8+cYaDZyQaOf4EZv6mG2ZbjVtoZ8LA9VTkPDu
         5qfUttVFtPRmsBVGMtEDn5c2OWWHACy1dOYCAjz5lMUVKHt9qlHzeSbaHTjx+qbBo7bo
         4HaR+hMJiiaJ6IS/qj8lzRTdtL4RupZphkP8EageH84Bwdey2/xXAdVOL4guo5EvqPoW
         mEI92DpcEEzx2QilSd9kPgv+PP41KkgTdzjnCnffHpMyXBJ3UOQ9DMN0JqVexiDxtl/0
         tmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=juX3lDoH7A5it30MWKVRBo5WuBz2pCJl9gskcMHPCiM=;
        b=cj4MyzLcMP13L4yU95OaTTPOmmoIAxfUiT0ZW2K6Q5/dlg21LmLdiHEKLjVdGGq8fX
         GNUssgu8kmeTykeT98bcedr8vVZAgB6/SZERDtvB5By3orQRnUQX9J1KRxh2eyvZ+Nt0
         B5rMNHa4Evp1F7YRk0YbDV8MvWrMz0W154knk4wsCde0k855bN+zNf0HhTOJb7x4iNi4
         /nH4QnqvkBTCJfRIw0GPpUcxvU5GHdEVm3EdRtOV9hbdxK7qW19oO48S2FfCf9Mvwpb5
         EZE4xOSi1J1lZjeE6Owp7CEBTYz4dKU9adO0c7+K8S6d9xXXZ8aJ1d4/QHNqI0ldRWIi
         l2dw==
X-Gm-Message-State: AA+aEWajsb4pyndl33vEE/f3d/+bLywslOJ+28PcIQT6d7HZSdUFxuaX
        YJAPp9FKqYV1a+EN3IotWyd4bVcEDyiWLMlhQmLNWA==
X-Google-Smtp-Source: AFSGD/VcLx0IctzwMG9izBUpbpgTd2+B4CtHMLVUf4ijkorEm0UGeQcLEyuVZ4XHzQ76K//umv4cbCQKTZgAgwmXxck=
X-Received: by 2002:adf:ee07:: with SMTP id y7mr14178135wrn.187.1545121415078;
 Tue, 18 Dec 2018 00:23:35 -0800 (PST)
MIME-Version: 1.0
References: <20181126060802.19314-1-anup@brainfault.org> <CAAhSdy1danjgviJ2WGGEANQXFkzZzXUdCj+04dZ4eLjcVOt14A@mail.gmail.com>
 <587bbe80f25203e6122dfcc0eadba50b@mailhost.ics.forth.gr>
In-Reply-To: <587bbe80f25203e6122dfcc0eadba50b@mailhost.ics.forth.gr>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 18 Dec 2018 13:53:23 +0530
Message-ID: <CAAhSdy2bxrP0VQui5AzEL5sueDACU9DkCN4h0--aC=8OpYKt8w@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Make BSS section as the last section in vmlinux.lds.S
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 6:29 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> =CE=A3=CF=84=CE=B9=CF=82 2018-12-17 11:36, Anup Patel =CE=AD=CE=B3=CF=81=
=CE=B1=CF=88=CE=B5:
> > On Mon, Nov 26, 2018 at 11:42 AM Anup Patel <anup@brainfault.org>
> > wrote:
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
> >> diff --git a/arch/riscv/kernel/vmlinux.lds.S
> >> b/arch/riscv/kernel/vmlinux.lds.S
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
> >>         _end =3D .;
> >>
> >>         STABS_DEBUG
> >> --
> >> 2.17.1
> >>
> >
> > Hi All,
> >
> > Any comment on this patch?
> >
> > Regards,
> > Anup
> >
>
> Just a note on coding style, you should be using a macro instead of 0x10
> so that those who read the code can understand what it is and also a few
> comments since searching through the commit logs to understand why you
> used it isn't optimal.

RISC-V can support 32bit, 64bit and 128bit machine-word sizes.

The 0x10 number is the machine-word size in bytes for 128bit
RISC-V CPU (i.e. maximum machine-word size).

I will add a macro MAX_BYTES_PER_LONG in vmlinux.lds.S and
use it in-place of 0x10

Regards,
Anup
