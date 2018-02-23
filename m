Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbeBWBkl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 20:40:41 -0500
Received: from lucky1.263xmail.com ([211.157.147.131]:55413 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbeBWBkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 20:40:39 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <b103f6ae59f1ac221e29094064f67ca5>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: dw_mmc: update kernel-doc comments for dw_mci
To: Alexey Roslyakov <alexey.roslyakov@gmail.com>
References: <20180222194525.28947-1-alexey.roslyakov@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <f87c7d91-8b26-bf63-5323-5c60b00c81e4@rock-chips.com>
Date: Fri, 23 Feb 2018 09:40:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222194525.28947-1-alexey.roslyakov@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

On 2018/2/23 3:45, Alexey Roslyakov wrote:
> cur_slot and num_slots has been removed from struct dw_mci in 42f989c002f2.
> Unfortunately, inline documentation was not updated so far.
> 
> Fix @lock field documentation in Locking section.
> Move @mrq field of struct dw_mci_slot mention closer to it
> description, so no one could miss this slightest detail.
> 
> Couple of code style fixes as a bonus.
> 

Thanks for updating these.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Alexey Roslyakov <alexey.roslyakov@gmail.com>
> ---
>   drivers/mmc/host/dw_mmc.h | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index e3124f06a47e..451bc0862493 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -65,8 +65,7 @@ struct dw_mci_dma_slave {
>    * @fifo_reg: Pointer to MMIO registers for data FIFO
>    * @sg: Scatterlist entry currently being processed by PIO code, if any.
>    * @sg_miter: PIO mapping scatterlist iterator.
> - * @cur_slot: The slot which is currently using the controller.
> - * @mrq: The request currently being processed on @cur_slot,
> + * @mrq: The request currently being processed on @slot,
>    *	or NULL if the controller is idle.
>    * @cmd: The command currently being sent to the card, or NULL.
>    * @data: The data currently being transferred, or NULL if no data
> @@ -102,7 +101,6 @@ struct dw_mci_dma_slave {
>    * @bus_hz: The rate of @mck in Hz. This forms the basis for MMC bus
>    *	rate and timeout calculations.
>    * @current_speed: Configured rate of the controller.
> - * @num_slots: Number of slots available.
>    * @fifoth_val: The value of FIFOTH register.
>    * @verid: Denote Version ID.
>    * @dev: Device associated with the MMC controller.
> @@ -134,17 +132,17 @@ struct dw_mci_dma_slave {
>    * =======
>    *
>    * @lock is a softirq-safe spinlock protecting @queue as well as
> + * @slot, @mrq and @state. These must always be updated
>    * at the same time while holding @lock.
> + * The @mrq field of struct dw_mci_slot is also protected by @lock,
> + * and must always be written at the same time as the slot is added to
> + * @queue.
>    *
>    * @irq_lock is an irq-safe spinlock protecting the INTMASK register
>    * to allow the interrupt handler to modify it directly.  Held for only long
>    * enough to read-modify-write INTMASK and no other locks are grabbed when
>    * holding this one.
>    *
> - * The @mrq field of struct dw_mci_slot is also protected by @lock,
> - * and must always be written at the same time as the slot is added to
> - * @queue.
> - *
>    * @pending_events and @completed_events are accessed using atomic bit
>    * operations, so they don't need any locking.
>    *
> @@ -321,8 +319,8 @@ struct dw_mci_board {
>   #define SDMMC_ENABLE_SHIFT	0x110
>   #define SDMMC_DATA(x)		(x)
>   /*
> -* Registers to support idmac 64-bit address mode
> -*/
> + * Registers to support idmac 64-bit address mode
> + */
>   #define SDMMC_DBADDRL		0x088
>   #define SDMMC_DBADDRU		0x08c
>   #define SDMMC_IDSTS64		0x090
> @@ -449,7 +447,8 @@ struct dw_mci_board {
>   	(SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET | SDMMC_CTRL_DMA_RESET)
>   
>   /* FIFO register access macros. These should not change the data endian-ness
> - * as they are written to memory to be dealt with by the upper layers */
> + * as they are written to memory to be dealt with by the upper layers
> + */
>   #define mci_fifo_readw(__reg)	__raw_readw(__reg)
>   #define mci_fifo_readl(__reg)	__raw_readl(__reg)
>   #define mci_fifo_readq(__reg)	__raw_readq(__reg)
> 
