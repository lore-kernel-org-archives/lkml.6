Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9F6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A245206A2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iSEHroYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbeLNXa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 18:30:29 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35660 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeLNXa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 18:30:29 -0500
Received: by mail-oi1-f196.google.com with SMTP id v6so5935602oif.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 15:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sGlDv9/mKgoV1WH+EYkpVmmz6kkahqJVT5cOChf7FP0=;
        b=iSEHroYm2T8KOX8I+49KZP8VPHNuXrAj0jPqKrZM17nAWV/3Q3tI0eePd0xDeLeoYv
         NtlPNYRrCu6C4NOL3h1os6Q0HsrHK2OjsErANUQUeTZ48az/AgGC06vWmYiaSNFXBPud
         LiI3ipJqBXiCfQ5SW4Ab+wpwShBPAqI+QAGPfSvrVWx5aM4sLiAgIPgartUvMZhktqwS
         aAMLDlRoidfVzeFnJEfdSd2zn3bKNb8EThuo2QpzQ3VP1XibonesA0wm0U0ZLGH4dupP
         VXlMQ7ht39yl3/ZZ+PuGm2hA7d93HlTyuSxtw9cj3qnfNfUaQj8kralMB/Q19ik6nm16
         7hCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sGlDv9/mKgoV1WH+EYkpVmmz6kkahqJVT5cOChf7FP0=;
        b=e04jd1k59kLRpMlgiWu2Hx9yJsbuq5ySaX5z3hbEmZqU83hptwBjhmUumeH5hecaei
         aNQPrT0vG7FrsrSBXiHahqe18bhrJI45js6/HHSfmR1lwyQp9S+IsqMFMBjICOp0PaFr
         lIIdE6/gh4LfkY+cz0LEq6JrqS3H4Mz0m1WDLcq7w11YkoYRrEbRcopiiYZGvCQKPKEu
         ebiXF8veohgmSIu+7a/d7x8aQ9j3P5ITWafsl9yl0h/9dJq6++16kycREz4gZiG2fB/e
         fxsRjdbtY1tm7pR+lzhXPzlcHkobkBpEq/wQLu7PMbyCFqBtjlK3akpVU3xRuRlL/Afp
         X6kQ==
X-Gm-Message-State: AA+aEWaAEbPyrZEGl/igM3g9oxYgcW7tN6Lyrcy3oXqyCrXl/NSaaSY2
        YXqryHZV0y2L+yyQKUheohutY6D4GomVsI0jkrgShg==
X-Google-Smtp-Source: AFSGD/VI3RLlk7QwbRZLvlcsDEgNJH3faTJN9cS8iJevW3Rz86HsVAofWxQH1Wg2+U5X5BgZnZ1cWiXUs6grVIWbB8M=
X-Received: by 2002:aca:a90f:: with SMTP id s15mr254887oie.137.1544830227794;
 Fri, 14 Dec 2018 15:30:27 -0800 (PST)
MIME-Version: 1.0
References: <20181214221023.3878670-1-arnd@arndb.de> <20181214221023.3878670-6-arnd@arndb.de>
In-Reply-To: <20181214221023.3878670-6-arnd@arndb.de>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 14 Dec 2018 15:30:16 -0800
Message-ID: <CAFd5g45GxxhHuyHWDjd41_8xscYN6p5XJShnmg9Z2-DDGwaE4A@mail.gmail.com>
Subject: Re: [PATCH 5/7] [stable-4.19] i2c: aspeed: fix build warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>, stable@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 2:12 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Upstream commit 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events
> properly") reworked the interrupt handling and fixed a warning in the process:
>
> drivers/i2c/busses/i2c-aspeed.c: In function 'aspeed_i2c_bus_irq':
> drivers/i2c/busses/i2c-aspeed.c:567:1: error: label 'out' defined but not used [-Werror=unused-label]
>
> The warning is still present in v4.19.8 and can be fixed either by applying
> that original patch, or by adding a simple #ifdef.
>
> Here, I choose the second simpler option as the original patch seems too
> invasive for a stable backport.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
