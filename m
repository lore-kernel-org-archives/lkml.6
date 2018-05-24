Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034158AbeEXRLR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:11:17 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:60682 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031530AbeEXRLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:11:11 -0400
Date: Thu, 24 May 2018 10:11:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ray Jui <ray.jui@broadcom.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v3 4/6] watchdog: sp805: set WDOG_HW_RUNNING when
 appropriate
Message-ID: <20180524171107.GB9499@roeck-us.net>
References: <1527120924-12131-1-git-send-email-ray.jui@broadcom.com>
 <1527120924-12131-5-git-send-email-ray.jui@broadcom.com>
 <20180524161901.GB28425@roeck-us.net>
 <5e3d05f2-d526-9108-e2fd-13573458be85@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e3d05f2-d526-9108-e2fd-13573458be85@broadcom.com>
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

On Thu, May 24, 2018 at 09:36:25AM -0700, Ray Jui wrote:
> 
> 
> On 5/24/2018 9:19 AM, Guenter Roeck wrote:
> >On Wed, May 23, 2018 at 05:15:22PM -0700, Ray Jui wrote:
> >>If the watchdog hardware is already enabled during the boot process,
> >>when the Linux watchdog driver loads, it should reset the watchdog and
> >>tell the watchdog framework. As a result, ping can be generated from
> >>the watchdog framework, until the userspace watchdog daemon takes over
> >>control
> >>
> >>Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> >>Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
> >>Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> >
> >Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> >
> >I have one question, though: Is it really correct that both
> >INT_ENABLE _and_ RESET_ENABLE have to be set to enable the watdog ?
> >What if only RESET_ENABLE is set ?
> 
> According to the SP805 TRM, INT_ENABLE needs to be set to high to enable the
> counter and the interrupt. Counter will be stopped if INT_ENABLE is cleared.
> So yes, INT_ENABLE needs to be set.
> 
Excellent, thanks for the clarification.

Guenter
