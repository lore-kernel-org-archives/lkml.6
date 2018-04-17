Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1535273-1523961235-2-4078006048069330650
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
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523961234; b=YIfz5bH02SJK3NwevK+49nz/ybMoroKvjBLuSSbw6DO88Xx2mN
    bhA0ATcsXD8MDwyBZDx/3nIJlApoeTk+tlDPBBdzQePh5Nnu27pm1T17tSzRLz5k
    Rqr27tFVrQiMd48d1XgklpzTmIRgtcCh7Q+KhyrTp73xDqxD1RuuRIf+pdjIHMdG
    vn+TjGCLzAtRtvANC84XzwTD9J1Yk9BFqRi8mL7UAotAtbiA+oYasP8h4lqrEYPg
    5ErS9aVQC8pnW+t3SB3bDzZ5pcIZdh1DwO6r2EE28yUuGMTJ+H2Rlg/9UuPbVv4l
    S8bSOIKIcPZm2Ew2cvpSD7WvZ0HGnHINnM/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523961234; bh=TBHt3FWPLc3w4NVgIOVZ1bjtohLInj
    ZBeniCW7OOoHk=; b=CutcrVXGWdx4h4AXR1h6E5+fxN9yHTEYxcj9rxGtIe6dmj
    iUhVa5QS52ZaF39Cv7suTXHk5/vcdYH89t9c4gl2JT3NX/uU9NYdrwUU+/bopwu+
    KPxVVM5sEC+kNxsmbe+ybsj1JTZiH9F5W8h3fW1q6MlmmV1R5D+MlWbbl/wYoEVd
    5IPDoycM+Wm0LIHxXWBXbeMB6flYckbjKS3XYdEpvgCT8KvMY4pZClomn0qIJT7q
    EoaMQUD5MZSDV0XtompzrAgQ2j6ySmlyo4+RfF9woi8jsdkc7UjoWtMX7xM4rt+I
    b0U+OinmnuudcbjjWp3obanHm8RSeTUv9iWmdfZg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=lL3pyeqm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=lL3pyeqm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKIry3sjKnr5e5mhnISO3dYzEVi8wCvC/I2+CiM/EWIPEUq/x8I91SrLj1Y6qJ0hWlKwxkK8X7yHm3CcYg4JEn4xY1j9UvpyLlW3w8CQuhglMDKnviZm
    yKBWqlgF1W0lTXZc8UhU/rYyPUGLTsEn2XE7eJepO964uLW3XjW+Yt9ELUXtrWcDXngp+AyFutCQUuTbFRdVl96V+ygDx48Ie/rHlaSshdks1pVkCDEFqnDy
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=BYdjmK0F3VFKc_sE9FoA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbeDQKdw (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 06:33:52 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43349 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752096AbeDQKdu (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 06:33:50 -0400
X-ME-Sender: <xms:jc3VWqWytlHs46uSWckwWuErigSyi8fmddPdK9LcaRX-cN6MGT1dFw>
Date: Tue, 17 Apr 2018 12:33:44 +0200
From: Greg KH <greg@kroah.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: Jan Kara <jack@suse.cz>, Guillaume Morin <guillaume@morinfr.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Pavlos Parissis <pavlos.parissis@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "jack@suse.com" <jack@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>
Subject: Re: kernel panics with 4.14.X versions
Message-ID: <20180417103344.GB8445@kroah.com>
References: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
 <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
 <KL1P15301MB0006B378757EC8F6B4D87BBBBFB00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KL1P15301MB0006B378757EC8F6B4D87BBBBFB00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 09:10:35PM +0000, Dexuan Cui wrote:
> > From: Jan Kara <jack@suse.cz>
> > Sent: Monday, April 16, 2018 07:41
> > ...
> > How easily can you hit this? Are you able to run debug kernels / inspect
> > crash dumps when the issue occurs? Also testing with the latest mainline
> > kernel (4.16) would be welcome whether this isn't just an issue with the
> > backport of fsnotify fixes from Miklos.
> 
> It's not easy for us to reproduce the fsnotify() lockup issue, and actually
> we still don't have an easy & reliable way to reproduce it.
> 
> According to our tests, v4.16 doesn't have the issue.
> And v4.15 doesn't have the issue either, if I recall correctly.
> I only know the issue happens to v4.14.x and 4.13.x kernels

Any chance to run 'git bisect' between 4.14 and 4.15 to find the fix?

thanks,

greg k-h
