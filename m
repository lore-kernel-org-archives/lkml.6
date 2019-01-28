Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192CBC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5AC2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1Khu1pJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfA1LDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:03:08 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:52577 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfA1LDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:03:05 -0500
Received: by mail-wm1-f54.google.com with SMTP id m1so13497104wml.2;
        Mon, 28 Jan 2019 03:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ma7NQbkbV4EGaErq9ddefJ4LlNDNE6uhJ0aUoGK6ZdY=;
        b=h1Khu1pJLfcdo2+V/iSq7JAd6lkHG4X+CN+7oQ9Noy6Y1Efr/kQrTcWPAZcdmGL0jE
         a3bWJ5j8OlXQa4eR1eDXgPvqNofPhr0jLs9KlveYmqEEW8fnTRM4vX8LUH38EvLA0HS+
         qtq51jbPXNFoTPzsO5hXa0JyYRhrUW0ArPoS0Q4faDXzI0Lsb2/FZFD0OcHUBzI9CsCZ
         OlE4yLzi3i0Dt8u52Iq9Xeo9v7x4zIwgRvWiBDV/URp3Z9dJXynyAAj8vmzx1FuwKQk6
         syo+OlWDJQSDY3tehfGN4a4hNMV3dBwhnUDpDIehdg5NmWvMcvvzHluwzcKmHslHxD7Q
         oKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ma7NQbkbV4EGaErq9ddefJ4LlNDNE6uhJ0aUoGK6ZdY=;
        b=N8DxmAn5qub6m0ytnM9rI3r7H4bUsJCgLogXgQvkJe1Ejln3A8uYGC5SPhMsqy6HDu
         9eO/FCN0sMuFWnJpCyn+ry1xSq8r9zQtjqCBjQahDe/HbH51vQYzgdqnL+y9it8iQ3jf
         tvAQBWhgidpYkbqiZ8zgYyBj1BojLxo0Vos+OnYt+4WTcCipHPvdiORvj+xS/rKzrEoe
         L+hLjtWTznIGAJiNXyTqDRRxUPw3GwHnO/fCkfwb/ux7CrLzO03JSoSCU60fudAaC9Rm
         1BCGH5L/Nsiv+vyKD6cMoWbTiYPvcv8eRLCpUlvgnRT3I14nlBjU9Ew6ewwyf+7gWcWa
         vxHQ==
X-Gm-Message-State: AJcUukcT42oSM4jZCqv7bqvXsupA66iKuTTTeh9a9uW7J/Xzr28QtJ48
        DUUh5ziEyf3Fnkyf9JKTfkIqpXc5HD4=
X-Google-Smtp-Source: ALg8bN5mlROxV7Sx1l3o5yf6hicxZFu3JHkpZEjedVFk72pFBQMZrkyhnsiseIumUpZoTxcHwyRckA==
X-Received: by 2002:a1c:7e56:: with SMTP id z83mr7406162wmc.100.1548673383117;
        Mon, 28 Jan 2019 03:03:03 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id v8sm132964293wrq.53.2019.01.28.03.03.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 03:03:02 -0800 (PST)
Subject: Re: [PATCH v7 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        zhengxunli@mxic.com.tw
References: <1548227352-14910-1-git-send-email-masonccyang@mxic.com.tw>
 <1548227352-14910-2-git-send-email-masonccyang@mxic.com.tw>
 <bb63b646-b549-dc3b-a604-17ba156e735c@gmail.com>
 <OF767ACC95.EECC73BE-ON4825838C.000BD6A3-4825838C.000D23A6@mxic.com.tw>
 <67fa5f94-886b-f09c-c93d-832e427ffec8@gmail.com>
 <OF891E176A.614DBEEF-ON4825838C.0022D454-4825838C.002396ED@mxic.com.tw>
 <0b3ea94f-a4f3-0780-301b-f88ff2ad2fb1@gmail.com>
 <OFEAAE10B4.20C3E45D-ON48258390.0007CD37-48258390.0009066E@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <2d762c16-d714-9171-9450-b6adf1a6509c@gmail.com>
Date:   Mon, 28 Jan 2019 12:03:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <OFEAAE10B4.20C3E45D-ON48258390.0007CD37-48258390.0009066E@mxic.com.tw>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/19 2:38 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,

Hi,

>> "Marek Vasut" <marek.vasut@gmail.com>
>> >> >> > +module_platform_driver(rpc_spi_driver);
>> >> >>
>> >> >> RPC is not a SPI controller, it's a SPI and HF controller.
>> >> >>
>> >> >> Also, how difficult will it be to add the HF support ?
>> >> >
>> >> > One of my customers needs RPC SPI driver for our company's
>> >> > Octal-Flash,MX25UW51245G.
>> >> > We don't have HF product and hope you could understanding.
>> >>
>> >> I am worried that when we need to add RPC HF support (which is what all
>> >> boards but the D3 Draak use), we will have to rewrite the entire driver
>> >> and/or convert it to MFD and that would be a tremendous
> undertaking. I'd
>> >> prefer to have the driver ready for the HF addition before it's
> accepted
>> >> upstream.
>> >>
>> >
>> > I think maybe your concerned would be happened only if HF driver
> goes with
>> > spi-mem layer.
>> >
>> > A comment for HF from Daniel Fishman. FYR.
>> >
>> > https://www.quora.com/What-is-a-hyper-flash-memory-and-how-is-it-
>> different-from-normal-flash-memory
>>
>> I have a decent idea what HF and SPI NOR are, since I wrote the RPC
>> driver for both HF and SPI mode for U-Boot (as I mentioned earlier).
>>
>> The HF in Linux would use the CFI NOR part of MTD framework. My concern
>> is that when we need to add HF support into this driver, this driver
>> will have to be basically rewritten, since the architecture won't allow
>> for that. I'd like to avoid that, since the majority of Gen3 boards,
>> expect for the D3 Draak, use RPC in HF mode.
> 
> FYI~
> 
> MX25UW51245g(64MByte Octa)                      S26KL512S(64MByte HF)
>    8 IO                                                  8 IO
> 200MHz DDR@1.8v                                   166MHz DDR@1.8v
> 
> support Read-while-write                       Not support
> good for OTA,etc
> powerful application

What does that mean ?

-- 
Best regards,
Marek Vasut
