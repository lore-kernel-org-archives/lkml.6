Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1242004-1520624301-2-1140972206312222028
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
    t=1520624301; b=b9YWnAGOM8qgAaqAatnxYvFHxhVpi+AylMTVcMwjt6B+sck
    AHUBMpWyD/nPH1LL4MNLu1AKIuhzjuw2ng9Pgs09Z8mTOg/OgP3Mt65XUtgYIP+a
    A2xO2Fn2yImW3dipecymXkWXD9Ctddeeqs1cJXVj/vTX1pg1Okacfv1ktk1y3EZV
    l0PBpABt3TCXJio2IyJi0kE0zHzXSZMh2zjC4kiuYnWbUALtN65+hdXTGzW72ZkE
    V9Q0fBg/utG5GCC/BwBY2AgqL5Gh6H53Ncr7JzRum/YwbnwozoHGu94O7vfmaIcJ
    tbITtSz8F4x8Y/BnarjWBCcYuScHBDQ0//Ol+8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520624301; bh=iEoHAqD13dD7rcimRu24vB/nTHhgMcFIuGAc04
    O52TY=; b=c8tg9ic6nSO0nR4/neFpgFbXfFiuaDb1MUMhr4GOvWPqw6jvqyMmaj
    cyeS1zU5lEPeRJa+O2677nYzryD1rB6AiGaQ2EnxCmMGGsutiTqZHyugb+i5sddl
    j2STF72Thmz8Q8vWEs8hUZUvMwz71H/DZGxEMyDCuTItx7/1iJ6dVhG813pMZ9sW
    OEoKiPYpqkZdz6mrWvFuUsMDBU1IZg2y5dxMZw2XlzNuJuSJ2Lg5RmZXD1ZFQVHk
    8P5qM/4OeHuTHd7XoQ1wWk/aoMtvLVf+cMelwPmN3j/+SDUGiTkeLMJRfDaXUGud
    07Vf9uSDe+MXQPBddoCznKQ3G1BsSe2w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
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
        id S932304AbeCITiU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 14:38:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:44186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932183AbeCITiT (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 9 Mar 2018 14:38:19 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40972178C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELubHSN0a+PfvrrQo0tZbT2pBAxnwFpDwXTf3mAmAXZXxt+pf+GS15kHA2/5jFoshw/79rqmZUi9G4zas93gXzM=
MIME-Version: 1.0
In-Reply-To: <20180309.135550.385837861865623769.davem@davemloft.net>
References: <20180309181527.GA15803@kroah.com> <E622B120-3C3A-4A15-8E1B-6F7649038623@amacapital.net>
 <74e26cc0-9e72-f03b-5396-f3480921f234@fb.com> <20180309.135550.385837861865623769.davem@davemloft.net>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 9 Mar 2018 19:37:57 +0000
X-Gmail-Original-Message-ID: <CALCETrWYDfByh7=xiO9T7_fFGMwMvZxUu40bkMdO9HE3E6=1VQ@mail.gmail.com>
Message-ID: <CALCETrWYDfByh7=xiO9T7_fFGMwMvZxUu40bkMdO9HE3E6=1VQ@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: David Miller <davem@davemloft.net>
Cc: Alexei Starovoitov <ast@fb.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Daniel Borkmann <daniel@iogearbox.net>,
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

On Fri, Mar 9, 2018 at 6:55 PM, David Miller <davem@davemloft.net> wrote:
> From: Alexei Starovoitov <ast@fb.com>
> Date: Fri, 9 Mar 2018 10:50:49 -0800
>
>> On 3/9/18 10:23 AM, Andy Lutomirski wrote:
>>> It might not be totally crazy to back it by tmpfs.
>>
>> interesting. how do you propose to do it?
>> Something like:
>> - create /umh_module_tempxxx dir
>> - mount tmpfs there
>> - copy elf into it and exec it?
>
> I think the idea is that it's an internal tmpfs mount that only
> the kernel has access too.

That's what I was imagining.  There's precedent.  For example, there's
a very short piece of code that does it in
drivers/gpu/drm/i915/i915_gemfs.c.


>
> And I don't think that even hurts your debuggability concerns.  The
> user can just attach using the foo.ko file in the actual filesystem.
>

Not if the .ko is actually a shim that actually just contains a blob
and a few lines of code to kick off the umh.  But one could still
debug it using kernel debug symbols (like vDSO debugging works right
now, at least if your distro is in a good mood) or by reading the
contents from /proc/PID/exe.
