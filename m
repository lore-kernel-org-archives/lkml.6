Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754855AbeEWSLC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:11:02 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:38378 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752282AbeEWSLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:11:00 -0400
Date: Wed, 23 May 2018 11:10:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Ray Jui <ray.jui@broadcom.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] Documentation: DT: Add optional 'timeout-sec'
 property for sp805
Message-ID: <20180523181058.GC27570@roeck-us.net>
References: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
 <1527014840-21236-2-git-send-email-ray.jui@broadcom.com>
 <af81ea74-fb80-11e2-7bdc-d3607bdbd46b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af81ea74-fb80-11e2-7bdc-d3607bdbd46b@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 11:57:25AM +0100, Robin Murphy wrote:
> On 22/05/18 19:47, Ray Jui wrote:
> >Update the SP805 binding document to add optional 'timeout-sec'
> >devicetree property
> >
> >Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> >Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> >---
> >  Documentation/devicetree/bindings/watchdog/sp805-wdt.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> >diff --git a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
> >index edc4f0e..f898a86 100644
> >--- a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
> >+++ b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
> >@@ -19,6 +19,8 @@ Required properties:
> >  Optional properties:
> >  - interrupts : Should specify WDT interrupt number.
> >+- timeout-sec : Should specify default WDT timeout in seconds. If unset, the
> >+                default timeout is 30 seconds
> 
> According to the SP805 TRM, the default interval is dependent on the rate of
> WDOGCLK, but would typically be a lot longer than that :/
> 
Depends on the definition of "default". In the context of watchdog drivers,
it is (or should be) a driver default, not a chip default.

Guenter

> On a related note, anyone have any idea why we seem to have two subtly
> different SP805 bindings defined?
> 
> Robin.
> 
> >  Examples:
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
