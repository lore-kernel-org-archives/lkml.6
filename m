Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1163969-1520621662-2-13266256754217126918
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520621661; b=Pp9vRWYGkQ9v4xX2AZnAlNNkG2UhHnA6tQgjhgjoWKULy47
    /8eWiPg/NxrHH9OJtQmfl3nN/Fp1S5j13+fcT8OhWApUb6z+H359aY88LjxqgRY3
    oJ3O4knlFFFqaH5KUY/Q0mxYVoPnFRM5F1HdbtiSL5kBkS6X3EZJsK23Pxf0qhm0
    7scZf7/74e98YUU2nVV0TvZZgKpOPaC7Z1yJ858Fr0fKUX+uWwHzi3MyOTLHrTAW
    S1zaaxKf/ujC8gD53QuDfjwjesvfQSptnHOJIuILUMUdXQfs0cQ6CbsYXYgaLHpo
    zgEd2eN7XqNOOW9G+Ino8trdNDInCMrVrbNeGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520621661; bh=1O54vIidFWG01HHlBJE2oS+escbazB7GvJkt/0
    vjoMc=; b=uvpNXR3nKC6BwyYjZXqfQ8T7jKhhantRM1h+aFIxqrK5JF+1PH4BPj
    B+zmO7A7fx7I+yxE1dWXhD5RThwnkrwFVLQhgDuWIVOBWcbp6Uxaeb1NlhGcVwvK
    CnZ8/zSR1csRz8P04d6pxgJnju14uGD29d+vetnQk40Szh7WSOFIXpzKyfE82rMc
    kxHbPWimEBplnzxPrvxclKgHPl+N72F/8V2LlkXY6Ad6YU3nHOrAGMHAv1czwxGb
    ly0Y2o7J8YFD5tcIpVVlKDHW0fKZCNa3yCU4gmi+leH+LC6FfsrNGR9AOqaS3M8C
    46/R0zPviitHsqBFAP1iPBaBBtr/wiqg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=E9AAlLL6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=n+u5rPtq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tfDT4uLA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=E9AAlLL6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=n+u5rPtq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tfDT4uLA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932074AbeCISyO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 13:54:14 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:41025 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932546AbeCISyM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Mar 2018 13:54:12 -0500
X-Google-Smtp-Source: AG47ELsu1znFBZrVQZQa9LfVHvsoVzBqRYDYsWF8jULq55ZcJOroB7t0Yg28yZp7yUB+l8FuDFFraKcJcEmNae0mqmg=
MIME-Version: 1.0
In-Reply-To: <CA+55aFzJEkUGfRkKqc8twaDSdSH_r_OWnFm-e4uNQf4SrJy7-A@mail.gmail.com>
References: <C94A45E9-54A0-446D-86D6-82D06E2A35CD@amacapital.net>
 <87478c51-59a7-f6ac-1fb2-f3ca2dcf658b@fb.com> <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com>
 <20180309.133509.1275903267249306409.davem@davemloft.net> <CAGXu5jJcuSojm_KN5+JQ3fV6J09V6dmNB6haqu11xkXTq=nxog@mail.gmail.com>
 <CA+55aFzJEkUGfRkKqc8twaDSdSH_r_OWnFm-e4uNQf4SrJy7-A@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 9 Mar 2018 10:54:10 -0800
X-Google-Sender-Auth: 2v0TFcJuFVGk-vCxVyRqJPr07_k
Message-ID: <CAGXu5j+-M1zWUrA8uX1=f46t2RAym6N-T_Sf8T0P1wFCMhNCAQ@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@fb.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 10:50 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Mar 9, 2018 at 10:43 AM, Kees Cook <keescook@chromium.org> wrote:
>>
>> Module loading (via kernel_read_file()) already uses
>> deny_write_access(), and so does do_open_execat(). As long as module
>> loading doesn't call allow_write_access() before the execve() has
>> started in the new implementation, I think we'd be covered here.
>
> No. kernel_read_file() only does it *during* the read.

Ah, true. And looking at this again, shouldn't deny_write_access()
happen _before_ the LSM check in kernel_read_file()? That looks like a
problem...

-Kees

-- 
Kees Cook
Pixel Security
