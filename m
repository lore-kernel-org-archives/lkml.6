Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDDEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD282086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="NStDoSwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfARIX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:23:57 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44575 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfARIX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:23:56 -0500
Received: by mail-lf1-f66.google.com with SMTP id z13so9831663lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 00:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0SJSH6bRMwHp7RYCoARq1uayXqt1+9KD9XSAanMXm5s=;
        b=NStDoSwR4lZoklec+1xfN9wJBQtVLHEHs79uK3qqhgFCRfFD7FVzm4FLI4YuVRo87g
         RB2PQIdE7WaVFFzDhDPtyqag+njVDGUCT5emScC7CI/AJCoEuyeHMBzZ3kDjFOV9dxhz
         g0mg/7eqMJEJOjaI2WDRYyzIgjCOfGxbUaik6fmgtq32KH7m9rR+4ncOL/PG6fStgpuL
         Z6vXrj5K6EUloOsvJ47e/ubBGd3VTcUxOzdPoI8RZyHgAMh+iRaE5blhvISSOHfxf0zd
         9NVFLhUvjVYzzXz6xL+3NpvGn+A6QPSLHOLI87+DwroPrtUMhEcI8ECNDbs69fIXZX7I
         uWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0SJSH6bRMwHp7RYCoARq1uayXqt1+9KD9XSAanMXm5s=;
        b=sA28zBvhdsz/vOlsFYqz1o1JE/Y+6An8WfJPulVGHIpU9qtE8O7IeOshQULvKqbBsT
         Q4RiMYXhHH/6KinrN0dIlyHaGppkobt77q89QxQM8ukPhqGvuKT1DOS2hdgvPO/GMukY
         ZS5xLO1/V9DvbfUNJoqhSY41ap60IHIewZiyaKo1oABhSs5G76S1pb3kJjVoEX6laks7
         b8015KJZI3DWzh6az/ATRnV6iFukhAlIxDHmBjlBODNQrTMwKIsZyMiDMrbxJ9rmLzXi
         YXiP5PI9xevio9H/lAlvCQokj2TEplnzLnvxK3Z5hMSIsAEJA8JUjskuJ1nKJVPSbWXJ
         BlZQ==
X-Gm-Message-State: AJcUukfdyAV5rzElzp7NfIyKYYL28kmaTSrawR8S7wFiGbv2SndPMSEe
        BtPJqMhAUnYI/OOKW3HU+JgxYw==
X-Google-Smtp-Source: ALg8bN4hOoDacLNurKvmhF7eDPeHuNSme1TlaKyPN/plT6NUA2CJRa/tnyMWDWZiwyVmMr9IY+ThoQ==
X-Received: by 2002:a19:982:: with SMTP id 124mr11597098lfj.138.1547799834695;
        Fri, 18 Jan 2019 00:23:54 -0800 (PST)
Received: from [192.168.0.199] ([31.173.87.239])
        by smtp.gmail.com with ESMTPSA id p21sm690912lfj.10.2019.01.18.00.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 00:23:53 -0800 (PST)
Subject: Re: [PATCH v6 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
To:     Marek Vasut <marek.vasut@gmail.com>,
        Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1547790855-22120-1-git-send-email-masonccyang@mxic.com.tw>
 <1547790855-22120-3-git-send-email-masonccyang@mxic.com.tw>
 <8367577a-9717-92e3-cbc8-8dee52876bcb@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <e3843856-fe6b-dfea-ffbe-07398aabc4cf@cogentembedded.com>
Date:   Fri, 18 Jan 2019 11:23:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8367577a-9717-92e3-cbc8-8dee52876bcb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 18.01.2019 9:16, Marek Vasut wrote:

>> Document the bindings used by the Renesas R-Car Gen3 RPC-IF controller.
>>
>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> ---
>>   .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 37 ++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>> new file mode 100644
>> index 0000000..9b5001e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>> @@ -0,0 +1,37 @@
>> +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
>> +----------------------------------------------------------
>> +
>> +Required properties:
>> +- compatible: should be "renesas,rcar-gen3-rpc"
>> +- #address-cells: should be 1
>> +- #size-cells: should be 0
>> +- reg: should contain three register areas:
>> +	first for the base address of rpc-if registers,
>> +	second for the direct mapping read mode and
>> +	third for the write buffer area.
>> +- reg-names: should contain "regs", "dirmap" and "wbuf"
>> +- clock-names: should contain "rpc"
>> +- clocks: should contain 1 entries for the module's clock
>> +
>> +Example:
>> +
>> +	rpc: rpc@ee200000 {
>> +		compatible = "renesas,rcar-gen3-rpc";
>> +		reg = <0 0xee200000 0 0x7fff>, <0 0x08000000 0 0x4000000>,
> 
> 0x7fff should be 0x8000 , right ?

    Even 0x200.

> 
>> +		      <0 0xee208000 0 0x100>;
> 
> Isn't the write buffer part of the RPC-IF register set ?

    No, if you look into the manual.

MBR, Sergei
