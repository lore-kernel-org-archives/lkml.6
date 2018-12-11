Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D450BC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98ED220849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPOpWLnc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98ED220849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbeLKMe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:34:59 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35625 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeLKMe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:34:59 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so12826845ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 04:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JLP/jVOfJWUzYaxcfAAo52I1nAx/30ZeEC3HeKJcBWo=;
        b=lPOpWLncAx00ZEf+nhM+8TfNwnijNp4B7BFNNz17wmKCwi/ljB52y87GVhe1TlPqf8
         PBnZ5HVEjr26cf8vwVawe/mobfYJRMHm3SDFCbTgqOGlYrGTB/dSmbtBGapgt1NfjVIb
         G0F8fWxbVuvrea1rlZ1Zg0hDI4wyiLjyf5pGaVHf0s8GHS0DIs1YmB7Ni7x0YJqyLThB
         6K6QBUgtur3T3R8Bkt50JG/HZKRyzdDA0UC9mKdqb1qyd/gsqJB8kp7t7wzAg8SYL4MB
         shzw4RQWWn9B/ahkQiHVOJClja1lL/PgnfwCFZl3QXDnOYRa1NVH0SOLsAvaP23xBgOD
         o93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JLP/jVOfJWUzYaxcfAAo52I1nAx/30ZeEC3HeKJcBWo=;
        b=I7ifu1LpRa6IJcD0OmN0+6RhBikyURr30RsHxRHX1lQ91RZjsFwu/YkBHcxxb2o3QE
         Fixu+a6GZrLC80ympaGxOPlz7DmwQK15b9WX8nkxDWpSbMGCqZWt0oCIiigYgY5SefHN
         I1YH2OdxYErB7XOj6jlxUEq2f+WIPSwVbnzwlaIEKc679aUMEM312XL41Fi0WYUzo/w7
         oF+soFBivFLmBvImrgTjTqH2F8SJNJf76dW8JKVtd/x4jO4OWTRsBJxUBeLIrGPiK4za
         0wmHAT6TdaXALLgjMsIo3+SfWPLNjPxXebUAdQcHZtVqc60pGixryhATZYXtrZns+BBj
         FuGQ==
X-Gm-Message-State: AA+aEWZhOd41n7u+hERYdhw3siHHjkwzR+Pu1ba7tVaa8Z8vv5sn29ZU
        omYStAjKI5OUZjIfJl6enMw=
X-Google-Smtp-Source: AFSGD/W8X+ywgvsaSdUwX+RZZ9zKd3dcg4KbVsE83COvgpK1ZCDwNB5HVeaaVjypGjfW5H3rKi8bhg==
X-Received: by 2002:a2e:5703:: with SMTP id l3-v6mr10563222ljb.106.1544531697010;
        Tue, 11 Dec 2018 04:34:57 -0800 (PST)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id l21-v6sm2635813lji.6.2018.12.11.04.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 04:34:56 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id CDCC8460AA3; Tue, 11 Dec 2018 15:34:55 +0300 (MSK)
Date:   Tue, 11 Dec 2018 15:34:55 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gorcunov@virtuozzo.com
Subject: Re: [PATCH v2] ksm: React on changing "sleep_millisecs" parameter
 faster
Message-ID: <20181211123455.GI2342@uranus.lan>
References: <20181211100346.GE2342@uranus.lan>
 <154452399396.4921.3418365102240528000.stgit@localhost.localdomain>
 <20181211111300.GF2342@uranus.lan>
 <26fb047f-9164-96ae-a6cd-7a7efa41d43b@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26fb047f-9164-96ae-a6cd-7a7efa41d43b@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 03:22:42PM +0300, Kirill Tkhai wrote:
> On 11.12.2018 14:13, Cyrill Gorcunov wrote:
> > On Tue, Dec 11, 2018 at 01:26:59PM +0300, Kirill Tkhai wrote:
> >> ksm thread unconditionally sleeps in ksm_scan_thread()
> >> after each iteration:
> >>
> >> 	schedule_timeout_interruptible(
> >> 		msecs_to_jiffies(ksm_thread_sleep_millisecs))
> >>
> >> The timeout is configured in /sys/kernel/mm/ksm/sleep_millisecs.
> >>
> >> In case of user writes a big value by a mistake, and the thread
> >> enters into schedule_timeout_interruptible(), it's not possible
> >> to cancel the sleep by writing a new smaler value; the thread
> >> is just sleeping till timeout expires.
> >>
> >> The patch fixes the problem by waking the thread each time
> >> after the value is updated.
> >>
> >> This also may be useful for debug purposes; and also for userspace
> >> daemons, which change sleep_millisecs value in dependence of
> >> system load.
> >>
> >> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> >>
> >> v2: Use wait_event_interruptible_timeout() instead of unconditional
> >>     schedule_timeout().
> > ...
> >> @@ -2844,7 +2849,10 @@ static ssize_t sleep_millisecs_store(struct kobject *kobj,
> >>  	if (err || msecs > UINT_MAX)
> >>  		return -EINVAL;
> >>  
> >> +	mutex_lock(&ksm_thread_mutex);
> >>  	ksm_thread_sleep_millisecs = msecs;
> >> +	mutex_unlock(&ksm_thread_mutex);
> >> +	wake_up_interruptible(&ksm_iter_wait);
> > 
> > Btw, just thought -- if we start using this mutex here don't we
> > open a window for force attack on the thread self execution,
> > iow if there gonna be a million of writers do we have a guarantee
> > thread ksm_scan_thread will grab the mutex earlier than writers
> > (or somewhere inbetween)?
> 
> This file is permitted for global root only. I don't think there is
> a problem.
> 
> If someone wants to make ksm helpless, a person may just write a big
> "sleep_millisecs" value. KSM thread won't be executed almost all the time
> in this case.

True. Still I think if we can leave without taking a lock it a rule of thumb.
Something like

	if (msecs != ksm_thread_sleep_millisecs)
		wake_up_interruptable(&ksm_iter_wait);

Thoughts?
