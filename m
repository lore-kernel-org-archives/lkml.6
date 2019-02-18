Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8712C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F80420838
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbfBRJYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:24:46 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39066 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbfBRJYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:24:45 -0500
Received: by mail-ed1-f68.google.com with SMTP id p27so5666256edc.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 01:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9e7PSIuyn5oInq+/JOF5GrvSV8UZzC/AkHaNtDdEfr0=;
        b=gKP2OlvEPPHxT+VvsK/U1wJFzvzeS7/Vnxuge6RSl/8ijA/5Vm3oy2FcwVd4LYIVLH
         bplK0ioaSgu7axu+R8UTNLHL/MVSNA33+gpAFfeVRWRse4G+7MYIDD3+R0u0IFIo6rN7
         B7HZwBDRvlHxNL6qLOt4y/PmENN6dpvNmNkdPrQop2RucIKRbjPQuS1ey4g+SfYxZOLs
         jMIT52lxecVWUqt0F/Vd3ZYvQFMUJAr6rSu2/EoNM+KmuRW/AmWGG/+r8IeWQU9+eAIU
         l6KzjvhraR5rS0P09GdqAlMP/tRfi6anaf3FlGt15UU3yjHNIMMa3F4S50RO4CP3G8yL
         5IyQ==
X-Gm-Message-State: AHQUAubpx06m2UcGicKA1N9Xxcv2O5RclPdmBRvj+XhhvyU9S2gln35o
        YwBOn88hEo4y4oCFzBQtpRsMu0Ci/fA=
