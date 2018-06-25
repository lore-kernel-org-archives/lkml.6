Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E90C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC1A25846
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvejrRrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC1A25846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932507AbeFYLm1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:42:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42828 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755221AbeFYLmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:42:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id k20-v6so4156327ljk.9;
        Mon, 25 Jun 2018 04:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6hlT0mqRWwlI55/1CgfXza99Gq2RVTPAG6JywVGqXNQ=;
        b=CvejrRrz5fDAQl1tO7OGSPYhhsT5VdWcgPRac+0liL19qPr9L3b4Oq6XQGYeR7f3ZJ
         lXGYM+GrPOMsyqcmTMh/srVfjLwqbuSGGCjVMAXxd7LsO8mt4Lvzr/wJGXOEgh0of18c
         v6WcbnTZO8mIqZDCo/Z6/prb3keQXMSVkJGkhEJREcW2fzIgxGVECpUabquOV+KldNCi
         tnjZJxDmVvKY03PWpshSLEEJCwDWWI5TgZy7VzX/8cv083gJ6U8eUpbBXZNM71jBXQU4
         D/GiAxWaGYYBDt++27YCOZNSZiDaezaql6ZSpMeyoJW0qeRAu67a0u0UdMHgJ2uruPbd
         150Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6hlT0mqRWwlI55/1CgfXza99Gq2RVTPAG6JywVGqXNQ=;
        b=Gtng3UvcTI+1Bgv3g67sykjI7bL8EHRIpIDruvjoUiCxPL01M4f3gOSPPXH+FMz+ip
         WG6LYzfi79p87llFZevRMbltn0gXRxkEZuA6nZg9u7DF0vAkJWYs5UPMwYrBMweSKGwy
         YO7+T82IN9VVdPqgn9Jjf6kb0AilPABDk4LpYsDQubEv32EiVrXgehZ+DJnYylrt43YI
         ZFPC0iY05n4ekoxmC9CFpaP9qCYGzT34/gtbOquTLa9rHXjmbKFN22SBddF9RI8LWodH
         qhjwzdoct1fZ/doQTvnmu/8xfjfMMb6Ppv5BJCniWsP47BmnIP98juDY2Pv7HTfZzj/U
         2wtQ==
X-Gm-Message-State: APt69E0727PU2K42ld7AahsSyHiqiLapC5EepHEvwnP6aoNlMdr3iZIh
        YgHc+RxBlhp8j9USuUYZ5TNtOl2ebsgYkFMzWGI=
X-Google-Smtp-Source: ADUXVKJdxGFht+DgeKsE7e3oGYIGkMxAHCXGtzh3dZqWGZMbg74ua0P+wvHIO6OzVhbsKXx/6J2O4TjQMdRDIFH+60w=
X-Received: by 2002:a2e:545a:: with SMTP id y26-v6mr6063971ljd.19.1529926941027;
 Mon, 25 Jun 2018 04:42:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41cf:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 04:42:19
 -0700 (PDT)
In-Reply-To: <87a7rm3eb5.fsf@xmission.com>
References: <20180420120605.1612248-1-arnd@arndb.de> <20180420120605.1612248-2-arnd@arndb.de>
 <20180621154915.GA31947@gmail.com> <CAK8P3a1QYTfRNQt2+a29BpvgYM_pnSFrO=NBvVo=BdUa2q9ngQ@mail.gmail.com>
 <20180621161121.GB7222@gmail.com> <CAK8P3a1mx16S+DhEMQA6WBJ7efdhN5YaKKVHU6n+E6kfifM-Qg@mail.gmail.com>
 <20180622021636.GA11266@gmail.com> <87a7rm3eb5.fsf@xmission.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Jun 2018 13:42:19 +0200
X-Google-Sender-Auth: z10Bwy0VD0jQIiIyunPTnbqKeO4
Message-ID: <CAK8P3a0G-MHA=buSL3Ymp3=-+=qgJWw1N3NtPQNr9wmpXV2cmA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rusage: allow 64-bit times ru_utime/ru_stime
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Eggert <eggert@cs.ucla.edu>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 7:45 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Ingo Molnar <mingo@kernel.org> writes:
>
> So I suspect the simplest thing to do would be to set a flag in the
> idtype member of waitid that says give me rusage64 and then we would
> be done.

It would have to be a flag in both the 'idtype' field of waitid(), and also
'who' field of getrusage(), which unfortunately uses a separate set of
flags. Not hard to do, but still a bit more complexity.

> Alternately we could use the low bits of the resource usage
> pointer.  Assuming we don't want to introduce another syscall that is.
> I really don't see much incremental extensibility potential in the wait
> or rusage interface right now.

This is also my conclusion after looking at how various other
operating systems implement getrusage() and wait4() today.
It seems that this is one of the most stable APIs, everyone uses
exactly the same structure layout (Linux/x32 being one exception,
they have the 64-bit Linux compatible layout using __s64 instead of
long members).

For the other ~20 system calls we introduce for y2038, the general
idea has been to stay mostly compatible with the source level interface,
just using a new syscall number. statx() is a notable exception here,
with clock_adjtime() and getitimer()/setitimer() still being undecided.

If we don't do an extensible layout or any other new fields, there
are still the open questions about whether any types should change:

- changing everything to 64-bit would allow sharing the kernel
  code between compat and native
- changing only __old_kernel_timeval to new 64-bit timeval would
  be the simplest user space change (only the syscall number
  changes with sizeof(time_t)), avoiding an extra copy thorough
  the user space stack.
- changing timeval to (64-bit) timespec would seem the most
  sensible update, since it avoids the silly nanosecond-to-
  microsecond conversion in the kernel (glibc would still need
  to do it for compatibility). This is what I'm considering for
  getitimer/setitimer,  too.

         Arnd
