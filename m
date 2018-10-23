Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0C9C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4A620671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZqGDrRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4A620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbeJXBIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:08:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37565 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeJXBIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 21:08:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id bh10-v6so906778plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 09:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WRUFdN9BuzwCHsVVelMk5OmnvF/BMTmzD3s6+pvsQpw=;
        b=PZqGDrRiRGr3cJOZmiL9ESglwqoezVvkhBYI/NDWTXlHt6ViWcvVNryLSvAOWsHcVo
         7tq2zcmqIuGvsggABX7Vuofs8sH2YtT+fllMaGwHtJ0TSr04pLyIssGCd4LcP5C5V/xd
         s4nxP+nrruPZZrRfr5rcipWoBHpbKvwOmWlkX6o4zprNXTiW16tU1WJcYxKEr8hjIqVM
         W6P8LsS6BPnZoLzgkOsqPzNhdtEV7LOQ/eAE+i6K6buJb2KlwegKCRTdYJF9uh3XthWw
         7LW1trnbV/att3JiYxbxs1zy8Ey2gwZdJz5BlI5DB/QrgUw2ptW8Ia0xdqdcEEaYactr
         iMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WRUFdN9BuzwCHsVVelMk5OmnvF/BMTmzD3s6+pvsQpw=;
        b=mmKUcwzlypvru4+sOJsiJEIsXYxsR8fGPX13ICE+byJKlcBH1ybbb9vLQJH3YMX6rC
         b1QA7EQm1TyqONym4nb3fGeItzIdYyBzfoKx6Z1JZETVJALU3fW8e9YBY/YFaa0PCV6i
         AnmYdMijEqB3fVCt4mKVKfNOc2OXuhyzNVnLquSwN9Tk2eU8ow03+Xc9RU9DXHB9FoTz
         HQJxldZSFuacdycFutsFva3cH1LGRSGuxOJth4B7wDq0xs9AS2wor4mfrlq6YOY04wWJ
         sPFbTmSP5Ifrd6YPdfxzT43MnakEhLGMB3X8Ki79qIwMLb67/Rk5qcHegyDHVd8KhB8f
         mETg==
X-Gm-Message-State: AGRZ1gJbnXyibDEitp3cW8BSzTbPLwDh1F3yisGWUJpUBJ9pQxHthJSK
        +vOvYytxfCCl1ZobBs2feCcASn1Pu+CI7ynPgNu0QA==
X-Google-Smtp-Source: AJdET5fuC7B4mDApLVEDdrOebo7pjV/4AqeG+W0FT58QFlx/+8p0SvopJVnK+8aAWyUJrtHF92LhBReLPYozGbLfVeE=
X-Received: by 2002:a17:902:b412:: with SMTP id x18-v6mr15127118plr.13.1540313082294;
 Tue, 23 Oct 2018 09:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181023004116.77465-1-mka@chromium.org>
In-Reply-To: <20181023004116.77465-1-mka@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Oct 2018 09:44:31 -0700
Message-ID: <CAKwvOdnCSN4gdhOsa-27sSsEgfCOyddO971+SF1Hqjsvg-sYCQ@mail.gmail.com>
Subject: Re: [PATCH] sched: Make sched_feat(x) boolean for !CONFIG_SCHED_DEBUG
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     mingo@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Phil_K97@gmx.de,
        groeck@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 5:41 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> If scheduler debugging is disabled sched_feat() resolves to a constant
> value that can be non-boolean. clang raises a warning when it detects
> that a non-boolean constant is used as operand in logical expressions:
>
> kernel/sched/core.c:208:26: warning: use of logical '&&' with constant
>   operand [-Wconstant-logical-operand]
>     if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
>                             ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Convert the original expression to boolean by means of a double not
> operation.
>
> Reported-by: Philipp Klocke <Phil_K97@gmx.de>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Thanks for resending, but I'm tracking this patch in -next:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=7e6f4c5d600c1c8e2a1d900e65cab319d9b6782e
I just cloned -next yesterday and looks like it's still there.

> ---
>  kernel/sched/sched.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 4a2e8cae63c4..b9387d35e261 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1393,7 +1393,7 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
>         0;
>  #undef SCHED_FEAT
>
> -#define sched_feat(x) (sysctl_sched_features & (1UL << __SCHED_FEAT_##x))
> +#define sched_feat(x) (!!(sysctl_sched_features & (1UL << __SCHED_FEAT_##x)))
>
>  #endif /* SCHED_DEBUG && HAVE_JUMP_LABEL */
>
> --
> 2.19.1.568.g152ad8e336-goog
>


-- 
Thanks,
~Nick Desaulniers
