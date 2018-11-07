Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1478EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8C72086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IscSacw6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hlELkXPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8C72086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbeKHIKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:10:38 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49166 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeKHIKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:10:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3D77D605FD; Wed,  7 Nov 2018 22:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541630289;
        bh=oAeIIYuxqUCV7KOjdQGmOd5/9Y9AF8PGNZMc3W1TSWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IscSacw6QGpMYMYs+pLkhwhm4jBPZaaFsuzb0Nlv4TaQ47buk6Pq8789CrTXp47D6
         R95yOt/OOcFZKrF1HozHJthUGEqCuErmb6s52l7HUWKfdKkl2aJ6fGM7oFoFypfGn7
         GTsuBH0SSAYTEzLn4O8aA6Siurkv2YYHofL95utc=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 98087603D2;
        Wed,  7 Nov 2018 22:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541630288;
        bh=oAeIIYuxqUCV7KOjdQGmOd5/9Y9AF8PGNZMc3W1TSWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hlELkXPGSmTH9Xpxz5VIJ5DGlMU0mmi51UML+doFRMVp64p5HpMlmifdfkdf0Vg1u
         KXcXAuOxCivj5QdXenp0LW0ubFcfO6PSJ48+x6HgkSD/GY17C9/nccu3MzDI9HVI9C
         9ZkEwGBf9BS5X/y4JHEl1wC3FYsYZz5FZ6YVTFq0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98087603D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 7 Nov 2018 15:38:07 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, evgreen@chromium.org,
        marc.zyngier@arm.com
Subject: Re: [PATCH RFC 1/1] drivers: pinctrl: qcom: add wakeup capability to
 GPIO
Message-ID: <20181107223807.GA10557@codeaurora.org>
References: <20181011002958.2597-1-ilina@codeaurora.org>
 <20181011002958.2597-2-ilina@codeaurora.org>
 <154096954339.98144.12348474096990107321@swboyd.mtv.corp.google.com>
 <20181031164650.GJ17444@codeaurora.org>
 <154103121313.98144.17090840121035743646@swboyd.mtv.corp.google.com>
 <20181101171630.GM17444@codeaurora.org>
 <154148156278.88331.3764949163056562893@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <154148156278.88331.3764949163056562893@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05 2018 at 22:19 -0700, Stephen Boyd wrote:
>Quoting Lina Iyer (2018-11-01 10:16:30)
>> On Wed, Oct 31 2018 at 18:13 -0600, Stephen Boyd wrote:
>> >
[...]

>Ok. I don't see why we need to limit ourselves here. If a GPIO interrupt
>isn't routed through PDC physically why does it matter? It shouldn't be
>why we avoid hierarchical irq domains.
>
Ok, now that we are not limited by this requirement...

>It doesn't seem like they can be exactly the same because of deep idle
>wakeup, so I suggest we go back to the beginning:
>
> * Split PDC into two domains, one for GIC and one for TLMM and
>   associate the TLMM one with an irq_domain_bus_token enum so
>   that TLMM can look it up with irq_find_matching_host()
>
The complexity here is that the GPIO and GIC interrupts are intertwined
at the PDC.
It would be ugly to describe the GIC interrupts with holes for the GPIOs
and the other way around as well. A single PDC instance would be best
way to keep things simple and clean.

Instead, we could have TLMM -> TLMM-PDC -> PDC -> GIC. The TLMM-PDC
being the interrupt controller that sets up the IRQ parent for the GPIO
IRQs.

Thanks,
Lina

> * Set TLMM as the child of the PDC TLMM domain
>
> * Allocate irqs from TLMM and have those allocate in the parent domain
>   if the TLMM is in a hierarchy domain with irq_domain_alloc_irqs()
>
> * When allocating an irq in TLMM's irqdomain::alloc function pass a
>   TLMM specific struct to irq_domain_alloc_irqs_parent() last argument
>
>   struct qcom_tlmm_fwspec {
>      bool mask;
>      struct irq_fwspec spec;
>   };
>
> * Have the PDC driver set the mask bit and the MPM driver not set the
>   mask bit in the qcom_tlmm_fwspec above
>
> * Have the TLMM driver use the mask bit to figure out if it should mask
>   or not mask the interrupt in the TLMM hardware
>
>This way we can use the last argument to irq_domain_alloc_irqs_parent()
>to communicate between the PDC/MPM drivers and the TLMM driver about how
>the irq is being managed by the wakeup domain.
>
>There will be some other functions to call for the hierarchy irq calls
>in the TLMM code, specifically the set_type callback and the set_wake
>callback need to call up to the parent irq domain so the MPM can trap
>the set_wake calls to know what to monitor and the PDC can trigger
>correctly. You can look at what Thierry has done for Tegra[1] and copy a
>lot of that patch series.
>
>The main difference is that on Tegra they have hardware replay the edge
>vs. on qcom platforms we'll rely on the GIC SPI line for each PDC line
>to go high and then have the hierarchy replay the interrupt. Also, on
>Tegra they don't really care to allocate the irq in the GIC, whereas on
>qcom we'll want to allocate the interrupt in the GIC to get the replay
>to work. In the MPM design I think we'll need to use the
>irq_set_irqchip_state() API too so the MPM driver can replay the edge
>interrupts into the TLMM hardware when the MPM summary irq runs.
>
>[1] https://lkml.org/lkml/2018/9/21/471
>
