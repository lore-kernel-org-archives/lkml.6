Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D843FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98249205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wdh+N58g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbfAQAam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:30:42 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37236 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfAQAam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:30:42 -0500
Received: by mail-vs1-f66.google.com with SMTP id n13so5177106vsk.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 16:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Em7wk3PyXe6w9y715u3c0jeiIc9iephmG7LGebWN4w0=;
        b=Wdh+N58gIadlymwOVRbR0OeuAsY1VhqqQ7zUGaQn1F2tntLbW7geB04NmnIJ99U6+3
         fgSX/DwVfNpGrpEnaD44Hjg1mK617Wr/jowMeiwqzEbxvh3xbIgK5iOTHV/yIyUscGrG
         s7nC+ag3iXnZk7oDb+eQNm+d6+46T3UVx43+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Em7wk3PyXe6w9y715u3c0jeiIc9iephmG7LGebWN4w0=;
        b=e8TqSf86Lz8RpwaE6iwEoDoO3GRIpezmMCBuWspoAG0o/9IRYxjWF1CBx+URRdrm1t
         wAsVXhyKmYyhvy+cfWDFXgESbRmOPypejbpp4Hg3M9Qo5eZRh4HrWy6vDT7m1xQsr9e9
         4X5/gvG9x3bSq2RzcNwvPwTvFr9J0/m2vPnaQ8uojBxnPEkBb0S5vVYZb0bAyjYaAv8c
         0Yo4acKzbnsOJBbPSYmmnKLw2kFJF9Kr3Wgwe8WNp/TACQe+rZHdBA+u47dGZbwT9EU2
         YWlSwAqKSuu8qxk391wi1l0kIM8JyWnGHm2jKZP3Pr0SOaGGa/47qIafQxtt5ppQx7PX
         KNmg==
X-Gm-Message-State: AJcUukdvfZ3y3QYCoOlwXdxdJtCg58rJdSLmKzSOuHrsNeI2xIVB/u73
        kgsK04vn+QzIQIuBGl6qbHxi2AWBmRk=
X-Google-Smtp-Source: ALg8bN4cJocpLVtnstt7vqPNJ598/AbUKO0zi2CIhDIZkg3s4etM816+FgjGScYd+E5jMKmW3UoLNA==
X-Received: by 2002:a05:6102:391:: with SMTP id m17mr5116755vsq.100.1547685040537;
        Wed, 16 Jan 2019 16:30:40 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id n206sm55408402vkn.36.2019.01.16.16.30.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 16:30:39 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id y14so1893119vkd.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 16:30:38 -0800 (PST)
X-Received: by 2002:a1f:4982:: with SMTP id w124mr4656998vka.4.1547685038416;
 Wed, 16 Jan 2019 16:30:38 -0800 (PST)
MIME-Version: 1.0
References: <7cd7d5bc-1d69-57f5-4a98-81b036f81682@kernel.org>
In-Reply-To: <7cd7d5bc-1d69-57f5-4a98-81b036f81682@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 16 Jan 2019 16:30:26 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLGqXstRCmM1_fxUxn4djs1YLUun2Fc8ExcaN4-CKyELQ@mail.gmail.com>
Message-ID: <CAGXu5jLGqXstRCmM1_fxUxn4djs1YLUun2Fc8ExcaN4-CKyELQ@mail.gmail.com>
Subject: Re: Linux 5.0-rc2 seccomp_bpf user_notification_basic test hangs
To:     shuah <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>
Cc:     James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 4:01 PM shuah <shuah@kernel.org> wrote:
>
> Hi Kees and James,
>
> seccomp_bpf test hangs right after the following test passes
> with EBUSY. Please see log at the end.
>
> /* Installing a second listener in the chain should EBUSY */
>          EXPECT_EQ(user_trap_syscall(__NR_getpid,
>                                      SECCOMP_FILTER_FLAG_NEW_LISTENER),
>                    -1);
>          EXPECT_EQ(errno, EBUSY);
>
>
> The user_notification_basic test starts running I assume and then
> the hang.
>
> The only commit I see that could be suspect is the following as
> it talks about adding SECCOMP_RET_USER_NOTIF
>
> commit d9a7fa67b4bfe6ce93ee9aab23ae2e7ca0763e84
> Merge: f218a29c25ad 55b8cbe470d1
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed Jan 2 09:48:13 2019 -0800
>
>      Merge branch 'next-seccomp' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security
>
>      Pull seccomp updates from James Morris:
>
>       - Add SECCOMP_RET_USER_NOTIF
>
>       - seccomp fixes for sparse warnings and s390 build (Tycho)
>
>      * 'next-seccomp' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security:
>        seccomp, s390: fix build for syscall type change
>        seccomp: fix poor type promotion
>        samples: add an example of seccomp user trap
>        seccomp: add a return code to trap to userspace
>        seccomp: switch system call argument type to void *
>        seccomp: hoist struct seccomp_data recalculation higher
>
>
> Any ideas on how to proceed? Here is the log. The following
> reproduces the problem.
>
> make -C tools/testing/selftests/seccomp/ run_tests
>
>
> seccomp_bpf.c:2947:global.get_metadata:Expected 0 (0) ==
> seccomp(SECCOMP_SET_MODE_FILTER, SECCOMP_FILTER_FLAG_LOG, &prog)
> (18446744073709551615)
> seccomp_bpf.c:2959:global.get_metadata:Expected 1 (1) == read(pipefd[0],
> &buf, 1) (0)
> global.get_metadata: Test terminated by assertion
> [     FAIL ] global.get_metadata
> [ RUN      ] global.user_notification_basic
> seccomp_bpf.c:3036:global.user_notification_basic:Expected 0 (0) ==
> WEXITSTATUS(status) (1)
> seccomp_bpf.c:3039:global.user_notification_basic:Expected
> seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog) (18446744073709551615) == 0 (0)
> seccomp_bpf.c:3040:global.user_notification_basic:Expected
> seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog) (18446744073709551615) == 0 (0)
> seccomp_bpf.c:3041:global.user_notification_basic:Expected
> seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog) (18446744073709551615) == 0 (0)
> seccomp_bpf.c:3042:global.user_notification_basic:Expected
> seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog) (18446744073709551615) == 0 (0)
> seccomp_bpf.c:3047:global.user_notification_basic:Expected listener
> (18446744073709551615) >= 0 (0)
> seccomp_bpf.c:3053:global.user_notification_basic:Expected errno (13) ==
> EBUSY (16)

Looks like the test is unfriendly when running the current selftest on
an old kernel version. A quick look seems like it's missing some
ASSERT_* cases where EXPECT_* is used. I'll send a patch.

-- 
Kees Cook
