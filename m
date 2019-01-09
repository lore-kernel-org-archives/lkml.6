Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A614C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E6B206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tayYLBcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfAIVXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:23:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37502 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfAIVXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:23:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id s12so9170772wrt.4;
        Wed, 09 Jan 2019 13:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WyVu/NRnECiTL/w0ho0hXwTO7iGZz3QvzPjqC/1ztOw=;
        b=tayYLBcYo1buPFxv18lL4G72eGTiAm5yaFYhHNzn8u0nv5K1+Jxu4263g5fhhjSL3Z
         Cg0rD+apwzXMe7emcmVGz5Ff+g8OcmfWjWL3OuNUIXmS0dHTT45h4tYfvPF4xFNtDV8p
         HOt1OQPV95dcDJ3vN1psVUUYF0Z4IrYK5pgjosaMLXEYGXzXHoevEh4LcgPzbbStRtVr
         kRmDfWoKM2lpLhBZXl7cds58Xcdq8/gCoUF9diOi3eqgipJzkJsXVfq6ohy073G1gz9F
         NVh1FTXCBWW+E/JoOXROYQjqlwW9Py+XPbkCOQNFeWp+G+CuY/bs3zb3f49Ect1T1qvh
         o/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WyVu/NRnECiTL/w0ho0hXwTO7iGZz3QvzPjqC/1ztOw=;
        b=A1bamjXH4ORmSHRCNyZMlORXSP3Qxp8Qiq7uaiNeA4SmFtiIEgS4rTtDZHalPa7W38
         x2n9940KLRvCXr1WLXws0b0fvPMzdGoFMcs2Eozrf+BXyp5WGRGQ9jLzVELlKRk3BW7s
         7hagmHqMhciuYnp95WIaDqUrxQ+ZlS7TarL1rgRcqy9yMmawGKuiC/+TjbHZGi4j79Q1
         yqIJrIYR5OIAH5+G6WeNviIVbFV7ip/aGBM2RdIYz+WmFvViAkeiqMxeDOt9R50ClfSC
         JifBBTDVj5zaGDszar5HtP0bsxgw1u9GIX5oNrHF916napckclff23fDslr5Z46OhbQV
         3avQ==
X-Gm-Message-State: AJcUukeKCHAWlnmVQR7kx4XCoFkyEUUUmvo8oAGFp3eS3gWrVnrIJtGZ
        GSwtu1H/uWk19K2PVGupLnB+UYvQ
X-Google-Smtp-Source: ALg8bN7KREseP0Zu9iaCDKbIB2bk1qGw36C/XatkyKI3FOdBzvCo1bp1qHIgRRMs8bNID/FSYXVZUw==
X-Received: by 2002:adf:81b6:: with SMTP id 51mr6879686wra.240.1547068983784;
        Wed, 09 Jan 2019 13:23:03 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id l20sm122848439wrb.93.2019.01.09.13.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 13:23:02 -0800 (PST)
Subject: Re: [PATCH v5 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mason Yang <masonccyang@mxic.com.tw>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1546921020-20436-1-git-send-email-masonccyang@mxic.com.tw>
 <1546921020-20436-2-git-send-email-masonccyang@mxic.com.tw>
 <74a5fba6-a77e-f71b-ce49-405fee8e0fda@cogentembedded.com>
 <CAMuHMdUPsN-VMhbttVK19gL_nPdaCTHHC7Dn3ajPoVhMqDJf_w@mail.gmail.com>
 <a4373a7f-07c4-baff-30a3-d1f5a294e1bb@cogentembedded.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <fcfcdc30-965e-ec63-17ce-006c500963d9@gmail.com>
Date:   Wed, 9 Jan 2019 22:23:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <a4373a7f-07c4-baff-30a3-d1f5a294e1bb@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/19 8:04 PM, Sergei Shtylyov wrote:
> On 01/09/2019 09:49 PM, Geert Uytterhoeven wrote:
> 
>>>> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
>>>>
>>>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>>>
>>>    You now need to add:
>>>
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>>>> --- a/drivers/spi/Kconfig
>>>> +++ b/drivers/spi/Kconfig
>>>> @@ -544,6 +544,12 @@ config SPI_RSPI
>>>>       help
>>>>         SPI driver for Renesas RSPI and QSPI blocks.
>>>>
>>>> +config SPI_RENESAS_RPC_IF
>>>
>>>    Since the driver is called without -IF suffix, I wouldn't use it in the
>>> Kconfig name either, the following is enough:
>>>
>>>> +     tristate "Renesas R-Car Gen3 RPC-IF SPI controller"
>>>> +     depends on ARCH_RENESAS || COMPILE_TEST
>>>
>>>    Judging on the compilation error reported by the 0-day bot about readq(),
>>> we now need to depend on 64BIT or something...
>>
>> IIRC, this hardware block is also used on RZ/A, which is 32-bit.
> 
>   I'm not seeing it in the "RZ/A1H Group, RZ/A1M Group User’s Manual: Hardware"
> Rev 3.00. What SoC did you have in mind?

At least the GR Peach boots from this block, so that one :)

-- 
Best regards,
Marek Vasut
