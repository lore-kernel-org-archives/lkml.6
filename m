Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F0BC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFF920818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnVhkO4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFF920818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeKJCiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:38:07 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46791 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeKJCiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:38:06 -0500
Received: by mail-pl1-f194.google.com with SMTP id c13-v6so1183557plz.13;
        Fri, 09 Nov 2018 08:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kt/MckXptzp5EzzhlquAkOFAEyyu8EcQkuFi6KktDh4=;
        b=LnVhkO4mD6NXEvzZ51OmCKTLFlfVd6xBboSGAFJFNobfxksmNkV3RxAwIflvezf1hn
         TUeDAssfO9MYBEOTDKcK4WUzSeI7Dh4MsaSUJ7Be3/HIqRJjzHFjZ57U7yEbJ1/YO8cw
         /FFrriMVuYuJNk7c7zyR/YvjZWTAkI7CJXaqyyrcNTkbXBEmSIpwU5VhlYPq70YWtSjU
         frbDo6amHaplRlcylC5E7J302D8g4lWEfbf3J/KML0u9IKDkF7qbVaD5LnH3qYK6prM7
         y4byo5hBNwnREwSN7KJeqip2Ha7eJDwDVoy1g4iFDWFdEGviFRhMAZQZFc+rqO4/AbZN
         5f/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kt/MckXptzp5EzzhlquAkOFAEyyu8EcQkuFi6KktDh4=;
        b=p70pom4GYTVdNrYbCknnyMkfdYmCpF8xRKDorAW0pstRWimpVdbV+GR0BEvNkIUHwl
         ItyL6qk5ZLGkCiinSbjFym9SH1qZNzyLmtD2Kd7VXTbsl/I6BxMaQaMbUVMDz4clUCTB
         5N+ucsSo80xcSk0c7Zv62IIEXIE2mpaTuJUBjY37n36t68ZkbbrUod++rhVOrOLuXBnL
         O9hKMwQ9LJffjJFDIrRN9WpUgT8qXWqeXJ9WAzIsM9nNeZgWksXoPYN10JoZQCkZIHD2
         iwuQeaLTEKYUGexsvdyOITrjpcz+u0XcoCD9vIQEUlBX5QB//6BLyRJGItT0vRy2tbNa
         MP3g==
X-Gm-Message-State: AGRZ1gL/u+aHt9DA1Ry5dES3otkdEApaUliprkn+n7HWfDJP0a3lVJRR
        bRwzOjNyJRRhhDIRdhGD4ms=
X-Google-Smtp-Source: AJdET5dzkU0TpPYkG7dZ8owWCMCYzUdn1GqPa8KiUL1gb9w1MlsvcTCNLdaPtp4Vd8KeEmZseaXPFw==
X-Received: by 2002:a17:902:8f8f:: with SMTP id z15-v6mr9708309plo.257.1541782601843;
        Fri, 09 Nov 2018 08:56:41 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id d8-v6sm8666567pfj.106.2018.11.09.08.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 08:56:41 -0800 (PST)
Subject: Re: [PATCH 1/4] of/device: Add a way to probe drivers by match data
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, ryder.lee@mediatek.com,
        Rob Herring <robh+dt@kernel.org>
References: <20181106183609.207702-1-sboyd@kernel.org>
 <20181106183609.207702-2-sboyd@kernel.org>
 <efa13e0b-0daf-3bf3-27ba-ed90f15c7dfe@gmail.com>
 <154169993998.88331.10494065577891939152@swboyd.mtv.corp.google.com>
 <0f2bb386-ba92-544c-e980-c95309944b22@gmail.com>
 <CAMuHMdWm2P8fa6d9vLhYtWHBe0uNPj9jfyL1rtmdLixPEi1rUg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <07ec49cb-e5b7-72bc-f563-2d2d7c2e2c0d@gmail.com>
Date:   Fri, 9 Nov 2018 08:56:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWm2P8fa6d9vLhYtWHBe0uNPj9jfyL1rtmdLixPEi1rUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/18 2:36 AM, Geert Uytterhoeven wrote:
> Hi Matthias,
> 
> On Fri, Nov 9, 2018 at 11:29 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>> On 08/11/2018 18:58, Stephen Boyd wrote:
>>> Quoting Matthias Brugger (2018-11-08 00:29:46)
>>>> On 06/11/2018 19:36, Stephen Boyd wrote:
>>>>> +int platform_driver_probe_by_of_match_data(struct platform_device *pdev)
>>>>> +{
>>>>> +     int (*probe_func)(struct platform_device *pdev);
>>>>> +
>>>>> +     probe_func = of_device_get_match_data(&pdev->dev);
>>>>
>>>> Shouldn't we check if probe_func is not NULL?
>>>
>>> Is the oops from the NULL pointer deref insufficient?
>>
>> Do you think we should crash the machine if someone uses the call wrongly? Or
>> should we provide the possibility to error out on the caller side?
> 
> I believe that would be a bug in the driver, to be discovered ASAP.
> So yes, please do crash ;-)

This is one of Linus' pet peeves.  He does not think crashing the
machine is the proper choice (as a general statement).

-Frank

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

