Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeCIGGT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 01:06:19 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4064 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbeCIGGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 01:06:18 -0500
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 08 Mar 2018 22:06:17 -0800
Subject: Re: [PATCH] vfio-mdev/samples: change RDI interrupt condition
To: Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Joey Zheng <yu.zheng@hxt-semitech.com>
References: <1520492887-8021-1-git-send-email-shunyong.yang@hxt-semitech.com>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <c14684a6-9388-e38a-c99a-a393c5bcf2a4@nvidia.com>
Date: Fri, 9 Mar 2018 11:36:05 +0530
MIME-Version: 1.0
In-Reply-To: <1520492887-8021-1-git-send-email-shunyong.yang@hxt-semitech.com>
X-Originating-IP: [10.24.250.71]
X-ClientProxiedBy: BGMAIL102.nvidia.com (10.25.59.11) To bgmail102.nvidia.com
 (10.25.59.11)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for fixing it.
Patch looks good to me.
+Alex to pull this patch.

Reviewed by: Kirti Wankhede <kwankhede@nvidia.com>

Thanks,
Kirti

On 3/8/2018 12:38 PM, Shunyong Yang wrote:
> When FIFO mode is enabled, the receive data available interrupt
> (UART_IIR_RDI in code) should be triggered when the number of data
> in FIFO is equal or larger than interrupt trigger level.
> 
> This patch changes the trigger level check to ensure multiple bytes
> received from upper layer can trigger RDI interrupt correctly.
> 
> Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> ---
>  samples/vfio-mdev/mtty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
> index 09f255bdf3ac..7abb79d8313d 100644
> --- a/samples/vfio-mdev/mtty.c
> +++ b/samples/vfio-mdev/mtty.c
> @@ -534,7 +534,7 @@ static void handle_bar_read(unsigned int index, struct mdev_state *mdev_state,
>  
>  		/* Interrupt priority 2: Fifo trigger level reached */
>  		if ((ier & UART_IER_RDI) &&
> -		    (mdev_state->s[index].rxtx.count ==
> +		    (mdev_state->s[index].rxtx.count >=
>  		      mdev_state->s[index].intr_trigger_level))
>  			*buf |= UART_IIR_RDI;
>  
> 
