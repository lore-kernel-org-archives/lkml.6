Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B76C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482BC2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="Ib5j+RMV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZpCydNgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482BC2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbeKZVa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:30:26 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33633 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726241AbeKZVa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:30:26 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5CEF922017;
        Mon, 26 Nov 2018 05:36:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 26 Nov 2018 05:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        zg5/ppP+1YlqxbxHwriFrkyxzrBieQgGbr6uXoWWwbM=; b=Ib5j+RMVEhzjGDf6
        2EDVAnts1060LgwlHv9IiyDc9mkSytEgkaZpBaJdOMovFU9LOiIsE6FD4r7YnoL8
        JVXW4c9Em8ajxvFKT0yVXVAkiCUIvU4HSre2Aa7Pv9fRVpukhRV3YJkhfmjCvdVw
        i9OyEwy+VwQdSU23V/dByEewWxpnjXZ9s2BVMX92U3QuugN3JoWRORN87vHL5eze
        7JjYKgXXq/Ahdk7DAvZMd8NNxZu+wHALCnrWV1ADYYAvWSelMuOsZ/xkIIY48Nbj
        6Y1pFHwn7Hg8DKGznRVeDw6xHBqmKJkztH8AJpPfILo0+28pV1YL8BN+l7aEl1C5
        undOcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=zg5/ppP+1YlqxbxHwriFrkyxzrBieQgGbr6uXoWWw
        bM=; b=ZpCydNgTjm90AM9IltpJtBozyuUkqD/76TialjXkH6s2XJm4wjuV0dLLQ
        WIYAawP9Eco32CeX4l1RGavPdvZ8FVj+EPtvVIu7BvWDaBLf4C0pg89Bzpz9p7G2
        kPwFypEkC3ykGAGhKDuyhFOso+1qCjYW6owYLryikhmT+gKrliqDsPWTUZYIt5+G
        kZwQJr3PbvrL9qQA1U9MXBMYL24Rip5QP/jo93srMt8+ZYMxXnSFnweL44PfbreT
        9LqS++EtsxoeMIJvQYctLUj39AMZ4gSwBe4izUoIwMIHv6YiLXB28Jomt4WQA/0W
        q0UcmpWMXLyMKhfCT8x/qgG2chUpg==
X-ME-Sender: <xms:vMz7W4tKrQ7hH_EkMUzdiXLwkmQMGkyVZFBc1K6wPEQ0Bx3SlE1eOw>
X-ME-Proxy: <xmx:vMz7W1UcZaqKwHI4Z-rrTpUX8s5s1CDslgIYCNfyTmoLy16Q8Pl2wQ>
    <xmx:vMz7W34EQOXkL3RHnONOkYmwcCzHtr26oGPL79JE9lwhyONUlPMMtQ>
    <xmx:vMz7WwJFHrU6qQnl8tJ80TBE7VPqeXr4n6SBAxj4YzH4Yc43T83Seg>
    <xmx:vMz7WyiaSrM3hzAoBOQcq7WKX4V6jufnQ32i9bYPBtRI5QEBIir3WA>
    <xmx:vMz7WyLOrvL2jFD62USwb1PRip99oJW6q8KEliMN0RJUFCukwwxCyw>
    <xmx:vMz7W6mAGDYt4eVxWmSO88tAuTTuZk4IMqh4hJdWGfJaWP8SRs7zgQ>
Received: from localhost (unknown [118.209.163.9])
        by mail.messagingengine.com (Postfix) with ESMTPA id A6C3F103C2;
        Mon, 26 Nov 2018 05:36:42 -0500 (EST)
Message-ID: <9f79a8203d29f207cfb71c7aefb3c98f28a23aaf.camel@themaw.net>
Subject: Re: [PATCH] autofs: drop dentry reference only when it is never used
From:   Ian Kent <raven@themaw.net>
To:     Pan Bian <bianpan2016@163.com>
Cc:     autofs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 26 Nov 2018 18:36:39 +0800
In-Reply-To: <1543197494-15688-1-git-send-email-bianpan2016@163.com>
References: <1543197494-15688-1-git-send-email-bianpan2016@163.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-26 at 09:58 +0800, Pan Bian wrote:
> The function autofs_expire_run calls dput(dentry) to drop the reference
> count of dentry. However, dentry is read via autofs_dentry_ino(dentry)
> after that. This may result in a use-free-bug. The patch drops the
> reference count of dentry only when it is never used.

Yes, I agree this is a bug and it should be fixed.

The autofs_expire_run() function is used for autofs v3 which is
very old now so it's not likely to be called.

But I think you are correct, if it is called the copy to user
space should trigger a umount and (likley) remove the mount
point directory, maybe I broke this at some point without
realising it ...

So thanks, I'll have a closer look but even if the ref counting
isn't quite what either of us expect this is probably still worth
while.

If I don't see any reason to not do this I'll forward the patch
to Andrew.

Ian
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  fs/autofs/expire.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
> index d441244..28d9c2b 100644
> --- a/fs/autofs/expire.c
> +++ b/fs/autofs/expire.c
> @@ -596,7 +596,6 @@ int autofs_expire_run(struct super_block *sb,
>  	pkt.len = dentry->d_name.len;
>  	memcpy(pkt.name, dentry->d_name.name, pkt.len);
>  	pkt.name[pkt.len] = '\0';
> -	dput(dentry);
>  
>  	if (copy_to_user(pkt_p, &pkt, sizeof(struct autofs_packet_expire)))
>  		ret = -EFAULT;
> @@ -609,6 +608,8 @@ int autofs_expire_run(struct super_block *sb,
>  	complete_all(&ino->expire_complete);
>  	spin_unlock(&sbi->fs_lock);
>  
> +	dput(dentry);
> +
>  	return ret;
>  }
>  

