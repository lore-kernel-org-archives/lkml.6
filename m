Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D184C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270922082F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="N9FOuq1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfBCIjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 03:39:37 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44992 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbfBCIjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 03:39:36 -0500
Received: by mail-ed1-f65.google.com with SMTP id y56so8773154edd.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 00:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DQ8D87H/acEBKppa2VceJ7gQx/qWTx7VPZy5zIq/IY0=;
        b=N9FOuq1DMpyfqyn3c7aQSb36UeXlPZc721y3CbJlEHFp6eV4Ri10iv3NWTNlVJdGbr
         wG8i33vBHW77byZrwjuXnxpMX9Yn6ztp2Fa5lf7R1IUBzQM2GNRJc2o0WjUgF3/G1+fX
         iXdm8mPOxbTOMVJgatjC0fuw9cfMkbHdzFwT431R6UUH/liO/YU0mPPusmmtWYzjJ6Xn
         1cDSuRwFKh9GXZnKZ/H2y/+nnNrxIrESOWFdVyP0ojrmDfbSLlSQHTI+lEkIu4OBq5wD
         DypN1gBhHskXxvhb2iPQFHQA21neHu1YQAeDU2AlWBYyPHtREaV7IKQd22vLQe9T2p4N
         9eqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DQ8D87H/acEBKppa2VceJ7gQx/qWTx7VPZy5zIq/IY0=;
        b=HiG8BseO2LqCpEuEZT7OQCtpGAWGmGVO7R0VcjCD1p7b7q0/3UNQXo5AXiO6lKgyLZ
         YlX9SGqZ1y+IsjmsWgpVPUBSJQIKftPqSz6BntC6oPRdy67D2G2n/6oeY15y+7NWPmpv
         hSXv+ga2DpmDQa00dY2Hu/mG+LsEMw1EIX+kPxtNjX5z83pelGgvNRFulNaR83Tm1av0
         MqXaePZUgdONBvGUhBzIHFW30cEZ6MQcsa3xStVK2pHCVMGfWbiiailopZju8lxMSDXK
         zoGLa1Vo8Pw+71QwyUWXY18kii8ANLTc1gkwYu8llf8TFc2gFM9udJuS2yIN8xHzdiS1
         8gYg==
X-Gm-Message-State: AHQUAuYuoyw+FXbYUfhUfQ8qxhELqN36rFjO3KmUsKkjoYV+VD6soxF8
        jyXVvwSWb5vCx9QMhyKy6P1Fpw==
X-Google-Smtp-Source: AHgI3Ia5g4xKSOrvM2nc0C9vhpGxyhvRe5t83sF+UTTNQSTjn3P17sTavBKCxINfqQtGSNJhovEOvA==
X-Received: by 2002:a17:906:4344:: with SMTP id z4mr20945867ejm.27.1549183174932;
        Sun, 03 Feb 2019 00:39:34 -0800 (PST)
Received: from brauner.io ([2001:67c:1810:f051:2130:3a9e:3894:d6a6])
        by smtp.gmail.com with ESMTPSA id f31sm3464395eda.16.2019.02.03.00.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Feb 2019 00:39:34 -0800 (PST)
Date:   Sun, 3 Feb 2019 09:39:34 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Jack Andersen <jackoalan@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] signal: always allocate siginfo for SI_TKILL
Message-ID: <20190203083933.ee4a6j4mdecesbn2@brauner.io>
References: <20190203074939.7261-1-jackoalan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190203074939.7261-1-jackoalan@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2019 at 09:49:38PM -1000, Jack Andersen wrote:
> The patch titled
> `signal: Never allocate siginfo for SIGKILL or SIGSTOP`
> created a regression for users of PTRACE_GETSIGINFO needing to
> discern signals that were raised via the tgkill syscall.
> 
> A notable user of this tgkill+ptrace combination is lldb while
> debugging a multithreaded program. Without the ability to detect a
> SIGSTOP originating from tgkill, lldb does not have a way to
> synchronize on a per-thread basis and falls back to SIGSTOP-ing the
> entire process.
> 
> This patch allocates the siginfo as it did previously whenever the
> SI_TKILL code is present.
> 
> Signed-off-by: Jack Andersen <jackoalan@gmail.com>

The  commit you're trying to fix has been discussed before wrt to
seccomp tests:

commit 2bd61abead58c82714a1f6fa6beb0fd0df6a6d13
Author: Kees Cook <keescook@chromium.org>
Date:   Thu Dec 6 15:50:38 2018 -0800

    selftests/seccomp: Remove SIGSTOP si_pid check

    Commit f149b3155744 ("signal: Never allocate siginfo for SIGKILL or SIGSTOP")
    means that the seccomp selftest cannot check si_pid under SIGSTOP anymore.
    Since it's believed[1] there are no other userspace things depending on the
    old behavior, this removes the behavioral check in the selftest, since it's
    more a "extra" sanity check (which turns out, maybe, not to have been
    useful to test).

    [1] https://lkml.kernel.org/r/CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com

    Reported-by: Tycho Andersen <tycho@tycho.ws>
    Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
    Signed-off-by: Kees Cook <keescook@chromium.org>
    Signed-off-by: Shuah Khan <shuah@kernel.org>

Ccing Kees on this. Seems that this commit might be worth given that
there's some parts of userspace relying on it and not just internal
kernel tests.

Christian
