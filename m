Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B207C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143E3208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpRWyjug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143E3208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbeGaPGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:06:43 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42606 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732110AbeGaPGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:06:43 -0400
Received: by mail-pl0-f66.google.com with SMTP id z7-v6so7146799plo.9;
        Tue, 31 Jul 2018 06:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6t1YF/5Oc/ghIQnV1XfAEsc5bXL1tHiN6OzwGgnLXSo=;
        b=hpRWyjugEVLrU5ErpiCkkwr68chyOkwEHrD1MGuIu+gfJsk+C3kVnIkUXMN3RaRJFC
         jOscLlf/5AaLDc874IEna8zSt+Ed1sJ51zqGkRhqlBM/EJRbMBl08tnUVeCoEcgFcNIt
         Fj5VTekRNewINlO1IzpoMU3T/sbJlOFs6Hz9QnsfLADqNPcoH0nRSizY5QeL41Uqltxi
         vf8bfJDJdpmKXgK0Mb13vil2Ox6LEYirrRS6GjEWAnJJVU3mfJTz8ExmZMjrCj01s62M
         /hlsY3eRiGxBQf1KO4oc7OhmVLoZek8syEyMwruVwlS3VHRkyMdz6qyt0ZG3ZJshqNLj
         8KTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6t1YF/5Oc/ghIQnV1XfAEsc5bXL1tHiN6OzwGgnLXSo=;
        b=WM/WEXWNhajgzaI9JKDj1tsorxMOh8KY2zFndrWHOFPHzfrkaMjljMmsHB/1++d0CT
         HjO6sAvIrZaf18H6JYfTrr26bvIR3qfZSSrxpANeYQFGG7xhXqNCj/S3y/5UaggIW8S9
         Y7rq4TPjrKCspgCEOWyhqXep7TtrNr8phHnfeP2CPrkVleTkYnYNm7XR3KYTz0pCJ3md
         3THuMKmPP72dxMbHgHBdMh9IE9TtZhTw2nXOVZCy8bGfQumHoUsTY2dFsHCh7p/7uAFl
         fwdv9wgn2X2bO5sxGzf7vJWgLtMn09PQAYTcaQ8heqXKKaVi06QULMciLt3gBx+kRyTE
         skhg==
X-Gm-Message-State: AOUpUlHbA9/Rdda2QNKYiql2OcM9b4qBql1TdHXjCXGvTNfeQHE/MwcY
        Jmkmn61l3v0P9QiyOO+zWC8=
X-Google-Smtp-Source: AAOMgpfWuTJ1ZWWHIKhQnFS9RTeqIlLYrRpwqse4dHaFZIciMDCAqRwIqXv7DK5jRU+fQo4Ovn6rHg==
X-Received: by 2002:a17:902:aa4b:: with SMTP id c11-v6mr20318898plr.344.1533043583080;
        Tue, 31 Jul 2018 06:26:23 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a25-v6sm16317644pgv.51.2018.07.31.06.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 06:26:22 -0700 (PDT)
Subject: Re: [BUG BISECT] Ethernet fail on VF50 (OF: Don't set default
 coherent DMA mask)
To:     Robin Murphy <robin.murphy@arm.com>, Stefan Agner <stefan@agner.ch>
Cc:     Christoph Hellwig <hch@lst.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fugang Duan <fugang.duan@nxp.com>
References: <CAJKOXPeaguNxRr7pCArJ5Db4tS6Kr5BDheCxskY+vd0dUN+0GQ@mail.gmail.com>
 <CAJKOXPfageiBVXddtdJRBS+092O3QfD0yoS_Mk+PoX7+qNYNUA@mail.gmail.com>
 <20180727140448.GA29001@lst.de> <20180728165820.GA5731@roeck-us.net>
 <45f7fc82-fb9c-e666-4ada-c5338d2c1c96@arm.com>
 <39fa11ce4b7dd151d98868f375baf818@agner.ch>
 <0e893142-a5db-d119-6eb3-f849db6b5d04@arm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f67628ad-4cae-96cd-d0c4-3b2f7d12a822@roeck-us.net>
