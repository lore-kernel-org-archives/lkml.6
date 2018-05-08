Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932735AbeEHOrN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:47:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59436 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932706AbeEHOrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:47:09 -0400
Subject: Re: [PATCH 01/11] irqchip: stm32: Optimizes and cleans up stm32-exti
 irq_domain
To: Ludovic Barre <ludovic.Barre@st.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald BAEZA <gerald.baeza@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        radek <radoslaw.pietrzyk@gmail.com>
References: <1524759514-12392-1-git-send-email-ludovic.Barre@st.com>
 <1524759514-12392-2-git-send-email-ludovic.Barre@st.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <20a1b5f0-7494-01a9-635f-c46c337a23b3@arm.com>
Date: Tue, 8 May 2018 15:47:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524759514-12392-2-git-send-email-ludovic.Barre@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/18 17:18, Ludovic Barre wrote:
> From: radek <radoslaw.pietrzyk@gmail.com>
> 
> - In stm32_exti_alloc function, discards irq_domain_set_info
>   with handle_simple_irq. This overwrite the setting defined while init
>   of generic chips. Exti controller manages edge irq type.
> - Removes acking in chained irq handler as this is done by
>   irq_chip itself inside handle_edge_irq
> - removes unneeded irq_domain_ops.xlate callback
> 
> Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
> Acked-by: Ludovic Barre <ludovic.barre@st.com>
> Tested-by: Ludovic Barre <ludovic.barre@st.com>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Nit: the "From:" should match the SoB line (the address does, but not
the name). I can fix that up when I apply the series.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
