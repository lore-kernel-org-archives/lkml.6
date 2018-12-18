Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09059C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8C020672
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHYnOjjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbeLRIhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:37:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51450 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeLRIhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:37:35 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so1679639wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vqzAn8YdXf7bnKbmiNaQpJRP/lxpkAy0aohkam2JcmM=;
        b=bHYnOjjn2s3GTiS7z+a5A7Yju2c7cNxMykNvVEZUM04K2uMYWNV8/JDXs0SKhjj27H
         FtZ0G1fVVDeuGAWbJKiqO8JTiwKEHCFTnOWDt59CxF1UXJyQ/vK5eFots9L5AMC7pioz
         nRPm5g9R65iyLhFKnjDU1a6FqqcqeCZ0mPGHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vqzAn8YdXf7bnKbmiNaQpJRP/lxpkAy0aohkam2JcmM=;
        b=uGXWfaPvFeOZ/jicctP9ZbpLeR3m8SpIteMORz4XZI67xAX7pvZJzPQgIPPQN7opB2
         2C8BeKASsHmVfrpRKVSiQBGZhVKGKLlwTCPamTVJmbcpJzKIWMIIEEsTxHRN4f3E9omu
         WBvQRgSQAG9LYln7eu3w45/hSRPMMcVyIuVQIUPZSZgkfYEvGc1Jzo73LowwlY0eyiNG
         Ytvu/WiQwS8sACelBFPUbtfhQtaU5PzADcvQlt2if7Ys4JaHSB43ffnP4M+loqYZQWsn
         cUdyekm/0jel07FaYLYUEbAmvjJbdzX8FGdI0U6KCWhr55nBKzjJflTy9KU3MMJsslHh
         Hk7g==
X-Gm-Message-State: AA+aEWZxllXOq6grZNCBGQEu/0Xn6nYn5BXsmhJXeqqX4QcQyonlsUTk
        /ubjAT4GhVePP80C9x4GrJG8ew==
X-Google-Smtp-Source: AFSGD/VQdMEMYeOxmFC4VnfdFgbB1mb+XZpzdiJP/7dmVGSKr7jNqCPUjEQu+aLI+vs13q3qjAtVoA==
X-Received: by 2002:a7b:c34c:: with SMTP id l12mr2135630wmj.147.1545122252603;
        Tue, 18 Dec 2018 00:37:32 -0800 (PST)
Received: from [192.168.1.2] (74.red-95-121-88.dynamicip.rima-tde.net. [95.121.88.74])
        by smtp.gmail.com with ESMTPSA id j33sm3629702wre.91.2018.12.18.00.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 00:37:31 -0800 (PST)
Subject: Re: [PATCH 05/13] clk: qcom: apcs-msm8916: get parent clock names
 from DT
To:     Stephen Boyd <sboyd@kernel.org>, andy.gross@linaro.org,
        david.brown@linaro.org, jassisinghbrar@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-clk@vger.kernel.org
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-6-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <154508986359.19322.1555129141976726505@swboyd.mtv.corp.google.com>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <57ef23b0-9c6b-cdd4-9a1a-41c6d5b3aa93@linaro.org>
Date:   Tue, 18 Dec 2018 09:37:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154508986359.19322.1555129141976726505@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/18 00:37, Stephen Boyd wrote:
> Quoting Jorge Ramirez-Ortiz (2018-12-17 01:46:22)
>> Allow accessing the parent clock names required for the driver
>> operation by using the device tree node.
>>
>> This permits extending the driver to other platforms without having to
>> modify its source code.
>>
>> For backwards compatibility leave previous values as default.
> Why do we need to maintain backwards compatibility? Isn't is required
> that the nodes have clocks properties?
>
>

this driver -apcs clock controller- uses platform data (not DT) and 
therefore it uses the DT from the parent node (mailbox).
And for the mailbox the clock property is optional.

So the APCS clock controller requires that the parent provides at least 
one clock but the clock is not mandatory in the parent DT node.
For instance in the case of the msm8916, the parent only provides one 
clock, just the pll.

am I required to modify that platform instead of maintaining backwards 
compatibility?





