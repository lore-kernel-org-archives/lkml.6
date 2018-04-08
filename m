Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1952039-1523182411-2-12165962282991613393
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, URIBL_RED 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523182410; b=vkLDWJ+J858y/znqc5bPGFLhpf3z+I778nt6hNPO1Me7F1CYHj
    SOcxt2HLpkPbJt2RW2YfkLFngoCtLX9xRm/09mEgV93lymhNkL+eqon39YFhCg8b
    pIUd3E61DYf6NMxuFO+BSm68j7gbEHsXmpYg8vQQ6DC8yOzQk5BN7EihsPo+qyQj
    wpea2Fv8SYOTt7m0w573G/KVBunpNpHFzhyJ1AWg1Y1NnHzZ8D9J8X/fQ50GzwEP
    pKT/vZ8ZW76ZyyDoQ8fDZuEC4go2HGbOEKryqNECYSAbUCgdkHgPoxssQ23kps6b
    CMPPvHXKkYMOUhCqW+5kaXzZUzTlhXin9+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523182410; bh=50xeFa0RavNMTzgn9dNCjymVoiNYOc
    mYd7Y989E5TS0=; b=aDlPiCxDW17rwFBCavtYETCiI+vN1cWAGP80DLMsBG6b6L
    lElgVL7+NAuY6NsQjSMQajF/nw84RrlG9U6o9H+/LXTRQ0hVT2oJQhXJ19hZd9Am
    nhTpG2zILmy9yrcdehEGS6IEctPq5LqC8xvjrKyHrPfbXE3Fc1kPIo+EXqSM0VCi
    3roC6CA9B9MH3pgCuJM/qShc2gqM0v/yC2IBSXQgZU3Otb8OAgfhp83yC4oeV1D1
    nGHgkvBnaIxrhVFwaXQRiIytvoa3WCsFfDR8Mou8aj1wbnH05aPYH7CIPOLFqqL+
    X8IARQ/SRnVd9fLWhcBwYkpnT0ZJhuAtUEFiqu4w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ziemianowicz.com header.i=marcin@ziemianowicz.com header.b=RKPWgbm6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=somekey;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ziemianowicz.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ziemianowicz.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ziemianowicz.com header.i=marcin@ziemianowicz.com header.b=RKPWgbm6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=somekey;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ziemianowicz.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ziemianowicz.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNWbZy0MhIFa4gZysL50nY1PxWF4z1ETCbIJAFC+15RnR7xpiSx7nZEv7waMV/U+e7Ht8YlXxVuRbMZMLNWkIFTNX7MEI7onplZPEXAfaXZlilitKbZX
    btShI+jD47GbFvWcpQxa2Tb4YMoNhkcKfqye+6hWIA3i/qRfPqfKMdPt0ep2b3+ATAprXagTNlPwwgctzL2OhpP3BSR2ijUCp9NAt0kAiIzPHCb0+tdiwKfg
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=0AA9OZvs-ncA:10 a=b5HTAggMAAAA:8 a=VwQbUJbxAAAA:8 a=uPndbxBi-bVOy7O4SS8A:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=zfgeMz1PSwFLVvhDL7gT:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbeDHKNR (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 06:13:17 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21386 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbeDHKNQ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 8 Apr 2018 06:13:16 -0400
Date: Sun, 8 Apr 2018 06:12:54 -0400
From: Marcin Ziemianowicz <marcin@ziemianowicz.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: at91: Added more information logging.
Message-ID: <20180408101254.GA51869@hak8or>
References: <20180408094330.GA51669@hak8or>
 <20180408095449.GA31179@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180408095449.GA31179@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ZohoMailClient: External
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 08, 2018 at 11:54:49AM +0200, Greg Kroah-Hartman wrote:
> On Sun, Apr 08, 2018 at 05:43:30AM -0400, Marcin wrote:
> > I noticed that when debugging some USB clocking issue that there weren't
> > many ways to tell what the state of the USB clocking system was. This
> > adds a few logging statements to see what the relevant code is trying to
> > do.
> > 
> > Signed-off-by: Marcin Ziemianowicz <marcin@ziemianowicz.com>
> 
> Your "From:" line doesn't match this name :(

Ah drat, I knew I did something wrong. You suggested in IRC that I wait a day
for others to reply, so after that I will attempt to version my patchset.

