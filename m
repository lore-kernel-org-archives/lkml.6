Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3260C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCDC205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M9EMuM7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394178AbfAPQp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:45:59 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35885 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393924AbfAPQp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:45:59 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190116164556euoutp014f060a444271daa935f90edf4f60f254~6YfvnH8cz2938529385euoutp01X
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 16:45:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190116164556euoutp014f060a444271daa935f90edf4f60f254~6YfvnH8cz2938529385euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547657156;
        bh=VkrQACLZPCl3dC7EmfXtkXws156/L81i6watDtqkC8Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=M9EMuM7GENn+KabNW1Eqm6fxT9+DjcU6EJcS/y/lbty1rTxeOrC/ZZxljfMcgcZV3
         0YjaR16KD9osYYGPnHXNCBVUQQzqsbYKe1T5shUKn4yXog14G6xh/FvzG6UaHCnUVu
         IrEGavX54Ai3V04SAFv7iB0XqWX0G8vaeSuRcqLA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190116164555eucas1p2dfbd702a8d8583a83d2292ca391db7ce~6Yfu6KrDY1914619146eucas1p2I;
        Wed, 16 Jan 2019 16:45:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 17.D9.04806.3CF5F3C5; Wed, 16
        Jan 2019 16:45:55 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190116164554eucas1p1933df2a07a1b87e64cd1fef16d0c5077~6YfuG6AIC2936329363eucas1p1U;
        Wed, 16 Jan 2019 16:45:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190116164554eusmtrp26d19f12c6561716d2ef9c20134867e35~6Yft3FTcw1267912679eusmtrp2z;
        Wed, 16 Jan 2019 16:45:54 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-aa-5c3f5fc33ae3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A3.95.04284.2CF5F3C5; Wed, 16
        Jan 2019 16:45:54 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190116164554eusmtip25dcbe26bb8c1acc90322f28ecd5420c7~6YftfH8VE2709427094eusmtip2D;
        Wed, 16 Jan 2019 16:45:54 +0000 (GMT)
Subject: Re: [PATCH v2] fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a
 cmd, line option
To:     Peter Rosin <peda@axentia.se>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <96876402-8860-5c8a-a28f-81f8df58d0ce@samsung.com>
Date:   Wed, 16 Jan 2019 17:45:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <6a9be31e-0bb4-d477-99e6-6cac3cd5087f@axentia.se>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djPc7qH4+1jDI78k7J4cqCd0eLK1/ds
        Fs9u7WWyWNi2hMXiRN8HVovLu+awWew9NJ/Rgd1j2oHZ7B6HDncwetzvPs7ksbhvMqvH501y
        AaxRXDYpqTmZZalF+nYJXBnbPk9lKbimXdHVN5mxgXGXchcjJ4eEgInE5pVXmboYuTiEBFYw
        Snw9vJoNwvnCKLF7xhIo5zOjxL09f9lgWlqnzmeGSCxnlPjSthXKec8o8WjlN7AqYYFYicc/
        V4DZIgKKEgt2zQIrYhY4xyTx+PVMZpAEm4CVxMT2VYwgNq+AncTcFQ1gDSwCqhLv/u5k72Lk
        4BAViJDoP6MOUSIocXLmExYQmxOofOLB9WBjmAXkJba/nQM2X0JgGbvEukPTmCFOdZHY8/8Q
        O4QtLPHq+BYoW0bi/875TBAN0xkl3vxaygLhrGeUWHPmGBNElbXE4eMXWUGuYBbQlFi/Sx/E
        lBBwlPi9wAfC5JO48VYQ4gY+iUnbpjNDhHklOtqEIGaoSWxYtoENZmvXzpVQl3lIHJx1m3kC
        o+IsJJ/NQvLNLIS1CxiZVzGKp5YW56anFhvnpZbrFSfmFpfmpesl5+duYgQmm9P/jn/dwbjv
        T9IhRgEORiUe3g4z+xgh1sSy4srcQ4wSHMxKIrw/l9jFCPGmJFZWpRblxxeV5qQWH2KU5mBR
        EuetZngQLSSQnliSmp2aWpBaBJNl4uCUamBc+0nY2SXi3pK2rPrDfpyHdiS/MtHcdj675+nq
        gzsOp630FWeVSFv7ZzJnblibk8GxQyLXopLShObJNXr8ztQ6GGMXM+FtIPOmVY85t7xZMT1b
        YZH6lOuZlX3F360NGhnMZdb+2L3lkEhrxQS2BKWa92tEhc8b7b0ddEg/vmnnMY7J9uxeHVVK
        LMUZiYZazEXFiQCcUkHkMgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7qH4u1jDLa8VLZ4cqCd0eLK1/ds
        Fs9u7WWyWNi2hMXiRN8HVovLu+awWew9NJ/Rgd1j2oHZ7B6HDncwetzvPs7ksbhvMqvH501y
        AaxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnb
        Pk9lKbimXdHVN5mxgXGXchcjJ4eEgIlE69T5zCC2kMBSRokLR6O6GDmA4jISx9eXQZQIS/y5
        1sXWxcgFVPKWUaJlymt2kISwQKzE458r2EBsEQFFiQW7ZjFDFF1jkXg6dxY7iMMscIFJYsul
        VkaQKjYBK4mJ7avAbF4BO4m5KxrAulkEVCXe/d0JNlVUIELi1sMOFogaQYmTM5+A2ZxA9RMP
        rge7lFlAXeLPvEtQtrzE9rdzmCcwCs5C0jILSdksJGULGJlXMYqklhbnpucWG+oVJ+YWl+al
        6yXn525iBEbRtmM/N+9gvLQx+BCjAAejEg9vh5l9jBBrYllxZe4hRgkOZiUR3p9L7GKEeFMS
        K6tSi/Lji0pzUosPMZoCPTGRWUo0OR8Y4Xkl8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tS
        s1NTC1KLYPqYODilGhijUjd+v2IlH2Wf2HR79cZHhtWnhRwUpLWD77Yt9FkbH1dywHFF/pLJ
        N1l6rSZtvH91e0zQhZidpzdrrp300nFt0tU1Gxlzjh+/+/z2pBWi4X9DL6d2bjZhrWRXXPXg
        4RHTwAPzPTuLW432hdrr3nR5O//Ql8Xb6hlXPK86YFL41na7DZ9CcM8mJZbijERDLeai4kQA
        0Hm1QrgCAAA=
