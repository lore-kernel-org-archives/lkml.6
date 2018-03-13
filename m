Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2832218-1520935397-2-15547645493042871169
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520935397; b=Avm6fbcXLihKI1Roe9+RZQMx1v14585Q71M8gGSoa/TpEw3
    3nMHH+o1hIi2NlbaqhCawdZNGm8XeOe4XeI6WuVmDDZcq42vHAkMxe2NDOmNfPiR
    8DrvENk7qciyrOIWQi/H8Y6vYzYOq24OLURw5PKoAdZUnxbFhmbteH+cSrLdQOcw
    eEGriRRjZ/UxA95MD7sqXgfAA3aTaPxfgv5uMsLkxn4nhCS1IQmmEEdUnhnGnfPw
    onP77A4Ec7Z+tqPify70aoSsrdTBmkrt/OKyKJvoOyZlcB5f43ED+UOm3//rZQ19
    9bM7I49+3/p4H5ey2r8tlB0UCbmwkkSkB0t5ZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520935397; bh=chjuRN2rYgrjy/fTGeIk+WIGrB
    T5OgNFOjBfchO3el0=; b=OMIvTzqSQdX8aSmekMFid0yxe6hwbWK6r3zYvYFpHH
    d9MPD7Yne3oZMaUs+0g3Tj2EHkUS15C/+eJ6MFTE8wV5QI9dVmglnntCojMJE9HC
    bFqWA8cm+ZCzfkImziRJoQYiz/q5MosHgstUiUK0/7hfSuT7sSsJ5cv7dWR6kGKS
    gDGxqsVsBm2rBcmmquQ/KxDLPjXPS24IjtR6qw17lLyoYFqXufWPG+cpUXuX+fsO
    ccqNNYnbwY3cJFD2Z110J6WCe7CD/6AX8b8breCmMcpWM+MUwiYPMvg/s6UBfNAj
    Sev+sX8ArJTimHm/s6DPQE6Ru3IikNJvnDFUMzCIAxWw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dsrb6VRV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dsrb6VRV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbeCMKDP (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 06:03:15 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59893 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752108AbeCMKDO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 06:03:14 -0400
X-ME-Sender: <xms:4qGnWvLhOUjvCVMo5f46sC_l06q9PNrp21HquGFaACiNQ48gxqyWig>
Date: Tue, 13 Mar 2018 11:03:16 +0100
From: Greg KH <greg@kroah.com>
To: Mark Brown <broonie@kernel.org>
Cc: Alex Shi <alex.shi@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
Message-ID: <20180313100316.GA1999@kroah.com>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com>
 <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
 <20180302165415.GB8704@kroah.com>
 <20180305124638.GG8588@sirena.org.uk>
 <20180305130859.GB17802@kroah.com>
 <20180306142634.GC13586@sirena.org.uk>
 <20180306172525.GA6618@kroah.com>
 <20180306213129.GG13586@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306213129.GG13586@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 09:31:29PM +0000, Mark Brown wrote:
> On Tue, Mar 06, 2018 at 09:25:25AM -0800, Greg KH wrote:
> > On Tue, Mar 06, 2018 at 02:26:34PM +0000, Mark Brown wrote:
> > Really?  Like what?  Last I looked it's only about 300 or so patches.
> > Something like less than .5% of the normal SoC backport size for any ARM
> > system recently.  There were some numbers published a few months ago
> > about the real count, I can dig them up if you are curious.
> 
> Really.  
> 
> The Android tree is making non-trivial modifications adding new features
> in core bits of the kernel like the scheduler - that's got an impact
> which will have follow on validation costs if it's not introduced early
> on in the process.

Ah crap, I forgot all about the scheduler mess.  Sorry about that, I've
been focusing on device-specific stuff too much (nothing I much care
lives outside of drivers/...)

So you are right, for some types of devices, the andoid-common tree
isn't the best idea.  However, the validation "costs" better be starting
all over based on the intrusiveness of these patches, they are
non-trivial :(

thanks,

greg k-h
