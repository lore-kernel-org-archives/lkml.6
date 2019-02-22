Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DC0C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E0E2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VsmQZX3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfBVRnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:43:37 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41174 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVRng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:43:36 -0500
Received: by mail-lf1-f66.google.com with SMTP id e27so2337016lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 09:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bU5UdZ6iYT+ZCp9/HUNxGc7BAk/Uq/vv4zTdsyOr9fU=;
        b=VsmQZX3tdylwFZ4Lwi0Kx/2FVzsQ7k2zCeAxNEZuLERlcaixuXrCJ+yWkVFdpCd1Gl
         lOXB0JCoFVe0BXcY8aY0aUeogmBO62o/nygFz9vstikKb1zOVRigdfyP78jcY5oGRkOy
         toh6BzeB2RdH3QzOJDZs6EHzqr1b4e8rHvASU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bU5UdZ6iYT+ZCp9/HUNxGc7BAk/Uq/vv4zTdsyOr9fU=;
        b=Si+JC83/GG2jUlc/o/MCLUbCD/Xmh70FXk90JsxT/vpAITdDd+2Hu1FAVLihVgstaE
         Nzr7Acqj7l8gJifjK7PRagPw4f9WzmX0Oz/u/VO7xtPEULWalUEXQX3MyMb9Ra9hGjOz
         u8tmbQZIj/qgnMrjNjAn6QI79TVLh01P1fpMCBoi5UuwjTPiV+UlWIgZSnPwREuU4zRO
         SoYVNk3ZRnIdlJmvuOP118TiawEOOL7dFsfB2XDgQupOny3ZfFnBkcsfq2+OeQP2G3sM
         IQJc1Spw4H3nnNHGar3viJdFGopVgOy5XXPNZsKoLUYzc6jJyoJHbxGSQDmtLC5j85B9
         q6WQ==
X-Gm-Message-State: AHQUAuZYJnER10NTdgJA3hfWQsy2R7aJZx3lQzIFSvjLLCJCfW0Or04F
        Y+e9f5YkBuBkH9thgs56X6nPRru/9Yw=
X-Google-Smtp-Source: AHgI3IboqTGvpOoq2toNO/TQ6fWzn+/ywXQoVJmbAFpwwh/KSJUZANsNfT3eSryoGOp4kFUgZPad9g==
X-Received: by 2002:a19:c48a:: with SMTP id u132mr2341837lff.16.1550857413142;
        Fri, 22 Feb 2019 09:43:33 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id n25sm641338lfe.70.2019.02.22.09.43.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 09:43:31 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id j1so2327203lfb.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 09:43:31 -0800 (PST)
X-Received: by 2002:ac2:4433:: with SMTP id w19mr3071940lfl.67.1550857410622;
 Fri, 22 Feb 2019 09:43:30 -0800 (PST)
MIME-Version: 1.0
References: <20190215174712.372898450@goodmis.org> <20190215174945.557218316@goodmis.org>
 <CAHk-=wjP4bEYCFaKZVG4kLWmYBctyfsW9jjhC91tiTk9WwB8Rg@mail.gmail.com>
 <20190215171539.4682f0b4@gandalf.local.home> <300C4516-A093-43AE-8707-1C42486807A4@amacapital.net>
 <20190215191949.04604191@gandalf.local.home> <CAHk-=wgJzNp0R3cVhjBPHTR4X9sOvHdqK4UVFfbsOKQ6L=A_eQ@mail.gmail.com>
 <CAHk-=wh9XrOykA5J9RQ7zaBio-S_D+1AE+rGnBYWSd==pCXh+w@mail.gmail.com>
 <20190219111802.1d6dbaa3@gandalf.local.home> <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
 <20190219140330.5dd9e876@gandalf.local.home> <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
 <20190220094926.0ab575b3@gandalf.local.home> <20190222172745.2c7205d62003c0a858e33278@kernel.org>
 <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org>
In-Reply-To: <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Feb 2019 09:43:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
Message-ID: <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 12:35 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Or, can we do this?
>
> long __probe_user_read(void *dst, const void *src, size_t size)
> {

Add a

        if (!access_ok(src, size))
                ret = -EFAULT;
        else {
.. do the pagefault_disable() etc ..
        }

to after the "set_fs()", and it looks good to me. Make it clear that
yes, this works _only_ for user reads.

Adn that makes all the games with "kernel_uaccess_faults_ok"
pointless, so you can just remove them.

(note that the "access_ok()" has to come after we've done "set_fs()",
because it takes the address limit from that).

Also, since normally we'd expect that we already have USER_DS, it
might be worthwhile to do this with a wrapper, something along the
lines of

        mm_segment_t old_fs = get_fs();

        if (segment_eq(old_fs, USER_DS))
              return __normal_probe_user_read();
        set_fs(USER_DS);
        ret = __normal_probe_user_read();
        set_fs(old_fs);
        return ret;

and have that __normal_probe_user_read() just do

        if (!access_ok(src, size))
                return -EFAULT;
        pagefault_disable();
        ret = __copy_from_user_inatomic(dst, ...);
        pagefault_enable();
        return ret ? -EFAULT : 0;

which looks more obvious.

Also, I would suggest that you just make the argument type be "const
void __user *", since the whole point is that this takes a user
pointer, and nothing else.

Then we should still probably fix up "__probe_kernel_read()" to not
allow user accesses. The easiest way to do that is actually likely to
use the "unsafe_get_user()" functions *without* doing a
uaccess_begin(), which will mean that modern CPU's will simply fault
on a kernel access to user space.

The nice thing about that is that usually developers will have access
to exactly those modern boxes, so the people who notice that it
doesn't work are the right people.

Alternatively, we should just make it be architecture-specific, so
that architectures can decide "this address cannot be a kernel
address" and refuse to do it.

                Linus
