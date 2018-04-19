Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274038-1524148555-2-10062076003910502926
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524148554; b=NwJUOmVuFkHRk2YBI2gs/51DrcoTddpt0gwpRVYZjaQypU+L60
    JQzaRGnu0vwz7xcn6hVmEP/QJxBIsfrdACOkdbn4v4pqBSzLCYpvUbU13FCaJETN
    wSSXUQvzf2Ihz8IWO7I0fV6z1GH+LSSuyutNXwR9qVWi4Nc/xT3grvkXTnVZ8612
    GY10CuFTmSn/WLvFnYFUapWnDKCcdOFBVdYayYiv5qiv6H0XdMUbER+s6gcbVZ0F
    1UaRGf7pFKQbb3342tIK0JS/jqiP+ZSGU+EjcjMXaZGXI3I1GAd707sYZpvsiJjv
    RGkAK5DmfovvG93CfoQIwon9nF8b9aKmDv7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to:cc:subject
    :mime-version:content-type:content-id:content-transfer-encoding
    :date:message-id:sender:list-id; s=fm2; t=1524148554; bh=/BgXnWo
    HZAQP6vl4OLP4sESmLmkZR1j7hLSokkJEBFA=; b=Zko4o70vlCpVy59Ycd2TO7y
    oG+UJgBrVVvGgqEgKm3dc/HU8VsOTAL4Y5QDaxgmkxDPPa3+1bapjhXwCay+Vw1m
    U/d41LKurwfhMl6Y41MFRHGFpS5RB0N642BNXWimwrFsKpga0VfMoXxB54g8EqoP
    SJcCq/aOIb6kDenWVziQ07f4C84Okgspwmqo6OMp88cR/j9pgiNWfQXELL6kSBTn
    DZCpRC28HX0GkGXol0S59uPUJE35tZT0sDW/EYRH8Xw9R2XJNJfxzE7V/xrMbtsb
    rkq+ownz2AX631+xk85t6NT6HY1L/iw6zuVuVUaAxK23iNiVawlrtk3soQceDiQ=
    =
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfGFm43e9pHaJfoCZafBbaJ/UWXN7AIHn/5UmY8sTZECSy79Ebt4eyqe/CiX7g5ET2e/f0ifE5tC8snEp9WPiQdNAg1WAM3RxED5gFLebbUGtswACZq6j
    x872dC0P4BELWYquunBMimRB9UjBUZ2oLLO4vCZOT+7ZqkqpNKiT5QXrRR5YXG4BONLxZKMaubVDW9MuU5/b4H2IJ4VT+PcqlxTUcKk6CPeNDtUQQqGzMaRX
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=P8zLqvrZzsJ75_ydw54A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeDSOfv convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Thu, 19 Apr 2018 10:35:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751136AbeDSOfu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 19 Apr 2018 10:35:50 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180413202241.GB4484@amd>
References: <20180413202241.GB4484@amd> <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk> <152346403637.4030.15247096217928429102.stgit@warthog.procyon.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: dhowells@redhat.com, torvalds@linux-foundation.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 24/24] debugfs: Restrict debugfs when the kernel is locked down
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27817.1524148547.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date: Thu, 19 Apr 2018 15:35:47 +0100
Message-ID: <27818.1524148547@warthog.procyon.org.uk>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Pavel Machek <pavel@ucw.cz> wrote:

> >  (1) chmod and chown are disallowed on debugfs objects (though the root dir
> >      can be modified by mount and remount, but I'm not worried about that).
> 
> This has nothing to do with the lockdown goals, right? I find chown of
> such files quite nice, to allow debugging without doing sudo all the time.

It allows someone to give everyone access to files that should perhaps only be
accessible by root.  Besides, if you disable lockdown then you can do this if
you want.

> >  (2) When the kernel is locked down, only files with the following criteria
> >      are permitted to be opened:
> > 
> > 	- The file must have mode 00444
> > 	- The file must not have ioctl methods
> > 	- The file must not have mmap
> 
> Dunno. Would not it be nicer to go through the debugfs files and split
> them into safe/unsafe varieties?

Whilst that is a laudable idea, there are at least a couple of thousand files
to analyse, some of them doing weird stuff in drivers that aren't easy to
understand, and some of them with lists of files, some of which might be safe
and some of which aren't safe.  Even some reads that look like they ought to
be safe have side effects (such as read-and-reset counters).

Besides, define 'safe'.  Is reading a particular reg on a device and returning
the value through a debugfs read safe, for example?  What about files where
reading is harmless, but writing needs to be disallowed?

I did try initially passing in a flag to say whether something was safe or
not, abusing an inode flag to store it since debugfs uses a plain inode
struct, but then I realised just how many ways there are to create debugfs
files and it started to get out of hand.  My initial idea also included
locking everything down by default and marking things unlocked on an as-needed
basis.

If you have the time to audit all these files, then that would be great.

I lean more towards the lock debugfs down entirely side.

David
