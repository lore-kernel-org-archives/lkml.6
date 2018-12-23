Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF9EC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 20:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE1C217D7
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 20:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJTvojpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbeLWULz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 15:11:55 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40780 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeLWULz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 15:11:55 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18-v6so9022648lji.7;
        Sun, 23 Dec 2018 12:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ALKclvEEQ2z4N2B5P1PZsuLcaqz4m7od/aY8t4+e9gM=;
        b=KJTvojpArzOrXEIdei2W/WZIasZmpQjnaJAPCHiygs93VKnlHfKPp1wKRwgxBO1NkR
         zKHWNF6GJhBJDsAV6K6x0hgnJq3FzKq+UWkghm0ba/3czV3kK6v2ONWY6qV5za0KeX7d
         sCabclJTrwyMS45YC+DJ9cMmxdWgqBdojebSssTSvuSRgiM0LEqBqi7Ba8FJOX3pnOHv
         QdSYgwokHdlQzJ7I49vhPW/EeHqW+cGLdQQo7FAAYG34nN4Qu4aOd9EZyrRJVDktBUTW
         TAhIhjukCrnFqfIQSqUrtWDN3U2FhLom1/7FQ2STbHx/Es8itqOcMfAsMZ57vbaieQUP
         LCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ALKclvEEQ2z4N2B5P1PZsuLcaqz4m7od/aY8t4+e9gM=;
        b=MKGiOVKeE+/qE538No7RIlgQ4rxozoE/XRqmlAd/R4gJeNipVfjlYQ5EOhQRjPNjhP
         il/jRE+2CbEke/V9Gg69UihWYktHbQkICWox0nU0OrAfyb+uQHzeVqTAaotVQAwwG7yc
         t1lLNvseEie/rqTRBEC0iuw3ymuHkUtbH2MPl4Rt/YOXMbXNkPdUsTfYyfLQ8xBIwgCa
         65fxdPe2Frt9sRugqmC3QQxkfaEUR/NaLkTqJIREg+AD+1NLsYpWHYdD6eJwySJ2YjZ8
         YnyrEphop3cvxHsx2mhXxSmLIaUMKFlToLRStGqQIKjCx63YRlFsIARzLEY5Fj8wVOX2
         yd9A==
X-Gm-Message-State: AJcUukckO34Zo+ZnWo2jV0js8q+uVxYwdjRlxEIpqzqrs2dAfGq/8Aq8
        qKXbueLy51J8+JVhzdl0eAk=
X-Google-Smtp-Source: ALg8bN6UkjHV1Wx//2QrDK2cJa25SAFiuvNFpbDugK+qCdOVho0rfJEN2QGbKt4SyR2fcMC76EEkTw==
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr6650121ljb.52.1545595911607;
        Sun, 23 Dec 2018 12:11:51 -0800 (PST)
Received: from [192.168.1.18] (dqd235.neoplus.adsl.tpnet.pl. [83.24.163.235])
        by smtp.gmail.com with ESMTPSA id h22-v6sm2536259lji.45.2018.12.23.12.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 12:11:50 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH 04/24] dt-bindings: leds: Add function and color
 properties
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>
Cc:     Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
 <0a0b176c-4eb4-4b0e-6c3c-b3c6c8f5fff5@gmail.com>
 <CAL_JsqKEpbJjExkQKSXwYma9wPPO+8E0QMTyWTPs1nkGSd49_g@mail.gmail.com>
 <20181212095929.GA13437@amd>
 <CAL_JsqJPMzwU9h2RSXeCfNTO5+zs7xTOb9jYcGivj+v_2RkG2A@mail.gmail.com>
 <20181212183253.GA16578@amd>
Message-ID: <5084ad0d-8673-8151-d676-b5c60dd510ee@gmail.com>
Date:   Sun, 23 Dec 2018 21:11:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181212183253.GA16578@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/18 7:32 PM, Pavel Machek wrote:
> On Wed 2018-12-12 07:56:20, Rob Herring wrote:
>> On Wed, Dec 12, 2018 at 3:59 AM Pavel Machek <pavel@ucw.cz> wrote:
>>>
>>> Hi!
>>>
>>>>> We would also probably need different DT properties for different
>>>>> types of devices, since e.g. for network case the network interface
>>>>> name would fit better for the LED name, than the phy name,
>>>>> and we would need to know what type of device name we're going
>>>>> to look for.
>>>>>
>>>>> Pavel gave following examples:
>>>>>
>>>>> eth0:green:link
>>>>> adsl0:green:link
>>>>> adsl0:red:error
>>>>>
>>>>> So we would have e.g.:
>>>>>
>>>>> associated-vl42-device = <&camera1>;
>>>>> associated-network-device = <&phy1>;
>>>>> associated-block-device = <&phy1>;
>>>>
>>>> Variable property names are kind of a pain to parse.
>>>>
>>>> Perhaps when LEDs are associated with a device, we shouldn't care
>>>> within the context of the LED subsystem what the name is. The
>>>> association is more important and if you have that exposed, then you
>>>> don't really need to care what the name is. You still have to deal
>>>> with a device with more than 1 LED, but that becomes a problem local
>>>> to that device.
>>>>
>>>> What I'm getting at is following a more standard binding pattern of
>>>> providers and consumers like we have for gpios, clocks, etc. So we'd
>>>> have something like this:
>>>>
>>>> ethernet {
>>>>    ...
>>>>    leds = <&green_led>, <&red_led>;
>>>>    led-names = "link", "err";
>>>> };
>>>>
>>>> We can still support defining LED names as we've done, but we don't
>>>> have to come up with some elaborate naming convention that covers
>>>> every single case.
>>>
>>> I see that it would be more consistent with how gpios work, but I'm
>>> afraid this does not fit LEDs properly.
>>>
>>> With power LED, you want to be able to say "this is just on". Some
>>> poeple like heartbeat, and have LED for that. There may be LED for
>>> "disk activity", meaning activity on any harddrive. And there may be
>>> activity LED for specific disk.
>>>
>>> Only in the last case it would be suitable to have LED reference as a
>>> child of an device...
>>
>> Right. For all the other cases, why do you need any link with a
>> device? What we have today is sufficient and can continue to be
>> supported. A link to a device is only used if the led is associated
>> with a particular device.
> 
> Right, so the link is only needed in some cases. So unlike your
> example, we would have:
> 
> led1 { led-meaning = "heartbeat"; }
> led2 { led-meaning = "link"; }
> led3 { led-meaning = "err"; }
> led4 { led-meaning = "activity"; what-activity = "all_harddisks"; }
> ethernet { leds = < &led2, &led3 >; }
> 
> Dunno. I'd expect all the LED description in the LED node, not part of
> the description there and back link from the device

