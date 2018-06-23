Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CFEC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 08:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF84E24B69
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 08:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ETvkWYCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF84E24B69
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbeFWILB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 04:11:01 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:17376 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751620AbeFWIK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 04:10:58 -0400
Received: from mail-vk0-f52.google.com (mail-vk0-f52.google.com [209.85.213.52]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w5N8Aqgu030945;
        Sat, 23 Jun 2018 17:10:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w5N8Aqgu030945
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529741453;
        bh=gR3nsODF10sFtxfscMSL2LZ0t7rPWiQ8gcW5aKLbNv8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ETvkWYCU9y2ItkwmytOdOOmg2rhuM1RXcVjI/e+MyjrrwEwWbaNVqQURAkSi4UPd0
         W067eX/o9J4lnBFxVjVCpNkv/TF4roeZSzSuhkNxLaBWDNQW0GY0Kv5E1e/CEBj3tk
         Aln9kzrVCiMOLN54GcxjoYYggh6BFg4QKkN5DJo9cF4h1xq3FPz7/Ok4qpC/rpuP6p
         9A6EU6kTMcbVbsPXZoBTJ3P7wjhexcfMAg4axr7GSxlFVamxiC1CtLQmPHMIujY+XA
         9yo167Yl7E1xd67ApaFY+wNGanwM6QPygc4QvL1mFn9yuUi9XBVSjsIUV9CDnBEu3H
         tFb9GWYJ//1lA==
X-Nifty-SrcIP: [209.85.213.52]
Received: by mail-vk0-f52.google.com with SMTP id b134-v6so5194086vke.13;
        Sat, 23 Jun 2018 01:10:53 -0700 (PDT)
X-Gm-Message-State: APt69E3cbQLMeA4noc7x94td6ZvqGHz/ShTAEVHcz7cVn6w6GoUDRHAc
        UlIxITD/jK1sFlN5Y623ScZM0iJAak4+dfVh7Sg=
X-Google-Smtp-Source: ADUXVKL+ECx1XpCpokDU90ete4w+mzaFQ5reOuRs7kzl3Fv0AID43Ip6CdD0kgFf0FRs3nce8wiytq19yOokuKjo91g=
X-Received: by 2002:a1f:1941:: with SMTP id 62-v6mr2875505vkz.34.1529741451919;
 Sat, 23 Jun 2018 01:10:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Sat, 23 Jun 2018 01:10:11
 -0700 (PDT)
In-Reply-To: <874li0vvii.fsf@turtle.gmx.de>
References: <874li0vvii.fsf@turtle.gmx.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 23 Jun 2018 17:10:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNARPOqbmhKOOMCZjeLFihs-1Fh7388vLtHzH3X5zz=EKDw@mail.gmail.com>
Message-ID: <CAK7LNARPOqbmhKOOMCZjeLFihs-1Fh7388vLtHzH3X5zz=EKDw@mail.gmail.com>
Subject: Re: [PATCH] stack-protector: Fix test with 32-bit userland and CONFIG_64BIT=y
To:     Sven Joachim <svenjoac@gmx.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-19 2:45 GMT+09:00 Sven Joachim <svenjoac@gmx.de>:
> When building a 64-bit 4.18-rc1 kernel with a 32-bit userland, I
> noticed that stack protection was silently disabled.  Adding -m64 in
> gcc-x86_64-has-stack-protector.sh fixed that, similar to what has been
> noticed in commit 2a61f4747eea ("stack-protector: test compiler
> capability in Kconfig and drop AUTO mode") for
> gcc-x86_32-has-stack-protector.sh.
>
> Signed-off-by: Sven Joachim <svenjoac@gmx.de>
> ---

Applied to linux-kbuild/fixes.  Thanks!



>  scripts/gcc-x86_64-has-stack-protector.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/gcc-x86_64-has-stack-protector.sh b/scripts/gcc-x86_64-has-stack-protector.sh
> index 3755af0cd9f7..75e4e22b986a 100755
> --- a/scripts/gcc-x86_64-has-stack-protector.sh
> +++ b/scripts/gcc-x86_64-has-stack-protector.sh
> @@ -1,4 +1,4 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>
> -echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -O0 -mcmodel=kernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
> +echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m64 -O0 -mcmodel=kernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
> --
> 2.17.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
