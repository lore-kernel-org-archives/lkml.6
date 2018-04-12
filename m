Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3941427-1523501856-2-990837100396486199
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523501855; b=YWlZnU3qP5XXjDUsyP8ekeM7JL3ec13KuqiDWDwZCJXPiQpevg
    hvp/SUP8dpXOZqZTgZtzqd4aoKGloce8zv48g+lNn5051YpqOhOj7WvdLRyjlrNA
    yVs3C80qIqhDURcZkdP8IPQQt8HLOBnG8ZNBjQ7YJV/Nwq5szOPk8fXxsoDtWQ5D
    32Hn9XwN/evfMvuwZJR3iWYSyg1L8mwppAR2psKWWiv96fomTqnD++8rvihGpA4U
    1vxb6fYPFA5HNlGOFkY8m0P+gZpYzo7vWM7+/41Fj37Gd4oUyu7b6/iSbMAUS8Fe
    8tbEGLPphNmOdEFXn267hGp+JmND2XABfftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523501855; bh=dCdwNU4OjXB5H6qZllahOVI95jeDq1J9XwTPUsfMkq
    I=; b=CJ4g8Qd7jz936aporo1dssyjjUINXbZ9UfARxnrOHmzKNLK7VTAaGjsZJA
    RrJ0jeKRaJ+fNKQDX/3ujcxMHuQllqlfdlj8/s2k4X1UCOVV4Uab82/kVIMRldZo
    eX8kxbu7Nk4FZE8hNTJEVGVUkx80NCZUWWtwuiyuJSCc7YvpOPxy3whrEuStvfTH
    hKyLAaRgkdNl0+oMw8IlQqHvwze8JCCCzGYZq22TeNR0QONim1MnHVGsJkunJJH3
    jJjVNKddatnIHZ1uis9DaYwKt5IJ7PwK+rV8rb8a17twu00Xu+IZfqalDJ0fiFrE
    2R1NJs7INFE7Fp7a794jcf2wQ+wQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=lxGYJLc+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=r4pFP4mW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=lxGYJLc+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=r4pFP4mW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKuv4D/nWqeNZfKZ4uAPo0BKe8QDYUVsrc7+UmhLi9+7/wXCLNYv839VUM45mwjB/KehI9Q3wwI3GU3EKUsuWIevGKxSneC/FgTRUEMm5fsAUZ7uIg7d
    DVgQGororUqfcX13QBboM7XDXPNMSgHElz/4/5HVij+lTWQ9q7TN+FazKzFPtA8OyWsIcegeR68/fKjMvGV2e6Tjgtf1lX3cjZcfRh3PCr1x12rR2/2obPCk
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=8NzE8fKlBQPv-MZQsRQA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbeDLC5e (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 22:57:34 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:37568 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752265AbeDLC5d (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Apr 2018 22:57:33 -0400
X-Google-Smtp-Source: AIpwx4+8//PrMEwx1PkyZef1fAFTLl+h6Jg9pP476y4Sq7SsSpZVXn1TWgfJMv2MT+IyPfsdzi4QL5loGpWkyiV0t7Y=
MIME-Version: 1.0
In-Reply-To: <152346388583.4030.15146667041427303547.stgit@warthog.procyon.org.uk>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346388583.4030.15146667041427303547.stgit@warthog.procyon.org.uk>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 11 Apr 2018 19:57:12 -0700
Message-ID: <CALCETrUaSeTwwiTs7LwNTcScUcVok1_j-OBnEQqGXmst5T++Sg@mail.gmail.com>
Subject: Re: [PATCH 01/24] Add the ability to lock down access to the running
 kernel image
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 9:24 AM, David Howells <dhowells@redhat.com> wrote:
>
>  (*) CONFIG_LOCK_DOWN_KERNEL
>
>      This makes lockdown available and applies it to all the points that
>      need to be locked down if the mode is set.  Lockdown mode can be
>      enabled by providing:
>
>         lockdown=1

By doing this, you are basically committing to making the
protect-kernel-integrity vs protect-kernel-secrecy split be a
second-class citizen if it gets added.

How about lockdown=integrity_and_secrecy or lockdown=2 if you feel
like using numbers?
