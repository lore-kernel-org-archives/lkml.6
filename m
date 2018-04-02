Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1460654-1522629597-2-3531827876112723641
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='ws',
  MailFrom='org'
X-Spam-charsets: to='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522629596; b=pn1KUVN9x0iH9zHpXjG/1MOq+5KgaRptLEY+eGOIT8wfbvyi0d
    4xpzAKs1a+la6/eLZsDXJ9DfTWyARJtEtA+7Bj0GpWiJ7jU+2p3G5YwdEqb9vRxT
    yVPgyEsjjHudrIEreQl5vqttbEeF5TO8gMULMddjy9OvRIro0VidFYjoROaf76p/
    58k4cNILa7OU2QJOZXA+2hVThfs0rzIGMjE01/MLF/Z3P7Qu5CyNYgbg7yk/m0Eh
    J9+5K/1PKMxYoscXsaR5tULNPYUJUdrTUdEPiZFPwpuzKVUZJCC/rISfeAA9imzQ
    SPlIqOsbZIEJtkuqryBG4az7KzyN1dgHF2Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1522629596; bh=70igMOocwkU
    5fJgc6D70uGRY6kRo2MQgWb+32voD6Ls=; b=OSSLtm8Ja5HKm6BhtUn5zENkBnC
    ZP/pPkP+Z0Pd2GKt/IBVEUP911iwF2GyaRMYlX+uH6T0eipZYzRJqOl/JpEFfeo4
    cHz4Hh65eUTB/y+p1wDF5izmkuEBRVpU331qNC4SCdz7dkbnPtcHrg6vLj2Vit1G
    a2VfxurIwcgVsoxoNLISTP4mEjaZBZlo5/yDzRSic1f7Rj8t/JHSrMlCorjt0FTc
    2+9Y03E4c7kho7+jSqjYtepjxRk6bvKBdSsUb3+d7RWd5Uy+P0CddjZcoTAArLwC
    nLaHGeZq2ajvZ/639gmWkJfO5C7wSxQQaWtbPNXUjks6Jj5FqlR3BysWXEQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b=b5AfCCOZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tycho.ws;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=N2W9hNpe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=tycho.ws header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b=b5AfCCOZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tycho.ws;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=N2W9hNpe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=tycho.ws header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMrhvgOVWDqvRpB9MeUepMV9tiLBljy/wRFeWHyt18B2IgaXoKIosdXrdhXaHkE+Cxxmaimm4U+sTZJ4mx5lDNylzlhVN8SCrYJcmfKtH2Gt0b8WHDyN
    qP7N5TVtyTN0qgLSrX2FDdyRI+kT+n+DpP7XKen6Tb+5moKlr20UCNnLQ9SfBtbdwhmByhh2zTPXVs9x7P7bJ4cEaj2xiOWZ2yb8Hx0njMrN0w8IAotBQ2Fh
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=MKtGQD3n3ToA:10
    a=Kd1tUaAdevIA:10 a=MQS611LM3gAA:10 a=ZZnuYtJkoWoA:10 a=VwQbUJbxAAAA:8
    a=4TOrsNVTvR_Hwe2lIGEA:9 a=uO1-hO73FVxlRJVm:21 a=Hf3owglD95yOzAt6:21
    a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754033AbeDBAjx (ORCPT <rfc822;greg@kroah.com>);
        Sun, 1 Apr 2018 20:39:53 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46700 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754031AbeDBAjv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 1 Apr 2018 20:39:51 -0400
X-Google-Smtp-Source: AIpwx4+AepKkYqAl02z2nL9DWfarWiGEQ7Z2SzAb1+8+vkhxLJEN+gQJeDogN2f9k96iBPQvzE1bmw==
Date: Sun, 1 Apr 2018 18:39:47 -0600
From: Tycho Andersen <tycho@tycho.ws>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Drysdale <drysdale@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        James Morris <james.l.morris@oracle.com>,
        Jann Horn <jann@thejh.net>, Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Sargun Dhillon <sargun@sargun.me>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        Thomas Graf <tgraf@suug.ch>, Will Drewry <wad@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v8 00/11] Landlock LSM: Toward unprivileged
 sandboxing
Message-ID: <20180402003947.GE5586@cisco>
References: <2e06621c-08e9-dc12-9b6e-9c09d5d8f458@digikod.net>
 <CALCETrWnJ7WkkfiymyahQd7YqO0KXP4mG1pRMq7fp8LG8Bwtcw@mail.gmail.com>
 <a70b41ee-78cb-52cc-152c-ac5e43b7e45c@digikod.net>
 <CALCETrUQYp0ta4tLgUWJ79pZVwp3WRY7cp-XaPcn1WyTc=wZyg@mail.gmail.com>
 <20180306224636.wf5z3kujtc7r5qyh@cisco>
 <7082be04-d6af-b853-4bb7-f331836662e2@digikod.net>
 <CALCETrXT8JUXVwDNKGVRG7=aenthDRePD+T+YiDY6cceaazDeA@mail.gmail.com>
 <cd811155-9e0d-283a-9291-4adfcec848e6@digikod.net>
 <CALCETrUwkV4_65y7UjSgrq5WHOcZZ=+znKArehvhb1xEGG9HXw@mail.gmail.com>
 <0f355079-7ee2-c06a-2d47-a7a2fa6d98fe@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f355079-7ee2-c06a-2d47-a7a2fa6d98fe@digikod.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Mickaël,

On Mon, Apr 02, 2018 at 12:04:36AM +0200, Mickaël Salaün wrote:
> >> vDSO is a code mapped for all processes. As you said, these processes
> >> may use it or not. What I was thinking about is to use the same concept,
> >> i.e. map a "shim" code into each processes pertaining to a particular
> >> hierarchy (the same way seccomp filters are inherited across processes).
> >> With a seccomp filter matching some syscall (e.g. mount, open), it is
> >> possible to jump back to the shim code thanks to SECCOMP_RET_TRAP. This
> >> shim code should then be able to emulate/patch what is needed, even
> >> faking a file opening by receiving a file descriptor through a UNIX
> >> socket. As did the Chrome sandbox, the seccomp filter may look at the
> >> calling address to allow the shim code to call syscalls without being
> >> catched, if needed. However, relying on SIGSYS may not fit with
> >> arbitrary code. Using a new SECCOMP_RET_EMULATE (?) may be used to jump
> >> to a specific process address, to emulate the syscall in an easier way
> >> than only relying on a {c,e}BPF program.
> >>
> > 
> > This could indeed be done, but I think that Tycho's approach is much
> > cleaner and probably faster.
> > 
> 
> I like it too but how does this handle file descriptors?

I think it could be done fairly simply, the most complicated part is
probably designing an API that doesn't suck. But the basic idea would
be:

struct seccomp_notif_resp {
    __u64 id;
    __s32 error;
    __s64 val;
    __s32 fd;
};

if the handler responds with fd >= 0, we grab the tracer's fd,
duplicate it, and install it somewhere in the tracee's fd table. Since
things like socket() will want to return the fd number as its
installed and the handler doesn't know that, we'll probably want some
way to indicate that the kernel should return this value. We could
either mandate that if fd >= 0, that's the value that will be returned
from the syscall, or add another flag that says "no, install the fd,
but really return what's in val instead).

I guess we can't mandate that we return fd, because e.g. netlink
sockets can sometimes return fds as part of the netlink messages, and
not as the return value from the syscall.

Tycho
