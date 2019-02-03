Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17893C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D630B20855
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdY+Afhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfBCIuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 03:50:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54721 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbfBCIuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 03:50:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so10119140wmh.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 00:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/LcsvIxDxzsXKqiH34uS/jv8MOJ9Bgucz7iwKhZHocE=;
        b=jdY+AfhjeUl7Q3UEJhN6nfsnOtudXSpAACoyeOpWd7wwK5nBAiO4XpOqzZ5B56D5zD
         kK7mZV/LzJS6ycwrJOl9YGs2F133gQ80kMAmFV9tYwlAt1PG+l4riT1BrwbxVYhLMaBA
         io31pd/3S/JcmpCvXyE+wGkVZKhop6S5x9VsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/LcsvIxDxzsXKqiH34uS/jv8MOJ9Bgucz7iwKhZHocE=;
        b=HFoLJfauZrRBjd61DA3KP8hnq4QazUVOm48TjooQiGPZU2Lt0jHxr3FI9KV+Ca0Qcf
         pQFt30AWccljhgsmpuzWJCue8wfuUwgdD61nWmmJoX2W8o2orrdvnCzI2gZBdgP+/tjR
         LwoP7D3M8B6VzYKzGs/TAstcnUzYYvwZwnotNQxMVLRSnsvDNSNfz6u48B/WVWvapYAZ
         tkGDjDUlGSFAHy9hHXslzHAuK81ABw2ImyoeOb9R6UKDmMSzGNUQVQ4neq/RcJusJRvY
         E9ZvDdLkf18XEw/ua8gAeMLn8PN3GVe0r9NimlObxr7OXUk6janWJrtw9A6YssHDoqa1
         jswA==
X-Gm-Message-State: AHQUAuZGJwPB8WsjGy65JbtAkUIBhL8ZYFqeCR9L5ozvBW5/C50jzmaQ
        8ROiiax4CN+pKuniehHkT61Hv03eZco=
X-Google-Smtp-Source: AHgI3IaVKNr5Q5mqz9aghUMVTFSDxGa/EdhXg7EXBs088dJndMY92ED1M7PceCp+MWMN/1Rk6DwndQ==
X-Received: by 2002:a7b:c2a9:: with SMTP id c9mr9445188wmk.44.1549183832087;
        Sun, 03 Feb 2019 00:50:32 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id j33sm28736604wre.91.2019.02.03.00.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 00:50:31 -0800 (PST)
Subject: Re: [PATCH v2 1/3] firmware: xilinx: Add zynqmp_pm_get_chipid() API
To:     Nava kishore Manne <nava.manne@xilinx.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com, jollys@xilinx.com,
        rajanv@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190204070951.6933-1-nava.manne@xilinx.com>
 <20190204070951.6933-2-nava.manne@xilinx.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d949520b-452f-9e66-42ae-263959a8c549@linaro.org>
Date:   Sun, 3 Feb 2019 08:50:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204070951.6933-2-nava.manne@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishore,

I need ack for this patch from Michal Simek to take this via nvmem tree.

thanks,
srini

On 04/02/2019 07:09, Nava kishore Manne wrote:
> This patch adds a new API to provide access to the
> hardware related data like soc revision, IDCODE... etc.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v2:
> 		-None.
> Changes for v1:
>                  -None.
> 
> Changes for RFC-V3:
>                  -corrected typo error in commit msg.
> 
> Changes for RFC-v2:
>                  -New Patch.
> 
>   drivers/firmware/xilinx/zynqmp.c     | 24 ++++++++++++++++++++++++
>   include/linux/firmware/xlnx-zynqmp.h |  2 ++
>   2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 9a1c72a9280f..af2a209fc2da 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -186,6 +186,29 @@ static int zynqmp_pm_get_api_version(u32 *version)
>   	return ret;
>   }
>   
> +/**
> + * zynqmp_pm_get_chipid - Get silicon ID registers
> + * @idcode:     IDCODE register
> + * @version:    version register
> + *
> + * Return:      Returns the status of the operation and the idcode and version
> + *              registers in @idcode and @version.
> + */
> +static int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	if (!idcode || !version)
> +		return -EINVAL;
> +
> +	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
> +	*idcode = ret_payload[1];
> +	*version = ret_payload[2];
> +
> +	return ret;
> +}
> +
>   /**
>    * zynqmp_pm_get_trustzone_version() - Get secure trustzone firmware version
>    * @version:	Returned version value
> @@ -471,6 +494,7 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
>   
>   static const struct zynqmp_eemi_ops eemi_ops = {
>   	.get_api_version = zynqmp_pm_get_api_version,
> +	.get_chipid = zynqmp_pm_get_chipid,
>   	.query_data = zynqmp_pm_query_data,
>   	.clock_enable = zynqmp_pm_clock_enable,
>   	.clock_disable = zynqmp_pm_clock_disable,
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 3c3c28eff56a..c435f4b35adf 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -34,6 +34,7 @@
>   
>   enum pm_api_id {
>   	PM_GET_API_VERSION = 1,
> +	PM_GET_CHIPID = 22,
>   	PM_IOCTL = 34,
>   	PM_QUERY_DATA,
>   	PM_CLOCK_ENABLE,
> @@ -91,6 +92,7 @@ struct zynqmp_pm_query_data {
>   
>   struct zynqmp_eemi_ops {
>   	int (*get_api_version)(u32 *version);
> +	int (*get_chipid)(u32 *idcode, u32 *version);
>   	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
>   	int (*clock_enable)(u32 clock_id);
>   	int (*clock_disable)(u32 clock_id);
> 
