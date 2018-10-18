Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2879EC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58AE21476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58AE21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeJRQvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:51:45 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41374 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbeJRQvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:51:45 -0400
Received: by mail-ed1-f66.google.com with SMTP id x31-v6so27469569edd.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 01:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lXRYzyQpOEMkRfskmvfIQ94cvWbun3un/tGOvrOlWiI=;
        b=jWd3SQZe3EBIBX6YVrOBkjkA+a7V/PBiSvKK6QR8TaZxKZU5uL3jpt0ph9efagYFPO
         0gh9e4XWgyrZjP2GAIXYI/Z3OgJmsS+XXLQZrlgtAA6ttgSDiUuhwOwM2GoAHFEQpW1y
         mIJ5Z43K7jVhvr9Ixo9j8NRid+e73ebXZZgb8bFRGNNXgBBvEfWlHla3ll9hiNOH5CDa
         Vj6MIr14HdU++hNfrL4x/WgH4Yr3ooZj/YaCOFaJRit62/ZuLOmOX5AZuy02DznSs7tl
         kgF047sSMtlItrLxRGoBvlm1/sL8r+YHcqtH9JitspModiNNXJrkd+NGSiEtVYcZlJ8J
         7+3w==
X-Gm-Message-State: ABuFfogc5hfhNdmxS3QGhds5viaMVcdWuOC1TtDpcQrHToDbSw7sX7AW
        k4sSmY5FTks3UtBhUT6V0fkJXw==
X-Google-Smtp-Source: ACcGV63vqsTSKS12AJMllLb4bpXo/nP+ZwbrE4qiq26iuAp0NEZ0i7YDDyQsKhGe3Ps7EAfFYVomoQ==
X-Received: by 2002:a17:906:c7d3:: with SMTP id dc19-v6mr27967868ejb.232.1539852705356;
        Thu, 18 Oct 2018 01:51:45 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id l16-v6sm4049503eja.14.2018.10.18.01.51.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 01:51:44 -0700 (PDT)
Subject: Re: [PATCH 3/5] dt-bindings: add more optional properties for
 elan_i2c touchpads
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     robh@kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
References: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
 <20181012142413.26107-4-benjamin.tissoires@redhat.com>
 <20181017201522.GA26525@bogus>
 <CAO-hwJ+z6YdnLdbzeh-7f99cBBjHfbLKLzKo-fQQaC_W8bt_Uw@mail.gmail.com>
 <1fb98946-a518-d7d7-3bec-8944be95b91c@redhat.com>
 <CAO-hwJKXBvuGLensAQv82SoPh-vrt9UFgoC3_XeTA78EHCOANA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4a81a5d1-39c8-60f3-16be-559d43c0116a@redhat.com>
Date:   Thu, 18 Oct 2018 10:51:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAO-hwJKXBvuGLensAQv82SoPh-vrt9UFgoC3_XeTA78EHCOANA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18-10-18 10:44, Benjamin Tissoires wrote:
> On Thu, Oct 18, 2018 at 10:39 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 18-10-18 10:10, Benjamin Tissoires wrote:
>>> On Wed, Oct 17, 2018 at 10:15 PM Rob Herring <robh@kernel.org> wrote:
>>>>
>>>> On Fri, Oct 12, 2018 at 04:24:11PM +0200, Benjamin Tissoires wrote:
>>>>> Some new touchpads IC are connected through PS/2 and I2C. On some of these
>>>>> new IC, the I2C part doesn't have all of the information available.
>>>>> We need to be able to forward the touchpad parameters from PS/2 and
>>>>> thus, we need those new optional properties.
>>>>>
>>>>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1628715
>>>>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>>>> ---
>>>>>    Documentation/devicetree/bindings/input/elan_i2c.txt | 8 ++++++++
>>>>>    1 file changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/input/elan_i2c.txt b/Documentation/devicetree/bindings/input/elan_i2c.txt
>>>>> index 797607460735..ace6bcb0b4eb 100644
>>>>> --- a/Documentation/devicetree/bindings/input/elan_i2c.txt
>>>>> +++ b/Documentation/devicetree/bindings/input/elan_i2c.txt
>>>>> @@ -13,6 +13,14 @@ Optional properties:
>>>>>      pinctrl binding [1]).
>>>>>    - vcc-supply: a phandle for the regulator supplying 3.3V power.
>>>>>    - elan,trackpoint: touchpad can support a trackpoint (boolean)
>>>>> +- elan,clickpad: touchpad is a clickpad (the entire surface is a button)
>>>>
>>>>> +- elan,max_x: the maximum reported value on the X axis
>>>>> +- elan,max_y: the maximum reported value on the Y axis
>>>>> +- elan,min_x: the minimum reported value on the X axis
>>>>> +- elan,min_y: the minimum reported value on the Y axis
>>>>> +- elan,x_res: the resolution of the X axis (in units per mm)
>>>>> +- elan,y_res: the resolution of the Y axis (in units per mm)
>>>>> +- elan,width: max reported width of a blob
>>>>
>>>> Can't we use standard touchscreen properties here? (Yes, I get this is a
>>>> touchpad, not touchscreen).
>>>
>>> Hey Rob,
>>>
>>> Well, there is that (it's a touchpad driver) and we can't also really
>>> use the of_touchscreen.c implementation.
>>> If both concerns are not an issue, we can then move the [min/max/res]
>>> properties to the touchscreen ones.
>>>
>>> Regarding 'elan,width', this is something missing from the standard ts
>>> properties, and AFAICT, this controls the maximum reported
>>> width/height of a touch.
>>> I should probably rename them to max_width, max_height.
>>>
>>> Hans, do you think we should add such properties to of_touchscreen.c
>>> too? (the width/height ones)
>>
>> Are there touchscreens which report finger/touch width / height ? if so
>> then it probably does make sense.
> 
> Well, it's pretty common for hid-multitouch touchscreens to report
> such properties (it's a way to indicate the palm). Don't know about
> the touchscreens that rely on of_touchscreen though.

Now that you mention it I think some may also have some sort of
pressure/weight value, but at least for the ones I wrote I do not
think we do anything with it, since the actual meaning of the
field is somewhat vague. This is all IIRC.

>> Note that for historical reasons
>> Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> 
> Looks like your sentence is not finished here :)

I actually deleted it, but not those 2 lines, what I had written there
was that for historical reasons it uses touchscreen-size-x rather then
max-x and that that might be a bit confusing vs max-width, but I could
not come up with something better then max-width, so I deleted my
rambling, but ended up not deleting all of it :)

>> Also the touchscreen bindings have: touchscreen-x-mm and touchscreen-y-mm
>> rather then res, which can then be used to calculate the resolution.
>>
> 
> yeah, that's fine, I would need to convert to mm, then go back to res.
> Extra effort, but that's the price to pay.

Ack.

Regards,

Hans

