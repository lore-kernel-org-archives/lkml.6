Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C50C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8E42147A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550486853;
	bh=SP74pSR2WXcfY2R64lXSZRkKL70o8xEOEG3bTFz4noU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yt9VdD5ltb5ubRMxsLmKpJGJRBhQSOIUuyDUwsuG/WT9s+ltFIa+etQioRrPHgeTQ
	 Hjioorr1+St8tVf/oVsQs1PCo6CwURGNkaeEnyhb9mSuTeDCR+KRydcpu0T3yRQzxq
	 EnGmk0Em6xCGp4VN7j20r27er+IxG7Q9qqOcwbyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbfBRKrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:47:32 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40153 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbfBRKrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:47:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id h1so8364718pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 02:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=C5GbvVFIVg97XioJPDlPOI1anGzy2w+IqWN8b4+VrMc=;
        b=ad2Bg3/52cekWVUyCUDtgIXxJyRlvipR9woEtuEKThXVZZROgWE51KmNGZx66k0tal
         OY7KbMsGo38HkqCOtqHw7YelMS5DnYQ/8si3Sx8oIWwerAIHkUNJbfTQGI8f/vkkt+1y
         bwfYW3ncDTJoNaAMIc8ZUKAdvhkbW2D1bghjqTYPraS5gSNmmCJ+SVtVvR7j2aPTYceY
         0tOXqAJMVogCLoOPnFXH8RniZDyYAVAmoBRZSBPkkmzMtQON9HAuB9fUmRd4WJBZsAwg
         /JfHpoqEJGeoGy+yzOiB2T5FzGyzlsSrQDO269eGYMkXOlY53dzifwm5jtk0uMZIJLal
         hYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=C5GbvVFIVg97XioJPDlPOI1anGzy2w+IqWN8b4+VrMc=;
        b=UwzDIrekw4SYN1an76nOKudXvbrydFRyP0vs5aHtIbe8P9SdBUAwpaf6L4BF/4lfwC
         J5WUkr8oS/+gPxx5M40ne7jlu9F55JFL6HI0M6vl7BrQEnMz6B9lT3VDZCqwF+rO/ptI
         QqNDZ/W56KIUurBkgmPRkkOGW5q+bVTK7NpILJwx6Yu0i1vNKsjo5WVKMGQg3VuOrpCX
         1CEEXhJigwNGgX/1Ab3j9YKXtRYPEMEYUZz20QfpbEMkVwjWJqgYYXXNvjKL+yO2ggWW
         wlfOH5pFQaU5uHcG8Mti26QAR3k65H33sHtCKxKvAu8hBISB7lgqx4djYm3i5/gf1H6j
         clFQ==
X-Gm-Message-State: AHQUAuZzu04NPM1+9kursKEBRfaPOE1JOR600PND48BckpZr+cTHYr9Z
        vvmXZzd0PLEc/MZxSZwmRbcYaxaZ
X-Google-Smtp-Source: AHgI3IYIVeDAtGi6u+93cnNKAR/vWs5JzVyZq0HUoGPZov8zz4Sh+QRxtIVs2kZE4vQdJnXIqY30oA==
X-Received: by 2002:a63:65c7:: with SMTP id z190mr18232408pgb.249.1550486850688;
        Mon, 18 Feb 2019 02:47:30 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id 145sm2897876pgb.66.2019.02.18.02.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 02:47:29 -0800 (PST)
Date:   Mon, 18 Feb 2019 19:47:25 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
        Martijn Coenen <maco@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Subject: Re: [PATCH] binder: reduce mmap_sem write-side lock
Message-ID: <20190218104725.GA160999@google.com>
References: <20190218081145.86633-1-minchan@kernel.org>
 <20190218083208.GA20069@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190218083208.GA20069@kroah.com>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 09:32:08AM +0100, Greg KH wrote:
> On Mon, Feb 18, 2019 at 05:11:45PM +0900, Minchan Kim wrote:
> > binder has used write-side mmap_sem semaphore to release memory
> > mapped at address space of the process. However, right lock to
> > release pages is down_read, not down_write because page table lock
> > already protects the race for parallel freeing.
> > 
> > Please do not use mmap_sem write-side lock which is well known
> > contented lock.
> > 
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Martijn Coenen <maco@android.com>
> > Cc: Arve Hjønnevåg <arve@android.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  drivers/android/binder_alloc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Is this just needed for the recent binder changes that are in
> linux-next, or for older kernels as well?

It has been there for several years but no need to fix older kernels
because down_write of mmap_sem is technically not a bug to stop the
working of binder. Rather than, it's just abuse of the lock so
it's okay to fix only recent kernel.

Thanks.
