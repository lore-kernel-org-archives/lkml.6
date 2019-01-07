Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790E8C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A042089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546856148;
	bh=vJMWAsOKip4geW5B7WXYGQhkH4I9qzadf0nL6f5EzEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KbM/eQPEGdiRn6YRplxFV81Kh5ON3CdFZn+QwFnrIS2Chs43HnfCkELuZmrHIx5QH
	 8XD5bdY5D0A0OozVj7tGa/r3qe8CTPm1I4bYmYnyLk+0U4K4vf/cFHSms5Xi5r7Vew
	 HATuXvneZZ7f564vWi7AF8W2b9UG3DEkmF+muUvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfAGKPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:15:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45350 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfAGKPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:15:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so42530324wrr.12;
        Mon, 07 Jan 2019 02:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yWirVjqGb8oxtQKBz5VYdknzBxnaGsefnIlvvHeuY7g=;
        b=iJYPV0FwUrMRQan3NlPP/Dst6utgocQVSR7jieBqzJK4szthcTcKSK0rEd28CMiJXm
         GPT8G+0qn3xPqL12BeNqeNb24a2EetfcKN+kJ5LCnPhp8rRJLdSItOY3Gcc7/blpdieU
         1NXGHYswV1ngjxtg0dAp/uK+UWP/YeIy0S+v4cu3mJoA0kPUoFgdVtvvKcFb0ED/HPbi
         g65SjOztI80SAYFZ5NTvS6VGsrzaE9Z3oYFOjwBm0zpaWoNWKyqjIeWBq+Fr3i4Kb6yD
         3caflwBsHyUb33nG8Okuq4QdVWqR4A7xkWL+H2mqNn0Ac3gMoi21eqOumQrbWhyKLuPz
         koUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yWirVjqGb8oxtQKBz5VYdknzBxnaGsefnIlvvHeuY7g=;
        b=GEcoulZK+/Li8NIYkxz/W6OCuFk2ZIBnLyGfd46n+U4OtIb580EcsdHmm5uJkYk/jn
         g8rFlZfan8oYzYAOK4J/4XSgKtVNj5n5MZKV4HtJ8bQDhv0uxj+NX9xdAsn3yYjs+vPm
         d6qrgGNKnPhCsQoli/aD+Gj6RcUy8eGsmudy7am6LcN9NAMZI1kTgge9q61t6GLOVhQ6
         QIeWB9xY61EqG7HxaqG1ZxnZ67vO1BoqNCZEPUfKrcb8MwgusGL4EU3vF1ozDmwOUUPj
         aN5jHbueuJNn/6w8ieri2vXKGEXdYZv9NANJBEt8mjMFr8roI272XaVa3iKX1EsHMnCP
         0fHg==
X-Gm-Message-State: AJcUukdewMb1DbyqsM25Ltzdc4Nfp9q0n9HCcW76AwESsoIXcGaTgvAO
        4Dd/ZoYd1hCyWWMw+zCcrKI=
X-Google-Smtp-Source: ALg8bN6mOGCzKj1vVKC4YulHWhkzP3JaidsEdXVOuz5Q6ZZZbocR3cgrs9cqXBxPqruE+ajd6pYAEg==
X-Received: by 2002:a5d:418b:: with SMTP id m11mr47463365wrp.8.1546856143892;
        Mon, 07 Jan 2019 02:15:43 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u204sm6847662wmu.30.2019.01.07.02.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 02:15:43 -0800 (PST)
Date:   Mon, 7 Jan 2019 11:15:40 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [GIT PULL] security: seccomp changes for v4.21
Message-ID: <20190107101540.GA87402@gmail.com>
References: <alpine.LRH.2.21.1812311511360.1435@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1812311511360.1435@namei.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* James Morris <jmorris@namei.org> wrote:

> From Kees:
> 
> "- Add SECCOMP_RET_USER_NOTIF
> 
> - seccomp fixes for sparse warnings and s390 build (Tycho)"
> 
> 
> 
> The following changes since commit 1072bd678547f8663cfb81a22fdb50c589e4976e:
> 
>   security: fs: make inode explicitly non-modular (2018-12-12 14:58:51 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-seccomp
> 
> for you to fetch changes up to 55b8cbe470d103b44104c64dbf89e5cad525d4e0:
> 
>   Merge tag 'seccomp-next-part2' of https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux into next-seccomp (2018-12-17 11:36:26 -0800)
> 
> ----------------------------------------------------------------
> James Morris (2):
>       Merge tag 'seccomp-next' of https://git.kernel.org/.../kees/linux into next-seccomp
>       Merge tag 'seccomp-next-part2' of https://git.kernel.org/.../kees/linux into next-seccomp
> 
> Tycho Andersen (6):
>       seccomp: hoist struct seccomp_data recalculation higher
>       seccomp: switch system call argument type to void *
>       seccomp: add a return code to trap to userspace
>       samples: add an example of seccomp user trap
>       seccomp: fix poor type promotion
>       seccomp, s390: fix build for syscall type change
> 
>  Documentation/ioctl/ioctl-number.txt           |   1 +
>  Documentation/userspace-api/seccomp_filter.rst |  84 +++++
>  arch/s390/kernel/compat_wrapper.c              |   2 +-
>  include/linux/seccomp.h                        |   9 +-
>  include/linux/syscalls.h                       |   2 +-
>  include/uapi/linux/seccomp.h                   |  40 ++-
>  kernel/seccomp.c                               | 467 ++++++++++++++++++++++++-
>  samples/seccomp/.gitignore                     |   1 +
>  samples/seccomp/Makefile                       |   7 +-
>  samples/seccomp/user-trap.c                    | 375 ++++++++++++++++++++
>  tools/testing/selftests/seccomp/seccomp_bpf.c  | 447 ++++++++++++++++++++++-
>  11 files changed, 1411 insertions(+), 24 deletions(-)
>  create mode 100644 samples/seccomp/user-trap.c

32-bit x86 allyesconfig doesn't build:

 /usr/bin/ld: i386:x86-64 architecture of input file `samples/seccomp/user-trap.o' is incompatible with i386 output
 /usr/bin/ld: samples/seccomp/user-trap.o: file class ELFCLASS64 incompatible with ELFCLASS32
 /usr/bin/ld: final link failed: File in wrong format
 collect2: error: ld returned 1 exit status
 scripts/Makefile.host:99: recipe for target 'samples/seccomp/user-trap' failed
 make[2]: *** [samples/seccomp/user-trap] Error 1

Is this a known regression?

Thanks,

	Ingo
