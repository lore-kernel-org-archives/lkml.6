Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2005596-1520008109-2-15384849946283635201
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520008108; b=DSRuwVzSOYDeCk826l/V9VClZPN84dJs8w82FHMiGALfIy8
    C2e/bBnWhk1KoaIPEOWcXTRoL6nFBizKsgrudcMbh9zC9jBgkc+PpSDYd3xPqgwS
    N6EdFbbBMCbhDWyHnjm+VbUXZI8tTvwMc0IZ0Bzea0uNuA9B3g76ORwc1WIQYMd7
    aBf3pXSDYkEYt7mpVABWFahw+1QSPaJUrzotXd1RVHlwe87VMXIYZ0RdgOsq3lL+
    v0JnZa+JtvRfV5DwD2HM3sLWV/bRCqE8rHz9gENt8Qh5aiGQx9UYDdtO/xp0YxFa
    kNGx/VTzpN0msbQaa9GAcAS+FlN/QxXiCRyf0ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520008108; bh=HNv7jVyZUgPnR0nOcfhOqYgEsd
    bebhgy1i64DC0LYL4=; b=Flw3/M7zQdwS/X5hNjXs0y6J9VYyOP35wwTouoYxJj
    OiCSYI2BElqXYx6vUgpF3WxoZfYk+5RqxV7k6FDqZfogeXEchKWBa8vD34hmUpQN
    5nKrshsF5I0AYUIh9eOE7YN1+ZefTEnfzDo6EeZBrubkPIRMIWDynro/l1DrZ5AP
    dXCCk+SL8rHoLzlWKoh+NZaYTAfiOGvP0wzOkbpR5iwy9wJL5mooEWWRAZmAiL+q
    6lLiXAZdOMZOlS8958QCSLnPZeAtknxJZ3w5uwnXtvySwxJJ6Y9wM8OFeyNT9Sre
    JSzjyIEZrWN5dZKTBluqomXnsjOoZVmejtcnmMA8U12A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936016AbeCBQ21 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 11:28:27 -0500
Received: from foss.arm.com ([217.140.101.70]:57758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932746AbeCBQ20 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 11:28:26 -0500
Date: Fri, 2 Mar 2018 16:28:21 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        linux-samsung-soc@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-i2c@vger.kernel.org,
        Ben Dooks <ben-linux@fluff.org>, stable@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
Message-ID: <20180302162821.bmsxgrqqaginjooo@lakrids.cambridge.arm.com>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302111931.GX9418@n2100.armlinux.org.uk>
 <20180302124647.sfhnto77wgdh5sv6@katana>
 <20180302125907.GA9418@n2100.armlinux.org.uk>
 <20180302135854.76ue5jzsg7lvxjxw@katana>
 <20180302140901.lrjqiaa2k4nxkqco@mwanda>
 <20180302153221.GB9418@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302153221.GB9418@n2100.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 03:32:22PM +0000, Russell King - ARM Linux wrote:
> How do we break this status quo and finally solve the IRQ 0 and
> NO_IRQ issue?

> Another possibility would be to change platform_get_irq() and
> suffer the regressions that will cause, telling people that fixing
> their platform IRQ numbering is the only solution (but this
> requires breaking our ideals about regressions.)

How about we start with a warning? That'll be visible, but shouldn't
result in broken systems while we wait for people to fix things up.

e.g. something like the below.

Mark.

---->8----
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index f1bf7b38d91c..bd42eeffd2aa 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -126,7 +126,12 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
                irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
        }
 
-       return r ? r->start : -ENXIO;
+       if (!r)
+               return -ENXIO;
+
+       WARN_ONCE(!r->start, "Platform uses zero as a valid IRQ.");
+
+       return r->start;
 #endif
 }
 EXPORT_SYMBOL_GPL(platform_get_irq);
