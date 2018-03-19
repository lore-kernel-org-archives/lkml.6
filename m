Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1601348-1521425634-2-6076794968110435016
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521425633; b=QdEFPAyyZSDxgfq9KsBI4/D9Wa226UO7idPzJZ7wV99nmO0
    v89+lsZrhn3Xsh5Eo6kUKeEKLw0zIn5lKM9zeJmNMb8JCKecOhc8qtTIeSsJFdq1
    nD9So+PaXaHeWaMVfbYYXMI19hTZkzgEJvCT4LRx5ZfQGWAiUUbhHfl5DLfLmDYk
    8g32p62UFgE6yuSWbvQS2zBm/XCXSCtqrgqiAIFWbawJVOccIgN8uMw0YHPBrSzf
    XTnX3dCKpt5JCr0v9GaYx5/5huMWiV0AvYzUhK0x61qAQdiH1CCBzxJWSTL+HKsq
    bhSkk5klkZG4bj39Rc+aF7poWml+wG8IgDPzJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521425633; bh=4NCNjV7ar0yyVdXqhIjiXMFSpUF9orxiWzm8oP
    oD31k=; b=SKRn7ZHUyaJrYS9H/33TIGwJY9CGREUI0mlueWj32TxlDVtFJtBzaK
    0DwW+CB69RRaCpjnXnS4192kEJcjR+K6lG/ZlAsrIEWsERKBBY4M9/HkKYA0ZURQ
    SGc0tY5VaBeQd1873+l/kBCDwhpL6gVihKeT5BXfXRzlFqMz+zv8LfnyoXuywdis
    Ttn0gyc+qVaduQ8U2xOF0Cr9LBBle6HOe4VD6WE3nB3rc2tGCM+/IpLWFK+gLkTI
    udS5DxD+oM6J5ALgkbtDX8bXXHn3nOXK6GN+H5Hix5XYCbWXjabJPFYNzZXXoXPs
    6L9HP6ggVLNqxt7qufldJgrqKUXmtsdw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755184AbeCSCNv (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 22:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755146AbeCSCNr (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 18 Mar 2018 22:13:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54545217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELvx/9s0vz2PMItWgNW80IZpvJWro3AryBgnncHc9LD/WGk8dPvUhIR/ek+vY01J3MSIk1ZAOf/o7JHCsRwVF/s=
MIME-Version: 1.0
In-Reply-To: <20180318064738.GA22649@light.dominikbrodowski.net>
References: <20180313231627.1247-1-hmclauchlan@fb.com> <CALCETrWWAB4FcDe=uUUBiq9YZ-jN1G7kNjdEw=Pwe1SSqyL5LQ@mail.gmail.com>
 <f47e1374-43eb-d7c6-dd0a-5d530ff2b4e2@fb.com> <20180318064738.GA22649@light.dominikbrodowski.net>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 19 Mar 2018 02:13:25 +0000
X-Gmail-Original-Message-ID: <CALCETrWU4KDu+3U2Z6XpLcV5G9-ihesCdREdaGtO76spuHW-mA@mail.gmail.com>
Message-ID: <CALCETrWU4KDu+3U2Z6XpLcV5G9-ihesCdREdaGtO76spuHW-mA@mail.gmail.com>
Subject: Re: [PATCH] bpf: whitelist syscalls for error injection
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Howard McLauchlan <hmclauchlan@fb.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yonghong Song <yhs@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Garnier <thgarnie@google.com>,
        kernel-team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 18, 2018 at 6:47 AM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> On Fri, Mar 16, 2018 at 03:55:04PM -0700, Howard McLauchlan wrote:
>> On 03/13/2018 04:56 PM, Andy Lutomirski wrote:
>> > On Tue, Mar 13, 2018 at 11:16 PM, Howard McLauchlan <hmclauchlan@fb.com> wrote:
>> >> Error injection is a useful mechanism to fail arbitrary kernel
>> >> functions. However, it is often hard to guarantee an error propagates
>> >> appropriately to user space programs. By injecting into syscalls, we can
>> >> return arbitrary values to user space directly; this increases
>> >> flexibility and robustness in testing, allowing us to test user space
>> >> error paths effectively.
>> >
>> > Temporary NAK IMO.  Specifically:
>> >
>> >> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>> >> index a78186d826d7..e8c6d63ace78 100644
>> >> --- a/include/linux/syscalls.h
>> >> +++ b/include/linux/syscalls.h
>> >> @@ -191,6 +191,8 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
>> >>
>> >>  #define SYSCALL_DEFINE0(sname)                                 \
>> >>         SYSCALL_METADATA(_##sname, 0);                          \
>> >> +       asmlinkage long sys_##sname(void);                      \
>> >> +       ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);              \
>> >
>> > sys_xyz() is not just the syscall itself; it's also a helper that's
>> > used for entirely silly reasons by various bits of kernel code for
>> > quite a few syscalls.  Fortunately, Dominik has patches to fix that,
>> > and Linus is even considering pulling them for 4.16.  This patch will
>> > most likely conflict with the final result of Dominik's series.
>> >
>> > Can you and Dominik coordinate a bit to get this patch or its
>> > equivalent landed on top of Dominik's work?  It might make sense for
>> > Dominik to just add this patch to his series so it can land with the
>> > rest of it.  Dominik, Ingo, what do you think?
>> >
>> > --Andy
>> >
>>
>> Dominik,
>>
>> This patch applies cleanly on top of your patch series. Is there anything you'd need from me to get this in on top of your work?
>
> Howard,
>
> would this form part of the kernel<->userspace interface and therefore needs
> to be kept stable? If so, this patch should wait until the arch-specific
> syscall calling convention is agreed upon.
>
> Moreover, the patches I sent out already do not cover all syscalls yet.
> Until all in-kernel users of sys_*() are gone (or at least outside arch/),
> I'd prefer to postpone this patch.
>

I was assuming that this ALLOW_ERROR_INJECTION thing is *not*
considered stable ABI.  We should be free to change the way that the
syscall entry code calls syscalls whenever we like.

If you want a stable syscall error injection mechanism, make it work
like seccomp instead, please.
