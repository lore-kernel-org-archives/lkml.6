Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38D4C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1A42145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1A42145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbeJRQjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:39:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45129 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeJRQjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:39:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id m6-v6so3930122eds.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 01:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CpsJXHZBjkymFn7scXJAAfRlAIJa6X4t9DZ+/c8lAS8=;
        b=GHTPs98AUIJ/JLa71SdKihrAM6Z49hP8dutSjEksieRVVPsx/+OPJKySMOIdcBl7dR
         Xf4MMnKNijGGzRl3loYGz/yH2T3kvg+AGISk/rwfISC22QsZiHkG88Fcf7zUktzFvHpC
         bTBWEGoCywe8HOz7tmKTjzPzXNi6PQGbsdKRw2y372KkiJF7MUlpqnv3nH8EAf+Ugc9E
         YteYzTySGyYbsA79nhRvCGc6H8Jl66Je7AD1hFUw/yrdOHBRxuYE9SonQSkczVq/Nvff
         d0XbjVygHry1ramTgJlFluxOMMO3UVfLFJ36KO4sS7/uMqPH25hY9jHs8EzNSjpX0a82
         rxBg==
X-Gm-Message-State: ABuFfojJOaQykYiF7XrShVhLpaa819tzW6sKEIgZdWisjzje6AyY6oQn
        OV4EUORf5aa6oeCMKCplXfCh0g==
X-Google-Smtp-Source: ACcGV62f/d2QUNIdkj4m0I4s8ZZ6MGTkawODQv9BiDw2pZJDjTcMzmMewk2yH2/o0/jnRfhB8UcSjg==
X-Received: by 2002:a17:906:c7d3:: with SMTP id dc19-v6mr27949170ejb.232.1539851980629;
        Thu, 18 Oct 2018 01:39:40 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id r55-v6sm11253814edd.80.2018.10.18.01.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 01:39:40 -0700 (PDT)
Subject: Re: [PATCH 3/5] dt-bindings: add more optional properties for
 elan_i2c touchpads
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>, robh@kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
References: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
 <20181012142413.26107-4-benjamin.tissoires@redhat.com>
 <20181017201522.GA26525@bogus>
 <CAO-hwJ+z6YdnLdbzeh-7f99cBBjHfbLKLzKo-fQQaC_W8bt_Uw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1fb98946-a518-d7d7-3bec-8944be95b91c@redhat.com>
Date:   Thu, 18 Oct 2018 10:39:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAO-hwJ+z6YdnLdbzeh-7f99cBBjHfbLKLzKo-fQQaC_W8bt_Uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18-10-18 10:10, Benjamin Tissoires wrote:
> On Wed, Oct 17, 2018 at 10:15 PM Rob Herring <robh@kernel.org> wrote:
>>
>> On Fri, Oct 12, 2018 at 04:24:11PM +0200, Benjamin Tissoires wrote:
>>> Some new touchpads IC are connected through PS/2 and I2C. On some of these
>>> new IC, the I2C part doesn't have all of the information available.
>>> We need to be able to forward the touchpad parameters from PS/2 and
>>> thus, we need those new optional properties.
>>>
>>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1628715
>>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>> ---
>>>   Documentation/devicetree/bindings/input/elan_i2c.txt | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/input/elan_i2c.txt b/Documentation/devicetree/bindings/input/elan_i2c.txt
>>> index 797607460735..ace6bcb0b4eb 100644
>>> --- a/Documentation/devicetree/bindings/input/elan_i2c.txt
>>> +++ b/Documentation/devicetree/bindings/input/elan_i2c.txt
>>> @@ -13,6 +13,14 @@ Optional properties:
>>>     pinctrl binding [1]).
>>>   - vcc-supply: a phandle for the regulator supplying 3.3V power.
>>>   - elan,trackpoint: touchpad can support a trackpoint (boolean)
>>> +- elan,clickpad: touchpad is a clickpad (the entire surface is a button)
>>
>>> +- elan,max_x: the maximum reported value on the X axis
>>> +- elan,max_y: the maximum reported value on the Y axis
>>> +- elan,min_x: the minimum reported value on the X axis
>>> +- elan,min_y: the minimum reported value on the Y axis
>>> +- elan,x_res: the resolution of the X axis (in units per mm)
>>> +- elan,y_res: the resolution of the Y axis (in units per mm)
>>> +- elan,width: max reported width of a blob
>>
>> Can't we use standard touchscreen properties here? (Yes, I get this is a
>> touchpad, not touchscreen).
> 
> Hey Rob,
> 
> Well, there is that (it's a touchpad driver) and we can't also really
> use the of_touchscreen.c implementation.
> If both concerns are not an issue, we can then move the [min/max/res]
> properties to the touchscreen ones.
> 
> Regarding 'elan,width', this is something missing from the standard ts
> properties, and AFAICT, this controls the maximum reported
> width/height of a touch.
> I should probably rename them to max_width, max_height.
> 
> Hans, do you think we should add such properties to of_touchscreen.c
> too? (the width/height ones)

Are there touchscreens which report finger/touch width / height ? if so
then it probably does make sense. Note that for historical reasons
Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

Also the touchscreen bindings have: touchscreen-x-mm and touchscreen-y-mm
rather then res, which can then be used to calculate the resolution.

Regards,

Hans
