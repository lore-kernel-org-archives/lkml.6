Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA970C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9382821582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XimgHnXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9382821582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbeKNVIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 16:08:50 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:56454 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeKNVIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 16:08:50 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20181114110555epoutp017d75b5280875ba98c9b3e842166e455d~m_N4cPTi60509805098epoutp01t;
        Wed, 14 Nov 2018 11:05:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20181114110555epoutp017d75b5280875ba98c9b3e842166e455d~m_N4cPTi60509805098epoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542193555;
        bh=Il+aQhdWNocSNhPIy5HmaM4WmdtOUjg6ldwpBDmwWMY=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=XimgHnXR52Cu/VN/B7lcB7tRxSV1Wb5TZbeRIRa7U6/spnvlmLiiz/O3A3ORIOtx2
         +diiWFGZA3+brUVBr9y9/KiRXe+5EMx2uiQPMCHtuIp7I3OLrKkr75lpv+YQ9QLjLE
         ZDOHt0/0XcYv00Qn7rwOZJlQEzjIqKewngJ7RcvE=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20181114110552epcas1p4056a74f1089ce8b3c35e8c789d608c30~m_N2EwHlu0352303523epcas1p4K;
        Wed, 14 Nov 2018 11:05:52 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.05.04072.0910CEB5; Wed, 14 Nov 2018 20:05:52 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20181114110551epcas1p4323d98bd891179a70454448ab7fd6978~m_N0_5kd70350703507epcas1p41;
        Wed, 14 Nov 2018 11:05:51 +0000 (GMT)
X-AuditID: b6c32a37-86fff70000000fe8-70-5bec0190f757
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 1D.F9.03701.F810CEB5; Wed, 14 Nov
        2018 20:05:51 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PI600KHXK5QMA60@mmp2.samsung.com>; Wed, 14 Nov 2018 20:05:51 +0900 (KST)
Message-id: <5BEC018E.8020102@samsung.com>
Date:   Wed, 14 Nov 2018 20:05:50 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        USB <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        rogerq@ti.com, Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 2/5] extcon: Return -EPROBE_DEFER when extcon device
 is not found
In-reply-to: <CAHp75VcJwR7S8t2jSyRvtjKCwaUA5Pu=EL3+MjCgf3SVWnChEQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmnu4ExjfRBv+a1S1eTjjMaHGs7Qm7
        RddCA4vmxevZLN4cn85k0bV6J4vF5V1z2CxmL+lnsfjce4TRYtGyVmaLJwvPMFncblzBZrF6
        zwtmi7lfpjJb9DzSsji9u8Ti56HzTA6CHhserWb12DnrLrvH5hVaHptWdbJ5zDsZ6LF/7hp2
        j/f7rrJ57PzewO7Rt2UVo8fxG9uZPD5vkgvgjsq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1
        MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAH6SEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5Ra
        kJJTYFmgV5yYW1yal66XnJ9rZWhgYGQKVJiQnfFndQtLQZ9oxduuY+wNjB2CXYycHBICJhJ7
        Pi5l6WLk4hAS2MEocX/+b3YI5zujxNsl39lhqrb96GcFsYUENjBK3HmiBWLzCghK/Jh8D6ib
        g4NZQF7iyKVskDCzgKbEiy+ToIbeZZTY9+4JM0S9lsTyzk1sIDaLgKrE9tu/weJsQPH9L26A
        xfkFFCWu/njMCGKLCkRI7Jz/DegGdg4RAX2J/WUQ42eySrx65g5iCwtESZy7uAesmlMgWOLp
        kgdg50sI7GOXmNr2ixXifBeJ3yteQNnCEq+Ob2EHOVlCQFri0lFbiPp2RokvL5pZIZwJjBIf
        Tm1mgmgwlni2sIsJYjOfxLuvPawQzbwSHW1CECUeEi/v9zFC/DuZReLXqV+MExhlZyEF0SxE
        EM1CCqIFjMyrGMVSC4pz01OLDQuMkeNuEyM47WqZ72DccM7nEKMAB6MSD6/F7VfRQqyJZcWV
        uYcYJTiYlUR4/aNfRwvxpiRWVqUW5ccXleakFh9iNAWG8ERmKdHkfGBOyCuJNzQ1MjY2tjAx
        NDM1NFQS530iNTdaSCA9sSQ1OzW1ILUIpo+Jg1OqgVF7aT2LScBxzclvrWNknN0C7Cqi1bTc
        y5Sqc5ma5/s43r86oVj1oqGJ9BX/BJUMrQKHpTfT3wdNWeE48cmDv8EuF3573OA6WthR9uyd
        wN2UubJe2pbOCha6KR7aCm9c784/NuPdr3VBoavP6Rg9X6/DxSxSfnkK36zqvxPV/lvmpXFX
        JHkdUWIpzkg01GIuKk4EAMeWkPHRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t9jQd1+xjfRBp8OyVi8nHCY0eJY2xN2
        i66FBhbNi9ezWbw5Pp3Jomv1ThaLy7vmsFnMXtLPYvG59wijxaJlrcwWTxaeYbK43biCzWL1
        nhfMFnO/TGW26HmkZXF6d4nFz0PnmRwEPTY8Ws3qsXPWXXaPzSu0PDat6mTzmHcy0GP/3DXs
        Hu/3XWXz2Pm9gd2jb8sqRo/jN7YzeXzeJBfAHcVlk5Kak1mWWqRvl8CV8Wd1C0tBn2jF265j
        7A2MHYJdjJwcEgImEtt+9LN2MXJxCAmsY5RY87ybDSTBKyAo8WPyPZYuRg4OZgF5iSOXsiFM
        dYkpU3Ihyu8zSnyePJEFolxLYnnnJrBWFgFVie23fzOD2GxA8f0vboDF+QUUJa7+eMwIMkdU
        IEKi+0RlFyM7h4iAvsT+MpCJzAKzWSVOXb7GClItLBAl8WvKVCaIVZNZJJYdvw02hlMgWOLj
        pj9sExgFZiE5dBbCobMQDl3AyLyKUTK1oDg3PbfYqMAwL7Vcrzgxt7g0L10vOT93EyMw9rYd
        1urbwXh/SfwhRgEORiUeXovbr6KFWBPLiitzDzFKcDArifD6R7+OFuJNSaysSi3Kjy8qzUkt
        PsQozcGiJM57O+9YpJBAemJJanZqakFqEUyWiYNTqoFRhzH4cuadf6G7zntzrnv9fGHmKTmp
        NT0ve84cyudbuc/y9PKKC//nbnPQrDhye8kq9dnxArHrGWdZGodclFj8au/qy7Mz36/0ClYt
        SzkbO1do2uI3qe9WSBXc/9f3ISk1/8nniRGzmc4tMv76r+/Lstq2Y09n2FzfGqJ843nBA15F
        TpmkK/rHNZRYijMSDbWYi4oTAT4eQrG5AgAA
