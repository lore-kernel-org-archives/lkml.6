Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3119161-1527022992-2-16282069069912763559
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527022990; b=A2D2qRctUD5QR1+cmVWf5Bp3a9490F4uhMyfAzLSsiWd7dnbvn
    1dlVPEgeuaVG4yok8got2qzwkbhKOMd1A0hRSsoLAddR4b1T6XVjScacMy/fSiVm
    MYHDP0tL4oDq9bqKxsjq5x4JGn1PUDkrvUVCNAE5ha24zAK86aZRfDtK3zvxuyX6
    xjdPyQnc2Jxu2XFBYr/HzHd/bwglID+TZykvLP8iQy3NFb6akRcQXC/WnvhCItUv
    j55KRpChp5paZtXIGM4/RS9HLaTfrvHcG6Ke9YjkbYOsyBD4uKJqt5trHe5VLNYp
    iY+ggCfNfVrnOwKO+HrBZvSvPML+lx7Qqj5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527022990;
    bh=6L0d6/JjwV88KLK36WrUwQuDAaggV8vvocGpcpluPQU=; b=a/OVMDlshSD5
    Y+Jv3ep7vtnJNSoQ7N4v7wzi0rV10FM/AyVeJfsNfaSp7cWl2cXe+GfbooTG0wAJ
    s1og0+c9UgT004xQq1RVM904YLzk4esjkvauxGjI1+iUE63buNn7wsBIKlKqcR3K
    jlSZbMHYbZP0Ri8hKXK6nYmg61N4yZiSPut7hvfefRmWQqU8mosR4oAStpLLLvkp
    1UZQoU9l8xxTeOVy8wCKXcnHMJsM6ANQo4DVLX9kRYI7efJDguStHWcWzVYPu9+K
    9a2hJ9g8W/mouoLWK3Z3lPqOYRZGoISrweySWq+wOWagoA3SBedmhDsknTm7+kY6
    xnOgzaS5SA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-foundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-foundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAsfPj2ruzkzwGOQAktsXEphc4ETMGlpvfS3nat/nrK2VOMnEkW3jhaa72hXwkrLmg96Q8tyC1bQZocEpbZm5f89eMzG2bZtDMjp2hh2AQ+38kteusyj
    zz6yRwmWxC/5BXnr/jO8hMbjK4yFg31cmfnOweo/v1bI9339Y3TZQKguLap0klDhOEHesAiYAclU3QW0E8qKOlRRk9IfbZcr8H/Od4f4ZOe95nZw7ax8CbBa
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=TYBLyS7eAAAA:8 a=VwQbUJbxAAAA:8 a=f2pcaBg-9aD8hFqme00A:9 a=CjuIK1q_8ugA:10
    a=zvYvwCWiE4KgVXXeO06c:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeEVVDI (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 17:03:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41994 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751575AbeEVVDH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 May 2018 17:03:07 -0400
Date: Tue, 22 May 2018 14:03:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Paul Menzel <pmenzel+linux-kasan-dev@molgen.mpg.de>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm/kasan: Don't vfree() nonexistent vm_area.
Message-Id: <20180522140305.5e0f8c62dcc2d735ed4ee84c@linux-foundation.org>
In-Reply-To: <4fc394ae-65e8-7c51-112a-81bee0fb8429@virtuozzo.com>
References: <12c9e499-9c11-d248-6a3f-14ec8c4e07f1@molgen.mpg.de>
        <20180201163349.8700-1-aryabinin@virtuozzo.com>
        <4fc394ae-65e8-7c51-112a-81bee0fb8429@virtuozzo.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 22 May 2018 19:44:06 +0300 Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:

> > Obviously we can't call vfree() to free memory that wasn't allocated via
> > vmalloc(). Use find_vm_area() to see if we can call vfree().
> > 
> > Unfortunately it's a bit tricky to properly unmap and free shadow allocated
> > during boot, so we'll have to keep it. If memory will come online again
> > that shadow will be reused.
> > 
> > Fixes: fa69b5989bb0 ("mm/kasan: add support for memory hotplug")
> > Reported-by: Paul Menzel <pmenzel+linux-kasan-dev@molgen.mpg.de>
> > Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> 
> This seems stuck in -mm. Andrew, can we proceed?

OK.

Should there be a code comment explaining the situation that Matthew
asked about?  It's rather obscure.
