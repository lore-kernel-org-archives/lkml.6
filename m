Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DF2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48163208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyATjVRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48163208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeK1HhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:37:09 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44161 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeK1HhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:37:09 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so21296947lji.11;
        Tue, 27 Nov 2018 12:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZwcpJra+WLSGwyVUNDL77BIBVOEDmS84RPuk+4OIRXM=;
        b=hyATjVRychXG6CHDyoxzPkuXMJd89vlEASchCLb78X7lMmPEa0vpxWV3cRD2FNMeEM
         7jgKmbu/HnDru7pTPQqgkh72W05XStmfQg+TNOiEF5KIse8zjc6GnhjdFIRJxSBYzXPs
         bPc5zFCWL9GOKdgTzJnpAa0b1zc3UAPSYg+yiEmUSmyiYyXSiWo0Sez1o06n+XRgLTMN
         tDKjEotj/L5dOJQy2cShxpqKpPI8Baj7Aqh9ABG0ND2giEvQ6Ig8T8czyX0VsUVdEiyM
         dWZ3dOkUDGCNJe2wz1RwUccxjAsRPsrow35GBkpOVA0oE+jf0oNLuhXs0Uf/nj60Uoqc
         Wr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZwcpJra+WLSGwyVUNDL77BIBVOEDmS84RPuk+4OIRXM=;
        b=JjKHbsKTJyecz/eNxtj2jhb73Jmn4ImcGPLonvGHuaOOKlSHaBpB+yag5Okum9SdZE
         5+x8TbKpEY8NGNopD/WX6MqkfSTZIJEvpwXOYPXj58BbWL+SC1w33KsAtFFiMS2fLUiz
         KuFzOUOvv7N5YEMlwL4wOaEUpxKYCg9gTjNI/jVCND9k2vc2GXwtAdCrzCq2G3ZEY3Cj
         ZK3JnFQ47FPK+dzGE3/iGoC3mImJ5ivGERIe7KiwvWaT6dKugLA0G6Lnqij1ttg1nWqk
         LWYEyRkMaXrNurqkKWfCHTBKJoPSJiBMYYgw+oZLxihmvIkARjYhYXKHItlcAWnzOMaD
         mmuQ==
X-Gm-Message-State: AA+aEWa4SVLqaV7+ns5K7xDjFupdsu4zW3ituLGWH+8DFS9JgGktxzWE
        DWM/B6gd/4lolGkQchokqWo=
X-Google-Smtp-Source: AFSGD/VkYsmdgAHQ5TFXIRa+eWvcU+oGP9Aw+kvmaX0PNiAgZljSrz0zBlkK3zAWdE2fUm5s+r3cJQ==
X-Received: by 2002:a2e:4503:: with SMTP id s3-v6mr19289458lja.44.1543351080168;
        Tue, 27 Nov 2018 12:38:00 -0800 (PST)
Received: from [192.168.1.18] (ckc106.neoplus.adsl.tpnet.pl. [83.31.78.106])
        by smtp.gmail.com with ESMTPSA id f8sm942940lfe.72.2018.11.27.12.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 12:37:59 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH 04/24] dt-bindings: leds: Add function and color
 properties
To:     Rob Herring <robh@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-5-git-send-email-jacek.anaszewski@gmail.com>
 <5bea0eb8.1c69fb81.6b921.80e6@mx.google.com>
 <dfb5bd23-bcb9-7501-a608-969cb0464168@gmail.com>
