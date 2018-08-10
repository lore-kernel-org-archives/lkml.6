Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD4AC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 00:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29C7223AA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 00:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/p1kPHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29C7223AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbeHJDFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 23:05:12 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:38860 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeHJDFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 23:05:12 -0400
Received: by mail-io0-f194.google.com with SMTP id v26-v6so6317385iog.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 17:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=UjYM+J0EUkHYDuSg7Gelnkuk3nF0kEX8x4kLy1srcrI=;
        b=u/p1kPHsFve19eUrbpspxvngqcG1tIpnV2QBrTGaUTNmtfoNruBsyTcWGltl1nNqah
         eJHDT1EHfwI99dJNPrZySIjisDID7dek7tbPUzpcRKPw5aBHE3Ci2QuwmzbaMQDA2d9a
         c+kaDuxbQLgW9uku6Zi0hyRADMy35g1JsJYlutsiM+iqZi0e6k6VLK7ABTuYxAw4mD4y
         rSKbJGYC2avRuIzHH0Qjsdi314RStdupt1pFuuXrFB5DPgf07ve2PSU4SkLS2QvuJ/LO
         RwrBi+o+rs9tp1CA2ltKgtIwnlfHImQV+NIqR/utP4OBOyOssB+oEagsPqitjUnCo9D7
         4v0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=UjYM+J0EUkHYDuSg7Gelnkuk3nF0kEX8x4kLy1srcrI=;
        b=owEsJBEyUz2HdUBGuffumgTXKPHohWz431/da+T+bQG8W1tFhxkOUYJcNcOI8cYMjS
         hdubQJXKg4UN0Cjn+8hKFMa6lVQyJS/da5xTp1m857xMDTC3EIaLUrFBsUjdXGeHhnZ8
         nhbwEZ0wZwxG2LpYQW3crpviBwZUKVT5OoBCcEn3US26+H+SRFkcJhMrolV0/pKibW51
         zGOSnKwjiuFQgGxSRpS3AXaClnN2JRsjRyrw8gm3hgLIBtjILbIH57Mxmv/RuZLKESFK
         5lxhw9VOh7FyfP58KZylH5X+MrqLDAJj5RVbpE3yUW3HSH76KUaYUjA9LXnbidf9xk/W
         I4jg==
X-Gm-Message-State: AOUpUlEQPIy9tnB1UcCRzVHANrEmXxCkxliTr2Hj6GpCKQQjpEH6Qw4p
        x964Ik3gJDnCqInel5sHCtYO7pTJ0OpK2PManuI=
X-Google-Smtp-Source: AA+uWPya2Ph/fqH45Way1SLOTepjrUd5OSfpA7qup2JL9kF3ug0OiYr2lIt6J5JOm7LS6gZ57nHW4qWAkxeoA9ilLBs=
X-Received: by 2002:a6b:35f:: with SMTP id 92-v6mr3661216iod.63.1533861470400;
 Thu, 09 Aug 2018 17:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <1533223316-9942-1-git-send-email-zong@andestech.com> <3AB16BFE6992A349B44EA6D8F29BFB476B1EA2CC@ATCPCS16.andestech.com>
In-Reply-To: <3AB16BFE6992A349B44EA6D8F29BFB476B1EA2CC@ATCPCS16.andestech.com>
From:   Zong Li <zongbox@gmail.com>
Date:   Fri, 10 Aug 2018 08:37:39 +0800
Message-ID: <CA+ZOyajyOfjZh8tQB4reAka3s+tqXachY4hiAtpA4Bb67x58AQ@mail.gmail.com>
Subject: Re: FW: [PATCH v2] RISC-V: Add the directive for alignment of stvec's value
To:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        hch@infradead.org, linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zong Li <zong@andestech.com>, greentime@adnestech.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v2] RISC-V: Add the directive for alignment of stvec's value
>
> The stvec's value must be 4 byte alignment by specification definition.
> These directives avoid to stvec be set the non-alignment value.
>
> Signed-off-by: Zong Li <zong@andestech.com>
> ---
>  arch/riscv/kernel/head.S | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S index 3b6293f..11066d5 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -94,6 +94,7 @@ relocate:
>         or a0, a0, a1
>         sfence.vma
>         csrw sptbr, a0
> +.align 2
>  1:
>         /* Set trap vector to spin forever to help debug */
>         la a0, .Lsecondary_park
> @@ -143,6 +144,7 @@ relocate:
>         tail smp_callin
>  #endif
>
> +.align 2
>  .Lsecondary_park:
>         /* We lack SMP support or have too many harts, so park this hart */
>         wfi


ping
