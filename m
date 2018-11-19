Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD07C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF02220831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="heynQIj6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF02220831
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbeKTCVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:21:45 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36765 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729825AbeKTCVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:21:44 -0500
Received: by mail-vs1-f65.google.com with SMTP id v205so18048586vsc.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 07:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9nI9EDei5NGcqe3JqwT0iOoVckuBXoqey9NpE1OlEpQ=;
        b=heynQIj6O4SVyC4gy/+l1sSnO3mvntoxLfoOPd8OJ9bmkA+yC3Z2IBl8/38lfKcIuF
         aRo3LfvjtdUu/uYuewCmbji0PM7l+Tq5tp0G8Idy5Pl+8Uur1bYvolyW0DoBfoHMgyPg
         /ux2x+aQepTXIcuGpE6LAp/6/GMMRi64xb25vFsJBMwWkJ4fIVawh3MaoPbBaVNrykz8
         EkjLef5/ifRs/YjDkUtQa104wIhuk8jGJ/KXtHuWbrS1Vs+99YVvsJbUqngG5mzmTGMN
         /7B/UPC2IKp2U2s5NGepnaXVxEQ/q2KFQwaalRICQhvUueaKbiMnS49qJ0hoVbD9PzqN
         jHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9nI9EDei5NGcqe3JqwT0iOoVckuBXoqey9NpE1OlEpQ=;
        b=G9Zh1SANJpMdYKAQsyovBmVVkXehm9XQzpDwyuzZXQmFX5sZboNY1yojnqtoMMHACv
         lXLPTUp8G8nTWRxdTksYjaJgYWcnnGUTQ2QPDnC1KS3tqCu7Qq9qgd7B7cZ7+YPZhd32
         1NbU0tgT4wd1QuBq2WMaWPud9kSJbhkKRpJa+QmD7+pOU3Vof6/r1CVdmwqt61KhF4sU
         0QTGQp0XHyZzHSm3mANpPn7mw7Q25Kt6nyhGt13uBqfApnKnTxY5Op1N2AHhlh1EQTZh
         qq30iRi7KRypWHHtilDxEbHEPO6J6nkmhSmtkOVoUaznzP8hHsv0FCf7A/R60e6UWKCf
         KvEw==
X-Gm-Message-State: AGRZ1gJmOF+8tlFnDjbIVQKvFDl9/QvBFdYhYZKceEVCfzg7NIHFAYmO
        UAo5nXJYnFtWTr6Pvl+jIQcDd2Qr8yQX3/qtxShqNg==
X-Google-Smtp-Source: AJdET5fsmrfWBjEQ7O4vbGk6U2Q2/U8C3jneSc6fVHnMcxya2uScdtYIcpRWC3F2uuHr22242BKuLSUuSvtSWIhdu8A=
X-Received: by 2002:a67:6cc1:: with SMTP id h184mr9443264vsc.149.1542643063333;
 Mon, 19 Nov 2018 07:57:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Mon, 19 Nov 2018 07:57:42
 -0800 (PST)
In-Reply-To: <CALCETrUY=Hk6=BjgPuDBgj5J1T_b5Q5u1uVOWHjGWXwmHoZBEQ@mail.gmail.com>
References: <20181119103241.5229-1-christian@brauner.io> <20181119103241.5229-3-christian@brauner.io>
 <CALCETrUY=Hk6=BjgPuDBgj5J1T_b5Q5u1uVOWHjGWXwmHoZBEQ@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 19 Nov 2018 07:57:42 -0800
Message-ID: <CAKOZuev7WKSykBpQb7w_fDdcQRYVZME=OXqV3amqKzYbstmGng@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 7:45 AM, Andy Lutomirski <luto@kernel.org> wrote:
> On Mon, Nov 19, 2018 at 2:33 AM Christian Brauner <christian@brauner.io> wrote:
>>
>> The kill() syscall operates on process identifiers. After a process has
>> exited its pid can be reused by another process. If a caller sends a signal
>> to a reused pid it will end up signaling the wrong process. This issue has
>> often surfaced and there has been a push [1] to address this problem.
>>
>> A prior patch has introduced the ability to get a file descriptor
>> referencing struct pid by opening /proc/<pid>. This guarantees a stable
>> handle on a process which can be used to send signals to the referenced
>> process. Discussion has shown that a dedicated syscall is preferable over
>> ioctl()s. Thus, the  new syscall procfd_signal() is introduced to solve
>> this problem. It operates on a process file descriptor.
>> The syscall takes an additional siginfo_t and flags argument. If siginfo_t
>> is NULL then procfd_signal() behaves like kill() if it is not NULL it
>> behaves like rt_sigqueueinfo.
>> The flags argument is added to allow for future extensions of this syscall.
>> It currently needs to be passed as 0.
>
> A few questions.  First: you've made this work on /proc/PID, but
> should it also work on /proc/PID/task/TID to send signals to a
> specific thread?

+1

>> +       if (info) {
>> +               ret = __copy_siginfo_from_user(sig, &kinfo, info);
>> +               if (unlikely(ret))
>> +                       goto err;
>> +               /*
>> +                * Not even root can pretend to send signals from the kernel.
>> +                * Nor can they impersonate a kill()/tgkill(), which adds
>> +                * source info.
>> +                */
>> +               ret = -EPERM;
>> +               if ((kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL) &&
>> +                   (task_pid(current) != pid))
>> +                       goto err;
>
> Is the exception for signaling yourself actually useful here?

All the signal functions exempt the current process from access
checks. Whether that's useful or not (and I think it is), being
inconsistent here would be wrong.
