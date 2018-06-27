Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B24C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8890E26512
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EicJDmyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8890E26512
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934426AbeF0Aq3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 20:46:29 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35406 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752638AbeF0Aq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 20:46:27 -0400
Received: by mail-pl0-f66.google.com with SMTP id k1-v6so158136plt.2;
        Tue, 26 Jun 2018 17:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MTUHQ0XBMKYjCMxTR8J9NyW/tLEmYUh7AnhEaRP63mA=;
        b=EicJDmySI3f7FAOgYjFQE0QBhXx1QlbBhWqVKSqV2ppFmDCumXD9YsZUtRhdviVb/1
         SY68jfa7h9OvviblUFoCit3bjzSb3O2RK+A8Ao5YDMocmTj9yZd2fI7AiplP80i+Ydbm
         rfXWfhTzEiNElbtWolSlhKZSu3ZngauAdCJcBD/BBfdN2G7pUncoUub5T8QsdyamJxuO
         /n+BccfPxaMArGyTYHwpygk5h7daEOlMqE+rTWwN3OmATSyGMFbGtMRrQzbsxDAA4QmF
         +J8KYJjyC5QNBF3WFuA0RqZkF6D0M20MUT8u9s+s2j8mup6f1dlznBqN6XE6HwMi/nlK
         5F1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MTUHQ0XBMKYjCMxTR8J9NyW/tLEmYUh7AnhEaRP63mA=;
        b=ADYgnZYrJpxD2qZC5zyK8K9ebwadVNtDKvkdjRPMaSko8Nx6WMvHapSXmynWrLQusf
         A3MaBI2/XtQW8oBLn8Wg2UNXGrbHIpVr01RGXnLYwUdlu5iCU5T+y606Vr68mu8b/8yf
         TY2TznT78+nKX6wj8Y3XzQrLM3Hgt3NdggOyGFaOYdPyCpeR/XeS9DteoBp1d4oqruTt
         WTyrrXCKjxIWFJhiNGstqYMnBbVegpWVdXsP1JYjZhfl0m8Bwj+kauUUM+uGbAQLd7yR
         AquGTAkeY63v7ZzaN7yLw+nPyfNw2fzp1PMgN8oVqQaOcblDdm6d1PnEETC/qnxuu1sI
         zdwg==
X-Gm-Message-State: APt69E1qGQT/JQbrZA/X0tvNVpnlRJ41IQxoecPA5GvQ2dWbBuSXJmW8
        Dla+kPNLsprbx0yjvmjbSA+LrA==
X-Google-Smtp-Source: ADUXVKIHMptzwIlHtmq3L5nT3k0OE4sliM7L/hElt2FYKdW30Lc7xEQxswWnV89OBxi2N8xHWURcdQ==
X-Received: by 2002:a17:902:5ac3:: with SMTP id g3-v6mr3771398plm.90.1530060386618;
        Tue, 26 Jun 2018 17:46:26 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 5-v6sm872738pfd.11.2018.06.26.17.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 17:46:26 -0700 (PDT)
Subject: Re: [PATCH V5 3/5] ARM: dts: stm32: add iwdg2 support for stm32mp157c
To:     Ludovic Barre <ludovic.Barre@st.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
 <1529941383-8653-4-git-send-email-ludovic.Barre@st.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a9fb5eaf-f76b-2fc4-e027-12712b3af589@roeck-us.net>
Date:   Tue, 26 Jun 2018 17:46:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529941383-8653-4-git-send-email-ludovic.Barre@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 08:43 AM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch adds independent watchdog support for stm32mp157c.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

Presumably this and the following patches will be pushed upstream
through an ARM tree.

Guenter

> ---
>   arch/arm/boot/dts/stm32mp157c.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index 7d17538..95cc166 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -784,6 +784,14 @@
>   			status = "disabled";
>   		};
>   
> +		iwdg2: watchdog@5a002000 {
> +			compatible = "st,stm32mp1-iwdg";
> +			reg = <0x5a002000 0x400>;
> +			clocks = <&rcc IWDG2>, <&rcc CK_LSI>;
> +			clock-names = "pclk", "lsi";
> +			status = "disabled";
> +		};
> +
>   		usbphyc: usbphyc@5a006000 {
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> 

