Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1091448-1522880385-2-8469102695688032541
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522880384; b=GmB6PqtHcdrSKgz6r6ZlneL/iVoLop7mvwxGngd+UT9H2ykP+Q
    NAyj0fndtcLSXbN5yOAQtHSf6mWd7K8grzYRKqgbzgTYvEQmfoIS2YFb/9E2GTuN
    jxfBHbBeUCIQSGCmUKOLDiJFMYSRx0zC87VzkqmsL5DgaHiBOq4O2AgGsZDxoEvS
    pA3Q4E3TtxfAprYH7pYGYmPeUZuwqn4+ZhZFD/gtK72PNqny6S8EEEKHOalG/FhW
    HZJlxp3/dwdoK1pxEp4XLZpjtCt85vfpDgnjxCDr8SJlvNXj0PUuFXKwwEJqkcTf
    7h+Acn4L08VzCew20LxPuBm7e64zkqK5k5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to:cc:subject
    :mime-version:content-type:content-id:date:message-id:sender
    :list-id; s=fm2; t=1522880384; bh=iKXa7/nJwge7fvQtjvO2txoNZRWdop
    fpFFOCp2axUME=; b=WAd7hBu/v40OlUCnGwTKXVgjJhjy4Llf2vPHSyHa6YztQk
    m57BbFJXeaI96sKb+8GptKLhHZQKhv5xd8nmcacr3zKmWxhJvVJf+ODniM5vDOcd
    y07NlpykjK1wtC31qE+Gh5mYX4CzhMM016SrlUssjQi5D6cNum+FGybLNHnXhFxp
    SCa6Dn8AGXK8b6I+DH0umeWCqu/2eKqaPAlp17dWSyhI0fWIJvE/9+1Q3L11rxox
    SmhD3Iedwl2emrFpEPgb9BCmLVMsXKL5zdtTqGbLjwNb46p9BAIi+GFngYim7szi
    9y8DfACIlyKJuGrEJD34yy5YR648VVlCBPLGBWYg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJuUdnXrMEbUlySRNLO1P4tqbB9JqG8IKNlUVZf1RCEX49P78nz+m6+4X9c3lvZ5Rc8boWsBk9ZiH5pG3VWcw3w838nppbj0R/E0rshiqrJwy82FMyCa
    M4RnN3n5HFUZxF5jJmh45x5mZLi0ooGflVmCP5zUBSzeDQ75f4TWztJivph12hXW8klhKw6DbAGBx2vo9cc6j18u0FfSFT03/RJwfymiZSYQcXG/q+6dr6g0
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=gR4Rho1IovKi-j0URZMA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbeDDWTd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 18:19:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751749AbeDDWTb (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 4 Apr 2018 18:19:31 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAG48ez3edmZo1iFXqpvzOKNY0jLzcqa18KuoRrBaPyfp=7huZQ@mail.gmail.com>
References: <CAG48ez3edmZo1iFXqpvzOKNY0jLzcqa18KuoRrBaPyfp=7huZQ@mail.gmail.com> <CALCETrUVQLDC6_VEvuAbdCOuGrmcxohqTB6P8eyNojm9AryNkg@mail.gmail.com> <1119.1522858644@warthog.procyon.org.uk>
To: Jann Horn <jannh@google.com>
Cc: dhowells@redhat.com, Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: An actual suggestion (Re: [GIT PULL] Kernel lockdown for secure boot)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15405.1522880367.1@warthog.procyon.org.uk>
Date: Wed, 04 Apr 2018 23:19:27 +0100
Message-ID: <15406.1522880367@warthog.procyon.org.uk>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Jann Horn <jannh@google.com> wrote:

> > Uh, no.  bpf, for example, can be used to modify kernel memory.
> 
> I'm pretty sure bpf isn't supposed to be able to modify arbitrary
> kernel memory. AFAIU if you can use BPF to write to arbitrary kernel
> memory, that's a bug; with CAP_SYS_ADMIN, you can read from userspace,
> write to userspace, and read from kernelspace, but you shouldn't be
> able to write to kernelspace.

Ah - you may be right.  I seem to have misremembered what Joey Lee wrote in
his patch description.

David
