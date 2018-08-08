Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE85C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BF4216ED
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ohcWphXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BF4216ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbeHHHVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 03:21:16 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36312 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeHHHVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 03:21:15 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180808050327euoutp02f2e2d9dbcc4db13c60222384675990a2~I0DbmdW3G2844028440euoutp02c
        for <linux-kernel@vger.kernel.org>; Wed,  8 Aug 2018 05:03:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180808050327euoutp02f2e2d9dbcc4db13c60222384675990a2~I0DbmdW3G2844028440euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533704607;
        bh=CdRD8WRraPF1XOp/UphO6rAExUBHuOaXopkIX5fj0pM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ohcWphXVVEKQlnvsvqvgU/C9L6jkYF4yjHGtp+U4Mp2ykZZDEidkozr+HEIawBEAA
         UBLGCIsnC9QaMLmbQFaqDuCxXZ2IkpICg10LakhN6uLU0uCCtZRc5BfFiYRgPPfUFi
         tUVSlUkPPh9pDkPR2mi4yxIydEivv7QN7Wxg04RE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180808050326eucas1p1d8b69ea0256e3c6b6eae2199fcf3993f~I0Da2yKQX0397803978eucas1p1H;
        Wed,  8 Aug 2018 05:03:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 37.44.04294.E997A6B5; Wed,  8
        Aug 2018 06:03:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180808050325eucas1p1fb0792e2a8490fa3eebdfdaa6165038c~I0DZ-C69N2154421544eucas1p1X;
        Wed,  8 Aug 2018 05:03:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180808050325eusmtrp2d2191f11f7a11c12b7d2516c424bfe2e~I0DZv9CG62562225622eusmtrp2G;
        Wed,  8 Aug 2018 05:03:25 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-fd-5b6a799ea1c1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 76.F6.04128.D997A6B5; Wed,  8
        Aug 2018 06:03:25 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180808050324eusmtip1cf48669b61f3fc1547a3b528b170b0ee~I0DZWxNis0379303793eusmtip1P;
        Wed,  8 Aug 2018 05:03:24 +0000 (GMT)
Subject: Re: [PATCH] Input: cros_ec_keyb: Remove check before calling
 pm_wakeup_event.
