Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D916C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1148D20645
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="1JzLTG6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1148D20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeIIBXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 21:23:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41727 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbeIIBXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 21:23:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id s15-v6so8576744pgv.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 13:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f9QE5Op2sxQPtdyoUwLTbkThRRP0odgRbRy4vVZ3GdE=;
        b=1JzLTG6AI8K/3DmjdyIz19ChK8I5wegv2w3xkYj0CUBkcTfMEoL7wGkLqFflLJlPHi
         qQ2Onup2nAWhFduozifE0x0jnA1EFgCRXn3BtHUul14YQtlvbTuVstU4a6TQq9d+C4ku
         LmoC+NZf9vjXuowusqCBX8zskieg4GMje33YyEKuVRHKix2AQCLiWvgEY/ESPvlwGYYW
         PFqsMZ3Lo398qfjv8h7NTl2B7BkAs3TDC6TvkKlS0oUIYFjsO/+uZM3/bUkYhhvv/up3
         fhM04w+qGveKmSrHFCgxJXm4TTxEbHwq6ZwoHkzas/CuJ7v9LvkXrFCdVyBf9FKxURif
         Hj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f9QE5Op2sxQPtdyoUwLTbkThRRP0odgRbRy4vVZ3GdE=;
        b=AFX9ecKV5EhG3j6u6tRpKG53F+NapMsN0K28GWvVwtZmRC/oCGZupW0ZcMsbYUn/a0
         uscFqRHlAWvVBURrfOEhtjgqlpTRbGKhhW6KlBPhZNK2WMt9NQNjuO+LOVsQFKIxO/+g
         YBGgMQiDJArM/aLoTqONjPSk8trjC1ru79Qz9WQwv9GBrntYOp3kdUZQrUDDeIuWrudX
         fUA6hfWXsQ+ZFbAHx8HHqM5YlZmS6IX5HugY90vUa4oMgANBLYh1+obQm0VPiHWcB/a+
         7W2c8GnD4aBuQAKBBlUdizNYoYyfQPxm4RUvXLg5oq0d/tFF91mI85BEtCa0h6Xsr13Q
         t7PQ==
X-Gm-Message-State: APzg51Auw4fMSw1Au25zaDSeRHsEgqlTrKl53JTPeW643zIEBFJTfhAB
        yF5P3vzAZnD64bub6LyJruRNNw==
X-Google-Smtp-Source: ANB0VdZTEQwkkBj9owpDMJMafsXhO27SHjDmwn6aS5g52RyFzgUlDWDt1IzdqQYbCXUEolCeiy1Qtw==
X-Received: by 2002:a62:d94:: with SMTP id 20-v6mr15429276pfn.202.1536438968594;
        Sat, 08 Sep 2018 13:36:08 -0700 (PDT)
Received: from cisco.cisco.com ([172.56.30.142])
        by smtp.gmail.com with ESMTPSA id 6-v6sm20569207pfs.58.2018.09.08.13.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Sep 2018 13:36:07 -0700 (PDT)
Date:   Sat, 8 Sep 2018 14:35:56 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Tyler Hicks <tyhicks@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v6 1/5] seccomp: add a return code to trap to userspace
Message-ID: <20180908203556.GF3444@cisco.cisco.com>
References: <20180906152859.7810-1-tycho@tycho.ws>
 <20180906152859.7810-2-tycho@tycho.ws>
 <20180906221412.GA26209@sec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906221412.GA26209@sec>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 10:15:12PM +0000, Tyler Hicks wrote:
> On 2018-09-06 09:28:55, Tycho Andersen wrote:
> >  /**
> >   * struct seccomp_filter - container for seccomp BPF programs
> >   *
> > @@ -66,6 +114,30 @@ struct seccomp_filter {
> >  	bool log;
> >  	struct seccomp_filter *prev;
> >  	struct bpf_prog *prog;
> > +
> > +#ifdef CONFIG_SECCOMP_USER_NOTIFICATION
> > +	/*
> > +	 * A semaphore that users of this notification can wait on for
> > +	 * changes. Actual reads and writes are still controlled with
> > +	 * filter->notify_lock.
> > +	 */
> > +	struct semaphore request;
> > +
> > +	/* A lock for all notification-related accesses. */
> > +	struct mutex notify_lock;
> > +
> > +	/* Is there currently an attached listener? */
> > +	bool has_listener;
> > +
> > +	/* The id of the next request. */
> > +	u64 next_id;
> > +
> > +	/* A list of struct seccomp_knotif elements. */
> > +	struct list_head notifications;
> > +
> > +	/* A wait queue for poll. */
> > +	wait_queue_head_t wqh;
> > +#endif
> 
> I suspect that these additions would benefit from better struct packing
> since there could be a lot of seccomp_filter structs floating around in
> memory on a system with a large number of running containers or
> otherwise sandboxed processes.
> 
> IIRC, there's a 3 byte hole following the log member that could be used
> by has_listener, at least, and I'm not sure how the rest of the new
> members affect things.

So it turns out the additions are fairly major. The previous
sizeof(struct seccomp_filter) == 24 bytes on x86_64, with the three
byte hole you mentioned.

The new members alone actual sizes are:

sizeof(struct sempahore) request == 80
sizeof(struct mutex) notify_lock == 128
sizeof(struct list_head) notifications == 16
sizeof(struct wait_queue_head_t) wqh == 72

+ the base types of next_id, has_listener gives a grand total of 305
additional bytes, assuming it's packed perfectly. That seems like
quite a huge hit for everyone to endure, especially since it won't be
perfectly packed.

Instead, what if we add a struct notification, and a struct
notification* to struct seccomp_filter? Then we can drop the bool
has_listener because we can use a null test, and the 304 bytes are
only paid by people who actually use this feature (as well as the cost
of an additional indirection, but who cares, they're trapping to
userspace anyway). Unless I hear any objections, I'll do this for v7
:)

Tycho
