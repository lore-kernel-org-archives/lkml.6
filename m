Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CAFECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D063205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D063205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbeGQQl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:41:56 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45895 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbeGQQl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:41:56 -0400
Received: by mail-io0-f194.google.com with SMTP id l25-v6so1437459ioh.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 09:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TawEyvqXALtrcuxP1WQiRYUBeh4gBtIa1+iKss9PHmQ=;
        b=ibUVle5QLtbr5saLl4nJidAXFXeeW1Nokd+wizT6a1DrVpMj56ENzmQI9hmzjZOGsR
         LSsea1loTUYrgzXbue6zs6gcbhuNk/GlrNFE6B75PK7LrcyahCIehDi/eVICAuDy63EI
         XYZJxr1iShqeEs82ZNtQzDnCXoWKA6uFNdFfS0LHOKZpw1YQ8YarfLFu1ZhYWhd7HBqz
         hUdvtxPIj+601O3wQoVfk57n/b5G2Mnz6E32Ytlr+hITLIEtsdfudbSj7CiX4Hf9qqB3
         VtD+QJuT5p8Z3P6AUS10DOQvysH5m6q3L1dUGIEQbGzHbtRrr1x+F0SfUfUhg8X6Muie
         P8Fg==
X-Gm-Message-State: AOUpUlGlaNKAbXceZk+MOzLiJTdyt7QdsLJEF2Kvvrw2h6dfexLmkETc
        DfCbtwFqNy5JvGMKt08mzt9Pq25P5i2b8dH1SjkkaQ==
X-Google-Smtp-Source: AA+uWPxxfCJxUuhPU2ROzP8+khrFaHx7B1KHBmFQR8CeZiLDRGDtEDxvadvUiY6P6NMwcV1sofA7Viqg/pNzW16xPsg=
X-Received: by 2002:a6b:9651:: with SMTP id y78-v6mr2034250iod.283.1531843714383;
 Tue, 17 Jul 2018 09:08:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:5882:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 09:08:33
 -0700 (PDT)
In-Reply-To: <20180717145928.29494-1-colin.king@canonical.com>
References: <20180717145928.29494-1-colin.king@canonical.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 17 Jul 2018 18:08:33 +0200
Message-ID: <CAHc6FU79qQuWD4o1SFbTshQcmuYAoQvSsNZ49jEWc-oSTthhFw@mail.gmail.com>
Subject: Re: [PATCH] gfs2: remove redundant variable 'moved'
To:     Colin King <colin.king@canonical.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin,

On 17 July 2018 at 16:59, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Variable 'moved' s being assigned but is never used hence it is
> redundant and can be removed.
>
> Cleans up clang warning:
> warning: variable 'moved' set but not used [-Wunused-but-set-variable]

thanks. I've looked up since when the variable is unused and added
that info. The patch is on for-next now.

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/gfs2/dir.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
> index d97ad89955d1..e37002560c11 100644
> --- a/fs/gfs2/dir.c
> +++ b/fs/gfs2/dir.c
> @@ -1011,7 +1011,7 @@ static int dir_split_leaf(struct inode *inode, const struct qstr *name)
>         u64 bn, leaf_no;
>         __be64 *lp;
>         u32 index;
> -       int x, moved = 0;
> +       int x;
>         int error;
>
>         index = name->hash >> (32 - dip->i_depth);
> @@ -1113,8 +1113,6 @@ static int dir_split_leaf(struct inode *inode, const struct qstr *name)
>
>                         if (!prev)
>                                 prev = dent;
> -
> -                       moved = 1;
>                 } else {
>                         prev = dent;
>                 }
> --
> 2.17.1
>

Andreas
