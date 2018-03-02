Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968053AbeCBQoY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:44:24 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58214 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967014AbeCBQoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:44:18 -0500
Date: Fri, 2 Mar 2018 16:44:13 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Grzegorz Jaszczyk <jaz@semihalf.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Hoeun Ryu <hoeun.ryu@gmail.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH] arm64: kdump: fix interrupt handling done during
 machine_crash_shutdown
Message-ID: <20180302164411.fxdx72ttz7livz2e@lakrids.cambridge.arm.com>
References: <1519837260-30662-1-git-send-email-jaz@semihalf.com>
 <20180228171647.6t4dabntujcb5kon@lakrids.cambridge.arm.com>
 <ba0c6804-51a3-f36e-a67e-20ce84961451@arm.com>
 <CAH76GKO8oYVN+H4pvd6NTGc0u8AD7JMSJCYEJzNtdsAJm5L_9w@mail.gmail.com>
 <20180302120556.xujh3hoy44y7ouz7@lakrids.cambridge.arm.com>
 <CAH76GKNw=irEY8BjhkaMnKm5m6AeCz8ZN67vrWSC6ByBmMMh8g@mail.gmail.com>
 <20180302131545.q2vf6uc3yofofqdb@lakrids.cambridge.arm.com>
 <CAH76GKOe=+WTrw8QEJ43+fyEfRPuo7+ds8VNoMCUqSNBMtxkyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH76GKOe=+WTrw8QEJ43+fyEfRPuo7+ds8VNoMCUqSNBMtxkyg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 02:52:07PM +0100, Grzegorz Jaszczyk wrote:
> 2018-03-02 14:15 GMT+01:00 Mark Rutland <mark.rutland@arm.com>:
> > Do you see this for a panic() in *any* interrupt handler?
> 
> I only test with this two interrupt handlers: watchdog and i2c but I
> think it will behave the same with others - I can try with other if
> you want, any suggestion which? Maybe with some PPI interrupt instead?
> >
> > Can you trigger the issue with magic-sysrq c, for example?
> 
> There is no problem when I trigger it via 'echo c >
> /proc/sysrq-trigger' - it works well all the time. The problem appears
> only, when the kexec/kdump procedure is triggered from interrupt
> context

I'd meant that you'd send sysrq + c over serial, rather than writing to
/proc/sysrq-trigger. That way, the panic will be in the context of the
UART IRQ handler.

If that shows the issue, that's ilikely to be the easiest way for
someone else to reproduce and investigate this.

Thanks,
Mark.
