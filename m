Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF15C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35552152B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="luV5aTHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35552152B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeHYBgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 21:36:40 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:49088 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeHYBgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 21:36:39 -0400
Received: from [192.168.0.27] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 95388B92;
        Sat, 25 Aug 2018 00:00:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1535148008;
        bh=+qH5DiZpsYrRvNvZZ5V6JWxd76uv9gQzL5AcCv4VJfE=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=luV5aTHbdPNN3mIrBoYjm8yeadkkg1B5JmwLXVm06/8GUiiUC38dsTWtAKZ2UA7gY
         gPPW6T4SInXL7KvDs6b3qfSiD+Bq9/kG8GpTKv0396e2OvXR1ZfZWqt4zxmfU1RS14
         Fkp1QZmb/Gdu1p3lqRt4y0qhlVvd49R92WLZe9Ug=
Reply-To: kieran.bingham@ideasonboard.com
Subject: Re: [RFC PATCH v1] media: uvcvideo: Cache URB header data before
 processing
To:     Keiichi Watanabe <keiichiw@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        ezequiel@collabora.com, "Matwey V. Kornilov" <matwey@sai.msu.ru>
References: <14751117.J1GmkhZxMo@avalon>
 <Pine.LNX.4.44L0.1808091005210.1549-100000@iolanthe.rowland.org>
 <CAD90Vcad9+-9VXkwb93voFK9gEZnhJ-WXwD5=1ugsdOq5e-GOg@mail.gmail.com>
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kieran.bingham@ideasonboard.com; keydata=
 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
 sbsRB8KNNvVXBOVNwko86rQqF9drZuw=
Organization: Ideas on Board
Message-ID: <12d35831-a658-c8c7-7fda-32a591facdab@ideasonboard.com>
Date:   Fri, 24 Aug 2018 23:00:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAD90Vcad9+-9VXkwb93voFK9gEZnhJ-WXwD5=1ugsdOq5e-GOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keiichi,

On 24/08/18 07:06, Keiichi Watanabe wrote:
> Hi all.
> 
> We performed two types of experiments.
> 
> In the first experiment, we compared the performance of uvcvideo by
> changing a way of memory allocation, usb_alloc_coherent and kmalloc.
> At the same time, we changed conditions by enabling/disabling
> asynchronous memory copy suggested by Kieran in [1].
> 
> The second experiment is a comparison between dma_unmap/map and dma_sync.
> Here, DMA mapping is done manually in uvc handlers. This is similar to
> Matwey's patch for pwc.
> https://patchwork.kernel.org/patch/10468937/.
> 
> Raw data are pasted after descriptions of the experiments.

Thank you for sharing the data and test cases.


> # Settings
> The test device was Jerry Chromebook (RK3288) with Logitech Brio 4K.
> We did video capturing at
> https://webrtc.github.io/samples/src/content/getusermedia/resolution/
> with Full HD resolution in about 30 seconds for each condition.
> 
> For logging statistics, I used Kieran's patch [2].
> 
> ## Exp. 1
> Here, we have two parameters, way of memory allocation and
> enabling/disabling async memcopy.
> So, there were 4 combinations:
> 
> A. No Async + usb_alloc_coherent (with my patch caching header data)
>    Patch: [3] + [4]
>    Since Kieran's async patches are already merged into ChromeOS's
> kernel, we disabled it by [3].
>    Patch [4] is an updated version of my patch.
> 
> B. No Async + kmalloc
>    Patch: [3] + [5]
>    [5] just adds '#define CONFIG_DMA_NONCOHERENT' at the beginning of
> uvc_video.c to use kmalloc.
> 
> C. Async + usb_alloc_coherent (with my patch caching header data)
>    Patch: [4]
> 
> D. Async + kmalloc
>    Patch: [5]
> 
> ## Exp. 2
> The conditions of the second experiment are based on condition D,
> where URB buffers are allocated by kmalloc and Kieran's asynchronous
> patches are enabled.
> 
> E. Async + kmalloc + manually unmap/map for each packet
>    Patch: [6]
>    URB_NO_TRANSFER_DMA_MAP flag is used here. dma_map and dma_unmap
> are explicitly called manually in uvc_video.c.
> 
> F. Async + kmalloc + manually sync for each packet
>    Patch: [7]
>    In uvc_video_complete, dma_single_for_cpu is called instead of
> dma_unmap_single and dma_map_single.
> 
> Note that the elapsed times for E and F cannot be compared with those
> for D in a simple way.
> This is because we don't measure elapsed time of functions outside of
> uvcvideo.c by [2].
> For example, while DMA-unmapping for each packet is done before
> uvc_video_complete is called at the condition D,
> it's done in uvc_video_complete at the condition E.
> 
> # References for patches
> [1] Asynchronous UVC
> https://www.mail-archive.com/linux-media@vger.kernel.org/msg128359.html
> 
> [2] Kieran's patch for measuring the performance of uvcvideo.
> https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git/commit/?h=uvc/async-ml&id=cebbd1b629bbe5f856ec5dc7591478c003f5a944
> I used the modified version of it for ChromeOS, but almost same.
> http://crrev.com/c/1184597
> The main difference is that our patch uses do_div instead of / and %.

