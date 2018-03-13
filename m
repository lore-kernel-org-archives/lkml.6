Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-220671-1520985436-2-7056541764362426988
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
    t=1520985436; b=BCIA6MmH6RV/XbIwBPWcAJMXLEqDhXYGZB62YNA4nDT4Jkt
    EHBDHr+lTahHT3BC7Ze3X2fLsqdBmSrceoHG4CDLyEyoSUU+Y4YhlpPD1DV/620t
    cAFG62+Er7LyT6Q6C0Ur4AjmjzyzLEh+RBSsu5MeyvBOObNKTX346dEoGRnNe7q/
    d8YpTUDIPI13T7RWWEVj3sVLwAxj0QJxPASo8HY5ZQe/5Sk7JKuhdCMb3070WE3Y
    FKjjNfpRSiQ3iplD8cS2tO9tfpe0kUoAbs6Oi0E7RXHzDbCMqIdirXTFUK3KaAT/
    uyTbjzCum1pQEtxfEIa7W3l9Sgo6KKmKOVCy/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520985436; bh=CNjYltqMPEYhv0wXWMZrt8c1fWFjQiBzINdAbu
    BFWi8=; b=AHr+3xkov1IZ/gq8I0qK+i2SKJORqaE5lud1sGQBZCsZaq7B79lIdR
    K8Z4kNRqGRbhCTGHXHZulUexUqnDh4Vvdi81FMRP4Dai5pufFNOFuPyncAiQPiNw
    yIkOJVJ094ehcYTct/aZYyQrHPgrJ+WEcta2CZpxN0WHtapfRXsfADwgdUuBBBec
    6NcaMJA51oLGMAQdZjQfuf2zGvEsTFTJGMyiFVw2Si72ucF2QvwUxaqvz9mK727D
    hPOOIBa4ReKWr48Apbsol56Ocnanlua5nhC5J0l81yBWN5cgNIbVdq+fbo1GkZaO
    elkXsMwhG7lv0A1xSbYj3FFd2Sa0gZ9A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
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
        id S932443AbeCMX5N (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 19:57:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753063AbeCMX5M (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Mar 2018 19:57:12 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3973217A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELvKfQGcHylyMZv/yJZRme5lq3Aeh1A4910Y9rqQ7KXdES09UjExmO2XCKtniOoUgUmeoiVlfcU5GF79A1KRqhE=
MIME-Version: 1.0
In-Reply-To: <20180313231627.1247-1-hmclauchlan@fb.com>
References: <20180313231627.1247-1-hmclauchlan@fb.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 13 Mar 2018 23:56:50 +0000
X-Gmail-Original-Message-ID: <CALCETrWWAB4FcDe=uUUBiq9YZ-jN1G7kNjdEw=Pwe1SSqyL5LQ@mail.gmail.com>
Message-ID: <CALCETrWWAB4FcDe=uUUBiq9YZ-jN1G7kNjdEw=Pwe1SSqyL5LQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: whitelist syscalls for error injection
To: Howard McLauchlan <hmclauchlan@fb.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
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

On Tue, Mar 13, 2018 at 11:16 PM, Howard McLauchlan <hmclauchlan@fb.com> wrote:
> Error injection is a useful mechanism to fail arbitrary kernel
> functions. However, it is often hard to guarantee an error propagates
> appropriately to user space programs. By injecting into syscalls, we can
> return arbitrary values to user space directly; this increases
> flexibility and robustness in testing, allowing us to test user space
> error paths effectively.

Temporary NAK IMO.  Specifically:

> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index a78186d826d7..e8c6d63ace78 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -191,6 +191,8 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
>
>  #define SYSCALL_DEFINE0(sname)                                 \
>         SYSCALL_METADATA(_##sname, 0);                          \
> +       asmlinkage long sys_##sname(void);                      \
> +       ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);              \

sys_xyz() is not just the syscall itself; it's also a helper that's
used for entirely silly reasons by various bits of kernel code for
quite a few syscalls.  Fortunately, Dominik has patches to fix that,
and Linus is even considering pulling them for 4.16.  This patch will
most likely conflict with the final result of Dominik's series.

Can you and Dominik coordinate a bit to get this patch or its
equivalent landed on top of Dominik's work?  It might make sense for
Dominik to just add this patch to his series so it can land with the
rest of it.  Dominik, Ingo, what do you think?

--Andy
