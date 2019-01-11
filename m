Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD732C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1F820578
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbfAKLo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:44:59 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53844 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbfAKLo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:44:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83CAF80D;
        Fri, 11 Jan 2019 03:44:58 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7499F3F70D;
        Fri, 11 Jan 2019 03:44:57 -0800 (PST)
Subject: Re: [RESEND PATCH v3 2/2] coresight: etmv4: Update ID register table
 to add UCI support
To:     mike.leach@linaro.org, linux@armlinux.org.uk
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20181218215944.2444-1-mike.leach@linaro.org>
 <20181218215944.2444-3-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <05f725dd-24be-65e4-8b5d-a9acc9167ae9@arm.com>
Date:   Fri, 11 Jan 2019 11:44:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218215944.2444-3-mike.leach@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/12/2018 21:59, Mike Leach wrote:
> Updates the ID register tables to contain a UCI entry for the A35 ETM
> device to allow correct matching of driver in the amba bus code.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 53e2fb6e86f6..2fb8054e43ab 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1073,12 +1073,28 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>   		.mask	= 0x000fffff,		\
>   	}
>   
> +static struct amba_cs_uci_id uci_id_etm4[] = {
> +	{
> +		/*  ETMv4 UCI data */
> +		.devarch	= 0x47704a13,
> +		.devarch_mask	= 0xfff0ffff,
> +		.devtype	= 0x00000013,
> +	}
> +};
> +
> +#define ETM4x_AMBA_UCI_ID(pid)			\
> +	{					\
> +		.id	= pid,			\
> +		.mask	= 0x000fffff,		\
> +		.data	= uci_id_etm4,		\
> +	}
> +
>   static const struct amba_id etm4_ids[] = {
>   	ETM4x_AMBA_ID(0x000bb95d),		/* Cortex-A53 */
>   	ETM4x_AMBA_ID(0x000bb95e),		/* Cortex-A57 */
>   	ETM4x_AMBA_ID(0x000bb95a),		/* Cortex-A72 */
>   	ETM4x_AMBA_ID(0x000bb959),		/* Cortex-A73 */
> -	ETM4x_AMBA_ID(0x000bb9da),		/* Cortex-A35 */
> +	ETM4x_AMBA_UCI_ID(0x000bb9da),		/* Cortex-A35 */
>   	{},
>   };
>   
> 

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