Date:   Tue, 31 Jul 2018 06:26:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0e893142-a5db-d119-6eb3-f849db6b5d04@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/2018 05:32 AM, Robin Murphy wrote:
> On 31/07/18 09:19, Stefan Agner wrote:
>> On 30.07.2018 16:38, Robin Murphy wrote:
>>> On 28/07/18 17:58, Guenter Roeck wrote:
>>>> On Fri, Jul 27, 2018 at 04:04:48PM +0200, Christoph Hellwig wrote:
>>>>> On Fri, Jul 27, 2018 at 03:18:14PM +0200, Krzysztof Kozlowski wrote:
>>>>>> On 27 July 2018 at 15:11, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On today's next, the bisect pointed commit
>>>>>>> ff33d1030a6ca87cea9a41e1a2ea7750a781ab3d as fault for my boot failures
>>>>>>> with NFSv4 root on Toradex Colibri VF50 (Iris carrier board).
>>>>>>>
>>>>>>> Author: Robin Murphy <robin.murphy@arm.com>
>>>>>>> Date:   Mon Jul 23 23:16:12 2018 +0100
>>>>>>>       OF: Don't set default coherent DMA mask
>>>>>>>
>>>>>>> Board: Toradex Colibri VF50 (NXP VF500, Cortex A5, serial configured
>>>>>>> with DMA) on Iris Carrier.
>>>>>>>
>>>>>>> It looks like problem with Freescale Ethernet driver:
>>>>>>> [   15.458477] fsl-edma 40018000.dma-controller: coherent DMA mask is unset
>>>>>>> [   15.465284] fsl-lpuart 40027000.serial: Cannot prepare cyclic DMA
>>>>>>> [   15.472086] Root-NFS: no NFS server address
>>>>>>> [   15.476359] VFS: Unable to mount root fs via NFS, trying floppy.
>>>>>>> [   15.484228] VFS: Cannot open root device "nfs" or
>>>>>>> unknown-block(2,0): error -6
>>>>>>> [   15.491664] Please append a correct "root=" boot option; here are
>>>>>>> the available partitions:
>>>>>>> [   15.500188] 0100           16384 ram0
>>>>>>> [   15.500200]  (driver?)
>>>>>>> [   15.506406] Kernel panic - not syncing: VFS: Unable to mount root
>>>>>>> fs on unknown-block(2,0)
>>>>>>> [   15.514747] ---[ end Kernel panic - not syncing: VFS: Unable to
>>>>>>> mount root fs on unknown-block(2,0) ]---
>>>>>>>
>>>>>>> Attached - defconfig and full boot log.
>>>>>>>
>>>>>>> Any hints?
>>>>>>> Let me know if you need any more information.
>>>>>>
>>>>>> My Exynos boards also fail to boot on missing network:
>>>>>> https://krzk.eu/#/builders/21/builds/799/steps/10/logs/serial0
>>>>>>
>>>>>> As expected there are plenty of "DMA mask not set" warnings... and
>>>>>> later dwc3 driver fails with:
>>>>>>       dwc3: probe of 12400000.dwc3 failed with error -12
>>>>>> which is probably the answer why LAN attached to USB is not present.
>>>>>
>>>>> Looks like all the drivers failed to set a dma mask and were lucky.
>>>>
>>>> I would call it a serious regression. Also, no longer setting a default
>>>> coherent DMA mask is a quite substantial behavioral change, especially
>>>> if and since the code worked just fine up to now.
>>>
>>> To reiterate, that particular side-effect was an unintentional
>>> oversight, and I was simply (un)lucky enough that none of the drivers
>>> I did test depended on that default mask. Sorry for the blip; please
>>> check whether it's now fixed in next-20180730 as it should be.
>>>
>>
>> Just for my understanding:
>>
>> Your first patch ("OF: Don't set default coherent DMA mask") sounded
>> like that *not* setting default coherent DMA mask was intentionally.
>> Since the commit message reads: "...the bus code has not initialised any
>> default value" that was assuming that all bus code sets a default DMA
>> mask which wasn't the case for "simple-bus".
> 
> Yes, reading the patches in the order they were written is perhaps a little unclear, but hopefully the order in which they are now applied makes more sense.
> 
>> So I guess that is what ("of/platform: Initialise default DMA masks")
>> makes up for in the typical device tree case ("simple-bus")?
> 
> Indeed, I'd missed the fact that the now-out-of-place-looking initialisation in of_dma_configure() still actually belonged to of_platform_device_create_pdata() - that patch should make the assumptions of "OF: Don't set default coherent DMA mask" true again, even for OF-platform devices.
> 
>> Now, since almost all drivers are inside a soc "simple-bus" and DMA mask
>> is set again, can/should we rely on the coherent DMA mask set?
>>
>> Or is the expectation still that this is set on driver level too?
> 
> Ideally, we'd like all drivers to explicitly request their masks as the documentation in DMA-API-HOWTO.txt recommends, if only to ensure DMA is actually possible - there can be systems where even the default 32-bit mask is no good - but clearly we're a little way off trying to enforce that just yet.
> 
> Robin.
> 

Please note that sparc images still generate the warning (next-20180731).

sunlance ffd35110: DMA mask not set
sunlance.c:v2.02 8/24/03 Miguel de Icaza (miguel@nuclecu.unam.mx)
ioremap: done with statics, switching to malloc
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 sparc_lance_probe_one+0x428/0x4f4

esp ffd38e90: DMA mask not set
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 esp_sbus_probe+0x408/0x6e8

Guenter

