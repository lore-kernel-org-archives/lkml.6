Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85271C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419BF2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="O6J0SXw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419BF2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732681AbeGLPOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:14:39 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:29693 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732362AbeGLPOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:14:38 -0400
Received: from mail-vk0-f49.google.com (mail-vk0-f49.google.com [209.85.213.49]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w6CF4Uju018528
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:04:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w6CF4Uju018528
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531407871;
        bh=yuWmCz8VcWHs5t25PI59Gv+FfjukZ7ujJ9tNJNhyfjg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=O6J0SXw6KvQWWyzJsTuZqHLSiekPFXSSBQ+hWdVny84Rq2+uG0J5gUBZwhjORM/vC
         E0S31Nqnri5zErN2uCKKPctMHIXaDaX20+SrpI9MUL8zldtEIgixyTSz8WBaiGQsCP
         Kf9RFUwFMPElV79OALgexwiDYsRMzoZersWsXiVmi5GVsWTUOwsF+fpfyInnCPLQQf
         qNTg4Zx47NVSF3hE12iui8FMFep0XihNEQf9D8feaUs+hxgH5xM+5F/OFaAAdfF115
         4unqnNMIr9vMDW77dOWLpB7xUGec7DhOJt6Vbxk5kceAmYSN9q0tkQnyF2iKwGgD1z
         U3HB+vPUAbFOA==
X-Nifty-SrcIP: [209.85.213.49]
Received: by mail-vk0-f49.google.com with SMTP id y9-v6so16519796vky.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 08:04:31 -0700 (PDT)
X-Gm-Message-State: AOUpUlGiyJynYb3B5V0LRVifzVS+SfA9p+AXQI4YqhGekXIkKc/JY+DQ
        wohn7uF0E4z5Y4xaJ9ptcmZ7KHrTPr4UeEJhqKw=
X-Google-Smtp-Source: AAOMgpfvv6mf+catS30IynfExoRSigWo1Obw0RWw2H4cZXUg2MyQWd/cJnoaNn+f8znS7gxCvmrVYd0+BR1LUvHm0QA=
X-Received: by 2002:a1f:a945:: with SMTP id s66-v6mr1543716vke.54.1531407870036;
 Thu, 12 Jul 2018 08:04:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 08:03:49
 -0700 (PDT)
In-Reply-To: <20180711183646.4022-1-const@MakeLinux.com>
References: <20180711183646.4022-1-const@MakeLinux.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 13 Jul 2018 00:03:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNASchVdP28f7hSQhdvyMpJJ_5dKK4EXTMScnuFP5RwOYig@mail.gmail.com>
Message-ID: <CAK7LNASchVdP28f7hSQhdvyMpJJ_5dKK4EXTMScnuFP5RwOYig@mail.gmail.com>
Subject: Re: [PATCH] scripts/tags.sh: add __ro_after_init
To:     Constantine Shulyupin <const@makelinux.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-12 3:36 GMT+09:00 Constantine Shulyupin <const@makelinux.com>:
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
> ---


Applied to linux-kbuild/fixes.  Thanks!


>  scripts/tags.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index 66f08bb1cce9..412a70cce558 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -245,7 +245,7 @@ exuberant()
>  {
>         setup_regex exuberant asm c
>         all_target_sources | xargs $1 -a                        \
> -       -I __initdata,__exitdata,__initconst,                   \
> +       -I __initdata,__exitdata,__initconst,__ro_after_init    \
>         -I __initdata_memblock                                  \
>         -I __refdata,__attribute,__maybe_unused,__always_unused \
>         -I __acquires,__releases,__deprecated                   \
> --
> 2.17.1
>



-- 
Best Regards
Masahiro Yamada
