Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11076C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995FE265BE
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmiPsqB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995FE265BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934476AbeF0Ar0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 20:47:26 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43025 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752416AbeF0ArY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 20:47:24 -0400
Received: by mail-pl0-f65.google.com with SMTP id c41-v6so149705plj.10;
        Tue, 26 Jun 2018 17:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DgE5NRPFkiYJ92yGu12zQZkSQyBjvgJQ3YJF/NEK/d0=;
        b=UmiPsqB3r91oCOtXA5/dHvbNt6QjQBjmWSol5kWevjIFzHvGsdxDV7zm42/7go4GiT
         z3biTv6mbh3daojbuopuiSgfwFvYKQRk0fLXQW09kAsZPpo/OcyOgACjgMpl7LmbP3VI
         w8mePZDGzwhEN49fBbmoM/85KktBDxqBcM5eN6hXm0ug9psA631OPXdwBno46q1QSPtS
         bZvasTiHiUAHxxIRMxZdRixMWyq+nUfgtas99BAfUR4clZRL7xwBm+DaSNTSswi2Brak
         xRQwhBYIX6igV3ZzpuhmH0Z26DZbtdYizFf3BQWExUlYk5tgv3y7GlSak6HzcWo+G59D
         q8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DgE5NRPFkiYJ92yGu12zQZkSQyBjvgJQ3YJF/NEK/d0=;
        b=YF/P4+wUtGRBYizpAa0wTvVNF5M9ALzLmxB4YDdg+mbLqjxtV2c67yqgvawkWJf+65
         OpzaL84yQq633PGhkjZsSDn94c1H8l/TuymvNYmWkiJYgCMeN21jwKmv6jROn3gBob/j
         JZ+39XVk57DQ+o2Eyv0wON9oKGdtRw5AqHVyZH8vDmTDsuhrIuJZO9zET4TkUSmkWepb
         IXUUq+ZqwyoqNYS2J5aHvT/4xFCdyjWk3Ev8QtLpBtUQJKO8AsPZ+Xi0+P+NizX5z+AS
         n0wrMz54znd8wN2gtuCw0+wOAZW4aXhaST2riENbrHgEVrjjNrjuCbokg6WYz+eYDoaR
         sozg==
X-Gm-Message-State: APt69E0LZH8IfA1/uNAqo//uoyiPGcDASC3azbFa7YjxMne3LHodW+Kn
        acK2gd+nwBdVXGCno9+u56UaQQ==
X-Google-Smtp-Source: ADUXVKKvvinNhS7O4Fkl9fzTqvcBjBD6KzyrCbU6mwM9y3emY6x9X/CJ966E0YKdu919ugaiTgwi1w==
X-Received: by 2002:a17:902:758e:: with SMTP id j14-v6mr3743129pll.160.1530060443902;
        Tue, 26 Jun 2018 17:47:23 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id v27-v6sm4193428pfi.23.2018.06.26.17.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 17:47:23 -0700 (PDT)
Subject: Re: [PATCH V5 5/5] ARM: dts: stm32: update iwdg with lsi clock name
 for stm32f429
To:     Ludovic Barre <ludovic.Barre@st.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
 <1529941383-8653-6-git-send-email-ludovic.Barre@st.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <1f13d8f9-3459-c91c-6cb6-041504ac16e6@roeck-us.net>
Date:   Tue, 26 Jun 2018 17:47:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529941383-8653-6-git-send-email-ludovic.Barre@st.com>
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
> This patch updates iwdg watchdog to use lsi clock name.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/arm/boot/dts/stm32f429.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index ede77e0..39ea13a 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -310,6 +310,7 @@
>   			compatible = "st,stm32-iwdg";
>   			reg = <0x40003000 0x400>;
>   			clocks = <&clk_lsi>;
> +			clock-names = "lsi";
>   			status = "disabled";
>   		};
>   
> 

