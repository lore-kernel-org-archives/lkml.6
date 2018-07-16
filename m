Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9060FECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8F120844
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uhy5juvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8F120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbeGPOBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:01:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44102 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbeGPOBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:01:02 -0400
Received: by mail-ed1-f65.google.com with SMTP id d17-v6so17910712eds.11;
        Mon, 16 Jul 2018 06:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IyVhZbqdYBhFFqSuelcaxRhJU1YlvrAXTLzRvLzZeHI=;
        b=Uhy5juvkqFiCrR6GTtEjadMPMZeBuuyes/SY+qQ+6ewq4VA8tiNKin/ocLC65tu3hs
         KTJBVabrLWBQw6jMCSXM4zA9MTVKHrEIhomzxKxe6qXMyzyo2P2TPEV6E9Y+O/f7CZdo
         UC7c9LlaEbjp6HxGl5kjjYQEHCGUtnmBlGPOPnogaeF3+XoItODyqcMyIjlkCPM2t8nF
         0B4D8+euJB6of6cDZXxNn82Ng+HL7vg6E7kOjGanqyjuwvxe/LTcz/U4+vMHfYIUFLFY
         qdrsozZz419qMhQqSGl6gTW9ZJlbY0AjCj8rdmKDCQOBxCyL5jJLBJMj9t8ZnGPNdFiY
         fIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IyVhZbqdYBhFFqSuelcaxRhJU1YlvrAXTLzRvLzZeHI=;
        b=tpDE/BUEej89+T/YRm8gLGjU5C3Hy7/zJhMghCKzPtjUeAGdDwpXWhQ+eYGPwcQTyq
         44PUxfQiG0IiqiuFXUxZYkDU7DzBm4MwWhxSgTQpHdlt8OttKMooL2neey4pHTpnDFlE
         iu3s4GMpATm+J+F5jH+vO6fQgkBYNUdubRlCIB+OJa1mBnzpu7T9Luli99+EGTiSzdZF
         u/WqMJRmGTzrxtbDRV//irhAmMPSXnqky81Ec275HlNyu45/pAp1L/Dh763kFMVT9bkS
         LM7/E9FAogwQrltm+E2ar7ah8liLy9sdgMLmFmjCvZNEDDjzYpnl8RE5ExZBKviCSCyn
         AVOA==
X-Gm-Message-State: AOUpUlFt60fIMe0vq04PDbipto7ypPyXxGr6vDvDC2DSM+At+78819kO
        nmgxwhc6jwJG9NyyK92oGHPqmSdv
X-Google-Smtp-Source: AAOMgpda1k8Rfd2UlbsY3jF5z1DmWzQiQ/RIxRF+CxNbrr4AScGlVaV9Gnr8u2hDULctrcJmzkDWYA==
X-Received: by 2002:a50:f31a:: with SMTP id p26-v6mr17961767edm.68.1531748012090;
        Mon, 16 Jul 2018 06:33:32 -0700 (PDT)
Received: from ziggy.stardust ([37.223.136.20])
        by smtp.gmail.com with ESMTPSA id v56-v6sm1630452edm.97.2018.07.16.06.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 06:33:31 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] dt-bindings: gpu: mali-utgard: add
 mediatek,mt7623-mali compatible
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     sboyd@codeaurora.org, mturquette@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1524816502.git.sean.wang@mediatek.com>
 <7ab060c2e9ef2b220fc62913b8936b706dfaf202.1524816502.git.sean.wang@mediatek.com>
 <3bd6e509-f99a-1f2d-1b66-65c414bacdbd@gmail.com>
 <1530089565.29697.35.camel@mtkswgap22>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <434aae44-d289-6683-9395-cb5711cd4b71@gmail.com>
Date:   Mon, 16 Jul 2018 15:33:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530089565.29697.35.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/06/18 10:52, Sean Wang wrote:
> On Mon, 2018-06-25 at 17:14 +0200, Matthias Brugger wrote:
>>
>> On 27/04/18 10:14, sean.wang@mediatek.com wrote:
>>> From: Sean Wang <sean.wang@mediatek.com>
>>>
>>> The MediaTek MT7623 SoC contains a Mali-450, so add a compatible for it
>>> and define its own vendor-specific properties.
>>>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>>> ---
>>
>> Hi Rob,
>>
>> Any comments regarding this patch?
>>
>> Regards,
>> Matthias
>>
> 
> Hi, Matthias
> 
> I've already got a Reviewed-by tag from Rob.
> 
> Is it possible that this patch go through your tree ?
> 

Basically yes, I just want to get the mmsys problem fixed first.
Sorry I know it is on my plate. I'll try to send a new version this week.

Regards,
Matthias

> 	Sean
> 
>>>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
>>> index 99d1c0a..656068f 100644
>>> --- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
>>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
>>> @@ -19,6 +19,7 @@ Required properties:
>>>        + rockchip,rk3228-mali
>>>        + rockchip,rk3328-mali
>>>        + stericsson,db8500-mali
>>> +      + mediatek,mt7623-mali
>>>  
>>>    - reg: Physical base address and length of the GPU registers
>>>  
>>> @@ -89,6 +90,14 @@ to specify one more vendor-specific compatible, among:
>>>        * interrupt-names and interrupts:
>>>          + combined: combined interrupt of all of the above lines
>>>  
>>> +  - mediatek,mt7623-mali
>>> +     Required properties:
>>> +      * resets: phandle to the reset line for the GPU
>>> +      * mediatek,larb: phandle pointed to the local arbiter used to control the
>>> +	access to external memory on the SoC.
>>> +	see Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
>>> +	for details
>>> +
>>>  Example:
>>>  
>>>  mali: gpu@1c40000 {
>>>
> 
> 
