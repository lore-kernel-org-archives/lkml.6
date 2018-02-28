Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2812402-1519776586-2-4942701408627090872
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519776585; b=ebqsU4uG4WOwHFRLrcrvwpe9eQK85DphQqgGVzwZz54doPw
    LFVdNk63zFvaehM85n33isDOf2eODpLxmPyrAUxdeNz2ysgzDulE6v3BeXhd5U+1
    zZYPStw6bQKhdofJA9+IXN9mxE+E8cL5yUmYh6xkC0QC94lUMLGKT2woZflW7gWN
    09oYvr833g1vXm7Cc6z1id8ZEjcMSsDByokT0t+WJOLaO3Id0b0Xfu/28anhKC2v
    1TyapQSHlLqF7zGSILzppvvOUxpr/q1ptTXEBYLxV4F5LHaiZVT7zcwipdYV0EdM
    +TPrgCOxV79sYG4QF9jItvJ/8raJ5XlsrpcQEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519776585; bh=5a51P0K34QVaufJVCCzeXCOYoFFbFUVX1zCDJxWQP4U=; b=K
    DYCitewoSGzwIh/ImHsFyLR/1GPLSgO/oaEGQSCUnfEsGe9p/OCYo3bqBeLi+Ki6
    5gcdakHrtlslmxyCjGRlvQBORxJjLZ8JKFV10i2aupYXJh8aWu/vSWL9WF6jkmvP
    BNMNcvWGPR8DM3EirXN8Rke2EPG4VFW9dyqgozDZOZN6noiWRjAMexoAv+jLmXh4
    343IgKIfldOH+N7PGFgpY0LJWK+u41Wa7+MVFInO3D9bmZfh2gWg4VWUQqAwMfg1
    nsOHN/kOts8f9PG/ZoEDbfaRiBEEZFHySZ/F/2iMA1f+yL3Ks019rtwczddixf3M
    tkZI6I7kEZzlzqAnKz1FA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbeB1AJh convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Tue, 27 Feb 2018 19:09:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751516AbeB1AJg (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 27 Feb 2018 19:09:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2E5217B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELv9MQPNywVrMFKXKd2G2yC63mR85s9x5qI6pySviLVpqUN1cIwfsMukZVa3zzt8MX8jCnUpU+gsLA7gzQ8c8CQ=
MIME-Version: 1.0
In-Reply-To: <f560a30d-10fd-31fc-adba-911961915937@digikod.net>
References: <20180227004121.3633-1-mic@digikod.net> <20180227004121.3633-9-mic@digikod.net>
 <CALCETrUpDbusLPyZijR6MpZd5-0x0d9KuQHBaavqP1_GZ2tjfg@mail.gmail.com>
 <D6B96EE0-8932-4845-BFA5-4C65E5189AFB@amacapital.net> <0e7d0512-12a3-568d-aa55-3def4b91c6d0@digikod.net>
 <CALCETrUTiUeV71jgYWup0CZwG8eQ3=W7X5FgJqmgPxnYbFsccw@mail.gmail.com>
 <CALCETrV_BVc44YYq6g8PCpeUYuqQaooVoQSQ7Y=VpuaBshQgQg@mail.gmail.com> <f560a30d-10fd-31fc-adba-911961915937@digikod.net>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 28 Feb 2018 00:09:13 +0000
X-Gmail-Original-Message-ID: <CALCETrW5v1sa17jPJuTskW5vdvcXqjFtRvAd0auWBmKvnAX-zQ@mail.gmail.com>
Message-ID: <CALCETrW5v1sa17jPJuTskW5vdvcXqjFtRvAd0auWBmKvnAX-zQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 08/11] landlock: Add ptrace restrictions
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
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
        Thomas Graf <tgraf@suug.ch>, Tycho Andersen <tycho@tycho.ws>,
        Will Drewry <wad@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 12:00 AM, Mickaël Salaün <mic@digikod.net> wrote:
>
> On 28/02/2018 00:23, Andy Lutomirski wrote:
>> On Tue, Feb 27, 2018 at 11:02 PM, Andy Lutomirski <luto@kernel.org> wrote:
>>> On Tue, Feb 27, 2018 at 10:14 PM, Mickaël Salaün <mic@digikod.net> wrote:
>>>>
>>>
>>> I think you're wrong here.  Any sane container trying to use Landlock
>>> like this would also create a PID namespace.  Problem solved.  I still
>>> think you should drop this patch.
>
> Containers is one use case, another is build-in sandboxing (e.g. for web
> browser…) and another one is for sandbox managers (e.g. Firejail,
> Bubblewrap, Flatpack…). In some of these use cases, especially from a
> developer point of view, you may want/need to debug your applications
> (without requiring to be root). For nested Landlock access-controls
> (e.g. container + user session + web browser), it may not be allowed to
> create a PID namespace, but you still want to have a meaningful
> access-control.
>

The consideration should be exactly the same as for normal seccomp.
If I'm in a container (using PID namespaces + seccomp) and a run a web
browser, I can debug the browser.

If there's a real use case for adding this type of automatic ptrace
protection, then by all means, let's add it as a general seccomp
feature.
