Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F546ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3DA21470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fqs4ULFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3DA21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeJSRaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:30:17 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37758 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbeJSRaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:30:17 -0400
Received: by mail-ua1-f68.google.com with SMTP id y5so7211169uap.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XV/8h4oJb4na0TjN+MF3xnsz/WDQ3kuOBaNNCYhBaJM=;
        b=Fqs4ULFFoudQ1BpMtduiZ/n4YsUONCckwIisj4gX6/jcQmuefLlUWEdzuPxAxYFT3i
         3RBU0NizOOA7GdBIKzcXEC7CdV+h3ZsKqMVTFKy4kFxxRraeyqFE7VxJGEEUKrQaLgkS
         ahKS48CbE2dR0sz+rGDAe7pjGuIPq7NJ+vIKsevI4+iOPl2U/O9ileIe9Zz157cxoK1T
         fcSc9gU8yfGl9cLF1uyTRsrabTLgpSRDSf7LgdKR8fg3bnYPx+fALLmZqGlhzVlDDPDq
         jssBI5HOrzKGCEm0wZuIFBJ4K9kHikV1M0NRUTidoWJVOnFi6T6R8k0fE5pP+yvUlCej
         PRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XV/8h4oJb4na0TjN+MF3xnsz/WDQ3kuOBaNNCYhBaJM=;
        b=Qec4sZ/fa6ewiNKh6kaUF3VqCqtlC5C/pamlnqR5cu16BGe3JQlccereKsDX9unt6D
         kk75LjLkU/ccSItn4QBeyY8dUge9vDwZ6VQKZkL0+wFHFQIBpZJrWYqknxcwsg+JyB0g
         9xSJ97pOZZuN7hSyHvQLzaFdGbtQirRuKM6SWBYP8ZcikCCp6FEZjeK9ooDF55QrD5ZU
         iqFW3+RFhvmrDLOZ+234lVreGD9Ldyey/+A9jSV9YqvC3bKEF9f2oR0I9JUB6wdwu8BV
         aJ+2mRhqP+P+vZixcZMjoI8d6O0WGhXtu8NTVkWHcPn9xORTq77ZNdazTNbw7MGI7ZgL
         JSjw==
X-Gm-Message-State: ABuFfojJylzV51wAljkvnZ6iwvALlKr6eDI4v7QxGOKN0yn1fK90EdKv
        1onmUnp7++wd/aKEwAj/MRHqJ7gnJKVdO6ejMMc=
X-Google-Smtp-Source: ACcGV61QEFWq5BgbOn+rnOUKCV2AP/Pgb6HdQ5ugjz5uMVbGyjtArEp0DZCT4nJhptiaJiTFYm45Dpen04szy7zL7W8=
X-Received: by 2002:ab0:711a:: with SMTP id x26mr15356457uan.45.1539941101184;
 Fri, 19 Oct 2018 02:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539654583.git.nickhu@andestech.com> <6f54200ae5c132634ede74df536a547e134554c2.1539654583.git.nickhu@andestech.com>
In-Reply-To: <6f54200ae5c132634ede74df536a547e134554c2.1539654583.git.nickhu@andestech.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Fri, 19 Oct 2018 17:24:24 +0800
Message-ID: <CAEbi=3fPg0pCFuRiizmU68r8_N4jC8ANVThf0kQXunkp+rOuNw@mail.gmail.com>
Subject: Re: [PATCH 1/1] nds32: Fix gcc 8.0 compiler option incompatible.
To:     Nickhu <nickhu@andestech.com>
Cc:     Greentime <greentime@andestech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Zong Li <zong@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nickhu <nickhu@andestech.com> =E6=96=BC 2018=E5=B9=B410=E6=9C=8818=E6=97=A5=
 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:38=E5=AF=AB=E9=81=93=EF=BC=9A
>
>         When the kernel configs of ftrace and frame pointer options are
> choosed, the compiler option of kernel will incompatible.
>         Error message:
>                 nds32le-linux-gcc: error: -pg and -fomit-frame-pointer ar=
e incompatible
>
> Signed-off-by: Nickhu <nickhu@andestech.com>
> Signed-off-by: Zong Li <zong@andestech.com>
> ---
>  arch/nds32/mm/Makefile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/nds32/mm/Makefile b/arch/nds32/mm/Makefile
> index 6b6855852223..7c5c15ad854a 100644
> --- a/arch/nds32/mm/Makefile
> +++ b/arch/nds32/mm/Makefile
> @@ -4,4 +4,8 @@ obj-y                           :=3D extable.o tlb.o \
>
>  obj-$(CONFIG_ALIGNMENT_TRAP)   +=3D alignment.o
>  obj-$(CONFIG_HIGHMEM)           +=3D highmem.o
> -CFLAGS_proc-n13.o              +=3D -fomit-frame-pointer
> +
> +ifdef CONFIG_FUNCTION_TRACER
> +CFLAGS_REMOVE_proc.o     =3D $(CC_FLAGS_FTRACE)
> +endif
> +CFLAGS_proc.o              +=3D -fomit-frame-pointer
Hi Nick,

Thanks.
Acked-by: Greentime Hu <greentime@andestech.com>
