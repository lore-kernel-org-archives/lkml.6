Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932164AbeE1J6L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:58:11 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43965 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754229AbeE1J6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:58:08 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180528095806euoutp024e8a4cb18b6c4dbd7093dced2c10dede~yxoI18qCG1886818868euoutp02k
X-AuditID: cbfec7f4-6f9ff700000043e4-ba-5b0bd2ac701b
Subject: Re: [PATCH v2 1/3] usb: gadget: ccid: add support for USB CCID
 Gadget Device
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Felipe Balbi <balbi@kernel.org>,
        davem@davemloft.net,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Date: Mon, 28 May 2018 11:58:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180528093254.GC4651@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3YuO043T1PxbUXRpChBy24c6IJBwYkgI4hCo5ztpJFO2fGS
        BjVc6jIz07ytaeW1ZKRuJilpaqSrSMtAvJVWMyhylVbYxcrjMfK/3/u8z/t+3/PxUZhylFBR
        x3XxnF6niVaTMryx83tPgLXXPWzt3VQPxlJrJZnOdKeUcbZlIMbScxZnjOW1JJNlSUXM9fQK
        nHnebCGZsqo0jLlU+5JgPk6ckzDjw4U4k9XkQIzdlo8FK9iGmwMStsn8Qsrab/iztppzJOvq
        7payjqKfOHuvxCply7PzCHbStnSvW6hsi5aLPp7I6ddsC5dFFXW2EXFfvU6aHBmkAY15ZiI3
        CugNcKs8F8tEMkpJ30BQeLFvrviCoPh1GSEWkwiM4xelmYiaHXlXt0fUqxFcHp6WiMVnBHVl
        eYSw14s+AAZHIxIGvOkgsI8ECx6MdmFwwWrEBQ9Jr4eWdhMSGKdXQPXQoFRgH/og1OdMYALL
        6YXwsNg563ejA6HbkE0KjNG+MOi8KhF5GRhvX5m9NtBpFLT3WJE4nAhTA2+lYtAdUO6qmmMv
        eN/VMMdL4E+TuAjoJMi395HioiwE1Z/GCbGxGe53PSOENBi9Gmqb14jydug3jc29igL6xxeK
        91FAbmMhJspyMKUrRbcfNHx9hIm8CNI+VKEcpDbPS2mel8w8L5n5/7nXEF6DfLkEPiaS49fp
        uKRAXhPDJ+giA4/GxtjQzL97/Lvryx3U/CuiA9EUUnvIDT9lYUpCk8gnx3QgoDC1t1wWMCPJ
        tZrkFE4fe0SfEM3xHWgxhat95YdXnQ5V0pGaeO4Ex8Vx+n9dCeWmMiDfUc/WGp9+3nNjqa2n
        ovJJhOuUbHBXfUoImxPOmgq899X1HlBh2oqRqObd0JozGfJ06wKVwiPSpep9s9zPPWzUZm87
        ZlTWFbc446YK6hUrK4un90+uclwIK/mx3S+4d1+NtlWn+uZ35sHQr+mR36XZKaX+56mWsUM7
        m8ruvZJsUuN8lCbIH9Pzmr9rOsEpcwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsVy+t/xe7qrL3FHG+y8yWkxZ/0aNotjbU/Y
        LZ4caGe0mHO+hcWiefF6NoueOU2MFgvblrBYXN41h81i0bJWZouJ6++xWrz/1Mlk8fbOdBaL
        np0nGC02b5rK7MDnsWXlTSaPnbPusntsXqHlsWlVJ5vHu3Pn2D1OzPjN4rF/7hp2j8V9k1k9
        Pm+SC+CM0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL
        0MuYcewAa8FX4YqOE+1sDYxP+bsYOTgkBEwkXm7w62Lk4hASWMoocWzmbdYuRk6guKRE78MD
        7BC2sMSfa11sEEXvGSWun5/KApIQFgiX+LDpDzPIIBEBQ4nN9x1AapgFPjFLLPwzjwmiYSuz
        xJIjK8AmsQkYS+w92MEIYvMK2Elcm34KbBCLgKrE8tu3wGpEBSIkmuatYYeoEZQ4OfMJWA2n
        gJ7EuYY+NhCbWcBMYt7mh8wQtrjErSfzmSBseYnmrbOZJzAKzULSPgtJyywkLbOQtCxgZFnF
        KJJaWpybnltsqFecmFtcmpeul5yfu4kRGOHbjv3cvIPx0sbgQ4wCHIxKPLwNv7mihVgTy4or
        cw8xSnAwK4nwcukChXhTEiurUovy44tKc1KLDzGaAj03kVlKNDkfmHzySuINTQ3NLSwNzY3N
        jc0slMR5zxtURgkJpCeWpGanphakFsH0MXFwSjUwJgdtOjf/Rav/vQtfvBUyezpknmtXrJrg
        fjFI/u+KFHNurkMXkguLmtyenvy1yCp2W2xwmm7rzg191dskfwVJHXb9XLMine3gjrcdFoKi
        y55Zf0/QfTSJQWEJ5/dNSixhi4pKXkSfOlPEG2x78e38WTfXJqjcmbHzvUS1OVeD+Wz9Y84S
        DXUpSizFGYmGWsxFxYkAVAfBAwYDAAA=
