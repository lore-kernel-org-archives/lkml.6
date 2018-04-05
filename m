Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1647834-1522896042-2-11990692249594321399
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522896042; b=p6lT1yQ3GYfksPjf6gVxrNvGyVyvR2Cibk3g0lqPtMFXsCY6lD
    svzchraj93rK/MHSLdJqAERWyIQIFyOKecOlvTP4vagOHAV05tb0T8DdqfOQWI9Q
    +VPJtDUuG4nkDqco5jxnp+Ixz0hXmy4ApFKYLC+Zyc1jOOh/pkqZRv+wQvkfw3cq
    W1+G3IUE5foZYNDc0cQt+HM3psztG8t9cEQRRNH+0N7gK2oi253a611912LYrELH
    d9R9t5K8YgeEvRGhCGbw1rmb6Otc/6ZAcPnWO+52ovVN6hTQ+PcbzHYuvjBdYfrG
    f5ZAV+Byqf4066ZQ+ggXjldJA6XnnJU8fDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522896042; bh=ckGXvpfoPTu0nvbAZFYAm4asHzBvkx6Odf+ack5BgM
    Q=; b=NTPTMAeZa7QRsS87peMf2R0NYXhsWX7b98V4eXBJ5v1JH53cIXehqTIkYw
    0gvpyXjWoD8OOzTQFlynOJSU67kIq9gt+VIG3aWMO2bGV8iAttLInkW7l81OwMtC
    ywiDWSMNm3umCSG7geJGzB7xn+RtsvdCQ5HXSbEzx/d8fP5pFxSDYsZiWsuAT2Up
    F51njkazfUqU+t/5zZbgzNhwuca887+YyxyLFr+I6koiWeHP9L10dYT5E7v2qYX9
    K/Io96/VVALjDEXZtEpse9wtjj58rgGQXk3uuA0aslN2N6kr4wg/cvYW2kt8qSxD
    miwppHCxPTd8twwtjd6FvTKHbESQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WHnkoYhg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=XxrheMIZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XJvLcILL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WHnkoYhg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=XxrheMIZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XJvLcILL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF/EbYzq9kCfTtSlzXwipdwJKsJoMi36nAoG1NPk0ZkaHN3vZD6JttV9X6KXCNbbiKo7KYjimis6+5tq7PEX97tF506WkvMhGx3XoDZ1xrQgv1FP5g8s
    oWwK8O9t4X15yA62sSaw44VpYellC/3nK1VvtHVEarlzhd3aix2Bu3iEgbGeY0bM/jzj78Iwk46/+b86XnVBTfOzkQ3Trbyct4W7NrKgwRqiVne4LX2bn/vK
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=t-cLYTTVLO97x6vw7yIA:9 a=_m8XjxugoyUVboFR:21
    a=F5KUlKRhwtQCiOlQ:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbeDECki (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 22:40:38 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:50247 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752692AbeDECkh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Apr 2018 22:40:37 -0400
X-Google-Smtp-Source: AIpwx4/O1i+7CQ111HjX7ENforlHGr2jiQWUafbJK5wS4U0urRf8eK+btYnyLDRPsGSsk+NxFrD0+uIPkDpEXwjfr70=
MIME-Version: 1.0
In-Reply-To: <20180405045231-mutt-send-email-mst@kernel.org>
References: <1522431382-4232-1-git-send-email-mst@redhat.com> <20180405045231-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Apr 2018 19:40:36 -0700
X-Google-Sender-Auth: hnWAnsyrlTUF3LEz99u205EcLts
Message-ID: <CA+55aFwpe92MzEX2qRHO-MQsa1CP-iz6AmanFqXCV6_EaNKyMg@mail.gmail.com>
Subject: Re: [PATCH] gup: return -EFAULT on access_ok failure
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com,
        linux-mm <linux-mm@kvack.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 6:53 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Any feedback on this? As this fixes a bug in vhost, I'll merge
> through the vhost tree unless someone objects.

NAK.

__get_user_pages_fast() returns the number of pages it gets.

It has never returned an error code, and all the other versions of it
(architecture-specific) don't either.

If you ask for one page, and get zero pages, then that's an -EFAULT.
Note that that's an EFAULT regardless of whether that zero page
happened due to kernel addresses or just lack of mapping in user
space.

The documentation is simply wrong if it says anything else. Fix the
docs, and fix the users.

The correct use has always been to check the number of pages returned.

Just looking around, returning an error number looks like it could
seriously confuse some things. You have things like the kvm code that
does the *right* thing:

        unsigned long ... npinned ...

        npinned = get_user_pages_fast(uaddr, npages, write ?
FOLL_WRITE : 0, pages);
        if (npinned != npages) {
     ...

err:
        if (npinned > 0)
                release_pages(pages, npinned);

and the above code clearly depends on the actual behavior, not on the
documentation.

Any changes in this area would need some *extreme* care, exactly
because of code like the above that clearly depends on the existing
semantics.

In fact, the documentation really seems to be just buggy. The actual
get_user_pages() function itself is expressly being careful *not* to
return an error code, it even has a comment to the effect ("Have to be
a bit careful with return values").

So the "If no pages were pinned, returns -errno" comment is just bogus.

                  Linus
