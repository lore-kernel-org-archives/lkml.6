Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E568C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286FB224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ipq8yw5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286FB224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbeKMTDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:03:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39774 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeKMTDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:03:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id u13-v6so10625199wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 01:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lbb6Z/9fWXEVYSNhVp0g9zKf0MrPDYp4qhHKGU5/WtM=;
        b=Ipq8yw5lH5SzskvirVg2VpgNNseiQsR+ISqZax70yYZOWhHSkkiPypJElkffh4vK8o
         ZhZG8tG5YZ1Z4PlPAE4p+V0k4cH013xlwoDmzgJVdqRzKcPzZj0Hh2tBL5KxJfMgorP7
         Lmi5CoYcEGwP9LqgqUTQtl5fWx8d2xea28Mpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lbb6Z/9fWXEVYSNhVp0g9zKf0MrPDYp4qhHKGU5/WtM=;
        b=kub8C6UiAjm8dic+z+M7LNGAG8qTIsWLFwOyYF0gVLBaOeJRE0rtlECcDXL7YHpHOS
         YCjpgq2tcmtpt9JLoBnUzjxxCIe7I6TpKk5qnIyO67ihyDokqtVhL+VlrdLGkQpjl0XP
         ti1LDUxH4sJCSNOTfRC0dc2ClDLviTvRytTmnyu+wJOpDHPtKUiFbfSzTZBMYZkgHB5P
         +lnsoHwHPNAIxISek1Dcjj6eZSAkJK5NzeVS/SNmXxsrrIYfMrubvnLT+Uu7k0nG9e1X
         odVfxk2H6OPb3xaU++Yv4Krjgno21odUVUI+7GWp58B4k3mSG+hGubyCPiRF05aKseam
         ICPw==
X-Gm-Message-State: AGRZ1gKJZq1Jexw4QCIJi6zpZMHYB+VqVf3VVqTkilBSPFWbAwYB/O4O
        ylXBgC1vjCbLMmkKdFgjJQzggnvpBDo=
X-Google-Smtp-Source: AJdET5f7xiZWRcIMJROfjiR/igZgEc4f0uLzQJ0cloP7as4rPPF/RS/ciWKECdWqp37k0YJxFXkIfg==
X-Received: by 2002:a1c:3954:: with SMTP id g81-v6mr2332795wma.139.1542099959421;
        Tue, 13 Nov 2018 01:05:59 -0800 (PST)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id j125-v6sm11254666wmb.12.2018.11.13.01.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 01:05:58 -0800 (PST)
Subject: Re: [PATCH 2/4] nvmem: meson-efuse: bindings: add peripheral clock
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181030102231.4851-1-jbrunet@baylibre.com>
 <20181030102231.4851-3-jbrunet@baylibre.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <60b49b47-67d6-ef78-0e0b-78d28da1be6e@linaro.org>
Date:   Tue, 13 Nov 2018 09:05:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181030102231.4851-3-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/10/18 10:22, Jerome Brunet wrote:
> The efuse found in gx SoC requires a peripheral clock to properly operate.
> We have been able to work without it until now because the clock was on by
> default, and left on by the CCF. Soon, it will not be the case anymore, so
> the device needs to claim the clock it needs
> 
> Signed-off-by: Jerome Brunet<jbrunet@baylibre.com>
> ---
>   Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt | 3 +++
>   1 file changed, 3 insertions(+)

Applied, thanks,

--
Srini
