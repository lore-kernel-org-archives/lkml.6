Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCEBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED9220823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGFpECHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED9220823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbeKTIyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:54:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44109 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbeKTIyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:54:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id j17-v6so33696185wrq.11;
        Mon, 19 Nov 2018 14:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l07Y2oK70N98oMqQBVw6f4bQihNSvSbS4JUBn2AMxgk=;
        b=GGFpECHmJk+ymxc44zgGU5dwVZl4DPKGJAiVHihKWuIhc6njIe047I8aotpo+nPZcy
         UV8ILJDwc96rGjYMkcTeZYtOjxlysaRzKgDlt8lv4kSMl4PMGTuzUYUWdFmwplLcZdci
         V2qxTvQGtegaLBD6YhOD2oXzOsgqeinQCu59pj6WasaEikjAGH5cmoXGtPO8VjlqqktI
         ycVFoZ0mTP+7HJZVA94oPBYa0ucVvAHgukdJjWeCKba1EzlKHGXSVTDmOmChSHyjMM28
         CAl16Bt8npkVJEgHf7P0pclikfnctZ65Ga7cxuEHEhUaBsIF7OnQ0u/clyrVAY1IXQDE
         Q09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l07Y2oK70N98oMqQBVw6f4bQihNSvSbS4JUBn2AMxgk=;
        b=q8qWYNP1HtFFWfZpuafiZ3I0gxkwtRtuTTfvzn/zPlgwMYtMut4FmijPOcS9WNX1Q8
         GmIhsjhCNuNek0dskDPPkAF6BeDBG5xq6WB4HsS7bYtMSxWMTqohLwnZtt+d9/BvUwHe
         +Hc461Jlyl3Wy+PM43x4Q59dUS81Qy0DcHWsVLSYxGK1n5Nun6DaeTaOWcucHLG0Z82A
         6r0jbbN1g3Hdf++qoGIK15BjKvZTNmsQoB6Fc6hxWK49xNhxg61KXaGtfdGkg2DMM1xz
         zYYpqHMwZOcFZJvC7hVh+m606q6LafV1/GeulGWrOTOz7fe4ITk6sHmcY4sOviAfpmG0
         oV3w==
X-Gm-Message-State: AA+aEWa8BJaCY+eUcIqMDgWQqjQ9l6yFd8l2NlLWboDbBN+6ozVdhRFU
        epvnKUMOEtriX+ORHaUUMC4=
X-Google-Smtp-Source: AFSGD/U7PWBZl6sj3mIMVw9kWVsOyF/i4INPpmlJHtuoAmxZxZxosUaraMAoWdKf+h/uA9wP08T7dg==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr6634010wrn.157.1542666542500;
        Mon, 19 Nov 2018 14:29:02 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id q185sm6185477wmg.14.2018.11.19.14.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 14:29:01 -0800 (PST)
Subject: Re: [PATCH 2/2] dt-binding: spi: Document Renesas R-Car RPC
 controller bindings
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        tpiepho@impinj.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        zhengxunli@mxic.com.tw
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
 <1542621690-10229-3-git-send-email-masonccyang@mxic.com.tw>
 <629a5d6f-5c13-9b24-1c21-461d09f1aa8a@gmail.com>
 <20181119151009.490413d9@bbrezillon>
 <b22b9bb3-17e3-1971-6986-33132c5ae232@gmail.com>
 <20181119154338.2dfa7a5a@bbrezillon>
 <4c0683d3-fe9d-5a10-6f5c-4774024cb12a@gmail.com>
 <20181119162127.71d0665d@bbrezillon>
 <3f791a3c-4a2e-5d43-1026-e1e7b879b562@gmail.com>
 <20181119231954.333699f4@bbrezillon>
 <9e217c7c-6626-d683-2d99-0b7571043b3b@gmail.com>
 <20181119232517.49b39e25@bbrezillon>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <90f42104-a6bd-54e7-959c-ebb906c6019a@gmail.com>
