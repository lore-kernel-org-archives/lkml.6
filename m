Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA31C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3201B20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X1TxzYH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfAOMQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:16:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40446 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfAOMQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:16:36 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so2694378wrt.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 04:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tk6oVp2Q1xK+5YrncieBjtBbgB8FiLeg/7FLZZtRyn0=;
        b=X1TxzYH30AjNUKURCpTHahfnoj0yRrm2m4TZhDhm12Q6Jb3h4YUFECyng7KHxHXu+M
         OdreQt6wwDLbxwZdP8b9xvd98zQf14h4QSGkgdPKqx7Nuk7r5rD2hkT00UB+ekGE8Thc
         027lDBoZbQr945Fskc02Jzo1wb7IHAaEJEUcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tk6oVp2Q1xK+5YrncieBjtBbgB8FiLeg/7FLZZtRyn0=;
        b=NBNNf2PDpeCOuelT93JkGBoCnWcwfxjaI3zLB+nYbjw8tXr/ba9Y3hIuP/Gq/+Hsoa
         9pusZkRNKZfYCRi3to7+RgRIpvp/O8PE0YefTz89oUuCuagA6wxEDX7YeDvJ603hWEu7
         Mz6PKEmUTBu7rJod/GBPU6DKbD9zKtyPyuK7tHXGv6QAgiAN/rBkzIFIRHBHUjpXObaH
         MiRXC2V9jMj7D4xzXVDaNlHATJhfcQ/HJ7Yz3p1f+KU3lWtU4Xaej0bH7za94J+ppaCY
         VJf0KPM8MOzUu9hz1DzMtJwGWh/te6pitNRsWrQkZXhgH4QgKQl+xrniIW68q5GJAcs2
         wbzw==
X-Gm-Message-State: AJcUukfKkvUO7VnT1t+M8WCk+3myzeHo+CaUXB9pPxDdGbXdL+ZvFwj6
        vhqZ9bkD5EYUT82iXZUkoXicJomdm3A=
X-Google-Smtp-Source: ALg8bN5mIPoxf1sDroAtZPM9tc25AUc05+t/ZyE1eF8uWo8CIz8LuUZuAKTL9VYMb9dL/w6hmlEang==
X-Received: by 2002:a5d:6684:: with SMTP id l4mr3174765wru.154.1547554593825;
        Tue, 15 Jan 2019 04:16:33 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id h1sm22637695wmb.0.2019.01.15.04.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 04:16:32 -0800 (PST)
Subject: Re: [PATCH] nvmem: sc27xx: Convert nvmem offset to block index
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     broonie@kernel.org, freeman.liu@unisoc.com,
        linux-kernel@vger.kernel.org
References: <915eacd1c2f05ec84ae50474feb94902bd790ec3.1547536224.git.baolin.wang@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3ed33cde-5656-e0e7-d3c2-ad0e4ec4188b@linaro.org>
Date:   Tue, 15 Jan 2019 12:16:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <915eacd1c2f05ec84ae50474feb94902bd790ec3.1547536224.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/01/2019 07:12, Baolin Wang wrote:
> From: Freeman Liu <freeman.liu@unisoc.com>
> 
> The Spreadtrum SC27XX efuse data are organized by blocks and each block
> contains 2 bytes data. Moreover the nvmem core always pass the offset
> in byte to the controller, so we should change the offset in byte to
> the correct block index and block offset to read the data.
> 
> Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---

Applied!

Thanks,
srini
