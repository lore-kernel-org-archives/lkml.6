Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F7FC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6422418D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6422418D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753550AbeGEJ54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:57:56 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:49733 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbeGEJ5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:57:54 -0400
Received: from [IPv6:2003:e9:d74b:8bb:3252:cbff:fe54:190f] (p200300E9D74B08BB3252CBFFFE54190F.dip0.t-ipconnect.de [IPv6:2003:e9:d74b:8bb:3252:cbff:fe54:190f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 75804C7FFB;
        Thu,  5 Jul 2018 11:57:52 +0200 (CEST)
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH] ieee802154: mcr20a: add missing includes
To:     Arnd Bergmann <arnd@arndb.de>, Xue Liu <liuxuenetmail@gmail.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Colin Ian King <colin.king@canonical.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180530214732.1021121-1-arnd@arndb.de>
Message-ID: <f05de56e-eb0c-a821-b623-90571c4551de@datenfreihafen.org>
Date:   Thu, 5 Jul 2018 11:57:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180530214732.1021121-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

[Sorry for the delay here, I was on a few weeks on leave]

On 30.05.2018 23:47, Arnd Bergmann wrote:
> Without CONFIG_GPIOLIB, some headers are not included implicitly,
> leading to a build failure:
> 
> drivers/net/ieee802154/mcr20a.c: In function 'mcr20a_probe':
> drivers/net/ieee802154/mcr20a.c:1347:13: error: implicit declaration of function 'irq_get_trigger_type'; did you mean 'irq_get_irqchip_state'? [-Werror=implicit-function-declaration]
> 
> This includes gpio/consumer.h and irq.h directly rather through the
> gpiolib header.
> 
> Fixes: 8c6ad9cc5157 ("ieee802154: Add NXP MCR20A IEEE 802.15.4 transceiver driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ieee802154/mcr20a.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
> index de0d7f28a181..e428277781ac 100644
> --- a/drivers/net/ieee802154/mcr20a.c
> +++ b/drivers/net/ieee802154/mcr20a.c
> @@ -15,10 +15,11 @@
>   */
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/spi/spi.h>
>  #include <linux/workqueue.h>
>  #include <linux/interrupt.h>
> +#include <linux/irq.h>
>  #include <linux/skbuff.h>
>  #include <linux/of_gpio.h>
>  #include <linux/regmap.h>
> 

This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
