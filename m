Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BED1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A042206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2aa6GNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfANE27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 23:28:59 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35172 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfANE27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 23:28:59 -0500
Received: by mail-lf1-f65.google.com with SMTP id e26so14621338lfc.2;
        Sun, 13 Jan 2019 20:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zP9c/TG+ypPoM7+YNBGf1hY0A2/Uxk27EqHLz6S0EsU=;
        b=e2aa6GNOJUlgmYY7EBY9Im18WSiyS2rvAjx7AxZcFtDwUb2l69+AWL7xDfdHyEB5yq
         druuV+q6Ajm9IhlbhlIAFp5SPuTjCad35Ko/HVKgkPklhOa9FgdOoJl2OK4HaE3JlmBx
         +eGe04m2KbiZtibiRa5mcNNunf96p5kWbmlwnv8xXhH69JJDfC2prqJr3uAkoU7bKVGp
         cdRRW7SaqYjq14RnlERYqwFO4KAYSGuBgXXvi44TjMFtEIrJMDBxAGQZoOkVMabd6kUP
         ygj1Ii1DO2YJa1lS3S7FsTQe1Ku+RkKqKs+kw7H2MHq98HlTgOINm5WR39UBWwwfr6eE
         3RMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zP9c/TG+ypPoM7+YNBGf1hY0A2/Uxk27EqHLz6S0EsU=;
        b=kCzsvdWp+fCigda3a2FsNmo4wGnaCD/K8o9iJcQmuq7g2hH9kDOAv7yLejvNAaxKnd
         yfV8SZ9RyVsInfCGFDCIc/fIDlVZPENb+1DcrppZHFLgYKwHfuJt/rn7GgoHzc+gBpK3
         v9FWi/pv/u7Kr8JK8zll9XXbjL5WSDzDlvPUy2pn8mk9NwVoLQrinqdfxbHT3RhuGm26
         Z15P5/tG6pS4r4lwUnNn/itw44WnoCLa9XZHTSz+kUwzkv5YVDyiTByQ/f93IT9QE+fN
         4kd2Py0KMA2u483bjZ6F7AOYxV4LgRTVkVTnYSTRKS34ZA6WiajkMdqZ1oruPQSZKJbd
         IngA==
X-Gm-Message-State: AJcUukdyBYqCCiS0Lkfhmn9Z5rkkBiwJz2poduPBfO35Wr3JCmdGE1N5
        855gJWKsl2mirIgxqy/9rECFDr3Q+JtMYBZMY5ZRyA==
X-Google-Smtp-Source: ALg8bN7FaB6MLsVXQSoUwkfDFr4Es29XjagIpnWa1In7Dj+EO1xedL+fEWKiZFznAL8VHDbLcoXizDpUY1216zqZwJc=
X-Received: by 2002:a19:24c6:: with SMTP id k189mr12400179lfk.77.1547440137129;
 Sun, 13 Jan 2019 20:28:57 -0800 (PST)
MIME-Version: 1.0
References: <20190104192410.GA11084@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190104192410.GA11084@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 14 Jan 2019 09:58:45 +0530
Message-ID: <CAFqt6zYC+cNLCPCjuQaodOBkdJH3GzKOtpnkV2YfSvXwGVZ9GA@mail.gmail.com>
Subject: Re: [PATCH] fs/dax: Convert to use vmf_error()
To:     Matthew Wilcox <willy@infradead.org>, zwisler@kernel.org,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 12:50 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> This code is converted to use vmf_error().
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Any comment on this patch ?
> ---
>  fs/dax.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 48132ec..ed39161 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1220,9 +1220,7 @@ static vm_fault_t dax_fault_return(int error)
>  {
>         if (error == 0)
>                 return VM_FAULT_NOPAGE;
> -       if (error == -ENOMEM)
> -               return VM_FAULT_OOM;
> -       return VM_FAULT_SIGBUS;
> +       return vmf_error(error);
>  }
>
>  /*
> --
> 1.9.1
>
