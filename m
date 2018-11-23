Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABE3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 05:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDAE20672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 05:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSK3wM0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDAE20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501982AbeKWQlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 11:41:11 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40474 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbeKWQlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 11:41:11 -0500
Received: by mail-yw1-f67.google.com with SMTP id r130so1218723ywg.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 21:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YE3EvI3y17cIFvUIjyyL8FY6Xun8Oor94rJFbPNFjqM=;
        b=kSK3wM0irHrBHyE+lspTs0v8rGRoX4UwnhNr8ztexF0r2DhT7E7uj2VAxhJuLFab/D
         XXZoluBxyg+jtlp23VUSFTtGLbBzchK8pW+xjoxSh38ml97XeW+0ES/mkqIFL7JgSxmZ
         U2XWddsul1J2y4teBoRq8KTeXRomr4PGEtVyHVPL2ktdGIjv8GXj3CZjinfsJwr5u7n/
         hThe/rmiza7AbD2N8lqE57RosMaan04xLalxEYSYhMI7LKn+Jkv+ws7UX8eMkMf2vkFk
         tWLqZMtGT7rlTRnmggTx7S+0Mt9bTYowlFSLw9qK4ra0ATJyBQalVZyeFXz0sQEwLvcQ
         riXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YE3EvI3y17cIFvUIjyyL8FY6Xun8Oor94rJFbPNFjqM=;
        b=O8n4FBORpe6TaT3+Bp+hC9sxp5299I0RrIgF2ISFCOrgH30Yu3c7snQWSJt74NAfSU
         BSdSFuOizXDTfM/3goGausyFVMAOL9Y5qJcCcj/XY6dB/qfEMrprl950FJVcw4+CisgU
         2xV5MqyySintzzh5Np9q6zdQ3vha40g9wMyVIkHM7qJ78uYqUgBDJBvtyXOzm0JgTDMo
         ACI/t7ENQJ2YXS1WB8K6RArsr7cOcD13WRaogUwQ3OIqXBMhKJGABjYT381Mp/SWPwUC
         eM+BtTNNsP+cQ0xNZCmQh/wA/E7syWeAnqazoYWQt6tcnAEAej78NilVzMdzm+jpAqCA
         EbvQ==
X-Gm-Message-State: AA+aEWZc/lcQZ0/4DHLDxkJjzqGtxrfqsZtHfwpewtmU127K5Ti4ar0j
        xb1dk5pqJJNBQbeT4Xor9w2yqiTJHEC7GXMR9F0=
X-Google-Smtp-Source: AFSGD/V3YdHWTOC1mUvqoSeX1yoJIwL2E1+yGVKeFMPvNMDvrptA2Ns7xDbFgEXXhbOMuioh2zTytPiVMz/dkldD9TE=
X-Received: by 2002:a81:2916:: with SMTP id p22mr11017059ywp.176.1542952707052;
 Thu, 22 Nov 2018 21:58:27 -0800 (PST)
MIME-Version: 1.0
References: <1542942953-93562-1-git-send-email-bianpan2016@163.com>
In-Reply-To: <1542942953-93562-1-git-send-email-bianpan2016@163.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 23 Nov 2018 07:58:15 +0200
Message-ID: <CAOQ4uxj74Xh6ZbJp7zPZOxOY-gkrm5K1yU31+DW1YMYzOWtKgA@mail.gmail.com>
Subject: Re: [PATCH] exportfs: do not read dentry after free
To:     bianpan2016@163.com
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 5:16 AM Pan Bian <bianpan2016@163.com> wrote:
>
> The function dentry_connected calls dput(dentry) to drop the previously
> acquired reference to dentry. In this case, dentry can be released.
> After that, IS_ROOT(dentry) checks the condition
> (dentry == dentry->d_parent), which may result in a use-after-free bug.
> This patch directly compares dentry with its parent obtained before
> dropping the reference.
>
> Fixes: a056cc8934c("exportfs: stop retrying once we race with
> rename/remove")
>

CC Fixes patch author/reviewers

How did you find this? by code review or did this actually happen?

Normally a IS_ROOT dentry would be either DCACHE_DISCONNECTED or
pinned to some super block, but I guess there may be corner cases?

> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  fs/exportfs/expfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 645158d..a69aaf5 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -77,7 +77,7 @@ static bool dentry_connected(struct dentry *dentry)
>                 struct dentry *parent = dget_parent(dentry);
>
>                 dput(dentry);
> -               if (IS_ROOT(dentry)) {
> +               if (dentry == parent) { /* is root entry */
>                         dput(parent);
>                         return false;
>                 }

The change itself looks right, but the name IS_ROOT is confusing
enough as it is. The explicit comment is just plain wrong.
If it was really a root dentry, it wouldn't have been DCACHE_DISCONNECTED
(unless it is a filesystem bug).

Thanks,
Amir.
