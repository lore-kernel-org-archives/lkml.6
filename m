Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751679AbeDFRe6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 13:34:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40432 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751278AbeDFRe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 13:34:57 -0400
Date: Fri, 6 Apr 2018 18:34:50 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: James Morse <james.morse@arm.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christopher Lameter <cl@linux.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexey Klimov <klimov.linux@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] arm64: entry: isb in el1_irq
Message-ID: <20180406173450.5h7lgh2xdtcs5fbs@lakrids.cambridge.arm.com>
References: <20180405171800.5648-1-ynorov@caviumnetworks.com>
 <20180405171800.5648-2-ynorov@caviumnetworks.com>
 <5036b99a-9faa-c220-27dd-e0d73f8b3fc7@arm.com>
 <20180406165402.nq3sabeku2mp3hpb@yury-thinkpad>
 <20180406172211.r42reit2bnpocab2@lakrids.cambridge.arm.com>
 <1ef13053-c3eb-deea-a4cc-67723fdf47f8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ef13053-c3eb-deea-a4cc-67723fdf47f8@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 06:30:50PM +0100, James Morse wrote:
> Hi Mark,
> 
> On 06/04/18 18:22, Mark Rutland wrote:
> > Digging a bit, I also thing that our ct_user_exit and ct_user_enter
> > usage is on dodgy ground today.
> 
> [...]
> 
> > I think similar applies to SDEI; we don't negotiate with RCU prior to
> > invoking handlers, which might need RCU.
> 
> The arch code's __sdei_handler() calls nmi_enter() -> rcu_nmi_enter(), which
> does a rcu_dynticks_eqs_exit().

Ah, sorry. I missed that!

Thanks,
Mark.
