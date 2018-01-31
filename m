Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752115AbeAaGD4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 01:03:56 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:56308 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbeAaGDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 01:03:54 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180131060324epoutp034ef7b5e825de7c9e20515dcf74b3b71d~Oz80dx_Fc2105621056epoutp03k
X-AuditID: b6c32a45-3ebff70000001023-10-5a715c2c59bc
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A715C2B.70609@samsung.com>
Date: Wed, 31 Jan 2018 15:03:23 +0900
From: Inki Dae <inki.dae@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RFC 1/2] arm: cacheflush syscall: process only pages that are
 in the memory
In-reply-to: <20180126213911.GY17719@n2100.armlinux.org.uk>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7bCmqa5OTGGUwfzdLBYbZ6xntXi/rIfR
        YtPja6wWl3fNYbM4NHUvo8XaI3fZLV5+PMHiwO6xZt4aRo/L1y4ye2xeUu/Rt2UVo8fnTXIB
        rFGpNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVygp
        lCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJWiDQ2N9AwNzPWMjIz0TIxjrYxMgUoSUjOefZ3E
        XvCTv2LvlKOMDYx/eLoYOTkkBEwkdn04zwRiCwnsYJT48saui5ELyP7OKLH8+3lGmKIzB88y
        QyQ2MEpcW72OHSTBKyAo8WPyPZYuRg4OZgF5iSOXskHCzAKaElt3r2eHqL/HKHGhfS5UvYbE
        +603wbaxCKhKrFi2DSzOBmRPXHGfDcQWFYiQ2Dn/G1hcRCBZovfRIrDFzALnGCUuv/7CApIQ
        FoiW2HriHdh1nALWEjcmLWAFKZIQOMAmMXduJxPE2S4Sl/69ZoawhSVeHd/CDmFLSzxbtZER
        oqGdUWLX2etsEE4P0NOLF0FVGUs8W9jFBPEQn0TH4b/sIH9KCPBKdLQJQZR4SHx6vocVwnaU
        WHHrCCPEzyuYJNZNXsc8gVF2FlIwzUIE0yykYFrAyLyKUSy1oDg3PbXYqMBQrzgxt7g0L10v
        OT93EyM4tWm57mCccc7nEKMAB6MSD29CVUGUEGtiWXFl7iFGCQ5mJRFeFp3CKCHelMTKqtSi
        /Pii0pzU4kOMpsBQnsgsJZqcD0y7eSXxhiaWBiZmZkbmZhbAZCXO2xbgEiUkkJ5YkpqdmlqQ
        WgTTx8TBKdXA6LBF0XGJK+M3Z3eZ9ri7E1z9bmlYV6jV/Hwvm23t2G89a6VoS9CKrBm3Ms6l
        /XZODP2j9Y/3xa5zZyyDP/r89lRJ0VhUffKx5IvXf20XbA53mFCl3NKyj2GnZAmnf3IF58UQ
        66u3161PsGrrPx6qVl9hKPzbrFT7rf5H/3vpvPeKVqw7mHldiaU4I9FQi7moOBEAQrhWqoMD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsVy+t9jQV3tmMIog55OI4uNM9azWrxf1sNo
        senxNVaLy7vmsFkcmrqX0WLtkbvsFi8/nmBxYPdYM28No8flaxeZPTYvqffo27KK0ePzJrkA
        1igum5TUnMyy1CJ9uwSujGdfJ7EX/OSv2DvlKGMD4x+eLkZODgkBE4kzB88ydzFycQgJrGOU
        2Ph3PQtIgldAUOLH5HtANgcHs4C8xJFL2SBhZgF1iUnzFkHVP2CU6HzzlRmiXkPi/dabTCA2
        i4CqxIpl29hBbDYge+KK+2wgc0QFIiS6T1SChEUEkiVW9G1iA5nDLHCOUeLp569sIAlhgWiJ
        M4e/sYLYQgKrmCSWHwC7h1PAWuLGpAWsExj5ZyE5bxbCebOQnLeAkXkVo2RqQXFuem6xUYFR
        Xmq5XnFibnFpXrpecn7uJkZgQG87rNW/g/HxkvhDjAIcjEo8vAlVBVFCrIllxZW5hxglOJiV
        RHhZdAqjhHhTEiurUovy44tKc1KLDzFKc7AoifPy5x+LFBJITyxJzU5NLUgtgskycXBKNTBu
        jtJr7TnnpaIpGHpb7cyuQ223HI4b1jnK+JfINF5evbAt7CifWsnHK39XXgkVuf1X9qjCrBU9
        VuqOVtNzEnc8LYpI1qpmbDinW8T+/kyXN8ufjRl1/C9U+Vt7vTJS0n3PhTZntahdv/r49zOh
        ylm/Chav+PW0SzZfjufvvvYIG68KD+apy5VYijMSDbWYi4oTAaTMDs5kAgAA
X-CMS-MailID: 20180131060323epcas2p37ee4d9fdee408fa18482de15ec048f4c
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180126111453eucas1p1330d8561386c3cf2bb457bc22c0d99a8
X-RootMTR: 20180126111453eucas1p1330d8561386c3cf2bb457bc22c0d99a8
References: <CGME20180126111453eucas1p1330d8561386c3cf2bb457bc22c0d99a8@eucas1p1.samsung.com>
        <20180126111441.29353-1-m.szyprowski@samsung.com>
        <20180126113226.GX17719@n2100.armlinux.org.uk>
        <589aa8ab-5bfc-e065-51f9-3a403c346d92@samsung.com>
        <20180126213911.GY17719@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

2018년 01월 27일 06:39에 Russell King - ARM Linux 이(가) 쓴 글:
> On Fri, Jan 26, 2018 at 02:30:47PM +0100, Marek Szyprowski wrote:
>> Hi Russell,
>>
>> On 2018-01-26 12:32, Russell King - ARM Linux wrote:
>>> On Fri, Jan 26, 2018 at 12:14:40PM +0100, Marek Szyprowski wrote:
>>>> glibc in calls cacheflush syscall on the whole textrels section of the
>>>> relocated binaries. However, relocation usually doesn't touch all pages
>>>> of that section, so not all of them are read to memory when calling this
>>>> syscall. However flush_cache_user_range() function will unconditionally
>>>> touch all pages from the provided range, resulting additional overhead
>>>> related to reading all clean pages. Optimize this by calling
>>>> flush_cache_user_range() only on the pages that are already in the
>>>> memory.
>>> What ensures that another CPU doesn't remove a page while we're
>>> flushing it?  That will trigger a data abort, which will want to
>>> take the mmap_sem, causing a deadlock.
>>
>> I thought that taking mmap_sem will prevent pages from being removed.
>> mmap_sem has been already taken in the previous implementation of that
>> syscall, until code simplification done by commit 97c72d89ce0e ("ARM:
>> cacheflush: don't bother rounding to nearest vma").
> 
> No, you're not reading the previous code state correctly.  Take a closer
> look at that commit.
> 
> find_vma() requires that mmap_sem is held across the call as the VMA
> list is not stable without that semaphore held.  However, more
> importantly, notice that it drops the semaphore _before_ calling the
> cache flushing function (__do_cache_op()).
> 
> The point is that if __do_cache_op() faults, it will enter
> do_page_fault(), which will try to take the mmap_sem again, causing
> a deadlock.

I'm not sure but seems this patch tries to do cache-flush only in-memory pages.
So I think the page fault wouldn't happen becasue flush_cache_user_range function returns always 0.

Thanks,
Inki Dae

> 
