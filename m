Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27F0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AB9222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406393AbfBNKEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:04:48 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34073 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387663AbfBNKEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:04:47 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so4543820ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 02:04:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sdq/xPWrFQPnFX96tIhCA42cOhxAnf+ayG8BSFYnesg=;
        b=OXdYrXbO8p5tXRauteXDM52wwXBFv2ChK+3vcTknux5LfEBcWQAJ+qrot9YmnwOxfc
         xrXXQ1jpKRk/FJxGMukK55gILB51bfJ6Y+Y4He2GJaQFYUco52MVIeuG4IwMoFxFXtAj
         wMWZJrWIAJgE7wpPM88Vdt1Eq13JPHFDH1SdSBB+vsFjk7NDs002Nv4nJCpqdwLbbDMR
         WiXGnPZkXBrq/sF+bZsfll4Dv++6jB/ZqgAy1MMct1FPIjoqhArCMEuKIVz/zfXA6vna
         4n7Zz1j3r/+DiNk/6BY9UyoF1rKHpKGuhcA+EvK9o/dpk7upxDVgSb3DUcvQG7Qgq4GT
         GZdg==
X-Gm-Message-State: AHQUAubaaWixDJzsO6SI33JJL9tFDI0K/3vmWjnrA9wZdiwmr/Hph0Pk
        cyVShRNpNEiLAm4S66gPaHvDiNuy2/w=
X-Google-Smtp-Source: AHgI3IbCOvQxnrZiE7DpOBbI4prtIRZDD5Tc/Kh4p+65cdmCYWIehIBaNw23t6IkpvbMg4iWV7wkuQ==
X-Received: by 2002:a50:9e0a:: with SMTP id z10mr2311414ede.39.1550138685975;
        Thu, 14 Feb 2019 02:04:45 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id v1sm523774eds.47.2019.02.14.02.04.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 02:04:45 -0800 (PST)
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
From:   Hans de Goede <hdegoede@redhat.com>
To:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20190212205901.13037-1-jekhor@gmail.com>
 <20190212205901.13037-2-jekhor@gmail.com>
 <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com>
Message-ID: <079efdd4-2259-1e6f-48dd-5876f2bd7a93@redhat.com>
Date:   Thu, 14 Feb 2019 11:04:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13-02-19 23:43, Hans de Goede wrote:
> Hi,
> 
> On 12-02-19 21:59, Yauhen Kharuzhy wrote:
>> Add support for LEDs connected to the Intel Cherry Trail Whiskey Cove
>> PMIC. Charger and general-purpose leds are supported. Hardware blinking
>> is implemented, breathing is not.
>>
>> This driver was tested with Lenovo Yoga Book notebook.

<snip>

> Note that in my experience the "charging" mode only works
> when bits 0-1 have the value 10.

Ok, scrap that I don't know where this info in my notes
came from (probably user error), the power-on-reset
value for bits 0-1 is 00 and then the hw controls the
charging LED just fine. So your code is right, bit 0
switches between hw-control (0) and user-control (1) and
bit 1 is on/off when user-control is enabled.

Regards,

Hans
