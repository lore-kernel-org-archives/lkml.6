Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425CBC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F007F20659
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNPdUUvp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F007F20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbeJLV60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:58:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55278 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbeJLV60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:58:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so12511625wma.4;
        Fri, 12 Oct 2018 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NCNQY6m01P3Qy3qr1yUlO29yse9SurNKF1zdUJ7E+Ro=;
        b=PNPdUUvpB3IoCSeWg7HFRrHEbXyZZthIROOO7LG0z4oyDfrDZbA2YL2b+Mu5rDcZ9f
         yHBEnMO7PvmBbKdduRZBf4nVNZWXx4ulTUl76DoTTZmhlFK5BmKMfNVWGnjyl16n9HP3
         FOUJQXL6u9NXIsozj8AUc4ElRAEvxJCCd/ApliUFyr7LD+fYi+GzbWcQ+76kJ0Ys740h
         /3EeCtnfwBYEjxlgIxbhbvlkzHMSW30s1HzZWKZzmTl8ABqqwhA45s26+MmIgwgvmZcn
         7MnkpU5SYWCEZDWoWLE7TtpJW395O2P+GXu7IFhQnHV2kyzmU7FhuRiP9EFWa7yVleOL
         wR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NCNQY6m01P3Qy3qr1yUlO29yse9SurNKF1zdUJ7E+Ro=;
        b=gEmFc97r0juIcJRGDhze7OiXD+dype8WvCQvSVnQwW6ecbAynzOxPxMcp57J3HlCyB
         f/oDkWMTVZkcG8njT4PgJHGrYYOIcATgkP1t5nt7YIwaV+fXFk2YGrXJvD0xgHBVIALQ
         gZeekij3vkUZ9tu3CnDJm1mxO9MuMT7FSFyC/cBjLT39OCvEbb5ll4KmGVng1qun0cnS
         BHSw1sJLnVTkktM6yMXQYmu9MGtQ9kZDFKeGQiulMLOL0F74iTx+Zu/Mkq8i3XKWW7lP
         XSZXaxF4Kb4UdYA2BnV/nKMVML9gJ9eUKcAcfesYKi00y/XbO1JJeG1Ek9jKNh5FvNUl
         cHvQ==
X-Gm-Message-State: ABuFfojZIQh9bIcbT/TGhp1I5ZCym7WhBEO4F89CcZyOn1X55T8u1bgy
        ris+sE9ztQ6G7fAfYBZAbAzKoV/J2x0=
X-Google-Smtp-Source: ACcGV61M9gyii/3AOLPy0AbzLaLBpgNIypv/YWaOns6OzVEj9nBs2y9iFIaiEseFvLebrW9R5TsJuw==
X-Received: by 2002:a1c:3b89:: with SMTP id i131-v6mr5303372wma.27.1539354343940;
        Fri, 12 Oct 2018 07:25:43 -0700 (PDT)
Received: from [172.16.1.192] (host-89-243-172-161.as13285.net. [89.243.172.161])
        by smtp.gmail.com with ESMTPSA id z8-v6sm1066164wrp.63.2018.10.12.07.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 07:25:43 -0700 (PDT)
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: Re: [PATCH 03/33] teach move_mount(2) to work with OPEN_TREE_CLONE
 [ver #11]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <153313706468.13253.16771852721230651938.stgit@warthog.procyon.org.uk>
Message-ID: <3fa048b0-896e-238f-0ba3-0e4e4f5a7157@gmail.com>
Date:   Fri, 12 Oct 2018 15:25:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <153313706468.13253.16771852721230651938.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2018 16:24, David Howells wrote:
> From: Al Viro<viro@zeniv.linux.org.uk>
>
> Allow a detached tree created by open_tree(..., OPEN_TREE_CLONE) to be
> attached by move_mount(2).
>
> If by the time of final fput() of OPEN_TREE_CLONE-opened file its tree is
> not detached anymore, it won't be dissolved.  move_mount(2) is adjusted
> to handle detached source.
>
> That gives us equivalents of mount --bind and mount --rbind.
>
> Signed-off-by: Al Viro<viro@zeniv.linux.org.uk>
> Signed-off-by: David Howells<dhowells@redhat.com>
> ---
>
>   fs/namespace.c |   26 ++++++++++++++++++++------
>   1 file changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index e2934a4f342b..3981fd7b13f5 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c

> @@ -2464,10 +2467,19 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
>   	p = real_mount(new_path->mnt);
>   
>   	err = -EINVAL;
> -	if (!check_mnt(p) || !check_mnt(old))
> +	/* The mountpoint must be in our namespace. */
> +	if (!check_mnt(p))
> +		goto out1;
> +	/* The thing moved should be either ours or completely unattached. */
> +	if (old->mnt_ns && !check_mnt(old))
>   		goto out1;
>   
> -	if (!mnt_has_parent(old))
> +	attached = mnt_has_parent(old);
> +	/*
> +	 * We need to allow open_tree(OPEN_TREE_CLONE) followed by
> +	 * move_mount(), but mustn't allow "/" to be moved.
> +	 */
> +	if (old->mnt_ns && !attached)
>   		goto out1;


Technically, I think the comment should say "mustn't allow rootfs to be 
moved". "rootfs", as in 
Documentation/filesystems/ramfs-rootfs-initramfs.txt. Moving "/" is allowed.

# unshare -m
# cd /mnt
# mount -ttmpfs none /
# mount --move --no-canonicalize /.. /mnt
#

(Or if you want to quibble about "/.." v.s. "/" -

# unshare -m
# cd /mnt
# mount --rbind / /
# chroot --skip-chdir /..
# mount --move --no-canonicalize / .

