Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2155FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB542075A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nR0LicQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB542075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeIJHh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:37:28 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46299 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeIJHh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:37:27 -0400
Received: by mail-oi0-f65.google.com with SMTP id y207-v6so37280884oie.13;
        Sun, 09 Sep 2018 19:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dQMPIv+2SRQooSqf2f1FtIXbctKsHqkGdT0UqymyeDk=;
        b=nR0LicQJROW/+opF2t9jlpcF0r9X7WrQrFG+5ufNBsvJkPZ1jPBTNpgj4gBlnKnJBb
         g0qKNPnY5aoZx71cYBrDsRhJLa3vlVLJ36SNzPayLbNb1uN1UhhFdl3ptlg+cXv/F5AY
         YLb7FcRhCEnNhnVSafdn4YtEAr/1TnjHa+TO3HLl+B3BzedUjlzZhdt02Mcqj0Nf6nlr
         LlexBksO63ZDsFue4199Kz7p3Sr1N6JcRWLiywW/qADj3wYJlSDWML6HJIvD8vemfcx5
         9sj7LtPxsBaLs1oOGZTFsIBB217dZ2Gv12Wy9BKflLqkQuzgLlgZeJzIBN7BR1TcHGWI
         S2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dQMPIv+2SRQooSqf2f1FtIXbctKsHqkGdT0UqymyeDk=;
        b=BCeS/gWhuUrF0Tt4sWaTJC2bQslatX4emADJfCHLZl1AebbTSCN8qb4VilrvXIA/q2
         +tB492TqAhOyr1gnVldhimEB+GdpFmyNw1GaiHFeiM07diR+e0VwnmjJYoklIBJscLna
         sEIQQI69v/dJZhN0105OD1bkI4mf2ivXKwRVCnzly3X/nJF7wDqUG/OZWeioPFPRQsh1
         jg8gzdCLeyniMygVoNbjdCGQeFTlNmkRTAEqW/bUMy9n/YTPY5gTuY4b+R7Glz6eHIHF
         SFGOJXd/Fp5Rmxo6h1TLS/cUXZdAJ9kLWFuuRGpKxV2Cdu6Au+6GJhCVHzbxxtCqUdL1
         +6Tg==
X-Gm-Message-State: APzg51ATydhNgI62CmPRrbyQja09xUsCZPvg6zKQtclY7G+BLzNIjIJX
        lRXARi+4Or0ypkpEgXzHtyGFRNUpV3uU7Hjft+UcFyw+
X-Google-Smtp-Source: ANB0VdbrW6dCjswKaJpd0RV0nhMTnHPMMAgGcn14YdIPSDH8SHA/HBlm+3hvUtX/1Sc2ev8lOg9op1tyn64DOlZxq2c=
X-Received: by 2002:aca:6087:: with SMTP id u129-v6mr17778821oib.99.1536540601007;
 Sun, 09 Sep 2018 17:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <1536411327-30127-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1536411327-30127-1-git-send-email-zhongjiang@huawei.com>
From:   Junhui Tang <tang.junhui.linux@gmail.com>
Date:   Mon, 10 Sep 2018 08:50:11 +0800
Message-ID: <CA+NNRhENeguvt7dXY=F_2NaD=ihMbAQ8R-MN9mZf73YmU9mEwQ@mail.gmail.com>
Subject: Re: [PATCH] bcache: remove redundant condition before debugfs_remove
To:     zhongjiang@huawei.com
Cc:     colyli@suse.de, Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM

Reviewed-by: tang.junhui.linux@gmail.com
zhong jiang <zhongjiang@huawei.com> =E4=BA=8E2018=E5=B9=B49=E6=9C=888=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=889:08=E5=86=99=E9=81=93=EF=BC=9A
>
> debugfs_remove has taken the IS_ERR_OR_NULL into account. Just
> remove the unnecessary condition.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/md/bcache/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 2d26f9e..a3d2a94 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -1506,8 +1506,7 @@ static void cache_set_free(struct closure *cl)
>         struct cache *ca;
>         unsigned int i;
>
> -       if (!IS_ERR_OR_NULL(c->debug))
> -               debugfs_remove(c->debug);
> +       debugfs_remove(c->debug);
>
>         bch_open_buckets_free(c);
>         bch_btree_cache_free(c);
> --
> 1.7.12.4
>