To:     Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ravi Chandra Sadineni <ravisadineni@google.com>,
        Todd Broch <tbroch@google.com>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Wed, 8 Aug 2018 07:03:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAEZbON5vMOiYRsnN1MyuSov3URByeAp-z3EEsEH6tqY23U32wQ@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeT3n7JyNpsdp+WCWMU1olmZ0GRiRULH6ZN8qK1t61Nk2x5kz
        NTChlWaaOih1XrNSKbDU0rlCS6MhZqZiZSBlDLuOkbPJvFQeT5bffv/n/n95KUxykwikVNp0
        htUq1VKBCG9/7nm5pSYrNW7rfKOPvLf+M5KPTbkJ+Yi1SiAvH+zykjcb3Ug+6Jgj5PUzE8Re
        UlGZO4QrOs3jpKKu1aBwta6PxY+JdicyalUGw0buOSVKKa27gesW1mSW5V8jctGApAAJKaC3
        g+3uqFcBElESuglB15yb4MU0goZ+J8kLF4Li8TFsuWXEWYr4RCOC2Z/DGC+cCLoraxBX5Ucf
        AWdhE8mxP70DBjz3CY4x2o7gomWJBXQUFDgKBBzjdCjcNrYtDqKo1fRxmLNGc2Ex7Qt9FXac
        YyF9GCoqi3B+TDB0OKowngPgnb12yQPQDSQYi0pwbo6YzoCW+fP80fug+8czxLMffLU9IHkO
        gt+dy70XEOSVm0leFCJ4WGUR8FXR0GsbIrihGL0J7lkjOQQ6BhZMwKM3vHX48ud4g6m9DOPD
        Ysi/9Pelw8Bsa/639emrYawESc0rTJpXGDOvMGb+v7YO4XdQAGPQa5IZ/TYtczZCr9ToDdrk
        iIQ0TSta/Dr9v2zTFmSdP92DaApJV4mpPlWchFBm6LM0PQgoTOovTshZDIkTlVnZDJsWzxrU
        jL4HraVwaYDYW5YUJ6GTlenMGYbRMexy1osSBuYi4YegIleeoNodbmkLURL9SaadnxwHQq6W
        Da+LvTwgnDSxMyFHs1Wh7tGN4Sdf99qpN5raJ45bYZpu5GuYDbyii6iYnA3dsCtT9kjhceq+
        kO7rqeMe6beJ/S+qWeNUZHD7occtXd9ZMoeVWfyGNxf7HOyIN504VzH5Puaj1KWW4voUZZQM
        Y/XKP7TeNjU2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xu7pzK7OiDWasFbQ4vOgFo8XNT99Y
        LS7vmsNmMeP8PiaLdS3fGC3Ov/3NarHo+0NWB3aP2Q0XWTx2zrrL7rFgU6nH501yASxRejZF
        +aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkTFyxkKfgr
        VjG9YyprA+NZoS5GTg4JAROJy+8nMnYxcnEICSxllNjy7wYzREJG4uS0BlYIW1jiz7UuNoii
        t4wSCxdsYANJCAtESLzvWcEOYosImEqc/bmBFaSIWeAJo8TLMzPZITqa2SWebN0KVsUmYCjR
        9bYLrJtXwE5i2tzlLCA2i4CKxNKWzWCrRQViJI5OboGqEZQ4OfMJWA2nQKDEzNm9YDazgJnE
        vM0PmSFseYntb+dA2eISt57MZ5rAKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusZFecWJu
        cWleul5yfu4mRmC0bTv2c8sOxq53wYcYBTgYlXh4E05nRguxJpYVV+YeYpTgYFYS4U2uAwrx
        piRWVqUW5ccXleakFh9iNAV6biKzlGhyPjAR5JXEG5oamltYGpobmxubWSiJ8543qIwSEkhP
        LEnNTk0tSC2C6WPi4JRqYJyy26LfYKOmZ1NigEqz0dnTjhuXVZ8p0P4XkvLoQO+jMwcXnmeZ
        231b+EGuZ3V08Wt+30jH6VOMujXP3fqYFK3vu5+jrf+HHq//jzNufGnGLyeVbZ05K11lcnPR
        va/r2F7yF0SJdNlcUro9fVZV/De71XtiryXMKMuzaLu63yqi91ok97agr0osxRmJhlrMRcWJ
        ANd0+sLMAgAA
Message-Id: <20180808050325eucas1p1fb0792e2a8490fa3eebdfdaa6165038c~I0DZ-C69N2154421544eucas1p1X@eucas1p1.samsung.com>
X-CMS-MailID: 20180808050325eucas1p1fb0792e2a8490fa3eebdfdaa6165038c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180803072628eucas1p26abe0cb121b974401759502f8807bb96
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180803072628eucas1p26abe0cb121b974401759502f8807bb96
References: <CGME20180803072628eucas1p26abe0cb121b974401759502f8807bb96@eucas1p2.samsung.com>
        <20180605224458.62692-1-ravisadineni@chromium.org>
        <20180803072628eucas1p26abe0cb121b974401759502f8807bb96~HTx4BGQjl1119311193eucas1p2U@eucas1p2.samsung.com>
        <CAEZbON7qLheHFuU6zwArCz=CG03JvnFjcehBGjE4RqROYrMLhQ@mail.gmail.com>
        <CAKdAkRQG08d_duPiKFi_=xUNO93c0Rcw9kpaYFFJahjJM-NdGw@mail.gmail.com>
        <CAEZbON4O0X8Fo6eAbmPOSiB1_Tw7x+Ox3ROoGfZQn72uQGQLkg@mail.gmail.com>
        <20180806052949eucas1p2483800c02730febd03d4a661a25fa405~INH40XvCx2719627196eucas1p2X@eucas1p2.samsung.com>
        <CAKdAkRSvLq-L3FrODUqxXqDs2FymM9k5dZRxnOpc44rFiHaWAQ@mail.gmail.com>
        <20180806071543eucas1p233ac5016e1a586594cf8ecd1fe3214b0~IOkV1Zt7j2129321293eucas1p20@eucas1p2.samsung.com>
        <CAEZbON72eVUCNT3ePEZKrB5B6+6YYgO7=X0TY0eBqUb3ws0sLA@mail.gmail.com>
        <CAEZbON5vMOiYRsnN1MyuSov3URByeAp-z3EEsEH6tqY23U32wQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

