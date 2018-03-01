Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3218355-1519917908-5-6455092449751301505
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519917907; b=Qj9vd0HzCPY3W3g/LhSOb+W8uCunCX7EVNv/6KTea9eeFY3
    vDoB5b+He94At9GYwgLmgNnBfAwtHnbYF+eddiont/9N73Fm9Rao/CpA+kCc8FVx
    GldsBpJhFxZqOxRxG53/KjX8ZmxGIQn6tWws6s3/q18TU64NB94VJHU6TXGfqE3B
    ArNC/KTCppvDcoUQPM3zUaQ4mi7fP/CANETEf4x3+L+XHAtfCc2JAVcS5NvtHMSF
    StissaC0A5/ZuueAyXxHb6M1pvhJJRr6gRi0t96Do54TXRwGp75lhcAXJH+38fMe
    PsEM6MeD2di8AofcCCWh6P2bakmlS/ZlbKnjdaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519917907; bh=4P2YwNfQwvS1genGmQVxKih0YI
    kizzxNvKlX2aZOsKU=; b=NjjR2TTh4NCGKTvO9WZW3bF3ddBDN244imPvm13WzD
    JDO/wtXQvquA1eRLEds6suOAFIiSxyvRpbRQcR04Id0Z5pmNcBMzqtyaPXMO3Q+y
    m2sWucKNLRkLI8vQqXAb1uQG1XjUODQ02HM5IskF1H3ghX5+28yBbuQ0SFmKFZXt
    WF1VP2E+ym4lP2esJI9VdG+P4n+foauVcgavBeEjM8TZiEzztwjrU4Az2sbwsZ+Y
    gTkQq4Rsnl6FilRkXm4S8BbyN6+Z3MerLMBhfsJjbcsPCYN6ZE378FOEQyApivuK
    A2JRmGth997rNl1HDWTQkqXMKf799rY4FExazy6u3yGw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=TTgMfd/1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=TTgMfd/1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032018AbeCAPY5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 10:24:57 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46497 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1031929AbeCAPYw (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 10:24:52 -0500
X-ME-Sender: <xms:QRuYWlhP_RSgaRb-5TRgNgKTbnKlGnNvP-47J5R9qOI9v2gLOl8AOg>
Date: Thu, 1 Mar 2018 16:24:50 +0100
From: Greg KH <greg@kroah.com>
To: Alex Shi <alex.shi@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
Message-ID: <20180301152450.GA4061@kroah.com>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 11:56:22AM +0800, Alex Shi wrote:
> Hi All,
> 
> This backport patchset fixed the meltdown issue, it's original branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
> A few dependency or fixingpatches are also picked up, if they are necessary
>  and no functional changes.
> 
> The patchset also on repository:
> 	git://git.linaro.org/kernel/linux-linaro-stable.git lts-4.9-spectrevv2 
> 
> No bug found yet from kernelci.org and lkft testing.

No bugs is good, but does it actually fix the meltdown problem?  What
did you test it on?

And why are you making this patchset up?  What is wrong with the patches
in the android-common tree for this?

> Any comments are appreciated!

You need to start versioning this changeset, as I have no idea if this
is the "latest" one or not, right?

Or have you not sent out this patchset before?  How does this interact
with the "spectre" patches?  Or am I totally confused here?

thanks,

greg k-h
