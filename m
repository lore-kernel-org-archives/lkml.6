Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292CCC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D688320989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="CB90cp7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D688320989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeLFWkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:40:02 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34375 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeLFWkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:40:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so890558pfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 14:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t77eOMa11P5XrIFxy2lHsrVEGddYOda6ZI5IRZjxtMw=;
        b=CB90cp7EfPnYEHOa/8HaBPDpoLfZXZ3bRG6WghiyTgl9FjGtRkop/wslZz9gA3HHC4
         zKQkQ1Ub5tV0L8plzXF3tXlf+pVyu5KI4x1A7AD/GeK9J254SYbpYN0+7Ixm7xkxpNwt
         4pe8j6XcWhL53MdyetD5zLU8yTLu9jUNOrSXinkizXcAVDGW10s45bh9asngs7rmKZd2
         aFAMWc4URFYvnSb20ZyTNT+1fQgCmWrm3p+CJqCVpEXu5GR5+wUTPwoxLAjm7MYnwYkD
         eEljnpQCg6xCCkpYoxUrxt4cdiaV63W8kP8Ei3Fvp+T0y9slUifmxAHnCLp5UTdp5f69
         1I/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t77eOMa11P5XrIFxy2lHsrVEGddYOda6ZI5IRZjxtMw=;
        b=VGOsc9yDGaX8x40dnbYEAgVzR10PRh/QL+q+ukrSRQLQNJvBLPXhbYXDUo6Ojt7xJW
         SETw/KqRnhqoqjMMwXbf7nGAbeBDyo2izazdMv5eW82TkrrAiUODajqCniZ2xrin4hPd
         LMP0S4DMnutzWHF6QLUhFur/VYX1CZdkK8REw1+2f7kjzs3CxBohhjESVKHDqGZS+Mex
         tPjHOeuisSSXpP9CDqxsO0U2QOjGm0CeI33tVZouftfyfZLXQF5bLmCK7eHxSkk4+5FK
         Hgu7djf/Q8XWx5IHRfNHuY/psiNyEwul4To8VTbYgpbYUZYYc5K6hxrgKkUL6GhcMe5N
         YbZg==
X-Gm-Message-State: AA+aEWbOgyrVMA0qNzw54UVcr5hXThKjQhGxR3LEcjgnenPznRv5bYY/
        sdJcXi4iQlMOJOY7pbJHCn2m2Q==
X-Google-Smtp-Source: AFSGD/V8RYnFapcRu+//MIH5ZcQvH7tspIkPdjL5qrLSCEwwvFzoRierOZtlzIFtBDbr2taNIN2+yA==
X-Received: by 2002:a62:130c:: with SMTP id b12mr30599837pfj.247.1544136001467;
        Thu, 06 Dec 2018 14:40:01 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:b824:a031:b50e:f401])
        by smtp.gmail.com with ESMTPSA id d3sm1535883pgl.64.2018.12.06.14.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 14:40:00 -0800 (PST)
Date:   Thu, 6 Dec 2018 23:39:51 +0100
From:   Christian Brauner <christian@brauner.io>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luto@kernel.org, arnd@arndb.de, serge@hallyn.com, jannh@google.com,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        dancol@google.com, timmurray@google.com, linux-man@vger.kernel.org,
        keescook@chromium.org, fweimer@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH v4] signal: add taskfd_send_signal() syscall
Message-ID: <20181206223948.gyfdtkgbhtozmpsp@brauner.io>
References: <20181206121858.12215-1-christian@brauner.io>
 <87sgzahf7k.fsf@xmission.com>
 <D372C766-572C-4897-8F02-2FD0E72CCFAC@brauner.io>
 <875zw6bh2z.fsf@xmission.com>
 <20181206193017.wpxls5p3zgjd6rv2@brauner.io>
 <871s6u9z6u.fsf@xmission.com>
 <20181206213152.gvci7ijr3dokew7w@brauner.io>
 <87o99y72gi.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o99y72gi.fsf@xmission.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 03:46:53PM -0600, Eric W. Biederman wrote:
> Christian Brauner <christian@brauner.io> writes:
> 
> >> Your intention is to add the thread case to support pthreads once the
> >> process case is sorted out.  So this is something that needs to be made
> >> clear.  Did I miss how you plan to handle threads?
> >
> > Yeah, maybe you missed it in the commit message [2] which is based on a
> > discussion with Andy [3] and Arnd [4]:
> 
> Looking at your references I haven't missed it.  You are not deciding
> anything as of yet to keep it simple.  Except you are returning
> EOPNOTSUPP.  You are very much intending to do something.

That was clear all along and was pointed at every occassion in the
threads. I even went through the hazzle to give you all of the
references when there's lore.kernel.org.

> 
> Decide.  Do you use the flags parameter or is the width of the
> target depending on the flags.

I'm sorry I don't understand what you a) mean with this sentence "width
of the target" and b) what you *exactly* want from us to get this accepted.

> 
> That is fundamental to how the system call and it's extensions work.
> That is fundamental to my review.
> 
> Until that is decided.
> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> There are a lot of fundamental maintenance issues and you can very easily
> get them wrong if you are not clear on the job of the file descriptor
> and the job of the flags argument.
> 
> I want don't want new crap that we have to abandon that has a nasty set
> of bugs because no one wanted to think through the system call all of
> the way and understand the corner cases.

That's why this system call is exactly kept as simple as it is. Which I
had to fight for! You kept consistenly asking for features such as:
- add a pid parameter maybe
- allow to signal into ancestor and cousin pid namespaces
I fought all of those off for the sake of keeping this patch as simple
as possible so that we can get it in.
We don't even need to decide whether we go for flags or another type of
fd right now. The point was that we can postpone this to a later
discussion. Which also has been discussed in multiple threads. That's
literally what I wrote in prior mails and nearly everyone agreed that
this is a good strategy.

I honestly have no idea what to make of your review given that it
started from a naming issue and suddenly the whole api is crap.
If you want this to be named fd_send_signal() to get in. Then seriously,
I'm happy to rename it. I honestly don't care even though I think taskfd
is a better name.

> 
> Eric