X-Google-Smtp-Source: AHgI3IbeYTs6M9DVYRcQ5jWb6K7mQgKKJukF5x8Pb7S/F5jIAYGzblO7pwoU6J8qH9gokERdw6kz+A==
X-Received: by 2002:a50:adfa:: with SMTP id b55mr18601118edd.160.1550481881220;
        Mon, 18 Feb 2019 01:24:41 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id s12sm2584188edb.11.2019.02.18.01.24.40
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 01:24:40 -0800 (PST)
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <416a0e12-aa0e-e781-2ef2-f11b97ba77a0@redhat.com>
Date:   Mon, 18 Feb 2019 10:24:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190217215242.GA12656@jeknote.loshitsa1.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17-02-19 22:52, Yauhen Kharuzhy wrote:
> On Fri, Feb 15, 2019 at 09:32:50AM +0300, Yauhen Kharuzhy wrote:
>> On Thu, Feb 14, 2019 at 05:31:48PM +0100, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 10-02-19 21:36, Yauhen Kharuzhy wrote:
>>>> In some configuration external charge "#charge enable" signal is
>>>> connected to PMIC. Enable it at device probing to allow charging.
>>>>
>>>> Tested at Lenovo Yoga Book (YB1-X91L).
>>>>
>>>> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
>>>> ---
>>>>    drivers/extcon/extcon-intel-cht-wc.c | 33 ++++++++++++++++++++++++++++
>>>>    1 file changed, 33 insertions(+)
>>>>
>>>> diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
>>>> index 4f6ba249bc30..00cb3084955e 100644
>>>> --- a/drivers/extcon/extcon-intel-cht-wc.c
>>>> +++ b/drivers/extcon/extcon-intel-cht-wc.c
>>>> @@ -57,6 +57,11 @@
>>>>    #define CHT_WC_USBSRC_TYPE_OTHER	8
>>>>    #define CHT_WC_USBSRC_TYPE_DCP_EXTPHY	9
>>>> +#define CHT_WC_CHGDISCTRL		0x5e2f
>>>> +#define CHT_WC_CHGDISCTRL_CCSM_DIS	0x11
>>>> +#define CHT_WC_CHGDISCTRL_CCSM_EN	0x00
>>>
>>> Hmm, the enable mask here does not match the enable mask from:
>>>
>>> https://github.com/01org/ProductionKernelQuilts/blob/master/uefi/cht-m1stable/patches/EM-Charger-Disable-battery-charging-in-S3-and-enable.patch
>>>
>>> Which has:
>>>
>>> #define CHGDISFN_EN_CCSM_VAL           0x50
>>> #define CHGDISFN_DIS_CCSM_VAL          0x11
>>> #define CHGDISFN_CCSM_MASK             0x51
>>>
>>> Where as on my hardware, the PMIC comes up with 0x50
>>> in the 0x5e2f register, exactly matching the values
>>> from that patch.
>>>
>>> Why did you change this value ?
>>
>> Good question... I found this values in Lenovo's sources and use them
>> 'as is':
>> https://github.com/jekhor/yogabook-linux-android-kernel/blob/b7aa015ab794b516da7b6cb76e5e2d427e3b8b0c/drivers/power/intel_pmic_ccsm.h#L255
>>
>> I don't remember if charger worked with Intel's value, I need to
>> re-check this.
> 
> As we know now, value 0x50 meaning is:
> - HW mode
> - regular output type
> - low level at output
> 
> 0x00 meaning is:
> - SW mode
> - open-drain output
> - low level at output
> 
> I don't know what exactly "HW/SW mode" means but I suppose that this pin
> can be controlled by PMIC internal charge state algorithm (if it is
> enabled) or by software (extcon driver).
> 
> So, if we set 0x50 value and disable HW-controlled charging entirely (as
> extcon driver does), we don't set 'charger enable' signal to low as
> expected. Its exactly state is unknown, but I checked – it is HIGH.
> Charger doesn't start charging with this value and starts with 0x00.
> 
> 0x0b register of 0x6b device on bus 7 – it is the status register of BQ25892
> charger, where bits 3,4 describe charging state, 10b means fast charging,
> 00b means not charging.
> 
> root@yogabook:/home/jek# i2cset -y -f 6 0x5e 0x2f 0x00
> root@yogabook:/home/jek# i2cget -y -f 7 0x6b 0x0b
> 0x16
> root@yogabook:/home/jek# i2cset -y -f 6 0x5e 0x2f 0x01
> root@yogabook:/home/jek# i2cget -y -f 7 0x6b 0x0b
> 0x06
> root@yogabook:/home/jek# i2cset -y -f 6 0x5e 0x2f 0x10
> root@yogabook:/home/jek# i2cget -y -f 7 0x6b 0x0b
> 0x16
> root@yogabook:/home/jek# i2cset -y -f 6 0x5e 0x2f 0x11
> root@yogabook:/home/jek# i2cget -y -f 7 0x6b 0x0b
> 0x06
> root@yogabook:/home/jek# i2cset -y -f 6 0x5e 0x2f 0x50
> root@yogabook:/home/jek# i2cget -y -f 7 0x6b 0x0b
> 0x06
> root@yogabook:/home/jek# i2cset -y -f 6 0x5e 0x2f 0x51
> root@yogabook:/home/jek# i2cget -y -f 7 0x6b 0x0b
> 0x06
> 
> 
> After reading of Intel's and Lenovo's sources i understood that Intel's
> meaning of CHGDISFN_EN_CCSM_VAL is 'enable HW control of charging' and
> Lenovo's is 'enable charging'. Lenovo set this value immediately after
> probing and after resume, Intel – only after resume. HW-controlled
> charging is disabled entirely at probing, so I don't know how Intel's
> driver enables charging.
> 
> So, I propose:
> 
> 1) save initial value of CHGDIS register for restoring it at driver
> remove (because the extcon-intel-cht-wc driver restores HW control in
> cht_wc_extcon_remove()).
> 2) at driver start, enable SW control of CHGDIS and set its value to 0.
> 3) at driver removing, restore the saved state.

This sounds good to me, note I believe the extcon code should not touch
bit 4 (open-drain,vs regular), but since we disable the charger state-machine
we should obviously then switch the pin to sw mode and drive the pin low
so that the charger still works.

I believe that on the GPD win / GPD pocket the chgdis pin of the PMIC
is not connected to the charger, since writing different values to reg
5e2f has no effect there.

