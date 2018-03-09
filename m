Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3285773-1520557534-2-15186892509872399970
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520557534; b=a/teQV8g7FzQusG0ShS340F9Iw1yHbSI32jyJpp+qctRY9N
    3B/527zP9P6/XSFOv2a1qBLfGS+zf2nFGqlc7fcPRxbT5t9M1PnE8bHofAUc6Luz
    z1RdJORPZhsr+dDTD2rJYsITQqlpXHCyg4gjOZVgz0eWELbmSYKWVK+v5JZuu5fi
    zi7up5r+7u2BmfnzTAqjQh3jCIM6POYdpIPXMt3GQqRhkNqeE7NgBLzQhRFgjphy
    5p84ErOgV1EIFOYUOqQQ/gm8eHIwi4jdHQV0i7Zu+e9vNYJMAVgYtPb/dXrAQYll
    3wbPoBPH9lBZ6gNSpwn/oudeM0S1MJnyJt0edPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520557534; bh=0FW8b9Hacr//NULZnaXS+MybGfchVNlmvAA0iL
    kZThE=; b=ElWZzUnOU4LYY2X5ICXjlP1lLWJDam9mQ/hRrcHKA99Zs5lYD1eKOg
    paZPZJBXqHdIEwYJd2tOhhKrGSarlqP3MqaIGvfQ3vzJ8faPwbdt4EhIL08nFEEr
    V+gmcgcAvJwMfg5xEr5O1G9MvL26svTm/b/Fx/jN+5UeEBKvwJteaIXu61lN+GRk
    GCWDvJ7JmUp7KJvbWWI6YJLqVgRZwZl3WPNfIOr+dOtjzvjt6pbhjMBdUh66+yqX
    u55mW4tKegi6wVeAo1fhSFJ/RuHVN/PUOOwR0VkUh0jIlSK3YqJOiR54hrv3HwEs
    E76IbVneJwkq191IvnSQCcJgK9ZFzs7g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=QnWgMaVU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NnWEqDin;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=QnWgMaVU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NnWEqDin;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbeCIBFB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 20:05:01 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:42668 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeCIBFA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Mar 2018 20:05:00 -0500
X-Google-Smtp-Source: AG47ELtWsSqfiEr8AZUjzzqkZC1+/Y4cnoATfNkS77n5RAOtVUb9Y1tHkcXCkKc9XXJlMxKNEnUEGCV1SsJp8R4kjrI=
MIME-Version: 1.0
In-Reply-To: <357c330f-0165-b7a4-7ecc-4cd797e61e15@fb.com>
References: <20180306013457.1955486-1-ast@kernel.org> <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com>
 <357c330f-0165-b7a4-7ecc-4cd797e61e15@fb.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 9 Mar 2018 01:04:39 +0000
Message-ID: <CALCETrVUOToH5WnZMdpk+Vt=NK5OuE=ha62sj7cN5Hw5=qrgRw@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: Alexei Starovoitov <ast@fb.com>
Cc: Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 12:57 AM, Alexei Starovoitov <ast@fb.com> wrote:
> On 3/8/18 4:24 PM, Kees Cook wrote:
>>
>> As Andy asked earlier, why not DYN too to catch PIE executables? Seems
>> like forcing the userspace helper to be non-PIE would defeat some of
>> the userspace defenses in use in most distros.
>
>
> because we don't add features without concrete users.

I disagree here.  If you're going to add a magic trick that triggers
an execve(), then I think you should either support *both* standard,
widely-used types of ELF programs or you should give a compelling use
case that works for ET_EXEC but not for ET_DYN.  Keep in mind that
many distros have a very strong preference for ET_DYN.

Or you could argue that ET_DYN requires tooling changes, but I think
it's awkward to ask the tooling to change in advance of the kernel
being willing to actually invoke the thing.  I'm not actually
convinced that any tooling changes would be needed, though.
