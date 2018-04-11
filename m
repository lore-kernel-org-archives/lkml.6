Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523477182-2-13977219863172619514
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
    1523477181; b=YhjyETuWrTqVPW5vZMxMh54x44frooTbVVZDGu+wAVq9ivTLEx
    eolE4jCIAnFDVZmZ5gHridu3cmHH8cY+uunjSEb/aO1/M+d5POpLYBZxjjTjxaRg
    g92roK0MaezXAPBdR3J6XMf4PfAJa31NVr6n29VuUmjT+LIJuv0duR5xXwhqKD/V
    PFA3nx7sVmJcw3mtWp2+olok1xd995GHvb2D1iqnrDt0Z+Gw2hDcUFpc8tDqgReR
    uODG3xfmInlAGh1gRRJuxF/ImibFeEpMSIyHKuEZKD/ogpXi9/srojgGlMstSAAD
    0LBaHeyQ6O1z5ZUhdsgkQ/0aOI7lWy6xgdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to:cc:subject
    :mime-version:content-type:content-id:date:message-id:sender
    :list-id; s=fm2; t=1523477181; bh=R+6PjYdcH1l+gpXXxcv27L/XE7QwJb
    MijbXkG5rjQ6k=; b=P8tZIvsa6/5/8AU8spSvYvJUvqmjXlXbcI6vq7LUXd0o4Z
    MkgJ7M/2ry1shqDWIHxjpUulJvHDrAQRX+qVj4dFD5N0IAjX96xWhpDlLgRjzZXJ
    s40LevdvX7wymDy96NRBaYH6YMV/eTfs5v099MBqjhNWbvr0ertlQb6J91hBI+/h
    uRfCCV2G+DKseC7MaNTIP8khwu+c7c7nZOZXJCtRd7Gi3Nr4cRW/BHR2KVdstFWd
    EoqAyJ3mjYgIsQQ58NzFSuKox3F7agqFq2konR0XnLyq7r8288pJmh11wOFhiNz7
    RoJmlBJ+WiyXkQWqYMudAfcrHLaoC9Wh4DeNXIoQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfCkpha33CWkztzfNpLYH0B7IagdWx8+710hanLKrOPZKBmMYzsRr159u4TcEkPkB8aw4n1WeQyBje5tOT+Dqb0pPqq1ffXwOqQEqTbkdIOFnN0LC48oE
    WS8kGINBVlvbhT83IpdfuG5XFsSZzWDcqVum5IDG8DklhHx4lSBQne51886BHtxxE8y3CAxvvPqEFrc80wrgAxuovxCRKjMkXidS77DQ6BHAyieh5mtN6xJC
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=PtDNVHqPAAAA:8 a=VwQbUJbxAAAA:8 a=b6GjUZRGnaNtc2M7tfYA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756854AbeDKUGC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:06:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756281AbeDKUF7 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 16:05:59 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <87po35k1q6.fsf@xmission.com>
References: <87po35k1q6.fsf@xmission.com> <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk> <152346391877.4030.6270466586590461223.stgit@warthog.procyon.org.uk>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: dhowells@redhat.com, torvalds@linux-foundation.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 06/24] kexec_load: Disable at runtime if the kernel is locked down
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12600.1523477156.1@warthog.procyon.org.uk>
Date: Wed, 11 Apr 2018 21:05:56 +0100
Message-ID: <12601.1523477156@warthog.procyon.org.uk>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Eric W. Biederman <ebiederm@xmission.com> wrote:

> Maybing I am missing it but I am not seeing anything that would require
> kexec_file_load be configured such that it checks the loaded kernel.
> 
> Without that I don't see the point of disabling kexec_load.

I meant to remove this patch too.

David
