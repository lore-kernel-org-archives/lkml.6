Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1414047-1519989621-2-10616056239587688572
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519989621; b=Q4oRGDaKA4h3j95SX7YkXDokfRB7E2xh872AdpIWlstxDUO
    q00bZTJq8SdurDBo/F/kboFoMslN4YOK8yv+inMfP3STYcVxnM5XLc9zhQALUDv1
    Tep2MdkZzoQ497R/tJsc5gPxHXNQmIqGpHN310c9nMfx3+PVZRoNAQu5s6W7kWOW
    gdDSfWhgfcdqEVlvpQ8R1rQhAQv20MknMd0Ciq7jVXTvEWIfBBaprhcJrcvIx1a9
    XHeC5NUpYFeqvqXC3pYX8Pv9pfRKFb77kKEmnJ49nQbsxQPoN5fIiSgZTUgyAZiz
    xfxcdN4nxeTMdoX4GjC8GYSAFAz5gA0TsrcYLIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519989621; bh=2lXaDJf/CSXu8f6abn52dtyBue
    DA8CaNAR7LDnBSDhU=; b=SUWntdJSjUPF+kPK3SHYVJohUOJJhzU2gdLmH3bQ5z
    2UVwAjPMNxaVLV7D6bUE4UQucrKwUQzXNYpI3RuUY2uVtadn1gOynX3RvuZNet4/
    XO3Vu9h2DYAfIOM5iS2tFZh6jC4+i13cuUwhuNgS1uRkDa3uCvqFJ9nrD+jqUHgM
    aCVGkevpm08xFeBjPYH4sEmfnLlbWBN4knKwNDxmmbG2Y1dyRkoolZznKtcMAPVj
    Iq/6KhmPwkjRqcjDhDq5EBJiiYBXnBpE8Cn2eM7s/l5iOvzWt0fZviy3LKJugYxT
    /8aUubI2i882Ma1QPY1qc0mODK5uin8rZ+HY7f88ZEGw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TsETwiQn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=pandora-2014;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=armlinux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=armlinux.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TsETwiQn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=pandora-2014;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=armlinux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=armlinux.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423344AbeCBLTy (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 06:19:54 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47244 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423202AbeCBLTw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 06:19:52 -0500
Date: Fri, 2 Mar 2018 11:19:31 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ben Dooks <ben-linux@fluff.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
Message-ID: <20180302111931.GX9418@n2100.armlinux.org.uk>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519936484-23132-1-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 09:34:44PM +0100, Krzysztof Kozlowski wrote:
> Interrupt number 0 (returned by platform_get_irq()) might be a valid IRQ
> so do not treat it as an error.  If interrupt 0 was configured, the driver
> would exit the probe early, before finishing initialization, but with
> 0-exit status.

The official position (as stated by Linus) is that interrupt zero is
not a valid interrupt for peripheral drivers (it may be valid within
architecture code for things like the x86 PIT, but nothing else.)

You need to number your platform interrupts from one rather than zero.

Note that there have been patches proposed to make platform_get_irq()
return an error rather than returning a value of zero, so changing
the driver in this way is not a good idea.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