On 2018-08-07 23:59, Ravi Chandra Sadineni wrote:
> hi Merek,
>
> I tried booting a snow device and could not get it to boot it to the
> console. I assume i don't have right kernel config. Can you share your
> config if possible.

I use standard exynos_defconfig bundled with Linux kernel. I've followed
this instruction to boot in on Snow:

https://s-opensource.org/2016/03/24/use-mainline-u-boot-non-signed-kernels-exynos-chromebooks/

>
> Thanks,
> RaviOn Mon, Aug 6, 2018 at 4:05 PM Ravi Chandra Sadineni
> <ravisadineni@chromium.org> wrote:
>> Hi Merek,
>>
>> Thanks for the info. Lemme understand what's going on. Will update the
>> thread once I have more info.
>>
>> Thanks,
>> Ravi
>> On Mon, Aug 6, 2018 at 12:15 AM Marek Szyprowski
>> <m.szyprowski@samsung.com> wrote:
>>> Hi Dmitry
>>>
>>> On 2018-08-06 08:16, Dmitry Torokhov wrote:
>>>> On Sun, Aug 5, 2018 at 10:29 PM Marek Szyprowski
>>>> <m.szyprowski@samsung.com> wrote:
>>>>> Hi Ravi,
>>>>>
>>>>> On 2018-08-03 18:53, Ravi Chandra Sadineni wrote:
>>>>>> Understood. I am trying to reproduce this issue locally. Wanted to
>>>>>> know the version of the kernel so I can give a try. Marek, can you
>>>>>> please confirm the kernel version.
>>>>>>
>>>>> Yes, sorry for the missing context, I was in hurry writing the report and
>>>>> I wanted to send it before leaving the office. I'm testing mainline on Snow
>>>>> with exynos_defconfig.
>>>>>
>>>>> Suspend/resume is partially broken already with mainline, but if you disable
>>>>> CPUfreq support, it works fine on Linux v4.17.
>>>>>
>>>>> I've posted CPUfreq related fixes here if you are interested:
>>>>> https://patchwork.kernel.org/patch/10554607/
>>>>> https://patchwork.kernel.org/patch/10554603/
>>>>>
>>>>> The issue with cros_ec_keyb patch appears first on Linux v4.18-rc1, which is
>>>>> the first release with that patch.
>>>> Marek, this patch should only be in -next, I do not believe I sent it
>>>> to Linus just yet. If mainline is broken for you it can't be caused by
>>>> this patch.
>>> Aaahh. My fault then. The suspend/resume issue is cause by commit
>>> 38ba34a43dbc ("Input: cros_ec_keyb - mark cros_ec_keyb driver as wake
>>> enabled device."), which has been merged to v4.18-rc1.
>>>
>>> It looks that I've downloaded wrong patch from the patchwork to reply it
>>> with a a bug report. :( I'm really sorry for the noise in the wrong thread.
>>>
>>> Ravi: please let me know how can I help you to debug this issue.
>>>
>>>>> Linux -next from 20180803, which has a few
>>>>> more patches for cros_ec_keyb suffers from the same issue.
>>>> Just to confirm, if you revert only this patch from -next you get
>>>> suspend/resume back?
>>>>
>>>> Thanks.
>>> Best regards
>>> --
>>> Marek Szyprowski, PhD
>>> Samsung R&D Institute Poland
>>>
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

