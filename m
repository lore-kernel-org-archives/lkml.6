Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B49C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B151C23FF6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="wAzQyIqS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TxD3Se36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B151C23FF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753924AbeGEPoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:44:30 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:46801 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753534AbeGEPoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:44:19 -0400
Received: by mail-yw0-f196.google.com with SMTP id e23-v6so2601150ywe.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 08:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WB00rg/X7o98XNa0SYG7GN650VkRI0jQvvn8re5I+jM=;
        b=wAzQyIqSK77VEDTUSyhn4lhaNS2X41UZDUgEO3A+okKQImboB+FXsC7IoP2f8B6rq5
         jRj2+WXm2gl2KAasnAV9Z8ZqOIKli314mzXhODLDcMa/qwEtofHFtJmor0MGVG267flR
         lu5dyoChZHKU8bxK1U3YOtJoqRn92QpVNKK7Xxfbbh+CaaEne5ss7ViS1Ry0K3FJNRsZ
         w8BAqmmSFVlxwMy3SdTNs3mGdNJx1OZQaBjoT58XIvXCpTvKgm5Jl8dhsU2c7qAVC4h5
         Qc4Ow7ejNA3GGAVwV7/CPPVqk7HInGsiGbs7sGnnCyXL9t4hqETBrDW+dbMGXPQNttXn
         aWEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WB00rg/X7o98XNa0SYG7GN650VkRI0jQvvn8re5I+jM=;
        b=TxD3Se36ttkEC89IbIht7zet4FkJ1lBZpstwvr3ijtpn/KnWM2mWNiHxZjal1797rW
         RDvgYyQcAvRJTugNWyMkw1zUrFevY8yqtCKf4GoAHwl6nJ1NYUkyCJ8vvGbTf0kgBs6y
         LLrfOVexKvWtNdVgwnymjPvGb9Zz0JImZh1Rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=WB00rg/X7o98XNa0SYG7GN650VkRI0jQvvn8re5I+jM=;
        b=NY/6t3XeXDkL6TRPdmXPtDUlG/J7KnGHQmr23+tXQh56B33QW1+XSBFjFkTf3irwSP
         FC0HRftrVUlPmpz9oQ8TkcF24+ayjV89r6WEQ92bayDQQzCRBFAqJkPyvNdevVwtXEA+
         aQSV/K2T1fIPaaAZwCuZzsLzHNt5JS3BYte3rrZvH8DULBPcEW0Ua07rQ946ZdzyWCPN
         haYcj03iUS1rGPKjML1f82eVHkZ6Sc5f0UjtuiVf5yPwWiJFtYAmu1EjqrnBcC6B5fGh
         IYmcFIiz5jmkB5KHcZvP/8kPWIdAUoqk7mM0M1/wGeIw8HeKfHuTQuOF5gC8bwhaUrjj
         xdCA==
X-Gm-Message-State: APt69E2PKTa4fHOre9lpSFE+hh/X77tD32vH8llC4VvXEVnMmOJ0J120
        6O8U4gRhKPj2IUE9F9fAWzqrXtGWw0s1by9Gum/QdND8
X-Google-Smtp-Source: AAOMgpc5Zcngj4LnYNSBQ8FoqmieiRqzPyc1X1EzDf3pEIKMIWyqIOxpNg8s3hdn/IyoBUStqD2PGPuaqBn0qL7n9Uo=
X-Received: by 2002:a0d:fa42:: with SMTP id k63-v6mr803852ywf.53.1530805458798;
 Thu, 05 Jul 2018 08:44:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 08:44:18 -0700 (PDT)
In-Reply-To: <20180705145539.9627-1-osalvador@techadventures.net>
References: <20180705145539.9627-1-osalvador@techadventures.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 5 Jul 2018 08:44:18 -0700
X-Google-Sender-Auth: ol1tudMQ7VeuWZd23e-oGV4NV3U
Message-ID: <CAGXu5jL4O_qwwAHmW1C8q77Jv1fe_1JCq6iFxC73VySBkvHSQw@mail.gmail.com>
Subject: Re: [PATCH] fs, elf: Make sure to page align bss in load_elf_library
To:     osalvador@techadventures.net
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 7:55 AM,  <osalvador@techadventures.net> wrote:
> From: Oscar Salvador <osalvador@suse.de>
>
> The current code does not make sure to page align bss before calling
> vm_brk(), and this can lead to a VM_BUG_ON() in __mm_populate()
> due to the requested lenght not being correctly aligned.
>
> Let us make sure to align it properly.
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Tested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Reported-by: syzbot+5dcb560fe12aa5091c06@syzkaller.appspotmail.com

Wow. CONFIG_USELIB? I'm surprised distros are still using this. 32-bit
only, and libc5 and earlier only.

Regardless, this appears to match the current bss alignment logic in
the main elf loader, so:

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  fs/binfmt_elf.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 0ac456b52bdd..816cc921cf36 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1259,9 +1259,8 @@ static int load_elf_library(struct file *file)
>                 goto out_free_ph;
>         }
>
> -       len = ELF_PAGESTART(eppnt->p_filesz + eppnt->p_vaddr +
> -                           ELF_MIN_ALIGN - 1);
> -       bss = eppnt->p_memsz + eppnt->p_vaddr;
> +       len = ELF_PAGEALIGN(eppnt->p_filesz + eppnt->p_vaddr);
> +       bss = ELF_PAGEALIGN(eppnt->p_memsz + eppnt->p_vaddr);
>         if (bss > len) {
>                 error = vm_brk(len, bss - len);
>                 if (error)
> --
> 2.13.6
>



-- 
Kees Cook
Pixel Security
