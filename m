Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8EDC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF692082B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qoQtwCSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF692082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbeJ2Sw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:52:29 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19694 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729568AbeJ2Sw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:52:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bd6db210000>; Mon, 29 Oct 2018 03:04:17 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 29 Oct 2018 03:04:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 29 Oct 2018 03:04:29 -0700
Received: from [10.21.24.173] (10.21.24.173) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 29 Oct
 2018 10:04:25 +0000
Subject: Re: [PATCH 4/9] mailbox: tegra-hsp: Add support for shared mailboxes
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jslaby@suse.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        Mika Liljeberg <mliljeberg@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
 <20181026111638.10759-5-thierry.reding@gmail.com>
From:   Pekka Pessi <ppessi@nvidia.com>
Message-ID: <bfc78c91-73f1-4f64-9196-5268a73b5c42@nvidia.com>
Date:   Mon, 29 Oct 2018 12:04:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181026111638.10759-5-thierry.reding@gmail.com>
X-Originating-IP: [10.21.24.173]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To HQMAIL101.nvidia.com
 (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1540807457; bh=JlL4yMXZQOz9VCnJ4CxAt4Q3VG31g83cpQLz5aKzY+Y=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=qoQtwCSX5RMbSUujsdt6DQI508MIwtg6NbCdj2zCWJoEMO7zIYgKg9zYe7jRRpmgT
         HzCRaqk5c7zSqwIS8Fkc7NoW2PB5cjcPXG5au2ku8fvwHcxXsAAtc8vy8DGljCued3
         ZYAbCZyXlEK5eZM6zXP00pWPR0lXUAmyifq2IAm+qjmYWeVdjHolWdMetvZbqO/Kan
         RBYoOZ9+UqWj6n50IHAD4DGphpKl3vhNWAWfroYJxyKbP7akIiFm5vvKWFYdk2XZru
         Mwhm+1dP+qVSXSNlALzN4MjemM8WvETsZRzaJWz2hm9pUFhA54XrzG/lDWuRsO3izU
         85vR/eQ85Fkqw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

There is typically one entity (aux cpu or a VM running on CCPLEX) owning=20
the "empty" or producer side of mailbox (iow, waking up on empty) and=20
another entity owning the "full" or consumer side of mailbox (waking up=20
on full). An entity should not muck with the interrupts used by the=20
opposite side.

One entity typically owns one shared interrupt only.=C2=A0 For the=20
BPMP/SCE/RCE/SPE HSP blocks the shared interrupt 0 is owned by the=20
auxiliary processor itself, the shared interrupts 1..4 are connected to=20
LIC and are available to other entities. The convention is to go through=20
the interrupts 0..4 and then using the first available shared interrupt=20
for both full and empty.

The interrupt functions should use a mask for mailboxes owned by kernel=20
(in essence what the IE register should be for the HSP shared interrupt=20
owned by the kernel) and serve only those mailboxes owned by kernel.=20
Note that there is no reset for HSP in Xavier, and the IE register=20
contents may be stale.

And lastly, if we want to support only Xavier and later, perhaps we=20
should be more clear in the bindings? There are no mailbox-specific=20
interrupt enable registers available on Parker and your design relies on=20
them.

--Pekka

On 10/26/2018 02:16 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
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
> Based on work by Mikko Perttunen <mperttunen@nvidia.com>.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   drivers/mailbox/tegra-hsp.c | 476 +++++++++++++++++++++++++++++++-----
>   1 file changed, 415 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
> index 0cde356c11ab..d070c8e38375 100644
> --- a/drivers/mailbox/tegra-hsp.c
> +++ b/drivers/mailbox/tegra-hsp.c
> @@ -1,5 +1,5 @@
>   /*
> - * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
> + * Copyright (c) 2016-2018, NVIDIA CORPORATION.  All rights reserved.
>    *
>    * This program is free software; you can redistribute it and/or modify=
 it
>    * under the terms and conditions of the GNU General Public License,
> @@ -11,6 +11,7 @@
>    * more details.
>    */
>  =20
> +#include <linux/delay.h>
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
>   #include <linux/mailbox_controller.h>
> @@ -21,6 +22,17 @@
>  =20
>   #include <dt-bindings/mailbox/tegra186-hsp.h>
>  =20
> +#include "mailbox.h"
> +
> +#define HSP_INT_IE(x)		(0x100 + ((x) * 4))
> +#define HSP_INT_IV		0x300
> +#define HSP_INT_IR		0x304
> +
> +#define HSP_INT_EMPTY_SHIFT	0
> +#define HSP_INT_EMPTY_MASK	0xff
> +#define HSP_INT_FULL_SHIFT	8
> +#define HSP_INT_FULL_MASK	0xff
> +
>   #define HSP_INT_DIMENSIONING	0x380
>   #define HSP_nSM_SHIFT		0
>   #define HSP_nSS_SHIFT		4
> @@ -34,6 +46,11 @@
>   #define HSP_DB_RAW	0x8
>   #define HSP_DB_PENDING	0xc
>  =20
> +#define HSP_SM_SHRD_MBOX	0x0
> +#define HSP_SM_SHRD_MBOX_FULL	BIT(31)
> +#define HSP_SM_SHRD_MBOX_FULL_INT_IE	0x04
> +#define HSP_SM_SHRD_MBOX_EMPTY_INT_IE	0x08
> +
>   #define HSP_DB_CCPLEX		1
>   #define HSP_DB_BPMP		3
>   #define HSP_DB_MAX		7
> @@ -55,6 +72,12 @@ struct tegra_hsp_doorbell {
>   	unsigned int index;
>   };
>  =20
> +struct tegra_hsp_mailbox {
> +	struct tegra_hsp_channel channel;
> +	unsigned int index;
> +	bool sending;
> +};
> +
>   struct tegra_hsp_db_map {
>   	const char *name;
>   	unsigned int master;
> @@ -66,10 +89,13 @@ struct tegra_hsp_soc {
>   };
>  =20
>   struct tegra_hsp {
> +	struct device *dev;
>   	const struct tegra_hsp_soc *soc;
> -	struct mbox_controller mbox;
> +	struct mbox_controller mbox_db;
> +	struct mbox_controller mbox_sm;
>   	void __iomem *regs;
> -	unsigned int irq;
> +	unsigned int doorbell_irq;
> +	unsigned int *shared_irqs;
>   	unsigned int num_sm;
>   	unsigned int num_as;
>   	unsigned int num_ss;
> @@ -78,14 +104,9 @@ struct tegra_hsp {
>   	spinlock_t lock;
>  =20
>   	struct list_head doorbells;
> +	struct tegra_hsp_mailbox *mailboxes;
>   };
>  =20
> -static inline struct tegra_hsp *
> -to_tegra_hsp(struct mbox_controller *mbox)
> -{
> -	return container_of(mbox, struct tegra_hsp, mbox);
> -}
> -
>   static inline u32 tegra_hsp_readl(struct tegra_hsp *hsp, unsigned int o=
ffset)
>   {
>   	return readl(hsp->regs + offset);
> @@ -158,7 +179,7 @@ static irqreturn_t tegra_hsp_doorbell_irq(int irq, vo=
id *data)
>  =20
>   	spin_lock(&hsp->lock);
>  =20
> -	for_each_set_bit(master, &value, hsp->mbox.num_chans) {
> +	for_each_set_bit(master, &value, hsp->mbox_db.num_chans) {
>   		struct tegra_hsp_doorbell *db;
>  =20
>   		db =3D __tegra_hsp_doorbell_get(hsp, master);
> @@ -182,6 +203,84 @@ static irqreturn_t tegra_hsp_doorbell_irq(int irq, v=
oid *data)
>   	return IRQ_HANDLED;
>   }
>  =20
> +static irqreturn_t tegra_hsp_shared_full_irq(int irq, void *data)
> +{
> +	struct tegra_hsp *hsp =3D data;
> +	unsigned long bit, mask;
> +	u32 status, value;
> +	void *msg;
> +
> +	status =3D tegra_hsp_readl(hsp, HSP_INT_IR);
> +
> +	/* only interested in FULL interrupts */
> +	mask =3D (status >> HSP_INT_FULL_SHIFT) & HSP_INT_FULL_MASK;
> +
> +	if (!mask)
> +		return IRQ_NONE;
> +
> +	for_each_set_bit(bit, &mask, hsp->num_sm) {
> +		struct tegra_hsp_mailbox *mb =3D &hsp->mailboxes[bit];
> +
> +		if (!mb->sending) {
> +			value =3D tegra_hsp_channel_readl(&mb->channel,
> +							HSP_SM_SHRD_MBOX);
> +			value &=3D ~HSP_SM_SHRD_MBOX_FULL;
> +			msg =3D (void *)(unsigned long)value;
> +			mbox_chan_received_data(mb->channel.chan, msg);
> +
> +			/*
> +			 * Need to clear all bits here since some producers,
> +			 * such as TCU, depend on fields in the register
> +			 * getting cleared by the consumer.
> +			 *
> +			 * The mailbox API doesn't give the consumers a way
> +			 * of doing that explicitly, so we have to make sure
> +			 * we cover all possible cases.
> +			 */
> +			tegra_hsp_channel_writel(&mb->channel, 0x0,
> +						 HSP_SM_SHRD_MBOX);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t tegra_hsp_shared_empty_irq(int irq, void *data)
> +{
> +	struct tegra_hsp *hsp =3D data;
> +	unsigned long bit, mask;
> +	u32 status, value;
> +
> +	status =3D tegra_hsp_readl(hsp, HSP_INT_IR);
> +
> +	/* only interested in EMPTY interrupts */
> +	mask =3D (status >> HSP_INT_EMPTY_SHIFT) & HSP_INT_EMPTY_MASK;
> +
> +	if (!mask)
> +		return IRQ_NONE;
> +
> +	for_each_set_bit(bit, &mask, hsp->num_sm) {
> +		struct tegra_hsp_mailbox *mb =3D &hsp->mailboxes[bit];
> +
> +		if (mb->sending) {
> +			/*
> +			 * Disable EMPTY interrupts until data is sent
> +			 * with the next message. These interrupts are
> +			 * level-triggered, so if we kept them enabled
> +			 * they would constantly trigger until we next
> +			 * write data into the message.
> +			 */
> +			value =3D tegra_hsp_readl(hsp, HSP_INT_IE(1));
> +			value &=3D ~BIT(HSP_INT_EMPTY_SHIFT + mb->index);
> +			tegra_hsp_writel(hsp, value, HSP_INT_IE(1));
> +
> +			mbox_chan_txdone(mb->channel.chan, 0);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>   static struct tegra_hsp_channel *
>   tegra_hsp_doorbell_create(struct tegra_hsp *hsp, const char *name,
>   			  unsigned int master, unsigned int index)
> @@ -194,7 +293,7 @@ tegra_hsp_doorbell_create(struct tegra_hsp *hsp, cons=
t char *name,
>   	if (!db)
>   		return ERR_PTR(-ENOMEM);
>  =20
> -	offset =3D (1 + (hsp->num_sm / 2) + hsp->num_ss + hsp->num_as) << 16;
> +	offset =3D (1 + (hsp->num_sm / 2) + hsp->num_ss + hsp->num_as) * SZ_64K=
;
>   	offset +=3D index * 0x100;
>  =20
>   	db->channel.regs =3D hsp->regs + offset;
> @@ -235,8 +334,8 @@ static int tegra_hsp_doorbell_startup(struct mbox_cha=
n *chan)
>   	unsigned long flags;
>   	u32 value;
>  =20
> -	if (db->master >=3D hsp->mbox.num_chans) {
> -		dev_err(hsp->mbox.dev,
> +	if (db->master >=3D chan->mbox->num_chans) {
> +		dev_err(chan->mbox->dev,
>   			"invalid master ID %u for HSP channel\n",
>   			db->master);
>   		return -EINVAL;
> @@ -281,46 +380,147 @@ static void tegra_hsp_doorbell_shutdown(struct mbo=
x_chan *chan)
>   	spin_unlock_irqrestore(&hsp->lock, flags);
>   }
>  =20
> -static const struct mbox_chan_ops tegra_hsp_doorbell_ops =3D {
> +static const struct mbox_chan_ops tegra_hsp_db_ops =3D {
>   	.send_data =3D tegra_hsp_doorbell_send_data,
>   	.startup =3D tegra_hsp_doorbell_startup,
>   	.shutdown =3D tegra_hsp_doorbell_shutdown,
>   };
>  =20
> -static struct mbox_chan *of_tegra_hsp_xlate(struct mbox_controller *mbox=
,
> +static int tegra_hsp_mailbox_send_data(struct mbox_chan *chan, void *dat=
a)
> +{
> +	struct tegra_hsp_mailbox *mb =3D chan->con_priv;
> +	struct tegra_hsp *hsp =3D mb->channel.hsp;
> +	u32 value;
> +
> +	mb->sending =3D true;
> +
> +	/* copy data and mark mailbox full */
> +	value =3D (u32)(unsigned long)data;
> +	value |=3D HSP_SM_SHRD_MBOX_FULL;
> +
> +	tegra_hsp_channel_writel(&mb->channel, value, HSP_SM_SHRD_MBOX);
> +
> +	if (!irqs_disabled()) {
> +		/* enable EMPTY interrupt for the shared mailbox */
> +		value =3D tegra_hsp_readl(hsp, HSP_INT_IE(1));
> +		value |=3D BIT(HSP_INT_EMPTY_SHIFT + mb->index);
> +		tegra_hsp_writel(hsp, value, HSP_INT_IE(1));
> +	}
> +
> +	return 0;
> +}
> +
> +static int tegra_hsp_mailbox_flush(struct mbox_chan *chan,
> +				   unsigned long timeout)
> +{
> +	struct tegra_hsp_mailbox *mb =3D chan->con_priv;
> +	struct tegra_hsp_channel *ch =3D &mb->channel;
> +	u32 value;
> +
> +	timeout =3D jiffies + msecs_to_jiffies(timeout);
> +
> +	while (time_before(jiffies, timeout)) {
> +		value =3D tegra_hsp_channel_readl(ch, HSP_SM_SHRD_MBOX);
> +		if ((value & HSP_SM_SHRD_MBOX_FULL) =3D=3D 0) {
> +			mbox_chan_txdone(chan, 0);
> +			return 0;
> +		}
> +
> +		udelay(1);
> +	}
> +
> +	return -ETIME;
> +}
> +
> +static int tegra_hsp_mailbox_startup(struct mbox_chan *chan)
> +{
> +	struct tegra_hsp_mailbox *mb =3D chan->con_priv;
> +	struct tegra_hsp_channel *ch =3D &mb->channel;
> +	struct tegra_hsp *hsp =3D mb->channel.hsp;
> +	u32 value;
> +
> +	chan->txdone_method =3D TXDONE_BY_IRQ;
> +
> +	/*
> +	 * Shared mailboxes start out as consumers by default. FULL interrupts
> +	 * are coalesced at shared interrupt 0, while EMPTY interrupts will be
> +	 * coalesced at shared interrupt 1.
> +	 *
> +	 * Keep EMPTY interrupts disabled at startup and only enable them when
> +	 * the mailbox is actually full. This is required because the FULL and
> +	 * EMPTY interrupts are level-triggered, so keeping EMPTY interrupts
> +	 * enabled all the time would cause an interrupt storm while mailboxes
> +	 * are idle.
> +	 */
> +
> +	value =3D tegra_hsp_readl(hsp, HSP_INT_IE(0));
> +	value |=3D BIT(HSP_INT_FULL_SHIFT + mb->index);
> +	tegra_hsp_writel(hsp, value, HSP_INT_IE(0));
> +
> +	value =3D tegra_hsp_readl(hsp, HSP_INT_IE(1));
> +	value &=3D ~BIT(HSP_INT_EMPTY_SHIFT + mb->index);
> +	tegra_hsp_writel(hsp, value, HSP_INT_IE(1));
> +
> +	tegra_hsp_channel_writel(ch, 0x1, HSP_SM_SHRD_MBOX_FULL_INT_IE);
> +	tegra_hsp_channel_writel(ch, 0x1, HSP_SM_SHRD_MBOX_EMPTY_INT_IE);
> +
> +	return 0;
> +}
> +
> +static void tegra_hsp_mailbox_shutdown(struct mbox_chan *chan)
> +{
> +	struct tegra_hsp_mailbox *mb =3D chan->con_priv;
> +	struct tegra_hsp_channel *ch =3D &mb->channel;
> +	struct tegra_hsp *hsp =3D mb->channel.hsp;
> +	u32 value;
> +
> +	tegra_hsp_channel_writel(ch, 0x0, HSP_SM_SHRD_MBOX_EMPTY_INT_IE);
> +	tegra_hsp_channel_writel(ch, 0x0, HSP_SM_SHRD_MBOX_FULL_INT_IE);
> +
> +	value =3D tegra_hsp_readl(hsp, HSP_INT_IE(1));
> +	value &=3D ~BIT(HSP_INT_EMPTY_SHIFT + mb->index);
> +	tegra_hsp_writel(hsp, value, HSP_INT_IE(1));
> +
> +	value =3D tegra_hsp_readl(hsp, HSP_INT_IE(0));
> +	value &=3D ~BIT(HSP_INT_FULL_SHIFT + mb->index);
> +	tegra_hsp_writel(hsp, value, HSP_INT_IE(0));
> +}
> +
> +static const struct mbox_chan_ops tegra_hsp_sm_ops =3D {
> +	.send_data =3D tegra_hsp_mailbox_send_data,
> +	.flush =3D tegra_hsp_mailbox_flush,
> +	.startup =3D tegra_hsp_mailbox_startup,
> +	.shutdown =3D tegra_hsp_mailbox_shutdown,
> +};
> +
> +static struct mbox_chan *tegra_hsp_db_xlate(struct mbox_controller *mbox=
,
>   					    const struct of_phandle_args *args)
>   {
> +	struct tegra_hsp *hsp =3D container_of(mbox, struct tegra_hsp, mbox_db)=
;
> +	unsigned int type =3D args->args[0], master =3D args->args[1];
>   	struct tegra_hsp_channel *channel =3D ERR_PTR(-ENODEV);
> -	struct tegra_hsp *hsp =3D to_tegra_hsp(mbox);
> -	unsigned int type =3D args->args[0];
> -	unsigned int master =3D args->args[1];
>   	struct tegra_hsp_doorbell *db;
>   	struct mbox_chan *chan;
>   	unsigned long flags;
>   	unsigned int i;
>  =20
> -	switch (type) {
> -	case TEGRA_HSP_MBOX_TYPE_DB:
> -		db =3D tegra_hsp_doorbell_get(hsp, master);
> -		if (db)
> -			channel =3D &db->channel;
> +	if (type !=3D TEGRA_HSP_MBOX_TYPE_DB || !hsp->doorbell_irq)
> +		return ERR_PTR(-ENODEV);
>  =20
> -		break;
> -
> -	default:
> -		break;
> -	}
> +	db =3D tegra_hsp_doorbell_get(hsp, master);
> +	if (db)
> +		channel =3D &db->channel;
>  =20
>   	if (IS_ERR(channel))
>   		return ERR_CAST(channel);
>  =20
>   	spin_lock_irqsave(&hsp->lock, flags);
>  =20
> -	for (i =3D 0; i < hsp->mbox.num_chans; i++) {
> -		chan =3D &hsp->mbox.chans[i];
> +	for (i =3D 0; i < mbox->num_chans; i++) {
> +		chan =3D &mbox->chans[i];
>   		if (!chan->con_priv) {
> -			chan->con_priv =3D channel;
>   			channel->chan =3D chan;
> +			chan->con_priv =3D db;
>   			break;
>   		}
>  =20
> @@ -332,6 +532,19 @@ static struct mbox_chan *of_tegra_hsp_xlate(struct m=
box_controller *mbox,
>   	return chan ?: ERR_PTR(-EBUSY);
>   }
>  =20
> +static struct mbox_chan *tegra_hsp_sm_xlate(struct mbox_controller *mbox=
,
> +					    const struct of_phandle_args *args)
> +{
> +	struct tegra_hsp *hsp =3D container_of(mbox, struct tegra_hsp, mbox_sm)=
;
> +	unsigned int type =3D args->args[0], index =3D args->args[1];
> +
> +	if (type !=3D TEGRA_HSP_MBOX_TYPE_SM || !hsp->shared_irqs ||
> +	    index >=3D hsp->num_sm)
> +		return ERR_PTR(-ENODEV);
> +
> +	return hsp->mailboxes[index].channel.chan;
> +}
> +
>   static void tegra_hsp_remove_doorbells(struct tegra_hsp *hsp)
>   {
>   	struct tegra_hsp_doorbell *db, *tmp;
> @@ -364,10 +577,72 @@ static int tegra_hsp_add_doorbells(struct tegra_hsp=
 *hsp)
>   	return 0;
>   }
>  =20
> +static int tegra_hsp_add_mailboxes(struct tegra_hsp *hsp, struct device =
*dev)
> +{
> +	int i;
> +
> +	hsp->mailboxes =3D devm_kcalloc(dev, hsp->num_sm, sizeof(*hsp->mailboxe=
s),
> +				      GFP_KERNEL);
> +	if (!hsp->mailboxes)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < hsp->num_sm; i++) {
> +		struct tegra_hsp_mailbox *mb =3D &hsp->mailboxes[i];
> +
> +		mb->index =3D i;
> +		mb->sending =3D false;
> +
> +		mb->channel.hsp =3D hsp;
> +		mb->channel.regs =3D hsp->regs + SZ_64K + i * SZ_32K;
> +		mb->channel.chan =3D &hsp->mbox_sm.chans[i];
> +		mb->channel.chan->con_priv =3D mb;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tegra_hsp_request_shared_irqs(struct tegra_hsp *hsp)
> +{
> +	int err;
> +
> +	if (hsp->shared_irqs[0] > 0) {
> +		err =3D devm_request_irq(hsp->dev, hsp->shared_irqs[0],
> +				       tegra_hsp_shared_full_irq, 0,
> +				       dev_name(hsp->dev), hsp);
> +		if (err < 0) {
> +			dev_err(hsp->dev,
> +				"failed to request full interrupt: %d\n",
> +				err);
> +			return err;
> +		}
> +
> +		dev_dbg(hsp->dev, "full interrupt requested: %u\n",
> +			hsp->shared_irqs[0]);
> +	}
> +
> +	if (hsp->shared_irqs[1] > 0) {
> +		err =3D devm_request_irq(hsp->dev, hsp->shared_irqs[1],
> +				       tegra_hsp_shared_empty_irq, 0,
> +				       dev_name(hsp->dev), hsp);
> +		if (err < 0) {
> +			dev_err(hsp->dev,
> +				"failed to request empty interrupt: %d\n",
> +				err);
> +			return err;
> +		}
> +
> +		dev_dbg(hsp->dev, "empty interrupt requested: %u\n",
> +			hsp->shared_irqs[1]);
> +	}
> +
> +	return 0;
> +}
> +
>   static int tegra_hsp_probe(struct platform_device *pdev)
>   {
>   	struct tegra_hsp *hsp;
>   	struct resource *res;
> +	unsigned int i;
>   	u32 value;
>   	int err;
>  =20
> @@ -375,6 +650,7 @@ static int tegra_hsp_probe(struct platform_device *pd=
ev)
>   	if (!hsp)
>   		return -ENOMEM;
>  =20
> +	hsp->dev =3D &pdev->dev;
>   	hsp->soc =3D of_device_get_match_data(&pdev->dev);
>   	INIT_LIST_HEAD(&hsp->doorbells);
>   	spin_lock_init(&hsp->lock);
> @@ -392,58 +668,136 @@ static int tegra_hsp_probe(struct platform_device =
*pdev)
>   	hsp->num_si =3D (value >> HSP_nSI_SHIFT) & HSP_nINT_MASK;
>  =20
>   	err =3D platform_get_irq_byname(pdev, "doorbell");
> -	if (err < 0) {
> -		dev_err(&pdev->dev, "failed to get doorbell IRQ: %d\n", err);
> -		return err;
> +	if (err >=3D 0)
> +		hsp->doorbell_irq =3D err;
> +
> +	if (hsp->num_si > 0) {
> +		unsigned int count =3D 0;
> +
> +		hsp->shared_irqs =3D devm_kcalloc(&pdev->dev, hsp->num_si,
> +						sizeof(*hsp->shared_irqs),
> +						GFP_KERNEL);
> +		if (!hsp->shared_irqs)
> +			return -ENOMEM;
> +
> +		for (i =3D 0; i < hsp->num_si; i++) {
> +			char *name;
> +
> +			name =3D kasprintf(GFP_KERNEL, "shared%u", i);
> +			if (!name)
> +				return -ENOMEM;
> +
> +			err =3D platform_get_irq_byname(pdev, name);
> +			if (err >=3D 0) {
> +				hsp->shared_irqs[i] =3D err;
> +				count++;
> +			}
> +
> +			kfree(name);
> +		}
> +
> +		if (count =3D=3D 0) {
> +			devm_kfree(&pdev->dev, hsp->shared_irqs);
> +			hsp->shared_irqs =3D NULL;
> +		}
>   	}
>  =20
> -	hsp->irq =3D err;
> +	/* setup the doorbell controller */
> +	hsp->mbox_db.of_xlate =3D tegra_hsp_db_xlate;
> +	hsp->mbox_db.num_chans =3D 32;
> +	hsp->mbox_db.dev =3D &pdev->dev;
> +	hsp->mbox_db.ops =3D &tegra_hsp_db_ops;
>  =20
> -	hsp->mbox.of_xlate =3D of_tegra_hsp_xlate;
> -	hsp->mbox.num_chans =3D 32;
> -	hsp->mbox.dev =3D &pdev->dev;
> -	hsp->mbox.txdone_irq =3D false;
> -	hsp->mbox.txdone_poll =3D false;
> -	hsp->mbox.ops =3D &tegra_hsp_doorbell_ops;
> +	hsp->mbox_db.chans =3D devm_kcalloc(&pdev->dev, hsp->mbox_db.num_chans,
> +					  sizeof(*hsp->mbox_db.chans),
> +					  GFP_KERNEL);
> +	if (!hsp->mbox_db.chans)
> +		return -ENOMEM;
>  =20
> -	hsp->mbox.chans =3D devm_kcalloc(&pdev->dev, hsp->mbox.num_chans,
> -					sizeof(*hsp->mbox.chans),
> -					GFP_KERNEL);
> -	if (!hsp->mbox.chans)
> +	if (hsp->doorbell_irq) {
> +		err =3D tegra_hsp_add_doorbells(hsp);
> +		if (err < 0) {
> +			dev_err(&pdev->dev, "failed to add doorbells: %d\n",
> +			        err);
> +			return err;
> +		}
> +	}
> +
> +	err =3D mbox_controller_register(&hsp->mbox_db);
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "failed to register doorbell mailbox: %d\n", err);
> +		goto remove_doorbells;
> +	}
> +
> +	/* setup the shared mailbox controller */
> +	hsp->mbox_sm.of_xlate =3D tegra_hsp_sm_xlate;
> +	hsp->mbox_sm.num_chans =3D hsp->num_sm;
> +	hsp->mbox_sm.dev =3D &pdev->dev;
> +	hsp->mbox_sm.ops =3D &tegra_hsp_sm_ops;
> +
> +	hsp->mbox_sm.chans =3D devm_kcalloc(&pdev->dev, hsp->mbox_sm.num_chans,
> +					  sizeof(*hsp->mbox_sm.chans),
> +					  GFP_KERNEL);
> +	if (!hsp->mbox_sm.chans)
>   		return -ENOMEM;
>  =20
> -	err =3D tegra_hsp_add_doorbells(hsp);
> +	if (hsp->shared_irqs) {
> +		err =3D tegra_hsp_add_mailboxes(hsp, &pdev->dev);
> +		if (err < 0) {
> +			dev_err(&pdev->dev, "failed to add mailboxes: %d\n",
> +			        err);
> +			goto unregister_mbox_db;
> +		}
> +	}
> +
> +	err =3D mbox_controller_register(&hsp->mbox_sm);
>   	if (err < 0) {
> -		dev_err(&pdev->dev, "failed to add doorbells: %d\n", err);
> -		return err;
> +		dev_err(&pdev->dev, "failed to register shared mailbox: %d\n", err);
> +		goto unregister_mbox_db;
>   	}
>  =20
>   	platform_set_drvdata(pdev, hsp);
>  =20
> -	err =3D mbox_controller_register(&hsp->mbox);
> -	if (err) {
> -		dev_err(&pdev->dev, "failed to register mailbox: %d\n", err);
> -		tegra_hsp_remove_doorbells(hsp);
> -		return err;
> +	if (hsp->doorbell_irq) {
> +		err =3D devm_request_irq(&pdev->dev, hsp->doorbell_irq,
> +				       tegra_hsp_doorbell_irq, IRQF_NO_SUSPEND,
> +				       dev_name(&pdev->dev), hsp);
> +		if (err < 0) {
> +			dev_err(&pdev->dev,
> +			        "failed to request doorbell IRQ#%u: %d\n",
> +				hsp->doorbell_irq, err);
> +			goto unregister_mbox_sm;
> +		}
>   	}
>  =20
> -	err =3D devm_request_irq(&pdev->dev, hsp->irq, tegra_hsp_doorbell_irq,
> -			       IRQF_NO_SUSPEND, dev_name(&pdev->dev), hsp);
> -	if (err < 0) {
> -		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n",
> -			hsp->irq, err);
> -		return err;
> +	if (hsp->shared_irqs) {
> +		err =3D tegra_hsp_request_shared_irqs(hsp);
> +		if (err < 0)
> +			goto unregister_mbox_sm;
>   	}
>  =20
>   	return 0;
> +
> +unregister_mbox_sm:
> +	mbox_controller_unregister(&hsp->mbox_sm);
> +unregister_mbox_db:
> +	mbox_controller_unregister(&hsp->mbox_db);
> +remove_doorbells:
> +	if (hsp->doorbell_irq)
> +		tegra_hsp_remove_doorbells(hsp);
> +
> +	return err;
>   }
>  =20
>   static int tegra_hsp_remove(struct platform_device *pdev)
>   {
>   	struct tegra_hsp *hsp =3D platform_get_drvdata(pdev);
>  =20
> -	mbox_controller_unregister(&hsp->mbox);
> -	tegra_hsp_remove_doorbells(hsp);
> +	mbox_controller_unregister(&hsp->mbox_sm);
> +	mbox_controller_unregister(&hsp->mbox_db);
> +
> +	if (hsp->doorbell_irq)
> +		tegra_hsp_remove_doorbells(hsp);
>  =20
>   	return 0;
>   }

