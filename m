Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232ECC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD580218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TGeOnirQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfAYRoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:44:03 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:32946 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfAYRoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:44:03 -0500
Received: by mail-vs1-f68.google.com with SMTP id p74so6177175vsc.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 09:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h5yXncTmw95TkKYow8C1ELbftuG/2dmXrQGaFTXsFcQ=;
        b=TGeOnirQJFV1jBGNFDZcBsGiwh4Jkb3hlqJCw2F7P5V/zHLpFHaB9VrzKKx3OPuahr
         kBQAZmiyjqPtAyO7INU4/7/JHwReB6CSuSgS1IgmzhTzfLOpt7GKeA9PNRx4Q4q7LBTY
         0SSF/WBjX77J6W2bAyKic6+hyTl3dSuII180A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h5yXncTmw95TkKYow8C1ELbftuG/2dmXrQGaFTXsFcQ=;
        b=f2iBH/TIfMFz6k0CMSygV3mLXd+7EgJoWLWCzoQ9rCRQ0untoma3yF7fG5jfVtOkjF
         0I+bdtW7W6OWQKnt3THjpFlxrAuD25KtdZXr9xWwc1BrRs7nx3e1marsJKh5nnEh4ifZ
         586lUkXyYe/cfFs4MW4rQrAyhiDfiFMjehThfNznrppdzM3A9i6kHbqbq6sZaOp18e2T
         eBY22CYW8vO9trVzfuzphcfS8x+XuN5ifhbyHPD2b9S+W02UhjomW4bo+dckB75Ap1Zb
         A4EeVAL5IF/SbManER9f55tIMlQgUznQJzLHM5XLY7uy6AUri+P/gx2TpgdtKiv53il4
         8G1Q==
X-Gm-Message-State: AJcUukeWJvNiyLo0IDmRCMGsVPhdbSyq/th/PDq85EtYyV3rRhC2fpHp
        TysfaTpuQ4zshOcZ7ANFOsnp8VYiyZE=
X-Google-Smtp-Source: ALg8bN6K9fNgfXo1ck94GRXMPR2aG8RyxF11gbG/I4yakWHQ9e2rdFD9fFkviTz2i1j3+wjA1uok2A==
X-Received: by 2002:a67:f31a:: with SMTP id p26mr5093858vsf.113.1548438241979;
        Fri, 25 Jan 2019 09:44:01 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id e67sm37305517vsd.32.2019.01.25.09.44.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 09:44:01 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id e7so6155776vsc.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 09:44:00 -0800 (PST)
X-Received: by 2002:a67:e15e:: with SMTP id o30mr5147081vsl.66.1548438240350;
 Fri, 25 Jan 2019 09:44:00 -0800 (PST)
MIME-Version: 1.0
References: <20190125145526.7106-1-colin.king@canonical.com>
In-Reply-To: <20190125145526.7106-1-colin.king@canonical.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 26 Jan 2019 06:43:47 +1300
X-Gmail-Original-Message-ID: <CAGXu5jLaXLNq_EGffGkadXAONYmqmg7ypDhf7MGN-X++5TJXDQ@mail.gmail.com>
Message-ID: <CAGXu5jLaXLNq_EGffGkadXAONYmqmg7ypDhf7MGN-X++5TJXDQ@mail.gmail.com>
Subject: Re: [PATCH][V2] selftests/seccomp: fix test failure on s390x because of
To:     Colin King <colin.king@canonical.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 3:55 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The error return being placed in regs.SYSCALL_RET is currently positive and
> this is causing test failures on s390x. The return value should be -EPERM
> rather than EPERM otherwise a failure is not detected and errno is not set
> accordingly on s390x.

Ah, hm, interesting. Yes, the selftest was accidentally encoding the
wrong details. However, I think the test for the result is a bit more
broken. EPERM is 1, so there isn't even a sanity check that the result
is getting passed down (the -1 from syscall won't tell us if the errno
actually landed too, so we need to check that with something that
isn't EPERM).

Let me send a patch to test on s390...

-Kees


>
> Fixes: a33b2d0359a0 ("selftests/seccomp: Add tests for basic ptrace actions")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>
> V2: remove misplaced Content-Type and Content-Transfer-Encoding fields
>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 496a9a8c773a..957344884360 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -1706,7 +1706,7 @@ void change_syscall(struct __test_metadata *_metadata,
>  #ifdef SYSCALL_NUM_RET_SHARE_REG
>                 TH_LOG("Can't modify syscall return on this architecture");
>  #else
> -               regs.SYSCALL_RET = EPERM;
> +               regs.SYSCALL_RET = -EPERM;
>  #endif
>
>  #ifdef HAVE_GETREGS
> @@ -1850,7 +1850,7 @@ TEST_F(TRACE_syscall, ptrace_syscall_dropped)
>                                            true);
>
>         /* Tracer should skip the open syscall, resulting in EPERM. */
> -       EXPECT_SYSCALL_RETURN(EPERM, syscall(__NR_openat));
> +       EXPECT_SYSCALL_RETURN(-EPERM, syscall(__NR_openat));
>  }
>
>  TEST_F(TRACE_syscall, syscall_allowed)
> @@ -1894,7 +1894,7 @@ TEST_F(TRACE_syscall, syscall_dropped)
>         ASSERT_EQ(0, ret);
>
>         /* gettid has been skipped and an altered return value stored. */
> -       EXPECT_SYSCALL_RETURN(EPERM, syscall(__NR_gettid));
> +       EXPECT_SYSCALL_RETURN(-EPERM, syscall(__NR_gettid));
>         EXPECT_NE(self->mytid, syscall(__NR_gettid));
>  }
>
> --
> 2.19.1
>


-- 
Kees Cook
