Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1242004-1520624391-2-12668132088969885500
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
    t=1520624391; b=Suj8jNlB8aUxX3ohB0eDzHbsp47vfR8DAK8RbCzac9vijtd
    878SkerPsqx/yb9tbI7TgwPVy/zTOBvPtTuaFHe7CDCvXZgx3NJRv81kGl5Av7J4
    JGcAcKVDwZxn0+24T9+DwHFIDJSVsGiG8Z/n0r5DcsRkMzfrCXwkJZ0iRjx8aPGH
    dZtsr1+FX9jMKvMBawAVyTkSZXzipQYFl1GC34b8KAhNAg9Z3+0/mB1tKntHP1GZ
    B4v1H5bVbezboirhio0iNEs2twRscUDXEAqT0QDQEVZ1VTTymj4FU+84Rlqo+Ka5
    MzhydkuawNn8lLZvBZhIj+dVVrMmz+FvdEEhzYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520624391; bh=l3tdNQcfZhkh1HlQ4JpuilcthCWcm1Vw8VHe2J
    B8mi4=; b=n4RTM3shiOauGNHx0y30zYWdweD9cMnkZoakX+fhQUi//FnL3E9x0I
    lLyQ1P3lTNSnOuMVTWKMt+B2N0iBV8E+N1h8pZVf9B6cF6lk1IIbNSwVGWpiTDC7
    hbGxLP451qNb59IOMBEpT322Dz8C6zMQS5VE9/Rki6YLgIHoQ+ntYwpsli3Ayke5
    vbdXjPpBRb5dsEJPuhirDdQ5jhBe4FzHJZAV7EHalS5PrlVgyXLOiRRGh/5NWC0l
    ftFE3DQb5qZt59TvVsubItDYC/Z0iFKttxhedAvoVrt4hMjFi2Tx8DO/aoDB85Fe
    c2F8lgvkNvyUYpR6eFj/e0Ds3QAMWG9A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HrbDoUHf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UnzXmp4E x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tbUD2Org;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HrbDoUHf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UnzXmp4E x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tbUD2Org;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbeCITi3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 14:38:29 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:40146 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932288AbeCITi0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Mar 2018 14:38:26 -0500
X-Google-Smtp-Source: AG47ELtDUIjZpS16hgEMfFfvwvEr6WvMqvj8hCbekQs56mKAPo+80EhmK5t/bWpEn9/v6jGMg4xLpFra4mSopnNlRRU=
MIME-Version: 1.0
In-Reply-To: <CA+55aFyN8JDh76bm1VinBvrgMH5jNL6RbuFAkrH8vuYU1s9GDQ@mail.gmail.com>
References: <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com>
 <E459E6CC-F51B-4F2A-9D26-FFB7166E0A47@amacapital.net> <CA+55aFx7w1s7=5HzeczPkkksaU4oVsWQf+_c=aHS0O7i_9g+Kg@mail.gmail.com>
 <20180309.135724.452219538059491199.davem@davemloft.net> <CA+55aFyN8JDh76bm1VinBvrgMH5jNL6RbuFAkrH8vuYU1s9GDQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Mar 2018 11:38:25 -0800
X-Google-Sender-Auth: MyQFvo6jolBuI_BnkZubaZEbPHE
Message-ID: <CA+55aFx-kDp87_uv9TW5pYD2+nr8c65=ervvwcxhTBJVg7c_pQ@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: David Miller <davem@davemloft.net>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@fb.com>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 11:12 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> How are you going to handle five processes doing the same setup concurrently?

Side note: it's not just serialization. It's also "is it actually up
and running".

The rule for "request_module()" (for a real module) has been that it
returns when the module is actually alive and active and have done
their initcalls.

The UMH_WAIT_EXEC behavior (ignore the serialization - you could do
that in the caller) behavior doesn't actually have any semantics AT
ALL. It only means that you get the error returns from execve()
itself, so you know that the executable file actually existed and
parsed right enough to get started.

But you don't actually have any reason to believe that it has *done*
anything, and started processing any requests. There's no reason
what-so-ever to believe that it has registered itself for any
asynchronous requests or anything like that.

So in the real module case, you can do

    request_module("modulename");

and just start using whatever resource you just requested. So the
netfilter code literally does

                request_module("nft-chain-%u-%.*s", family,
                               nla_len(nla), (const char *)nla_data(nla));
                nfnl_lock(NFNL_SUBSYS_NFTABLES);
                type = __nf_tables_chain_type_lookup(nla, family);
                if (type != NULL)
                        return ERR_PTR(-EAGAIN);

and doesn't even care about error handling for request_module()
itself, because it knows that either the module got loaded and is
ready, or something failed. And it needs to look that chain type up
anyway, so the failure is indicated by _that_.

With a UMH_WAIT_EXEC? No. You have *nothing*. You know the thing
started, but it might have SIGSEGV'd immediately, and you have
absolutely no way of knowing, and absolutely no way of even figuring
it out. You can wait - forever - for something to bind to whatever
dynamic resource you're expecting. You'll just fundamentally never
know.

You can try again, of course. Add a timeout, and try again in five
seconds or something. Maybe it will work then. Maybe it won't. You
won't have any way to know the _second_ time around either. Or the
third. Or...

See why I say it has to be synchronous?

If it's synchronous, you can actually do things like

 (a) maybe you only need a one-time thing, and don't have any state
("load fixed tables, be done") and that's it. If the process returns
with no error code, you're all done, and you know it's fine.

 (b) maybe the process wants to start a listener daemon or something
like the traditional inetd model. It can open the socket, it can start
listening on it, and it can fork off a child and check it's status. It
can then do exit(0) if everything is fine, and now request_module()
returns.

see the difference? Even if you ended up with a background process
(like in that (b) case), you did so with *error* handling, and you did
so knowing that the state has actually been set up by the time the
request_module() returns.

And if you use the proper module loading exclusion, it also means that
that (b) can know it's the only process starting up, and it's not
racing with another one.  It might still want to do the usual
lock-files in user space to protect against just the admin starting it
manually, but at least you don't have the situation that a hundred
threads just had a thundering herd where they all ended up using the
same kernel facility, and they all independently started a hundred
usermode helpers.

                  Linus
