Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753689AbeCFO5y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:57:54 -0500
Received: from muru.com ([72.249.23.125]:59640 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750838AbeCFO5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:57:53 -0500
Date: Tue, 6 Mar 2018 06:57:49 -0800
From: Tony Lindgren <tony@atomide.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, Guo Zeng <Guo.Zeng@csr.com>
Subject: Re: [PATCH v2] regmap: irq: fix ack-invert
Message-ID: <20180306145749.GC5799@atomide.com>
References: <1520283457-31637-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520283457-31637-1-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Tim Harvey <tharvey@gateworks.com> [180305 20:59]:
> When acking irqs we need to take into account the ack-invert case.
> Without this chips that require 0's to ACK interrupts will never clear
> the interrupt.
> 
> By using regmap_irq_update_bits to ACK the interrupts we use the masked
> status bits so we take care not to affect any other bits then use
> ack_invert to determine if we clear or set those bits.

This change to use regmap_irq_update_bits() now breaks things for
me with cpcap interrupts. So it seems to cause a non-inverted mode
regression. There should be no need to read the ack register, I
gues that's the whole idea of having a separate ack register :)

> The only user of ack_invert currently appears to be the motorola-cpcap
> driver which we find is incorrectly setting ack_invert and thus we
> fix that at the same time as otherwise it would break.

Regards,

Tony
