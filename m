Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4E3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B8120693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="t+YHct+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B8120693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbeGREbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 00:31:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40337 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725727AbeGREbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 00:31:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id z13-v6so1281041wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 20:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=T0hRs3odEa1sGTzdaY0fJdg+PAEQE0HrzTZ3Johd9GA=;
        b=t+YHct+G/5hDMKmBZXEOaNBpbpeme7fBRvOFmHb5daGhGCm6BKmnXFZgoiXPgpEeIY
         Gd2nEOfwX5sSPYZwsXpytR1KC5apJur2XjiQ7Tk66/ooOQWJ0kEIUaRSL9+1bOmeJc9M
         aEbNKIAdxYBnGOHt1p9YX0h2jh33fv7BAERWLypq0MG1hIGCzatMSfAuama7g3j1tZO0
         8PXxbqGlkiW8gb28u6gYnyrSw8vOj2zJMaq3xvUo6mcgV1qXSuIiTjM+mkFoDqvIiTJe
         Xaa1O5q0TRWPebDlch4F0S8jhTNNi18F2kOsE92QeXxEY86HBUscpN2A1lOeUNadaDdi
         XXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=T0hRs3odEa1sGTzdaY0fJdg+PAEQE0HrzTZ3Johd9GA=;
        b=MbRUbFnQgZm5/s8TT3qicGOMfQ8DwF5SKn/yc5avBcpNL1aFY+oqWWfYWSehywhUNN
         Zay3DoNjrJQ0dJTtVqvKunHx3wJ2+0M78f51wHjkeqlidUnZkQ7cbmpGzQbC+cGVqmGM
         vxtgQvgxtdRfrI80x/LAc+8hpa0Iu0qHWM82s1DqFmSvX9/B0hz2OrXAVEGYWeRL3HCm
         6YF4V/RKKu/bS8x7Fpqrp8hr7EctF8TkMpqgH5mzGatdP2AZn9+ha1XVQ2nmBJXOngLb
         M3L7WmUaUwmbLvEop4WqWnR1kpyak56uLyym32pgX5FE7hgCVQvCowc0Zknxb6hfKD6j
         jYGg==
X-Gm-Message-State: AOUpUlHgStFMHiqb+1jVJjAgW+WlxCjXUxbojRC5QC/NyXbZDUz6VXAN
        3YWA8ejQ/6xUEKraMQ5uEQ4rig==
X-Google-Smtp-Source: AAOMgpdhy0aWeP8z5GDWisAdmLycpgzTcMnLgMhgqHeFutlVqDwTP/C5EpXjRMj7lz6tt5E0eWfdpQ==
X-Received: by 2002:a1c:af53:: with SMTP id y80-v6mr391296wme.55.1531886114016;
        Tue, 17 Jul 2018 20:55:14 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C91300048EB295EB0D2EF5.dip0.t-ipconnect.de. [2003:d9:93c9:1300:48e:b295:eb0d:2ef5])
        by smtp.googlemail.com with ESMTPSA id w9-v6sm6631957wrk.28.2018.07.17.20.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 20:55:12 -0700 (PDT)
Subject: Re: [PATCH -next] ipc/sem: prevent queue.status tearing in semop
To:     Davidlohr Bueso <dave@stgolabs.net>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
References: <20180717052654.676-1-dave@stgolabs.net>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <7909e12b-6dd7-e28a-010c-003545a8e4b5@colorfullife.com>
Date:   Wed, 18 Jul 2018 05:55:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180717052654.676-1-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Davidlohr,

On 07/17/2018 07:26 AM, Davidlohr Bueso wrote:
> In order for load/store tearing to work, _all_ accesses to
> the variable in question need to be done around READ and
> WRITE_ONCE() macros. Ensure everyone does so for q->status
> variable for semtimedop().
What is the background of the above rule?

sma->use_global_lock is sometimes used with smp_load_acquire(), 
sometimes without.
So far, I assumed that this is safe.

The same applies for nf_conntrack_locks_all, in nf_conntrack_all_lock()
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>   ipc/sem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ipc/sem.c b/ipc/sem.c
> index 6cbbf34a44ac..ccab4e51d351 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -2125,7 +2125,7 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
>   	}
>   
>   	do {
> -		queue.status = -EINTR;
> +		WRITE_ONCE(queue.status, -EINTR);
>   		queue.sleeper = current;
>   
>   		__set_current_state(TASK_INTERRUPTIBLE);


