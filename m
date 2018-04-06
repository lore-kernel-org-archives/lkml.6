Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeDFRdn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 13:33:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40372 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750807AbeDFRdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 13:33:41 -0400
Subject: Re: [PATCH 1/5] arm64: entry: isb in el1_irq
To: Mark Rutland <mark.rutland@arm.com>
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
References: <20180405171800.5648-1-ynorov@caviumnetworks.com>
 <20180405171800.5648-2-ynorov@caviumnetworks.com>
 <5036b99a-9faa-c220-27dd-e0d73f8b3fc7@arm.com>
 <20180406165402.nq3sabeku2mp3hpb@yury-thinkpad>
 <20180406172211.r42reit2bnpocab2@lakrids.cambridge.arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <1ef13053-c3eb-deea-a4cc-67723fdf47f8@arm.com>
Date: Fri, 6 Apr 2018 18:30:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180406172211.r42reit2bnpocab2@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 06/04/18 18:22, Mark Rutland wrote:
> Digging a bit, I also thing that our ct_user_exit and ct_user_enter
> usage is on dodgy ground today.

[...]

> I think similar applies to SDEI; we don't negotiate with RCU prior to
> invoking handlers, which might need RCU.

The arch code's __sdei_handler() calls nmi_enter() -> rcu_nmi_enter(), which
does a rcu_dynticks_eqs_exit().


Thanks,

James
