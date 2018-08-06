Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,UNWANTED_LANGUAGE_BODY,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AD7C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BEB8219EB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sbVBZ+7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BEB8219EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeHFLMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:12:48 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33225 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeHFLMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:12:48 -0400
Received: by mail-pl0-f66.google.com with SMTP id b90-v6so4609233plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 02:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=czzFOhmoJku+61MtblKxOikgqQsnpvKD1bRrcCJLO8o=;
        b=sbVBZ+7EkXnABJNTneoqOIq1RDH34ncjRe0yRV4zDMp8Hir3a1qFC7jXyzJfQRxWbe
         3Wp6sl+i+shF46ewqVbknO+cP3kQrIpKlzDH2+pIpiMbmWr/5TLP5iIFs3zxg4il8Etr
         507w12TdjD7qOLJjtM2gPhR74fCG0tDJmTxjTuzNVx7wb5TVyidkNxPX/RQnufEnNevE
         X2jUIRXVdpOhiQ0lWCxlPCF1kfzb+0ywRaXoCcnwq6YW4lnF887SmtIcjeJ4EhhmotKS
         QGhUYixgmGnvuoK386AMWlBHTqkx4xekKHrUiU41Kp5iWKTKQS+U79RNxpPjlSs69eaS
         1+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=czzFOhmoJku+61MtblKxOikgqQsnpvKD1bRrcCJLO8o=;
        b=jIA4BaJ7ze3hjzJdK4M2Srx/+FT9rN5LplQrLfUIgbgEROUvRiwFUJFDVObbYHLNfB
         4WOio83Gp/hS6hQOriKMNZj8uqQI+4HZtGmzkUX0sb/7qJGFWkT4JngE92VPJrkBvBXY
         VOWRGk2blx3W2MCwNdWGLF75i8Bki7nSPc1nQD9q3Ui/C3T6PWbxY3z4PvchIi80mbXA
         9x29E1jGKiRx8u7FNl0u8/jv/M7jAbjJ1T8x2f62ERoy7oDI7oCx5raHGPPET+rKCa8i
         /79pgQaa0JGi3NHS5rYM8V1o/lrs+QIHHlopm0pgXlpzqq47dLaIvGpYsWcAJuY+DdAN
         uBXw==
X-Gm-Message-State: AOUpUlGPJQKIMGK7qQsj05BWcuhm4eMWFa0L7oeKlMalvoTGeL5xNd79
        WoptSgyfSoGpqAGzzhnsenAiqlFQuGjw4LhQD2c1Hw==
X-Google-Smtp-Source: AAOMgpeMapuig0JxIrSSf2VhjpmH7NNQimgCEFbhe5R9TfAS+u4fTiHVSr+LqJUz1rcPjptOlpva3vPeIP20ryne+3c=
X-Received: by 2002:a17:902:bcc6:: with SMTP id o6-v6mr13072187pls.117.1533546283106;
 Mon, 06 Aug 2018 02:04:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 6 Aug 2018 02:04:22
 -0700 (PDT)
In-Reply-To: <20180804220827.GA12559@embeddedor.com>
References: <20180804220827.GA12559@embeddedor.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 6 Aug 2018 11:04:22 +0200
Message-ID: <CACT4Y+arVJ4qt54LzKKoyh9+NKA+fjyCShKi82NanbovhK_mmQ@mail.gmail.com>
Subject: Re: [PATCH] mm/kasan/kasan_init: use true and false for boolean values
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 5, 2018 at 12:08 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Return statements in functions returning bool should use true or false
> instead of an integer value.
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Hi Gustavo,

I don't see this code in upstream tree. Is it against some other tree? Which?

Thanks

> ---
>  mm/kasan/kasan_init.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/kasan/kasan_init.c b/mm/kasan/kasan_init.c
> index 7a2a2f1..c742dc5 100644
> --- a/mm/kasan/kasan_init.c
> +++ b/mm/kasan/kasan_init.c
> @@ -42,7 +42,7 @@ static inline bool kasan_p4d_table(pgd_t pgd)
>  #else
>  static inline bool kasan_p4d_table(pgd_t pgd)
>  {
> -       return 0;
> +       return false;
>  }
>  #endif
>  #if CONFIG_PGTABLE_LEVELS > 3
> @@ -54,7 +54,7 @@ static inline bool kasan_pud_table(p4d_t p4d)
>  #else
>  static inline bool kasan_pud_table(p4d_t p4d)
>  {
> -       return 0;
> +       return false;
>  }
>  #endif
>  #if CONFIG_PGTABLE_LEVELS > 2
> @@ -66,7 +66,7 @@ static inline bool kasan_pmd_table(pud_t pud)
>  #else
>  static inline bool kasan_pmd_table(pud_t pud)
>  {
> -       return 0;
> +       return false;
>  }
>  #endif
>  pte_t kasan_zero_pte[PTRS_PER_PTE] __page_aligned_bss;
> --
> 2.7.4
