Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-33582-1518014231-2-10549186121551186860
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518014230; b=HK4hwgam0GXrMLB8lOF3dgJGZtkSNrqkEjA10fMqtfq4lxQ
    REWunwOKmczM+tLjAlm7FY1w88qfHX68Lhvmbq4TKUIAxhh1DNmtcqlJOzEexlPz
    T5Nq3VmPh8kYbaQiRjGKrEaN43hKuauq0+ZBLRMWw7F9euh1YglMkzqx8CxiGVOe
    TpuxVsHIxmhQuQJUCTPDubG0Cvj9lhhX/kmmmwOj+IPQWXksYpK4fcQ7xcVbeLSb
    MtCCnD+f3U8vRx9gDV+vtEPf24jogbsipmigDEEwT0SSE36xwsk56BNq7xKCxrzC
    Pul7D4nB1Gid81qXwxo9Da32D2WGByrwIuSSpIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518014230; bh=OOsvK5jVViiPyAQzhh4gVyTg1k
    xs2VBqK0ccxZUFr0U=; b=rUyPYFmL1K4KUju4auYqaFX717mocndlXIydldhzGc
    vDMAkHeg2YZ3oi/TgCtgvYzjfsnrZ8arL5voP0spSkLn3Hr84vwhNDWxXR4nO30H
    nnN3pgNpG/czykY28Gu5qa4lrRt0JphI0pwfrlvA6IP15i7NzZxnQZUvJg/6g/5g
    AbgFbIjadkwW2btr7rpo3/1FVD6ZYA9AzFbi5ia/FbTs/xq1Pjzsv+tE4k85zKOk
    5ltw7cQ1KUW58B2WD2F5bQhU6f0oCaNVP2Ob/j309aOr2k6MuNJRchRtCllJjv0/
    jDZprVy79QIMSXguVezecMSPC2DaZoSYQEODqqutqpgg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754062AbeBGOhI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 09:37:08 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754011AbeBGOhH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Feb 2018 09:37:07 -0500
Date: Wed, 7 Feb 2018 06:37:06 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Harsh Shandilya <msfjarvis@gmail.com>, akpm@linux-foundation.org,
        ben.hutchings@codethink.co.uk, linux-kernel@vger.kernel.org,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        shuahkh@osg.samsung.com, stable@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 3.18 00/36] 3.18.94-stable review
Message-ID: <20180207143706.GB31944@kroah.com>
References: <20180205182351.774761393@linuxfoundation.org>
 <CALpmF+GKNPabSb1QjBf4nogZRryhU7oD6MRsB8yrU3esT0KxMA@mail.gmail.com>
 <20180206103404.GC10790@kroah.com>
 <CALpmF+G1Cn7-1Oe2xiNXcGq-cvSPj8GPQTEf0AEF7wN-FDLvFQ@mail.gmail.com>
 <20180206131407.GA4222@kroah.com>
 <9d4d16bb-4384-4332-3988-c20e449dbda5@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d4d16bb-4384-4332-3988-c20e449dbda5@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 06:48:17AM -0800, Guenter Roeck wrote:
> On 02/06/2018 05:14 AM, Greg Kroah-Hartman wrote:
> > Thanks for letting me know, that's great to hear as I just had a
> > question from some companies who are worried that taking stable patches
> > will cause tons of merge issues.  It hasn't in my experience, and seeing
> > reports of this from others is great news.
> > 
> 
> From merging v4.4 and v4.14 into the respective ChromeOS branches, I would conclude
> that merging is for the most part easy. Major source of conflicts, if they happen,
> is that we may already have picked up additional commits from upstream.
> 
> This is only true, though, if merges are done on a release-by-release basis
> and if the merge happens shortly after a stable release is available. Otherwise,
> as time goes by, merges become more and more difficult (almost exponentially
> over time). Wait for more than 2-3 months between merges and it becomes almost
> impossible.
> 
> For reference, the top of tree for both branches is
> 	v4.14.16-3823-g597d36f1d331
> 	v4.4.114-12977-ga207b53fe939

Ugh, 12k patches is not trivial, gotta love those graphic drivers :(

> meaning there are _lots_ of patches on top of the mainline stable releases.
> 
> Also, overall, the rate of regressions is quite low (if I recall correctly,
> somewhere between 3 and 5 in chromeos-4.4, and one so far in chromeos-4.14,
> ie below 0.1%).

Thanks a lot for the feedback, this helps out a lot when talking to
companies that are "afraid" of doing merges with stable.

Based on this, one phone vendor just forward merged their 4.4.y based
tree to the latest release in a few hours with no reported problems at
all, so it has already helped out with tangable results.

thanks,

greg k-h
