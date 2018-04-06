Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-683775-1522996025-2-900827524405579839
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522996025; b=bftWb/oBAPYoinbgJPNmDtJ1Q6tq+IjDw01efXE4jztmRBli6C
    3MATyg1YgXPZahZtOMQGCGSjgHKiI5MreLl9Y8SAvGougiOGG19zx3Xb6ZbDyTiX
    uuqF1emP/QeAAE2OiN6byCWyu8qS/hJU0JWgTUqTMq8p2HQ8vJPssUMlaIRVb6n2
    64EtXKBdB9AQVeNINGQOHr1OxTK72OkzfNmEYXfXRcMtyaVkZCwKiXqpa0I755JA
    Q9gpCzNrwvYk+AtyHYzTPb6UFGuT91Aw7Ly+/5yG3BDLXGSwAeu1x/vZNBRmi83a
    kdkf3F5UW6esKbbmfV8lHm5sCRy7DDuwBoHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522996025; bh=uX9ZKAE7//QKX5y9S1TSwLLXZPObPV
    vke1NXBte3bH8=; b=G/oR7IdNgKf8t9S6Z7HkpRvQO+PgPtqeoPlBrxmw4huyks
    axvyjoRQ/aO96g5oE8E81a6xXUFIYZKE85OYJWgfk8Nf0unX8OmbL0C4WkuWdnnR
    XbczhFYwm+b3exgmVBDBk1yU+BAtrCMGQh4z6exf0coN/NngLrV66V5r+gmGAIxZ
    DJ7lyvPX+E8CMjQyXtoyJiVemf2g2F+Nf+ETRBSdIP0MCyunjiqNxZ/a+PFOpNcQ
    fP4TkgdlrSzkLxANanXJ7QWASWsgoA1jwxgTcyiTqINcgA0Ru9fe5YwWQpCjCRnf
    RAC61gAVU75dt6dqNunCA4VRaI5qE/ZljHGcGVLg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH8CRgDf0AihY/jD/1ClEFBn/Wv+VtLoAKaK73lNEKsMNXmowKABne2Ql9AVPlMmF0hFH9Aj8hX5Mzkaes/AGzm0aXpEcuQJv3QXSBeVstiBV95l/C25
    JX+HoPkwMJ0siAlGpem7zpiaFxvTMDc8rXDRAJyRXNQD1HX4WBYUr55D93B6bQa3rVrGXtZGOQsqMbXrO3e/hkJOnXuGkK1XTUYTCOxHRny1/AByvHNY7M26
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=mtmhXxi6JtwZn0RyJdYA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeDFG1D (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 02:27:03 -0400
Received: from verein.lst.de ([213.95.11.211]:53602 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752014AbeDFG1C (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 6 Apr 2018 02:27:02 -0400
Date: Fri, 6 Apr 2018 08:27:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: io_pgetevents & aio fsync V2
Message-ID: <20180406062700.GA20714@lst.de>
References: <20180328072639.16885-1-hch@lst.de> <20180406031630.GU30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406031630.GU30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 04:16:30AM +0100, Al Viro wrote:
> BTW, this is only tangentially related, but... does *anything* call
> io_submit() for huge amounts of iocb?  Check in do_io_submit() is
> insane - "no more than MAX_LONG total of _pointers_".  Compat variant
> goes for "no more than a page worth of pointers" and there's
> a hard limit in ioctx_alloc() - we can't ever get more than
> 8M slots in ring buffer...

Logical upper bound for io_submit is nr_events passed to io_setup(),
which is bound by aio_max_nr.  Except that we never actually check
against nr_events (or max_reqs as it is known in kernel) in io_submit.
Sigh..
