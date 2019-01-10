Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9827FC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BE320879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFdqqCWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfAJNnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:43:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34545 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbfAJNnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:43:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so11478321wrw.1;
        Thu, 10 Jan 2019 05:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PUNNiqlsfxrP3NkRtGyXhshMaWx6PTZbvwB96bcU1Lg=;
        b=JFdqqCWlhNMscDh/C8RTQe9QCxF4ZqHajcjf6OKNOUDyw8dxST2TEeACBbI7YByAM4
         0ABzSAhTjiV06Dv/K5zQS6tEas4bSymHqDBdhWyd18SiRX4clXyst0XNGTs2sBKMlI4y
         tZxXrAKDlXluOICs5vs27TmkS3s8sofT+PeXhDA+Q+tesDV5dw8pSfrEtgWvokYbV8De
         mRYKs5ZRh3tT4IesFpXhT6KiJilgR8pYOIo40U9Vri9h1psHW5LQBJB5MwAGGR4lQ7OD
         /EoUjXjgq5YbQHAF0+fhJ8DU9VGrtVJCDuWnkkitmuzymlnAan8AyZ7mcN518fyotbRg
         xiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PUNNiqlsfxrP3NkRtGyXhshMaWx6PTZbvwB96bcU1Lg=;
        b=AOH+5EBO3L1S7JQeHdMGnpAktPbaMpTErH9D/xWVS+ia2bbZL+deYIFaPVYrp9s83E
         n2B4CiCZ1XMC3t2HH8KUEUcF9kn7F2KwiFZ5cGFZOJMUYjEF1YAAINvRdPtmK2U744bx
         8Q3DBP8lhavlCvcB2cSFDarb1rAx/rmo+vLepFly0tSVeYs054Aj4ewsac/q6aUCCkkz
         ILIYEDLnGJHQCGgCBnIl6YV6fotj0ssZIrVY4DWayXSblV6LGyXKOB/kXAr1j0aQMuGu
         2bnee5Dfio95z67Rev038degn7JcCQQLrIXrvWZfFeBJXRgF4BDjuHnHtnaZT5SYqvjR
         kxZg==
X-Gm-Message-State: AJcUuke8gHZf3zRTDoAYO70q0hkQpMKcyDw2C19R8qb8FLlkS8XK3hx7
        fSB9TjU0WS9pQl+/QJungng=
X-Google-Smtp-Source: ALg8bN7WhOA1gcALjAc7Y/LLZiFB0ZKKO9d+h8gOgTwneQJkk9RotD6HFS/2L8r0GoVdBQigRl1DNg==
X-Received: by 2002:adf:df01:: with SMTP id y1mr9689733wrl.127.1547127828554;
        Thu, 10 Jan 2019 05:43:48 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id y13sm8963319wme.2.2019.01.10.05.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 05:43:47 -0800 (PST)
Subject: Re: [PATCH v5 2/2] dt-bindings: spi: Document Renesas R-Car RPC-IF
 controller bindings
To:     masonccyang@mxic.com.tw
Cc:     boris.brezillon@bootlin.com, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        zhengxunli@mxic.com.tw
References: <1546921020-20436-1-git-send-email-masonccyang@mxic.com.tw>
 <1546921020-20436-3-git-send-email-masonccyang@mxic.com.tw>
 <05c8e4ac-a9c8-7c24-289f-ce7a089dbc1e@gmail.com>
 <OFD1D4749F.04B5A6A1-ON4825837E.00331D68-4825837E.00344CA0@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <85882d18-9b05-5cc9-105d-093ae7cf0041@gmail.com>
Date:   Thu, 10 Jan 2019 14:43:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <OFD1D4749F.04B5A6A1-ON4825837E.00331D68-4825837E.00344CA0@mxic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/19 10:31 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,

Hi,

>> "Marek Vasut" <marek.vasut@gmail.com>
>> 2019/01/08 下午 08:06
>> > diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-
>> rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>> > new file mode 100644
>> > index 0000000..5f96532
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>> > @@ -0,0 +1,37 @@
>> > +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
>> > +----------------------------------------------------------
>> > +
>> > +Required properties:
>> > +- compatible: should be "renesas,r8a77995-rpc"
>> > +- #address-cells: should be 1
>> > +- #size-cells: should be 0
>> > +- reg: should contain 2 entries, one for the registers and one
>> for the direct
>> > +       mapping area
>> > +- reg-names: should contain "regs" and "dirmap"
>> > +- clock-names: should contain "rpc"
>> > +- clocks: should contain 1 entries for the module's clock
>> > +- renesas,rpc-mode: should contain "spi" for rpc spi mode or
>> > +                  "hyperflash" for rpc hyperflash mode.
>>
>> Why do we need this property ? I believe it is possible to detect the
>> configuration based on the type of child of the RPC node. If the driver
>> was properly designed, it could well behave as either CFI NOR driver or
>> SPI flash driver and all would be good, but it seems this is written
>> with it being SPI flash driver only and once the HF mode would need to
>> be added, it'd mean a tremendous undertaking to rework the entire driver.
>>
> 
> Except to check if there are any SPI NOR child nodes by "jedec,spi-nor"
> compatible, is any other way better ?
> 
> any suggestion is welcome.

That's the one. A MFD RPC driver can sanitize it's child nodes, verify
that the config is valid and configure the RPC accordingly. All of the
devices that can be connected to the RPC are either valid jedec-nor or
CFI NOR (HF), so this should work fine.

-- 
Best regards,
Marek Vasut
