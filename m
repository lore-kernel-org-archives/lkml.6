Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3309672-1524148903-2-6894824356666700387
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
    1524148903; b=Wk7e7hpnlK256TijMBtuPRxeZG0hdsNcnDUw5s1M0FIiB1MIzD
    mJWIDA8ILFAA2gDPcDorb+AH6/EAoTexg+8Jr8n5EDvJb5lt0RZn/yoLx0/bNp/z
    ECaJfdLPGPs0h35t/VLF01+4HEvx0b+RVqID7IyXGQiiXZkMynso/WSP6orHFtc3
    kpbN4S0JwQaCAkz6yxQheYEhmic0ttb90efPrR+6vHt+KEadtbK1iOrbagRNK0l2
    VOlIh+wztdEKvI6xzdrvg3U/njHcJ47rP8OyYyBpgZm/j5F0HHSI6XVY9JmwxgnP
    43aQExNzoQej/LEZPxV1OSJX0mBIPi1JPg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to:cc:subject
    :mime-version:content-type:content-id:date:message-id:sender
    :list-id; s=fm2; t=1524148903; bh=YNkt2H8akbUlIT91QUl7vHLZHpOucz
    s0s3uD4lNbVo4=; b=wKQ/ouik1quF3e4Smz6kacjb+Jr0Fcwfe6p0jXynPj1Loe
    xpdYKLL9SGDU/rGrHh9oA7ydm+YKaWIqRs5ac6c4Elda6QN3GRADiVQaVAN1yepF
    fozuRlHqKqsV3XCPl4G1jxBGgz3x67lM2vGwIwR19p69prEVvEdB3pBcboCSksJD
    tekPn3rMOCT98k+EbYy1hJt89xrZnH4xpjnhkP8qMgh9BMNp1n70dnPEUMMrh1eN
    js4+jk8KueKCrQA6q8IuRpleXuGw3UhgFmdZ4z2isox//cyOiCTF1JoRP20cRlLS
    twbE5qpOHGKCQ9l/iSCGN4zyG2BVsY5kk8J8bnjQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfDDbTMezZcPt3SXs7XKo5hg7F6zD8wK6ThL7tKuzwH/1Ldx5OkO/FFiJacylQaTGMPsJUnzKqNV7u8tttHJR50IT4UD/6AgPJ05pAizuNaKBKJkUmvc6
    +6ymcX3OX3LYNvGMT4GRdcsOs08K7cARlsPD+LKtI590iQuSCD+PSipy5FoqPzltJwGBBPeDN3IezOeA9JxSvBOQX73TnrwZKc/ddx1/aK0fnzvsOiDfVXWy
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=f0p72tb6o5GHwl5x2OMA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753706AbeDSOl3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 10:41:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753041AbeDSOi4 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 19 Apr 2018 10:38:56 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180413202234.GA4484@amd>
References: <20180413202234.GA4484@amd> <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk> <152346392521.4030.5108539377959227838.stgit@warthog.procyon.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: dhowells@redhat.com, torvalds@linux-foundation.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 07/24] hibernate: Disable when the kernel is locked down
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27925.1524148733.1@warthog.procyon.org.uk>
Date: Thu, 19 Apr 2018 15:38:53 +0100
Message-ID: <27926.1524148733@warthog.procyon.org.uk>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Pavel Machek <pavel@ucw.cz> wrote:

> > There is currently no way to verify the resume image when returning
> > from hibernate.  This might compromise the signed modules trust model,
> > so until we can work with signed hibernate images we disable it when the
> > kernel is locked down.
> 
> I'd rather see hibernation fixed than disabled like this.

The problem is that you have to store the hibernated kernel image encrypted,
but you can't store the decryption key on disk unencrypted or you've just
wasted the effort.

So the firmware has to unlock the image, asking the user for a password to
unlock the key.

David
