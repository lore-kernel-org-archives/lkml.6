Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2675DC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CB4218AD
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Le3OWjJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbeLWXL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 18:11:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38913 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeLWXLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 18:11:55 -0500
Received: by mail-pg1-f194.google.com with SMTP id w6so4919560pgl.6;
        Sun, 23 Dec 2018 15:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yo8mbqWnMHbde7X3yplhhkPZVj44wIEIKuxIr9Idckk=;
        b=Le3OWjJo3WG6qelDo8/Yg7KeMfUhF8f5NQt9ARxNsm9R+bHPpuicf9LLXpSj/DPige
         Srs45X0lqW7AI5/kJI7jFZ+m9S2wQkxaf+oBqA+5tqZE9DuVILL+1fh8KLWitTEk1MqT
         T77atGhoLUUHeB0r/OcKIhRq1oaF5TW40EXsk1tFVOpF6tHksqC1O9+Q3tJCLmoIUO+N
         NzOYxTz7EkHcOI8iLHZB4VWHEC4eRd6MgIdZJdQpaIlsP47bpLDuCbvyiwcgsW2NhLDg
         5gm7C0qU8BAAx1E2AWH+ANEIpgPVO+ZBV0pIEllMszXs3Jb4qtb2dxxYfkUb6bDywdaP
         IYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yo8mbqWnMHbde7X3yplhhkPZVj44wIEIKuxIr9Idckk=;
        b=FtWG/RISoXVW1wzDsCF7MYAyQnMFLHi4Gs8TPvntd540FQ8BnoGCVJtsutw8LU39HI
         oCfMnpXupmkhDiisz2/1LzTt5RixD0xL6J8zIAg6XimsqPRTXyUlR3e928PmhQJV0G4F
         2vfClsxcd0kOOUwsKRyeOv74CkffcTqRQIva0GITXmCedY6ZTqeS2qlkFeBbYCNEbq6V
         LSLJU9VfhPOe9aCyBfZJxFG6we6O4cmTzLW1wmgLL6xirym2L5p/m2PTAbJ0vbxNGjFU
         FG38ZqisMEOHe5ajAMgCwwPyu7Z5Si3TQ/DOlVmyILo/cV6KGKIgHen9wvOncLSS8dyF
         N5lw==
X-Gm-Message-State: AJcUukeysGs2y4bX9q8qJsiEyxy8IB3HO3ur4+vD1HOjk20/4buTJRa2
        XzWUMRtJtQZwy/ZGImJQ6gU=
X-Google-Smtp-Source: ALg8bN6sqXZX5vsYAR4igJY7aYJt5gBYb0UbhhGKm1hwWuq4fFbhM88iGQcFFe4lPUUG5NfKCRNJ4Q==
X-Received: by 2002:a63:f444:: with SMTP id p4mr10374896pgk.124.1545606714766;
        Sun, 23 Dec 2018 15:11:54 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:add8])
        by smtp.gmail.com with ESMTPSA id i21sm47478980pgm.17.2018.12.23.15.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 15:11:53 -0800 (PST)
Date:   Sun, 23 Dec 2018 15:11:51 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, stable@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH] x86/speculation: Add document to describe Spectre and
 its mitigations
Message-ID: <20181223231149.5yuenb53pavlvr3m@ast-mbp.dhcp.thefacebook.com>
References: <64efec3fda40c0758601bf9b1480a35d76d3c487.1545413988.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64efec3fda40c0758601bf9b1480a35d76d3c487.1545413988.git.tim.c.chen@linux.intel.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 09:44:44AM -0800, Tim Chen wrote:
> +
> +4. Kernel sandbox attacking kernel
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The kernel has support for running user-supplied programs within the
> +kernel.  Specific rules (such as bounds checking) are enforced on these
> +programs by the kernel to ensure that they do not violate access controls.
> +
> +eBPF is a kernel sub-system that uses user-supplied program
> +to execute JITed untrusted byte code inside the kernel. eBPF is used
> +for manipulating and examining network packets, examining system call
> +parameters for sand boxes and other uses.
> +
> +A malicious local process could upload and trigger an malicious
> +eBPF script to the kernel, with the script attacking the kernel
> +using variant 1 or 2 and reading memory.

Above is not correct.
The exploit for var2 does not load bpf progs into kernel.
Instead the bpf interpreter is speculatively executing bpf prog
that was never loaded.
Hence CONFIG_BPF_JIT_ALWAYS_ON=y is necessary to make var2 harder
to exploit.
Same goes for other in kernel interpreters and state machines.

> +
> +Necessary Prerequisites:
> +1. Malicious local process
> +2. eBPF JIT enabled for unprivileged users, attacking kernel with secrets
> +on the same machine.

This is not quite correct either.
Var 1 could have been exploited with and without JIT.
Also above sounds like that var1 is still exploitable through bpf
which is not the case.

