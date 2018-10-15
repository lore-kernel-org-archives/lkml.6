Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78F2C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8845E20652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOy0swf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8845E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeJOUSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:18:35 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40733 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeJOUSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:18:35 -0400
Received: by mail-it1-f196.google.com with SMTP id i191-v6so27383781iti.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 05:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4dgj23StcuwzC1A1qsnwn8fhe0rQJE0yVYC2T+UkJ2w=;
        b=AOy0swf3r2apx1xmdR3ch3bzqFr+gPkDSTdZLqtOlP9CFEsyKoqti//kJv02tQrxA9
         AK5vWyX2n/nMrnUtUPs8Z+BYjkNkK50W6yUXSw3F51M0VAvUjoygJQl0I4gEMfUl253q
         bzyhczwsdqIxyGzEngjbeLpEfpXyzN30hu0wEv2gh7IpV8F/dnyRpkqEP9YPao3H8ypO
         1u/fB2MijpIIeI4hk0cS5H6xHVdWrwC0YWu0mOeds0SwqC2XGcFFy+ZLRTQ71CCIXI8t
         HgHlULji6SPDcnmrO/5pjg08JhKIa1CZHWsAVY3YgUnVN6N/NV2LxjEabkrrjpGFh4tS
         d+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4dgj23StcuwzC1A1qsnwn8fhe0rQJE0yVYC2T+UkJ2w=;
        b=MXfZKkrvr9TQl/E0hRFnZuqH3jOqqDJ9Lcx4yf0SFPzA3v0D4kIuD0yyPLKKmyHus6
         FFuYFBUWX1HqUg240zBkclAIK+OCKhVre5kyHXYf7MpH6cjf21V2o/7wdERq7Zu6c8EX
         X1GEWqHqUHM6ExVghHMhtrKlq0EzJLZmJi7Ddf3rcks4DL4lYrtWqhL77JcnDzUYqOo7
         hvdJGfKus2Px9UxVPI7ARPC+ZY0LF1CN0vpONH19M2wJB2hvckK6Ewn57zy9UkGurpEp
         LJ1yAlVdQfcGxZ/cwIkv/NqOKIiyF6WMjRffW+mfpFMnqkXyjvZRMILu4ux9zcVU+TAd
         fgyg==
X-Gm-Message-State: ABuFfoiqL2HmXNE1T2gzUwwW5Y1POqKztHmhoTVCaH5MJ4IbDJ7L9QuF
        fM0kwKynvewh7VeRN1frN0VYmq+RaDsCReOrBeA=
X-Google-Smtp-Source: ACcGV62JVu0nwY6fN3LW6Psm0vzlSpwoMFjUSQMWd1G7tZwdnPWymNs5gL6ZtY9Osfq383xXFjQq1KxUbJYMUE35dEQ=
X-Received: by 2002:a05:660c:14e:: with SMTP id r14mr280507itk.136.1539606808030;
 Mon, 15 Oct 2018 05:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538535527.git.zongbox@gmail.com>
In-Reply-To: <cover.1538535527.git.zongbox@gmail.com>
From:   Zong Li <zongbox@gmail.com>
Date:   Mon, 15 Oct 2018 20:33:17 +0800
Message-ID: <CA+ZOyaig6dwzfhUn5CQ92P__yay2-aAgA4Nh+VxTs50FCbECwQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Fix some bugs on RV32 build fail and issue
To:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu
Cc:     hch@infradead.org, Zong Li <zong@andestech.com>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zong Li <zongbox@gmail.com> =E6=96=BC 2018=E5=B9=B410=E6=9C=883=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8811:12=E5=AF=AB=E9=81=93=EF=BC=9A
>
> This patches contain the modificaion as follows:
> 1. Fix up the building fail on RV32.
> 2. Add umoddi3 and udivmoddi4 functions for RV32.
> 3. Fix ioremap problem on RV32.
>
> Thanks all for review these code and modify the copyright description.
>
> Changes in v4:
>  - Retain the complete copyright description.
>  - Modify commit message.
>  - Rebase upstream code.
>
> Changes in v3:
>  - Change the copyright notices to GPLv2 from  gcc 4.2.1.
>
> Changes in v2:
>  - Retain the copyright notices from libgcc in umoddi3.c and udivmoddi4.c=
.
>
> Vincent Chen (1):
>   RISC-V: Avoid corrupting the upper 32-bit of phys_addr_t in ioremap
>
> Zong Li (4):
>   RISC-V: Build tishift only on 64-bit
>   RISC-V: Add preprocessor directive for swiotlb
>   lib: Add umoddi3 and udivmoddi4 of GCC library routines
>   RISC-V: Select GENERIC_LIB_UMODDI3 on RV32
>
>  arch/riscv/Kconfig        |   1 +
>  arch/riscv/kernel/setup.c |   3 +
>  arch/riscv/lib/Makefile   |   3 +-
>  arch/riscv/mm/ioremap.c   |   2 +-
>  lib/Kconfig               |   3 +
>  lib/Makefile              |   1 +
>  lib/udivmoddi4.c          | 326 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  lib/umoddi3.c             |  48 +++++++
>  8 files changed, 385 insertions(+), 2 deletions(-)
>  create mode 100644 lib/udivmoddi4.c
>  create mode 100644 lib/umoddi3.c
>
> --
> 2.7.4
>

ping
