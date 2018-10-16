Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D63DC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0550820881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NjEIbJ/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0550820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeJPRZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:25:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34015 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeJPRZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:25:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id z25-v6so24887670wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 02:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D4VuEUlu/saxzOygyOhdfNwTC/OlDQqRxsJfoPGahcQ=;
        b=NjEIbJ/wBGmbINHO0aJPgNWAnH6BmtSBTK77jmr/TalYUlB0NyF/ExoOKMaQZHONQT
         5hhYoV/f9DJMLle977OKy5GlHtxpWZopkJtziJPcwVEx+knWT5scGFYGsKHbWpCSUhA4
         y/9WYTKiveSkoap3o1+jvuQNl2QrWPBFD3Qe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D4VuEUlu/saxzOygyOhdfNwTC/OlDQqRxsJfoPGahcQ=;
        b=HDDHKOrDulE1tHwodays8YmXTyUkxvKFuLgqn4Q8qBa31K1T2bgM2qDt3/Eq+TtHgL
         EbLWhmwGGuj6fbWIHOQ20gOmeJHgbF2WL8efK7J6syhTs/CtWjmySnF68fAYTMY8LvT1
         v9V4RuZAtlc+zPg1GkvGN4AwI7w3Wt+SNYpXaIJ36hEG4Cax1YP2A6hEvHxNRkTscRzM
         yO1XFYJOGnPNR8agvVmDzGTQ25t9eZPthasrKZlPgdW0qdnieI+UOi3gPU/pH/JZR7ZX
         AANuDC50pst0pn7R2ytWHx/YFzKp/V5C/jaLOrvYWkWgm5U7jfksAtWHewhaa38VxYsM
         4cIA==
X-Gm-Message-State: ABuFfogtwJ2moG/vrfTi0ugvkkGtWKQ281XCi4K1JyW5Jqw8xW+cugxU
        p2msAVYte7p0477E8pa4iVLp3i7MnFM=
X-Google-Smtp-Source: ACcGV60gENZ0Mdzi7mWQun6Cf9Ygi+93QJMawOrr3sO18QGno6Xg72GzlDlmrj7B+0Kp5DIJivDBjA==
X-Received: by 2002:a1c:f417:: with SMTP id z23-v6mr16498014wma.80.1539682559900;
        Tue, 16 Oct 2018 02:35:59 -0700 (PDT)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id l125-v6sm44018662wmb.1.2018.10.16.02.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 02:35:58 -0700 (PDT)
Subject: Re: [PATCH v2] slimbus: ngd: QCOM_QMI_HELPERS has to be selected
To:     Niklas Cassel <niklas.cassel@linaro.org>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20181015183218.GA16900@kroah.com>
 <20181015194441.10475-1-niklas.cassel@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0c4e1267-8eef-8334-f041-87c71d343aa5@linaro.org>
Date:   Tue, 16 Oct 2018 10:35:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181015194441.10475-1-niklas.cassel@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Niklas for quick v2 patch!

On 15/10/18 20:44, Niklas Cassel wrote:
> QCOM_QMI_HELPERS is a hidden kconfig, so the proper usage is
> to select it, not depend upon it.
> 
> Because of this change, we now also need to depend on the same
> Kconfigs as QCOM_QMI_HELPERS depends on.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

LGTM

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
> Hello Greg, Srini,
> 
> I'm sorry for this.
> (Although I'm a bit curious why 0-day test bot didn't catch this.)
> 
> Considering that I've just changed QCOM_QMI_HELPERS in:
> ccfb464cd106 ("soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs")
> which is currently in linux-next, and that this Kconfig should
> depend on the same Kconfigs as QCOM_QMI_HELPERS depends on,
> I chose to have this Kconfig match the QCOM_QMI_HELPERS that is
> currently in linux-next.
> 
>   drivers/slimbus/Kconfig | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
> index 9d73ad806698..8cd595148d17 100644
> --- a/drivers/slimbus/Kconfig
> +++ b/drivers/slimbus/Kconfig
> @@ -22,8 +22,9 @@ config SLIM_QCOM_CTRL
>   
>   config SLIM_QCOM_NGD_CTRL
>   	tristate "Qualcomm SLIMbus Satellite Non-Generic Device Component"
> -	depends on QCOM_QMI_HELPERS
> -	depends on HAS_IOMEM && DMA_ENGINE
> +	depends on HAS_IOMEM && DMA_ENGINE && NET
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	select QCOM_QMI_HELPERS
>   	help
>   	  Select driver if Qualcomm's SLIMbus Satellite Non-Generic Device
>   	  Component is programmed using Linux kernel.
> 
