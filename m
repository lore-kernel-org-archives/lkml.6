Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E53AECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE80720856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LqPPodYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE80720856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388177AbeGWV70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:59:26 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40411 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388052AbeGWV70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:59:26 -0400
Received: by mail-io0-f193.google.com with SMTP id l14-v6so1705783iob.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iUIT79HGIDyUJCTj7MiVddWvAzLDg3NxJc8A3A11Xgk=;
        b=LqPPodYc8b+k7thdzBRSXQ3H8sORbOnje9H2OW2b7Fx4V7aDtJurU0ZEvu8cq5ZbAB
         MkWAEqwr55i7fKlujE0N/FmDLo5CWGvFaw4DMAGnp0yrJGAPQnQrGeenAlJ/TZa47DCG
         qqn6eWmZVMidAZ04eLhgRibiFv7yfn7aaY7cQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iUIT79HGIDyUJCTj7MiVddWvAzLDg3NxJc8A3A11Xgk=;
        b=IVBOpXLlNS5csAEGC6nZ7TNcChYAhYIaf2xqh00MB8ne1bq0ndnJSnUwD0UMX0pFfY
         W2hjxYebcibK+4+cvHUkgRZqRdmTjqvVctRm4cNKSiE0hSv5hsJhPgaPJp7PlegbxwP5
         id4iqJRbx8+PCTvjNhL9DQfgN5XSefmXWPpapgbYuxOvuDjZD94mahseOCepVq+ZlPC7
         kCKWXj37DD7mmql2BbSAfIeCLGiVv3oEsLU+s+KZxEfmtABO2XVyhcGWUfKf6N8uFIT7
         Tadi2O5Nq+mDB3akRvzkFrYT+Ob/tch3asHau93TfKGgJlZ+xa+77JCcm9sd7hKk8zLv
         sb9g==
X-Gm-Message-State: AOUpUlFuy0wNA18/Trtyxm4EM1qt69mwdKtCnj7K9wVQmhyea4LZkiiL
        7dW5tQ4irbf9nyhlK9Fvf40EXdoOqVCpRMWOUcc=
X-Google-Smtp-Source: AAOMgpd5ePKCAx/lxKmn56vej79DGS8IjvTV85cQfkSCiQ29NHlQxkVp7/KdoJMC/0ISyVunCQQ89mwsdNHHx9sg0pI=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr11975564iov.203.1532379386261;
 Mon, 23 Jul 2018 13:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFzMheDA-2z=MdGgJrz-REcrknb+4OEvRKaJipm+x6xEhw@mail.gmail.com>
 <20180723204617.GA14487@roeck-us.net>
In-Reply-To: <20180723204617.GA14487@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Jul 2018 13:56:15 -0700
Message-ID: <CA+55aFyuaEGGksOxv3aAp0THYkAapap-JY65A0A81S0qUE0S+g@mail.gmail.com>
Subject: Re: Linux 4.18-rc6
To:     Guenter Roeck <linux@roeck-us.net>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding davem for the sparc issue, Martin for the s390 one.

On Mon, Jul 23, 2018 at 1:46 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> The s390 gcc plugins related build error reported previously has not really
> been fixed; after feedback from the s390 maintainers, suggesting that it
> won't get fixed in 4.18, I disabled GCC_PLUGINS for s390 builds. This is
> not my preferred solution, but it beats not testing s390:allmodconfig
> builds at all.

Martin - can we just remove the

         select HAVE_GCC_PLUGINS

from the s390 Kconfig file (or perhaps add "if BROKEN" or something to
disable it).

Because if it's not getting fixed, it shouldn't be exposed.

> The sparc32 build error is still:
>
> In file included from
>         ...
>         from drivers/staging/media/omap4iss/iss_video.c:15:
> include/linux/highmem.h: In function 'clear_user_highpage':
> include/linux/highmem.h:137:31: error:
>         passing argument 1 of 'sparc_flush_page_to_ram' from incompatible pointer type
>
> due to a missing declaration of 'struct page', as previously reported.

Hmm.  I assume it's

    arch/sparc/include/asm/cacheflush_32.h

that wants a forward-declaration of 'struct page', and doesn't include
any header files.

The fix is presumably to move the

   #include <asm/cacheflush.h>

in drivers/staging/media/omap4iss/iss_video.c down to below the
<linux/*> includes?

The old patchwork link you had for a fix no longer works, I think
because the patchwork database got re-generated during the upgrade
(and the patchwork numbering isn't stable).

Davem?

              Linus