Ah yes, I keep meaning to do this conversion, ever since the build-bots
warned me ...


> 
> [3] Disable asynchronous decoding
> http://crrev.com/c/1184658
> 
> [4] Cache URB header data before processing
> http://crrev.com/c/1179554
> This is an updated version of my patch I sent at the begging of this thread.
> I applied Kieran's review comments.
> 
> [5] Use kmalloc for urb buffer
> http://crrev.com/c/1184643
> 
> [6] Manually DMA dma_unmap/map for each packet
> http://crrev.com/c/1186293
> 
> [7] Manually DMA sync for each packet
> http://crrev.com/c/1186214
> 
> # Results
> 
> For the meanings of each value, please see Kieran's patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git/commit/?h=uvc/async-ml&id=cebbd1b629bbe5f856ec5dc7591478c003f5a944
> 
> ## Exp. 1
> 
> A. No Async + usb_alloc_coherent (with my patch caching header data)
> frames:  1121
> packets: 233471
> empty:   44729 (19 %)
> errors:  34801
> invalid: 8017
> pts: 1121 early, 986 initial, 1121 ok
> scr: 1121 count ok, 111 diff ok
> sof: 0 <= sof <= 0, freq 0.000 kHz
> bytes 135668717 : duration 32907
> FPS: 34.06
> URB: 427489/3048 uS/qty: 140.252 avg 2.625 min 660.625 max (uS)
> header: 440868/3048 uS/qty: 144.641 avg 0.000 min 674.625 max (uS)
> latency: 30703/3048 uS/qty: 10.073 avg 0.875 min 26.541 max (uS)
> decode: 396785/3048 uS/qty: 130.179 avg 0.875 min 634.375 max (uS)
> raw decode speed: 2.740 Gbits/s
> raw URB handling speed: 2.541 Gbits/s
> throughput: 32.982 Mbits/s
> URB decode CPU usage 1.205779 %
> 
> ---
> 
> B. No Async memcpy + kmalloc
> frames:  949
> packets: 243665
> empty:   47804 (19 %)
> errors:  2406
> invalid: 1058
> pts: 949 early, 927 initial, 860 ok
> scr: 949 count ok, 17 diff ok
> sof: 0 <= sof <= 0, freq 0.000 kHz
> bytes 145563878 : duration 30939
> FPS: 30.67
> URB: 107265/2448 uS/qty: 43.817 avg 3.791 min 212.042 max (uS)
> header: 192608/2448 uS/qty: 78.679 avg 0.000 min 471.625 max (uS)
> latency: 24860/2448 uS/qty: 10.155 avg 1.750 min 28.000 max (uS)
> decode: 82405/2448 uS/qty: 33.662 avg 1.750 min 186.084 max (uS)
> raw decode speed: 14.201 Gbits/s
> raw URB handling speed: 10.883 Gbits/s
> throughput: 37.638 Mbits/s
> URB decode CPU usage 0.266349 %
> 
> ---
> 
> C. Async + usb_alloc_coherent (with my patch caching header data)
> frames:  874
> packets: 232786
> empty:   45594 (19 %)
> errors:  46
> invalid: 48
> pts: 874 early, 873 initial, 874 ok
> scr: 874 count ok, 1 diff ok
> sof: 0 <= sof <= 0, freq 0.000 kHz
> bytes 137989497 : duration 29139
> FPS: 29.99
> URB: 577349/2301 uS/qty: 250.912 avg 24.208 min 1009.459 max (uS)
> header: 50334/2301 uS/qty: 21.874 avg 0.000 min 77.583 max (uS)
> latency: 77597/2301 uS/qty: 33.723 avg 15.458 min 172.375 max (uS)
> decode: 499751/2301 uS/qty: 217.188 avg 4.084 min 978.542 max (uS)
> raw decode speed: 2.212 Gbits/s
> raw URB handling speed: 1.913 Gbits/s
> throughput: 37.884 Mbits/s
> URB decode CPU usage 1.715060 %
> 
> ---
> 
> D. Async memcpy + kmalloc
> frames:  870
> packets: 231152
> empty:   45390 (19 %)
> errors:  171
> invalid: 160
> pts: 870 early, 870 initial, 810 ok
> scr: 870 count ok, 0 diff ok
> sof: 0 <= sof <= 0, freq 0.000 kHz
> bytes 137406842 : duration 29036
> FPS: 29.96
> URB: 160821/2258 uS/qty: 71.222 avg 15.750 min 985.542 max (uS)
> header: 40369/2258 uS/qty: 17.878 avg 0.000 min 56.292 max (uS)
> latency: 72411/2258 uS/qty: 32.068 avg 10.792 min 946.459 max (uS)
> decode: 88410/2258 uS/qty: 39.154 avg 1.458 min 246.167 max (uS)
> raw decode speed: 12.491 Gbits/s
> raw URB handling speed: 6.870 Gbits/s
> throughput: 37.858 Mbits/s
> URB decode CPU usage 0.304485 %
> 
> ----------------------------------------
> ## Exp. 2
> 
> E. Async + kmalloc + manually dma_unmap/map for each packet
> frames:  928
> packets: 247476
> empty:   34060 (13 %)
> errors:  16
> invalid: 32
> pts: 928 early, 928 initial, 163 ok
> scr: 928 count ok, 0 diff ok
> sof: 0 <= sof <= 0, freq 0.000 kHz
> bytes 103315132 : duration 30949
> FPS: 29.98
> URB: 169873/1876 uS/qty: 90.551 avg 43.750 min 289.917 max (uS)
> header: 88962/1876 uS/qty: 47.421 avg 0.000 min 113.750 max (uS)
> latency: 109539/1876 uS/qty: 58.389 avg 37.042 min 253.459 max (uS)
> decode: 60334/1876 uS/qty: 32.161 avg 2.041 min 124.542 max (uS)
> raw decode speed: 13.775 Gbits/s
> raw URB handling speed: 4.890 Gbits/s
> throughput: 26.705 Mbits/s
> URB decode CPU usage 0.194948 %
> 
> ---
> 
> F. Async + kmalloc + manually dma_sync for each packet
> frames:  927
> packets: 246994
> empty:   33997 (13 %)
> errors:  226
> invalid: 65
> pts: 927 early, 927 initial, 560 ok
> scr: 927 count ok, 0 diff ok
> sof: 0 <= sof <= 0, freq 0.000 kHz
> bytes 103017167 : duration 30938
> FPS: 29.96
> URB: 170630/1868 uS/qty: 91.344 avg 43.167 min 1142.167 max (uS)
> header: 86372/1868 uS/qty: 46.237 avg 0.000 min 163.917 max (uS)
> latency: 109148/1868 uS/qty: 58.430 avg 35.292 min 1106.583 max (uS)
> decode: 61482/1868 uS/qty: 32.913 avg 2.334 min 215.833 max (uS)
> raw decode speed: 13.510 Gbits/s
> raw URB handling speed: 4.847 Gbits/s
> throughput: 26.638 Mbits/s
> URB decode CPU usage 0.198726 %
> 
> ----------------------------------------
> 
> I hope this helps.
> 

