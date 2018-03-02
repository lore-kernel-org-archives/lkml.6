Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1525519-1519994102-2-11550879488266882456
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
    t=1519994102; b=f5Y1IeHXN0ZhcskUN3Ybd7/a12mfwidLihwZVMIPGjlS+aX
    WyN4Xod60BcPU3xa1BdOCqDusLIQ171HBdv6jOMGcOPh+ROIMaTA9g+/4CNLQtzP
    E4UIo6pCwgoL4i+5+NfyPYLcvxaRIFM54iHYM0w9Ut5a01ExKrYGT1EwtIsr5Thr
    l806g0yIVt03FqF59mavZJSFoJyQx8NvBG4jyj9ykgMbS3zF+Tt7ifABjwQ414sN
    us1d8NWYVYqS2OA7W55jyRjEoDu++r2PIjT+0kL3803ZTHafFFpRnmCBbUuzmXZw
    4ipsDxTgXxCOb/JNUJRhVCR9rKRNv7JlTC+HqGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519994102; bh=1yKOoUohKzKcMlFx/r+BINW6mZ
    64vllffX7NbmIvbn8=; b=C6bkV+DSf7KeGT8BDJ3g3Zg66bGB8oeOj5Vec7eAdj
    WFAagxbeCXzEDMZCdUWU/BH3VmeevKHOYA3I+p7fCJQZJIhz3fwUM2yVpFzyloYN
    jQHZ1vHI7xznYxfQm5P/ZQzP2COQ6Tx6Xqjz2XUn+6aD/aSJ2UkBeOYGpSwxyTB9
    ekfogca3nCVTkujAaErezixBnvwC8nyMrOMrsd7WKDbGse3NnUQ+w5ohnKj1Dtg8
    LmyHqZmO+h09TNprxCrya5m7l6z3rZrERk/ArHy0zcs6UQpM+vNFNNr5T8ZGZeLI
    fYcLIpvmDNfMurJ8POgJGDsqYGE+KvlZWiaSykCNA+wQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Ci8YuTmb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=pandora-2014;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=armlinux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=armlinux.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Ci8YuTmb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=pandora-2014;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=armlinux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=armlinux.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165003AbeCBMe7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 07:34:59 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:48190 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164824AbeCBMe4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 07:34:56 -0500
Date: Fri, 2 Mar 2018 12:34:44 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
Message-ID: <20180302123444.GZ9418@n2100.armlinux.org.uk>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302111931.GX9418@n2100.armlinux.org.uk>
 <20180302114909.u6kqdszt3aew2io2@mwanda>
 <20180302121929.GY9418@n2100.armlinux.org.uk>
 <20180302122655.uckejonjyzt4vjd3@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302122655.uckejonjyzt4vjd3@mwanda>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 03:26:56PM +0300, Dan Carpenter wrote:
> Ok, but in that case the original code is still wrong because it returns
> early with success.  I guess it could be changed to:
> 
> 	if (irq <= 0)
> 		return -ENXIO;

What if platform_get_irq() returns -EPROBE_DEFER or some other error
code?

So we're now re-hashing all the discussion from last November.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
