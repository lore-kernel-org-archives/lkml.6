Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1E8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB5D20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCBtiLz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB5D20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeK2SlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 13:41:19 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42221 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeK2SlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 13:41:19 -0500
Received: by mail-ed1-f67.google.com with SMTP id j6so1031008edp.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 23:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+YoVQTqH3vy5mPd37GsUvR97cQgim6z/Pdh8hSKwkaw=;
        b=HCBtiLz7Z8e2fAHeBaeyI6yMUWugVwbf3Vzx7hDnSoALdYCEkW9rLI/gi9RxJ3VwdE
         /yKevyOCIlw/NxgwyPGKHvNdd1ielrwejYJxoAILXV8axKeJVoBtHm/CmYnOT/SVB/rd
         3tLq99Bt4Pb721AKciyi8DzhEXCk2IGyG0PT+ABj0wblejrKEclOzRh9q3XIhK1v8pkc
         knv8V6fe2t/PYZknH3kvzKMNG+43Gzmct+dryTMZyM7YCdlMWpsgd5puW+fdbQUWDzZ5
         CEigu7F4IIC7CPrdoGNrx4g/OywAj51TMe9ALCXXVgymRRnqopJf2SthVV7+bbFeD5DJ
         jeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+YoVQTqH3vy5mPd37GsUvR97cQgim6z/Pdh8hSKwkaw=;
        b=GpVKadVmDdBLbE2sFnuSWeMNrwsv4QjxxGq5o5bCmLzgFmY3XvTs6FGfuWWIh5iaGL
         l56/y7xmWm1i+HxZAm9VlkFYY0XZNvSOGHZJb0+/a6ez4AviiRrFf2cm1mHeq3ue80Jp
         4W27el3JPxTVKCBUiw+XfYRcG08HlkosrqRfJGlnk37VOmWS4k0vQyWV20J/ZBMGhtng
         VhthogZqfsgTx+XkSyWcQsC6YOHPmnUiOhVtns/0MAYLWrzzPZtsG3FtvEGLzkMOyN0l
         5kB/zR3XfxF0atT6Uh6A0gqOuZnfFw+27YQcUMQ4Rn5e9/I6e15EpnhlfPY8eSsrxBkC
         nzdQ==
X-Gm-Message-State: AA+aEWZ2JPcnnFQuzWDNg+xEnldhP7OW/9fFwZFEEr3yyl67yam27SBk
        9VYlCMv/rHgPt4tJXtssxncJxZs5MhIeskMSrq8=
X-Google-Smtp-Source: AFSGD/XaC2/HYejm4OWtUq1E5HNkUx2dKSETgXLDJkJK44hDJjfusvM7w891+z1Fr4f6fEWAebd5X+xjMX6rbk4jGD4=
X-Received: by 2002:a17:906:7c52:: with SMTP id g18-v6mr696479ejp.77.1543477012342;
 Wed, 28 Nov 2018 23:36:52 -0800 (PST)
MIME-Version: 1.0
References: <20181126060802.19314-1-anup@brainfault.org>
In-Reply-To: <20181126060802.19314-1-anup@brainfault.org>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 29 Nov 2018 15:36:41 +0800
Message-ID: <CAEUhbmXMZj68FyANeqP4jo2Pvk4ihEqPG2+g1gQAFMSqppNq-Q@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Make BSS section as the last section in vmlinux.lds.S
To:     Anup Patel <anup@brainfault.org>
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, hch@infradead.org,
        atish.patra@wdc.com, linux-riscv@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 2:12 PM Anup Patel <anup@brainfault.org> wrote:
>
> The objcopy only emits loadable sections when creating flat kernel
> Image. To have minimal possible size of flat kernel Image, we should
> have all non-loadable sections after loadable sections.
>
> Currently, execption table section (loadable section) is after BSS
> section (non-loadable section) in the RISC-V vmlinux.lds.S. This
> is not optimal for having minimal flat kernel Image size hence this
> patch makes BSS section as the last section in RISC-V vmlinux.lds.S.
>
> In addition, we make BSS section aligned to 16byte instead of PAGE
> aligned which further reduces flat kernel Image size by few KBs.
>
> The flat kernel Image size of Linux-4.20-rc4 using GCC 8.2.0 is
> 8819980 bytes with current RISC-V vmlinux.lds.S and it reduces to
> 7991740 bytes with this patch applied using GCC 8.2.0. In summary,
> this patch reduces Linux-4.20-rc4 flat kernel Image size by 809 KB.
>
> Signed-off-by: Anup Patel <anup@brainfault.org>
> ---
>  arch/riscv/kernel/vmlinux.lds.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
