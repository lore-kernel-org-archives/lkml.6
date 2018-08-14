Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F2BC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D1320B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uw0QK07X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D1320B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbeHNPci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:32:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47055 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731328AbeHNPci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:32:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id h14-v6so17083433wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 05:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vI/M425Eix1liHmzuPZme1Dyugw4ohhFXgrbfxEYQlw=;
        b=Uw0QK07XVjp8UjbvBKWtpJW/dfR1zgMnt4jurv/krjuYmF+9MLOjQPVdmOovIM3DOS
         7cWn3AAyF9jYCz1hq3LQwqWGcROxUt49VmXY3kB0Rvm74bBso2ZM+OpJt75/APPOOEuY
         y4DTporFvFkXP8nloAWVkDcDzkPv4K6buBOHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vI/M425Eix1liHmzuPZme1Dyugw4ohhFXgrbfxEYQlw=;
        b=AEJhUp8Gx30JDu4yhqtXV2OZm/vQ8wSjOGZNwUYAgmli+A6hzmYkxsqRDFsqqaiorg
         SFjqtI2+8zZ6bDFCG4zerWP2ouLd6jxROebqljvC2rVCa+dEkxuTpe7qmRQmMD2ZRBFQ
         cg93LdkMGhrR/7axf91u1CoU0rthDkMleeGs6niQYX4acvvEppl6bBewTmo3O4G7osRo
         hvvQ0BSvbkaS80aeJysS83tM9ytWwIEGYcwcY0GjEAmv4or78sP/Qk26vBeAt6Nj5lGQ
         EUt+L0HZwa10GDvIELneioa5YWV4uQ/lN4DLaSJ0RInZz+p2CWmKO+Ol/DLk5iGH9XkP
         QhgA==
X-Gm-Message-State: AOUpUlFoAEEHuORvzdTrqUAiHatfWmJrRwJ5Dpcp0csNuZiKPCUgl3Yh
        nBDy8yLWyMS31WXVeToC8yg/b8u3xxU=
X-Google-Smtp-Source: AA+uWPw1WOFwHra177MntwGq3P5AlNyqiCZM9Xl/KmtlGFgbRLPFub026cmpklYaqhrgNzeZ54EbCw==
X-Received: by 2002:adf:ff11:: with SMTP id k17-v6mr14049212wrr.255.1534250734820;
        Tue, 14 Aug 2018 05:45:34 -0700 (PDT)
Received: from [192.168.27.197] ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 198-v6sm24980380wmm.0.2018.08.14.05.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 05:45:33 -0700 (PDT)
Subject: Re: [PATCH] [v2] media: camss: add missing includes
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hansverk@cisco.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180814091636.1960071-1-arnd@arndb.de>
From:   Todor Tomov <todor.tomov@linaro.org>
Message-ID: <565437f4-e01a-4558-ccc1-4f312e26cf35@linaro.org>
Date:   Tue, 14 Aug 2018 15:45:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180814091636.1960071-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 14.08.2018 12:13, Arnd Bergmann wrote:
> Multiple files in this driver fail to build because of missing
> header inclusions:
> 
> drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c: In function 'csiphy_hw_version_read':
> drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c:31:18: error: implicit declaration of function 'readl_relaxed'; did you mean 'xchg_relaxed'? [-Werror=implicit-function-declaration]
> drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c: In function 'csiphy_hw_version_read':
> drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c:52:2: error: implicit declaration of function 'writel' [-Werror=implicit-function-declaration]

Thank you for noticing this and preparing a patch.
I build for arm64 and x86_64 with compile test enabled and I don't see these errors. Do you have a guess what is different that I don't have them?

> drivers/media/platform/qcom/camss/camss-ispif.c: In function 'msm_ispif_subdev_init':
> drivers/media/platform/qcom/camss/camss-ispif.c:1079:16: error: implicit declaration of function 'kcalloc'; did you mean 'kvcalloc'? [-Werror=implicit-function-declaration]

Maybe we have to use devm_kcalloc instead of kcalloc here, I will check this.

Best regards,
Todor

> 
> Add the ones that I observed, plus linux/io.h in all other files that
> call readl/writel and related interfaces.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: actually add the linux/io.h instances for files that did not show
> the error but might still be affected because of the readl/writel usage
> ---
>  drivers/media/platform/qcom/camss/camss-csid.c           | 1 +
>  drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c | 1 +
>  drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c | 1 +
>  drivers/media/platform/qcom/camss/camss-csiphy.c         | 1 +
>  drivers/media/platform/qcom/camss/camss-ispif.c          | 2 ++
>  drivers/media/platform/qcom/camss/camss-vfe-4-1.c        | 1 +
>  drivers/media/platform/qcom/camss/camss-vfe-4-7.c        | 1 +
>  7 files changed, 8 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
> index 729b31891466..a5ae85674ffb 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid.c
> @@ -10,6 +10,7 @@
>  #include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/interrupt.h>
> +#include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c
> index c832539397d7..12bce391d71f 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c
> @@ -12,6 +12,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> +#include <linux/io.h>
>  
>  #define CAMSS_CSI_PHY_LNn_CFG2(n)		(0x004 + 0x40 * (n))
>  #define CAMSS_CSI_PHY_LNn_CFG3(n)		(0x008 + 0x40 * (n))
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> index bcd0dfd33618..2e65caf1ecae 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> @@ -12,6 +12,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> +#include <linux/io.h>
>  
>  #define CSIPHY_3PH_LNn_CFG1(n)			(0x000 + 0x100 * (n))
>  #define CSIPHY_3PH_LNn_CFG1_SWI_REC_DLY_PRG	(BIT(7) | BIT(6))
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
> index 4559f3b1b38c..008afb85023b 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
> @@ -10,6 +10,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> +#include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> diff --git a/drivers/media/platform/qcom/camss/camss-ispif.c b/drivers/media/platform/qcom/camss/camss-ispif.c
> index 7f269021d08c..d824c4958c07 100644
> --- a/drivers/media/platform/qcom/camss/camss-ispif.c
> +++ b/drivers/media/platform/qcom/camss/camss-ispif.c
> @@ -10,11 +10,13 @@
>  #include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/interrupt.h>
> +#include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/slab.h>
>  #include <media/media-entity.h>
>  #include <media/v4l2-device.h>
>  #include <media/v4l2-subdev.h>
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
> index da3a9fed9f2d..174a36be6f5d 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/interrupt.h>
> +#include <linux/io.h>
>  #include <linux/iopoll.h>
>  
>  #include "camss-vfe.h"
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
> index 4c584bffd179..0dca8bf9281e 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/interrupt.h>
> +#include <linux/io.h>
>  #include <linux/iopoll.h>
>  
>  #include "camss-vfe.h"
> 

-- 
Best regards,
Todor Tomov
