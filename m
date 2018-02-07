Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-306900-1518022516-2-1356556929262435315
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518022515; b=IYMQq0ZsHi/220709r/HR4b/mo1u0VNp2gCnC6g1eOsmjwG
    SSxTRfZonmQysHu7rrTvHLQlMdz5FXhYHj4zQlBxnsqa7RFzsOs6tw6ngT3wvr0H
    g45NaY72Mqw1xRwTooYWIgADBZb3enCyMsmq9GJwOb4IMJRQigdekhJWaSxiVXWi
    GH9VNEIgIj33Ih0PPt52x415C8ZKF4O6i6Dm+UonG/1TH97a5idi8gRLSoOw1aKs
    oEqjoJVUjvoA1waT1Q9XOR9IP19dw49JXt75pNTr6KYGOtD+YlvTZI1KczD34ykz
    bDY6dye7LINlN1cL6AkCBwajn7WP68Md6nuOmAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518022515; bh=8GWJuFiqG++ZJoRRatNep5pM8T
    +oA7LZLciqaOb7Eos=; b=sLwbUD9W9U5u5iQswLLqSNTtt32nAMjROhMWe+R/hS
    NuvWoUpKQbWCvEJOfvT9nw5dZ7/IzDxyJLjahJwajAKr1HxtxsHYtpSRVlilfxcu
    SuQ0jxpCJbk5Mwjy1bvmiCHevoKRiSRtVpC6QUqgFAg0kmj6cFXhPlWFAjLL7FbA
    KOumgCWkQLcjDKlS29mMSG0II14rUNstOg9UbbNYxRV4ZnASFuN6Fq8NJQwcWOrU
    BO3GQQZQJdLHJoY/KY6sMY04ApzuZRuJN8189YjYcqIGYikjfJvOfV96heyQQY/t
    eJo9UQ1swygE3k610IGrqm8INdSumRYyaFGoGj0T9nGA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KP4Rd/5U x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=W91LSN7y;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KP4Rd/5U x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=W91LSN7y;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754421AbeBGQzM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 11:55:12 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:46844 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754231AbeBGQzL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Feb 2018 11:55:11 -0500
X-Google-Smtp-Source: AH8x226OnaaXxvDUK2d7h6JzkdjCqlpkcgR8rxsEgZ/OG7hMg14SDDickDXpgPfnrWQ3w9sLD3p3Qg==
Date: Wed, 7 Feb 2018 08:55:07 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Harsh Shandilya <msfjarvis@gmail.com>, akpm@linux-foundation.org,
        ben.hutchings@codethink.co.uk, linux-kernel@vger.kernel.org,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        shuahkh@osg.samsung.com, stable@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 3.18 00/36] 3.18.94-stable review
Message-ID: <20180207165507.GA25462@roeck-us.net>
References: <20180205182351.774761393@linuxfoundation.org>
 <CALpmF+GKNPabSb1QjBf4nogZRryhU7oD6MRsB8yrU3esT0KxMA@mail.gmail.com>
 <20180206103404.GC10790@kroah.com>
 <CALpmF+G1Cn7-1Oe2xiNXcGq-cvSPj8GPQTEf0AEF7wN-FDLvFQ@mail.gmail.com>
 <20180206131407.GA4222@kroah.com>
 <9d4d16bb-4384-4332-3988-c20e449dbda5@roeck-us.net>
 <20180207143706.GB31944@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207143706.GB31944@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 07, 2018 at 06:37:06AM -0800, Greg Kroah-Hartman wrote:
> On Tue, Feb 06, 2018 at 06:48:17AM -0800, Guenter Roeck wrote:
> > On 02/06/2018 05:14 AM, Greg Kroah-Hartman wrote:
> > > Thanks for letting me know, that's great to hear as I just had a
> > > question from some companies who are worried that taking stable patches
> > > will cause tons of merge issues.  It hasn't in my experience, and seeing
> > > reports of this from others is great news.
> > > 
> > 
> > From merging v4.4 and v4.14 into the respective ChromeOS branches, I would conclude
> > that merging is for the most part easy. Major source of conflicts, if they happen,
> > is that we may already have picked up additional commits from upstream.
> > 
> > This is only true, though, if merges are done on a release-by-release basis
> > and if the merge happens shortly after a stable release is available. Otherwise,
> > as time goes by, merges become more and more difficult (almost exponentially
> > over time). Wait for more than 2-3 months between merges and it becomes almost
> > impossible.
> > 
> > For reference, the top of tree for both branches is
> > 	v4.14.16-3823-g597d36f1d331
> > 	v4.4.114-12977-ga207b53fe939
> 
> Ugh, 12k patches is not trivial, gotta love those graphic drivers :(
> 
That, plus a gazillion backports, plus vendor specific out-of-tree wireless
drivers, plus all the Android stuff. No, there is no "love" involved, only
annoyance :-(.

> > meaning there are _lots_ of patches on top of the mainline stable releases.
> > 
> > Also, overall, the rate of regressions is quite low (if I recall correctly,
> > somewhere between 3 and 5 in chromeos-4.4, and one so far in chromeos-4.14,
> > ie below 0.1%).
> 
> Thanks a lot for the feedback, this helps out a lot when talking to
> companies that are "afraid" of doing merges with stable.
> 
> Based on this, one phone vendor just forward merged their 4.4.y based
> tree to the latest release in a few hours with no reported problems at
> all, so it has already helped out with tangable results.
> 
Excellent. More test coverage!

Guenter
