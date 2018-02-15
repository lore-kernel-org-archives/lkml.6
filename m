Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbeBOF3v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 00:29:51 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:35810 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbeBOF3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 00:29:49 -0500
Subject: Re: linux-next: build failure after merge of the mmc tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20180215114954.689cc952@canb.auug.org.au>
CC: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c278d6eb-8ca2-c25c-3ff9-2d62d758317d@ti.com>
Date: Thu, 15 Feb 2018 10:59:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20180215114954.689cc952@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 15 February 2018 06:19 AM, Stephen Rothwell wrote:
> Hi Ulf,
> 
> After merging the mmc tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> drivers/mmc/host/sdhci-omap.c: In function 'sdhci_omap_set_timing':
> drivers/mmc/host/sdhci-omap.c:466:8: error: implicit declaration of function 'pinctrl_select_state'; did you mean 'inc_node_state'? [-Werror=implicit-function-declaration]
>   ret = pinctrl_select_state(omap_host->pinctrl, pinctrl_state);
>         ^~~~~~~~~~~~~~~~~~~~
>         inc_node_state
> drivers/mmc/host/sdhci-omap.c: In function 'sdhci_omap_iodelay_pinctrl_state':
> drivers/mmc/host/sdhci-omap.c:740:18: error: implicit declaration of function 'pinctrl_lookup_state'; did you mean 'inc_node_state'? [-Werror=implicit-function-declaration]
>   pinctrl_state = pinctrl_lookup_state(omap_host->pinctrl, mode);
>                   ^~~~~~~~~~~~~~~~~~~~
>                   inc_node_state
> drivers/mmc/host/sdhci-omap.c:740:16: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>   pinctrl_state = pinctrl_lookup_state(omap_host->pinctrl, mode);
>                 ^
> drivers/mmc/host/sdhci-omap.c: In function 'sdhci_omap_config_iodelay_pinctrl_state':
> drivers/mmc/host/sdhci-omap.c:769:23: error: implicit declaration of function 'devm_pinctrl_get'; did you mean 'devm_clk_get'? [-Werror=implicit-function-declaration]
>   omap_host->pinctrl = devm_pinctrl_get(omap_host->dev);
>                        ^~~~~~~~~~~~~~~~
>                        devm_clk_get
> drivers/mmc/host/sdhci-omap.c:769:21: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>   omap_host->pinctrl = devm_pinctrl_get(omap_host->dev);
>                      ^
> drivers/mmc/host/sdhci-omap.c:775:8: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>   state = pinctrl_lookup_state(omap_host->pinctrl, "default");
>         ^
> 
> Caused by commit
> 
>   713190bb14aa ("mmc: sdhci_omap: Add support to set IODELAY values")
> 
> Forgot to include linux/pinctrl/consumer.h?

yeah, looks like it though I didn't observe this error with omap2plus_defconfig.

Ulf, can you drop "mmc: sdhci_omap: Add support to set IODELAY values" patch
from your next. I'll resend the patch after fixing it.

Thanks
Kishon
