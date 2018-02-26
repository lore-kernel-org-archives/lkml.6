Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2498165-1519639521-2-11326380941556003528
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519639521; b=qaSRl4aPIkKuwRtAnm+A24urL1vfDCkwxlOWAxberP1YRSI
    dSNb6ZfMdqQlS9+0ZUix9Aja+7ZBT392Sjtm5aLdPudedUhSpV7BsefibE9jqKno
    gB2tGn1Qajga7YJ09Pi4hq/sRQ39ubUasY+F0I8ADaVoZKhHGhV14CPw1pxrvXci
    14DvXQRye6WpjDpdXoBq8ArTWTWJ48gRsQWos33Qsc4uzgcJxvbozqC48eXJEdJn
    YiRihKteYE+DuR1jum81NNjPzX1HvY0agJSqErmR2c6rO0OJNgP3hT5C8a5vydpm
    S3nWLLdH9xU2TKDQqIXO1M2wtSxr/QCbQESFwKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519639521; bh=gD3NB9Ii8he4w59S3hFLmi3/t6
    X3VJviHerTZSp4UAw=; b=F5lUOGGAZZaGve7qST+Q1plFtdCC6V+2P5ad1lcZEh
    FKsTNUl49IV5uEP/CRgtzt14NWs3MFB8jF4LXig3V4g3I6syDgH3EFgpPMyWPLLo
    zUppvx9gcmJ1cxpwrcqPeKKlg06dBoBsQPx9o4XvmKonMTFVjBT3QwvnU7dtfyND
    l/nw7D7OeusBpQaRM1MCX08UVtv3NkWib7/X+CI3ZkkhvkwY2d/HyIUpSCXNCf8g
    opMHXCksfdhO0Te+j3rBkO0fhZvUXVeeyhjWTmu1GE7gUlwofyPZL60SBaOs1MC2
    3cv4QG8sk6GgsgHMB8tgdn+y8Y5Z05R4V4BQwWQEPv8Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=CtK/Vvbv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=CtK/Vvbv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeBZKFS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 05:05:18 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57209 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751609AbeBZKFR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 05:05:17 -0500
X-ME-Sender: <xms:3duTWvc77nMQkvIKd9xfINsFtdXCk5_OnqpXrGTC9W9O5oZSQzcTMw>
Date: Mon, 26 Feb 2018 11:05:18 +0100
From: Greg KH <greg@kroah.com>
To: Alex Shi <alex.shi@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 46/52] arm: Add BTB invalidation on switch_mm for
 Cortex-A9, A12 and A17
Message-ID: <20180226100518.GA11378@kroah.com>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
 <1519633227-29832-47-git-send-email-alex.shi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519633227-29832-47-git-send-email-alex.shi@linaro.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 04:20:20PM +0800, Alex Shi wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> ** Not yet queued for inclusion in mainline **

As Marc said, this should have been a HUGE clue that we can't take this
patch.  Please go re-read
	https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

thanks,

greg k-h
