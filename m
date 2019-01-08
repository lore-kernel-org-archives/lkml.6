Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBD9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A56A217D9
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGsSvTBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfAHVQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:16:56 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43397 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbfAHVQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:16:56 -0500
Received: by mail-lj1-f194.google.com with SMTP id q2-v6so4644875lji.10;
        Tue, 08 Jan 2019 13:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ffJA1v8eqqAiOla1ZUJvfK0j0opKkLQDfgNuSvF6Syc=;
        b=qGsSvTBKLSAfIumtgdwAgQWYF1ycQgcNi1inWn41zbCrl0plvnwxzZxtR6MJz8QgOj
         9HgxziD3aggXUdsVuXn6rO4E/7Riu32iHUcpL3gTFWCRwfCQv/snnFeNncZQHPauTOO5
         DZ4kCr7YRbi3RCqFD/V3IN6gF3nGdwb72W7bifVKLYSkGbqRWC1R/+GwnjEi8zP7ID3q
         xdkbfkh2YXsaWNb2/PXql38cjDb3KCG6Db7/fL/SpECV/0nv+TMG/Xe2Um/yJgy4uWXV
         odjwVV8ya8bo9JPnoQ/+OR2Aq/4xV5BO00qW4Iz4zOgeQg38MoRzSTOfPlg2mUZaC4i7
         eUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ffJA1v8eqqAiOla1ZUJvfK0j0opKkLQDfgNuSvF6Syc=;
        b=lQVpcG71MCfGa1o7XWilJrn+LW9F3HtSI9Ehirvyz7f5DxDsMnRa7sHkjUZKfcd5ck
         Gd4QPV8E0VnBFXeypZms34VXEGF3GHRtD6Cef1szzQfgJLbpAqDFU2tiJa3ktvBXbKZQ
         vyhuYGLv9cdYDxs0nJAKWgbk/sHeHsGZgJVliZUWHbVgMFaOX6aLnFIcX+ee4qMEeUOq
         GqbQXRS9/MNkDzQBKSlvtDseUciKxFhTpmxHKz5rJdKWFeLvcfbwD7Wk6RN9Ra3X0STy
         J43q5CgYTX1KhAd2l4oaKozLiRy/yfwNYETh5ai64/blYY6+Xms3E01PpTYVv0xaWtvF
         q2sg==
X-Gm-Message-State: AJcUukenfimJWwXxwD/k8v8EgneAOfYw68KcnpMRFz+MsF7B++/vxMoe
        axazGKiSbESrhkMiHpnlpGEwQE8K
X-Google-Smtp-Source: ALg8bN4mbFT7AVhu3y2zAQay33dgb87lZf6hBuyWUP0i803Z8bY3Tcy2Yb8hb7kaEofDfpF1TFoAbQ==
X-Received: by 2002:a2e:612:: with SMTP id 18-v6mr1892244ljg.125.1546982211642;
        Tue, 08 Jan 2019 13:16:51 -0800 (PST)
Received: from [192.168.1.18] (dlx201.neoplus.adsl.tpnet.pl. [83.24.53.201])
        by smtp.gmail.com with ESMTPSA id 185-v6sm11840516ljj.49.2019.01.08.13.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 13:16:51 -0800 (PST)
Subject: Re: [PATCH 1/2] dt: bindings: lp5024: Introduce the lp5024 and lp5018
 RGB driver
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20181219162626.12297-2-dmurphy@ti.com>
 <dc2283f9-db85-1eaf-f046-3fbbd4adcace@gmail.com>
 <2d2d5dcd-9c23-e901-daac-9b79aa5a5e82@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <6c62956e-7789-58ba-5437-f2e033f2825c@gmail.com>
Date:   Tue, 8 Jan 2019 22:16:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2d2d5dcd-9c23-e901-daac-9b79aa5a5e82@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/19 9:53 PM, Dan Murphy wrote:
> Jacek
> 
> On 1/8/19 2:33 PM, Jacek Anaszewski wrote:
>> Dan,
>>
>> On 12/19/18 5:26 PM, Dan Murphy wrote:
>>> Introduce the bindings for the Texas Instruments LP5024 and the LP5018
>>> RGB LED device driver.  The LP5024/18 can control RGB LEDs individually
>>> or as part of a control bank group.  These devices have the ability
>>> to adjust the mixing control for the RGB LEDs to obtain different colors
>>> independent of the overall brightness of the LED grouping.
>>>
>>> Datasheet:
>>> http://www.ti.com/lit/ds/symlink/lp5024.pdf
>>>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>>>    .../devicetree/bindings/leds/leds-lp5024.txt  | 63 +++++++++++++++++++
>>>    1 file changed, 63 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/leds/leds-lp5024.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/leds/leds-lp5024.txt b/Documentation/devicetree/bindings/leds/leds-lp5024.txt
>>> new file mode 100644
>>> index 000000000000..9567aa6f7813
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/leds/leds-lp5024.txt
>>> @@ -0,0 +1,63 @@
>>> +* Texas Instruments - LP5024/18 RGB LED driver
>>> +
>>> +The LM3692x is an ultra-compact, highly efficient,
>>> +white-LED driver designed for LCD display backlighting.
>>> +
>>> +The main difference between the LP5024 and L5018 is the number of
>>> +RGB LEDs they support.  The LP5024 supports twenty four strings while the
>>> +LP5018 supports eighteen strings.
>>> +
>>> +Required properties:
>>> +    - compatible:
>>> +        "ti,lp5018"
>>> +        "ti,lp5024"
>>> +    - reg :  I2C slave address
>>> +    - #address-cells : 1
>>> +    - #size-cells : 0
>>> +
>>> +Optional properties:
>>> +    - enable-gpios : gpio pin to enable/disable the device.
>>> +    - vled-supply : LED supply
>>> +
>>> +Required child properties:
>>> +    - reg : Is the child node iteration.
>>> +    - led-sources : LP5024 - 0 - 7
>>> +            LP5018 - 0 - 5
>>> +            Declares the LED string or strings that the child node
>>> +            will control.  If ti,control-bank is set then this
>>> +            property will contain multiple LED IDs.
>>> +
>>> +Optional child properties:
>>> +    - label : see Documentation/devicetree/bindings/leds/common.txt
>>> +    - linux,default-trigger :
>>> +       see Documentation/devicetree/bindings/leds/common.txt
>>> +    - ti,control-bank : Indicates that the LED strings declared in the
>>> +                led-sources property are grouped within a control
>>> +                bank for brightness and mixing control.
>>> +
>>> +Example:
>>> +
>>> +led-controller@28 {
>>> +    compatible = "ti,lp5024";
>>> +    reg = <0x28>;
>>> +    #address-cells = <1>;
>>> +    #size-cells = <0>;
>>> +
>>> +    enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>>> +    vled-supply = <&vbatt>;
>>> +
>>> +    led@0 {
>>> +        reg = <0>;
>>> +        led-sources = <1>;
>>> +    };
>>> +
>>> +    led@1 {
>>> +        reg = <1>;
>>> +        led-sources = <0 6>;
>>> +        ti,control-bank;
>>
>> Do you really need ti,control-bank? Doesn't led-sources array size
>> greater than 1 mean that the node describes control bank?
>>
> 
> That will work too.

>> Also, does it make sense to have only two LEDs in the bank?
> 
> The array can populate all 7 LEDs in a single node.  I only show 2 here as the example.
> See the description above of the led-sources

OK, I confused RGB LED modules with banks.

Shouldn't we allow for defining either strings or RGB LED
triplets somehow then?

-- 
Best regards,
Jacek Anaszewski
