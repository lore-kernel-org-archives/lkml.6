Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbeERRkX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 13:40:23 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59537 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbeERRkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 13:40:18 -0400
Date: Fri, 18 May 2018 19:39:38 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Vince Weaver <vincent.weaver@maine.edu>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Eric Anholt <eric@anholt.net>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Message-ID: <1113496355.72893.1526665178400@email.1und1.de>
In-Reply-To: <278cb8b1-d567-2067-2dde-980596821c9c@arm.com>
References: <20180518143913.26306-1-marc.zyngier@arm.com>
 <alpine.DEB.2.21.1805181222380.11339@macbook-air>
 <278cb8b1-d567-2067-2dde-980596821c9c@arm.com>
Subject: Re: [PATCH v3 0/5]
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev28
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:zUcNcaqP/0pphpB49B4NYF3SjuV6vetTndGj6qhvc5xY1s7iVi+
 kXrkORkfzVHKAJ/PeJvXvhWh2z8f5UD88rjm9Jw9ey97KlNaCb7yQWDxCOif2X2r3eG5FTQ
 C88lzdXjBSmIWagQqPkn4aNLujdRuQvWJuJWbnHmuGiObxQ6VbBqF3eo8yoliGGXiSgrORS
 asKSDXNHdK+jjGYi/Lvkg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J3IOPoODnB8=:3aisz8GI2DrTwT/RUlXB2l
 cqMWNQySVW8gml7in4e4ny5PyAdUPznTb89wpviiR5wLZyYgDXw0ZfY13Q3nm7iNgeihRSRZD
 rv4znEtqGyD9kAJIbJemNAKH5R9hLlhuiWNpYXXglXgSt/9UDsGux4X8U2EYKHRf/z7RN+jF2
 b1ZhmGsjA9wP/F8M2HdE3MrSN6bc1rFRqoKKk7LY2irdgkqjGdFnwJYxomxtYmB0mTc8TSLoU
 uNuzDA4l99WZ91F0s6E7SBPi2ByFtke0lc/oN29A8GLuD8yJCu44Z7UmP6XSzhxuSZeDoPs0m
 ZvGru+lF1Mcpi587sV3rp6VyplfzrgPuOiwANc5HmQctE7wT1bkQcXMNPpTB7e3TaoWFrBcej
 nC5JDIDv4UMba/MZJL2PXrtfRxJQ8GqSxBprEHD6tu9P4T0GMFJbbKur102hAJkPn5DAaukkz
 5tuSOp6pJhUFMI3s3gAriER2RuJocU+oJtwzWsZ6q7XcbADDenUfnEIATdNtnqOvGuho1TOgp
 gGwYKnmkTILCXBhBQiRK6ulkbhOIO7Blnny92FE7toByX1QhmofMy5QMZU4ruvOlREo07urnc
 N5BhXaCm9q3MkWhpes6Mue9PJAX0fJkJUrSEM0y8X5NmZHc7SWRik0GUiTVH4L5njT5v2b2zU
 IaUdRiUEkqMyNMfurlIDHs5TobiQXBcXVdXBvsXLqP1L8txHyNdBKTRz+vkIo0p1NymOvXGCA
 lAT9z7wLxsf7DHUp
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Marc Zyngier <marc.zyngier@arm.com> hat am 18. Mai 2018 um 18:41 geschrieben:
> 
> 
> [/me beats himself for not writing a subject line...]
> 
> On 18/05/18 17:29, Vince Weaver wrote:
> > On Fri, 18 May 2018, Marc Zyngier wrote:
> > 
> >> There is also the case of people natively running 32bit kernels on
> >> 64bit HW and trying to upstream unspeakable hacks, hoping that the
> >> stars will align and that they'll win the lottery (see [1]).
> > 
> > I've tested these patches on a Raspberry Pi 3B running a 32-bit upstream 
> > (4.17-rc5-git) kernel and they work.
> > 
> > [    0.472906] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 counters available
> > 
> > I only needed to add this to the devicetree
> > 
> > 	arm-pmu {
> > 		compatible = "arm,cortex-a53-pmu";
> > 		interrupt-parent = <&local_intc>;
> > 		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
> > 	};
> 
> That's definitely the sensible thing to have on such hardware. Why isn't
> it in the upstream DT already, irrespective of the state of the kernel
> support?

I remember that Vince point out the absence. He asked about how to implement it and i wasn't sure about it. At this time we hadn't IRQ polarity support. So we wanted to get this puzzle piece before. In march i put it on my TODO list, but then RPI 3 B+ support had higher prio to get into 4.18.

In general we have the problem that most of the users take the downstream kernel and don't know about the differences. Luckily more distributions switch to the upstream kernel, which increases the feedback.

> 
> > Tested-by: Vince Weaver <vincent.weaver@maine.edu>

Thanks again
Stefan

> 
> Thanks a lot for testing.
> 
> 	M.
> -- 
> Jazz is not dead. It just smells funny...
