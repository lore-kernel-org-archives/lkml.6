Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372B1C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74892083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkUNC6M8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74892083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbeGZKEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:04:49 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:41995 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbeGZKEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:04:49 -0400
Received: by mail-ua0-f193.google.com with SMTP id w7-v6so579404uan.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 01:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AtUdswberurTTOXCfPPgHavSTf5uHPImUrFx4dyDFhA=;
        b=qkUNC6M8FNtu/jM1ypsPP/KfA/XqUGMi5Q5azWfHmZgQ/cLUGJcWcE112nF05OV1Pz
         kG6DfjjiF13HBCQLTbwJ6aFHQCBudfPPZGejtxcL75sEIbGRcOcVVRYWygQdiUjsVFNa
         9WiJ3QCU2kjsJRXSiOz4iv9Ok3bLkPzmH89EE5/p/u6YiUU4b0Bf8IuxRa4YDBJrlDhW
         kHXJrmsUx3zYzrp/rnFToY+eaUZd/zVswWw/weeel0evimbtCFnqydUa5P5z6JxoBShZ
         Ay8f7e8W0lzjyv+rXhnMQKg43DDJA0b/i+4aY+dBh3lfiGCMTLgWZelgjKmoEjrHXXEU
         H/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AtUdswberurTTOXCfPPgHavSTf5uHPImUrFx4dyDFhA=;
        b=TH4xi8l65xwEqen00wB5wteNk3ORbjNibJ+yzVbj+6Fvh8V3sBYtXK/6Z+kmRo3G9u
         gn6BtYWUCeyCOxtJ1V0ktuxxeRk/IoUunspdJuhV3hMWS+wGft3cpy2EYujvi4QwNWSb
         g1123E+XKHu94L6EwYY3QKb4t6wuanRgh3OZEcg6NdnTXKq93fxXuvXIpwBYkZ97zPJK
         SZyg7Q0ko47toptosAZRIOcj7+YTkNk3CTjp1op4NpljG71AcYQKS8gtiQwAS05VisY0
         yVN3VRSLN1Smr/JcV7jokx1Q1C/dJ/vlRBxAcokEJ7skPqYYC+buMwGAq2xEEvb5lYjd
         18vg==
X-Gm-Message-State: AOUpUlHZiTSMBgLPuWieh37ZFt6s1+jMbJ4mL2s0NCzjh5tY2964n5Wq
        mJEdk9+mkJm3NrM5wpMVjBFt4pwTDXsa3uajK4I4W6K3
X-Google-Smtp-Source: AAOMgpc4YZ4klPhevdyVivuTFfVQLB77uiEp23Meq/1Z0DMd1GaETT7LKAVPscMyPmvJphcal6sBtkQhOadC4jccBss=
X-Received: by 2002:ab0:6037:: with SMTP id n23-v6mr705343ual.28.1532594939549;
 Thu, 26 Jul 2018 01:48:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 01:48:59
 -0700 (PDT)
In-Reply-To: <1532592471-21177-1-git-send-email-wei.w.wang@intel.com>
References: <1532592471-21177-1-git-send-email-wei.w.wang@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 26 Jul 2018 11:48:59 +0300
Message-ID: <CAHp75VcFZ7jS-M6+O95XTfyg1m05UOQMVgdQb5wC-0bNWkyvMg@mail.gmail.com>
Subject: Re: [PATCH] linux/bitmap.h: fix BITMAP_LAST_WORD_MASK
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        dgilbert@redhat.com, Matthew Wilcox <mawilcox@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 11:07 AM, Wei Wang <wei.w.wang@intel.com> wrote:
> The existing BITMAP_LAST_WORD_MASK macro returns 0xffffffff if nbits is
> 0. This patch changes the macro to return 0 when there is no bit needs to
> be masked.
>

Can you provide a practical example of what's going wrong before this
patch applied?

> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  include/linux/bitmap.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 1ee46f4..12af3d7 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -194,7 +194,10 @@ extern int bitmap_print_to_pagebuf(bool list, char *buf,
>                                    const unsigned long *maskp, int nmaskbits);
>
>  #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
> -#define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
> +#define BITMAP_LAST_WORD_MASK(nbits)                           \
> +(                                                              \
> +       nbits ? (~0UL >> (-(nbits) & (BITS_PER_LONG - 1))) : 0  \
> +)
>
>  #define small_const_nbits(nbits) \
>         (__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
