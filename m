Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9352C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576CA25F70
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xzqoFkuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576CA25F70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965740AbeF0Qmo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:42:44 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:57438 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965580AbeF0Qml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:42:41 -0400
Received: from mail-ua0-f172.google.com (mail-ua0-f172.google.com [209.85.217.172]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w5RGgPcU002235;
        Thu, 28 Jun 2018 01:42:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w5RGgPcU002235
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530117746;
        bh=fkEGxdK/iFOV/QNrhPABJTQ7HEe6AYuAh42Uizf+lcU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=xzqoFkuIw7pFUkyZMHB5uXJWwc+lWNpPbdtHgz26mNS8jbBkVISMCnpO3yGpGQo3X
         IwQZ4SdSgqf+JSUBjRe6LA5Q17T0KNZZDDYSTx+iysbyz7HaHxGfQFsNkdKMHK/QPh
         Mji/BaPWL1yKxDj72S3Q6lD1KCOu0ss5uIGZnxR420eKnwW5OWjFndw52S+KAa3W1D
         awLhQpvDmZ4M8mhd6LGyWzRvhIfu42KoGkpifK9wa3J9o+R4nlS0bgatTR7fo3k7at
         TiwqSXb7trvy9O3FMxwIs+hi48L1jrUWEWT2D79NCp5NXNMiA/qFmf/KHqPdDsNCgM
         OrggwcwKdKzCw==
X-Nifty-SrcIP: [209.85.217.172]
Received: by mail-ua0-f172.google.com with SMTP id z16-v6so1669866uaz.10;
        Wed, 27 Jun 2018 09:42:26 -0700 (PDT)
X-Gm-Message-State: APt69E0Y+jR15vupfiawOAfMd9aMWHS2A8JjdwxleoEMzTSuuglWLc9z
        GDLnw3BRl6idxzhTY0QF2Lbsgw5dgHjUAZDH+1o=
X-Google-Smtp-Source: AAOMgpdMeMkEAiYVCrMpUqrWAkV3N09B4ifS/lZ/XKAtHrlosZBktUDazjT9tpEuLXfqNje0hyOros9eoLv0PmmeLXo=
X-Received: by 2002:a9f:3d6e:: with SMTP id m46-v6mr4231688uai.17.1530117745334;
 Wed, 27 Jun 2018 09:42:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 09:41:44
 -0700 (PDT)
In-Reply-To: <1529772111-5780-1-git-send-email-yamada.masahiro@socionext.com>
References: <1529772111-5780-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 28 Jun 2018 01:41:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT8qp2-mj4_miSJUojzZTty1gbh2YOOw4zAiLRBKXx0rA@mail.gmail.com>
Message-ID: <CAK7LNAT8qp2-mj4_miSJUojzZTty1gbh2YOOw4zAiLRBKXx0rA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: reword help of LD_DEAD_CODE_DATA_ELIMINATION
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-24 1:41 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Since commit 5d20ee3192a5 ("kbuild: Allow LD_DEAD_CODE_DATA_ELIMINATION
> to be selectable if enabled"), HAVE_LD_DEAD_CODE_DATA_ELIMINATION is
> supposed to be selected by architectures that are capable of this
> functionality.  LD_DEAD_CODE_DATA_ELIMINATION is now users' selection.
> Update the help message.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>

Applied to linux-kbuild/fixes.

>  init/Kconfig | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index fde3d09..041f3a0 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1051,10 +1051,9 @@ config LD_DEAD_CODE_DATA_ELIMINATION
>         depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
>         depends on EXPERT
>         help
> -         Select this if the architecture wants to do dead code and
> -         data elimination with the linker by compiling with
> -         -ffunction-sections -fdata-sections, and linking with
> -         --gc-sections.
> +         Enable this if you want to do dead code and data elimination with
> +         the linker by compiling with -ffunction-sections -fdata-sections,
> +         and linking with --gc-sections.
>
>           This can reduce on disk and in-memory size of the kernel
>           code and static data, particularly for small configs and
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
