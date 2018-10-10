Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74084C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C8F2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKXSfycM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C8F2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeJJU2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:28:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39467 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbeJJU2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:28:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id y144-v6so5644621wmd.4;
        Wed, 10 Oct 2018 06:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xo81FGVxUpGzKKvCPBbOO7/8bRD39uGZQLZ6C5DXp0Y=;
        b=rKXSfycMbyp7o0hsaAuB5w7GZJfXf8iyMcmNxYJ3OrGGJqJsyk8E9CForTN6DTrk2X
         oT74D3G+tzxoW05IwribmKfiLgYJox3ZKmPR0awcIlZ+SgcEJ6+QGnrlGxXixC2znOtm
         WVLrdUKa+6tqPA45KhlFjtZTfjbURyTT3xhHqKvJ+lEbKmORHrOW8mSaiS59/XL8tPS8
         wEYErT5CfZo8V/n5rA2DcDrCoEkhJTmgLN3qtPxdxGgzVF1U1w0je+fQOpQw6Fscz9wL
         Wy3CxurqFbrteuIO0kKZ3uj7xAF2ELafSsDqk1G9mwrJmp6oKs+TOlfjrTIfjuBKYDy6
         2oFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xo81FGVxUpGzKKvCPBbOO7/8bRD39uGZQLZ6C5DXp0Y=;
        b=M/fXNrTbcCvHllTDktRFcGll4C8ZMcoeF5RLURNiGgcIInKAZdy5OVs9vu6enKNumT
         WZRwLbVg5z2K/3Ar1bVwdUPQKnlPHPqWDast1ID2Hiz52uoOyDzNxq+jUYmHc2x3Fm6V
         nbO5iezFjVEnhQts3MzwMgw6vDv37OVl5gk5rrnZfdRAhvn9PUNN+qJyxKeBMvPqmKUe
         BkZZ3RVvQ7V9y6mB3GFc7Wi2u5yI/kit2bBu/QqUKlWwsGWimxfIXsABiKqgHzCWSUFu
         /OS8yX4R0kNTVhBz1s7xpSwufuvZGlvLh0QZAtmPM4BDda9UEetBQ5lp0QWtL8eJw0/S
         W82Q==
X-Gm-Message-State: ABuFfoiU232j80O+3H2ridFhoHZZkjpFcdXeLKSDcxKjw+u1qVfkJUYe
        FxILdqkEJuNmEzb4h5QIbaA=
X-Google-Smtp-Source: ACcGV60iP78RxTNxH1xu3fomG2TpAzKZB0EDk7I7gs97yhf7kkMLSJAuSwo5ImfNeTIK8xjNyqm5Gg==
X-Received: by 2002:a1c:4d0b:: with SMTP id o11-v6mr884491wmh.94.1539176784357;
        Wed, 10 Oct 2018 06:06:24 -0700 (PDT)
Received: from [172.16.1.10] (host-89-243-172-161.as13285.net. [89.243.172.161])
        by smtp.gmail.com with ESMTPSA id c184-v6sm13464308wma.15.2018.10.10.06.06.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 06:06:23 -0700 (PDT)
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE
 [ver #12]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
References: <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com>
 <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
 <15751.1539176549@warthog.procyon.org.uk>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <63c8d073-8309-82cf-6089-ef805feb9fae@gmail.com>
Date:   Wed, 10 Oct 2018 14:06:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <15751.1539176549@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2018 14:02, David Howells wrote:
> The attached change seems to fix the lazy-umount problem.
>
> David
> ---
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 5adeeea2a4d9..d43f0fa152e9 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2472,7 +2472,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
>   	if (old->mnt_ns && !attached)
>   		goto out1;
>   
> -	if (old->mnt.mnt_flags & MNT_LOCKED)
> +	if (old->mnt.mnt_flags & (MNT_LOCKED | MNT_UMOUNT))
>   		goto out1;
>   
>   	if (old_path->dentry != old_path->mnt->mnt_root)


I can't test any more at the moment, as my laptop died today :). But I 
have no objection to this.

It would be more fun if there was a way to support it :), but I don't 
have a genuine reason to want it.  And you couldn't use it for fully 
general purposes anyway, because umount2( , MNT_DETACH) is defined as 
separating all the child mounts.

P.S. Regarding the issue with the namespace loop.  My strawman solution 
would be for graft_tree() to silently detach any NS file mounts that 
have a sequence number less than or equal to the namespace they are 
being mounted into.
