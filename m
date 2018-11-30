Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB08C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310A520867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNqUWAI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310A520867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbeLAKQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:16:38 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37333 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAKQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:16:37 -0500
Received: by mail-yb1-f195.google.com with SMTP id w129-v6so1339867ybe.4;
        Fri, 30 Nov 2018 15:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qFTAE6tP9xU0AGPHwRa6UHsQrmdFu57GcbGCXh1Vx5E=;
        b=bNqUWAI4Fv9XrPOh1jleFYmf5dtNMfYKepG+fQtINjxz+fjUIbuYNlmCL+xJkMRaR3
         ORxkMVS7vWfG0tkyg0lcKTdfBOroXbBpQwSK4KFIHn1nMois/D9iQqw6AjmGLXJRkdap
         JDwocZ726ZFHdEundmiUErMnzIfcF1oxFgqXoKd9CU8hY8lpsl9BbMoJXCbknglwW9gf
         2ES+KezdX7rDazpcykjfHhNWe/kj8zmglW+f8vXlFl4anJMPm57gqwG3p8yX93Hm62xG
         RRgOpshMW3jAeS22LbQayY6nYqb9eCFM9kGn6vI+fvB1UhgoYDMIqxeJd3KqfZTSI07N
         B7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qFTAE6tP9xU0AGPHwRa6UHsQrmdFu57GcbGCXh1Vx5E=;
        b=XWLzfSevaOodCmktAGOZHbUTOHsVnCbDMJ5CyCm3UhHXDyTzP/oCxr1H0DxlnjVwbY
         uOeOEfLC6IPCpaUi5eKzdO7t4Wj2P3BypQ85kRvfPtpKat5RDZn8ibKERwACfsCy2VDD
         vhq+djfU1/qPeYJo8qUmtASwzRcedvA6rmI9hMml4oOSzoqjG42Re1XkxkmfIEcI7Cky
         CPJdtTKtEn0FJZgoKvR5rER4AYSnUXqLTmFcTQp4MD5PfPGD3awYjKoVmhxh1sAV9uLi
         rKaeYtYmC4I1XU72R4feOgJmRVWTO2Qsg9CGFHBLPueqqj7GWKM5R4DquchjkaNmqv8F
         jD8w==
X-Gm-Message-State: AA+aEWbvxhsI5xEzN4kM1gdslwx3btHQk3sK/M10OBkeSkof1xaTlsHE
        pgRM08mm2ruBBNxvze9DGyW2e6IyLlViStx8cjc=
X-Google-Smtp-Source: AFSGD/U+84yPr34+p6A4F8dsnyR0otFDDXE4sYBhu0TuvIxflN5V/6YuBwjkJ4xOC+bjRsWL/9SmbKp5F4MmOCN31Kg=
X-Received: by 2002:a25:b990:: with SMTP id r16-v6mr7285744ybg.74.1543619144235;
 Fri, 30 Nov 2018 15:05:44 -0800 (PST)
MIME-Version: 1.0
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com> <20181130192737.15053-6-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20181130192737.15053-6-jarkko.sakkinen@linux.intel.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Fri, 30 Nov 2018 21:05:32 -0200
Message-ID: <CA+ToGPGA9PTzhaQjhXULzqpes_V16LovWA2tjSJLRsByLRxWmw@mail.gmail.com>
Subject: Re: [PATCH RFC 05/15] parisc: replace **** with a hug
To:     jarkko.sakkinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, jejb@parisc-linux.org, deller@gmx.de,
        linux@dominikbrodowski.net, keescook@chromium.org,
        akpm@linux-foundation.org, linux-parisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 5:30 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> In order to comply with the CoC, replace **** with a hug.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  arch/parisc/kernel/sys_parisc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
> index 376ea0d1b275..4782c41f00c8 100644
> --- a/arch/parisc/kernel/sys_parisc.c
> +++ b/arch/parisc/kernel/sys_parisc.c
> @@ -287,7 +287,7 @@ asmlinkage unsigned long sys_mmap(unsigned long addr, unsigned long len,
>         }
>  }
>
> -/* Fucking broken ABI */
> +/* Hugging broken ABI */
>
>  #ifdef CONFIG_64BIT
>  asmlinkage long parisc_truncate64(const char __user * path,
> --
> 2.19.1
>

What about profanity in commit messages?
