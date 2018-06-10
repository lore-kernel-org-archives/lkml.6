Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Dwm4FuP1HFsQbAAAmS7hNA
	; Sun, 10 Jun 2018 09:56:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2CC3A60850; Sun, 10 Jun 2018 09:56:51 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4xAIJ1v"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AC327602FC;
	Sun, 10 Jun 2018 09:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC327602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932330AbeFJJ4q (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 05:56:46 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:47016 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751368AbeFJJ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 05:56:44 -0400
Received: by mail-lf0-f67.google.com with SMTP id j13-v6so26206445lfb.13;
        Sun, 10 Jun 2018 02:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8/HjZQg/+E2TcGrnFf/1bJ23sEU2KQgSGMJ5YnA+qxs=;
        b=U4xAIJ1v8JG+yBeegndq5WNBf56hYEEBrF8ML0SRy+OfGV62LG91KgWIFTQ2KODNre
         ndjFX5uPQIJQGWDP0bLea8Qr3MZpj2frmKRaRgtGi1OJINilgjGrzXG1XKNzg+s6fqIU
         lxBfO3e85lZuMkqAbl1skY3O7n6ajkzNB8a4w7WdWSkPnootv+52RoEN6i8U4ohwNBE7
         r4qWbsalYMKPr72bjMeWGt/ezwVucZ2aRS2YHQuVeWLCITr5+JTV8G4VOExBNy/Ly8Ao
         1ptQwK+zvATghX/s1JyyeM8shRajqT6fYgj0RW/fcGmSGd4YRrX30PYEh2frT6odf1D6
         TL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8/HjZQg/+E2TcGrnFf/1bJ23sEU2KQgSGMJ5YnA+qxs=;
        b=JCbdEErpWNllxoYpGZo8W69BMT9YuaWUe3qtXegb5ygoAjlym2LJZZ3eaIgVENObv2
         F9NmK1mavAvzmpD8Dcjz3qOprVhoHJhOHn6F4Lv2OfBBwgS4afvcQAA0djWM8nLzpHrI
         tqJWP2PgF4p6eQery2I2imaTNxz/7aM6nPik6KuqTk+y5UIwwBG8VBai6T01U3KWPd/v
         GX8jV2dgoxEsYt+y3IYjgpfF+NklwKiqdvYim+uIOGbhR+4W3synNUX3lfnfW2nt5Zh/
         Gy5aj6Dgrshl0NPZOO4RECRGSGsxU3+mC4YKGvE4SeDGuJYjGcKIh/HOZoBMgK8am9VT
         A5NQ==
X-Gm-Message-State: APt69E3haEa3BrMiOp59BSQCeO6BrcceERDRW3W7fxGQGLbsKH9AhrbT
        mnI/ngJ6p54jlQyPlv4+QBDAD7037RuKh6cHvZM=
X-Google-Smtp-Source: ADUXVKKGltfo3x5gr7AHSYvAJyqoSUPTzl17tbyANHfTVr8IOCLbOwjjBMiZMrG4vcgI1bSimBt2RwjLgFt0P2ytOPI=
X-Received: by 2002:a19:a111:: with SMTP id k17-v6mr3014016lfe.60.1528624602827;
 Sun, 10 Jun 2018 02:56:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b43:0:0:0:0:0 with HTTP; Sun, 10 Jun 2018 02:56:42
 -0700 (PDT)
In-Reply-To: <20180610095640.GA4061@jordon-HP-15-Notebook-PC>
References: <20180610095640.GA4061@jordon-HP-15-Notebook-PC>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Sun, 10 Jun 2018 15:26:42 +0530
Message-ID: <CAFqt6zaDdhG9=ak1ufeY2x8sr+nin8e+cgMQoi=-2o41uS5jxA@mail.gmail.com>
Subject: Re: [PATCH] fs: 9p: Adding new return type vm_fault_t
To: Eric Van Hensbergen <ericvh@gmail.com>, rminnich@sandia.gov,
        Latchesar Ionkov <lucho@ionkov.net>
Cc: v9fs-developer@lists.sourceforge.net,
        Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 3:26 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> Use new return type vm_fault_t for page_mkwrite
> handler.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
>  fs/9p/vfs_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index 03c9e32..5f2e48d 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -533,7 +533,7 @@ int v9fs_file_fsync_dotl(struct file *filp, loff_t start, loff_t end,
>         return retval;
>  }
>
> -static int
> +static vm_fault_t
>  v9fs_vm_page_mkwrite(struct vm_fault *vmf)
>  {
>         struct v9fs_inode *v9inode;
> --
> 1.9.1
>

Eric, as requested, posted it in net-dev and lkml mailing list.
