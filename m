Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3675524-1525826355-2-7032662989375772894
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525826355; b=Q8TTfzWo2a+sKTCw3kJ3TgqxJMqWfUtJP/xB05O1tOPsN+IQ7K
    zGsEerFcxI5nHU42Gb9qZch/Az59kYawWURAyfwUVHaLQ8Jcz+7/V8Gldl93GujM
    +QBtTr0V43Q9yKi+mO7CiJAd3gXtiU1mJZnkq1TXjsJPtmZMFpk358mKAx0y2ST7
    NZQJvQcFQmTOHAZVUAj1ZXMkncz3xr3OCqZEFmUlEZzSEDQ2y9+7ixmDy1Ha1h5J
    dzwm202pSV3/cm20FZn6qgIWyzCDzEwscHqwhQJa/uzeRjG/yTvoHghF1exze8Id
    sVihxeN9kbW6trbdZuiRDe1CFhMDqxWek3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525826355; bh=c+vlVBFoZpEgcHHMrgUs50xmt4nDdU
    aLBBj3cc2POwc=; b=UpQWbcb0fwapBBHHuyXMZDlaDOY6XU6GBy4RX1zCeY1/G5
    3WgpEBFhlW5MDipbV0Zg9Hu9u1LDv2k5A4fl8DFEWbz/GGj1FB9zh+wJ05xoJW35
    euNRzG1cpTTJtN9z9JBI48fIlaafjc1FxcH1D28OGIQEtb8vUHZnhW4kc3vrUd+V
    i0zg22yHEqerLRNWHZA7qbDWSgzYXu1v8NNo+FXQTtHdxB0acxJR/aC39JaqN56R
    +FSLBaZ4PEDEiuTndaoxpUkLCUVCbthhNEzTr43N15r3vvRHR6xVQByEZ4NCrbLv
    yc8dtzMuTzpLEvD0VQJubRmxE32w1YtK8+QBOt2Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEhZIAl5OQFbm9uQrmIbRKVoqblk/AmgT4HLlKFuDk3aDPiGJZAo5BpZMYs2wcz5reGi9FwEOYzBJSFcjEjIVYDzL4eOVlAmPomT8Yeapb3dzMp8gsFY
    U2SjwzSEL1GyhMyz19BDZs1GunjY0jNPSkdGnLi9o1kzaHxvqQsp6KY19kqKqk1K2IhWCAb3e1uZHhNKgLG2nYmiUu6Q1uOW1k4dfYpZHYkq56DDr6MsHQ/9
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=LszvGOKLxmwUAs3mp8wA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932802AbeEIAi7 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 20:38:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:39308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932593AbeEIAi6 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 8 May 2018 20:38:58 -0400
Date: Wed, 9 May 2018 00:38:55 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        sandeen@sandeen.net, dhowells@redhat.com, tytso@mit.edu,
        fliu@suse.com, jack@suse.cz, jeffm@suse.com, nborisov@suse.com,
        jake.norris@suse.com, mtk.manpages@gmail.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] vfs: skip extra attributes check on removal for symlinks
Message-ID: <20180509003855.GK27853@wotan.suse.de>
References: <20180426234639.12480-1-mcgrof@kernel.org>
 <20180501172319.GK4127@magnolia>
 <20180501174512.GA27853@wotan.suse.de>
 <20180508003055.GC11261@magnolia>
 <20180509000327.GJ27853@wotan.suse.de>
 <20180509001741.GB11261@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509001741.GB11261@magnolia>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 05:17:41PM -0700, Darrick J. Wong wrote:
> On Wed, May 09, 2018 at 12:03:28AM +0000, Luis R. Rodriguez wrote:
> > Groovy, thanks, let's not forget the xfs_repair respective fix :) let me know
> > if you have any feedback on that.
> 
> TBH I've lost any proposed xfs_repair patches to the mists of time
> because some patch volcano keeps erupting on the lists. :P
> 
> Uh... I think it's fine for xfs_{repair,scrub} to clear the immutable
> and append flags on any special inodes it finds, particularly since
> neither flag has any real meaning for block/char/fifo/socket/symlinks
> anyway.

Sure, my point during review of that series for xfs_repair in particular
though was that for symlinks the justification is different (half of the
commit log in this new patch), as such I'd prefer to deal with them in a
separate follow up patch.

  Luis
