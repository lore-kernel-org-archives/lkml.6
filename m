Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754713AbeBNMIT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 07:08:19 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38934 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754616AbeBNMIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 07:08:17 -0500
X-Google-Smtp-Source: AH8x227LBHY4Q+lUurhxWz49qNQoOtlGF7Mu4ISf7k7pSsi+HCyUTW0/RDpJrt0h1YdssWua2GHE8w==
Subject: Re: [PATCH] irqchip/gic-v3: Support MSIs via aliases and distributor
To: Stephen Boyd <sboyd@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        sboyd@kernel.org
References: <20171127102408.6631-1-sboyd@codeaurora.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <bf71552e-6ea0-55f3-6b42-f4a1a3f65cb9@linaro.org>
Date: Wed, 14 Feb 2018 12:08:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20171127102408.6631-1-sboyd@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/11/17 10:24, Stephen Boyd wrote:
> Some GIC configurations don't have an accessible ITS, but they
> want to support MSIs through the distributor's SETSPI registers
> or through the IMPLEMENTATION DEFINED message-based interrupt
> request register region. This mode of operation is similar to the
> v2m support on gic-400, but we don't necessarily know what
> particular SPIs are supported as MSIs so we need some help from
> firmware to know what to do.
> 
> Introduce an "arm,spi-ranges" property for this, similar to the
> "marvell,spi-ranges" property, that indicates the base and size
> of each MSI range. This property applies equally to the
> distributor and alias registers. In either case, we detect this
> mode of operation by looking for a node with the "msi-controller"
> property and then probe the v2m frame code on top of it. Assume
> these nodes will have the "arm,spi-ranges" property in them so
> that the v2m code works mostly unmodified.
> 
> Cc: <devicetree@vger.kernel.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>   .../bindings/interrupt-controller/arm,gic-v3.txt   |  48 +++++++++-
>   drivers/irqchip/irq-gic-v2m.c                      | 102 ++++++++++++++++-----
>   drivers/irqchip/irq-gic-v3.c                       |   4 +
>   include/linux/irqchip/arm-gic-common.h             |   3 +
>   4 files changed, 129 insertions(+), 28 deletions(-)

What's the plan on this?
I have not seen this patch in rc1 or in next.

We have a dependency on this to get WLAN working on DragonBoard820c.


thanks,
Srini
