Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DBCC4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 08:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E54A223E6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 08:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anIOopKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E54A223E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeHKKeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 06:34:08 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41173 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbeHKKeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 06:34:07 -0400
Received: by mail-qt0-f195.google.com with SMTP id e19-v6so12713261qtp.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 01:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Sv0P22Iv02OrqwVXx+cIPzWSnuWnVlAhCTSZIIH/v30=;
        b=anIOopKC7wTPGRnsliOyyaQgepTUqTwB3VIbiZ9XiiVR5bRXGhzWgmuFIKvbHtBXYg
         F8Yj7FAfWfVwlTzF8yJO1ZZv8B8NVoTE0EqcoIuB03YtTEuvwkNn/wi/BdQUDaPf8Aeb
         e3AuVhPOIV4t8Jc9muSyKjaCc444wEkLz7EGTEtNCadKi7jep15YYeq92Qhq8pVd9BFn
         rgvtpXt0fJzuICiMyuV0DL1VPTE8yUoxSG0GdN0QlKc1u1q+fabWU77OfWPDD/TDlSKb
         S3j+p5sByzUOAAL2akh7ATJQ+ILj45YrZFX5Amjv+0mleKv7TyvIxofGs5s1bemN8Krs
         TJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Sv0P22Iv02OrqwVXx+cIPzWSnuWnVlAhCTSZIIH/v30=;
        b=TYkYqdsc6xJjTl4PvgkWzg/D/4hsxcOwg/v2+6fJmfG+LBkVm3FwqzkjlsxrxkyngP
         tFYW4/uTNlYyganBH+Ati2tQDZBn5EfjFV6r4VDN8gyEIFwj0UF2TCt/zDFw6qKUJ8LW
         h7QzFU8j1Dqj8CkEqxTS1lZ2M8kuzC3sNlXB7v8eeRZaSSL1d98Z0XR6iCOeYZa9aMDG
         Jmz/63bXVwPs3xrBusG0+uC9/UDN9/SEmoceiukeHUGTLlqdK4Y1GLopF4506SxtdG1b
         AmotxwPXfezD50lR+mhk55Ow6/Fq8ZY9R0bWlhAop28HbbfchkFRBXv9M8uWY0Z0Ir3h
         4cNw==
X-Gm-Message-State: AOUpUlHt0ePcIwTnX71i5kXiYQfyorhijizwdS/LDqrCpShtj8FJxG36
        mU2b+DzfygVKf6FClVwgu1LYmZeMr6D7NFe7EPk=
X-Google-Smtp-Source: AA+uWPxT7a8lgIu2GQ6T5o5T8uXOQ65aKjeGQXNX3m1wDGgNtbYMnPLeR47g6YJmRIiloEUkD8AS/ls5dW1466fdr+M=
X-Received: by 2002:a0c:f883:: with SMTP id u3-v6mr8538230qvn.28.1533974445859;
 Sat, 11 Aug 2018 01:00:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Sat, 11 Aug 2018 01:00:45
 -0700 (PDT)
In-Reply-To: <20180809041856.1547-2-ravi.bangoria@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com> <20180809041856.1547-2-ravi.bangoria@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Sat, 11 Aug 2018 01:00:45 -0700
Message-ID: <CAPhsuW4zyC1v59bwe4D7j-K3Nw90FbDs2FZ5HuT2HOgR_oooUg@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] Uprobes: Simplify uprobe_register() body
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     srikar@linux.vnet.ibm.com, Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 9:18 PM, Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
> Simplify uprobe_register() function body and let __uprobe_register()
> handle everything. Also move dependency functions around to fix build
> failures.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Reviewed-by: Song Liu <songliubraving@fb.com>