Date:   Mon, 19 Nov 2018 23:29:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181119232517.49b39e25@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/2018 11:25 PM, Boris Brezillon wrote:
> On Mon, 19 Nov 2018 23:22:45 +0100
> Marek Vasut <marek.vasut@gmail.com> wrote:
> 
>> On 11/19/2018 11:19 PM, Boris Brezillon wrote:
>>> On Mon, 19 Nov 2018 23:11:31 +0100
>>> Marek Vasut <marek.vasut@gmail.com> wrote:
>>>   
>>>> On 11/19/2018 04:21 PM, Boris Brezillon wrote:  
>>>>> On Mon, 19 Nov 2018 16:12:41 +0100
>>>>> Marek Vasut <marek.vasut@gmail.com> wrote:
>>>>>     
>>>>>> On 11/19/2018 03:43 PM, Boris Brezillon wrote:    
>>>>>>> On Mon, 19 Nov 2018 15:14:07 +0100
>>>>>>> Marek Vasut <marek.vasut@gmail.com> wrote:
>>>>>>>       
>>>>>>>> On 11/19/2018 03:10 PM, Boris Brezillon wrote:      
>>>>>>>>> On Mon, 19 Nov 2018 14:49:31 +0100
>>>>>>>>> Marek Vasut <marek.vasut@gmail.com> wrote:
>>>>>>>>>         
>>>>>>>>>> On 11/19/2018 11:01 AM, Mason Yang wrote:        
>>>>>>>>>>> Document the bindings used by the Renesas R-Car D3 RPC controller.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>>>>>>>>>>> ---
>>>>>>>>>>>  .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 33 ++++++++++++++++++++++
>>>>>>>>>>>  1 file changed, 33 insertions(+)
>>>>>>>>>>>  create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>>>>>>>>>>> new file mode 100644
>>>>>>>>>>> index 0000000..8286cc8
>>>>>>>>>>> --- /dev/null
>>>>>>>>>>> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>>>>>>>>>>> @@ -0,0 +1,33 @@
>>>>>>>>>>> +Renesas R-Car D3 RPC controller Device Tree Bindings
>>>>>>>>>>> +----------------------------------------------------
>>>>>>>>>>> +
>>>>>>>>>>> +Required properties:
>>>>>>>>>>> +- compatible: should be "renesas,rpc-r8a77995"
>>>>>>>>>>> +- #address-cells: should be 1
>>>>>>>>>>> +- #size-cells: should be 0
>>>>>>>>>>> +- reg: should contain 2 entries, one for the registers and one for the direct
>>>>>>>>>>> +       mapping area
>>>>>>>>>>> +- reg-names: should contain "rpc_regs" and "dirmap"
>>>>>>>>>>> +- interrupts: interrupt line connected to the RPC SPI controller          
>>>>>>>>>>
>>>>>>>>>> Do you also plan to support the RPC HF mode ? And if so, how would that
>>>>>>>>>> look in the bindings ?        
>>>>>>>>>
>>>>>>>>> Not sure this approach is still accepted, but that's how we solved the
>>>>>>>>> problem for the flexcom block [1].
>>>>>>>>>
>>>>>>>>> [1]https://elixir.bootlin.com/linux/v4.20-rc3/source/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt        
>>>>>>>>
>>>>>>>> That looks pretty horrible.
>>>>>>>>
>>>>>>>> In U-Boot we check whether the device hanging under the controller node
>>>>>>>> is JEDEC SPI flash or CFI flash and based on that decide what the config
>>>>>>>> of the controller should be (SPI or HF). Not sure that's much better,but
>>>>>>>> at least it doesn't need extra nodes which do not really represent any
>>>>>>>> kind of real hardware.
>>>>>>>>      
>>>>>>>
>>>>>>> The subnodes are not needed, you can just have a property that tells in
>>>>>>> which mode the controller is supposed to operate, and the MFD would
>>>>>>> create a sub-device that points to the same device_node.      
>>>>>>
>>>>>> Do you even need a dedicated property ? I think you can decide purely on
>>>>>> what node is hanging under the controller (jedec spi nor or cfi nor).    
>>>>>
>>>>> Yes, that could work if they have well-known compatibles. As soon as
>>>>> people start using flash-specific compats (like some people do for
>>>>> their SPI NORs) it becomes a maintenance burden.    
>>>>
>>>> Which, on this controller, is very likely never gonna happen. Once it
>>>> does , we can add a custom property.
>>>>  
>>>>>>> Or we can have
>>>>>>> a single driver that decides what to declare (a spi_controller or flash
>>>>>>> controller), but you'd still have to decide where to place this
>>>>>>> driver...      
>>>>>>
>>>>>> I'd definitely prefer a single driver.
>>>>>>    
>>>>>
>>>>> Where would you put this driver? I really don't like the idea of having
>>>>> MTD drivers spread over the tree. Don't know what's Mark's opinion on
>>>>> this matter.    
>>>>
>>>> Well, it's both CFI (hyperflash) and SF (well, SPI flash) controller, so
>>>> where would this go ?
>>>>  
>>>
>>> The spi-mem layer is in drivers/spi/ so it could go in drivers/spi/
>>> (spi-mem controller) or drivers/mtd/ (CFI controller).  
>>
>> drivers/mtd is probably a better option, since it's not a generic SPI
>> controller.
>>
> 
> No, spi-mem controller drivers should go in drivers/spi/ even if they
> don't implement the generic SPI interface (it's allowed to only
> implement the spi_mem interface).

Except this is not only SPI MEM controller, this is also hyperflash
(that is, CFI) controller. It can drive both types of chips. Thus , I
think it fits better in drivers/mtd/ .

-- 
Best regards,
Marek Vasut
