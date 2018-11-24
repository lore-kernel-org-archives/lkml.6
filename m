Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D99C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45592082F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20150623.gappssmtp.com header.i=@dubeyko-com.20150623.gappssmtp.com header.b="JuqOOhxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45592082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbeKYGwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 01:52:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35964 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeKYGwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 01:52:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so4728594pfc.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 12:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qeOINDPCWIFgmDcwccigEa5EApZtKiTbO08+z1codPI=;
        b=JuqOOhxEyLbrMIs3xJXcEtbNBECwwFr78yD4AbN3pm1Y9huYme5HzlxUFja9WwmEbV
         pAjCs0sCxv8VOov5omnM++5ItOvTrOYk99vp6jE/QcbYoU9xZ9o642laXUQueAFBY/0a
         LE3UZ7LQmAPA6ChIzZEnpcywD3vZzHOG7jG9xYHGj4EImI/02lWcrukL8lbNpTjm56Ol
         mNfg1A9qo6Wh65b19SXGHfjGUZi4fXGB6DnGU62XgxejG5lIj5/7UTh/lULiI3SFg/nK
         UB3fgPI3IkQNHuHTBBGcVVQBAE/xmNTnL105n7DHiqw+pNSZpahA3HfhXWBMcIjSf9YT
         GzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qeOINDPCWIFgmDcwccigEa5EApZtKiTbO08+z1codPI=;
        b=UH8gBBOhovsM23rmoLUYP7g0hb1BGa00ao+K9F0WUpbkQp4XFK3EosxqJPJhLsoY4y
         elJXi44mzUaoBeVFKYPdKnS7js1J6eMXpX+ET4hMDFkWpaipoPHzwemCZ8XcI/EYiEGa
         ar4nPNsPtM8+0q+E6k0PqsnF5o3QWEOOxfrtwtgOhuHUZNQGdG56YQk7F4hRVIT/k5aZ
         QvWEIfF7MCb8ssft4JAh2BdgAhDKOZPrujOpnI+iISM37AoBF3s0ol92/fqLTSYcoJ25
         9+2LMNSd9+OlZ8W628PlryjCoNgEJHMKTO10nay9UyeyrgQ0WUhcMksG8gZtfbA2cpcu
         yqZw==
X-Gm-Message-State: AA+aEWZse+IrHB5Iugi263w9mP7HBKdkjypXJffzrquq4EG7/kjS/JFA
        2sZcekuNee0t50jC9TQM6fI88CcxR6RFBg==
X-Google-Smtp-Source: AFSGD/XYWVcN9wtIcig82PcTUL+BLZ0Uz746De4vb1s0DRpMQkS6oEK24plCXKEX95PM3EqQMJ1KPQ==
X-Received: by 2002:a63:4613:: with SMTP id t19-v6mr19132218pga.197.1543089823769;
        Sat, 24 Nov 2018 12:03:43 -0800 (PST)
Received: from ubuntu-16 (c-24-130-14-162.hsd1.ca.comcast.net. [24.130.14.162])
        by smtp.gmail.com with ESMTPSA id m72-v6sm3051678pfj.171.2018.11.24.12.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 12:03:43 -0800 (PST)
Message-ID: <1543089821.12764.7.camel@dubeyko.com>
Subject: Re: [PATCH V2] hfs: do not free node before using
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     Pan Bian <bianpan2016@163.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        ernesto.mnd.fernandez@gmail.com, Joe Perches <joe@perches.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 24 Nov 2018 12:03:41 -0800
In-Reply-To: <1543025458-31592-1-git-send-email-bianpan2016@163.com>
References: <1543025458-31592-1-git-send-email-bianpan2016@163.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-11-24 at 10:10 +0800, Pan Bian wrote:
> The function hfs_bmap_free frees node via hfs_bnode_put(node).
> However,
> it then reads node->this when dumping error message on an error path,
> which may result in a use-after-free bug. This patch frees node only
> when it is never used.
> 
> Fixes: a1185ffa2fc("HFS rewrite")
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> 
> ---
> V2: correct the commit information in Fixes


By the way, HFS+ has the same issue [1].

> 
> ---
>  fs/hfs/btree.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 98b96ff..19017d2 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -338,13 +338,14 @@ void hfs_bmap_free(struct hfs_bnode *node)
>  
>  		nidx -= len * 8;
>  		i = node->next;
> -		hfs_bnode_put(node);
>  		if (!i) {
>  			/* panic */;
>  			pr_crit("unable to free bnode %u. bmap not
> found!\n",
>  				node->this);
> +			hfs_bnode_put(node);
>  			return;
>  		}
> +		hfs_bnode_put(node);

First of all, it looks weird to have two calls of hfs_bnode_put(node).
Secondly, you will add only one line of code instead of two if you
simply save the node->this in the local variable.

>  		node = hfs_bnode_find(tree, i);
>  		if (IS_ERR(node))
>  			return;


Thanks,
Vyacheslav Dubeyko.

[1] https://elixir.bootlin.com/linux/latest/source/fs/hfsplus/btree.c#L457

