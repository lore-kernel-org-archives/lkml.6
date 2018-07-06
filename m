Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1B2C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB6E2404E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jA+P2SEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB6E2404E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754108AbeGFGWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:22:30 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42923 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753304AbeGFGW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:22:28 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180706062225euoutp02eadb9e30e8ae910ae563306f3d775fd2~_s19o2s5s2009920099euoutp02M
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jul 2018 06:22:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180706062225euoutp02eadb9e30e8ae910ae563306f3d775fd2~_s19o2s5s2009920099euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530858145;
        bh=xxAEJwcDtRVeMqtA//q7OiGoR9gjPWV8XIlo7lViVB8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jA+P2SEZzl3jl6wffTEFOHR/uD5FDVJJmlSXID1tb/JI10j+wQUuuv2xgveKxjmtB
         pKqIkDk7DKZFj1JfXo4+iQk20FQyX0Y/uAc7P0Djttf7OgQIVGZNxl9+yxIs878I/0
         0+R0wjAVOU+zqGv1SV7MKUDwdZB9ozv3feBKnb4U=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180706062224eucas1p16a1966e09d00e016f4c40d9dfd223880~_s18Zou3E3251732517eucas1p1r;
        Fri,  6 Jul 2018 06:22:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C3.69.05700.0AA0F3B5; Fri,  6
        Jul 2018 07:22:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180706062223eucas1p1295e6366bbe19f4fe11a6427bc12af94~_s17Sg74d0494404944eucas1p1X;
        Fri,  6 Jul 2018 06:22:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180706062222eusmtrp2ceb54a788e2d048edccc6caf31f9bb96~_s17D9BaQ0556305563eusmtrp2S;
        Fri,  6 Jul 2018 06:22:22 +0000 (GMT)
X-AuditID: cbfec7f2-1c1ff70000011644-4d-5b3f0aa046a5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 45.56.04183.E9A0F3B5; Fri,  6
        Jul 2018 07:22:22 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180706062222eusmtip256bb12ca1b3db024012b8bfeaf34fc82~_s16ktMK51349113491eusmtip2D;
        Fri,  6 Jul 2018 06:22:22 +0000 (GMT)
Subject: Re: [PATCH] dma: add support for reporting pause and resume
 separately
To:     Vinod <vkoul@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        dmaengine <dmaengine@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Fri, 6 Jul 2018 08:22:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180706060036.GR22377@vkoul-mobl>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjt3b27uxtOX6fik0nFkLAgP6DgQmUGFSuJEqMfGtrKmy51yqaW
        FaVZfiUp2lCnqZjRUtI0v2aZtUWzTKcmIaWVqJEfw0qtBD9yXi3/neec57zPOfDShKSV70Ir
        lLGsSimPlFIisuHVbOf2UtHeIK8fOoLp7TbwmNFsI2Jq8qv5jGZwmGLyNF2IqdTM85ny3BI+
        8665iGL0/W2Er1D2aOoaJdNrBwSyu09HebLainRKVj5h4Mtu1VUg2VTtxmOCQNHuUDZSEc+q
        PH1OicIbf5eSMR/tLhgHkqlE9NUmAwlpwDvgzkgpPwOJaAnWIfjU30BxwzSCxZIpATdMIXhs
        eSBYtWTOm1aE+wjK3o4sCxI8iSDtzXordsD+UDiWssw74kOQ31FFWg0E7uTBaM2zZYHC3pBh
        yaCsmMRu0PrSjKzYCZ+E4rJ50orF2B5eFwwvYZoWYi/IalmmCbwJGi1FBIed4cNwCc/6PuAe
        AZQNziHOGw+VuX9ILvV+KCwbWmngAGOmuhXsCov6VXMygtR8rYAbMhHUFzVR3NYuMJq6+dYU
        BN4K1c2eHL0PcroNAisN2Bb6LPZcIFvIacgjOFoMaSkSbnsLaE1V/86+6OohspFUu6aldk01
        7Zpq2v93SxFZgZzZOHVUGKv2VrLnPdTyKHWcMszjTHRULVr6Vu0Lpp9NaKbntAFhGkltxODl
        EyThy+PVCVEGBDQhdRS3+C9R4lB5wkVWFR2iiotk1Qa0gSalzuJg9yuBEhwmj2UjWDaGVa2q
        PFrokojYmyFmHy9NUq1/UsDt4vczTj5z6+pLxp+nT9iFmL9/3mkMbypsLDinyFkYTPQ1tyFb
        1by7Prr9am+ha/j1bwvy8cHgI0zwic1D+UnHUw+by9ODLvW4HYCIaV1zx9k2v9jZhQjdw6Ok
        5jIYYw4qvtx78st2xjfoRnqoX9ae7IDJPimpDpd7byNUavlf1c1SIlIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xe7rzuOyjDRo+GltcuXiIyeLlhMOM
        FhtnrGe1mPrwCZvF9KkXGC1WT/3LarFk8nxWi8u75rBZ7LxzgtmB02PD5yY2j52z7rJ7LN7z
        kslj06pONo8lbw6xevRtWcXo8XmTXAB7lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGx
        eayVkamSvp1NSmpOZllqkb5dgl7G9u8LWApu81ccvtvM1sD4jKeLkZNDQsBEoufvcfYuRi4O
        IYGljBJ3lvUxQSRkJE5Oa2CFsIUl/lzrYuti5AAqesso8TURJCwsECgx+1UbO4gtIuApMePs
        OhaQOcwCF5gkWt+eZoQYepdJ4uvm6cwgVWwChhJdb0EGcXLwCthJnOvezQJiswioSOw/cp4R
        xBYViJFYufk1VI2gxMmZT1hAFnMKGEj07wUrZxYwk5i3+SEzhC0vsf3tHChbXOLWk/lMExiF
        ZiHpnoWkZRaSlllIWhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjM1tx35u2cHY9S74
        EKMAB6MSD2+Gtl20EGtiWXFl7iFGCQ5mJRHevYFAId6UxMqq1KL8+KLSnNTiQ4ymQL9NZJYS
        Tc4Hpo28knhDU0NzC0tDc2NzYzMLJXHe8waVUUIC6YklqdmpqQWpRTB9TBycUg2MuzU+RJl9
        F3ctZruifY/76X2N27t+lwXPmnlr0v3za7jthO4ucmEUq7xi6PU1eY7UZu7lu/zznW/MDjkh
        /d/s6ZJEvS751+FRXSEpDedPiNr23mRN5DEQ2v84t2e2XWr6YqPrqyeL7/P6Pf2uZOHfGxfW
        2t/o2sQdEPDj0jStB5Kfl3dXxD3mUmIpzkg01GIuKk4EABfKcV7jAgAA
