Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C27ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58A020856
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QrJLGjO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58A020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbeGPNNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:13:06 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:39801 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbeGPNNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:13:06 -0400
Received: by mail-io0-f194.google.com with SMTP id e13-v6so37647150iof.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 05:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6hGO7Pj45sgxBx+ohvN3Ee0fjvMFtItKoF5mpf7kkp0=;
        b=QrJLGjO7uXzI9QcrYMFozxH1se2Jzo69g8HdwTUdrtFvcoMalZcG1VlW5EGC/6XQaj
         U8Tvrx8/XLex9UOiE6eM7MPbRMbZhmyr8c+YtWR2Mp2GC6jgt4S5RyMLxe10dpIhbvZy
         JEFOrbNaaZ+/eYkPwiR4mSZzLp19O4jNZKSsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6hGO7Pj45sgxBx+ohvN3Ee0fjvMFtItKoF5mpf7kkp0=;
        b=p9hafL4hO/Z07JkkIa74tWt0polFw3W46AfbaviGuhrHIBpyh4nPPQDW5tBqPFId6T
         X9TlLDgMCzBrfbgCJPLIVO8YK9C67dyD4oBWhprfs7Wq4iq3xNSKitlmMyhdgF21CRt8
         Y09xP/VsLOU4YfyZ9QkNQd0LPEUV6xtUYG5BRq19lN/GApMLJ6mgZd/fX5yPOUKzMwDe
         97wmGU++h4qQR9kxRmsyk4lsftJqRVliJQNp8j2HHK1uhJI+LSUa7Gs50Qi6yRfFfjNO
         dyoRez7OJZV1JvmLfwLasrhJ25uTk4kv8n5XZTJdtAdqRjc95e0pdbIvgMI+yi2GOO/T
         iEaw==
X-Gm-Message-State: AOUpUlGL/eYyvPihkHwok4ojAIQnsP+W2Yqa9a1xc/y3ov6BZ3PXtTpS
        0SC6Z4IkJthip2A4aSJEkoCSLvbl2+j39/y8uU5Rr0vy
X-Google-Smtp-Source: AAOMgpdJ0z7y/535PMLF7i1ls2+YmjQkovtTtmqdEP/r8UFs7HIBg8jCYM74rpPv7ftBVkclELiKh6/AbMIoYreQZPU=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr38523988iof.304.1531745148545;
 Mon, 16 Jul 2018 05:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180716081018.21bfe495@canb.auug.org.au> <CACRpkdZ5BA1wn=TPn4yWkwWd3pAKh9wuMHd9woBF=+6+L1jtFA@mail.gmail.com>
 <20180716182944.593cca3c@canb.auug.org.au>
In-Reply-To: <20180716182944.593cca3c@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Jul 2018 14:45:36 +0200
Message-ID: <CACRpkdZ0ufcXDbxHsvuXO59Ot3g7L57gk8CJuOGWwmHK7VA9Mg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the pinctrl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 10:29 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> In the tree I fetched this morning, those commits are all committed by
> you, but you did not add a Signed-off-by to then.  This usually happens
> when you rebase a branch/tree.

Ah sorry man. Mark Brown told me the same thing this morning in
conversation, and of course I need to sign them off as I am now on
the delivery path.

Sorry for the fuzz :(

Yours,
Linus Walleij
