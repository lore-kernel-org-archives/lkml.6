Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6C3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F92E20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NVyCm6OF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfANVMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:12:05 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42305 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfANVMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:12:05 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so190596plp.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 13:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJpB+Q6ySg9/qHqPWr9mmqL7i7+Ucdth2nuHzirNUgg=;
        b=NVyCm6OF4WPvnjGXTPqTJJbuBfShU3XoNMyHWGqvEdlKzMsROdN4ALsW2wmbYQXEPC
         m4kTIKR6awWj02OwQ4cq2EzEjBW3VQmwWlAagVqvvkzcVes3TdOhlHfiTGkfFXpEISz8
         DfCbSJ2ur26AkCqnjqWkKdVqwXbgwkBzSYjarl2C4gqJ2wVFc/m+ec4irRLcAYjL0ueN
         +4YKZK2tyNTRDvZrjf/RGePsvj9LuOS2Za546GosH1ujprnVxTZYjbW6PmgiEDto0OVc
         bVtOlV3K19SYKnWl4eHF9zaPrkz+HszlBCsUiCHi+5KdS0LSjTxyAS+w2hyEUOqNqfHC
         76ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJpB+Q6ySg9/qHqPWr9mmqL7i7+Ucdth2nuHzirNUgg=;
        b=YXMUtK2/oPjtC1yDwOEbearKFqW4hYL3GZuz3zoQQcrIyHYr79YwSxfEluqeKzQ96U
         KguxxlxA3ysKdXWtBN1XqzbgGzjhZNKTt/y+2c8HU3hkwxpfJ7lVTt73UKwDnaeIA5MF
         7M31lrzGAQPCqFJbgu83btmgZ+eXgC05Jpu2xpaeXQ5syddnLnzH62onTK8LHm3k6AbH
         NroOAMcSjZLgFx72jjBzUtgcO5eO9NWWjomZTyX2w+nnGEamWCtmij7w7ZvM1D9hbZXT
         QxHmn9xa/vfwss78gtSQqLjd0Z0lzpDBWCBK9dgjDkL2PQhjxwHo9GD1HbbAA51/waOO
         3CbA==
X-Gm-Message-State: AJcUukfoVp4kL8Inf0omCdrzIxxc1sTKjt7R7S1/yApY0FuL0RX1gDl2
        xl3m2ZPiXbzSfxTtBid/ZGRjTHn7U2sxY8DMD8uldwJlUg4=
X-Google-Smtp-Source: ALg8bN5ZK1YlC/QKMhbb05NveWaK2Hf/j/jJKwW2kNW5T3QXRHNFobjIOQSfWIsYcDyme/D7OxJCIlAWkYmkYyEf4Fc=
X-Received: by 2002:a17:902:4464:: with SMTP id k91mr485840pld.13.1547500324073;
 Mon, 14 Jan 2019 13:12:04 -0800 (PST)
MIME-Version: 1.0
References: <20190114210426.177543-1-trong@android.com> <20190114210426.177543-5-trong@android.com>
In-Reply-To: <20190114210426.177543-5-trong@android.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 14 Jan 2019 13:11:52 -0800
Message-ID: <CAKwvOd=RD0UgRo4WXKzBQ84q1P3Xmreb58_dfxLLYBoqHSStLA@mail.gmail.com>
Subject: Re: [PATCH 4/4] gcov: clang: pick GCC vs Clang format depending on compiler
To:     Tri Vo <trong@android.com>
Cc:     oberpar@linux.ibm.com, ghackmann@android.com,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 1:05 PM Tri Vo <trong@android.com> wrote:
>
> Clang gcov format is only supported by Clang compiler, and Clang
> compiler only supports Clang format.
>
> We set gcov format to depend on which compiler (GCC or Clang) is used.
>
> Automatic format detection behavior is preserved because:
> If GCC is used, one of the GCC gcov formats is selected.
> If Clang is used, Clang gcov format is selected.
>
> Signed-off-by: Tri Vo <trong@android.com>

Thanks for sending the series Tri.  I think this config change on the
end is a nice little touch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  kernel/gcov/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> index eb428e570923..37ec551d4039 100644
> --- a/kernel/gcov/Kconfig
> +++ b/kernel/gcov/Kconfig
> @@ -60,6 +60,8 @@ choice
>         In such a case, change this option to adjust the format used in the
>         kernel accordingly.
>
> +       Select Clang gcov format if building with Clang compiler.
> +
>  config GCOV_FORMAT_3_4
>         bool "GCC 3.4 format"
>         depends on CC_IS_GCC && GCC_VERSION < 40700
> @@ -68,11 +70,13 @@ config GCOV_FORMAT_3_4
>
>  config GCOV_FORMAT_4_7
>         bool "GCC 4.7 format"
> +       depends on CC_IS_GCC
>         ---help---
>         Select this option to use the format defined by GCC 4.7.
>
>  config GCOV_FORMAT_CLANG
>         bool "Clang format"
> +       depends on CC_IS_CLANG
>         ---help---
>         Select this option to use the format defined by Clang.
>
> --
> 2.20.1.97.g81188d93c3-goog
>


-- 
Thanks,
~Nick Desaulniers
