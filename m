Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523479402-2-11980999075040692321
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479400; b=K7HlBLlace64rjbTmOR2FkbmcIo96uvo+6AFppu3a/0hRGo4E8
    q+PXCEOimrlCKzw2MXAGL1zmyHw47SoZ0bb7aLH9LLJbWVev3Hk8xqzI/ajV5opg
    +GI2xkFwTxvFY8FOga/8qCKwSC0yM3Rqmr9O+6Jhe25By9FKDDAyWbYvTH8O8QJk
    nYGhueUw7/AF4mdsQSxMXjVXHuoNvcPIDRxCB6BgYvkAc4uLPga1YeXlzX0M+eBV
    Yyav+wG8vOABLiCPSvFxT9g2h1jT/Qqf62HzGvk0B9wmG8+HiMLunEsopoSUiEwe
    SnMAnRNqySdAR+5jHe0lPRFwUsJsbXQBCzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523479400; bh=k1vFPUBDQpB3RI/RvAFbMLmkAQGciw
    NiJCuOdI4Aq1I=; b=S/+moJLHPxZFacxlJPzSsnZb5s1iose6XQeZvFlxXo1oCo
    oinRGJOpnPiPeR/HNCDKocbfWXHeZdPh81rWzlF8YOMgMoD0YyTcDUOeF+BNgfok
    Om16uz+H28tB8tBF4t7Nesg+WJ1ICORBBVaQCnp2ZidVCSQZui5tpdPdOElwazxt
    QRZmD0S0wLFyN1ixPdRSJobN/gkhPvd5ayBlS18hRb/UDJVw0in+rDYrXRElGuVw
    ryaZ9B4KQDbQ5CmmnnD5jEkgIPclTG08d+J/C292SgfZ/cvlcN2AeOGD2q/pnrlt
    mcBuowH8ZylIduAxlpjS8fcgO63IJOO95CyZP95Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=SW2KPwdR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=SW2KPwdR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGbYJih+jkwVWsV7Ea5NgJZE1YUX1cqomnisCV3EHFmvYsOQlDvHMZwOo48v/6IJkp42VTCTyMueMMkEBQRh003z88RYkoPoPbFUsGBwZxVgNCcXrMkM
    IUaMtCd1+Ca+4k9Oj/7VGmkpD+XNpMsTuZHS2ZPs5iQmG9VKNJWwr0ZoOPjw3RCNDiiwNfoi7pq1UdQwfJU/YVlbM8LqR2jKOhF4PoBFtmzhCQx0xpNijTyT
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=2C6YHBdLAAAA:8 a=VwQbUJbxAAAA:8 a=77Y27ZO1al6EsNLK9NsA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=yxGMNg53M24zlVSZdvMH:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932446AbeDKUnR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:43:17 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54667 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932425AbeDKUnP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Apr 2018 16:43:15 -0400
X-ME-Sender: <xms:C3HOWuiipPW2px7fcsRnEvN5JDONjhVZm_yjHpmblR-bqDNwphJ4qQ>
Date: Wed, 11 Apr 2018 22:33:08 +0200
From: Greg KH <greg@kroah.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 24/24] debugfs: Restrict debugfs when the kernel is
 locked down
Message-ID: <20180411203308.GA10167@kroah.com>
References: <20180411195436.GA7126@kroah.com>
 <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346403637.4030.15247096217928429102.stgit@warthog.procyon.org.uk>
 <12769.1523477356@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12769.1523477356@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 09:09:16PM +0100, David Howells wrote:
> Greg KH <greg@kroah.com> wrote:
> 
> > Why not just disable debugfs entirely?  This half-hearted way to sorta
> > lock it down is odd, it is meant to not be there at all, nothing in your
> > normal system should ever depend on it.
> > 
> > So again just don't allow it to be mounted at all, much simpler and more
> > obvious as to what is going on.
> 
> Yeah, I agree - and then I got complaints because it seems that it's been
> abused to allow drivers and userspace components to communicate.

With in-kernel code?  Please let me know and I'll go fix it up to not
allow that, as that is not ok.

I do know of some bad examples of out-of-tree code abusing debugfs to do
crazy things (battery level monitoring?), but that's their own fault...

debugfs is for DEBUGGING!  For anything you all feel should be "secure",
then just disable it entirely.

thanks,

greg k-h
