Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B295AC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6982526C65
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fW5PjOPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6982526C65
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932219AbeF1ElL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:41:11 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35870 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbeF1ElK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:41:10 -0400
Received: by mail-pg0-f66.google.com with SMTP id m5-v6so1902044pgd.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 21:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SFHSNBzkWptaVBnGKHj66hJQRHEELS2An+pdJervb2A=;
        b=fW5PjOPbfwpgbJPo+W1HDRfL7GQL5j5AJ7QDJhnkvXFyEnJS8CXPmFpGBlNm6ZxuKp
         arh7HEjgjB/L1x0jU8xTBPhLUBiY2tHt6uGgj4c22zQw1xicmw3EB29maKWCP7AU86AS
         uzi/ifUIC/lW2aZKl/V48yrgq0Bu1+73E+JDWMeaen+TJDONCHwSKF0Lmft8Uor65OVK
         2n1Ugy629rwqpz/QxXB8ypEQnqVLye57feGNTO+KiZij1aE25lzCVR6qs8Auo7HA68d4
         5fPoPBwvwlm/hqqU+Ki53HS9FWJvexI9jSSHc7h1yEr5K9r67JsqI8OE+kcXR3pC2vSg
         ARlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SFHSNBzkWptaVBnGKHj66hJQRHEELS2An+pdJervb2A=;
        b=rjDsiMWYTGJh571icsG0pT9KrQEzCAf8t611mBFVjSby6+LwvkwhQalfjGsZyD43ed
         a5AIn+hR4bC1+AHAOZODGifJNPtPhFh+4YzGEvLT2ovrLt/CRZz/uumqknFq0kzlM3cz
         jihGOWB7S2sXZWdGdrJ0Q4TTRlX/vQR1dKYNkrrZ/rE54+64Ixk7VD3rLcUL/DcIzeGZ
         5Y6JBfMJWsLonCAMVWTMQ4OIdhxUKCUoGEgkOasWHowvmISpMI4KlmTwjfLzeFD53+r5
         WKkqWmV9bcovVp7p/5FQKC5P243GBj5tlPf2+90m1WRp3HnrqQLGQKoyxnZfSTETDjk0
         5fCw==
X-Gm-Message-State: APt69E0m5YGQDe08HMWrbcFonso7/ID5EwUd87ncNgRZmFSpZBNWBQ67
        HCmYZGXXa0e3pUaaWXKepnxLTw==
X-Google-Smtp-Source: AAOMgpcJd7swVo9Z262WR9fuehG+JJ8yzotGVRFlLsNXN7suVCKsOQRQk17VroT4qNk43AYKqoQOKA==
X-Received: by 2002:a62:2253:: with SMTP id i80-v6mr8516172pfi.11.1530160869917;
        Wed, 27 Jun 2018 21:41:09 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id l1-v6sm11979720pgn.55.2018.06.27.21.41.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 21:41:08 -0700 (PDT)
Subject: Re: [Qemu-devel] Linux kernel configurations for various Microblaze
 systems
To:     "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc:     =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
        Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
        "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
        Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>,
        KONRAD Frederic <frederic.konrad@adacore.com>
References: <20180627185248.GA19743@roeck-us.net>
 <96809884-2f46-ed63-48fd-9fd4c5050e20@amsat.org>
 <20180627205915.GA22693@roeck-us.net> <20180627224718.ewamlt42kvyirhjw@toto>
 <ae120580-01f2-672d-edc0-440c2dd3f248@roeck-us.net>
 <20180628041217.qxlspqzqfm4gszxd@toto>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4193ce56-e3f8-d3f7-52a1-170f2d9185bb@roeck-us.net>
Date:   Wed, 27 Jun 2018 21:41:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628041217.qxlspqzqfm4gszxd@toto>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27/2018 09:12 PM, Edgar E. Iglesias wrote:
> On Wed, Jun 27, 2018 at 05:34:15PM -0700, Guenter Roeck wrote:
>> Hi Edgar,
>>
>> On 06/27/2018 03:47 PM, Edgar E. Iglesias wrote:
>>
>>>
>>> Hi Guenter,
>>>
>>> Re: ml605
>>> The thing to watch out for with kernel configs for microblaze systems is the
>>> physmem address setting. Unfortunately the kernel does not auto-detect this.
>>>
>>> I'm attaching a kernelconfig for the ml605 that works for me and a qemu commandline.
>>>
>>> qemu-system-microblazeel -M petalogix-ml605 -m 256 -serial mon:stdio -dtb petalogix-ml605.dtb -kernel arch/microblaze/boot/linux.bin -append rdinit=/bin/sh
>>>
>>
>> Can you also send me the dtb file or even better its source ? I don't think
>> the one in qemu is correct. It lists the serial port at 0x83e00000, but qemu
>> instantiates it at 0x83e01000.
> 
> I used the one from QEMU. IIRC, there's some offsetting going on there
> that differs between the Xilinx version and the PC version of these
> UARTs...

Yes, I noticed after I sent the previous e-mail.

> 
> Can you try again and see how it goes?
> If it doesn't work, I can share my kernel Image and we can compare from there.
> 

I tried lots of things, nothing worked. Until I got your e-mail, tried again,
and suddenly it works just great. Go figure. Turns out I had used a big endian
toolchain to build a little endian target. Shameface.

I do get this odd gcc warning:

cc1: warning: -mxl-multiply-high can be used only with -mcpu=v6.00.a or greater

Actual parameters are "-mcpu=v10.0 -mxl-multiply-high", so that doesn't really make
sense to me. I tried various toolchains, all with the same result. Any idea what
that is about ?

Thanks,
Guenter
