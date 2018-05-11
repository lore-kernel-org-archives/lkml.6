Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-221214-1526066925-2-4448092711675111506
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526066925; b=bbSP/Fedsljo2+BROKmFvAxJQdGWgTjPxpHm97QId2pIo81rez
    frtP39ubUJXQYhRflug/P2agS0BsfRR2z/bsarqW995lesMQtvCLXdd1Yx6es/5u
    IpAWY1+Gh+6tvu7l7hpbpmZK+TJi33Zh9LbUFjVznONaExqq5wA4nErUtM7aNXL+
    1g2kyZdAt2Ay8kar15vmyhHP2gDhrlb6WRWBFxwvZD6yVJMFEV/uAfpyI6PiL1D8
    m+y44Z49JPs8FXdAYOC90UbIkyzsjYmfx4LT9M6a9EJETCCnm1XmLeIPVt+/8YjA
    NMCRKVIsIvZK8lNscHtQ2xp+EnTEdS05chpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526066925; bh=dWvsZWk7SZX8f7bHHt22lau2jwHVN3
    EB42QsNUFUZi0=; b=XjWpEGJHUYHydEnc2c0Af5IqEuRBWWzskfne7wGEescBTU
    MDg4fc2mcLG7QxLfQtTO3ewyOsU5znSlCzcraqYP/+T0UN3RdP9SnwhAbyQHfxaC
    jh4LnuKayA8NCHJw6yviPPtRZIGZINN2/XFVOmQnnOFwcVkp4uoBGPcEMR8OcUdw
    SvUZtJbi5UQ4Ht2/+fFrL54Uxp/vzLS+8nCJG1ng82iDk09IB/+GO2c153hHUY+o
    iv5niFsAby7bqCwSyA1zkDq1GJi7/4lPWPKd86Jzsq7hT6PbcE/BrPcxgpFddDxU
    l0t1dEkYnTCn7N45+8mJsXLFGEyQRSKnnzXSpg+w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=zeniv.linux.org.uk header.mx.error=NOERROR
    header.result=warn header_org.domain=linux.org.uk
    header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=zeniv.linux.org.uk header.mx.error=NOERROR
      header.result=warn header_org.domain=linux.org.uk
      header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKQTEbpEh0bKOyibngUN6T8YoCJGMHwzV7JTi0ydZuFa/H3ntH1trhRe2xDH1RHI2BqUBU69W+pwRCH89YMOoMRZNZ5lUgLsyn3pC34wwMSOMIrSqG5o
    7atrPTsSchSUWSJeXDWMLMFS24u2+iKSdAIVa1eINBz2uRtXogOSgGOdQWggDGoxilYezIFlsnoMT1zt2R3/YLN3knhWGDfwXXJEXinMfDYIJL8Krmp/kD3i
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=zJnW8gc2Vqe23zpo_3gA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751012AbeEKT2m (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 15:28:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57390 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeEKT2l (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 May 2018 15:28:41 -0400
Date: Fri, 11 May 2018 20:28:32 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: gladkov.alexey@gmail.com, Kees Cook <keescook@chromium.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        Ingo Molnar <mingo@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Solar Designer <solar@openwall.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Djalal Harouni <tixxdz@gmail.com>
Subject: Re: [PATCH v5 0/7] proc: modernize proc to support multiple private
 instances
Message-ID: <20180511192831.GC30522@ZenIV.linux.org.uk>
References: <20180511093221.GA902@comp-core-i7-2640m-0182e6>
 <CA+55aFwZK+BMsm19sK-Wmfta6PcdvW6z-ghuKsb4PAwk19nRVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwZK+BMsm19sK-Wmfta6PcdvW6z-ghuKsb4PAwk19nRVg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 09:39:23AM -0700, Linus Torvalds wrote:
> On Fri, May 11, 2018 at 2:42 AM Alexey Gladkov <gladkov.alexey@gmail.com>
> wrote:
> 
> > This is RFC v5 to modernize procfs and make it able to support multiple
> > private instances per the same pid namespace.
> 
> So I have no big objections, but I would *really* like this to go through
> Al's vfs tree.
> 
> Al? Have you looked at this series?

Looking through it...
