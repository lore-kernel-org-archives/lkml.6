Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1593260-1527357546-2-4176655683994717935
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527357546; b=ZP4p01z5QQ6l9Te/Yl92JnoPg2Rc4ECFirh02mQ/jsZfDVZqtc
    gL4ZQE6ts6Qsc4fxeAeG9zG/+2qsci8hSe67yEs9kZszKUNcN5SPQaSUBKwzhgnh
    8MBd+YKgWhTNUeDa7yNzISPPInEMSSFvr4WzsAJcKqgwjMMf2kWJ/UbpamVJelEY
    EXy1wAGN6zoA7F3baJM/80vFZVXQ94R9NO2ASsJAi7aSLnF4X8Z8YJM5cXch6gNd
    zCqvw5+7U5XdHdKSBNPjmJ3G6liG4WUSlKSaKnD4eNwJilsoHL1UyhXrK0mHy/7o
    VrudyK7pZ/ihRIElN6jT6q8lvF7M/tGuBnGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527357546; bh=ZsoFxGdYevRiHf1/7uuDKN/6oxDvo9
    CWRAD//BcIBKY=; b=BdSTbaJKPKyUzh1i5Os2d7jLZZj40cqyN6f6PNiINc+UBY
    +Mc3BvBQwFU+0ErSj7i6ITy3GTbXyut0e5oYuB3QgSaSpVfiiodCeCIf9NI5HULR
    BSvhiTrUzfL8gyO6esF3Z9cZoTRPsqJnY7QgMmt5wcz25BlyOWI7jujfioqs+0EB
    agtkXKioh1oMKHWX2l/8hDcgFNcuMDwzzjcHTGmS8BS8L4xiHiupO7QyYqP62jOZ
    rfCEiMaFZYWmrES+FULh57jlEIQ341GkZYTTbQ2DDSVClrvng+Ip5IKyaELYhcpa
    8fA1dFq8AWOL9tycqitif2i/VW7zt3VeKdQscVwA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=Ao9LMX9z x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=SwIn3kUF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=Ao9LMX9z x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=SwIn3kUF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLE5Yu+kQIFIjiSoNYCKElArplzVy3oJyWMM+msVkYTPvQdE4/CtN9XuOhZFE1rh8v93cMIfQzM7h4FMZuy7e3Oc5nSfuCIgvqTzlJYZJ+OXeeHQZWoj
    SxBjKtMaWDi4pYExI+IqNT44n064nSsLd78nrqYXvZqF1Rz89znVWKoX5yjuX8plTF73pFkX3ni71KcIE616fP5qzhkLY4QC0vqDNQXEfq2rVo8Tbf6s+ISd
    KZj19aBNeFYy7rjbcBOYwg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=aLjZf_mOksQA:10 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=P-IC7800AAAA:8
    a=VwQbUJbxAAAA:8 a=liBID9XXQtgZMFhj-poA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=d3PnA9EDa4IxuAV0gXij:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032115AbeEZR7D (ORCPT <rfc822;linux@kroah.com>);
        Sat, 26 May 2018 13:59:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51834 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032112AbeEZR7C (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 26 May 2018 13:59:02 -0400
X-Google-Smtp-Source: ADUXVKI52XOXjoBKE5wF2JAdWFk9yxWNA2sRGTO6vm/IwnplZkr2w/7Yqk+W3+9ubbW4MaiwdQKSxg==
Date: Sat, 26 May 2018 20:58:58 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] proc: prevent a task from writing on its own /proc/*/mem
Message-ID: <20180526175858.GA19115@avx2>
References: <1527346246-1334-1-git-send-email-s.mesoraca16@gmail.com>
 <20180526154819.GA14016@avx2>
 <CAJHCu1LgSUJdiZEfParCH7aLERWM1bgwC7e8wQKgmkNE01_4KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHCu1LgSUJdiZEfParCH7aLERWM1bgwC7e8wQKgmkNE01_4KA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 26, 2018 at 07:30:47PM +0200, Salvatore Mesoraca wrote:
> 2018-05-26 17:48 GMT+02:00 Alexey Dobriyan <adobriyan@gmail.com>:
> > On Sat, May 26, 2018 at 04:50:46PM +0200, Salvatore Mesoraca wrote:
> >> Prevent a task from opening, in "write" mode, any /proc/*/mem
> >> file that operates on the task's mm.
> >> /proc/*/mem is mainly a debugging means and, as such, it shouldn't
> >> be used by the inspected process itself.
> >> Current implementation always allow a task to access its own
> >> /proc/*/mem file.
> >> A process can use it to overwrite read-only memory, making
> >> pointless the use of security_file_mprotect() or other ways to
> >> enforce RO memory.
> >
> > You can do it in security_ptrace_access_check()
> 
> No, because that hook is skipped when mm == current->mm:
> https://elixir.bootlin.com/linux/v4.17-rc6/source/kernel/fork.c#L1111

OK

> > or security_file_open()
> 
> This is true, but it looks a bit overkill to me, especially since many of
> the macros/functions used to handle proc's files won't be in scope
> for an external LSM.
> Is there any particular reason why you prefer it done via LSM?

Well, it exists to implement all kinds of non-standard restrictions.

You're probably blacklisting mprotect() and worry that compromised
program might use /proc/self/mem instead. But you need to blacklist
much more that mprotect(). I think forking a dummy "worker" process
to open your /proc/*/mem and pass a descriptor back should still work
with your patch.
