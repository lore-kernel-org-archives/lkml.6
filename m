Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA6BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C9D20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dEm2KVZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfARNFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:05:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35457 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfARNFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:05:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so15008273wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 05:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IGEYkrqPTO24Yuc9eocs/hY5nllEGzkfq9emuvq8Gio=;
        b=dEm2KVZB5cxpLHfuaK6Dh4OAk7nC+5q4DwoWZ5vCwIoDY70tXasm3lPYREyiAzY8M5
         ryWnM9cHOAHYVn7GXxFoaFF6sg2wGMm7w3GgFXsBpjKz/Iwtu7rx8gXtYAWpBDXIBJ6a
         KVJIovoSS2bL7FQtEGlfTG4pNrv3QsOQ/C2AI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IGEYkrqPTO24Yuc9eocs/hY5nllEGzkfq9emuvq8Gio=;
        b=s7dEvoBQAXiw+AJeWRf2RI5zCXrENLU54XhkovOcwwiNWa0l8t24m5yGeq/4liUhf3
         Mfhq7ZADw+p6zSWh4ugJQp5fRqFvSeg7N4Aqq8QhNqRzJ2+pksyi9hsSfAv0gWcYR30b
         WGywokSyevF7TEt/QRlGbdD8i40Er6T7/JQxP1/vMhobtR+xWr2EfR7ACs1qDk8Nw5sG
         End4GsaIogXNW/hxqw6aWBrhKi+u2Dq9nn5lwnSSBLlKPxOBhb4LOkwX8mb8LQmojhFv
         7RrJVnVDqb6BPLDLk05RLW00xZcJ1kUmkboIhPtIxW4a4DKUyI6fSLRInuIvPTdD+osp
         XQ4g==
X-Gm-Message-State: AJcUukfhLUXEDqxjp+dmWjEuYI76WsArVd7UPvtkejP3E2biIxUF8IRW
        XlRsXwBSqLr8voBXPfsuY0d4uXOTYHk=
X-Google-Smtp-Source: ALg8bN4MqGHXzI3kuvhkVNKKcLNqY6IDlH5hvYoHlArNLFmkRU+kslIWROxGT6xGFhCTgYI09oU78Q==
X-Received: by 2002:adf:dd06:: with SMTP id a6mr17214160wrm.2.1547816734132;
        Fri, 18 Jan 2019 05:05:34 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id a12sm79510174wrm.45.2019.01.18.05.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 05:05:32 -0800 (PST)
Subject: Re: [PATCH v4 0/2] arm64: dts: qcom: sdm845: Fix DMA allocations for
 devices with IOMMU
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190117042940.25487-1-bjorn.andersson@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7e662602-73dd-2ac6-4e49-ce92f1d157d2@linaro.org>
Date:   Fri, 18 Jan 2019 13:05:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117042940.25487-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/01/2019 04:29, Bjorn Andersson wrote:
> These patches extends the size cells of the soc bus and define the dma-ranges,
> so that DMA allocations for devices with IOMMU attached will get valid IOVAs.
> 
> Changes since v3:
> - Split patch in two
> - Rewrote commit message from scratch
> 
> Bjorn Andersson (2):
>    arm64: dts: qcom: sdm845: Increase address and size cells for soc
>    arm64: dts: qcom: sdm845: Extend ranges and describe DMA space
> 
>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 301 ++++++++++++++-------------
>   1 file changed, 151 insertions(+), 150 deletions(-)
> 

Thanks for the fix, finally managed to get both fastrpc and ufs working 
together with iommu!


Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