X-CMS-MailID: 20181114110551epcas1p4323d98bd891179a70454448ab7fd6978
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181110181155epcas2p1ac9bffb2dc7dd6337db5c37f8a87bd5e
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
        <CGME20181110181155epcas2p1ac9bffb2dc7dd6337db5c37f8a87bd5e@epcas2p1.samsung.com>
        <20181110181101.24557-2-andriy.shevchenko@linux.intel.com>
        <5BE8C821.5080002@samsung.com> <5BEB63C3.1020504@samsung.com>
        <CAHp75Vfe586+tr5mUdSHv4ehmpi0KwS_m+UC0tfFHrdXwKhkig@mail.gmail.com>
        <5BEBE741.6050101@samsung.com> <20181114093652.GK10650@smile.fi.intel.com>
        <5BEBEF7C.7060003@samsung.com>
        <CAHp75VcJwR7S8t2jSyRvtjKCwaUA5Pu=EL3+MjCgf3SVWnChEQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 11월 14일 19:20, Andy Shevchenko wrote:
> On Wed, Nov 14, 2018 at 11:48 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>
>> On 2018년 11월 14일 18:36, Andy Shevchenko wrote:
>>> On Wed, Nov 14, 2018 at 06:13:37PM +0900, Chanwoo Choi wrote:
>>>> On 2018년 11월 14일 17:35, Andy Shevchenko wrote:
>>>>> On Wed, Nov 14, 2018 at 1:53 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>>>>
>>>>>> I was thinking about again to change from NULL to EPROBE_DEFER.
>>>>>>
>>>>>> extcon_get_extcon_dev() function was almost called in the probe function.
>>>>>> But, this function might be called on other position instead of probe.
>>>>>
>>>>> *Might be* sounds like a theoretical thing, care to share what is in you mind?
>>>>> Current users and more important the new coming one are *all* doing the same.
>>>>>
>>>>>> ENODEV is more correct error instead of EPROBE_DEFER.
>>>>>
>>>>> So, you are proposing to continue duplicating conversion from ENODEV
>>>>> to EPROBE_DEFER in *each* caller?
>>>>
>>>> The extcon core don't know the caller situation is in either probe() or other position
>>>> in the caller driver. The caller driver should decide the kind of error value
>>>> by using the return value of extcon_get_extcon_dev().
>>>>
>>>> extcon_get_extcon_dev() function cannot be modified for only one case.
>>>> If some device driver call extcon_get_extcon_dev() out of probe() fuction,
>>>> EPROBE_DEFER is not always correct.
>>>
>>> I agree with this, but look at the current state of affairs. All users do the same.
>>> If we need to have another case we may consider this later.
>>
>> Because we know the potential wrong case of this change, I can't agree this change.
>> If extcon_get_extcon_dev() returns ENODEV instead of EPROBE_DEFER,
>> it is clear and then there are no problem on both current and future.
> 
> Changing NULL to -ENODEV is a trading bad to worse.
> I would not go that way, so, it's your call.

If you think that this change is not necessary, just keep the current code
without the modification. Please drop this patch on next version.

> 
>>> API inside the kernel are not carved in the stone.
> 
> Only can repeat myself (see above). While I see *theoretical*
> rationale on your side, mine has *practical* proofs.
> So, I'm giving up on this and will duplicate same what it's done in 4
> current callers.
> 

I think that it is more important for removing the potential wrong case
instead of removing the duplicate code. The many device drivers already
decided the proper error value by using the return value of function of 
kernel framework.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
