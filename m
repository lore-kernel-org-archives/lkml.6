Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933362AbeCEHwM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 02:52:12 -0500
Received: from lucky1.263xmail.com ([211.157.147.135]:37600 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752527AbeCEHwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 02:52:08 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: vladimir_zapolskiy@mentor.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <c025c1d284022f78d87464aa39db4e3a>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vladimir_Zapolskiy@mentor.com
Subject: Re: [PATCH v2] mmc: Export host capabilities to debugfs.
To: Harish Jenny K N <harish_kandiga@mentor.com>, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, adrian.hunter@intel.com, avri.altman@wdc.com,
        andriy.shevchenko@linux.intel.com
References: <1520223870-3471-1-git-send-email-harish_kandiga@mentor.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <40000048-4f64-792d-ba38-25a15be8569a@rock-chips.com>
Date: Mon, 5 Mar 2018 15:51:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520223870-3471-1-git-send-email-harish_kandiga@mentor.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/3/5 12:24, Harish Jenny K N wrote:
> From: Abbas Raza <Abbas_Raza@mentor.com>
> 
> This patch exports the host capabilities to debugfs
> 
> Signed-off-by: Abbas Raza <Abbas_Raza@mentor.com>
> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
> ---
> 
> Changes in v2:
> - Changed Author
> 
>   drivers/mmc/core/debugfs.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index c51e0c0..fa2df7f 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -289,6 +289,9 @@ void mmc_add_card_debugfs(struct mmc_card *card)
>   
>   	card->debugfs_root = root;
>   
> +	if (!debugfs_create_x32("host_caps", S_IRUSR, root, (u32 *)&host->caps))

Perhaps you don't need cast, and '&host->caps' should be fine?
And you don't need to export host->caps2?

> +		goto err;
> +
>   	if (!debugfs_create_x32("state", S_IRUSR, root, &card->state))
>   		goto err;
>   
> 
