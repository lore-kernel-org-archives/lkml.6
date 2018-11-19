Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CFCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEEF20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="hndXFIt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFEEF20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbeKTJFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:05:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45390 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730899AbeKTJFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:05:51 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so12274233pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 14:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V9Dtv5lhjmiwwT+fmo/egRH1C+SB084sb2G6VU2EwTs=;
        b=hndXFIt4AQzQsa0XxIMeK2XsVY5Q+I2utk62/J2/S5VX90fnjccjTyc1Ns1rxoeJpv
         AmvOEuhjol3aKWY3TJa8hIdFOFZGfyqmxk/sxvBKqFH598mdskx1xeIhMLn9AhFvB65R
         W6aW8XAw7A+1C5kBS3GSszvjfHt0hw+7pla+lVuivpk/PdSJ9PRyA918bTXwn8ay3pGA
         CUh2RTf0u9twMjiQsu66TuaG4gBGet7S2g8WUdr27cTghc9YNmjkRc+hL9Es/FMT7FMq
         HbdtlyOXff+WuKt4h7L84We3biqaEoeB9Da+5RM6DPGLEUZJ2TPfRIMGIe8BJ9Kahpof
         Nh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V9Dtv5lhjmiwwT+fmo/egRH1C+SB084sb2G6VU2EwTs=;
        b=gVolgZq9ftdgQB2U1pqKO1mO8UYAW4YZCiG1blRzAop/ZDgtdbKq79EPVRBJDTX0nW
         uKieOZ4rpklfpq0CVROjzmIT7sC5y3SPtYUK/fiEG9DWtvfAbVihSt2dZDApxtUnAbDH
         DKk1P3oZQvCw0bp6wn6tl+B+agaXb86Xo2nlPQ+miGdBfWuz2SOjuZEYbbz7u0WQjUts
         dByzxKoIRV7l4fTmq9OsUHU3WKSaPZPrOn6V5qbCj2ZJnQbGFlpyqDl5aCH+xC3/A0Q0
         eyoqRXkszinVs7hx0ybjvuLZA3/+0TNViS5TdSKl+InbTvg8QnDsyFil9z7OErg4U1t4
         L8gA==
X-Gm-Message-State: AGRZ1gL6jZ66zN75oOFMQWCo9+OftskKj4eYXJ/UdjeMrzHQh8/7frGp
        eXpG1HOQfW4JEOsN5/RHOjlPOA==
X-Google-Smtp-Source: AJdET5dL67Z9wwRUofI+pyUumlQ5s7g9cXLsWZDPYCemw4lMQt5kyq/sBHIJSTM3d1cgrONh2XKFQg==
X-Received: by 2002:a62:e0d8:: with SMTP id d85mr24524708pfm.214.1542667199157;
        Mon, 19 Nov 2018 14:39:59 -0800 (PST)
Received: from cisco ([128.107.241.178])
        by smtp.gmail.com with ESMTPSA id f22-v6sm51384210pff.29.2018.11.19.14.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 14:39:57 -0800 (PST)
Date:   Mon, 19 Nov 2018 15:39:54 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian@brauner.io>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181119223954.GA4992@cisco>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-3-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119103241.5229-3-christian@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 11:32:39AM +0100, Christian Brauner wrote:
>
> +/**
> + *  sys_procfd_signal - send a signal to a process through a process file
> + *                      descriptor
> + *  @fd: the file descriptor of the process
> + *  @sig: signal to be sent
> + *  @info: the signal info
> + *  @flags: future flags to be passed
> + */
> +SYSCALL_DEFINE4(procfd_signal, int, fd, int, sig, siginfo_t __user *, info,
> +		int, flags)
> +{

Can I just register an objection here that I think using a syscall
just for this is silly?

My understanding is that the concern is that some code might do:

unknown_fd = recv_fd();
ioctl(unknown_fd, SOME_IOCTL, NULL); // where SOME_IOCTL == PROC_FD_KILL
// whoops, unknown_fd was a procfd and we killed a task!

In my experience when writing fd sending/receiving code, the sender and
receiver are fairly tightly coupled. Has anyone ever actually fixed a
bug where they had an fd that they lost track of what "type" it was
and screwed up like this? It seems completely theoretical to me.

The ioctl() approach has the benefit of being extensible. Adding a
syscall means that everyone has to do all the boilerplate for each new
pid op in the kernel, arches, libc, strace, etc.

Tycho
