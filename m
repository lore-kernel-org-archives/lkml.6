Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A53C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848DF20837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QURjiv/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848DF20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbeLGQbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:31:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36672 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbeLGQbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:31:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id u3so4393879wrs.3;
        Fri, 07 Dec 2018 08:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=teCa7RVUOAmvKrf5c7GaoQcfS9eegjTNzbq90mGFt78=;
        b=QURjiv/JGYL0XOneHDa7CqmgSBHb7SwULhz3iOSzj3AloTCqc0swf5TiNEkahIR5+O
         Qc5nmEfhO8IyfXsaEER0aReo1jouxbI4CM8g2r8/C3wJOaVhxG7Kd1+PQH+utdFqX80j
         GortzKj7WlHStGch9rh9ct864Zkr5TmPl4bA2+39b4Ycxo3h1SS2oZ+x0/AEDZBbZBop
         RNcEHyMetwjsr9scGOtOV2twDNVEtiXTm7HjYawFvjrp4LvlmcJk0B+Uq64JbCqtIz2V
         J+GJA8UsOIgIGrDt3FTJ+c/v8hz1WZet2XzYmYnoqM4Ww/FByLB/KN+1qxGDXjgbqaA/
         NQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=teCa7RVUOAmvKrf5c7GaoQcfS9eegjTNzbq90mGFt78=;
        b=S8D79MXR5uAq6lUhnLxT7gg/WQRNiTCNCMn5m5fmkr/xXq2mU8GyKK6LePnMawn7S4
         2hVyTh6SPyJWe+zll4U3BPalFxOBNooYtJzVZG/B+eHeBJV6m5OfTCDlf3CBk8VLAOgd
         rihY5ThW/CWdXgBabZ72MEej5/3EOdrVnwdh36LO02Tx6ruu1t7QzDkEoFsjxWJKHBke
         QWva4r/hideMGcQlcj12YJTQXzby39s98iQH49O55HsugkzNXkQxYn5NOAArOz2i6oFj
         L2EV00kjgBQv1BFr6HiwC6sHavYEQJl0F6ytrNZCi7icsLWM3/FxgeJBBoXRVkhF/9W/
         64zA==
X-Gm-Message-State: AA+aEWYNozAdPBFejIh3vjbbf/lHMx1fhnScY81UDRCEI+bsurPESDOy
        jVsQwHrKAJTce62m9aP0lZ3IhJrT
X-Google-Smtp-Source: AFSGD/XD7FDjNf5BoEdGl5R78oT7jWEqS+Jdf3zqFH3+Vjuy4H/41RZYwTZ8SZJ7mXAOeKIyO12+Dg==
X-Received: by 2002:adf:f984:: with SMTP id f4mr2413307wrr.234.1544200275999;
        Fri, 07 Dec 2018 08:31:15 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id p74sm5525772wmd.29.2018.12.07.08.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 08:31:15 -0800 (PST)
Subject: Re: [PATCH v3 2/2] dt-binding: spi: Document Renesas R-Car Gen3 RPC
 controller bindings
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        boris.brezillon@bootlin.com, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1544181199-3373-1-git-send-email-masonccyang@mxic.com.tw>
 <1544181199-3373-3-git-send-email-masonccyang@mxic.com.tw>
 <b89fb13a-4fe2-d3ca-7e12-7ac6b11455f6@cogentembedded.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <8564903b-b162-a451-296e-be3ec199e248@gmail.com>
Date:   Fri, 7 Dec 2018 17:31:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <b89fb13a-4fe2-d3ca-7e12-7ac6b11455f6@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2018 05:03 PM, Sergei Shtylyov wrote:
> Hello!
> 
> On 12/07/2018 02:13 PM, Mason Yang wrote:
> 
>> Document the bindings used by the Renesas R-Car Gen3 RPC controller.
>>
>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> ---
>>  .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 38 ++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>> new file mode 100644
>> index 0000000..a191f70
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>> @@ -0,0 +1,38 @@
>> +Renesas R-Car Gen3 RPC controller Device Tree Bindings
>> +------------------------------------------------------
>> +
>> +Required properties:
>> +- compatible: should be "renesas,r8a77995-rpc"
>> +- #address-cells: should be 1
>> +- #size-cells: should be 0
>> +- reg: should contain 2 entries, one for the registers and one for the direct
>> +       mapping area
>> +- reg-names: should contain "rpc_regs" and "dirmap"
> 
>    Please drop this "rpc_" thing, I think "regs" should be enough.
> 
>> +- interrupts: interrupt line connected to the RPC controller
>> +- clock-names: should contain "clk_rpc"
> 
>    Please drop this "clk_" thing. BTW, what's with the RPCD2 clock?
> 
>> +- clocks: should contain 1 entries for the module's clock
>> +- rpc-mode: should contain "rpc-spi-flash" for rpc spi mode or
>> +			   "rpc-hyperflash" for rpc hyerflash mode.
> 
>    I think the prop should be called "renesas,rpc-mode" and the values should be
> just "spi" and "hyperflash". 

Like I said before, you can determine the mode from the subnode attached
to the controller, we don't need special prop for that.

-- 
Best regards,
Marek Vasut