Message-Id: <20180706062223eucas1p1295e6366bbe19f4fe11a6427bc12af94~_s17Sg74d0494404944eucas1p1X@eucas1p1.samsung.com>
X-CMS-MailID: 20180706062223eucas1p1295e6366bbe19f4fe11a6427bc12af94
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65
References: <CGME20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65@eucas1p2.samsung.com>
        <20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65~9jzNWZMqQ1216712167eucas1p27@eucas1p2.samsung.com>
        <20180704070033.GA22377@vkoul-mobl>
        <CAHp75Vfy8=i3dSYoQ5Uto-RtmU6E8BVWU1dmG8BihN=Wtkr+_A@mail.gmail.com>
        <20180706060036.GR22377@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 2018-07-06 08:00, Vinod wrote:
> On 04-07-18, 13:38, Andy Shevchenko wrote:
>> On Wed, Jul 4, 2018 at 10:00 AM, Vinod <vkoul@kernel.org> wrote:
>>> Hi Marek,
>>>
>>> On 02-07-18, 15:08, Marek Szyprowski wrote:
>>>> 'cmd_pause' DMA channel capability means that respective DMA engine
>>>> supports both pausing and resuming given DMA channel. However, in some
>>>> cases it is important to know if DMA channel can be paused without the
>>>> need to resume it. This is a typical requirement for proper residue
>>>> reading on transfer timeout in UART drivers. There are also some DMA
>>>> engines with limited hardware, which doesn't really support resuming.
>>> Am curious given that your hardware does not support resume, what was motivation
>>> for adding pause?
>>>
>>>> Reporting pause and resume capabilities separately allows UART drivers to
>>>> properly check for the really required capabilities and operate in DMA
>>>> mode also in systems with limited DMA hardware. On the other hand drivers,
>>>> which rely on full channel suspend/resume support, should now check for
>>>> both 'pause' and 'resume' features.
>>>>
>>>> Existing clients of dma_get_slave_caps() have been checked and the only
>>>> driver which rely on proper channel resuming is soc-generic-dmaengine-pcm
>>>> driver, which has been updated to check the newly added capability.
>>>> Existing 'cmd_pause' now only indicates that DMA engine support pausing
>>>> given DMA channel.
>>> The change looks fine to me. I was hoping that serial would also check
>>> this..
>> AFAIU serial does not need to resume.
> I meant the serial should check for Pause capability..

Yes, I want to add such check to Samsung Exynos serial driver once this 
change is
merged. PL330 DMA engine (which is used in Samsung Exynos SoCs) supports 
only
pause, it is not possible to check that functionality from serial driver 
yet.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