To make this easier to interpret, I've extracted the values with [0] and
done some manual copy pasting to compile this test data into a
spreadsheet and share it on google-docs [0]:

I've gone through quickly and tried to colour code/highlight good and
bad values with some form of traffic light colour scheme.


[0] http://paste.ubuntu.com/p/W9jsCdYjpP/
[1]
https://docs.google.com/spreadsheets/d/1uPdbdVcebO9OQ0LQ8hR2LGIEySWgSnGwwhzv7LPXAlU/edit?usp=sharing


Regards

Kieran



> Best regards,
> Keiichi
> On Thu, Aug 9, 2018 at 11:12 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>>
>> On Thu, 9 Aug 2018, Laurent Pinchart wrote:
>>
>>>>>> There is no need to wonder.  "Frequent DMA mapping/Cached memory" is
>>>>>> always faster than "No DMA mapping/Uncached memory".
>>>>>
>>>>> Is it really, doesn't it depend on the CPU access pattern ?
>>>>
>>>> Well, if your access pattern involves transferring data in from the
>>>> device and then throwing it away without reading it, you might get a
>>>> different result.  :-)  But assuming you plan to read the data after
>>>> transferring it, using uncached memory slows things down so much that
>>>> the overhead of DMA mapping/unmapping is negligible by comparison.
>>>
>>> :-) I suppose it would also depend on the access pattern, if I only need to
>>> access part of the buffer, performance figures may vary. In this case however
>>> the whole buffer needs to be copied.
>>>
>>>> The only exception might be if you were talking about very small
>>>> amounts of data.  I don't know exactly where the crossover occurs, but
>>>> bear in mind that Matwey's tests required ~50 us for mapping/unmapping
>>>> and 3000 us for accessing uncached memory.  He didn't say how large the
>>>> transfers were, but that's still a pretty big difference.
>>>
>>> For UVC devices using bulk endpoints data buffers are typically tens of kBs.
>>> For devices using isochronous endpoints, that goes down to possibly hundreds
>>> of bytes for some buffers. Devices can send less data than the maximum packet
>>> size, and mapping/unmapping would still invalidate the cache for the whole
>>> buffer. If we keep the mappings around and use the DMA sync API, we could
>>> possibly restrict the cache invalidation to the portion of the buffer actually
>>> written to.
>>
>> Furthermore, invalidating a cache is likely to require less overhead
>> than using non-cacheable memory.  After the cache has been invalidated,
>> it can be repopulated relatively quickly (an entire cache line at a
>> time), whereas reading uncached memory requires a slow transaction for
>> each individual read operation.
>>
>> I think adding support to the USB core for
>> dma_sync_single_for_{cpu|device} would be a good approach.  In fact, I
>> wonder whether using coherent mappings provides any benefit at all.
>>
>> Alan Stern
>>

-- 
Regards
--
Kieran
