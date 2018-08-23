Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEC0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53122150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g6uOKbWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53122150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeHWWNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:13:47 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41597 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbeHWWNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:13:47 -0400
Received: by mail-qt0-f193.google.com with SMTP id t39-v6so6651410qtc.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 11:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ZHJoPYr9D1mkR3howQUFvlApJnQXiyyAXgaTjp8t2Q0=;
        b=g6uOKbWtDQyvzNXPXo8HG5QSzL+qAp5ujqJFrj1iJfAcVVyM9aZpmxktXsjg+GfYiS
         ca3mH1ZLsOFvrbWqXARBF/Lq6O6v9TIau50FyBhkxhgXS7BUOUBKqQ0shZXWRqvypSSs
         qbN6Od0m4JFzNCa4YwOqvJi1b0nxSaxMY2BIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ZHJoPYr9D1mkR3howQUFvlApJnQXiyyAXgaTjp8t2Q0=;
        b=t2O6vtQMbuEUI+iyfUvlI231p/YWjI2m89vGId7pQxw8TtnUPL46+K22VFb9UkUBiE
         IQsITXNaf5qIjztPFjEF08l3HZUuN9L9jLNguG50AWE11GJw8XW+Z/5yIJCELB+wBhil
         QlhJ9tBVF0q7AbbNW/ufYJrVmDagf7VEPHp/bYmkaw1ZpWJ+3xe0uuxskpc3M9uZ7FU2
         DyBGznsCzBB2YdugO5vBrGaGKf52BAHY9ML34pqInake8e54F8p3OMLprJFJZvOZt4iH
         3bqHED6bMo+38NFxLWshFAHqqH60gEOhGgU60qceG8+37EWacxXglI+BTCdA+gP6kFQg
         mpPA==
X-Gm-Message-State: AOUpUlH1n9o6kjBdxovkfQwRC5wAxfBADWZvGsrjQ1YmIHNlMGvKn6uv
        keTvoc/zqr0cnvOPVOg9Qs1QRbNH9JM=
X-Google-Smtp-Source: ANB0VdY5/SugE1ls/7btiM1HB0oiR0Y/F423ldEdixJnFGjVbwk+HNGqvA0j3MM/1ZWpqw/qIdUe2A==
X-Received: by 2002:ac8:fe7:: with SMTP id f36-v6mr17753509qtk.63.1535049767212;
        Thu, 23 Aug 2018 11:42:47 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id y47-v6sm3384677qtk.27.2018.08.23.11.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 11:42:46 -0700 (PDT)
Date:   Thu, 23 Aug 2018 14:42:45 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc:     josh@joshtriplett.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel-only deployments?
In-Reply-To: <20180823174359.GA13033@linux.vnet.ibm.com>
Message-ID: <nycvar.YSQ.7.76.1808231414190.10215@knanqh.ubzr>
References: <20180823174359.GA13033@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2018, Paul E. McKenney wrote:

> Hello!
> 
> Does anyone do kernel-only deployments, for example, setting up an
> embedded device having a Linux kernel and absolutely no userspace
> whatsoever?

Not that I know of.  For one thing, you'd lose the ability to license 
your application code the way you want.

> The reason I as is that such a mode would be mildly useful for rcutorture.
> 
> You see, rcutorture runs entirely out of initrd, never mounting a real
> root partition.  The user has been required to supply the initrd, but
> more people are starting to use rcutorture.  This has led to confusion
> and complaints about the need to supply the initrd.  So I am finally
> getting my rcutorture initrd act together, with significant dracut help
> from Connor Shu.  I added mkinitramfs support for environments such as
> mine that don't support dracut, at least not without significant slashing
> and burning.
> 
> The mkinitramfs approach results in about 40MB of initrd, and dracut
> about 10MB.  Most of this is completely useless for rcutorture, which
> isn't interested in mounting filesystems, opening devices, and almost
> all of the other interesting things that mkinitramfs and dracut enable.

No surprise there.

> Those who know me will not be at all surprised to learn that I went
> overboard making the resulting initrd as small as possible.  I started
> by throwing out everything not absolutely needed by the dash and sleep
> binaries, which got me down to about 2.5MB, 1.8MB of which was libc.

That is possibly still very big. You could probably get away with a 
statically linked busybox containing only the shell facilities you 
require for 100K or so.

> This situation of course prompted me to create an initrd containing
> a statically linked binary named "init" and absolutely nothing else
> (not even /dev or /tmp directories), which weighs in at not quite 800KB.

This still looks big for a custom binary, unless you do have a lot of 
code in there. It is already possible to have a kernel binary about that 
size, and even if that's a configured down kernel, quite some complex 
code remains.

The bloat might come from the C library you use. It's been a while since 
glibc stopped caring about not pulling a lot of unneeded code when all 
you want to do is printf(). It carries all those locale dependencies, 
etc. You should look at alternative C libs to get things small.

> This is a great improvement over 10MB, to say nothing of 40MB, but 800KB
> for a C-language "for" loop containing nothing more than a single call to
> sleep()?  Much of the code is there for things that I might do (dl_open(),
> for example), but don't.  All I can say is that there clearly aren't many
> of us left who made heavy use of systems with naked-eye-visible bits!
> (Or naked-finger-feelable, for that matter.)

:-)

> This further prompted the idea of modifying kernel_init() to just loop
> forever, perhaps not even reaping orphaned zombies [*], given an appropriate
> Kconfig option and/or kernel boot parameter.  I obviously cannot justify
> this to save a sub-one-megabyte initrd for rcutorture, no matter how much
> a wasted 800K might have offended my 30-years-ago self.  If I take this
> next step, there have to be quite a few others benefiting significantly
> from it.

You could easily do it from your init binary with less trouble than 
having the kernel carry such an option.

> So, does anyone in the deep embedded space already do this?

Not that I know of. Normally, if the init process dies, you typically 
want the whole system to reboot (you may force a reboot upon any kernel 
panic for example).


Nicolas
