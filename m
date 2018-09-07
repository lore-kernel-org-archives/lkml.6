Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CBBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5FC2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="bqXJ3Ecw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5FC2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeIGWx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:53:26 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36246 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeIGWx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:53:26 -0400
Received: by mail-yb1-f194.google.com with SMTP id d34-v6so5779422yba.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 11:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbtc8TzdCugj3QHIJWgj2/BTkMLKbdDPgbrqfwSUAro=;
        b=bqXJ3EcwD5lcE8Idzuoxc5igQiygGxI4Z3Y3OPODdxu2bL+i3j7zwgNIBRLVUoNB6I
         lY14YIRm6espk0/f8EIVL/5JE6B+AC5E7E2zVB6y1+MaF3NmrK0frbU1CM6am0K+UQOL
         lYg/SqfPUQQlJvvSUn7xJbAtg2UwzEtB0mH5jF88mHQgy+iTkdWCWSfpcrK42M9PhjqD
         JLC1aB7Adcfd4eS/l3MSwKwgozJCz8O6/78WFmrNpbDCtcQ2mHXGgoIKpENa/8yGOkpQ
         68AQHAOjB1Y5UeSMrvv2SrIvU3O/8xNGNGnpsnuN1ncZRO6Tgfc6Gnc/UM5tOlbyUDDD
         /ZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbtc8TzdCugj3QHIJWgj2/BTkMLKbdDPgbrqfwSUAro=;
        b=ENPyzGt+bdlfTqGBcPVHmsLL585K7kxwfl38fS7ozJ7P8QIt5kjYVeL8az1oLSsizI
         ulXLEHHoVO7uVbuZBzYMK8zq9j6A+RaBLIeh20BEzwJp3vQVz7LAIPornPdBTCSQHvAf
         RH0Oufg7XHb8AdEmqSNXv/qNnJZZk155Hn7/UZfzWFkQPUc3dHVnsD7GYK85q3zxrI0U
         iVzpN9YF0tNyj1juprGPIqYYiNfylMIhZCqdLtD1+awcm59AKgJ6FQ9L4+NOh21cCSNe
         NxwIuaQveQSAnZC75kyi8fj5myePHnsjR7H50hPN4hngOcuJYVa12QvBCTzhk8SQIXyg
         eB9A==
X-Gm-Message-State: APzg51AxPUT5TRvlEsrw7zLDMWlxhnDm1IHbmdA0dnSdrDdNEstPhM1R
        l+fEYdL0zZpd6mBKgn8ejzSYYtovTuZ8jPJeyUhbgA==
X-Google-Smtp-Source: ANB0VdZFtrmhf8qBacQ6GgsisIaOg+NARVUEQjIvG2TtKZ/ulY+CbPoPtWwIbunUGTkDvjP9nqhcg7nL/qSc+s2nmk8=
X-Received: by 2002:a25:be04:: with SMTP id h4-v6mr4672158ybk.407.1536343879362;
 Fri, 07 Sep 2018 11:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180831143352.22970-1-cgxu519@gmx.com> <20180831143352.22970-5-cgxu519@gmx.com>
In-Reply-To: <20180831143352.22970-5-cgxu519@gmx.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Fri, 7 Sep 2018 14:11:08 -0400
Message-ID: <CAOg9mSR1n88LBpmr7kOdSRx84FtnzUzsxG+oV4=vWVjz0Zkfbw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] orangefs: cache NULL when both default_acl and acl
 are NULL
To:     cgxu519@gmx.com
Cc:     jack@suse.com, "Theodore Ts'o" <tytso@mit.edu>,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        shaggy@kernel.org, Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org, LKML <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        jfs-discussion@lists.sourceforge.net,
        Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks... I've added your patch to 4.19-rc2, run it through xfstests,
and added it to my linux-next tree...

-Mike
On Fri, Aug 31, 2018 at 10:35 AM Chengguang Xu <cgxu519@gmx.com> wrote:
>
> default_acl and acl of newly created inode will be initiated
> as ACL_NOT_CACHED in vfs function inode_init_always() and later
> will be updated by calling xxx_init_acl() in specific filesystems.
> Howerver, when default_acl and acl are NULL then they keep the value
> of ACL_NOT_CACHED, this patch tries to cache NULL for acl/default_acl
> in this case.
>
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> ---
> v1->v2:
> - Coding style change.
>
>  fs/orangefs/acl.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/orangefs/acl.c b/fs/orangefs/acl.c
> index 10587413b20e..72d2ff17d27b 100644
> --- a/fs/orangefs/acl.c
> +++ b/fs/orangefs/acl.c
> @@ -167,12 +167,16 @@ int orangefs_init_acl(struct inode *inode, struct inode *dir)
>                 error = __orangefs_set_acl(inode, default_acl,
>                                            ACL_TYPE_DEFAULT);
>                 posix_acl_release(default_acl);
> +       } else {
> +               inode->i_default_acl = NULL;
>         }
>
>         if (acl) {
>                 if (!error)
>                         error = __orangefs_set_acl(inode, acl, ACL_TYPE_ACCESS);
>                 posix_acl_release(acl);
> +       } else {
> +               inode->i_acl = NULL;
>         }
>
>         /* If mode of the inode was changed, then do a forcible ->setattr */
> --
> 2.17.1
>
