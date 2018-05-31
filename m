Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754175AbeEaTrM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 15:47:12 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:33896 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754071AbeEaTrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 15:47:10 -0400
Date: Thu, 31 May 2018 15:47:08 -0400 (EDT)
Message-Id: <20180531.154708.1943762077531456815.davem@davemloft.net>
To: arnd@arndb.de
Cc: grygorii.strashko@ti.com, linux-gpio@vger.kernel.org,
        f.fainelli@gmail.com, ivan.khoronzhuk@linaro.org, j-keerthy@ti.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ti: cpsw: include gpio/consumer.h
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180530215212.1151415-1-arnd@arndb.de>
References: <20180530215212.1151415-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 May 2018 23:51:54 +0200

> On platforms that don't always enable CONFIG_GPIOLIB, we run into
> a build failure:
> 
> drivers/net/ethernet/ti/cpsw.c: In function 'cpsw_probe':
> drivers/net/ethernet/ti/cpsw.c:3006:9: error: implicit declaration of function 'devm_gpiod_get_array_optional' [-Werror=implicit-function-declaration]
>   mode = devm_gpiod_get_array_optional(&pdev->dev, "mode", GPIOD_OUT_LOW);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/ti/cpsw.c:3006:59: error: 'GPIOD_OUT_LOW' undeclared (first use in this function); did you mean 'GPIOF_INIT_LOW'?
>   mode = devm_gpiod_get_array_optional(&pdev->dev, "mode", GPIOD_OUT_LOW);
> 
> Since we cannot rely on this to be visible from gpio.h, we have to include
> gpio/consumer.h directly.
> 
> Fixes: 2652113ff043 ("net: ethernet: ti: Allow most drivers with COMPILE_TEST")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks Arnd.
