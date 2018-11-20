Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF80C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2AB120831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvplhKWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2AB120831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbeKTX0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:26:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51678 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeKTX0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:26:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id w7-v6so2035471wmc.1;
        Tue, 20 Nov 2018 04:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5V2wJzlxizmJBJaoI+y/R49gu7muKz7LqFHd4gJ4kWc=;
        b=FvplhKWHqO2cR5qTCRwvMw5uFZ58Z6Sg/VdPoITECtPGMQT4HbVG452INnVBBytvJO
         7XNkrkiHIftLchTdxztqBbngEMA8WXsM0+k8FsBTisQgLzFnPHBI8R5RcH/lkFR8laEj
         s0BTl8RjbgevqBYSgGrG4YU7k+EOFSpP19YSo+5haIIBtOajTkzYmFEopJCT8363H75X
         q2KWP8F3y1BSjnRDxbMOtb4KDiV7QaNBvaY5hVF4aUynzE/DtbhX5sBbVUI87A9Dsgpk
         s5B5xA9gzyHM3rb7L3dU31oboPOtsNgYmfjMWX7H2ocUG3vfdDveK5xpwo6QLGeQGrSU
         /uQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5V2wJzlxizmJBJaoI+y/R49gu7muKz7LqFHd4gJ4kWc=;
        b=kUR4W+Hnmph7Qqqmpb13GynuhHhUi93ZV/p8tmSt+OPm2lSTpRPYyvkfwdds1DbukD
         AVtk0e7T+CZk71bCqRw+mt3n8PsT+rcvCtytk977fjMq0JbZWxr+Ng1VQtrZnHOV0eZr
         Lzw7CpamHj1tE4yMonydnS0JaUmxyN1HxVqtK6/VQVKTdFrlPxp4kumPDtyRbhiHlodl
         zUfVKPfZVVVzoYnw4ZfR2AuqySxzZJ2evsNYRfFFtj+PivbrnS9SA3NeSI4ZG8HriBNw
         3Gs8JKI2VpoWlRjER87sjQJWmvwgJyWJf7FykT3Zm2zraCzsFtdo7O7b3nktrKv+FcFz
         l4tw==
X-Gm-Message-State: AA+aEWbkl5RAGAEQsYbjRTn3LLBp7tJzfOr5qK9nHlVXAQ17YJJjoJQg
        pHVV588ZeytcHp8qaUOMsDE=
X-Google-Smtp-Source: AJdET5feUV6k78SURQTtq8993lqT8Euf4g38oqIeQwUvKWGuECTf5ChFKSP69ev3NjZ3u/h/FQR8zg==
X-Received: by 2002:a1c:e513:: with SMTP id c19mr2182852wmh.101.1542718642573;
        Tue, 20 Nov 2018 04:57:22 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id i7-v6sm49960532wrb.3.2018.11.20.04.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 04:57:21 -0800 (PST)
Subject: Re: [PATCH 2/2] dt-binding: spi: Document Renesas R-Car RPC
 controller bindings
To:     masonccyang@mxic.com.tw
Cc:     boris.brezillon@bootlin.com, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, tpiepho@impinj.com,
        zhengxunli@mxic.com.tw
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
 <1542621690-10229-3-git-send-email-masonccyang@mxic.com.tw>
 <629a5d6f-5c13-9b24-1c21-461d09f1aa8a@gmail.com>
 <OFDD04CD59.10199EDD-ON4825834B.001E1390-4825834B.001F65DD@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <e7fd0653-75a7-249a-462a-18a7bf4616d1@gmail.com>
Date:   Tue, 20 Nov 2018 13:57:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <OFDD04CD59.10199EDD-ON4825834B.001E1390-4825834B.001F65DD@mxic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/2018 06:42 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,
> 
> Marek Vasut <marek.vasut@gmail.com> 已在 2018/11/19 下午 09:49:31 上寫入:
> 
>> Marek Vasut <marek.vasut@gmail.com>
>> 2018/11/19 下午 09:49
>>
>> To
>>
>> Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
>> tpiepho@impinj.com, linux-kernel@vger.kernel.org, linux-
>> spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman
>> <horms@verge.net.au>,
>>
>> cc
>>
>> boris.brezillon@bootlin.com, juliensu@mxic.com.tw, Geert
>> Uytterhoeven <geert+renesas@glider.be>, zhengxunli@mxic.com.tw
>>
>> Subject
>>
>> Re: [PATCH 2/2] dt-binding: spi: Document Renesas R-Car RPC
>> controller bindings
>>
>> On 11/19/2018 11:01 AM, Mason Yang wrote:
>> > Document the bindings used by the Renesas R-Car D3 RPC controller.
>> >
>> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> > ---
>> >  .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 33 +++++++++
>> +++++++++++++
>> >  1 file changed, 33 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/spi/spi-
>> renesas-rpc.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-
>> rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>> > new file mode 100644
>> > index 0000000..8286cc8
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>> > @@ -0,0 +1,33 @@
>> > +Renesas R-Car D3 RPC controller Device Tree Bindings
>> > +----------------------------------------------------
>> > +
>> > +Required properties:
>> > +- compatible: should be "renesas,rpc-r8a77995"
>> > +- #address-cells: should be 1
>> > +- #size-cells: should be 0
>> > +- reg: should contain 2 entries, one for the registers and one
>> for the direct
>> > +       mapping area
>> > +- reg-names: should contain "rpc_regs" and "dirmap"
>> > +- interrupts: interrupt line connected to the RPC SPI controller
>>
>> Do you also plan to support the RPC HF mode ? And if so, how would that
>> look in the bindings ? I'd like to avoid having to redesign the bindings
>> later to handle both the SPI and HF modes.
>>
> 
> I patched this RPC SPI/Octa driver is for mx25uw51245g and you may also
> refer to Boris's patch. [1][2][3]

Does this mean the driver is specific to one particular kind of flash ?

> [1] https://patchwork.kernel.org/cover/10638055/
> [2] https://patchwork.kernel.org/patch/10638057/
> [3] https://patchwork.kernel.org/patch/10638085/


-- 
Best regards,
Marek Vasut
