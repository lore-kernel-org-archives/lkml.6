Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FC5C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3148C2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bO2NSTxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfAGVOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:14:06 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:44803 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfAGVOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:14:05 -0500
Received: by mail-lj1-f172.google.com with SMTP id k19-v6so1561156lji.11;
        Mon, 07 Jan 2019 13:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rkWyZltd6SK8OFYWWFKn5JDtY1gpiColbnBZL8HyhV0=;
        b=bO2NSTxtmGShg4H+rX5G0++pWbUIJ5Oq+SFMcTGxSwj73HIicw87lbmmfyDMjc4PgV
         e1Oge5B+z1WEEXaQ5lIHsGMC/J54lqRm4mw9rQPGChro9e+dbKuj5glnnYAB4vBIwPab
         HvRrJVlsP2ckWeQhc3i6Hal/QIfcyILBRLpfLfOM+EGaKdqIlv0IDNIXztxiqCp+J1YF
         seg6ooLM7hxQTwtOnY/JO5qI1hVZmBZ4s9C4a+GoVd0SeuMut85lktHNCOAWlR83f/Dd
         +98IAtGZ2KC2HQdTiGGj9STuxxqHHBKkXwmWOsxPjH7VveNny1U6kuiQYWE/yKi46RP5
         fzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rkWyZltd6SK8OFYWWFKn5JDtY1gpiColbnBZL8HyhV0=;
        b=od//MdKs4iqoJYj/o79g42LuvkLajhHbpe+ioDVwOPlef2B5use5y1TjfrKBdXrThc
         kiYte69Z5P3xMb/C9cydbCDpXB7L8F6t8LqE/TFLqcXQ3tRxpIKQmtmfp9hoXJk9v8ZC
         E55wsH+2ghARA0TJfXhgY9s+hxJIVm4k/kSwxQtiOMveYUBVWwrag0uTW+mGiCdjKkwT
         CXG6oAQRmCupA5xrf0K2no3jOxvXTQIjsnQqO2zpDgQTPEt8DqXZzgaFLljru38Z5doU
         RZQkxPbX9d2yQn0SkSVSPABRIMC6klmHCyOpbLiGymz2hdMYvzEVQzXHZYMSQQTPtP8K
         493A==
X-Gm-Message-State: AJcUukce80hpsJ38/QAhNp3ZzCfPJO7Kq4uOrnMOJ/Ji1Y9O1PwLT8mf
        wanff2fza/CF6nSkRU6eqdM0/pks
X-Google-Smtp-Source: ALg8bN7fCeROECQj7P70U/mohWQrkI5lpUyLo4lCwUIjN4lgNyXuru8nArd7ovmD746mbEAZ/mbUuw==
X-Received: by 2002:a2e:8945:: with SMTP id b5-v6mr6482077ljk.55.1546895642014;
        Mon, 07 Jan 2019 13:14:02 -0800 (PST)
Received: from [192.168.1.18] (dnq218.neoplus.adsl.tpnet.pl. [83.24.98.218])
        by smtp.gmail.com with ESMTPSA id z6sm12620947lfa.87.2019.01.07.13.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 13:14:01 -0800 (PST)
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com>
 <20181219201047.GA23448@amd> <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
 <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
 <a72c11c0-949b-bdbc-df2c-4490e04a1065@gmail.com>
 <986b5105-2fdb-bd25-7c8a-ca8fd1ade821@gmail.com>
 <7f205102-e854-f1cb-cc03-1307d1cddc87@gmail.com>
 <c9f8965a-90f4-b456-8225-c70694c9f071@gmail.com>
 <cf6c0025-36e7-197b-b27a-1f31fb45cc38@gmail.com> <20190104201256.GA2931@amd>
 <a4e3a782-de76-ba91-3727-4db69cf27c3a@gmail.com>
 <90a2ed79-b437-af14-4538-430d8723cc6b@gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <38daf022-e4e4-799d-4c75-ee851315290d@gmail.com>
Date:   Mon, 7 Jan 2019 22:13:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <90a2ed79-b437-af14-4538-430d8723cc6b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vesa,

On 1/5/19 1:39 AM, Vesa Jääskeläinen wrote:
> Hi Jacek,
> 
> On 04/01/2019 23.37, Jacek Anaszewski wrote:
>> But, aside from that hypothetic issue, we need a solution for
>> LEDn_BRIGHTNESS feature of lp5024, i.e. setting color intensity
>> via a single register write. How would you propose to address that?
> 
> You could model it to something like this in device tree:
> 
> led-module @ <i2c-address> {
>      compatible = "lp5024";
> 
>      // There is in hardware setup to use either linear or
>      // logarithmic scaling:
>      //enable-logarithmic-brightness;
> 
>      led0 {
>          // this will create led instance for LED0 in lp5024
>          label = "lp-led0";
> 
>          // This specifies LED number within lp5024
>          led-index = <0>;   // set output-base as 0*3 == 0
> 
>          element-red {
>              // refers to OUT0
>              output-offset = <0>;
>          };
> 
>          element-green {
>              // refers to OUT1
>              output-offset = <1>;
>          };
> 
>          element-blue {
>              // refers to OUT2
>              output-offset = <2>;
>          };
> 
>      };
> 
>      led1 {
>          // this will create led instance for LED1 in lp5024
>          label = "lp-led1";
> 
>          // This specifies LED number within lp5024
>          led-index = <1>;   // set output-base as 1*3 == 3
> 
>          element-red {
>              // refers to OUT3
>              output-offset = <0>;
>          };
> 
>          element-green {
>              // refers to OUT4
>              output-offset = <1>;
>          };
> 
>          element-blue {
>              // refers to OUT5
>              output-offset = <2>;
>          };
> 
>      };
> 
>      bank-led {
>          // this will create led instance for bank leds in lp5024
>          label = "lp-bank-led";
> 
>          // configured bank led configuration
>          led-index = <2 3 4 5 6 7>;
>          // As here is list of led-indices this entry is
>          // assumed to be bank configuration. Bank mode is enable
>          // for the indices.
> 
>          // set output-base as BANK A
> 
>          element-red {
>              // refers to BANK A
>              output-offset = <0>;
>          };
> 
>          element-green {
>              // refers to BANK B
>              output-offset = <1>;
>          };
> 
>          element-blue {
>              // refers to BANK C
>              output-offset = <2>;
>          };
>      };
> };
> 
> This would then create three led instances and each led instance has 
> brightness setting and that goes straight to hardware.
> 
> If one would want to override hardware control for brightness then I 
> suppose you would define in led node something like:
> 
>      brightness-model = "hsl"
> 
> This would then pick red, green and blue elements for hsl calculations 
> and others color elements for linear. LED specific hardware brightness 
> would then be either 0 or 0xFF depending if all of LED color elements 
> are zero or not.
> 
> Would that kind of model work?

I'd prefer to have single RGB LED device. And your DT design
is unnecessarily complex and a bit confusing.

Also, you provided scarce information about sysfs interface.
It would be nice to see the sequence of commands.

-- 
Best regards,
Jacek Anaszewski
