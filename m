Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B87C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B582086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvAQ4fDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B582086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbeKHDBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:01:17 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38585 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKHDBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:01:17 -0500
Received: by mail-pl1-f196.google.com with SMTP id p4-v6so5774371plo.5;
        Wed, 07 Nov 2018 09:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bbj5npJXnNTp8dyYDiIKMNryYkZWLtHcL9WWUQN/XEc=;
        b=MvAQ4fDJJLkM1Gg4OwKwsBNmQR00Lc3vY+Sq8cCGz4dbYncGobHAwbecXXnQD0iDSD
         XUnEIAAPKHN31rHJftA1pXNg7frWNkc++kX5pUMCnXDtq3GNradTEIBjlt6/BIeIKCIy
         dytZlYu05z0vAMuUDoqy3mvOzU5PRu3lumHH4cgX/pcc/Nj0CPqp3HcXa8eE/rPgTIGP
         09SqgVlgVJmzZBOrUO+8tlouF4MaOFbaWtWJGps6MX9Q+WXk9ttxijwxpzdgvsrACuxp
         VLGLXCFlhcOtQ15Re2tZtZLt2pNHgfcWcZySy1c0ToZxAfNHWsJHtSJVGUBZiaUO3TNY
         5VyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bbj5npJXnNTp8dyYDiIKMNryYkZWLtHcL9WWUQN/XEc=;
        b=LEWSAihi7qCOk9Xc2SDepo0heEVeu6KVHm2iWzB4K6xZxsdVjdwbYBPVflDVsQpdrd
         e0b1DesvqeDu7PnKChv2M27VAitO2Y9i6SC2V+rW6FC1JJleIiSIiAHrTQC6jvsAqRnM
         3OlOI54OBZ03MXgB/cMOz5P8SVsgNJZiW+yU0StpDfnh0zQlzIl77+uUOSg+sJ7U1v1M
         I83ZAT+0VZZhebyvRBhmurkmdGweD0dgHHi8Yv1yyF0SPWmLRGUMkbQwpuM/3g9ZCuzg
         pMp/fNikv5yKn+4GJw2Oj20DUCA9bau4lw9kRUvkCib1DDM6nWOq72aTX+2JRcfW8sdW
         e5CQ==
X-Gm-Message-State: AGRZ1gJmBHscYSWVwodWQBlhMspddOqAIWTIwUBx2gjLs+xMKplNQrJt
        HjPscMGnx5ValQk6WSZ2NB0=
X-Google-Smtp-Source: AJdET5eH7R0+eKpuq+YlzXpA9V2oqfPGbuqg6ZuSgC5P5iK7E1zUF3/ERHLg7m4kbsRPk1d/HO3glw==
X-Received: by 2002:a17:902:b612:: with SMTP id b18-v6mr1105313pls.205.1541611794981;
        Wed, 07 Nov 2018 09:29:54 -0800 (PST)
Received: from [10.67.49.62] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id z8sm1125784pgz.53.2018.11.07.09.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 09:29:53 -0800 (PST)
Subject: Re: [PATCH V3 4/6] usb: ohci-platform: Add support for Broadcom STB
 SoC's
To:     Alan Stern <stern@rowland.harvard.edu>,
        Al Cooper <al.cooper@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        Alban Bedel <albeu@free.fr>, Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-usb@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>