> ---
>  kernel/events/uprobes.c | 69 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 36 insertions(+), 33 deletions(-)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index ccc579a7d32e..471eac896635 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -840,13 +840,8 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
>         return err;
>  }
>
> -static int __uprobe_register(struct uprobe *uprobe, struct uprobe_consumer *uc)
> -{
> -       consumer_add(uprobe, uc);
> -       return register_for_each_vma(uprobe, uc);
> -}
> -
> -static void __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
> +static void
> +__uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
>  {
>         int err;
>
> @@ -860,24 +855,46 @@ static void __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *u
>  }
>
>  /*
> - * uprobe_register - register a probe
> + * uprobe_unregister - unregister a already registered probe.
> + * @inode: the file in which the probe has to be removed.
> + * @offset: offset from the start of the file.
> + * @uc: identify which probe if multiple probes are colocated.
> + */
> +void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
> +{
> +       struct uprobe *uprobe;
> +
> +       uprobe = find_uprobe(inode, offset);
> +       if (WARN_ON(!uprobe))
> +               return;
> +
> +       down_write(&uprobe->register_rwsem);
> +       __uprobe_unregister(uprobe, uc);
> +       up_write(&uprobe->register_rwsem);
> +       put_uprobe(uprobe);
> +}
> +EXPORT_SYMBOL_GPL(uprobe_unregister);
> +
> +/*
> + * __uprobe_register - register a probe
>   * @inode: the file in which the probe has to be placed.
>   * @offset: offset from the start of the file.
>   * @uc: information on howto handle the probe..
>   *
> - * Apart from the access refcount, uprobe_register() takes a creation
> + * Apart from the access refcount, __uprobe_register() takes a creation
>   * refcount (thro alloc_uprobe) if and only if this @uprobe is getting
>   * inserted into the rbtree (i.e first consumer for a @inode:@offset
>   * tuple).  Creation refcount stops uprobe_unregister from freeing the
>   * @uprobe even before the register operation is complete. Creation
>   * refcount is released when the last @uc for the @uprobe
> - * unregisters. Caller of uprobe_register() is required to keep @inode
> + * unregisters. Caller of __uprobe_register() is required to keep @inode
>   * (and the containing mount) referenced.
>   *
>   * Return errno if it cannot successully install probes
>   * else return 0 (success)
>   */
> -int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
> +static int __uprobe_register(struct inode *inode, loff_t offset,
> +                            struct uprobe_consumer *uc)
>  {
>         struct uprobe *uprobe;
>         int ret;
> @@ -904,7 +921,8 @@ int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *
>         down_write(&uprobe->register_rwsem);
>         ret = -EAGAIN;
>         if (likely(uprobe_is_active(uprobe))) {
> -               ret = __uprobe_register(uprobe, uc);
> +               consumer_add(uprobe, uc);
> +               ret = register_for_each_vma(uprobe, uc);
>                 if (ret)
>                         __uprobe_unregister(uprobe, uc);
>         }
> @@ -915,6 +933,12 @@ int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *
>                 goto retry;
>         return ret;
>  }
> +
> +int uprobe_register(struct inode *inode, loff_t offset,
> +                   struct uprobe_consumer *uc)
> +{
> +       return __uprobe_register(inode, offset, uc);
> +}
>  EXPORT_SYMBOL_GPL(uprobe_register);
>
>  /*
> @@ -946,27 +970,6 @@ int uprobe_apply(struct inode *inode, loff_t offset,
>         return ret;
>  }
>
> -/*
> - * uprobe_unregister - unregister a already registered probe.
> - * @inode: the file in which the probe has to be removed.
> - * @offset: offset from the start of the file.
> - * @uc: identify which probe if multiple probes are colocated.
> - */
> -void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
> -{
> -       struct uprobe *uprobe;
> -
> -       uprobe = find_uprobe(inode, offset);
> -       if (WARN_ON(!uprobe))
> -               return;
> -
> -       down_write(&uprobe->register_rwsem);
> -       __uprobe_unregister(uprobe, uc);
> -       up_write(&uprobe->register_rwsem);
> -       put_uprobe(uprobe);
> -}
> -EXPORT_SYMBOL_GPL(uprobe_unregister);
> -
>  static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
>  {
>         struct vm_area_struct *vma;
> --
> 2.14.4
>
