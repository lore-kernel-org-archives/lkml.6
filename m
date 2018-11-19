Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2BBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8853B20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhCMoDET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8853B20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbeKTBgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:36:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40763 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbeKTBgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:36:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so23298903wrt.7;
        Mon, 19 Nov 2018 07:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aZtv047poDD10sIyMM43BX4wyNVtgA74SvoKQ1ZqC/I=;
        b=ZhCMoDETv71/HutHmiWzsUVBKuwcILlRgyQ1ZHd0pCrx5fANmLF5wc+4Id0EbqDyWu
         fQ6bp4rh5he1dVKR6nfcJtyD2JVC3JAxT5H3BK9ZtS5TSWCXP6whI9MSsicrmnzHIZ3h
         bOUMdHdKz+Dr6VdukMw39D3T3k3xTLky3wImc8YSjQOP8FHDd5ONEhJ6Wgi18ZGQ7hwW
         LVBLAegl5MvjMO0ozoRjVd0/JVYWkHfQoegHpYh9S0HsNuGioUSLZWuKOIBUpGEB5pJ/
         j6lJ5SlgwLZDAEh9GhBarevyHdjBWCsRBeKNNQMrS7GJlU2LzHUOvfZsna9ICeV7AVi7
         suCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aZtv047poDD10sIyMM43BX4wyNVtgA74SvoKQ1ZqC/I=;
        b=Bqns8vzCYOzz0Frqs3Uq8QwbzihAtZxpozYvlTNOsXhlBTpWnR+/Mq4o/Bhvb0Zykk
         lLC1RNs7Z3o4r7B2jxfajxXSUsFE4C3bS/JFKqFZnIXJivCjMKVZWgacp5mWHOOrPxJ4
         5YaO0BuFU/Pa5SB/nSd0UMk3HsHuVqT52irOz1KRwC2tcY26+3kTfjYXIAoHmkTKpWly
         iOn45REpNutOrsjT9C4fod3lAXOJhbzNM2lDuToYitG650fQNU6MmHjyRFwNZf4qOBuK
         sSX+lQ7DLl0/8qISFitpjXzi41yFb4Zu3F0QMxbHuNVhqJPFRfwdwBSQ27pVCKZk/P/u
         d9WA==
X-Gm-Message-State: AGRZ1gKhnETYj9fzP6fUxXB2m8JdOpEBOgnMmw5SbXIZOWMZII6qrNp2
        BpqSGInYEHMxfyLRWBuMz7Y=
X-Google-Smtp-Source: AJdET5fHnktavUheO7JXGyidA85F/V+IWSs//QQwlXzLwJ+7GPAtz6clBhbKZ0WNmThIb5Q6EOij7Q==
X-Received: by 2002:a5d:4708:: with SMTP id y8-v6mr18492401wrq.16.1542640362963;
        Mon, 19 Nov 2018 07:12:42 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id f12-v6sm24097929wru.63.2018.11.19.07.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 07:12:42 -0800 (PST)
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
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <4c0683d3-fe9d-5a10-6f5c-4774024cb12a@gmail.com>
Date:   Mon, 19 Nov 2018 16:12:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181119154338.2dfa7a5a@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/2018 03:43 PM, Boris Brezillon wrote:
> On Mon, 19 Nov 2018 15:14:07 +0100
> Marek Vasut <marek.vasut@gmail.com> wrote:
> 
>> On 11/19/2018 03:10 PM, Boris Brezillon wrote:
>>> On Mon, 19 Nov 2018 14:49:31 +0100
>>> Marek Vasut <marek.vasut@gmail.com> wrote:
>>>   
>>>> On 11/19/2018 11:01 AM, Mason Yang wrote:  
>>>>> Document the bindings used by the Renesas R-Car D3 RPC controller.
>>>>>
>>>>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>>>>> ---
>>>>>  .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 33 ++++++++++++++++++++++
>>>>>  1 file changed, 33 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>>>>> new file mode 100644
>>>>> index 0000000..8286cc8
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>>>>> @@ -0,0 +1,33 @@
>>>>> +Renesas R-Car D3 RPC controller Device Tree Bindings
>>>>> +----------------------------------------------------
>>>>> +
>>>>> +Required properties:
>>>>> +- compatible: should be "renesas,rpc-r8a77995"
>>>>> +- #address-cells: should be 1
>>>>> +- #size-cells: should be 0
>>>>> +- reg: should contain 2 entries, one for the registers and one for the direct
>>>>> +       mapping area
>>>>> +- reg-names: should contain "rpc_regs" and "dirmap"
>>>>> +- interrupts: interrupt line connected to the RPC SPI controller    
>>>>
>>>> Do you also plan to support the RPC HF mode ? And if so, how would that
>>>> look in the bindings ?  
>>>
>>> Not sure this approach is still accepted, but that's how we solved the
>>> problem for the flexcom block [1].
>>>
>>> [1]https://elixir.bootlin.com/linux/v4.20-rc3/source/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt  
>>
>> That looks pretty horrible.
>>
>> In U-Boot we check whether the device hanging under the controller node
>> is JEDEC SPI flash or CFI flash and based on that decide what the config
>> of the controller should be (SPI or HF). Not sure that's much better,but
>> at least it doesn't need extra nodes which do not really represent any
>> kind of real hardware.
>>
> 
> The subnodes are not needed, you can just have a property that tells in
> which mode the controller is supposed to operate, and the MFD would
> create a sub-device that points to the same device_node.

Do you even need a dedicated property ? I think you can decide purely on
what node is hanging under the controller (jedec spi nor or cfi nor).

> Or we can have
> a single driver that decides what to declare (a spi_controller or flash
> controller), but you'd still have to decide where to place this
> driver...

I'd definitely prefer a single driver.

-- 
Best regards,
Marek Vasut
