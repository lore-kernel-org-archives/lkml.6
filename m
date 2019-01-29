Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7029EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CD520882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="OsEJ4n8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfA2TrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:47:07 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54909 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfA2TrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:47:07 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so6498495ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 11:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XG7u523a/0f6kyGjbZgxsWPAk334VvfCv1Jk6fCTIsA=;
        b=OsEJ4n8zUxkYU4PMZvePLOWqNzRY0561eKlemyXivyWwEbnIbIFlNqXpffGsDVmwUn
         GSDW9+4KKPB8YJaEmsXPMpZCtbv0FuBQdMhXS6mah7p0plnwDMbamslfsEB3SqedOk8n
         zYGxz9LCJ42C5+n8tZDEAhRSg2JOFcScsrrwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XG7u523a/0f6kyGjbZgxsWPAk334VvfCv1Jk6fCTIsA=;
        b=WJSste6pKGYHDAiXBG0c04r/uHdlqiuH3xriBkARUOLyceCTxiK9A9x3PKJkih0yBv
         oGc29yBt5Uu4Q5ukXz9vR8yjJaIj/KbAa+j4SNN+pZB2YJ5PovI7Rr/WVgfBw8npZY66
         FtoA6qK3kM/aMR20l510y4bhLpCjsRAXc8mYFv/ImxWtts62bDH6FAw+luDcIIYOA+LO
         jTYmGCq3VcB8e+DDIddBzUcMxU+EohNQ80Z1mqlTUfgBj/T+RcmB9RChcoofBSESjNHB
         Duu69y3h8ba+k7qiN4b7GVmytsXewkGCx+HafKALS0J0w4sQ7ZSWq1hPpjjUHBzAbxL+
         Bgzg==
X-Gm-Message-State: AJcUukcznOrgveQKuq9l0tfesigJTExYgmRc7wqoTADUMt/GET3Pobvu
        O1YscruTiROCI1DV8mlvgWb0z5BB09Rg6DXar9ZdeQ==
X-Google-Smtp-Source: ALg8bN5DGzla/QKZwis6cRJIQyg2Ju8Fk2fSxgIH3vLcT9upMZn+e+YH48qNUy050rPyOgC45tKsBG55kMHkrJmcYhg=
X-Received: by 2002:a24:9dce:: with SMTP id f197mr14154001itd.13.1548791226353;
 Tue, 29 Jan 2019 11:47:06 -0800 (PST)
MIME-Version: 1.0
References: <20190122152151.16139-9-gregkh@linuxfoundation.org>
In-Reply-To: <20190122152151.16139-9-gregkh@linuxfoundation.org>
From:   Dan Streetman <ddstreet@ieee.org>
Date:   Tue, 29 Jan 2019 14:46:30 -0500
Message-ID: <CALZtONCjGashJkkDSxjP-E8-p67+WeAjDaYn5dQi=FomByh8Qg@mail.gmail.com>
Subject: Re: [PATCH] zswap: ignore debugfs_create_dir() return value
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 10:23 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> Cc: Seth Jennings <sjenning@redhat.com>
> Cc: Dan Streetman <ddstreet@ieee.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  mm/zswap.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index a4e4d36ec085..f583d08f6e24 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1262,8 +1262,6 @@ static int __init zswap_debugfs_init(void)
>                 return -ENODEV;
>
>         zswap_debugfs_root = debugfs_create_dir("zswap", NULL);
> -       if (!zswap_debugfs_root)
> -               return -ENOMEM;
>
>         debugfs_create_u64("pool_limit_hit", 0444,
>                            zswap_debugfs_root, &zswap_pool_limit_hit);

wait, so if i'm reading the code right, in the case where
debugfs_create_dir() returns NULL, that will then be passed along to
debugfs_create_u64() as its parent directory - and the debugfs nodes
will then get created in the root debugfs directory.  That's not what
we want to happen...

> --
> 2.20.1
>
