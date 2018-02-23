Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeBWImj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:42:39 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:40532 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeBWImh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:42:37 -0500
Date: Fri, 23 Feb 2018 09:42:38 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
cc: Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH v2 1/2] irqchip: stm32: Optimizes and cleans up stm32-exti
 irq_domain
In-Reply-To: <6491f248c6748f21a2acf310e186d2be4f9b4e4c.1519374248.git.radoslaw.pietrzyk@gmail.com>
Message-ID: <alpine.DEB.2.21.1802230938510.11168@nanos.tec.linutronix.de>
References: <cover.1519374248.git.radoslaw.pietrzyk@gmail.com> <6491f248c6748f21a2acf310e186d2be4f9b4e4c.1519374248.git.radoslaw.pietrzyk@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radoslaw,

On Fri, 23 Feb 2018, Radoslaw Pietrzyk wrote:

> - discards setting handle_simple_irq handler for hierarchy interrupts
> - removes acking in chained irq handler as this is done by
> irq_chip itself inside handle_edge_irq
> - removes unneeded irq_domain_ops.xlate callback

if that's all functionally correct, then this is a nice cleanup. Though
from the above changelog its hard to tell because it merily tells WHAT the
patch does, but not WHY. The WHY is the important information for a
reviewer who is not familiar with the particular piece of code/hardware.

Can you please amend the changelog with proper explanations why a
particular piece of code is not needed or has to be changed to something
else?

Thanks,

	tglx
