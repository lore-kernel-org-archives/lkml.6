Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477313-2-17665363092022193070
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
    1523477313; b=SZbOz8JUlCipL8nerdZr4PliZNW05uoahfIVnOmRc7Cg2NKq2X
    +ENHJkmEHmSokwA2Dselrxr7JuiXind2hjCCTPk8LXui29EP4CS14QensQWQABKq
    XuNfDQGhkcukQ8J1VjPG6M1iQcZUn38XcLbY+/jDXdTNX+ad+XBuRZIUVA5cN7s1
    1m0+GxjqPsOz41k3JexkOJ6NmyvKd+C0nEmNkMOFRc0G8nxgR0UrX8ktjyCQdee+
    5T7TpnOvqIJzh+4if5qxrbVq2xqb1jn+DVqHjZuublAt84BmdFbndUcGuVknCthV
    hwMhi+E+sdqHS9wl6Ewfc0wNxx8o3o5t0oGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to:cc:subject
    :mime-version:content-type:content-id:content-transfer-encoding
    :date:message-id:sender:list-id; s=fm2; t=1523477313; bh=2zIr5jb
    0O2l1uiPkQ/RSoOM58ddbG6cGnKL1gsL14AA=; b=FgDI+UzLgv7Og8tg0RfF0qY
    08+yJ4CWoCtz8YYFGi/TDxukPcJiF8j9nC2Q4ndBb9zLwn2WwyxdxoJhTXulZtG9
    hFzcBWF468JmFFJCxbKqS3IpmtXu9oCa17Vn3XNbD6ZhmfObjSuA/p6LO/4ifl09
    1PtPdJqRPc+s4JJH4SMFXzEl1DTlHVUL0OfPZipbS1kN1YaiprWpTSSzXH8o6E4d
    dWr5xajZ5Xd8aLvNYPiXALt4N4ZhP7hKfkVmRpKiBUslr+o0qEtV77wxtqr3EJa+
    4eyRnUGzzwHAnMgi5fsAp0+BxnPHlJoRAic3PhhrMkTbsM47xqfojG1KBIF+ymg=
    =
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
X-CM-Envelope: MS4wfHhNT1HDdvz7NG1o7ZQtX/7Hygr0NzlxtVCmOnEXrpnhYVwfu0Wqi6ZdEBcmmvyxBn5cjfKYXSGA/r2QssFOmXmDnODcfxyp/qZFaZxIdhQMwOHOBHDF
    qjtzhPySKwNbSuP5abeSlWqVEXEWaaWW434rgyGiYuFqnVR0rCgNu/KtV8ZfD/95H/K1h2abJYJz8cvz6PtYrQSFmcARFnVPiI71e506YosaTaW1ViUI0mMx
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=PtDNVHqPAAAA:8 a=VwQbUJbxAAAA:8 a=36EtJlO0JiJiVSyQpYQA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757404AbeDKUIZ convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 11 Apr 2018 16:08:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756097AbeDKUIX (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 16:08:23 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <87zi29k26z.fsf@xmission.com>
References: <87zi29k26z.fsf@xmission.com> <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk> <152346403637.4030.15247096217928429102.stgit@warthog.procyon.org.uk>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: dhowells@redhat.com, torvalds@linux-foundation.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 24/24] debugfs: Restrict debugfs when the kernel is locked down
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12740.1523477301.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date: Wed, 11 Apr 2018 21:08:21 +0100
Message-ID: <12741.1523477301@warthog.procyon.org.uk>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Eric W. Biederman <ebiederm@xmission.com> wrote:

> Why is mounting debugfs allowed at all?  Last I checked (it has been a while)
> the code quality of debugfs was fine for debugging but debugfs was not
> safe to mount on a production system.
> 
> Maybe the code quality is better now but for a filesystem that is
> not supposed to be needed for developers letting us mount debugfs
> seems odd.

I agree.  But debugfs has been abused and it seems that there are some things
that use it as an interface between a kernel driver and the userspace side.

David