X-CMS-MailID: 20190116164554eucas1p1933df2a07a1b87e64cd1fef16d0c5077
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190107103630epcas3p1939481c5a659d9dd0f11d026d7f4c4e1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190107103630epcas3p1939481c5a659d9dd0f11d026d7f4c4e1
References: <20181126215725.2548-1-peda@axentia.se>
        <20181126215725.2548-3-peda@axentia.se>
        <CAMuHMdVfoRP_yNL5HcmwwV3fn9GqnsbORtG_hOhWw3qUeMKFKQ@mail.gmail.com>
        <37be75aa-7a63-a937-6de7-777a31af741b@axentia.se>
        <CAMuHMdXR2iuftV26s-EnKo74vZxcW2w_R1dD_Mk+Ug8MsNwL3Q@mail.gmail.com>
        <cb772a2f-2d33-6d0e-9ea6-ba9eb49023f9@axentia.se>
        <662db203-ae18-4a11-7b10-3d7d480f6f37@axentia.se>
        <CAMuHMdXMidVgtz-T8PZDUrKAwJmz9B4g1hNgw6FwrCpU-m5Gew@mail.gmail.com>
        <CGME20190107103630epcas3p1939481c5a659d9dd0f11d026d7f4c4e1@epcas3p1.samsung.com>
        <6a9be31e-0bb4-d477-99e6-6cac3cd5087f@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/07/2019 11:35 AM, Peter Rosin wrote:
