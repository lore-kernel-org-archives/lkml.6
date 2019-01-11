Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37B8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9585420872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F40gQAAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbfAKCRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:17:06 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33916 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbfAKCRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 21:17:06 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so11928873ede.1;
        Thu, 10 Jan 2019 18:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gqI+RU5FGvjE30EMotLomGJbb9bG8U0ifTamAT/wHuw=;
        b=F40gQAAesCbMzYjpE2GGjqyIuNFXrPzsiqv3JHFMvBqRDB1QBY/Akwp73v91iiHCUM
         l9G4EzwZ69/OsIiPSHfIPm5DSQoA4ZlTOflDNpgUWSW+o2+r2AidmBpp0FbG+s8ftI7g
         Uk5IWnVv6S6fGFkqH+36sBFPRSAGbtZAYeBP25Na7CsBWZrPnDC6fCpqdU+iOcXfBBva
         /R3hT6FBjfJTFxeK7LBvkNya1KID6JnNIC9chWhO5qDm6WiiLveqeAGUNp4sKgpu0NnI
         X3MtuRH42llNJoLwrCXjcM2vveZ+xI6fCQo9oGLTeuw4EXWoAOKDFBDDtBD+S5KzGXKR
         NXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gqI+RU5FGvjE30EMotLomGJbb9bG8U0ifTamAT/wHuw=;
        b=hxsL7xm/ajcr3/9Bj2sVlicc6gnRvNjFdM0RsUaC2yHu0V1QehSSxwBy0+9XEDxU/S
         G9sbS26JT7UFNBJhdPP/Cc7/cXdjdnkB2vLwVeUO9SU65Gv4nmO7ZMhX/haKtRP0GS9f
         hikkezeNBx3CkrCiEJKxnBW9QS6NPgIyEnWynkQEOlbJINnLoyZsTrXNmmP+gKzCLVam
         10kNY+21h2Od6mL+UPb08ga+k1JJy29dAAE0i7R9PmvuQqWAsa52REgw+rINChvT/pgr
         FjsDMmAiVTOS40iB5IT9yCReqwoI2DXambDae/v7lftuyZuagjc8i4dPcZVJnvUcuc0r
         hpqg==
X-Gm-Message-State: AJcUukfx35+d4gA6qHwQx7GNdLJ7MnzgFWE0tOGBVzExm52Vt6kCnp9K
        m49qAegPvHzQ1FNzv67Rci3ywy2O2PY=
X-Google-Smtp-Source: ALg8bN72NK0D5AUd0o4YQwiwq34uQDWg2T3hozl76n9dJwgAjOhB4m1Vd8eM5Ra6qOIUKibcm6YvOw==
X-Received: by 2002:a17:906:228d:: with SMTP id p13-v6mr10281492eja.159.1547173023768;
        Thu, 10 Jan 2019 18:17:03 -0800 (PST)
Received: from bebop (189.114.217.220.dynamic.adsl.gvt.net.br. [189.114.217.220])
        by smtp.gmail.com with ESMTPSA id r1sm2010127eds.1.2019.01.10.18.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 18:17:03 -0800 (PST)
Date:   Fri, 11 Jan 2019 00:17:42 -0200
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     shli@kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH] drivers/md.c: Make bio_alloc_mddev return
 bio_alloc_bioset
Message-ID: <20190111021740.GB1228567@bebop>
References: <20181222100845.566772-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181222100845.566772-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On Sat, Dec 22, 2018 at 08:08:45AM -0200, Marcos Paulo de Souza wrote:
> bio_alloc_bioset return a bio pointer or NULL, so we can avoid storing
> the returned data into a new variable.
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
>  drivers/md/md.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index fc488cb30a94..42e018f014cb 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -207,15 +207,10 @@ static bool create_on_open = true;
>  struct bio *bio_alloc_mddev(gfp_t gfp_mask, int nr_iovecs,
>  			    struct mddev *mddev)
>  {
> -	struct bio *b;
> -
>  	if (!mddev || !bioset_initialized(&mddev->bio_set))
>  		return bio_alloc(gfp_mask, nr_iovecs);
>  
> -	b = bio_alloc_bioset(gfp_mask, nr_iovecs, &mddev->bio_set);
> -	if (!b)
> -		return NULL;
> -	return b;
> +	return bio_alloc_bioset(gfp_mask, nr_iovecs, &mddev->bio_set);
>  }
>  EXPORT_SYMBOL_GPL(bio_alloc_mddev);
>  
> -- 
> 2.16.4
> 

-- 
Thanks,
Marcos