Driven by the feeling that it's all going in a wrong direction
I've done a bit more analysis - please refer below to my conclusions.

We already have a means for associating LEDs connected to standalone LED
controllers with other devices - this is LED trigger mechanism.
The association can be discovered by reading "trigger" sysfs file.

Device drivers can even create their own custom triggers, comprising
device node name or phy name in their names, which are known only during
driver probing, which allows to better describe the association than the
generic ones.

When it comes to devices with built-in LEDs - let's check how network
devices handle their LEDs. I've looked into ralink wireless driver:

drivers/net/wireless/ralink/rt2x00/rt2x00leds.c

It registers its LEDs in rt2x00leds_register(),
and composes names according to the following pattern:

    snprintf(name, sizeof(name), "%s-%s::assoc",
             rt2x00dev->ops->name, phy_name);

    snprintf(name, sizeof(name), "%s-%s::quality",
             rt2x00dev->ops->name, phy_name);

    snprintf(name, sizeof(name), "%s-%s::radio",
             rt2x00dev->ops->name, phy_name);

which results in the following LED names for wifi dongle:

rt73usb-phy16::assoc -> 
../../devices/pci0000:00/0000:00:14.0/usb2/2-8/2-8:1.0/leds/rt73usb-phy16::assoc
rt73usb-phy16::quality -> 
../../devices/pci0000:00/0000:00:14.0/usb2/2-8/2-8:1.0/leds/rt73usb-phy16::quality
rt73usb-phy16::radio -> 
../../devices/pci0000:00/0000:00:14.0/usb2/2-8/2-8:1.0/leds/rt73usb-phy16::radio

As it is shown, each entry under /sys/class/CLASS_NAME is a symbolic
link to the class device sub-directory located in the parent device
directory. In this case, even if we hadn't phy name in the LED name,
we could retrieve it by traversing parent device directory in the
sysfs:

../../devices/pci0000:00/0000:00:14.0/usb2/2-8/2-8:1.0/ieee80211/phy16/

We have also available additional device and driver specific info
in the uevent file:

../../devices/pci0000:00/0000:00:14.0/usb2/2-8/2-8:1.0/uevent:DEVTYPE=usb_interface
../../devices/pci0000:00/0000:00:14.0/usb2/2-8/2-8:1.0/uevent:DRIVER=rt73usb
../../devices/pci0000:00/0000:00:14.0/usb2/2-8/2-8:1.0/uevent:PRODUCT=148f/2573/1
../../devices/pci0000:00/0000:00:14.0/usb2/2-8/2-8:1.0/uevent:TYPE=0/0/0
../../devices/pci0000:00/0000:00:14.0/usb2/2-8/2-8:1.0/uevent:INTERFACE=255/255/255
../../devices/pci0000:00/0000:00:14.0/usb2/2-8/2-8:1.0/uevent:MODALIAS=usb:v148Fp2573d0001dc00dsc00dp00icFFiscFFipFFin00

In addition to that the driver registers also its own triggers,
that associate the LEDs it exposes with the particular phy and the
function: phy16rx phy16tx phy16assoc phy16radio.

This is the pattern to be followed also in case user wants to
associate standalone LEDs with the device. Driver of a device
that lacks onboard LEDs would have to register suitable trigger
and that's it.

In case of keyboard LEDs we have similar symlinks:

input0::capslock -> 
../../devices/pci0000:00/0000:00:14.0/usb2/2-3/2-3:1.0/0003:1C4F:0002.0001/input/input0/input0::capslock
input0::numlock -> 
../../devices/pci0000:00/0000:00:14.0/usb2/2-3/2-3:1.0/0003:1C4F:0002.0001/input/input0/input0::numlock
input0::scrolllock -> 
../../devices/pci0000:00/0000:00:14.0/usb2/2-3/2-3:1.0/0003:1C4F:0002.0001/input/input0/input0::scrolllock

#cat 
/sys/devices/pci0000:00/0000:00:14.0/usb2/2-3/2-3:1.0/0003:1C4F:0002.0001/uevent 

DRIVER=hid-generic
HID_ID=0003:00001C4F:00000002
HID_NAME=SIGMACHIP USB Keyboard
HID_PHYS=usb-0000:00:14.0-3/input0
HID_UNIQ=
MODALIAS=hid:b0003g0001v00001C4Fp00000002

Having all the above it seems that we can safely remove devicename
section from LED class device naming pattern. Also no other links
in DT will be needed if we will entirely rely on LED trigger mechanism.

-- 
Best regards,
Jacek Anaszewski
