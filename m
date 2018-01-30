Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbeA3NQJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:16:09 -0500
Received: from mout.gmx.net ([212.227.15.18]:50397 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752194AbeA3NQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:16:08 -0500
Message-ID: <1517318144.10272.6.camel@gmx.de>
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
From: Mike Galbraith <efault@gmx.de>
To: Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        srinivas.pandruvada@linux.intel.com
Date: Tue, 30 Jan 2018 14:15:44 +0100
In-Reply-To: <20180130125718.iwntjuvcp3yplvdx@techsingularity.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
         <20180130104555.4125-5-mgorman@techsingularity.net>
         <20180130115054.GA2269@hirez.programming.kicks-ass.net>
         <20180130125718.iwntjuvcp3yplvdx@techsingularity.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:viIhgeiUHCKTJLY6hNoLM93cGkfLaNqnudNrf+YD62knKRNAxxm
 hGyxQ6j3cxM5Zb6JA95/Dy7DmT0pLCLaevdrHSb5PWYqiMpCaw1Ajtb3fozrqp4Gb6KoLxG
 rg4P4w094rAIXQhCmkV3htAYwsV9UYcAeE7gLZZN5WIoVdNpG+RrLquIZiNH2E+dCsCi2Au
 qJY5K8audG8wxwrC9Wpsg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RXmYY4ZqsCU=:Dxy+y0G2+160RlpE3yTKfT
 6+UPzVaX7QgnkN4f4Uo/gefmwDU7vqgf75dl4piGb8hS0Wutylw8WBEKz0A1qiV0609ZF8Ebs
 IPdt19px+/9ciO3KnVhagPmnoA263ds6YFjqunU3Ords+j8Dp9FMcNz/yu7L+HyZKF5BCkHp/
 Pr+sAW8mvhDJRQQFON5EuPgBdfd+eG56gCmxDp1qacXmGjsMvP8+SaMZBYDG1RPr6o+t7Rqbg
 KBX9RHUXaysgI0OT1MmB0QT/n2zERDP1adgZQoAVJ+KUQWjR6pj3hqTULUeSy5qrGR7Z3Cv2Y
 aGDz+KwtgYXWTUz0gVubjjUEKxQaZUJVJwOJqEAga1XdgTaas3BaQ3om19yGcA1nvGLnLrniF
 KFjVvonqvcTXX+cRqVpuupQ4hbVdWiAciRmsmrkiHoB7Z7UQwhB9xxRs5Kj2if6uRVBLWwWpN
 uWt/Gdp+lBj7Cxo2Wy+lnbfIpp6/V6Sj6sNRV8M26ckzwAOqs85S70tAH4b5B1NFUby54LQC7
 2IyQEBV18edhdhVokkwo1N21ZkTIV04zDY0DwWv9J0aGVCqg6T4qrFTDD73PZwO1d7/zXfc+X
 8FSZmoi/YKvMsNMzGjVuyuk7NhqiPeXXZqOYvqwWv0ye5sIE/vjcP3eWlbdBm30tQZfoaHXUh
 iC2ymN2MqqsqVvP4VpvHwGveh7hnK4JKj+WTu56OQIk4tShnvt3UavX/EI85XTzB2VPx4B3gg
 bPOvbuzBuYbK7AmLGhQzuqb42iaVRE7wGiJ0VVCJLL3sPs7asrPTOImWcnmrke1akIH8HQ+T/
 UDdRYywrANiYfuXlGZepu6oXK8n1Jnkej4b2iPd2krQRW9G3b8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-01-30 at 12:57 +0000, Mel Gorman wrote:
> On Tue, Jan 30, 2018 at 12:50:54PM +0100, Peter Zijlstra wrote:
> 
> > Mel, what hardware are you testing this on?
> 
> The primary one was a single socket skylake machine with 8 threads (HT
> enabled).

I took it for a spin in a 2 x Gold 6152 box.

	-Mike
