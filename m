Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751506AbeERQ3n (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:29:43 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35098 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeERQ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:29:41 -0400
X-Google-Smtp-Source: AB8JxZrsH/VrMOFHtGsmDfAxbazVdKyg8DLtnFJMdWHQr2GCHTjEu7OCDhj0KpJSPL8W1okoArhQdA==
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Fri, 18 May 2018 12:29:36 -0400 (EDT)
X-X-Sender: vince@macbook-air
To: Marc Zyngier <marc.zyngier@arm.com>
cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v3 0/5]
In-Reply-To: <20180518143913.26306-1-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.21.1805181222380.11339@macbook-air>
References: <20180518143913.26306-1-marc.zyngier@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2018, Marc Zyngier wrote:

> There is also the case of people natively running 32bit kernels on
> 64bit HW and trying to upstream unspeakable hacks, hoping that the
> stars will align and that they'll win the lottery (see [1]).

I've tested these patches on a Raspberry Pi 3B running a 32-bit upstream 
(4.17-rc5-git) kernel and they work.

[    0.472906] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 counters available

I only needed to add this to the devicetree

	arm-pmu {
		compatible = "arm,cortex-a53-pmu";
		interrupt-parent = <&local_intc>;
		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
	};


Tested-by: Vince Weaver <vincent.weaver@maine.edu>

Vince