Message-Id: <20180528095803eucas1p17d5816834311bfaa79dd10237a71f93d~yxoGS2jAg1338013380eucas1p1l@eucas1p1.samsung.com>
X-CMS-MailID: 20180528095803eucas1p17d5816834311bfaa79dd10237a71f93d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180526212048epcas2p1510fd6c92f20e8f6d0059742ab5fb3f7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180526212048epcas2p1510fd6c92f20e8f6d0059742ab5fb3f7
References: <CGME20180526212048epcas2p1510fd6c92f20e8f6d0059742ab5fb3f7@epcas2p1.samsung.com>
        <20180526211940.25474-1-marcus.folkesson@gmail.com>
        <20180528070453eucas1p294be19abd2cab7d112404d15710edfde~yvQ5mevbz2769227692eucas1p2k@eucas1p2.samsung.com>
        <20180528083834.GB4651@gmail.com>
        <20180528091229eucas1p20cfbb68cdfaa6de2cf5b5a7e2bdac72c~yxAUSF7e61070710707eucas1p2j@eucas1p2.samsung.com>
        <20180528093254.GC4651@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 28.05.2018 o 11:32, Marcus Folkesson pisze:
> Hi Andrzej,
> 
> Thank you for reviewing.
> 
> On Mon, May 28, 2018 at 11:12:27AM +0200, Andrzej Pietrasiewicz wrote:
>> W dniu 28.05.2018 o 10:38, Marcus Folkesson pisze:
>>> Hi Andrzej,
>>>
>>> On Mon, May 28, 2018 at 09:04:51AM +0200, Andrzej Pietrasiewicz wrote:
>>>> Mi Marcus,
>>>>
>>>> W dniu 26.05.2018 o 23:19, Marcus Folkesson pisze:
>>>>> Chip Card Interface Device (CCID) protocol is a USB protocol that
>>>>> allows a smartcard device to be connected to a computer via a card
>>>>> reader using a standard USB interface, without the need for each manufacturer
>>>>> of smartcards to provide its own reader or protocol.
>>>>>
>>>>> This gadget driver makes Linux show up as a CCID device to the host and let a
>>>>> userspace daemon act as the smartcard.
>>>>>
>>>>> This is useful when the Linux gadget itself should act as a cryptographic
>>>>> device or forward APDUs to an embedded smartcard device.
>>>>>
>>>>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>>>>> ---
>>>>
>>>>>     
>>>>> +config USB_CONFIGFS_CCID
>>>>> +	bool "Chip Card Interface Device (CCID)"
>>>>> +	depends on USB_CONFIGFS
>>>>> +	select USB_F_CCID
>>>>> +	help
>>>>> +	  The CCID function driver provides generic emulation of a
>>>>> +	  Chip Card Interface Device (CCID).
>>>>> +
>>>>> +	  You will need a user space server talking to /dev/ccidg*,
>>>>> +	  since the kernel itself does not implement CCID/TPDU/APDU
>>>>> +	  protocol.
>>>>
>>>> Your function needs a userspace daemon to work.
>>>> It seems you want to use FunctionFS for such a purpose
>>>> instead of creating a new function.
>>>>
>>>> Andrzej
>>>
>>>>> +	  since the kernel itself does not implement CCID/TPDU/APDU
>>> Oops, the driver does handle CCID.
>>
>> Which parts of code do this handling?
> 
> My bad, I was thinking about the USB descriptors and endpoints setup.
> That is of cause not part of the CCID protocol.
> 
>>
>> Is there any kind of state machine usual for protocols?
>> If the protocol is stateless then isn't it just a data format then?
> 
> The protocol is stateless.
> 
>>
>> Which part of this handling must be done in kernel and why?
>>
>> Does the said handling do anything other than forwarding the
>> traffic between USB and a character device?
> 
> No, it forward the CCID messages to the character device to be handled
> by the application.
> 
>>

My opinion is: this wants to be done with FunctionFS.

Andrzej