I do wonder how this interacts with inserting an otg-host cable into
the micro-usb, I mean a cable like this:

https://alexnld.com/wp-content/uploads/2013/11/S-UDC-103.jpg

A cable like this will short the id-pin to ground and at this point
we should disable the charger and enable a 5V boost converter to
supply 5V to the device connected to the USB-A connector.

On the GPD win / GPD pocket this is controlled through the Type-C
framework and the V5 boost converter is actually part of the
charger-IC, so charging gets disabled automatically when we tell
the charger-IC to do enable its 5V boost converter.

Do you already have an idea how to deal with this, it might be good
to have at least an idea how we want to handle 5V boost before we
merge the patch to control the CHGDIS pin, since we may need to
disable the charger when the id-pin is connected to GND, so that
the charger does not try to charge from the output of the 5V boost
converter, which happens when an external 5v boost converter is used.

I also wonder if you've considered just disabling the extcon driver
for the PMIC leaving it in automatic mode. Unlike the GPD win / pocket
with their Type-C connector, your device seems to actually be using
the PMIC as it was designed, so the automatic mode might just work
and not touching the PMIC at all might be best.

> Q: In theory, enabling of 'charge enable' output without of properly
> configuration of external charger can cause some problems (USB overload,
> battery overcurrent etc.). I think that there are no such stupidly
> designed devices exist but we cannot be sure. What should we do with this?

This should not be a problem, the input-current-limit of the charger
will already be setup by the firmware at boot and if a charger gets
plugged in later then the input-current-limit will reset to 500mA.

Likewise the max charging current for the battery should already
be configured properly by the firmware (this must be the case since
the device will also charge while off) and we don't even know what
the max charging current for the battery is, so we just have to rely
on the firmware/BIOS here.

