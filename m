Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850ECC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA0C20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VoqfxPQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfANVul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:50:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42796 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfANVul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:50:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so235227plp.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 13:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=14YDRVDAISmz9dZZlQeYueBmLlhpYfy7IbOGqRyiihc=;
        b=VoqfxPQkIcuUU7OdfNYcqqc1DgxfgBeIUKF430kGGMvIxflJasgqb9ssflHaCHwyDW
         qIWwDCB5SXtn4HddNK0hFtT2husYotSKng8l1dclotJIPf5cdDQEag/1SU3PraQypc2M
         Y4JHEWhUds+k/hdxB+uHacrx1p1u0cBAO8CkSk088eF13mByhadQLyIMku+HOsAoDocf
         z6FxKUVvH8zAGcnzQlOpUCfu0b+HDoww7/qoWgvPks8hmyIDJ8+/eFNQZcaCzslZfXe+
         Lh2aXHvvq9DV43UXqam3ZbqQGVPCVv6g26e8DMYYJoAIWJACJNVjI6KnYA+SUWxU/mX6
         yUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=14YDRVDAISmz9dZZlQeYueBmLlhpYfy7IbOGqRyiihc=;
        b=EPxri2065J8opgBGfJMqk7TRJKk6kSDGbSVzt4woYuwZeAX3L/Y9ZiNdKJfK8uzbRq
         TU9JWU4AYowQIR219ypWUGEBIz2epvE66QQ86xhLVQhVsrr5oQHk1I8EWToyo7iC7o/q
         GfpGUwwpoGWjH554tZRg+9OZqRuDm07R8Bu500ZvfDnDiYF6X7A0zaoYhHyATWpvqUTU
         0PiHQwu1UkIQmZ2rXyHM5qkNqP87DzTejlOPRiA6IQnUPjkvYh1g87RRF8wfmhO9XiZk
         TSyZ6yJjYnVUXQQLnmH8OR12cMDgiFEfum9GlCei9yYoggFpDokrtWKUomHMmeTwyanf
         w7Hw==
X-Gm-Message-State: AJcUukfVXcTGhIS3bpCYhGvqLWZYb89eZSW3FQGFy0wqLtZbVheBRBJF
        TOei3s8XKkHEbY95usUH6cLz15bYVP/S2ryXPB2CnQ==
X-Google-Smtp-Source: ALg8bN5WYwfKFNo18jusVOkbUyBtHW3XDnco3uLejxkDKuqe5av9U6hYhrAv0zmazg/Uh0xxqKFxA8L5rQ+6wM5Tf7k=
X-Received: by 2002:a17:902:4464:: with SMTP id k91mr627699pld.13.1547502640507;
 Mon, 14 Jan 2019 13:50:40 -0800 (PST)
MIME-Version: 1.0
References: <20181210223133.22667-1-ndesaulniers@google.com>
In-Reply-To: <20181210223133.22667-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 14 Jan 2019 13:50:29 -0800
Message-ID: <CAKwvOdnZcHdV6H1H74mRGbVayYwbpU0AmX0nwhEJHYmKVuvo5Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: VDSO: Drop implicit common-page-size linker flag
To:     Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 2:32 PM <ndesaulniers@google.com> wrote:
>
> GNU linker's -z common-page-size's default value is based on the target
> architecture. arch/arm/vdso/Makefile sets it to the architecture
> default, which is implicit and redundant. Drop it.
>
> Link: https://lkml.kernel.org/r/20181206191231.192355-1-ndesaulniers@google.com
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/arm/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
> index f4efff9d3afb..8f2fac5acbc8 100644
> --- a/arch/arm/vdso/Makefile
> +++ b/arch/arm/vdso/Makefile
> @@ -11,7 +11,7 @@ ccflags-y := -fPIC -fno-common -fno-builtin -fno-stack-protector
>  ccflags-y += -DDISABLE_BRANCH_PROFILING
>
>  VDSO_LDFLAGS := -Wl,-Bsymbolic -Wl,--no-undefined -Wl,-soname=linux-vdso.so.1
> -VDSO_LDFLAGS += -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096
> +VDSO_LDFLAGS += -Wl,-z,max-page-size=4096
>  VDSO_LDFLAGS += -nostdlib -shared
>  VDSO_LDFLAGS += $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
>  VDSO_LDFLAGS += $(call cc-ldoption, -Wl$(comma)--build-id)
> --
> 2.20.0.rc2.403.gdbc3b29805-goog
>

Bumping for review.  This option has been removed from all other architectures.

-- 
Thanks,
~Nick Desaulniers