References: <Pine.LNX.4.44L0.1811071124260.1542-100000@iolanthe.rowland.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSDOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJw==
Message-ID: <16a80878-58f7-1584-058e-0e0e49da61cb@gmail.com>
Date:   Wed, 7 Nov 2018 09:29:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1811071124260.1542-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/18 8:27 AM, Alan Stern wrote:
> On Wed, 7 Nov 2018, Al Cooper wrote:
> 
>> On 11/7/18 10:23 AM, Alan Stern wrote:
>>> On Tue, 6 Nov 2018, Florian Fainelli wrote:
>>>
>>>> On 11/6/18 1:40 PM, Al Cooper wrote:
>>>>> On 11/6/18 11:08 AM, Alan Stern wrote:
>>>>>> On Mon, 5 Nov 2018, Al Cooper wrote:
>>>>>>
>>>>>>> Add support for Broadcom STB SoC's to the ohci platform driver.
>>>>>>>
>>>>>>> Signed-off-by: Al Cooper <alcooperx@gmail.com>
>>>>>>> ---
>>>>>>
>>>>>>> @@ -177,6 +189,8 @@ static int ohci_platform_probe(struct
>>>>>>> platform_device *dev)
>>>>>>>            ohci->flags |= OHCI_QUIRK_FRAME_NO;
>>>>>>>        if (pdata->num_ports)
>>>>>>>            ohci->num_ports = pdata->num_ports;
>>>>>>> +    if (pdata->suspend_without_phy_exit)
>>>>>>> +        hcd->suspend_without_phy_exit = 1;
>>>>>>
>>>>>> Sorry if I missed this in the earlier discussions...  Is there any
>>>>>> possibility of adding a DT binding that could express this requirement,
>>>>>> instead of putting it in the platform data?
>>>>>>
>>>>>> Alan Stern
>>>>>>
>>>>>
>>>>> Alan,
>>>>>
>>>>> That was my original approach but internal review suggested that I use
>>>>> pdata instead. Below is my original patch for:
>>>>
>>>> And the reason for that suggestion was really because it was percevied
>>>> as encoding a driver behavior as a Device Tree property as opposed to
>>>> describing something that was inherently and strictly a hardware
>>>> behavior (therefore suitable for Device Tree).
>>>
>>> Right.  The best way to approach this problem is to identify and
>>> characterize the hardware behavior which makes this override necessary.
>>> Then _that_ can be added to DT, since it will be a property of the
>>> hardware rather than of the driver.
>>>
>>>>> Add the ability to skip calling the PHY's exit routine on suspend
>>>>> and the PHY's init routine on resume. This is to handle a USB PHY
>>>>> that should have it's power_off function called on suspend but cannot
>>>>> have it's exit function called because on exit it will disable the
>>>>> PHY to the point where register accesses to the Host Controllers
>>>>> using the PHY will be disabled and the host drivers will crash.
>>>
>>> What's special about this PHY?  Why does the exit function mess the PHY
>>> up?  Or to put it another way, why doesn't the exit function mess up
>>> other PHYs in the same way?
>>>
>>> For that matter, can we change the code so that suspend doesn't call
>>> the exit function for _any_ PHY?  Will just calling the power_off
>>> function be good enough?  If not, then why not?
>>>
>>> Alan Stern
>>>
>>
>> In our USB hardware the USB PHY supplies a clock for the EHCI/OHCI and 
>> XHCI host controllers and if the PHY is totally shut down the EHCI, OHCI 
>> and XHCI registers will cause an exception if accessed and cause the 
>> EHCI, OHCI and XHCI drivers to crash. There is always talk of fixing 
>> this in the hardware by adding an aux clock that will takeover when the 
>> PHY clock is shut down, but this hasn't happened yet. It seems like 
>> "exit on suspend" still makes sense on systems that don't have this 
>> problem (additional power savings?) so removing the exit on suspend for 
>> all systems is not a good idea.
> 
> Then in theory you should be able to add a Device Tree property which
> says that the PHY provides a clock for the USB host controller.  That
> is strictly a property of the hardware; it has nothing to do with the
> driver.  Therefore it is appropriate for DT.

The very compatible string that is being allocated/defined for this
controller carries that information already, that is, if you probe a
"brcm,bcm7445-ohci" compatible then that means the controller has a
dependency on the PHY to supply its clock.

Adding a property vs. keying on the compatible string makes sense if you
know there is at least a second consumer of that property (unless we
make it a broadcom specific property, in which case, it really is
redundant with the compatible string).

Anyway, my grudge with that property was the name chosen initially,
which included an action to be performed by an implementation as opposed
to something purely descriptive. E.g: 'phy-supplies-clock' might be okay.

> 
> Wouldn't this solve your issue?

It would not change much except that there is no need to much with
ohci-platform.c anymore, but ultimately that property needs to be read
by ohci-hcd.c and acted on, which would likely lead to the same amount
of changes as those present in patch #2 currently.
-- 
Florian
