Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5C9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D9B21903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TaOKGUsn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbeLUHiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:38:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37726 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730689AbeLUHiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:38:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so4158422wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 23:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QZZ7YADYnialSsrPRHFulkT8AqPoFrFrOJYuHyaVHX8=;
        b=TaOKGUsnP0/yUI2ghUWynEPssb4nZyEcE9EibV1Qn5I7QzyGABJz9RPCPYZk56Vzxf
         rT17Y92S9T/tlBlyHRZo4l3eF/J/ccB3T1xn3ip41BufEly5yG5LL6pQmGZZeS8t3umo
         WN/vH8qcWKoRJYUzRnzzA5eGZD3WEoz+oIuTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QZZ7YADYnialSsrPRHFulkT8AqPoFrFrOJYuHyaVHX8=;
        b=pWTU6e8AnCgKXxbxrqkWaOouw7hLqRQ3mcRMBj+0Dn33gfjYXLF0JOK6LbfAGtFEJ4
         ptRttFSKEOrCeSOvC753W+KqqOHABN7aZ8v7plk+WmmG/SpV1QkgBrBnHBar+3IokSo9
         ffNNt4BT4cmwN5VpKlGEXZVTYF0jGpW/FuKkLjNRpG1tDv6a/Ne5xq8baUebM1tEzNAX
         /QXutSuCNg91W/RSsHlaUa3Mv+1B0Y2rPGNQI3lYPSzPwPJqD4+F5a8UE4tMYc00zxY6
         L6+Z4WceaTiLjU1kqVK4Xh4Ghr9vICZ3bWG6FgSek2TOqt3bqubd0sm0cxGinXQYKhSl
         mVcQ==
X-Gm-Message-State: AJcUukenSvkQTpQtDfUBjnz4H04y0R85DxUpa/ElMk4keIioUuxY+mBi
        z9TTYooMJ0b0Gya4JZNzqNpVLQ==
X-Google-Smtp-Source: ALg8bN7tCnQwJus4DiqOdXF8IF3IGqEcJEGJY9T2QFR2TKf6RdHbmo0KsVGCoNyFBd6al7jBbUsSKA==
X-Received: by 2002:adf:e284:: with SMTP id v4mr1305310wri.26.1545377878949;
        Thu, 20 Dec 2018 23:37:58 -0800 (PST)
Received: from [192.168.1.2] (119.red-79-146-81.dynamicip.rima-tde.net. [79.146.81.119])
        by smtp.gmail.com with ESMTPSA id j63sm7969927wmb.40.2018.12.20.23.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 23:37:58 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: Add Qualcomm USB Super-Speed PHY
 bindings
To:     Stephen Boyd <swboyd@chromium.org>, gregkh@linuxfoundation.org,
        kishon@ti.com, mark.rutland@arm.com, robh+dt@kernel.org
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawn.guo@linaro.org,
        vkoul@kernel.org
References: <1544176558-7946-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1544176558-7946-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <154533751009.79149.13940391507897650993@swboyd.mtv.corp.google.com>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <14fc8e2e-f3c9-ef87-ec8f-51bdaea90470@linaro.org>
Date:   Fri, 21 Dec 2018 08:37:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154533751009.79149.13940391507897650993@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 21:25, Stephen Boyd wrote:
> Quoting Jorge Ramirez-Ortiz (2018-12-07 01:55:57)
>> +
>> +- qcom,vdd-voltage-level:
>> +    Value type: <prop-array>
>> +    Definition: This is a list of three integer values <no min max> where
>> +                each value corresponding to voltage corner in uV.
> As far as I'm aware, this isn't how qcom's voltage corners are handled
> or are going to be handled. Can't you hardcode it in the driver for now?
>
>

ok so you mean use a regulator to control the supply (with 
regulator-min-microvolt and max-microvolt properties instead?
I'll look into that

I guess we should pull back on this one as well?
https://lore.kernel.org/patchwork/patch/1026641/
