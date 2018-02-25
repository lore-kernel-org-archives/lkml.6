Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbeBYSNq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 13:13:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33924 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751861AbeBYSNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 13:13:44 -0500
Subject: Re: [PATCH] auxdisplay: arm-charlcd: Fix struct charlcd doc line
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, triad@df.lth.se,
        linux-kernel@vger.kernel.org
References: <20180225124652.76r5tucjebyplw2q@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <682e1867-3fd3-3267-f626-724f08481e9c@infradead.org>
Date: Sun, 25 Feb 2018 10:13:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180225124652.76r5tucjebyplw2q@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/25/2018 04:46 AM, Miguel Ojeda wrote:
> There was a missing first line and a missing member,
> which gave a warning under W=1:
> 
>     CC      drivers/auxdisplay/arm-charlcd.o
>   drivers/auxdisplay/arm-charlcd.c:57: warning: Cannot understand
>    * @dev: a pointer back to containing device on line 57 - I thought
>   it was a doc line
> 
> Cc: Linus Walleij <triad@df.lth.se>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
> Please let me know if anyone does not want this in 4.17.
> 
>  drivers/auxdisplay/arm-charlcd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/auxdisplay/arm-charlcd.c b/drivers/auxdisplay/arm-charlcd.c
> index b3176ee92b90..27cf08a05e93 100644
> --- a/drivers/auxdisplay/arm-charlcd.c
> +++ b/drivers/auxdisplay/arm-charlcd.c
> @@ -54,12 +54,14 @@
>  #define HD_BUSY_FLAG			0x80U
>  
>  /**
> + * struct charlcd

Can you make that more like:
 * struct charlcd - <some brief description>

please.  And merged soon would be fine.

>   * @dev: a pointer back to containing device
>   * @phybase: the offset to the controller in physical memory
>   * @physize: the size of the physical page
>   * @virtbase: the offset to the controller in virtual memory
>   * @irq: reserved interrupt number
>   * @complete: completion structure for the last LCD command
> + * @init_work: delayed work structure to initialize the display on boot
>   */
>  struct charlcd {
>  	struct device *dev;
> 

thanks,
-- 
~Randy
