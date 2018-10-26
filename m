Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5301CECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0646520868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKDCUBJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0646520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeJ0D3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:29:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40699 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbeJ0D3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:29:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id g21-v6so973112pfi.7;
        Fri, 26 Oct 2018 11:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CNrmm2Cd0/IzU63bnK+ak3meqD0hHgGMcdSZm5jtCkc=;
        b=eKDCUBJYPT85nO+yQFleQiNGil5xUTcby+XI4B8WCgNLz4Q6ZQwbiswI9J1NJnf7F2
         /W/CmOKiAQh2i+rWdErE4BJ2/lIE1Es7DhMMQ2ijOzO65Wh+KrzFofrT/JFQhA69nphJ
         HTY543xuQBFYObgMfBEOcYupZlIB0eoC3cBcRD/2RWzf0u9JPZ8jpH4iGI0+7ZO0PYr4
         9QtoR9cui1FsyDgSVTzgixJu3EH2FGVSpCHM0ZGOfgy8vAMrYnsVGAzZXq59PIxK+vZE
         WSU5j3GFVGcI/Xzr+Jh1HwZiq4Kf4uMf3IzCZ5ih/b9CrxmOXMLBbKEA3spBNYCk+dz+
         hdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CNrmm2Cd0/IzU63bnK+ak3meqD0hHgGMcdSZm5jtCkc=;
        b=E3V47yV9Xg5uwZ0YySWToAO59WgwaGHxOnDAImdqVtNcR+dYoRCkkIb+Ev1iN6QIph
         LMewpT4TC63oBmQ7JQUbDeE+1ZCekaLTZzGb8U8O0oocHOQT7rD+8HA3jn2uT4A3VDHW
         5MQA+fofpk3LL7B1qRFf9GGJL3RAE96IzCFw/esW0t+9JlmL85Pm24YunWiAKhrDs6fT
         ZQs5WlkE+mwXGlfibbOyZpSIqiMSBUMl8/HhgV0zL5MrpzTdZNvDwxv/CbR3I2f0nQs+
         aRiwETRorF8CxvcQ4+AXMTz/x5pPQJ7KMxiyyWfB6ty+lC6zJQmmxEjs7AFc9llZ1i0I
         Z1HQ==
X-Gm-Message-State: AGRZ1gJVtHohKqEGUFadAhGL7eUvR1fWd7dt4TNW63SlfR//rhtSToti
        t66LhbMrk+dKSrMtnJB0hCdRxHmWONzETgTCSxE=
X-Google-Smtp-Source: AJdET5dSJi5Rlzuzkm9t3GfdnbNgK93ikRXcdWA+EGcv1+wZ4eTseDu+32bdZIR5WsFj0pTPTSuyGIz9NP3MIy0iR7U=
X-Received: by 2002:a63:61c8:: with SMTP id v191mr4635847pgb.242.1540579865257;
 Fri, 26 Oct 2018 11:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20181026180721.5040-1-colin.king@canonical.com>
In-Reply-To: <20181026180721.5040-1-colin.king@canonical.com>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 26 Oct 2018 13:50:54 -0500
Message-ID: <CAH2r5mtPEj04VutE44Dwdk+UtRM0PuT6_teMrOU44XCk3CirQA@mail.gmail.com>
Subject: Re: [PATCH] cifs: fix spelling mistake, EACCESS -> EACCES
To:     Colin King <colin.king@canonical.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next
On Fri, Oct 26, 2018 at 1:10 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to a spelling mistake of the error access name EACCESS,
> rename to EACCES
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/cifs/file.c  | 2 +-
>  fs/cifs/inode.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 84477e995246..6894d071850a 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -1003,7 +1003,7 @@ cifs_lock_add(struct cifsFileInfo *cfile, struct cifsLockInfo *lock)
>   * Set the byte-range lock (mandatory style). Returns:
>   * 1) 0, if we set the lock and don't need to request to the server;
>   * 2) 1, if no locks prevent us but we need to request to the server;
> - * 3) -EACCESS, if there is a lock that prevents us and wait is false.
> + * 3) -EACCES, if there is a lock that prevents us and wait is false.
>   */
>  static int
>  cifs_lock_add_if(struct cifsFileInfo *cfile, struct cifsLockInfo *lock,
> diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
> index 0945d40030eb..3685e2c25205 100644
> --- a/fs/cifs/inode.c
> +++ b/fs/cifs/inode.c
> @@ -1305,8 +1305,8 @@ cifs_drop_nlink(struct inode *inode)
>  /*
>   * If d_inode(dentry) is null (usually meaning the cached dentry
>   * is a negative dentry) then we would attempt a standard SMB delete, but
> - * if that fails we can not attempt the fall back mechanisms on EACCESS
> - * but will return the EACCESS to the caller. Note that the VFS does not call
> + * if that fails we can not attempt the fall back mechanisms on EACCES
> + * but will return the EACCES to the caller. Note that the VFS does not call
>   * unlink on negative dentries currently.
>   */
>  int cifs_unlink(struct inode *dir, struct dentry *dentry)
> --
> 2.19.1
>


-- 
Thanks,

Steve
