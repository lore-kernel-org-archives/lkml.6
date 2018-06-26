Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E32C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BB226AE7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BB226AE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965237AbeFZNID (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:08:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37934 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933478AbeFZNIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:08:02 -0400
Received: from mail-wr0-f200.google.com ([209.85.128.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1fXnhR-0000jw-6r
        for linux-kernel@vger.kernel.org; Tue, 26 Jun 2018 13:08:01 +0000
Received: by mail-wr0-f200.google.com with SMTP id g6-v6so11352367wrp.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 06:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cJH8LUDlyyta2zXRvI4QKllDYFJEXmLo5RuBxl8TRPM=;
        b=gytd5ulSOzoYW4MSBX4UNxx+DvqU3KI5HrSUuzYWi4S+8xNA2jLon2+qJZ6X4czQ85
         cSYBpoAFKvznQkmTj0WXe+OJEoVfSp+RfcvPUXBCK0B5m8krpenPBuIDFUTN/lG48Yyq
         KM8GlvtOrICUbwR84Vp0wO7IgndX2YLeuUtXmfQPpbIIlzEGm2JeDQCYo27t2daQxoHa
         PIqUCoCLZ4q3NNjN9DqfMWhaWWcudzsgvbmEsoy6bTcWvqMXhUPe7S5bGMlUUVQQ7d55
         FH270BxP2RM8DfzayQSDL+x05iGO/nMNbFaxTpP0+8yvQgsTDW3BZHBw4uf7Qd7ilgQe
         vISw==
X-Gm-Message-State: APt69E2ukRr+pssamHTjDsBYjJBrzBjcA3pWSKxtv3V/Yn42idMWz15P
        yu7RLD+HsZMm32MUIHZvmxSxWhAMGQuiEGOtNEIvmUdKTtya9RwKzaAACOpMtNKpcz1bG1rnrzx
        1u3Kr2OziBTN4E5Q8GSAHUTRNi0aoavpMLIjozx49rA==
X-Received: by 2002:adf:8f23:: with SMTP id p32-v6mr1444735wrb.193.1530018480811;
        Tue, 26 Jun 2018 06:08:00 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpcTN6U4kVBR/RzrP0avlPh3Im/vUGbWpkUhYHCqe68FifyhqfejM5eRmTBH+cIyNtq5ZuHtlw==
X-Received: by 2002:adf:8f23:: with SMTP id p32-v6mr1444713wrb.193.1530018480481;
        Tue, 26 Jun 2018 06:08:00 -0700 (PDT)
Received: from gmail.com (u-087-c160.eap.uni-tuebingen.de. [134.2.87.160])
        by smtp.gmail.com with ESMTPSA id b15-v6sm2130011wri.14.2018.06.26.06.07.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 06:07:59 -0700 (PDT)
From:   Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian@brauner.io>
Date:   Tue, 26 Jun 2018 15:07:58 +0200
To:     Jann Horn <jannh@google.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, security@kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH] userns: move user access out of the mutex
Message-ID: <20180626130757.GA10042@gmail.com>
References: <20180625163419.216578-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180625163419.216578-1-jannh@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 06:34:19PM +0200, Jann Horn wrote:
> The old code would hold the userns_state_mutex indefinitely if
> memdup_user_nul stalled due to e.g. a userfault region. Prevent that by
> moving the memdup_user_nul in front of the mutex_lock().
> 
> Note: This changes the error precedence of invalid buf/count/*ppos vs
> map already written / capabilities missing.
> 
> Fixes: 22d917d80e84 ("userns: Rework the user_namespace adding uid/gid...")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  kernel/user_namespace.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index c3d7583fcd21..e5222b5fb4fe 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -859,7 +859,16 @@ static ssize_t map_write(struct file *file, const char __user *buf,
>  	unsigned idx;
>  	struct uid_gid_extent extent;
>  	char *kbuf = NULL, *pos, *next_line;
> -	ssize_t ret = -EINVAL;
> +	ssize_t ret;
> +
> +	/* Only allow < page size writes at the beginning of the file */
> +	if ((*ppos != 0) || (count >= PAGE_SIZE))
> +		return -EINVAL;
> +
> +	/* Slurp in the user data */
> +	kbuf = memdup_user_nul(buf, count);
> +	if (IS_ERR(kbuf))
> +		return PTR_ERR(kbuf);

I'm not opposed to this but what is annoying is the changed error
reporting you pointed out. It seems conceptually way cleaner if missing
permissions are reported before more specific internal errors.

The question I have is how bad it would be if memdup_user_nul() stalled
and if you see any issues security wise. Given that the mutex is only
taken on operations that are mostly performed when creating or setting
up a new user namespace

map_write()
create_user_ns()
proc_setgroups_write()
userns_may_setgroups()

and not when actually interacting with it it seems the worst that
happens is that creation of new user namespaces is not possible anymore.
That shouldn't have any effect on the host though which I would see as a
real issue. But I might be missing context. :)

Christian

>  
>  	/*
>  	 * The userns_state_mutex serializes all writes to any given map.
> @@ -895,19 +904,6 @@ static ssize_t map_write(struct file *file, const char __user *buf,
>  	if (cap_valid(cap_setid) && !file_ns_capable(file, ns, CAP_SYS_ADMIN))
>  		goto out;
>  
> -	/* Only allow < page size writes at the beginning of the file */
> -	ret = -EINVAL;
> -	if ((*ppos != 0) || (count >= PAGE_SIZE))
> -		goto out;
> -
> -	/* Slurp in the user data */
> -	kbuf = memdup_user_nul(buf, count);
> -	if (IS_ERR(kbuf)) {
> -		ret = PTR_ERR(kbuf);
> -		kbuf = NULL;
> -		goto out;
> -	}
> -
>  	/* Parse the user data */
>  	ret = -EINVAL;
>  	pos = kbuf;
> -- 
> 2.18.0.rc2.346.g013aa6912e-goog
> 