>>> It would be interesting to get a dump of the
>>> charger's i2c registers using i2cdump before
>>> and after writing this new value to register
>>> 0x5e2f. Note you can simply leave the patch adding
>>> the write out of the kernel, and then do:
>>>
>>> i2cdump <charger>
>>> i2cget -y -f 6 0x5e 0x2f
>>> # check 0x00 is the correct val
>>> i2cset -y -f 6 0x5e 0x2f 0x00
>>> i2cdump <charger>
>>>
>>> To see if any reg values of the charger-ic have changed.
>>>
>>> Note bus 6 is the right bus for the PMIC on my systems,
>>> but it might be different, to find the right bus do:
>>>
>>> ls -l /sys/bus/devices/i2c-INT34D3:00
>>>
>>> And look at what the i2c bus-number is in that symlink.
>>>
>>>
>>> Also can you please provide i2cdump output for the
>>> 0x5e and 0x6e devices of the PMIC, preferably from a
>>> clean boot, without your patches, so that we can
>>> see what the value of the 0x5e2f register is before
>>> your code modifies it.
>>>
>>> i2cdump -y -f 6 0x5e
>>> i2cdump -y -f 6 0x6e
> 
> linux-next (5.0.0-rc5-next-20190208+), extcon module is disabled,
> charger is connected before power-on:
> 
> root@yogabook:/home/jek# i2cdump -f -y 6 0x5e
> No size specified (using byte-data access)
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 ff 00 XX XX 03 00 00 50 00 XX XX 09 XX 00 XX    ...XX?..P.XX?X.X
> 10: 00 00 4a 01 0b 0b 10 80 01 29 01 XX 00 74 04 1b    ..J??????)?X.t??
> 20: 06 ff 00 6b 00 6b 0a 03 73 8a 03 ff 6c 6c 00 10    ?..k.k??s??.ll.?
> 30: 02 0e 00 fe 00 00 03 ff 00 51 01 3b 01 a7 01 62    ??.?..?..Q?;???b
> 40: 00 42 00 42 00 9f 00 9f 00 9f 00 d2 00 d2 00 d2    .B.B.?.?.?.?.?.?
> 50: 01 09 00 4d 00 8e 00 d3 01 11 01 56 02 XX XX XX    ??.M.?.????V?XXX
> 60: XX 02 0b ff 6a 6c 0e 26 34 44 52 60 XX XX XX XX    X??.jl?&4DR`XXXX
> 70: 00 00 00 00 00 00 00 00 00 00 00 XX XX XX XX XX    ...........XXXXX
> 80: XX 00 00 00 XX XX 00 00 00 00 00 00 00 00 00 00    X...XX..........
> 90: 00 XX XX XX XX XX XX ff ff ff ff ff ff ff ff ff    .XXXXXX.........
> a0: ff ff XX XX XX XX XX XX 00 00 XX XX XX XX XX XX    ..XXXXXX..XXXXXX
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 
> root@yogabook:/home/jek# i2cdump -f -y 6 0x6e
> No size specified (using byte-data access)
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 01 02 00 00 00 80 00 18 0d XX 11 00 00 80 af 00    ??...?.??X?..??.
> 10: 00 00 b0 00 1a ff XX 11 XX 60 03 XX 00 XX 15 00    ..?.?.X?X`?X.X?.
> 20: 00 00 00 0c ac 0b 5a 11 10 0c 1f 18 2b 00 00 XX    ...???Z?????+..X
> 30: 4a 4a XX 08 09 00 09 01 09 08 08 00 38 XX XX XX    JJX??.?????.8XXX
> 40: XX XX XX 09 08 XX XX XX XX XX XX XX XX XX XX XX    XXX??XXXXXXXXXXX
> 50: XX XX XX 0f XX XX 07 00 07 01 01 9b 63 01 07 01    XXX?XX?.????c???
> 60: XX XX XX 02 06 06 06 00 06 20 00 00 66 00 XX XX    XXX????.? ..f.XX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 80: XX XX XX XX XX XX XX XX XX XX XX 37 XX XX XX XX    XXXXXXXXXXX7XXXX
> 90: 01 01 XX XX XX 01 XX XX XX 01 01 01 01 00 01 01    ??XXX?XXX????.??
> a0: 01 01 01 01 XX XX XX XX XX XX XX XX XX XX XX XX    ????XXXXXXXXXXXX
> b0: XX XX XX XX 12 14 ad XX 00 00 00 18 00 XX XX XX    XXXX???X...?.XXX
> c0: 1f 1f 1f 14 14 1f 3d 34 3d 33 33 3d 3d 1f 1f 3d    ??????=4=33==??=
> d0: 1f 1f 3d 3d XX XX XX XX XX 00 f0 02 05 00 b0 XX    ??==XXXXX.???.?X
> e0: XX XX XX 00 00 00 7d 04 XX XX XX XX XX XX XX XX    XXX...}?XXXXXXXX
> f0: 81 08 XX XX XX XX XX XX 0f XX 03 06 06 06 2f XX    ??XXXXXX?X????/X
> 
> root@yogabook:/home/jek# i2cdump -f -y 6 0x4f
> No size specified (using byte-data access)
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 06 46 00 00 28 02 00 00 00 00 00 00 00 92 08 04    ?F..(?.......???
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 02 11 52    .............??R
> 20: 12 00 01 20 b8 10 87 20 b8 10 87 20 b8 10 87 31    ?.? ??? ??? ???1
> 30: 65 31 65 05 8e 00 20 b8 00 0c 00 38 00 46 00 ff    e1e??. ?.?.8.F..
> 40: 00 00 00 d8 25 a1 15 12 11 2d 10 fe 10 b8 27 45    ...?%????-????'E
> 50: 10 87 00 89 06 2f 00 59 00 59 00 59 10 65 10 65    ??.??/.Y.Y.Y?e?e
> 60: 10 65 05 de 20 b8 20 b8 1f 00 00 00 00 00 00 00    ?e?? ? ??.......
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: 00 00 77 07 77 77 77 07 00 00 00 00 00 00 00 00    ..w?www?........
> 90: 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff    ................
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 00 00    ................
> b0: 00 00 XX XX XX 00 00 06 00 14 18 3f 3f 2c 3f 3f    ..XXX..?.????,??
> c0: 04 1f 1f 04 10 05 00 a8 8e b3 00 1f 04 72 00 83    ??????.???.??r.?
> d0: 00 81 17 00 XX 00 00 00 00 00 94 7a b7 XX XX 19    .??.X.....?z?XX?
> e0: 06 ff 00 23 3e 3b ff ff 00 02 1f 03 00 08 00 00    ?..#>;...???.?..
> f0: 00 00 00 00 00 e9 00 50 00 02 00 01 XX XX 01 00    .....?.P.?.?XX?.
> 
> 
> The same, without charger connected:
> 
> root@yogabook:/home/jek# i2cdump -f -y 6 0x5e
> No size specified (using byte-data access)
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 ff 00 XX XX 03 00 00 50 00 XX XX 09 XX 00 XX    ...XX?..P.XX?X.X
> 10: 00 00 4a 01 0b 0b 10 80 01 0b 01 XX 00 74 04 1b    ..J????????X.t??
> 20: 06 ff 00 6b 00 6b 0a 03 73 43 00 ff 6c 6c 00 10    ?..k.k??sC..ll.?
> 30: 02 0e 00 fe 00 00 03 ff 00 51 01 3b 01 a7 01 62    ??.?..?..Q?;???b
> 40: 00 42 00 42 00 9f 00 9f 00 9f 00 d2 00 d2 00 d2    .B.B.?.?.?.?.?.?
> 50: 01 09 00 4d 00 8e 00 d3 01 11 01 56 02 XX XX XX    ??.M.?.????V?XXX
> 60: XX 02 0b ff 6a 6c 0e 26 34 44 52 60 XX XX XX XX    X??.jl?&4DR`XXXX
> 70: 00 00 00 00 00 00 00 00 00 00 00 XX XX XX XX XX    ...........XXXXX
> 80: XX 00 00 00 XX XX 00 00 00 00 00 00 00 00 00 00    X...XX..........
> 90: 00 XX XX XX XX XX XX ff ff ff ff ff ff ff ff ff    .XXXXXX.........
> a0: ff ff XX XX XX XX XX XX 00 00 XX XX XX XX XX XX    ..XXXXXX..XXXXXX
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> root@yogabook:/home/jek# i2cdump -f -y 6 0x6e
> No size specified (using byte-data access)
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 01 02 01 05 00 80 00 18 0d XX 10 00 00 80 af 00    ????.?.??X?..??.
> 10: 00 00 b0 00 1a ff XX 11 XX 60 03 XX 00 XX 14 00    ..?.?.X?X`?X.X?.
> 20: 00 00 01 0c ac 0b 5a 11 10 0c 1f 18 2b 00 00 XX    ..????Z?????+..X
> 30: 4a 4a XX 08 09 00 09 01 09 08 08 00 38 XX XX XX    JJX??.?????.8XXX
> 40: XX XX XX 09 08 XX XX XX XX XX XX XX XX XX XX XX    XXX??XXXXXXXXXXX
> 50: XX XX XX 0f XX XX 07 00 07 01 01 9b 63 01 07 01    XXX?XX?.????c???
> 60: XX XX XX 02 06 06 06 00 06 20 00 00 66 00 XX XX    XXX????.? ..f.XX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 80: XX XX XX XX XX XX XX XX XX XX XX 37 XX XX XX XX    XXXXXXXXXXX7XXXX
> 90: 01 01 XX XX XX 01 XX XX XX 01 01 01 01 00 01 01    ??XXX?XXX????.??
> a0: 01 01 01 01 XX XX XX XX XX XX XX XX XX XX XX XX    ????XXXXXXXXXXXX
> b0: XX XX XX XX 12 14 ad XX 00 00 00 18 00 XX XX XX    XXXX???X...?.XXX
> c0: 1f 1f 1f 14 14 1f 3d 34 3d 33 33 3d 3d 1f 1f 3d    ??????=4=33==??=
> d0: 1f 1f 3d 3d XX XX XX XX XX 00 f0 02 05 00 a0 XX    ??==XXXXX.???.?X
> e0: XX XX XX 00 00 00 7d 04 XX XX XX XX XX XX XX XX    XXX...}?XXXXXXXX
> f0: 81 08 XX XX XX XX XX XX 0f XX 03 06 06 06 2f XX    ??XXXXXX?X????/X
> root@yogabook:/home/jek# i2cdump -f -y 6 0x4f
> No size specified (using byte-data access)
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 06 46 00 00 a6 02 00 00 00 00 00 00 00 92 08 03    ?F..??.......???
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 02 11 52    .............??R
> 20: 12 00 01 20 b8 10 87 20 b8 10 87 20 b8 10 87 31    ?.? ??? ??? ???1
> 30: 65 31 65 05 8e 00 20 b8 00 6f 00 49 00 5f 00 ff    e1e??. ?.o.I._..
> 40: 00 00 00 d1 25 a1 15 12 11 2d 10 fe 10 b8 27 45    ...?%????-????'E
> 50: 10 87 00 89 06 2f 00 59 00 59 00 59 10 65 10 65    ??.??/.Y.Y.Y?e?e
> 60: 10 65 05 de 20 b8 20 b8 08 00 00 00 00 00 00 00    ?e?? ? ??.......
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: 00 00 77 07 77 77 77 07 00 00 00 00 00 00 00 00    ..w?www?........
> 90: 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff    ................
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 00 00    ................
> b0: 00 00 XX XX XX 00 00 06 00 14 31 3f 3f 2f 3f 3f    ..XXX..?.?1??/??
> c0: 04 1f 1f 04 10 05 00 75 8f b3 00 1f 04 72 00 83    ??????.u??.??r.?
> d0: 00 81 17 00 XX 00 00 00 00 00 b2 90 7a XX XX 19    .??.X.....??zXX?
> e0: 06 ff 00 23 3e 3b ff ff 00 02 1f 03 00 08 00 00    ?..#>;...???.?..
> f0: 00 00 00 00 00 9c 00 ac 00 02 00 01 XX XX 01 00    .....?.?.?.?XX?.
> 
> 
> The same, with USB hub connected (OTG host mode):
> 
> root@yogabook:/home/jek# i2cdump -f -y 6 0x5e
> No size specified (using byte-data access)
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 ff 00 XX XX 03 00 01 50 00 XX XX 09 XX 00 XX    ...XX?.?P.XX?X.X
> 10: 00 00 4a 01 0b 0b 10 c0 01 0f 01 XX 00 74 04 1b    ..J????????X.t??
> 20: 06 ff 00 6b 00 6b 0a 2a 73 00 00 ff 6c 6c 00 50    ?..k.k?*s...ll.P
> 30: 02 0e 00 fe 00 00 03 ff 00 51 01 3b 01 a7 01 62    ??.?..?..Q?;???b
> 40: 00 42 00 42 00 9f 00 9f 00 9f 00 d2 00 d2 00 d2    .B.B.?.?.?.?.?.?
> 50: 01 09 00 4d 00 8e 00 d3 01 11 01 56 02 XX XX XX    ??.M.?.????V?XXX
> 60: XX 02 0b ff 6a 6c 0e 26 34 44 52 60 XX XX XX XX    X??.jl?&4DR`XXXX
> 70: 00 00 00 00 00 00 00 00 00 00 00 XX XX XX XX XX    ...........XXXXX
> 80: XX 00 00 00 XX XX 00 00 00 00 00 00 00 00 00 00    X...XX..........
> 90: 00 XX XX XX XX XX XX ff ff ff ff ff ff ff ff ff    .XXXXXX.........
> a0: ff ff XX XX XX XX XX XX 00 00 XX XX XX XX XX XX    ..XXXXXX..XXXXXX
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> root@yogabook:/home/jek# i2cdump -f -y 6 0x6e
> No size specified (using byte-data access)
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 01 02 01 15 00 00 00 18 0d XX 00 00 00 80 af 00    ????...??X...??.
> 10: 00 00 b0 00 1a ff XX 11 XX 60 03 XX 00 XX 0d 00    ..?.?.X?X`?X.X?.
> 20: 00 00 01 0c ac 0b 5a 11 10 0c 1f 18 2b 00 00 XX    ..????Z?????+..X
> 30: 4a 4a XX 08 09 00 09 01 09 08 08 00 38 XX XX XX    JJX??.?????.8XXX
> 40: XX XX XX 09 08 XX XX XX XX XX XX XX XX XX XX XX    XXX??XXXXXXXXXXX
> 50: XX XX XX 0f XX XX 07 00 07 01 01 9b 63 01 07 01    XXX?XX?.????c???
> 60: XX XX XX 02 06 06 06 00 06 20 00 00 66 00 XX XX    XXX????.? ..f.XX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 80: XX XX XX XX XX XX XX XX XX XX XX 37 XX XX XX XX    XXXXXXXXXXX7XXXX
> 90: 01 01 XX XX XX 01 XX XX XX 01 01 01 01 00 01 01    ??XXX?XXX????.??
> a0: 01 01 01 01 XX XX XX XX XX XX XX XX XX XX XX XX    ????XXXXXXXXXXXX
> b0: XX XX XX XX 12 14 ad XX 00 00 00 18 00 XX XX XX    XXXX???X...?.XXX
> c0: 1f 1f 1f 14 14 1f 3d 34 3d 33 33 3d 3d 1f 1f 3d    ??????=4=33==??=
> d0: 1f 1f 3d 3d XX XX XX XX XX 00 f0 02 05 00 c0 XX    ??==XXXXX.???.?X
> e0: XX XX XX 00 00 00 7d 04 XX XX XX XX XX XX XX XX    XXX...}?XXXXXXXX
> f0: 81 08 XX XX XX XX XX XX 0f XX 03 06 06 06 2f XX    ??XXXXXX?X????/X
> root@yogabook:/home/jek# i2cdump -f -y 6 0x4f
> No size specified (using byte-data access)
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 06 46 00 00 99 02 00 00 00 00 00 00 00 92 08 04    ?F..??.......???
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 02 11 52    .............??R
> 20: 12 00 07 20 b8 10 87 20 b8 10 87 20 b8 10 87 31    ?.? ??? ??? ???1
> 30: 65 31 65 05 8e 00 20 b8 00 d9 00 a2 00 c6 00 ff    e1e??. ?.?.?.?..
> 40: 00 00 00 cc 25 a1 15 12 11 2d 10 fe 10 b8 27 45    ...?%????-????'E
> 50: 10 87 00 89 06 2f 00 59 00 59 00 59 10 65 10 65    ??.??/.Y.Y.Y?e?e
> 60: 10 65 05 de 20 b8 20 b8 08 00 00 00 00 00 00 00    ?e?? ? ??.......
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: 00 00 77 07 77 77 77 07 00 00 00 00 00 00 00 00    ..w?www?........
> 90: 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff    ................
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 00 00    ................
> b0: 00 00 XX XX XX 00 00 06 00 14 39 3f 3f 36 3f 3f    ..XXX..?.?9??6??
> c0: 04 1f 1f 04 10 05 00 21 91 b3 00 1f 04 72 00 83    ??????.!??.??r.?
> d0: 00 81 17 00 XX 00 00 00 00 00 b2 92 67 XX XX 19    .??.X.....??gXX?
> e0: 06 ff 00 23 3e 3b ff ff 00 02 1f 03 00 08 00 00    ?..#>;...???.?..
> f0: 00 00 00 00 00 94 00 99 00 03 00 03 XX XX 01 00    .....?.?.?.?XX?.

Thank you.

Regards,

Hans
