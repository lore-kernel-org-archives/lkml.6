Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C69C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDB921763
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gV2ruoka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDB921763
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeHUP2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 11:28:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38080 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeHUP2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 11:28:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id t25-v6so2617127wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 05:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VEP3BXn88EqQsrJIqzViF2ONkrjogXpicuBD9QfmpeM=;
        b=gV2ruoka/nSoGxbhe8443xpqKBXLyBcYE0KDo+c9G0uavy4HtP9z3qxBvj5kYMtH0I
         gHGNo0RiGheUQawCCH3Ullt07IYUgBm8QmQAoQg72kMwKZg8AbEU+f58j2QyBBZxHkUW
         SbF4gP1U5ukqnuuNHmml9mKP9fQwdvzKWE7wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VEP3BXn88EqQsrJIqzViF2ONkrjogXpicuBD9QfmpeM=;
        b=orLDE6riz9JJ40RxtyzqKhTvyG8GvVQYCCriiJHTiP2X3XYWfxYhvNgelLbx9+PS1r
         Pi3mn9JXkmaPCFaUtXckwdki5+CRgkL2FUkRiGK2t5C8h35aKmbdBOhXnHCNtIkt2594
         B5hWhXMsWJTzcf9oTPzXJkJV33gSnBB3TorvqoZk7CAeqM7Hqq2qsz5lo4eZMENbqZod
         a/KVgQ40vvj4+4E1Ss9Z4c3YCRyhO5K3mrFNCjqGuINKmbG8FkF2AIm4X0cM4x7gr+Zm
         aTICtRLOUReXdvppiWMqG7cNMHKCCKuTYIEMqNIOUEpHQSP0QBnbN10m7R8Lj2cVG13V
         WSHg==
X-Gm-Message-State: AOUpUlEA+OBB6O6snp2PikBorhnkFwqTby0bv9yVSvf7D9a/tpmzCK8/
        ILos/kGdsnFHHJzd40s0viKtpA==
X-Google-Smtp-Source: AA+uWPxBnRNZxFsiwsW19+DqcnwVnk3GqJeLMG7e7OigeZKS2cnP1m2poIOuI6N88yXzqe8D05v9Ng==
X-Received: by 2002:a1c:f46:: with SMTP id 67-v6mr26574390wmp.122.1534853328691;
        Tue, 21 Aug 2018 05:08:48 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id o33-v6sm29516922wrf.11.2018.08.21.05.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 05:08:48 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] venus: firmware: move load firmware in a separate
 function
To:     Vikash Garodia <vgarodia@codeaurora.org>, hverkuil@xs4all.nl,
        mchehab@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, acourbot@chromium.org
References: <1533562085-8773-1-git-send-email-vgarodia@codeaurora.org>
 <1533562085-8773-3-git-send-email-vgarodia@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <8ffd63d9-ba9f-44b2-e1c0-7edce167fd9c@linaro.org>
Date:   Tue, 21 Aug 2018 15:08:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533562085-8773-3-git-send-email-vgarodia@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

On 08/06/2018 04:28 PM, Vikash Garodia wrote:
> Separate firmware loading part into a new function.
> 
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/core.c     |  4 +--
>  drivers/media/platform/qcom/venus/firmware.c | 54 +++++++++++++++++-----------
>  drivers/media/platform/qcom/venus/firmware.h |  2 +-
>  3 files changed, 37 insertions(+), 23 deletions(-)
> 

<snip>

> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 3aa6b37..4577043 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -58,20 +58,18 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
>  	return 0;
>  }
>  
> -int venus_boot(struct device *dev, const char *fwname)
> +static int venus_load_fw(struct venus_core *core, const char *fwname,
> +			phys_addr_t *mem_phys, size_t *mem_size)

fix indentation

>  {
>  	const struct firmware *mdt;
>  	struct device_node *node;
> -	phys_addr_t mem_phys;
> +	struct device *dev;
>  	struct resource r;
>  	ssize_t fw_size;
> -	size_t mem_size;
>  	void *mem_va;
>  	int ret;
>  
> -	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) || !qcom_scm_is_available())
> -		return -EPROBE_DEFER;
> -
> +	dev = core->dev;
>  	node = of_parse_phandle(dev->of_node, "memory-region", 0);
>  	if (!node) {
>  		dev_err(dev, "no memory-region specified\n");
> @@ -82,16 +80,16 @@ int venus_boot(struct device *dev, const char *fwname)
>  	if (ret)
>  		return ret;
>  
> -	mem_phys = r.start;
> -	mem_size = resource_size(&r);
> +	*mem_phys = r.start;
> +	*mem_size = resource_size(&r);
>  
> -	if (mem_size < VENUS_FW_MEM_SIZE)
> +	if (*mem_size < VENUS_FW_MEM_SIZE)
>  		return -EINVAL;
>  
> -	mem_va = memremap(r.start, mem_size, MEMREMAP_WC);
> +	mem_va = memremap(r.start, *mem_size, MEMREMAP_WC);
>  	if (!mem_va) {
>  		dev_err(dev, "unable to map memory region: %pa+%zx\n",
> -			&r.start, mem_size);
> +			&r.start, *mem_size);
>  		return -ENOMEM;
>  	}
>  
> @@ -106,23 +104,39 @@ int venus_boot(struct device *dev, const char *fwname)
>  		goto err_unmap;
>  	}
>  
> -	ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID, mem_va, mem_phys,
> -			    mem_size, NULL);
> +	if (core->no_tz)
> +		ret = qcom_mdt_load_no_init(dev, mdt, fwname, VENUS_PAS_ID,
> +					mem_va, *mem_phys, *mem_size, NULL);
> +	else
> +		ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID,
> +				mem_va, *mem_phys, *mem_size, NULL);

Please fix the indentation issues above.

>  
>  	release_firmware(mdt);
>  
> -	if (ret)
> -		goto err_unmap;
> -
> -	ret = qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
> -	if (ret)
> -		goto err_unmap;
> -
>  err_unmap:
>  	memunmap(mem_va);
>  	return ret;
>  }
>  
> +int venus_boot(struct venus_core *core)
> +{
> +	phys_addr_t mem_phys;
> +	struct device *dev = core->dev;

move this one row upper.

> +	size_t mem_size;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
> +		(!core->no_tz && !qcom_scm_is_available()))
> +		return -EPROBE_DEFER;

fix indentation

> +
> +	ret = venus_load_fw(core, core->res->fwname, &mem_phys, &mem_size);
> +	if (ret) {
> +		dev_err(dev, "fail to load video firmware\n");
> +		return -EINVAL;
> +	}

blank line here

> +	return qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
> +}

-- 
regards,
Stan
