Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2270871-1522239728-2-7908514639318250895
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522239726; b=N38H1/g3YsZwps0o2H7tXgiRSpKgUZ8XgSuHUVNIYnKQYVz
    ae1GBemwZ87raej+xAULBUrQiLDi79YlehwqJOg3IUj1BQ+58Sga9Vp/Seo+3V2y
    Ab4n+5lHAGmu1aF7jUaPCGtQO1ZnuxaW6m6HbWPGQDwih+867Ghuj+MpOktnpChj
    B3/B7yHVzxyBdTACFvSwXUSv+Y0gD+eUxaTeCUGOIUo8gGtZpFLzmCR1HYTJm50k
    Mnrb5FJBa+HftvI9qqGx5wVWnooy/yQbh018kIFWe0hGWSNTAJJ97rWgR6S0onv/
    uwYOiNxtkamuuAeYHZikeBRX3Cg25LGqKgjtklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522239726; bh=tEyBEBsNVd+NhzY/BTD+44y5ypUv5/5cpa6rYnB6mNw=; b=V
    rUp/eIZo1jWStgh8sd0UN61VhNY6LaDxozkpUVTJaVU1xTjR5Iin1SuczqxPaG84
    y2bH+ckJUEPGw7VRHOBHt8lbNpIP9LJadanHEs4DilDB6TmqNceWcNrf4ylFTujx
    xnX1N/o5+1DsupMtBhHQQMNQbCvPFvGyvZOsruaeliFrFW2h5k10OITE8VnIivoe
    7fb1Wetroq9QNmUqJo8/sLOjf4KbYa+DEtmfZ/MSv9r5O0/Er2D2anX4a74Tqtf9
    23pvZIv1H7nF7ZaMSwW303zi2v0jkTFKGYpSaWvj0ZP2VZpw5Py8HJwBYlOoVJUN
    f7xx4n2E2J9RaC+hhxHCw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGylvFUKzL3JDUqzMfZpMQuBzbo1pG9hhSPo9dNTCQwAT0aGt7mPfA9SJFecmDTe+q3q54ivVeQpch3XDyT9dIJWTDsSNf9qclBL8n5X5Lh9Z9JY6Ki7
    IdjCBDCDWqWg/TVLhZG6HVdfjNIojUGuWFGdBQLCD2xuQX1LuOtmONLcICIilgKkjMkASHA0DXgnFvHKQ4WKO91oTVueWiM2o4QXIKNuH4/igVidGWS8UZcI
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=Ikd4Dj_1AAAA:8 a=o1mstnbwgVYzkTjX2o8A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeC1MWD (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 08:22:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40018 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750799AbeC1MWC (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Mar 2018 08:22:02 -0400
Subject: Re: [PATCHv3] irqchip: arm-gic: take gic_lock when updating irq type
To: Aniruddha Banerjee <aniruddha.nitd@gmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: aniruddhab@nvidia.com, stable@vger.kernel.org, vipink@nvidia.com,
        strasi@nvidia.com, swarren@nvidia.com, jonathanh@nvidia.com,
        talho@nvidia.com, treding@nvidia.com
References: <20180328085430.3401-1-aniruddha.nitd@gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <067de784-0f27-a8f4-3a50-b33cd8445c54@arm.com>
Date: Wed, 28 Mar 2018 13:21:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328085430.3401-1-aniruddha.nitd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Aniruddha,

On 28/03/18 09:54, Aniruddha Banerjee wrote:
> The kernel documentation states that the locking of the irq-chip
> registers should be handled by the irq-chip driver. In the irq-gic,
> the accesses to the irqchip are seemingly not protected and multiple
> writes to SPIs from different irq descriptors do RMW requests without
> taking the irq-chip lock. When multiple irqs call the request_irq at
> the same time, there can be a simultaneous write at the gic
> distributor, leading to a race. Acquire the gic_lock when the
> irq_type is updated.
> 
> Signed-off-by: Aniruddha Banerjee <aniruddhab@nvidia.com>
> ---
> Changes from V1:
> 
> * Moved the spinlock from irq-gic to irq-gic common, so that the fix
> is valid for GIC v1/v2/v3.
> 
> Change from V2:
> 
> * Fixup the Signed-off-by line.
> 
>  drivers/irqchip/irq-gic-common.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
> index 9ae71804b5dd..73dd39959e6e 100644
> --- a/drivers/irqchip/irq-gic-common.c
> +++ b/drivers/irqchip/irq-gic-common.c
> @@ -21,6 +21,8 @@
>  
>  #include "irq-gic-common.h"
>  
> +static DEFINE_RAW_SPINLOCK(irq_controller_lock);
> +
>  static const struct gic_kvm_info *gic_kvm_info;
>  
>  const struct gic_kvm_info *gic_get_kvm_info(void)
> @@ -57,6 +59,7 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
>  	 * Read current configuration register, and insert the config
>  	 * for "irq", depending on "type".
>  	 */
> +	raw_spin_lock(&irq_controller_lock);
>  	val = oldval = readl_relaxed(base + GIC_DIST_CONFIG + confoff);
>  	if (type & IRQ_TYPE_LEVEL_MASK)
>  		val &= ~confmask;
> @@ -64,8 +67,10 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
>  		val |= confmask;
>  
>  	/* If the current configuration is the same, then we are done */
> -	if (val == oldval)
> +	if (val == oldval) {
> +		raw_spin_unlock(&irq_controller_lock);
>  		return 0;
> +	}
>  
>  	/*
>  	 * Write back the new configuration, and possibly re-enable
> @@ -83,6 +88,7 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
>  			pr_warn("GIC: PPI%d is secure or misconfigured\n",
>  				irq - 16);
>  	}
> +	raw_spin_unlock(&irq_controller_lock);
>  
>  	if (sync_access)
>  		sync_access();
> 

I've just realized a potential issue: As interrupts are not disabled
here, you could take one in the middle of this critical section. If the
interrupt handler has the stupid idea to change the trigger type of
*any* interrupt, we deadlock.

Yes, this would be a very stupid idea, but better safe than sorry.
Please use raw_pin_lock_irqsave/irqrestore instead.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
