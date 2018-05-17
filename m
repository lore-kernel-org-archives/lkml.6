Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbeEQTbm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 15:31:42 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35332 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQTbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 15:31:41 -0400
X-Google-Smtp-Source: AB8JxZre1DNXd0eIZDqqeQJW9TSgPl91rPGLTG7KWXFxF96KnLSLg61y8J/vP0rtzNasqO8C+pPz1g==
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Thu, 17 May 2018 15:31:38 -0400 (EDT)
X-X-Sender: vince@macbook-air
To: Peter Zijlstra <peterz@infradead.org>
cc: Stefan Wahren <stefan.wahren@i2se.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
        Eric Anholt <eric@anholt.net>, linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
In-Reply-To: <alpine.DEB.2.21.1805171422450.8529@macbook-air>
Message-ID: <alpine.DEB.2.21.1805171530080.8529@macbook-air>
References: <20180517131727.29263-1-eric@anholt.net> <1412187220.62585.1526572780332@email.1und1.de> <alpine.DEB.2.21.1805171233500.7984@macbook-air> <307323036.63872.1526576126537@email.1und1.de> <20180517180758.GK12198@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1805171422450.8529@macbook-air>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2018, Vince Weaver wrote:

> On Thu, 17 May 2018, Peter Zijlstra wrote:
> with cortex-a7 now, would it be possible to later drop that if proper 
> cortex-a53 support is added to the armv7 pmu driver?  Or would that lead 
> to all kinds of back-compatability mess?

For what it's worth, the pi-foundation kernel bcm2710 device tree file 
does:

		arm-pmu {
#ifdef RPI364
			compatible = "arm,armv8-pmuv3", "arm,cortex-a7-pmu";
#else
			compatible = "arm,cortex-a7-pmu";
#endif
			interrupt-parent = <&local_intc>;
			interrupts = <9>;
		};


Which is probably where I was getting the arm,armv8-pmuv3 from in my 
original patch.

Vince
