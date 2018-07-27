Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EC3C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0904620671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQM3EKEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0904620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389135AbeG0X3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:29:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35381 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389000AbeG0X3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:29:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6-v6so3964718pgv.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 15:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A/sYL9Eg+X3Op7B7NPq9m4gWQhnM/AksD0oBmnrxtkc=;
        b=IQM3EKEfHJP3tXAJtMn55y91XkvS/xE4Hx6DYV3OaOw4OlXbEgx5XXi9iM0QcdQ3Cu
         AYQ3PjNW/QR2qZXVW9wXpCnlmKd62WeNfEo3W6sTrk8333SiNQpou71c7BfdF4WmE7bh
         4oKxiko2Hkl19EyXgJIZuIt3R4V2MkNCpwTCnhihZTodJ6GuUUfxh/cMS9HxgiTniliK
         hZJ6jwJcxiYbIPyvN078S//DdWMLu7DKNvVQSQdeKIKnIbyGAXUfuDFStXNLMh1/Le+G
         9Y2tgsZplidYJgDOgQ936/RNaNkysk63OicEgxZjO8Qe0DC9fCEyRupB2oyQ9BfkX3pJ
         qnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A/sYL9Eg+X3Op7B7NPq9m4gWQhnM/AksD0oBmnrxtkc=;
        b=Jwl8gQ7+EvbsqKYplZx70OP2VjV+/Qp+GKt9YLVINoFLKzzOZluaTrZYiO/odWmqGR
         HzqYyoenwJfQ8X7rfsKCOh6KPq0BfkTFeKXA1+T4FfGc1kmvNi1QRZdQwk/4W7ivzC0S
         l2LYT/BhDRE9rEgxMhEOsuzHoMarlVDDzPdu0zIB/Gl+queb2D20PUtUgRCJcbuDd4nX
         i6l6pZ3bKkZZMaiV5NOZCj3QyuBpZNTqHCUchn4nFpf3W7n/gxqEnpmbggzBz6qXt12t
         wtLOyHAa6OzXlv73cf/I/+nC7Jgje4ZVO05sh772i2MzqfC1uVC1l1ai9kAZ0AufabIL
         pQhg==
X-Gm-Message-State: AOUpUlFv0zjXI6P5J3yFLxryEAh1qG2zpyvRrMGlUPULn41RSubRiKPy
        XqS/ptrG+a6cPByT6GNuqraW8g==
X-Google-Smtp-Source: AAOMgpe+qkA4MvXASrb5m387XJrwOi3taCH1nB6r9tjqlq9Iqr+8WV0t3xWibAxw7kTOUFTEBE75pQ==
X-Received: by 2002:a62:8d84:: with SMTP id p4-v6mr8428075pfk.251.1532729145334;
        Fri, 27 Jul 2018 15:05:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:6e29:33f4:7c9a:4918])
        by smtp.gmail.com with ESMTPSA id o27-v6sm10831167pfj.35.2018.07.27.15.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 15:05:44 -0700 (PDT)
Date:   Fri, 27 Jul 2018 15:05:43 -0700
From:   Sandeep Patil <sspatil@google.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jann Horn <jannh@google.com>, salyzyn@google.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Golden_Miller83@protonmail.ch, Greg KH <greg@kroah.com>,
        Kees Cook <keescook@google.com>, salyzyn@android.com,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, kernel-team@android.com,
        stable@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
Subject: Re: [PATCH] tracing: do not leak kernel addresses
Message-ID: <20180727220543.GT190909@sspatil-desktop.mtv.corp.google.com>
References: <CAG48ez1U=5nTOrnOqwMuXhdER-7XxJUYLcyYNuczwasQLQ0gXA@mail.gmail.com>
 <20180727094730.3a448629@gandalf.local.home>
 <CAKwvOdmg4DSSwy9YBccYWzc+6ZU2yKSSFmfnj72wqbYDJU0gzw@mail.gmail.com>
 <20180727143141.4b53d554@gandalf.local.home>
 <CAMx4XWv3OazvURuN1XU2+5C5tNDzPuTniMn_T=XTA4P8_uwS_A@mail.gmail.com>
 <CAG48ez25zgjTQRux_rk1fn2DUVthtK31dRU9cxE+55pBGmYjXQ@mail.gmail.com>
 <CAG48ez1MdupASE1DMt0OWXv+rqZO-2GAbfDthEQcvNXrc2pTsQ@mail.gmail.com>
 <20180727195416.GF13922@thunk.org>
 <20180727161103.797f12b7@gandalf.local.home>
 <20180727202114.GH13922@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727202114.GH13922@thunk.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 04:21:14PM -0400, Theodore Y. Ts'o wrote:
> On Fri, Jul 27, 2018 at 04:11:03PM -0400, Steven Rostedt wrote:
> > That said, I would assume that
> > other Android utilities are using other debugfs files for system
> > status and such.

As of today, I think a lot of information in 'bugreports' is read
out of debugfs (including things like binder stats). We do have a plan
to change that.

> 
> Yeah, I know we probably have lost the "debugfs is only for debugging
> and has no place in a production system" battle, and we should just
> move on and assume we need to completely harden all of debugfs.  But
> it's worth at least *asking* whether or not the use of debugfs for
> Android can be avoided....

Indeed, I think it can. However, the problem is the last time I tried to
remove this a whole bunch of things just broke. So, it wasn't about losing
a functionality here and there. Agree, we need to clean up platform to not use
debugfs first. Then we can expect Apps or other native processes to not rely
on debugfs at all.

The work is in progress..[1]

- ssp

1] https://source.android.com/devices/architecture/kernel/modular-kernels#debugfs

> 
> 					- Ted
> 
> -- 
> You received this message because you are subscribed to the Google Groups "kernel-team" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 