> On 2019-01-07 10:11, Geert Uytterhoeven wrote:
>> Hi Peter,
>>
>> On Mon, Jan 7, 2019 at 10:03 AM Peter Rosin <peda@axentia.se> wrote:
>>> On 2019-01-07 09:59, Peter Rosin wrote:
>>>> On 2019-01-07 09:40, Geert Uytterhoeven wrote:
>>>>> On Mon, Jan 7, 2019 at 9:26 AM Peter Rosin <peda@axentia.se> wrote:
>>>>>> On 2019-01-06 10:33, Geert Uytterhoeven wrote:
>>>>>>> On Mon, Nov 26, 2018 at 10:59 PM Peter Rosin <peda@axentia.se> wrote:
>>>>>>>> If there are extra logos (CONFIG_FB_LOGO_EXTRA) the heights of these
>>>>>>>> extra logos are not considered when centering the first logo vertically.
>>>>>>>>
>>>>>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>>>>>
>>>>>>>> --- a/drivers/video/logo/Kconfig
>>>>>>>> +++ b/drivers/video/logo/Kconfig
>>>>>>>> @@ -10,6 +10,15 @@ menuconfig LOGO
>>>>>>>>
>>>>>>>>  if LOGO
>>>>>>>>
>>>>>>>> +config FB_LOGO_CENTER
>>>>>>>> +       bool "Center the logo"
>>>>>>>> +       depends on FB=y
>>>>>>>> +       help
>>>>>>>> +         When this option is selected, the bootup logo is centered both
>>>>>>>> +         horizontally and vertically. If more than one logo is displayed
>>>>>>>> +         due to multiple CPUs, the collected line of logos is centered
>>>>>>>> +         as a whole.
>>>>>>>> +
>>>>>>>
>>>>>>> Isn't a kernel command line option more suitable to configure the position
>>>>>>> of the logo?
>>>>>>
>>>>>> That didn't occur to me previously, but it does make sense now that you
>>>>>> mention it. This is on top of v5.0-rc1, and if applied before v5.0 we
>>>>>> can avoid possible regressions for folks who might start to rely on
>>>>>> CONFIG_FB_LOGO_CENTER if v5.0 is released w/o this.
>>>>>>
>>>>>> Cheers,
>>>>>> Peter
>>>>>>
>>>>>> From de7353ab519ba9b5c9ea3f62d607bb8e94b687cc Mon Sep 17 00:00:00 2001
>>>>>> From: Peter Rosin <peda@axentia.se>
>>>>>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>>>> Cc: Peter Rosin <peda@axentia.se>
>>>>>> Cc: dri-devel@lists.freedesktop.org
>>>>>> Cc: linux-fbdev@vger.kernel.org
>>>>>> Cc: linux-doc@vger.kernel.org
>>>>>> To: linux-kernel@vger.kernel.org
>>>>>> Date: Mon, 7 Jan 2019 08:35:26 +0100
>>>>>> Subject: [PATCH] fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a cmd line
>>>>>>  option
>>>>>>
>>>>>> A command line option is much more flexible than a config option and
>>>>>> the supporting code is small. Gets rid of #ifdefs in the code too...
>>>>>>
>>>>>> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>>>
>>>>> Thanks for your patch!
>>>>>
>>>>>> --- a/Documentation/fb/fbcon.txt
>>>>>> +++ b/Documentation/fb/fbcon.txt
>>>>>> @@ -163,6 +163,12 @@ C. Boot options
>>>>>>         be preserved until there actually is some text is output to the console.
>>>>>>         This option causes fbcon to bind immediately to the fbdev device.
>>>>>>
>>>>>> +7. fbcon=center-logo
>>>>>> +
>>>>>> +       When this option is selected, the bootup logo is centered both
>>>>>> +       horizontally and vertically. If more than one logo is displayed due to
>>>>>> +       multiple CPUs, the collected line of logos is centered as a whole.
>>>>>> +
>>>>>
>>>>> What about making this more generic, than an option specific for centering?
>>>>> Else people want fbcon=left-logo or fbcon=right-logo soon?
>>>>>
>>>>>     fbcon=logo-pos:<pos>
>>>>>
>>>>> With <pos> being "center", "left", "top", "right", "bottom", and combinations
>>>>> like "top,center"? Or is that complicating stuff too much?
>>>>
>>>> I'm not too keen on implementing all that when I have zero use for it. I can
>>>> however rename the trigger for the existing fb_center_logo bool to
>>>>
>>>>       fbcon=logo-pos:center
>>>>
>>>> and add a check for "top,left" to reset the bool to false. Then the other
>>>> variants can be added later by whomever and when needed.
>>>>
>>>> Is that good enough?
>>>
>>> Ouch, I just realized that using a comma is a no-go, as that is already
>>> separating fbcon suboptions, so I suggest top-left instead.
>>
>> Sure, sounds fine to me.  I just want to avoid having a parameter system
>> that complicates future extension.
>> I think you can drop the check for top-left, as the bool defaults to false.
> 
> Right. So, here's an update...
> 
> Again, it would probably be best if this went in before 5.0 is released.
> 
> Changes since v1:
> - rename from fbcon=center-logo option to fbcon=logo-pos:center (and adjust
>   the help text accordingly).
> 
> Cheers,
> Peter
> 
> From ebfb2feb7ea4298ac9c222e6ea6f9c9a92452084 Mon Sep 17 00:00:00 2001
> From: Peter Rosin <peda@axentia.se>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> To: linux-kernel@vger.kernel.org
> Date: Mon, 7 Jan 2019 08:35:26 +0100
> Subject: [PATCH v2] fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a cmd
>  line option
> 
> A command line option is much more flexible than a config option and
> the supporting code is small. Gets rid of #ifdefs in the code too...
> 
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Patch queued for 5.0, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
