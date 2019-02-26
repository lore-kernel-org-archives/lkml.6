Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1614C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D017217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="rtzm2sNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfBZPYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:24:51 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39167 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfBZPYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:24:51 -0500
Received: by mail-qt1-f196.google.com with SMTP id o6so15274384qtk.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 07:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tIb2I8rZC2PIlMCnZ63uX59cMsFRagPduk4bF+eM78w=;
        b=rtzm2sNsyrHcZAukv40yLi228bjHkDLGHh1wA5YVErmVMNL0EprOZ9lL6BDVeELonX
         sXsqJOciw+E9+XDde6J/9QKFbKH0sBJzmS7tBHDmpTFZMnxV1xwN3jgi4BY3LXkcBtXD
         +abVho8afJCTolOvtXYmIh8B8MKNBGQEudbgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tIb2I8rZC2PIlMCnZ63uX59cMsFRagPduk4bF+eM78w=;
        b=sUJ7eCmKiMvyoSZq+K8gvhfEXXgj+4QUESDydd25f45ZOH8kstATjuTkS9MOAViNak
         RcdkXLDyiPVCHFUdb8TqpjYWmARFDdcW7jhfBo6Rn4oj1/E1td5gM6PKP+Tr8oaXIFF4
         l6uDfnszX0uHGKoCzpApL5Cu4cDM877I8XSgeIJV/9i1rLK3RQuJhNsfHv9EiflBL9QM
         77MLj5Iz9+jzhXmzuoWggiw6lXi/W+bWmtq06HQyP7FO31ccpXipG9Qvo11wxAOg6vfO
         gRY7kp57nAy49TDOnRGpguTqLkLGjNdNkE62u4EHbL1hJEb4O0dwYJcA2yFKaqhGg+EJ
         +9xw==
X-Gm-Message-State: AHQUAubUfGmhnv0vycHmTx+6HB5GbSDOWeO+V1NPnQ3EYRDD+cV34UMv
        MtxQ+8//HD3rLA5CDzH6UMC2WA==
X-Google-Smtp-Source: AHgI3IZ62Hse8tz0BoMzd4d72FCvxLMaHE68ZDZRpUO3ftaH3U1D+JRqFZNrZLGZU1IXuXnccLaBwQ==
X-Received: by 2002:a0c:9508:: with SMTP id l8mr9231910qvl.88.1551194690147;
        Tue, 26 Feb 2019 07:24:50 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id 132sm6926844qke.0.2019.02.26.07.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 07:24:47 -0800 (PST)
Date:   Tue, 26 Feb 2019 10:24:47 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>, will.deacon@arm.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-ID: <20190226152447.GA99670@google.com>
References: <CAHk-=wh9XrOykA5J9RQ7zaBio-S_D+1AE+rGnBYWSd==pCXh+w@mail.gmail.com>
 <20190219111802.1d6dbaa3@gandalf.local.home>
 <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
 <20190219140330.5dd9e876@gandalf.local.home>
 <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
 <20190220094926.0ab575b3@gandalf.local.home>
 <20190222172745.2c7205d62003c0a858e33278@kernel.org>
 <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org>
 <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 11:27:05AM -0800, Alexei Starovoitov wrote:
> On Fri, Feb 22, 2019 at 09:43:14AM -0800, Linus Torvalds wrote:
> > 
> > Then we should still probably fix up "__probe_kernel_read()" to not
> > allow user accesses. The easiest way to do that is actually likely to
> > use the "unsafe_get_user()" functions *without* doing a
> > uaccess_begin(), which will mean that modern CPU's will simply fault
> > on a kernel access to user space.
> 
> On bpf side the bpf_probe_read() helper just calls probe_kernel_read()
> and users pass both user and kernel addresses into it and expect
> that the helper will actually try to read from that address.

Slightly related and FWIW, BCC's eBPF-based opensnoop tool [1] installs a
kprobe on do_sys_open to monitor calls to the open syscall globally.

do_sys_open() has prototype:

long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode);

This causes a "blank" filename to be displayed by opensnoop when I run it on
my Pixel 3 (arm64), possibly because this is a user pointer. However, it
works fine on x86-64.

So it seems to me that on arm64, reading user pointers directly still doesn't
work even if there is a distinction between user/kernel addresses. In that
case reading the user pointer using user accessors (possibly using
bpf_probe_user_read helper) should be needed to fix this issue (as Yonghong
also privately discussed with me).

[1] https://github.com/iovisor/bcc/blob/master/tools/opensnoop.py#L140

thanks!

 - Joel


> 
> If __probe_kernel_read will suddenly start failing on all user addresses
> it will break the expectations.
> How do we solve it in bpf_probe_read?
> Call probe_kernel_read and if that fails call unsafe_get_user byte-by-byte
> in the loop?
> That's doable, but people already complain that bpf_probe_read() is slow
> and shows up in their perf report.
> 
