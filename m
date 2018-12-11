Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFAEC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807F620855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bh6xBfR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807F620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeLKPUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:20:03 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37907 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeLKPUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:20:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so13304563lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 07:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fn+scbFlNULxssk/BYGcNz4FdZbdJsSXnSN7/gzjQ+Y=;
        b=Bh6xBfR4TXRufpusiKEfEc1OxDh2WvWaFp51ROKa+ontw7KElBf6QHa+2bd37mWyXe
         vKMXejJr13JfpTm8glAKRBbBnHQzQWctBbNjC4b3qIl4vYlJMpLl9kANN/9RNYnXY9bU
         G/xYXNXYqlTRtfGS87TswQ4/xlNrlhEngv4gXYyFuOjxpLW2EymxbowIZLfyeUwdiygR
         eVxbLFsAJDpNErecKZ0rOO2DV5ecYqVVT82mfqUXgAY52jlsKXrbw3uaUwGCC18NBk4L
         VV6TSX9yAFRF+w24AqdLc7BJRykMAu20f4vmz3UvEtx7WyzRwMOMY7qsgnFN2/4LiZCu
         fOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fn+scbFlNULxssk/BYGcNz4FdZbdJsSXnSN7/gzjQ+Y=;
        b=UZjiV/+CEHai5ODDVINxfx6OH79y5X9/UEq8tkXAF0fOOQoXNUnf2nivbg6nA4P/4v
         VPysy6aJK7IQl55yq6ek8ztj72NwBp2URlXjQhTn01LlpZgV8ascjHJW50u+aCOSiPdI
         p1nIXX2jXa/3Ysf+2SoFyq6rtrXFMks3poFogO3SzLs6gJx35iEFlHgJmP3gPMvLcAAP
         /1IId6h8CgOP3586L1VEvFL81JR4ReeJQpygfBUaXBsXjliJowWCSZSDtj0jN9rMhtxn
         q1BYdvsN8RVW+wmYOJRykRbXdP2mEeC9sfhdFHaRT3tqhYuJ9Ud4aaUN1X7QZYzoohMb
         CYeA==
X-Gm-Message-State: AA+aEWaOJSBp8suiWLAQtg9RX7l6O3iEnTjyYJ5ut12EyGA64SHK2aUq
        xOdATSgQyMYqE+bCTX9FMhA=
X-Google-Smtp-Source: AFSGD/Xbpp6Zcw2ou4ywfFygZsk9/5AuSKgHfbysVd6h3+rImGLtctYiYU+cY/T7kwRABHGvrf0few==
X-Received: by 2002:a2e:8ec8:: with SMTP id e8-v6mr10119658ljl.162.1544541599739;
        Tue, 11 Dec 2018 07:19:59 -0800 (PST)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id g17sm2691224lfg.78.2018.12.11.07.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 07:19:58 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 9B09E460AA3; Tue, 11 Dec 2018 18:19:57 +0300 (MSK)
Date:   Tue, 11 Dec 2018 18:19:57 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gorcunov@virtuozzo.com
Subject: Re: [PATCH v3] ksm: React on changing "sleep_millisecs" parameter
 faster
Message-ID: <20181211151957.GJ2342@uranus.lan>
References: <2dd9cc7b-9384-df11-bb5a-3aed45cc914b@virtuozzo.com>
 <154454107680.3258.3558002210423531566.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154454107680.3258.3558002210423531566.stgit@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 06:11:25PM +0300, Kirill Tkhai wrote:
> ksm thread unconditionally sleeps in ksm_scan_thread()
> after each iteration:
> 
> 	schedule_timeout_interruptible(
> 		msecs_to_jiffies(ksm_thread_sleep_millisecs))
> 
> The timeout is configured in /sys/kernel/mm/ksm/sleep_millisecs.
> 
> In case of user writes a big value by a mistake, and the thread
> enters into schedule_timeout_interruptible(), it's not possible
> to cancel the sleep by writing a new smaler value; the thread
> is just sleeping till timeout expires.
> 
> The patch fixes the problem by waking the thread each time
> after the value is updated.
> 
> This also may be useful for debug purposes; and also for userspace
> daemons, which change sleep_millisecs value in dependence of
> system load.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> 
> v3: Do not use mutex: to acquire it may take much time in case long
>     list of ksm'able mm and pages.
> v2: Use wait_event_interruptible_timeout() instead of unconditional
>     schedule_timeout().
Looks ok to me, thanks!

Acked-by: Cyrill Gorcunov <gorcunov@gmail.com>
