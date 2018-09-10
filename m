Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657A6C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F702064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dty4Z8Io"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F702064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbeIJHVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:21:18 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38885 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeIJHVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:21:18 -0400
Received: by mail-oi0-f67.google.com with SMTP id x197-v6so37310493oix.5;
        Sun, 09 Sep 2018 19:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OZEnTt9PuEdybCuk6NytBr5+HNU3iL3f03dR7n/UH20=;
        b=Dty4Z8IonQqooLwJcwUrnlO5fzMuIdK0mH6KN5DEcrO3k27Jcab0QSTCvAZru+da8T
         kMe9DJqea0zrl2p1O5sYMN89VIrdfN9Ul4WjaKpJTFnNDYYwNs4bUXrbGvmXkah1bxwR
         djcftzw9usg/oTwta12//yvoXnbs8ZqmQagGTaW+gT2OQ5IfhTdT9CvCG6hnl6ZgM4Q9
         FN4P1B6YpX92p/TsGhMXMIZcUZzOqT+OY/psJPFNqDO5zGHNkzwhom1ElRoi6pmP69K7
         GfnvHXx6Gzqg6rJj66i5kbVCBbnCoFetH3ELf76ehQ3am0vmuEEI/AXbd5vpJnaAN5sr
         ifyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OZEnTt9PuEdybCuk6NytBr5+HNU3iL3f03dR7n/UH20=;
        b=jR0W9fP21rI5LctHjg0WgSULvrs0STG0W/aVedmUtCc+lbSzTQO1KJoXUon5w4CZcQ
         OvdEp7SuFE1XNQ8bwvaww4v/TLdAEN9oJvZf+CSIsfYQWlG928zxFvw4RMExTW2EKAKE
         buz+wGq8OlXjgYyzUtr5DT8zNgX0KdYoChlcdtoEKY3T0nPuxxFp59DYo1qxQCqIjskP
         V+IU6ufMr5jwfFvnuHC/sxp7urYs45C1Y+xlajBhImAC+zU+UAGb+5CW48eR0Lvhe0Rt
         X1RTsvuSLS7FkZ2406qqZ22wANyfeoYvBAUquLnRyEbtOBBpV3yAbhXHrx0Fpi2zKzwB
         Wflg==
X-Gm-Message-State: APzg51C+I2XCZvt0Gsc+0jxsrEL+0wqhasBPSR8W5YboyRyhd/3gHO+h
        qG4uw2wuF/78EMvoqwrPPFrm7aPjs0r6a9XGOG+62sNC
X-Google-Smtp-Source: ANB0VdbbaWzfE1X5UTe8homtTsMiwns6/p5DwV13EYoaICPgNPeGlEZuXjSfZW/65JNxkVtl7rUQ3dYtdnmfEQb+0qk=
X-Received: by 2002:aca:e643:: with SMTP id d64-v6mr20297239oih.81.1536540618345;
 Sun, 09 Sep 2018 17:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <1536413350-31523-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1536413350-31523-1-git-send-email-zhongjiang@huawei.com>
From:   Junhui Tang <tang.junhui.linux@gmail.com>
Date:   Mon, 10 Sep 2018 08:50:28 +0800
Message-ID: <CA+NNRhFgQbdPjoX0ePP1fM5rFiBnrD5PLtxs2fE92Xg5V=_ing@mail.gmail.com>
Subject: Re: [PATCH] bcache: remove unecessary condition check before debugfs_remove_recursive
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
=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=889:41=E5=86=99=E9=81=93=EF=BC=9A
>
> debugfs_remove_recursive has taken IS_ERR_OR_NULL into account. So just
> remove the condition check before debugfs_remove_recursive.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/md/bcache/debug.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
> index 06da66b..8c53d87 100644
> --- a/drivers/md/bcache/debug.c
> +++ b/drivers/md/bcache/debug.c
> @@ -249,8 +249,7 @@ void bch_debug_init_cache_set(struct cache_set *c)
>
>  void bch_debug_exit(void)
>  {
> -       if (!IS_ERR_OR_NULL(bcache_debug))
> -               debugfs_remove_recursive(bcache_debug);
> +       debugfs_remove_recursive(bcache_debug);
>  }
>
>  void __init bch_debug_init(struct kobject *kobj)
> --
> 1.7.12.4
>