Message-ID: <0a0b176c-4eb4-4b0e-6c3c-b3c6c8f5fff5@gmail.com>
Date:   Tue, 27 Nov 2018 21:37:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <dfb5bd23-bcb9-7501-a608-969cb0464168@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/2018 09:57 PM, Jacek Anaszewski wrote:
> On 11/12/2018 07:27 PM, Rob Herring wrote:
>> On Tue, Nov 06, 2018 at 11:07:12PM +0100, Jacek Anaszewski wrote:
>>> Introduce dedicated properties for conveying information about
>>> LED function and color. Mark old "label" property as deprecated.
>>>
>>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>>> Cc: Baolin Wang <baolin.wang@linaro.org>
>>> Cc: Daniel Mack <daniel@zonque.org>
>>> Cc: Dan Murphy <dmurphy@ti.com>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
>>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>>> Cc: Simon Shields <simon@lineageos.org>
>>> Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
>>> ---
>>>  Documentation/devicetree/bindings/leds/common.txt | 52 +++++++++++++++++++----
>>>  1 file changed, 44 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
>>> index aa13998..3efc826 100644
>>> --- a/Documentation/devicetree/bindings/leds/common.txt
>>> +++ b/Documentation/devicetree/bindings/leds/common.txt
>>> @@ -10,14 +10,20 @@ can influence the way of the LED device initialization, the LED components
>>>  have to be tightly coupled with the LED device binding. They are represented
>>>  by child nodes of the parent LED device binding.
>>>  
>>> +
>>>  Optional properties for child nodes:
>>>  - led-sources : List of device current outputs the LED is connected to. The
>>>  		outputs are identified by the numbers that must be defined
>>>  		in the LED device binding documentation.
>>> +- function: LED functon. Use one of the LED_FUNCTION_* prefixed definitions
>>> +	    from the header include/dt-bindings/leds/functions.h.
>>> +	    If there is no matching LED_FUNCTION available, add a new one.
>>> +- color : Color of the LED.
>>>  - label : The label for this LED. If omitted, the label is taken from the node
>>>  	  name (excluding the unit address). It has to uniquely identify
>>>  	  a device, i.e. no other LED class device can be assigned the same
>>> -	  label.
>>> +	  label. This property is deprecated - use 'function' and 'color'
>>> +	  properties instead.
>>
>> I don't know if I'd go as far a deprecating.
>>
>> One thing to consider is how we handle multiple of the same function? Do 
>> we allow an index on function names? What if an index isn't meaningful 
>> and we need "front" vs. "rear" for example? Maybe label is still needed 
>> there. 
> 
> I believe that 'label' property with its old semantics must be preserved
> for backwards compatibility - it so far has been used inconsistently for
> conveying variations of devicename:color:function sections. If provided,
> then it's been taken as-is for LED class device name, or concatenated
> with the devicename hard-coded in the driver.
> 
> Regarding the differentiation between the LEDs with functions of
> same kind - OK, I agree, we will need another section.
> 
> What seems to fits the best is the reference to the device it is
> logically associated with.
> 
> The question is whether the devicename should be provided in DT
> literally, or by phandle, and then retrieved in runtime, basing on the
> sysfs entry, like in case of input-leds bridge which for USB keyboard
> creates LEDs named e.g.:
> 
> input5::capslock
> input5::numlock
> input5::scrolllock
> 
> Probably we will have to allow for some flexibility in this regard,
> to allow for providing devicename literally like "rear", "front",
> or like above input case.

I must admit I have a dilemma  with this devicename part.
Thinking more of it - the semantics of that section of LED
class device name needs to be precise. Currently there seem
to be two types of device names considered:

1) descriptive name like in case of flash -
   front-camera::flash, rear-camera::flash, which would allow
   for providing arbitrary devicenames, i.e. it would not improve
   LED naming too much, which was the aim of this patch set
2) name representing hardware relation or user-defined relation between
   some device and the LED class device, like in above keyboard
   LED case:

   - input5::numlock

   or for hard disk:

   - sda1::hdderr,

   In the hdderr case Pavel mentioned the arrangement where the LED
   is not a part of the hard disk, so the relation would have to be
   defined in DT.
   For the flash case the devicename part would be matching /dev/videoN
   device.

I'm in favour of the option 2) since it seems to be more precise.
In this case we would need a mechanism for asynchronous LED class
device registration which would register a LED only after the
associated device has been probed and its name is known.
The mechanism would be a simpler form of
drivers/media/v4l2-core/v4l2-async.c.

In the LED DT node we would need a property holding a phandle
to the associated device. Then, in the runtime the related device
would call led_register_associated_device(struct device_node*,
struct device*) which would in turn match the device_node with
the phandle assigned to the property in the LED DT node. Having
the struct device of the associated device we could retrieve
device node name from dev->kobj.

We would also probably need different DT properties for different
types of devices, since e.g. for network case the network interface
name would fit better for the LED name, than the phy name,
and we would need to know what type of device name we're going
to look for.

Pavel gave following examples:

eth0:green:link
adsl0:green:link
adsl0:red:error

So we would have e.g.:

associated-vl42-device = <&camera1>;
associated-network-device = <&phy1>;
associated-block-device = <&phy1>;

Currently I have no idea how to obtain related network interface
name by struct device related to the network device phy, but
I believe it is possible.

I'm open to suggestions on what direction it should go.

I only wonder if such a solution wouldn't be an over-engineering.

Other ideas are welcome.

-- 
Best regards,
Jacek Anaszewski
