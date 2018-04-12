Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1772267-1523562211-2-2270279100225550484
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523562211; b=N5bKdeXEazgP+jc62pQrWICcnRUx0O//R32mueHTyI7rTeJSn9
    0K2dWz1tsYVncvvtJ+hDrcZaGFsrxuQpGaC1C5jOOnnRYIfWWXVqdX0em1+QrY70
    6QnfPYwjnbtdopjfPkUdfakVLEJyYvpK4sWyI8AvCaj44MUPUcEF8M+8C/qyFWg+
    vQSYi1JYFOxnS/cPgLpQtxVAPGTrOSL987jeRAngzHIPRY8Bn9YfbkvWVVN9fKzG
    gDS3Z5goBB9MY+VKiOBkJeSrUctfMcaKgJsOFJkQ3f5vKgIAPtZTvmYhO/FQrKy5
    bJDuy5CHeb86JtFWZYjt6J9r0Hsk9GuyFdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523562211; bh=V5lLiRVGyO1qYXl74HPXevbhKDKIbIFMq38/e84JYD
    4=; b=kbVLTwpQzjdwkVEj9r29zQfbbitCiug7fM2beEnAXfXj2HkNctHxMlgMtI
    HpkSwO5fgvOlZCb2YLqSkgpH/Icrzo/URFVjmlyptdmqePZzDH5WaSDbJN9Cwmyt
    D8TUn7RlMrdtaHp+jbyPy9BPzzrSQPTmNcjvZKBmOmg4O38KO4MVxVp6gjf37Yth
    grKZQqZVOgLYxg9cbz4XmL+OkzJA7UgAhAorSCafrmxT9OUDj9zlR52x24PRyc6K
    RsO5MJ11lf9i+a+JXDECl8qvh4jIbw7IzraNHtGnledIJfFXoVsqRlLgnmZvNzfU
    MFWpIB4cAS88BVE9GXTLe4DyL9qA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qg3JohWe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=mcezUZL5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SSxgWYhr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qg3JohWe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=mcezUZL5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SSxgWYhr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIJybnQPzdmtdQCC/10knHSMoVqxp+XIPjN65OCaSvwadc1lnmPwyIFebwVmNZbqN7cKJmUBQcy0DLT8uoB3glQ6Nl4I1JKDMMJ0LaJX8Iv/UH3N/Py9
    mYXd9aPmU9DM4n9WT8tY0NO1TFmk9ngQtxXVFCh8es67Uf6ZniY1kZO01h/wXU+pugx/HxtSJ/dORtMH+aaYP5jLUN0LBKVkVeuavvzx8kxjxlC3Rh5i3DHi
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=XSpy5CPPpacnjkX-MJIA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752970AbeDLTna (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 15:43:30 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:53089 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753223AbeDLTn3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 15:43:29 -0400
X-Google-Smtp-Source: AIpwx4/XUygamOkEA5vVLEESVcNh6k8fOTtHyn5i12c/pemb/5hEiAaKcP4L1V3rFPzoQKP0JnNltOksoeChoMh74JM=
MIME-Version: 1.0
In-Reply-To: <20180412192800.15708-13-mathieu.desnoyers@efficios.com>
References: <20180412192800.15708-1-mathieu.desnoyers@efficios.com> <20180412192800.15708-13-mathieu.desnoyers@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Apr 2018 12:43:27 -0700
X-Google-Sender-Auth: pNrTZMtEmfZIQ5AFRLMMzVmRw3E
Message-ID: <CA+55aFxcJ2V_1BoW0Cct=Kkp7REkgiU_BTimGdmoFmWHaWaZ-g@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 12/23] cpu_opv: Provide cpu_opv system call (v7)
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 12:27 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> The cpu_opv system call executes a vector of operations on behalf of
> user-space on a specific CPU with preemption disabled. It is inspired
> by readv() and writev() system calls which take a "struct iovec"
> array as argument.

Do we really want the page pinning?

This whole cpu_opv thing is the most questionable part of the series,
and the page pinning is the most questionable part of cpu_opv for me.

Can we plan on merging just the plain rseq parts *without* this all
first, and then see the cpu_opv thing as a "maybe future expansion"
part.

I think that would make Andy happier too.

             Linus
