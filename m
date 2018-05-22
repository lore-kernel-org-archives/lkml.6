Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2783972-1527006102-2-10046080459207405440
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enroca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527006101; b=k6zAy6AnTBcSB5BdYCXLAGAHa7ON0AQhciXEP4p+4z9VTcSUtG
    jdxzqBeZaeA/nza9CeLXMh/vBx7eeSuWUHpeVcUnVPPmJUztiGsIDBscGpdZSP0M
    DpPTbiqOfH3blm7+6mPDVZcTMzdK+c/mghX/Uhh1hODf9Yequees/2eFSWfvGeDy
    rqp+kPNWcdIJ1UpQnSLRlfBRfaYzMhezE2d02oRSUTpdYsKf0f5wb3TvbHX1AKRk
    WNw1m9Z3edh9HyWApEEOWEKaRtLm/vr2fNF/88tXzUrl8pHdBkM0m54ihFKEmv7v
    0PzZvwtHxSmY0CpiO1036iXGLwH2JR7JJedg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527006101;
    bh=redbl9IzW6morOAq/tc+JowsNVqeOQUJ1Yhv7TGJ5PI=; b=enoJ26u6744D
    BGJlKoGldAeG71wpFzPoqjGUyvpzpFeEqrl3bOUxdyAELe2K0sjtBx/j6npvYQbe
    eWg4Vyt68xCYybB8kPYN2J8mooxJ7zOsb2zfiO3b6CFsn44oXlYh2pG8B0nnaOu3
    Th6so6+ehisLCKkrPsPWVcvsg34EEavlk2gMoo+6OnGr+CRM7N3YVTf62OaxhAtf
    NM9x9qSBCrHesUnqraT43I5JJgUr1N1iQTDSdXRu7c6tKcHqYft8SwhJF6Zms00u
    sweNUHMbJAN27EHZZ3aJBNsm6HPFeGQXjZyH7pBVT5QJFGnCYxC7/Yh+IBq/Y0/A
    455mOZdxwQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOWhpkOF/3lOE09qy/A8WIPBNsa62SQhSGlnTZwv2Vrj9MCzAsa5OG7SKo6lFRpfxnLXGSekQzs7NJj/nuByderp4K6M5PS2wBaeh8rA1MPeKjmIwp4x
    j7P/EIIYwswjb3A6/fcqBrywRf/ClcnvdMaiHW+8zE+YNwUJpGmEJnH2HMwn4Xnm8U52QUShzRWB/JKATMayh22oiA1oWd5wqDcW+CUHstp+LjmEO1u4/CFS
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Xd-_xOzPHCEA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=3PM7F35aXcA0-1nz-1YA:9
    a=1Z3xQeW7WAOA6iP2:21 a=AB7SMQ2FHE2cxHnz:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeEVQVi (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 12:21:38 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13796 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751257AbeEVQVh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 May 2018 12:21:37 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 22 May 2018 09:21:39 -0700
Subject: Re: [PATCH 5/8] mailbox: tegra-hsp: Add support for shared mailboxes
To: Mikko Perttunen <mperttunen@nvidia.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jassisinghbrar@gmail.com>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>
CC: <araza@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
 <20180508114403.14499-6-mperttunen@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <dc9db3b2-f40b-9422-5dc8-f5d3c186a044@nvidia.com>
Date: Tue, 22 May 2018 17:20:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508114403.14499-6-mperttunen@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 08/05/18 12:44, Mikko Perttunen wrote:
> The Tegra HSP block supports 'shared mailboxes' that are simple 32-bit
> registers consisting of a FULL bit in MSB position and 31 bits of data.
> The hardware can be configured to trigger interrupts when a mailbox
> is empty or full. Add support for these shared mailboxes to the HSP
> driver.
> 
> The initial use for the mailboxes is the Tegra Combined UART. For this
> purpose, we use interrupts to receive data, and spinning to wait for
> the transmit mailbox to be emptied to minimize unnecessary overhead.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>   drivers/mailbox/tegra-hsp.c | 216 +++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 193 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
> index 16eb970f2c9f..77bc8ed7ef15 100644
> --- a/drivers/mailbox/tegra-hsp.c
> +++ b/drivers/mailbox/tegra-hsp.c
> @@ -21,6 +21,11 @@
>   
>   #include <dt-bindings/mailbox/tegra186-hsp.h>
>   
> +#include "mailbox.h"
> +
> +#define HSP_INT0_IE		0x100
> +#define HSP_INT_IR		0x304
> +
>   #define HSP_INT_DIMENSIONING	0x380
>   #define HSP_nSM_SHIFT		0
>   #define HSP_nSS_SHIFT		4
> @@ -34,6 +39,8 @@
>   #define HSP_DB_RAW	0x8
>   #define HSP_DB_PENDING	0xc
>   
> +#define HSP_SM_SHRD_MBOX	0x0
> +
>   #define HSP_DB_CCPLEX		1
>   #define HSP_DB_BPMP		3
>   #define HSP_DB_MAX		7
> @@ -68,6 +75,18 @@ struct tegra_hsp_db_map {
>   	unsigned int index;
>   };
>   
> +struct tegra_hsp_mailbox {
> +	struct tegra_hsp_channel channel;
> +	unsigned int index;
> +	bool sending;
> +};
> +
> +static inline struct tegra_hsp_mailbox *
> +channel_to_mailbox(struct tegra_hsp_channel *channel)
> +{
> +	return container_of(channel, struct tegra_hsp_mailbox, channel);
> +}
> +
>   struct tegra_hsp_soc {
>   	const struct tegra_hsp_db_map *map;
>   };
> @@ -77,6 +96,7 @@ struct tegra_hsp {
>   	struct mbox_controller mbox;
>   	void __iomem *regs;
>   	unsigned int doorbell_irq;
> +	unsigned int shared_irq;
>   	unsigned int num_sm;
>   	unsigned int num_as;
>   	unsigned int num_ss;
> @@ -85,6 +105,7 @@ struct tegra_hsp {
>   	spinlock_t lock;
>   
>   	struct list_head doorbells;
> +	struct tegra_hsp_mailbox *mailboxes;
>   };
>   
>   static inline struct tegra_hsp *
> @@ -189,6 +210,35 @@ static irqreturn_t tegra_hsp_doorbell_irq(int irq, void *data)
>   	return IRQ_HANDLED;
>   }
>   
> +static irqreturn_t tegra_hsp_shared_irq(int irq, void *data)
> +{
> +	struct tegra_hsp_mailbox *mb;
> +	struct tegra_hsp *hsp = data;
> +	unsigned long bit, mask;
> +	u32 value;
> +
> +	mask = tegra_hsp_readl(hsp, HSP_INT_IR);
> +	/* Only interested in FULL interrupts */
> +	mask &= 0xff << 8;

Maybe add some definitions for the above.

Should we qualify 'mask' against the HSP_INT_IE register as well?

> +
> +	for_each_set_bit(bit, &mask, 16) {
> +		unsigned int mb_i = bit % 8;

If you right-shifted the mask above, you could avoid this modulo.

> +
> +		mb = &hsp->mailboxes[mb_i];
> +
> +		if (!mb->sending) {
> +			value = tegra_hsp_channel_readl(&mb->channel,
> +							HSP_SM_SHRD_MBOX);
> +			value &= ~BIT(31);

Similarly a definition for bit 31 may add some clarity.

> +			mbox_chan_received_data(mb->channel.chan, &value);
> +			tegra_hsp_channel_writel(&mb->channel, value,
> +						 HSP_SM_SHRD_MBOX);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>   static struct tegra_hsp_channel *
>   tegra_hsp_doorbell_create(struct tegra_hsp *hsp, const char *name,
>   			  unsigned int master, unsigned int index)
> @@ -277,15 +327,58 @@ static void tegra_hsp_doorbell_shutdown(struct tegra_hsp_doorbell *db)
>   	spin_unlock_irqrestore(&hsp->lock, flags);
>   }
>   
> +static int tegra_hsp_mailbox_startup(struct tegra_hsp_mailbox *mb)
> +{
> +	struct tegra_hsp *hsp = mb->channel.hsp;
> +	u32 value;
> +
> +	mb->channel.chan->txdone_method = TXDONE_BY_BLOCK;
> +
> +	/* Route FULL interrupt to external IRQ 0 */
> +	value = tegra_hsp_readl(hsp, HSP_INT0_IE);
> +	value |= BIT(mb->index + 8);
> +	tegra_hsp_writel(hsp, value, HSP_INT0_IE);
> +
> +	return 0;
> +}
> +
> +static int tegra_hsp_mailbox_shutdown(struct tegra_hsp_mailbox *mb)
> +{
> +	struct tegra_hsp *hsp = mb->channel.hsp;
> +	u32 value;
> +
> +	value = tegra_hsp_readl(hsp, HSP_INT0_IE);
> +	value &= ~BIT(mb->index + 8);
> +	tegra_hsp_writel(hsp, value, HSP_INT0_IE);
> +
> +	return 0;
> +}
> +
>   static int tegra_hsp_send_data(struct mbox_chan *chan, void *data)
>   {
>   	struct tegra_hsp_channel *channel = chan->con_priv;
> -	struct tegra_hsp_doorbell *db;
> +	struct tegra_hsp_mailbox *mailbox;
> +	uint32_t value;
>   
>   	switch (channel->type) {
>   	case TEGRA_HSP_MBOX_TYPE_DB:
> -		db = channel_to_doorbell(channel);
> -		tegra_hsp_channel_writel(&db->channel, 1, HSP_DB_TRIGGER);
> +		tegra_hsp_channel_writel(channel, 1, HSP_DB_TRIGGER);
> +		return 0;
> +	case TEGRA_HSP_MBOX_TYPE_SM:
> +		mailbox = channel_to_mailbox(channel);
> +		mailbox->sending = true;
> +
> +		value = *(uint32_t *)data;
> +		/* Mark mailbox full */
> +		value |= BIT(31);
> +
> +		tegra_hsp_channel_writel(channel, value, HSP_SM_SHRD_MBOX);
> +
> +		while (tegra_hsp_channel_readl(channel, HSP_SM_SHRD_MBOX)
> +		               & BIT(31))
> +			cpu_relax();

Could be nice to use readx_poll_timeout() here.

> +
> +		return 0;
>   	}
>   
>   	return -EINVAL;
> @@ -298,6 +391,8 @@ static int tegra_hsp_startup(struct mbox_chan *chan)
>   	switch (channel->type) {
>   	case TEGRA_HSP_MBOX_TYPE_DB:
>   		return tegra_hsp_doorbell_startup(channel_to_doorbell(channel));
> +	case TEGRA_HSP_MBOX_TYPE_SM:
> +		return tegra_hsp_mailbox_startup(channel_to_mailbox(channel));
>   	}
>   
>   	return -EINVAL;
> @@ -311,6 +406,9 @@ static void tegra_hsp_shutdown(struct mbox_chan *chan)
>   	case TEGRA_HSP_MBOX_TYPE_DB:
>   		tegra_hsp_doorbell_shutdown(channel_to_doorbell(channel));
>   		break;
> +	case TEGRA_HSP_MBOX_TYPE_SM:
> +		tegra_hsp_mailbox_shutdown(channel_to_mailbox(channel));
> +		break;
>   	}
>   }
>   
> @@ -364,7 +462,16 @@ static struct mbox_chan *of_tegra_hsp_xlate(struct mbox_controller *mbox,
>   
>   	switch (type) {
>   	case TEGRA_HSP_MBOX_TYPE_DB:
> -		return tegra_hsp_doorbell_xlate(hsp, param);
> +		if (hsp->doorbell_irq)
> +			return tegra_hsp_doorbell_xlate(hsp, param);
> +		else
> +			return ERR_PTR(-EINVAL);
> +
> +	case TEGRA_HSP_MBOX_TYPE_SM:
> +		if (hsp->shared_irq && param < hsp->num_sm)
> +			return hsp->mailboxes[param].channel.chan;
> +		else
> +			return ERR_PTR(-EINVAL);
>   
>   	default:
>   		return ERR_PTR(-EINVAL);
> @@ -403,6 +510,31 @@ static int tegra_hsp_add_doorbells(struct tegra_hsp *hsp)
>   	return 0;
>   }
>   
> +static int tegra_hsp_add_mailboxes(struct tegra_hsp *hsp, struct device *dev)
> +{
> +	int i;
> +
> +	hsp->mailboxes = devm_kcalloc(dev, hsp->num_sm, sizeof(*hsp->mailboxes),
> +				      GFP_KERNEL);
> +	if (!hsp->mailboxes)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < hsp->num_sm; i++) {
> +		struct tegra_hsp_mailbox *mb = &hsp->mailboxes[i];
> +
> +		mb->index = i;
> +		mb->sending = false;
> +
> +		mb->channel.hsp = hsp;
> +		mb->channel.type = TEGRA_HSP_MBOX_TYPE_SM;
> +		mb->channel.regs = hsp->regs + SZ_64K + i * SZ_32K;
> +		mb->channel.chan = &hsp->mbox.chans[i];
> +		mb->channel.chan->con_priv = &mb->channel;
> +	}
> +
> +	return 0;
> +}
> +
>   static int tegra_hsp_probe(struct platform_device *pdev)
>   {
>   	struct tegra_hsp *hsp;
> @@ -431,14 +563,19 @@ static int tegra_hsp_probe(struct platform_device *pdev)
>   	hsp->num_si = (value >> HSP_nSI_SHIFT) & HSP_nINT_MASK;
>   
>   	err = platform_get_irq_byname(pdev, "doorbell");
> -	if (err < 0) {
> -		dev_err(&pdev->dev, "failed to get doorbell IRQ: %d\n", err);
> -		return err;
> -	}
> +	if (err < 0)
> +		hsp->doorbell_irq = 0;

It should not be necessary to set to zero as it should already be zero.

> +	else
> +		hsp->doorbell_irq = err;
>   
> -	hsp->doorbell_irq = err;
> +	err = platform_get_irq_byname(pdev, "shared0");
> +	if (err < 0)
> +		hsp->shared_irq = 0;

It should not be necessary to set to zero as it should already be zero.

> +	else
> +		hsp->shared_irq = err;
>   
>   	hsp->mbox.of_xlate = of_tegra_hsp_xlate;
> +	/* First nSM are reserved for mailboxes */
>   	hsp->mbox.num_chans = 32;
>   	hsp->mbox.dev = &pdev->dev;
>   	hsp->mbox.txdone_irq = false;
> @@ -451,10 +588,22 @@ static int tegra_hsp_probe(struct platform_device *pdev)
>   	if (!hsp->mbox.chans)
>   		return -ENOMEM;
>   
> -	err = tegra_hsp_add_doorbells(hsp);
> -	if (err < 0) {
> -		dev_err(&pdev->dev, "failed to add doorbells: %d\n", err);
> -		return err;
> +	if (hsp->doorbell_irq) {
> +		err = tegra_hsp_add_doorbells(hsp);
> +		if (err < 0) {
> +			dev_err(&pdev->dev, "failed to add doorbells: %d\n",
> +			        err);
> +			return err;
> +		}
> +	}
> +
> +	if (hsp->shared_irq) {
> +		err = tegra_hsp_add_mailboxes(hsp, &pdev->dev);
> +		if (err < 0) {
> +			dev_err(&pdev->dev, "failed to add mailboxes: %d\n",
> +			        err);
> +			goto remove_doorbells;
> +		}
>   	}
>   
>   	platform_set_drvdata(pdev, hsp);
> @@ -462,20 +611,40 @@ static int tegra_hsp_probe(struct platform_device *pdev)
>   	err = mbox_controller_register(&hsp->mbox);
>   	if (err) {
>   		dev_err(&pdev->dev, "failed to register mailbox: %d\n", err);
> -		tegra_hsp_remove_doorbells(hsp);
> -		return err;
> +		goto remove_doorbells;
>   	}
>   
> -	err = devm_request_irq(&pdev->dev, hsp->doorbell_irq,
> -			       tegra_hsp_doorbell_irq, IRQF_NO_SUSPEND,
> -			       dev_name(&pdev->dev), hsp);
> -	if (err < 0) {
> -		dev_err(&pdev->dev, "failed to request doorbell IRQ#%u: %d\n",
> -			hsp->doorbell_irq, err);
> -		return err;
> +	if (hsp->doorbell_irq) {
> +		err = devm_request_irq(&pdev->dev, hsp->doorbell_irq,
> +				       tegra_hsp_doorbell_irq, IRQF_NO_SUSPEND,
> +				       dev_name(&pdev->dev), hsp);
> +		if (err < 0) {
> +			dev_err(&pdev->dev,
> +			        "failed to request doorbell IRQ#%u: %d\n",
> +				hsp->doorbell_irq, err);
> +			return err;

Clean-up?

> +		}
> +	}
> +
> +	if (hsp->shared_irq) {
> +		err = devm_request_irq(&pdev->dev, hsp->shared_irq,
> +				       tegra_hsp_shared_irq, 0,
> +				       dev_name(&pdev->dev), hsp);
> +		if (err < 0) {
> +			dev_err(&pdev->dev,
> +				"failed to request shared0 IRQ%u: %d\n",
> +				hsp->shared_irq, err);
> +			return err;

Clean-up?

> +		}
>   	}
>   
>   	return 0;
> +
> +remove_doorbells:
> +	if (hsp->doorbell_irq)
> +		tegra_hsp_remove_doorbells(hsp);
> +
> +	return err;
>   }
>   
>   static int tegra_hsp_remove(struct platform_device *pdev)
> @@ -483,7 +652,8 @@ static int tegra_hsp_remove(struct platform_device *pdev)
>   	struct tegra_hsp *hsp = platform_get_drvdata(pdev);
>   
>   	mbox_controller_unregister(&hsp->mbox);
> -	tegra_hsp_remove_doorbells(hsp);
> +	if (hsp->doorbell_irq)
> +		tegra_hsp_remove_doorbells(hsp);
>   
	>   	return 0;
>   }
> 

Cheers
Jon

-- 
nvpublic
