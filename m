Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2924715-1524138460-2-12350310529238381655
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524138460; b=SqR9hN9Ebh7E/1kU6g0aRV0jjhae0qbLLKvMZZKRbpL6f2S55/
    hFve5aoS9YaeJpAskqh3xNArdGlbcW2tGhtS166YQWndCUqrQkY3PnYZKWkWx1TQ
    fOrXhN91M4k/3cONibLIJDSkdj2lDIi++BEOJ9m9Ru/Oa8zDzN4Q/ca4q2rfdDPO
    RhOwUGooAJpUR5DkyCH8TGbmLvsdYZrxsCMs+HbYP1E5xJGEw70lib/rdalnQyKy
    cHPFJotUu/IgQIU32eMGyBwyoFcmjK3zsGJyMpqXlWFQfk41cl6h5iKFIAl9yrXN
    k8V2h2fpnlYpVPSL5i/jLGjqValyBf/ji8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524138460; bh=3BEt/UDyEtm2qzZspEMei7cQK4aeU1P9d1u9IK2Wj3
    M=; b=bAVboQhP6s5OQ4YdkJqWFx5PVvgZ2AXPma0Bx8otPtWVTiWxAwOXWPEDQD
    t2OZPLCAvAFUX4NIfMNUlnwx9DRtqziKFJtytAm9ygFNNNK8b2GZrjNVBwc573WL
    7nV5dBaZfhz1kYyacx0twzePewLO0539npsBe6vAe/GKLib7cv7xaZl3sASn7CO3
    NIzuopTdCxn8o/PeuSnqE+/ZEXkOPe3Njs176ps6SlwiQgZ+OcsoRPot/Ujyq9qF
    U2/rPe7qXt+wLo194zzw/9Q87sjgnw0IVFDwTQUd9KXiBLMr6Mp2DDcd312YNZZV
    v274C1wcBiQwoDsHPSw3SlBS6ukA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CvaT5QYg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=T7iKqFVX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CvaT5QYg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=T7iKqFVX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPz7/tRER1bCFrNe/L5wLnCy2vV4E50dzYoRzctN/e8Q6aJePG/udRqVuFQohLJcY4Z3ae52K760Px6J0pcBCw0bH3H95e9pBiS+nwEts6XqCpJWp/Do
    EV4tthkK2jZBaHg/PgDRcHa5poE0vfCDqJCSrrX0euvF+SRNSF+tPGQ0NNyTUM3VYxlA5JNshxguDPcF5j2OJKYMRV/fZH3+t7jSYTKRCTl05eUwq5xz2Za6
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=trSJhBdePwiJULLil44A:9 a=QEXdDO2ut3YA:10 a=l1He_3m2cmAA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751159AbeDSLrh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 07:47:37 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40447 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbeDSLrg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 07:47:36 -0400
X-Google-Smtp-Source: AB8JxZqV/wlmi6CyyIxgzShKDw2R/+UG167boguyBX/njR3GYmhqDj5DWlh0rFjxgB2LN7yMAWeMV4BIJVUG8+LlXQI=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0-n-Qabdr+5hwjq8wa9nZHtFwcE32WsW8ZTbKjtpiBUQ@mail.gmail.com>
References: <CAK8P3a0-n-Qabdr+5hwjq8wa9nZHtFwcE32WsW8ZTbKjtpiBUQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 19 Apr 2018 13:47:35 +0200
X-Google-Sender-Auth: -yCZo7Eo259Hm1iWnwXKdTtCwa4
Message-ID: <CAK8P3a3vS1AWHGMmGchQOrkV40GESNuJHQfZF-YDtOwZ1Z18Dw@mail.gmail.com>
Subject: Re: [tip GIT PULL v2] y2038: timekeeping syscall changes
To: Thomas Gleixner <tglx@linutronix.de>
Cc: y2038 Mailman List <y2038@lists.linaro.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 1:45 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
>
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
>
> are available in the git repository at:
>
>   git+ssh://gitolite@ra.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
> tags/y2038-timekeeping

That one is still messed up. I changed my .gitconfig to have a
different "insteadof"
section, but for some reason that failed. Obviously the URL I meant is

git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
tags/y2038-timekeeping

I've never figured out how to configure this correctly and try to
manually edit the
pull request, but forget to do that half of the time.

      Arnd
