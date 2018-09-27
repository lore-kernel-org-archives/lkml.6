Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0484C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E20621580
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnThmBOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E20621580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeI0OuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:50:23 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38046 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeI0OuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:50:23 -0400
Received: by mail-yb1-f193.google.com with SMTP id e190-v6so754982ybb.5;
        Thu, 27 Sep 2018 01:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wR/F6sIXJmgdfRx8vs2rDgd0C9qP8+i8A1KV8FWr1yU=;
        b=DnThmBOe6qxWbvSYFFBwOY1l5INfeirYUmS8kmBDHNEXwx7iVYoJnSZ+S9fNSubyUY
         oaPdtnjMZKAlOiwb+wrmw7vnAdIv2YHcFK/GugivlNj7NYge5ppTkQDcUXQvuVZHepF2
         hpNqoE8KVYQYD/7avLcwGye+kB/tSTAkjsTyJ8mMeRjdKYZXvcGKTVI+R3vk3EJNRenD
         7QLRtYqPO4ew8zoO74DHzPJpIwov2I5/sJbmyyQKsFtevv5ldRjFiNxPQZXPzS+3kfhj
         7M6ngvlVldV0LyQn6PDFsEQAlKVRif+V/WWBESma3Foi8NWdTuBR1GEzoHc7ahyy+JtU
         K7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wR/F6sIXJmgdfRx8vs2rDgd0C9qP8+i8A1KV8FWr1yU=;
        b=aRd32wMCF5ThQQS9G1rBeYFGJfkzUY4IWI+Cyb9TjTo6064u8EZ9zLDe8CttkKonX7
         d0D7r5Wf9tUk8e5dmm8OcAsmEr7WUdt7nVDxCFoYBFxERolvTUYbzz1WunzexGJrBNr6
         OZOR5Ht8X9ND/otvKAErIzMEq4P8K2dQDzgM5r/RPYg3l1RdSCJmi4OUZPJf1zLm8RP9
         LmC1SvAYkVlNvHGzzD5yaSLeVtAK2v5Ai16pbX08i2t3d6cj8oMVZSxGq1eT8A3/RKkj
         PUTPuhwLA9YqR6D2RWDNGkDXPQ94QP21yz/74VdQPbq3377ErgVUsyM3/Sz5OsZHjrRt
         aJBw==
X-Gm-Message-State: ABuFfoikfwcN2oesDwJFsx/Grkcu8aGCTyruuUUeJUp6UJ6/bOJDaFTi
        LXwp6/Zkq+Ol4xih+2BZNQ==
X-Google-Smtp-Source: ACcGV616Rky39chKu2PjXjW80wAMn/zbrue01sTpj9jk8b+8uvXzS1FF0L9tTPqDsGoVj7aXC8TIRw==
X-Received: by 2002:a25:4657:: with SMTP id t84-v6mr5019694yba.177.1538037196900;
        Thu, 27 Sep 2018 01:33:16 -0700 (PDT)
Received: from kmo-pixel (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id f5-v6sm577188ywa.39.2018.09.27.01.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 01:33:15 -0700 (PDT)
Date:   Thu, 27 Sep 2018 04:33:13 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Dongbo Cao <cdbdyx@163.com>
Cc:     colyli@suse.de, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bug fix in function check_should_bypass
Message-ID: <20180927083313.GA29959@kmo-pixel>
References: <20180927082749.2243-1-cdbdyx@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927082749.2243-1-cdbdyx@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 04:27:49PM +0800, Dongbo Cao wrote:
> bio->bi_iter.bi_sector is the sector index of current request, no need to be aligned.
> instead, bio->bi_iter.bi_size should be aligned to block_bytes-1, not block_size-1.
> and bio_sectors is the number of sectors of current request, also no need to be aligned, just remove it.

this isn't a bug fix, please don't label things as bug fixes that aren't.

also, it's wrong. an unaligned IO that overlaps with data already in the cache
will result in an extent in the cache with misaligned size, which will result in
misaligned IOs when reading from it.

> 
> Signed-off-by: Dongbo Cao <cdbdyx@163.com>
> ---
>  drivers/md/bcache/request.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
> index 13d3355a..fb3502da 100644
> --- a/drivers/md/bcache/request.c
> +++ b/drivers/md/bcache/request.c
> @@ -398,8 +398,7 @@ static bool check_should_bypass(struct cached_dev *dc, struct bio *bio)
>  	    !(bio->bi_opf & REQ_PRIO))
>  		goto skip;
>  
> -	if (bio->bi_iter.bi_sector & (c->sb.block_size - 1) ||
> -	    bio_sectors(bio) & (c->sb.block_size - 1)) {
> +	if (bio->bi_iter.bi_size & (block_bytes(c) - 1)) {
>  		pr_debug("skipping unaligned io");
>  		goto skip;
>  	}
> -- 
> 2.17.1
> 
> 
