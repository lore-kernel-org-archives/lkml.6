Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64F3C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E7C2145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="j4V9yFbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfBEI0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:26:48 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:25446 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfBEI0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:26:48 -0500
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x158Qg6P006102;
        Tue, 5 Feb 2019 17:26:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x158Qg6P006102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549355203;
        bh=KmjzBrXxR3zNlk76HvmjQj0YEZz9pYOyHhasIBSXfsw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j4V9yFbjgX0T5ECX03v2YPmJgVJPRps/CAeKFyE64OBFbl0cIOipB2cIRaIoLjM1i
         LpwO87ElcpYZIhQeK4yJ1v1kzuUEJYuduup1c4dgaskDML/+tRvbXwozbUgt07bj6e
         CGAxvrZa/5vbV4F+Rf5VZqiVpmeEXmRLlVZdPtO4ICgdT9IODFmADd+aJ/gFgM/MVR
         cWhX3k+i6ofjwXzBCD6Fl+LfcGaQVTddBsEN3XyCg/zz9HOrH6SfvAMtxHbIxAo9dy
         O2afLJNaWGsU5NfQiatxl6EaRA3wstUMCyEXZqhEh43QWE2TXO3bBiU8M9hIgBE8hP
         xxt1Hf95vqIzw==
X-Nifty-SrcIP: [209.85.221.176]
Received: by mail-vk1-f176.google.com with SMTP id o130so592279vke.10;
        Tue, 05 Feb 2019 00:26:42 -0800 (PST)
X-Gm-Message-State: AHQUAub6NA/C5A1OxgCA/0u84zXhUxaq8tmA5MGLZa6T4+1K4m58V2+C
        HDyVA00H7GG99Q2wbsNRPo78RqvAhin60qy3RJk=
X-Google-Smtp-Source: AHgI3IbCMRNefHd6257chfqUqd543PwCWXx9kiYSa5jQpTKQEAEmzXZ06BLthp4MtPqIbpkql1Cief8CbUzOxkdk9J4=
X-Received: by 2002:a1f:9350:: with SMTP id v77mr1431766vkd.64.1549355201737;
 Tue, 05 Feb 2019 00:26:41 -0800 (PST)
MIME-Version: 1.0
References: <20190201210853.244043-1-jflat@chromium.org>
In-Reply-To: <20190201210853.244043-1-jflat@chromium.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 5 Feb 2019 17:26:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS5j6+o+wb8WL=8WP4r4fgqY1MDSGe0_u9Nri81_Eb3xw@mail.gmail.com>
Message-ID: <CAK7LNAS5j6+o+wb8WL=8WP4r4fgqY1MDSGe0_u9Nri81_Eb3xw@mail.gmail.com>
Subject: Re: [PATCH] kbuild, LLVMLinux: Don't suppress format warnings
To:     jflat@chromium.org
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 2, 2019 at 6:10 AM <jflat@chromium.org> wrote:
>
> From: Jon Flatley <jflat@chromium.org>
>
> gcc produces format warnings that clang suppresses. To keep behavior
> consistent between gcc and clang, don't suppress format warnings in
> clang.
>
> Signed-off-by: Jon Flatley <jflat@chromium.org>
> ---

Applied to linux-kbuild.
Thanks.




>  scripts/Makefile.extrawarn | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 768306add591..94daf4e1fc73 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -68,7 +68,6 @@ else
>  ifdef CONFIG_CC_IS_CLANG
>  KBUILD_CFLAGS += $(call cc-disable-warning, initializer-overrides)
>  KBUILD_CFLAGS += $(call cc-disable-warning, unused-value)
> -KBUILD_CFLAGS += $(call cc-disable-warning, format)
>  KBUILD_CFLAGS += $(call cc-disable-warning, sign-compare)
>  KBUILD_CFLAGS += $(call cc-disable-warning, format-zero-length)
>  KBUILD_CFLAGS += $(call cc-disable-warning, uninitialized)
> --
> 2.20.1.611.gfbb209baf1-goog
>


-- 
Best Regards
Masahiro Yamada
