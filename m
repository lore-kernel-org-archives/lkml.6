Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-977394-1524477646-2-5618449947052598599
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524477645; b=M3uWqD++cBxJqlWgxmekrTJmT7yyvAemPx1RKjxHmPt1+48mqB
    PJdc6WRmsbCZQk9pJKGpKxzdhtmmbBRxGeK7aaxV/jHrajfEukvOy5b6ONFyUfxD
    fC4p7Pi6aebQTb4wfMhawGHxMdzvpCN2I+5czhiIBxH4XtvyYD/iIHP4cJxA47iJ
    nj9XxIFgidTsPwo6SOPMx7RVnQUrX/B/lIEqRS8LfXLxy58HbrznCeLK5awTHwjp
    /I5nd8WdG+UMSvyynNlVuxo8eG1YFepy1iiQ6+fTHwOzf/wiWKS89qUHYqNiv+SX
    Lfp7W72p0QeXMZxwIJ35m4abZqW3L2rmXpSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524477645; bh=bL4Wz
    bGp4iQRkxQElh8yAJvcXtySWn1Q++8OcYZlEcc=; b=GTylIjf5Tfg5Ef46ENnOn
    XwPMVb2WmwD0fp1Wuu7oDnkVYJFFOlJk90RHDqf512bSO6cMZEV/jU3bIhoDIluC
    dupQSirUrY9uXPLw3/jHVsAjrGZCP7VgApcnQsu55ShX6GPe9MZ1JGXm1blbU7bT
    bWL+9gQcPRRIalf4RNzHP59QNiBx6V6U3n9jJI7OxOXlRmCL7DBu8WEO2uLo0yaj
    VKDbcKeqGCkNby6oMYSEiEe3j0TYf45sy+EKfij2mstXWyMRjHCbr5OI1jw3X1wR
    qZD1G1iofzZjwUMXjL3+4I1uwuyYGNpU+x0Yg2+IWu8V/pL5dAyTcq0bur/mp1ZP
    Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=kOuQJxEj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XwPnCym9;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=android.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=kOuQJxEj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XwPnCym9;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=android.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH5PQBiMAz8FL2RgqFLjztJVy6sPedxYvCLuRlfv+lHFZXr477q4G+gSQNgz+Hmd+/CYd28Yt9waqK3yYDlk5SwW4yAIRFDuqpW8JO+kkJaKe+MzWlkf
    jdUr0+N5OCcHSPSCVXr9UgeLUXQPChmEwwepYhSws2W3M9oj/c8+F+V4q7fe5cfsOj691+HeLw/RSfHUcUhl0Lb1Vsi7wxqV+GMQvGtIIL5z57eDRTPPaDCw
    kOobnBw0D7PscPtIvOmGfA==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=1XWaLZrsAAAA:8 a=DDOyTI_5AAAA:8
    a=DovsJynapVsfixpvEF4A:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx491KnkTNKGhan7ybKcxJDakNSfoeZgHcmGKFbb/uWI90eQqgheqv8HNXYGlj2qdqLYBNHQqQE2iozrbAW2OIGQ=
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Y6cOgF4+TnFuU6NO8-ycpmo5=Ma-Dg+nAp71iTK64-Lw@mail.gmail.com>
References: <001a113f8f14113e790568fd0c02@google.com>
 <20180419213517.GA13221@gmail.com>
 <CAB0TPYGC_e9FZfDzVRQEJbjB7HfRvHZ+TUGAySzhOT3AHUUq8w@mail.gmail.com>
 <CACT4Y+YcODNPLzx5Zjjswz4mCcoootVQQGgwfsta+f8Vxn0RUA@mail.gmail.com>
 <CAB0TPYHLxjfmisvmVLOw+6XjV+mt=buZPJFCpg44JZpGimjLjw@mail.gmail.com>
 <CACT4Y+Y6cOgF4+TnFuU6NO8-ycpmo5=Ma-Dg+nAp71iTK64-Lw@mail.gmail.com>
From: Martijn Coenen <maco@android.com>
Date: Mon, 23 Apr 2018 12:00:32 +0200
Message-ID: <CAB0TPYGxrDF+egw9GUXhWaDnj6wkH8gKd=htyujUH4jzwSE8zA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in binder_release_work
To: Dmitry Vyukov <dvyukov@google.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
 Todd Kjos <tkjos@android.com>, Greg KH <gregkh@linuxfoundation.org>,
 Eric Biggers <ebiggers3@gmail.com>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
 syzbot <syzbot+0cf1f1aa154f56ff2e8d@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 11:49 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> Since it's already in Greg's queue, it's not worth bothering. We can
> fix up things here with these "#syz fix" tags in emails, which
> associate fixes with bugs.

I meant, when I sent the original patch a month or so ago, could
syzbot have replied saying "The reported-by tag you used belongs to a
bug that was already marked as closed by this other commit?".

>
>
>> Thanks,
>> Martijn
>>
>>> Now syzbot already skips list_del frame and takes the next one, so it
>>> should become slightly better.
>>>
>>> Let's close this one with the binder fix (since that one was closed
>>> with an rdma fix):
>>>
>>> #syz fix: ANDROID: binder: prevent transactions into own process.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
