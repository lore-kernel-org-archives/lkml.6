Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C5BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BEC20880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfBUJdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:33:45 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38954 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUJdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:33:45 -0500
Received: by mail-ed1-f65.google.com with SMTP id p27so14937923edc.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 01:33:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e/cRZFfRS1Ml1qaQW3ilHy5ozRayIu+7e4g7JUknFZ4=;
        b=MOF9O9E+j3/ogRVz9ee96IurcEPxZTy85NhvN8dhLy7uCu2h1jkKG0FoWIDbVejTIC
         RhEJtpuAOD/4wD1NVoEHdoZcG1iR3CoeaKsCkf+/tjus9l1JfKUm4X+G1mFg74twnOR9
         NCPjLRSA80e3WMVfPtM/m+pS+o550Z5WKSptDVacOve75/bZyWpshtG9sMYIAGCs43sZ
         iyfawNVxaQh8Ld1EHznEEL66i3vRIlhl4gEZuMVuzkQ346aeT4qRH1fcFNfabciO1xHH
         EpkWElQy1AlguJKH3LTEM68PSI25iuHricn9AssxsCKordF+Wblgp4dPDNX8n9miHA6R
         +qhg==
X-Gm-Message-State: AHQUAuZ5ieBdrPIM9sxDNWUPHSCNw9GX4csWsBZgxcUL/5h0L19ae9iR
        hGf8kulryT6C9z203Yv1kXrwDTIGyCY=
X-Google-Smtp-Source: AHgI3IZiHZfESq1/fzvRtHTofIoKuEW/zjTMSz83AjVoTeBOO3JSPrnfdtQow2SZCNzx/1tMhZYVSA==
X-Received: by 2002:a50:aa68:: with SMTP id p37mr30015192edc.168.1550741623537;
        Thu, 21 Feb 2019 01:33:43 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id k26sm4836738ejv.63.2019.02.21.01.33.42
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 01:33:42 -0800 (PST)
Subject: Re: [PATCH 2/2] extcon intel-cht-wc: Enable external charger
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20190210203649.21691-1-jekhor@gmail.com>
 <20190210203649.21691-3-jekhor@gmail.com>
 <1b2f04fc-05a0-4f09-c84e-dc7adc63ec63@redhat.com>
 <20190215063250.GB30250@jeknote.loshitsa1.net>
 <20190217215242.GA12656@jeknote.loshitsa1.net>
 <416a0e12-aa0e-e781-2ef2-f11b97ba77a0@redhat.com>
 <CAKWEGV7r_026NhT96AiXJUT_9WOTy_=DC3Kx9qVNRfjWmMkEBA@mail.gmail.com>
 <8e3d9949-4bd3-f229-ace4-196a5f08fad3@redhat.com>
 <20190219202005.GA3699@jeknote.loshitsa1.net>
 <6a7be360-8da3-f1e6-6ca7-f55b3b2c60df@redhat.com>
 <20190220202836.GA23567@jeknote.loshitsa1.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <01afde97-544b-423a-c18a-b39410b335ea@redhat.com>
Date:   Thu, 21 Feb 2019 10:33:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190220202836.GA23567@jeknote.loshitsa1.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20-02-19 21:28, Yauhen Kharuzhy wrote:
> On Wed, Feb 20, 2019 at 05:42:28PM +0100, Hans de Goede wrote:
>>>> The input-current-limit only specifies how much current the charger may
>>>> draw from the micro-usb for both supplying the laptop as well as for
>>>> charging the battery combined. You can safely set this as high as
>>>> the charger can handle (2A for a dedicated charger).
>>>>
>>>> The BQ25892 should have a *separate* setting for the max current to
>>>> use while charging the battery (assuming that the input current allows
>>>> drawing enough current in the first place). I would hope that those bits
>>>> have some sane value set from the firmware...
>>>
>>> Yes, the charger has separate battery current limit but firmware doesn't
>>> change its default value (2048 mA) while Lenovo's software driver does.
>>> It set battery charging limit to 4 A and input limit to 2 A (it makes
>>> sense because Lenovo adapter and BQ25892 both support voltage increasing
>>> upto 12V).
>>
>> Hmm, I guess your device uses a separate power-barrel charging conector
>> then? 12v over micro-usb requires special negotiation which the Whiskey Cove
>> PMIC does not support AFAIK.
> 
> The Yoga Book supports kind of quick charging by negotiate voltage with
> 'current pulse protocol' supported by BQ25892 and Lenovo's wall cube.
> I think that PMIC is not connected to VBUS directly. After charging
> started, BQ25892 driver can ask power adapter to increase voltage
> number of times upto 12V. See
> https://github.com/jekhor/yogabook-linux-kernel/blob/master/drivers/power/supply/bq25890_charger.c#L918
> for example.
> 
>>
>> In either case if you want to increase the max battery current to 4A
>> in the kernel, then this will have to be guarded by a DMI check.
> 
> Yes.
> 
>>
>> I beieve the way to do this wuld be throuh a device-property on the
>> charger which gets set from drivers/i2c/busses/i2c-cht-wc.c, but as
>> said this needs to be behind a DMI check, e cannot just g and boost
>> the max charge current to 4A everywhere.
> 
> Yes, I use such method already in the my kernel:
> https://github.com/jekhor/yogabook-linux-kernel/blob/master/drivers/i2c/busses/i2c-cht-wc.c#L247
> 
> Anyway, charger tweaking will be next iteration, now I want to complete
> current extcon stuff/

Ok, sounds good.

Regards,

Hans
