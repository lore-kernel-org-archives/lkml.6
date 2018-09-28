Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4930FC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFDB206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT9DyV1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AFDB206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeI2EX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:23:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43599 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeI2EX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:23:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id z14-v6so7798859wrs.10;
        Fri, 28 Sep 2018 14:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9cQa7ak+L9r2UqapgK/q5NeEM1JpHTtVvZGL5jeuVyk=;
        b=AT9DyV1fcrf6RvzpBRBrs61PoCzcxAm/sXpelf4lDvwzixcMZqzBmVcHfWM2Cjpby/
         SgC52554sz3DsSxiq3dXuXXnwcAj8/BWTSA1S3Na0H1EIuvQyNW4hjzaR25AQEcrkxil
         VzVUFi6PRJI0fBJK7nkDs6ERq6+MzMJb6jpBSklPD9useUUZKvsdJ6RE0pM/CKpo3Mny
         N2PImM1YqoPVrYzUvcI7ZNnv+31jUNe31V6q93+xp3km3DZKY9of/v6LZcEkMtRYJ3qY
         R1/vTCB4T6+fcPwC946MUWSscolGT3+ne88D0Q52GXCPPaoG4nm+aDKRjPysPij3UPvC
         al5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9cQa7ak+L9r2UqapgK/q5NeEM1JpHTtVvZGL5jeuVyk=;
        b=ApGWN1OZOriZ/EXvVOX2G02YnuFeQEOEqj5LbwvHqnaY1yY38uKFsRsI2ZLm8U8RZj
         AoVwJJkOOBAKexQbA/m6G8Rtgg0Rs5fY/aGN748v7oIlwkBFBLHB6qQX6Dsil75cyD0L
         dxXDDa9T38zUURQY8nlbDhptWO2g0qqVBlZxEMTV+jBmuk1HdFIVNY6AFvzjXgx/DQ5b
         y0Cz7eiCuytAlgAZbl0pSh99cfhEucsfjNySlk1A0ksRCXwNNU77YzpqP/wvFbAxUPi2
         eBIP//m1HAijGLVD6Zaye8i1tOFB160J8Nl19B8FgXP28srBzGBEqkUJ7YnsZG1OMngP
         W+pw==
X-Gm-Message-State: ABuFfogHxPGok3J1Ve88ZBYIipFalofV5ncIDvYaY7qM859ZKzvdipFm
        AHxwspPN/hzm8mSV7vSNQOscWUw6wXY=
X-Google-Smtp-Source: ACcGV60SlS5Quhw0lu/ELfOItlmWf6KBEp7tl4HB9y369wjmrKA6VbFgk34iv6x1UWymi1wJaeQQBA==
X-Received: by 2002:a5d:6551:: with SMTP id z17-v6mr319421wrv.194.1538171862412;
        Fri, 28 Sep 2018 14:57:42 -0700 (PDT)
Received: from ?IPv6:2001:a61:2453:e300:e539:f1b3:2a96:5f83? ([2001:a61:2453:e300:e539:f1b3:2a96:5f83])
        by smtp.gmail.com with ESMTPSA id 200-v6sm6372385wmv.6.2018.09.28.14.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 14:57:41 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 0/6] seccomp trap to userspace
To:     Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>
References: <20180927151119.9989-1-tycho@tycho.ws>
From:   "Michael Kerrisk (man-opages)" <mtk.manpages@gmail.com>
Message-ID: <686fe047-16e6-3dfc-6284-ed574d97ad2f@gmail.com>
Date:   Fri, 28 Sep 2018 23:57:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180927151119.9989-1-tycho@tycho.ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tycho,

On 09/27/2018 05:11 PM, Tycho Andersen wrote:
> Hi all,
> 
> Here's v7 of the seccomp trap to userspace set. There are various minor
> changes and bug fixes, but two major changes:
> 
> * We now pass fds to the tracee via an ioctl, and do it immediately when
>    the ioctl is called. For this we needed some help from the vfs, so
>    I've put the one patch in this series and cc'd fsdevel. This does have
>    the advantage that the feature is now totally decoupled from the rest
>    of the set, which is itself useful (thanks Andy!)
> 
> * Instead of putting all of the notification related stuff into the
>    struct seccomp_filter, it now lives in its own struct notification,
>    which is pointed to by struct seccomp_filter. This will save a lot of
>    memory (thanks Tyler!)

Is there a documentation (man page) patch for this API change?

Thanks,

Michael

> v6 discussion: https://lkml.org/lkml/2018/9/6/769
> 
> Thoughts welcome,
> 
> Tycho
> 
> Tycho Andersen (6):
>    seccomp: add a return code to trap to userspace
>    seccomp: make get_nth_filter available outside of CHECKPOINT_RESTORE
>    seccomp: add a way to get a listener fd from ptrace
>    files: add a replace_fd_files() function
>    seccomp: add a way to pass FDs via a notification fd
>    samples: add an example of seccomp user trap
> 
>   Documentation/ioctl/ioctl-number.txt          |   1 +
>   .../userspace-api/seccomp_filter.rst          |  89 +++
>   fs/file.c                                     |  22 +-
>   include/linux/file.h                          |   8 +
>   include/linux/seccomp.h                       |  14 +-
>   include/uapi/linux/ptrace.h                   |   2 +
>   include/uapi/linux/seccomp.h                  |  42 +-
>   kernel/ptrace.c                               |   4 +
>   kernel/seccomp.c                              | 527 ++++++++++++++-
>   samples/seccomp/.gitignore                    |   1 +
>   samples/seccomp/Makefile                      |   7 +-
>   samples/seccomp/user-trap.c                   | 312 +++++++++
>   tools/testing/selftests/seccomp/seccomp_bpf.c | 607 +++++++++++++++++-
>   13 files changed, 1617 insertions(+), 19 deletions(-)
>   create mode 100644 samples/seccomp/user-trap.c
> 
