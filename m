Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3264212-1518627623-2-14794433267831883969
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518627623; b=p6JrjH/HvQsPZ/H+n5mnfb0hHIknbbvgmrxRzk8oTceB3wH
    7ASigQ+v2BA/JiNFb4uI9rtx41CPdIR20i0MD3/rcUHAD6cwOS/YoIGCbFHL8+5Z
    tZhr22DO9Y7gxcIAWAPEwhAco7M8TqPP9koEwFUHy6x3Dpign7Z2gFM52nUeaz5O
    jW928vDOeHrF0IvvLckPi6iYcnUaGEOmvMSjtvB9VYxcnWxh02VN2F5R9Cp1cdqO
    ueVxd2rz0GK4NgTdO5fB4WN/dZCQkp1BKQjSCmfvMuFMUCm0E6ogP7c8erFYt8NK
    0Eag6LEcyH9bQlag5B8Sl7V/MxVdujxd2zBZoEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518627623; bh=VQFxQzNHB2LGUqKoWc5wmRbBn8
    hUVv3CQctVWTkqkC0=; b=Y75LlN6RcEc53pfAEZMXnda9AsQZp2KHNwhVeWktO+
    unCMNqL2L5zF+Y7kBqK/cg5mCMJsbOptTJoE9FIe7w19jERy6xLFXr0khnfTQ2JD
    +gaVaxKiq97dm1xgUUS6ZzUVhyMFT01j56lE6pa0nyqsqswGlk8XchuUJlR/v8rI
    EXaapGkZk/Nn8pVmkZtqQkrwsW9wWjEmLVFOhrOk7RwhO079+lpvOU8AYAnWNjFn
    zSuCHcCoZcGjIvTHfj/JU+AFUVRuh0TgletY/HOmGRICEovxhxIarhWc32yB+4kl
    Id1M6FwcOs5MG1W4e0epjkzkm+BxAJVmLfs89zyb3Eqg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033118AbeBNQ7z (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 11:59:55 -0500
Received: from muru.com ([72.249.23.125]:57004 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033042AbeBNQ7y (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 14 Feb 2018 11:59:54 -0500
Date: Wed, 14 Feb 2018 08:59:50 -0800
From: Tony Lindgren <tony@atomide.com>
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-omap <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 4/4] ARM: dts: am43xx: Enable dual-role mode for USB1
Message-ID: <20180214165950.GK6364@atomide.com>
References: <1516626688-2302-1-git-send-email-rogerq@ti.com>
 <1516626688-2302-5-git-send-email-rogerq@ti.com>
 <d2c871ac-105b-2c11-747b-d430489b3cff@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2c871ac-105b-2c11-747b-d430489b3cff@ti.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Roger Quadros <rogerq@ti.com> [180122 05:17]:
> +Tony
> 
> On 22/01/18 15:11, Roger Quadros wrote:
> > USB1 port is micro-AB type and can function as peripheral
> > as well as host. Enable dual-role mode for USB1.

Looks like I don't have this one, please resend it
separately when it's safe to apply.

Regards,

Tony
