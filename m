Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id b3QbChN6GVsvOAAAmS7hNA
	; Thu, 07 Jun 2018 18:35:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 347756074D; Thu,  7 Jun 2018 18:35:37 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="IUSpZ3cB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rauq4k3V"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 570BB601C3;
	Thu,  7 Jun 2018 18:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 570BB601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753975AbeFGSfe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:35:34 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34673 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753716AbeFGSfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:35:32 -0400
Received: by mail-vk0-f68.google.com with SMTP id q135-v6so6685023vkh.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YO5ivJAZ5l6YLHqkx2z8lMXXajYZWBoqnkfyWRSA0bA=;
        b=IUSpZ3cBtOETsVvcwo1MG+iaH8q54o01H52GX/2EuCRqezJEU9TGMpDaDGI07nMQQR
         FdKK7qjg0VMuJynTlcDNZR77KHPR1m1xOkiPeNEr7aNhh4o+oggQhWBMXmzat0wL/U+S
         ucOTPIE4KwOFDp+RaTF5flRdSbHZyK3gTEIJkvmLWEetx2KLPQJHbJtG0ynnhPCHzAxM
         FrdTPquCip0vsT/pvOcD4wozS4KCtO/bSkGvaETz4B0wMWXAkiNhF/thG5GyC34GO0V5
         nSa9W4iA42YJHUYjPVG0tJf6fw5tu8NxPJOD0jdXxiDSxO/YkSSqfodwD/xPA9XL5DIn
         NH7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YO5ivJAZ5l6YLHqkx2z8lMXXajYZWBoqnkfyWRSA0bA=;
        b=Rauq4k3VJfZSgn4qHNUb4VzYO6n2tb6jg+TYc2Pho8s8Ne7hdxy147g+E3Okqa6zKa
         r1QNAcrDVOtDRVRd8h3Udw3R39QT5j5/2oD85iyPZRNoAFuKF0nXwkI6wBeFUf17afQO
         34xoacV8N9yyRN97JKo7Tr5mZ/mhoyERxq1tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YO5ivJAZ5l6YLHqkx2z8lMXXajYZWBoqnkfyWRSA0bA=;
        b=TN8hEQ+8tRG1uHad3MVtdt20yYla2g7Aq0JQhs52b0Yb4EsJleMTzN0MF2n/TlBmD6
         ANC8dxYujnbP70zGgfq4GtZqjN3+QlYRCjm0dwgzW3u+UrwO4IfwHEdLH8EFdnzGn1Qd
         KlhToppcFgNzQdiKprbGGyMiEVaYSc99hGB1C/JYSc9UFk0DbNj2rU1lnwBDZ2O/e2T7
         S6L8KJ6MteOoETwSyEge98YpcQAAcKnJR3U16gwcQ4Qg1gkU6VaTtd1LP8fLmcgod0O2
         GSMWOYZNQbOkZ+d4tcR42cL6jynzOWlSG8rGAe42j+YuNxeAUkylvjlg1HIYag1FawGo
         MnQA==
X-Gm-Message-State: APt69E0u+/68kXYRqH67LugYqJqKPGVvoBXO+2cC0/dwEIJS372SOwLo
        Evh9HuIjieDz6WS5UUwWfhRObKanY6btAuOfmA+luCIe
X-Google-Smtp-Source: ADUXVKJ+FWBFrlR+GUs/vIJ5T07aCxsLRpOjfE1IiKYJkQMR42BmigUCtwiu1PzWT8h0Ib0bqsAuEj0l3mDzQolH2+w=
X-Received: by 2002:a1f:c10f:: with SMTP id r15-v6mr1901853vkf.121.1528396531707;
 Thu, 07 Jun 2018 11:35:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:a085:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 11:35:31 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.21.1806071258310.7958@pobox.suse.cz>
References: <alpine.LSU.2.21.1806071258310.7958@pobox.suse.cz>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 7 Jun 2018 11:35:31 -0700
X-Google-Sender-Auth: pUBvws_DRNRry9aVaL1-ytPqVVY
Message-ID: <CAGXu5j+XFR7BtYPU6G4CeLFREWevN+GC1FPX1hPAYA1LRBM9Bg@mail.gmail.com>
Subject: Re: sparse warnings in overflow.h
To: Miroslav Benes <mbenes@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 4:01 AM, Miroslav Benes <mbenes@suse.cz> wrote:
>
> Hi Kees,
>
> sparse (make C=1) gives me this warnings today...
>
> ./include/linux/overflow.h:254:13: error: undefined identifier '__builtin_mul_overflow'
> ./include/linux/overflow.h:254:13: error: incorrect type in conditional
> ./include/linux/overflow.h:254:13:    got void
> ./include/linux/overflow.h:256:13: error: undefined identifier '__builtin_add_overflow'
> ./include/linux/overflow.h:256:13: error: incorrect type in conditional
> ./include/linux/overflow.h:256:13:    got void
>
> This hunk obviously fixes it, but I'm really not sure if it is a proper
> fix.
>
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index f1a7492a5cc8..15e55b89e952 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -344,6 +344,6 @@
>   */
>  #define uninitialized_var(x) x = x
>
> -#if GCC_VERSION >= 50100
> +#if GCC_VERSION >= 50100 && !defined(__CHECKER__)
>  #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
>  #endif
>
> Any idea?

Hi! Yeah, that's probably the correct approach. If the checker doesn't
have it, the builtins need to be disabled. :)

Can you send this with a Signed-off-by line, etc, and I'll take it for
sending to Linus?

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
