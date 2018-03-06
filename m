Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1545212-1520376421-2-4668565454619868039
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='ws',
  MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520376421; b=aX/V3ltMMZKsFjCbjnQRbdZ5a7CVcuPI66V8HUIjLaDJlf+
    zfCLUSzozMc8eDLjLWVOvcjVYKqKa8+QumoobZ89ZVCamwvXNFuOt+I4Q8eoZnM0
    1xx62ZiE+2Akd8guGpiRaB3gH8nXJcuiRSYguEZ2jb/18dvajaXDD3JWFv3OPDEs
    uL2YZ9c5otk71l7F690I8dNJMmOwvdOayJwKj1kdK55IlvoWEWwsaSTBaO0HvcYH
    cZqI7mgAzkDAMIospOub+rz5bor0wF5tMgNBkFa4URodVjzyQDbCvJjp9ZB9rh9J
    NxU4CC9PF0L51auZSwG9U3JdmkzgXkh71AatlMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520376421; bh=2Ppuc5DcHuQbd+NGeo1IWErd08
    kPSG19B+FH0xqgIW8=; b=BG8KbPDy/aIU0gJiTZ9s6Z5DMFbjrUxXPIK6ZpJAki
    JJ2y1fCsbCYgm0RrxWu/P/jT27iCRyPFef9Clv14agm9FR1O2HnALtxc8Vf+PLLN
    JzacOAnA8r40QejOA6VehWF6DGpZ7FFEaiHuGjXKb8puQoeO2KARLx/J64GYsKkK
    8U8PknlId74A+IgvH85Tk9rcrI0RxCnmIwL4artM2E26b55RD/paSCyzRLKSnUci
    Xd9/7dZsT5I1Cd/0d7UbBDGwxueB7VHpYAY2ZHlu6HuEnefmRxRUGn5pPHOjPYOK
    6mUhjJ9Kd/tUaYFNqVOfZpKkCI2oThKQ9se2SS38WRWQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b=1gGEVSbu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tycho.ws;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-87 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FHx+xlWl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=tycho.ws header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b=1gGEVSbu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tycho.ws;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-87 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FHx+xlWl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=tycho.ws header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754133AbeCFWqn (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 17:46:43 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:39683 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754083AbeCFWql (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Mar 2018 17:46:41 -0500
X-Google-Smtp-Source: AG47ELudZqQuIuF3IitlTutjxwqCFou6hnw1uebc8n+J8hMfRpLu1Awcne/pimrhiqfZOfnMDIFTEg==
Date: Tue, 6 Mar 2018 15:46:36 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: Andy Lutomirski <luto@amacapital.net>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
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
Message-ID: <20180306224636.wf5z3kujtc7r5qyh@cisco>
References: <20180227004121.3633-1-mic@digikod.net>
 <CALCETrV3OZb70o83uOG437PubwBwaUJ6SKQucq_7g1BuBOmxzg@mail.gmail.com>
 <2e06621c-08e9-dc12-9b6e-9c09d5d8f458@digikod.net>
 <CALCETrWnJ7WkkfiymyahQd7YqO0KXP4mG1pRMq7fp8LG8Bwtcw@mail.gmail.com>
 <a70b41ee-78cb-52cc-152c-ac5e43b7e45c@digikod.net>
 <CALCETrUQYp0ta4tLgUWJ79pZVwp3WRY7cp-XaPcn1WyTc=wZyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUQYp0ta4tLgUWJ79pZVwp3WRY7cp-XaPcn1WyTc=wZyg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 10:33:17PM +0000, Andy Lutomirski wrote:
> >> Suppose I'm writing a container manager.  I want to run "mount" in the
> >> container, but I don't want to allow moun() in general and I want to
> >> emulate certain mount() actions.  I can write a filter that catches
> >> mount using seccomp and calls out to the container manager for help.
> >> This isn't theoretical -- Tycho wants *exactly* this use case to be
> >> supported.
> >
> > Well, I think this use case should be handled with something like
> > LD_PRELOAD and a helper library. FYI, I did something like this:
> > https://github.com/stemjail/stemshim
> 
> I doubt that will work for containers.  Containers that use user
> namespaces and, for example, setuid programs aren't going to honor
> LD_PRELOAD.

Or anything that calls syscalls directly, like go programs.

Tycho
