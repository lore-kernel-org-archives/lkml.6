Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC52C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8BD21871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546422129;
	bh=FpV0fMSz1j6wkj8WyQlF52BgW4ytoQrtPvaX20T0ZlA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nr9PUFdR1bQMZbFz+ETBswq3+EW62Kp6eqwvEsPOpQXvW2uZ2KZutknd4aGHJAX8P
	 wpYQ1nqMCjl8sZBJH7YswFENU0QCbzmcwj281wPAbE7JCtUEheV5IMqNIcqRhmtMhy
	 EA29hVbXLxjfZqPDnSO+qil0lMxUwxM1WhPhFOSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfABJmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:42:07 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34818 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbfABJmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:42:07 -0500
Received: by mail-ot1-f66.google.com with SMTP id 81so26271326otj.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 01:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d+787IwLgI4COzA79Dv98FiXtazThVHpcWWIdM6pGGM=;
        b=c+pGTpknobwB13DQPXVgSSAhcPKap/3XhPiFyNcIB28a1qsBChwXCxNDhd9e/LT/gt
         2d44EgeTbHpU3xGuH28AuBiqJwkn4rSecuZy7OXmhEk36oLn98LnxPuPFnaJOQKOYPKw
         +hSC/AzD1lyxEDAuNo4p8Hhnad7/fnIo3LT5g5C2dWVB0ntsNACCIOM6YIY2swAeB2mK
         BkyJmHN6We2H+GmhgkHHKzTrSYtGBHb410hEXxbAynHnqBregAh5+Vy4D52S+mugqUVg
         i68m/NIgCgkC//myzh+F3tKeMA4rsbOTr+GO/gXVzgIEoLrjyBez+Mt9RIhWkPpiH3RP
         gnmw==
X-Gm-Message-State: AJcUukc1HdmBTUzH0zJO6/sB8EHFeHZBSdGrGmJd5SZzbHS3363GPLO6
        WfRd/JWfS3yE9mKEh+FGWsx7d2IL3l8qzkwETzfywA==
X-Google-Smtp-Source: ALg8bN4agZAvlD7ASY5W5sy2D+oXV5zpoIO07GYmfbIViFow+A9d5e1FIFDeMtRgXLufxcaNVIoUuNFE9ro1PAqYVmQ=
X-Received: by 2002:a9d:2062:: with SMTP id n89mr28258113ota.244.1546422126700;
 Wed, 02 Jan 2019 01:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20181230034652.6214-1-sergey.senozhatsky@gmail.com>
In-Reply-To: <20181230034652.6214-1-sergey.senozhatsky@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Jan 2019 10:41:55 +0100
Message-ID: <CAJZ5v0iCmGaVXwOZwKo9k_vFamiY7E8jNyCFykrLsFnXbo0-nQ@mail.gmail.com>
Subject: Re: [PATCH] debugfs: debugfs_use_start/finish do not exist anymore
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 4:49 AM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> debugfs_use_file_start() and debugfs_use_file_finish() do not exist
> since commit c9afbec27089 ("debugfs: purge obsolete SRCU based removal
> protection"); tweak debugfs_create_file_unsafe() comment.
>
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  fs/debugfs/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 13b01351dd1c..4354069101b4 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -422,8 +422,8 @@ EXPORT_SYMBOL_GPL(debugfs_create_file);
>   * debugfs core.
>   *
>   * It is your responsibility to protect your struct file_operation
> - * methods against file removals by means of debugfs_use_file_start()
> - * and debugfs_use_file_finish(). ->open() is still protected by
> + * methods against file removals by means of debugfs_file_get()
> + * and debugfs_file_put(). ->open() is still protected by
>   * debugfs though.
>   *
>   * Any struct file_operations defined by means of
> --
> 2.20.1
>
