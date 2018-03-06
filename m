Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932624AbeCFO66 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:58:58 -0500
Received: from regular1.263xmail.com ([211.150.99.134]:48726 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753075AbeCFO65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:58:57 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: jeffy.chen@rock-chips.com
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <f0598ab598023d087e3acff141925178>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5A9EAC92.4050702@rock-chips.com>
Date: Tue, 06 Mar 2018 22:58:26 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org
CC: Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] mfd: syscon: Set name of regmap_config
References: <20180306110403.14438-1-jeffy.chen@rock-chips.com>
In-Reply-To: <20180306110403.14438-1-jeffy.chen@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Mark.

even this is already fixed by a430ab205d29 ("regmap: debugfs: 
Disambiguate dummy debugfs file name")

but maybe we can still have this for a better debugfs name?

On 03/06/2018 07:04 PM, Jeffy Chen wrote:
> We are now allowing to register debugfs for syscon regmap, and not
> having a valid name will end up using "dummy" to create debugfs dir.
>
> Fixes: 9b947a13e7f6 ("regmap: use debugfs even when no device")
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
>
>   drivers/mfd/syscon.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index 7eaa40bc703f..250d22f40c84 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -109,6 +109,7 @@ static struct syscon *of_syscon_register(struct device_node *np)
>   	syscon_config.reg_stride = reg_io_width;
>   	syscon_config.val_bits = reg_io_width * 8;
>   	syscon_config.max_register = resource_size(&res) - reg_io_width;
> +	syscon_config.name = of_node_full_name(np);
>
>   	regmap = regmap_init_mmio(NULL, base, &syscon_config);
>   	if (IS_ERR(regmap)) {
>
