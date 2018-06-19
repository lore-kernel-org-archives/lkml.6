Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793DBC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3362075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0+Wyvln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3362075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967182AbeFSROu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:14:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51827 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966552AbeFSROr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:14:47 -0400
Received: by mail-wm0-f66.google.com with SMTP id r15-v6so1617446wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GIABXCV2oTEXKKeNsQf9F0+ihTB/hgRXxAR/6uRmAAg=;
        b=J0+Wyvlnf5S67mGFg2PddD33carRw4zOQdfq++dJOpPCk5M+pUH1vSBLEDX+nIn7J1
         aH5jSi5yWnNN5hjAJJuaQEwZR8FDzcsYfiPj+CMhvk/fFzIQy90rgOSWmKEbvn+RM00v
         Y8zB/Ao3SdPL2Bb758d+OGxwTIf1ugzxV51HAA+H3RYNlJLBPmdRf4gyznASGCFKjLu5
         SWyxeISYZMFWDCsjfBASaRjp41dJND+cCLBmWGCRuGVovoCEMMhKNEBVsnCTL9Jixm1t
         G89P2c+31JwOhQYiIpg49mcjBf3LskKea8r3q6nzE4fLzUEUzsJhStQdF6RIpiZun902
         nPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GIABXCV2oTEXKKeNsQf9F0+ihTB/hgRXxAR/6uRmAAg=;
        b=kPiu2lUceG3Z+HKiXlG1ZJiPtx6ZYaWyubtIgl8fOqYtm1AVEvFdOBNtNK1BX1GyYX
         6IeP5PuRTiHFfY/Lk8e/TPd4RaOWoMHidTgEudbQ57/rKkJynHe/LiUDWoWRo5BlVxSe
         FrFOjzQD32pYtLbYgLmZ/rbzEyZD2arvK4F2UPbQI2VXyabGd0NFrYvYD8ed5VHyT4oo
         svX1Mwk0zUcpINFJ3LEbrvj/Pdfjlt+13lSNo8nGPViHaeLfBPyOfpMrX8yxhxIrv33F
         o3+hxmRnv08Oj4a0vHmAewKx5XEiMFbRQVrEjnD6WQ/PoKuLI9cxcDl/ubkpA10Av7Mu
         QxsA==
X-Gm-Message-State: APt69E0Pch9fX2CLhN1szVMDYeLoZlL2Fn98GqOWWqSwoVNJ2dK8PI5I
        BfCTxRyJiJ0VbPcEJcFM7CDY
X-Google-Smtp-Source: ADUXVKI86OBgvPXbmEIgf1A4F5o0OyJcDzNnXB21iZ7K+4OfOqnXYrwy8LMJaTA99F3O+QfbeZbEOA==
X-Received: by 2002:a1c:8bc3:: with SMTP id n186-v6mr12205485wmd.34.1529428486345;
        Tue, 19 Jun 2018 10:14:46 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id i10-v6sm765370wmf.4.2018.06.19.10.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 10:14:45 -0700 (PDT)
Date:   Tue, 19 Jun 2018 20:14:42 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] proc: add missing '\0' back to /proc/$pid/cmdline
Message-ID: <20180619171442.GA2133@avx2>
References: <20180619162411.B2B7AA1081@unicorn.suse.cz>
 <20180619163109.5245BA1081@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180619163109.5245BA1081@unicorn.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 06:28:40PM +0200, Michal Kubecek wrote:
> Recent rewrite introduced a regression, /proc/$pid/cmdline is missing the
> trailing null character:
> 
> mike@lion:/tmp> cat /proc/self/cmdline | od -t c
> 0000000   c   a   t  \0   /   p   r   o   c   /   s   e   l   f   /   c
> 0000020   m   d   l   i   n   e
> 0000026
> 
> This is because strnlen() is used to search for the null character but it
> returns the length without it so that we need to copy one byte more (but
> only if we actually found a null character). And once we pass the null
> character to userspace we need to make sure next read returns 0 (EOF).
> 
> This is another problem, even if rather theoretical one: if userspace seeks
> to arg_end or past it, we only start checking for null character from that
> position so that we may return random segment of environment rather then
> EOF.
> 
> Resolve both by always starting no later than at arg_end-1 (so that we
> always catch the right null character) but don't copy data until we reach
> the requested start position.

See what's happening?

Code was made allegedly simpler by removing special case for "c == '\0'"
but that didn't work and now you're adding complexity back with another
variable and branches.

> Fixes: 5ab827189965 ("fs/proc: simplify and clarify get_mm_cmdline() function")

> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -209,7 +209,8 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
>  			      size_t count, loff_t *ppos)
>  {
>  	unsigned long arg_start, arg_end, env_start, env_end;
> -	unsigned long pos, len;
> +	unsigned long req_pos, pos, len;
> +	bool end_found = false;
>  	char *page;
>  
>  	/* Check if process spawned far enough to have cmdline. */
> @@ -236,25 +237,27 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
>  		env_start = env_end = arg_end;
>  
>  	/* We're not going to care if "*ppos" has high bits set */
> -	pos = arg_start + *ppos;
> +	req_pos = arg_start + *ppos;
>  
>  	/* .. but we do check the result is in the proper range */
> -	if (pos < arg_start || pos >= env_end)
> +	if (req_pos < arg_start || req_pos >= env_end)
>  		return 0;
>  
>  	/* .. and we never go past env_end */
> -	if (env_end - pos < count)
> -		count = env_end - pos;
> +	if (env_end - req_pos < count)
> +		count = env_end - req_pos;
>  
> +	pos = min_t(unsigned long, req_pos, arg_end - 1);
>  	page = (char *)__get_free_page(GFP_KERNEL);
>  	if (!page)
>  		return -ENOMEM;
>  
>  	len = 0;
> -	while (count) {
> +	while (count && !end_found) {
>  		int got;
> -		size_t size = min_t(size_t, PAGE_SIZE, count);
> +		size_t size = count + (pos < req_pos ? req_pos - pos : 0);
>  
> +		size = min_t(size_t, PAGE_SIZE, size);
>  		got = access_remote_vm(mm, pos, page, size, FOLL_ANON);
>  		if (got <= 0)
>  			break;
> @@ -276,12 +279,26 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
>  				n = arg_end - pos - 1;
>  
>  			/* Cut off at first NUL after 'n' */
> -			got = n + strnlen(page+n, got-n);
> +			n += strnlen(page + n, got - n);
> +			got = min_t(int, got, n + 1);
> +			end_found = !page[n];
>  			if (!got)
>  				break;
>  		}
>  
> -		got -= copy_to_user(buf, page, got);
> +		if (pos + got <= req_pos) {
> +			/* got > 0 here so that pos always advances */
> +			pos += got;
> +			continue;
> +		}
> +
> +		if (pos < req_pos) {
> +			got -= (req_pos - pos);
> +			got -= copy_to_user(buf, page + req_pos - pos, got);
> +			pos = req_pos;
> +		} else {
> +			got -= copy_to_user(buf, page, got);
> +		}
>  		if (unlikely(!got)) {
>  			if (!len)
>  				len = -EFAULT;
