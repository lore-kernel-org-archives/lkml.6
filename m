Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3527705-1520564796-2-18010449177189833991
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520564796; b=bYR/moIR1WE0+JW4+Io6qgsXACYCDkErhjEkcQlqQPzyuGY
    r4BAN0ziMHKiBtHRCRuQeKRBFrqMDXwolcrQ+9TRDRvnTnAdKkK0dtDa1N2stOYJ
    VmxprB172h2ofptVe1txy/pSvszxqaFnsY3lAD30gXAOqoc1E2GbEixHwARBsk2z
    4znpzKo2wnrqCb5aTv9JcUeYettOCzKdjaHDVCz+Fj2B6rRfBL159vtgpbmMB07s
    2RZZu21FTq2u2WPUYgGtm5PYY0A/5dXBRRezlriUibpKAON6B6Gcwec0ipaiZaDU
    4vNy/olUlKFl/qf7J0fsvPQUtEEwPoKJiQF7eLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520564796; bh=bLgOSCBsy8jVMfrHqA19fkGbosb0wpeA7EIh7o
    UqgM8=; b=L8JqwgZAQ+0OLPNvzAo1GXQo9g/di8v+356TS46nJn0UZFFOMwiE2I
    xzvRLeyZgDs8REKvGShx9dkurjROTciBQo5ltP9Yu7Fq5WWTLBLkvUNcBSKpU9/1
    rwKqEpYHW/9G7x4HFBb4qI8Wd3ccWcGib3T1Hb8sanzwW5Mwr2gcLmXzPtOAA47J
    UnUb0ZjnAP+l/CKMgPDnBHhvIHH9vFRbGMeoDym4lsxOQ4GEPTXPBiLH0DawIT1t
    K60WCj4o4MmtAKn6CV6iQQhv5JqkbRqGcwjZqlmXSK2tC9GFFjlhz6zobsLAqhPQ
    OW4Pym2gKuv1tNsLDZlX8mHm+hIZFzkg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HHe+pDeL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=k9U8x0fl x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jRvmxA5h;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HHe+pDeL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=k9U8x0fl x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jRvmxA5h;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750878AbeCIDGc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 22:06:32 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:34235 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbeCIDGb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Mar 2018 22:06:31 -0500
X-Google-Smtp-Source: AG47ELtIkBWna0RpYE1kmU0yIZqaYk4dUkg8qn5sEpuMr5IaNoFFstcKa2I3RzLO2fpJ9Cbu+51NtCnrXPwmD3nfejg=
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+B4wgT3ovynAxa1zwCeROfN5zK45tL1FUnFh0sg8M5AA@mail.gmail.com>
References: <20180306013457.1955486-1-ast@kernel.org> <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com>
 <CALCETrX=Vfk1T-XegwnjtUqeEsyUFXH1744d0yGkufQvDA5xkQ@mail.gmail.com>
 <CA+55aFwJPDub+tdShCgeTz3UejeskVE7_x+eQLq75mCjYPyP8w@mail.gmail.com> <CAGXu5j+B4wgT3ovynAxa1zwCeROfN5zK45tL1FUnFh0sg8M5AA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Mar 2018 19:06:29 -0800
X-Google-Sender-Auth: 6pSNBgBSKY_jhVLJoUuC6ljtzlA
Message-ID: <CA+55aFwRGDPvaCUgMtqnQHb2PZ77JSMQMQVf1znSN+PiV7NR-Q@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
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

On Thu, Mar 8, 2018 at 5:44 PM, Kees Cook <keescook@chromium.org> wrote:
>
> My concerns are mostly about crossing namespaces. If a container
> triggers an autoload, the result runs in the init_ns.

Heh. I saw that as an advantage. It's basically the same semantics as
a normal module load does - in that the "kernel namespace" is init_ns.

My own personal worry is actually different - we do check the
signature of the file we're loading, but we're then passing it off to
execve() not as the image we loaded, but as the file pointer.

So the execve() will end up not using the actual buffer we checked the
signature on, but instead just re-reading the file.

Now, that has two issues:

 (a) it means that 'init_module' doesn't work, only 'finit_module'.

    Not a big deal, but I do think that we should fail the 'info->file
== NULL' case explicitly (instead of failing when it does an execve()
of /dev/null, which is what I think it does now - but that's just from
the reading the patch, not from testing it).

 (b) somebody could maybe try to time it and modify the file
after-the-fact of the signature check, and then we execute something
else.

Honestly, that "read twice" thing may be what scuttles this.
Initially, I thought it was a non-issue, because anybody who controls
the module subdirectory enough to rewrite files would be in a position
to just execute the file itself directly instead.

But it turns out that isn't needed. Some bad actor could just do
"finit_module()" with a file that they just *copied* from the module
directory.

Yes, yes, they still need CAP_SYS_MODULE to even get that far, but it
does worry me.

So this does seem to turn "CAP_SYS_MODULE" into meaning "can run any
executable as root in the init namespace". They don't have to have the
module signing key that I thought would protect us, because they can
do that "rewrite after signature check".

So that does seem like a bad problem with the approach.

So I don't like Andy's "let's make it a kernel module and then that
kernel module can execve() a blob". THAT seems like just stupid
indirection.

But I do like Andy's "execve a blob" part, because it is the *blob*
that has had its signature verified, not the file!

             Linus
