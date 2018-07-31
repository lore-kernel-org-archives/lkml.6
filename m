Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BD0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25034208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhKam+I5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25034208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbeGaC1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:27:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40086 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeGaC1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:27:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id x5-v6so8149639pgp.7;
        Mon, 30 Jul 2018 17:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YtnPS/cLdCfa+BjzVskKAmoIMT5WXazDRjaX0PyWJeI=;
        b=XhKam+I5HhAGmNzGwe/LD0T6z2ktXxXs2ErGcrO6iLNNhEi3B0mHrzjrXj9skPlXvm
         v4UNkYC+PE0B5YtyfT+1mmyP1Ub/NC0aVn5pia+ov3ttsTB2mRO1bABZRShNg1DK861I
         sHw7WJmuewJJWDDbqZZawXz2GQH/EvExKoLjQnS1YTz3MW5wp4UuQ+76fpqTNY0ZisHk
         jlXVvneBomtGh7DC9vtA/frRHbokJ3OwXVJWCkodkK2eqAykb8HuBt4zjJAnGckHdzeZ
         kzXorWDUp1T/F40Vg7+LhbiLc/Z+ip0Uxn9RTjVmdeLJAEd8z5cZkn9bQcR2vpZrzoGE
         oRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YtnPS/cLdCfa+BjzVskKAmoIMT5WXazDRjaX0PyWJeI=;
        b=SlQwfk4JBhWZMQ4AOn1T7OusOkOOmBIl1iBQ7OURGqWk4E1CyWN80mp+tfGLsBCPg+
         5cuJlxuAeji89Ly9sEc9wWTROHGmEnR+/Ee8a7zi2r/m+BOAFsQXABKYX3apn5BDC0oJ
         EkhMK3nLjjel9UruaCtE+SkHmbbE1q8ObPWef7l0HsFY6+KJQeVtP6q384cNMLXawtX0
         6D/WwLdfARkeeQES2NG8pAZ6922OVC/RxHCn9InNSFkCN16un3F/x7Kw7aQLjn+CbXon
         BE/Of5IGQZ1XGckbpbThlAfo43C/FhtIwRGS1kBYIdqUTIfMo7J1K6xCpO4oPhYsmRYI
         qdVg==
X-Gm-Message-State: AOUpUlEj5gQR01+FMsbrEQSc9LHX/lxa7Jd3sJpPaMI+Oy1bPXzfk7rc
        RFQxx2y5j5HodqorgQseezM=
X-Google-Smtp-Source: AAOMgpdgZ0rHVhlzwn/P2T7H0lclsNk3EUZmNZTdoV4VHoLjK3cgDLCMnGptgLyO4CnCpnFDKVO+GQ==
X-Received: by 2002:a62:1157:: with SMTP id z84-v6mr20139445pfi.66.1532998216878;
        Mon, 30 Jul 2018 17:50:16 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z8-v6sm17113013pfe.163.2018.07.30.17.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 17:50:15 -0700 (PDT)
Subject: Re: [BUG BISECT] Ethernet fail on VF50 (OF: Don't set default
 coherent DMA mask)
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>,
        Fugang Duan <fugang.duan@nxp.com>
References: <CAJKOXPeaguNxRr7pCArJ5Db4tS6Kr5BDheCxskY+vd0dUN+0GQ@mail.gmail.com>
 <CAJKOXPfageiBVXddtdJRBS+092O3QfD0yoS_Mk+PoX7+qNYNUA@mail.gmail.com>
 <20180727140448.GA29001@lst.de> <20180728165820.GA5731@roeck-us.net>
 <45f7fc82-fb9c-e666-4ada-c5338d2c1c96@arm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <77ea6e7f-2343-be9b-bf87-2d757bdc20d7@roeck-us.net>
Date:   Mon, 30 Jul 2018 17:50:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <45f7fc82-fb9c-e666-4ada-c5338d2c1c96@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2018 07:38 AM, Robin Murphy wrote:
> On 28/07/18 17:58, Guenter Roeck wrote:
>> On Fri, Jul 27, 2018 at 04:04:48PM +0200, Christoph Hellwig wrote:
>>> On Fri, Jul 27, 2018 at 03:18:14PM +0200, Krzysztof Kozlowski wrote:
>>>> On 27 July 2018 at 15:11, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>> Hi,
>>>>>
>>>>> On today's next, the bisect pointed commit
>>>>> ff33d1030a6ca87cea9a41e1a2ea7750a781ab3d as fault for my boot failures
>>>>> with NFSv4 root on Toradex Colibri VF50 (Iris carrier board).
>>>>>
>>>>> Author: Robin Murphy <robin.murphy@arm.com>
>>>>> Date:   Mon Jul 23 23:16:12 2018 +0100
>>>>>      OF: Don't set default coherent DMA mask
>>>>>
>>>>> Board: Toradex Colibri VF50 (NXP VF500, Cortex A5, serial configured
>>>>> with DMA) on Iris Carrier.
>>>>>
>>>>> It looks like problem with Freescale Ethernet driver:
>>>>> [   15.458477] fsl-edma 40018000.dma-controller: coherent DMA mask is unset
>>>>> [   15.465284] fsl-lpuart 40027000.serial: Cannot prepare cyclic DMA
>>>>> [   15.472086] Root-NFS: no NFS server address
>>>>> [   15.476359] VFS: Unable to mount root fs via NFS, trying floppy.
>>>>> [   15.484228] VFS: Cannot open root device "nfs" or
>>>>> unknown-block(2,0): error -6
>>>>> [   15.491664] Please append a correct "root=" boot option; here are
>>>>> the available partitions:
>>>>> [   15.500188] 0100           16384 ram0
>>>>> [   15.500200]  (driver?)
>>>>> [   15.506406] Kernel panic - not syncing: VFS: Unable to mount root
>>>>> fs on unknown-block(2,0)
>>>>> [   15.514747] ---[ end Kernel panic - not syncing: VFS: Unable to
>>>>> mount root fs on unknown-block(2,0) ]---
>>>>>
>>>>> Attached - defconfig and full boot log.
>>>>>
>>>>> Any hints?
>>>>> Let me know if you need any more information.
>>>>
>>>> My Exynos boards also fail to boot on missing network:
>>>> https://krzk.eu/#/builders/21/builds/799/steps/10/logs/serial0
>>>>
>>>> As expected there are plenty of "DMA mask not set" warnings... and
>>>> later dwc3 driver fails with:
>>>>      dwc3: probe of 12400000.dwc3 failed with error -12
>>>> which is probably the answer why LAN attached to USB is not present.
>>>
>>> Looks like all the drivers failed to set a dma mask and were lucky.
>>
>> I would call it a serious regression. Also, no longer setting a default
>> coherent DMA mask is a quite substantial behavioral change, especially
>> if and since the code worked just fine up to now.
> 
> To reiterate, that particular side-effect was an unintentional oversight, and I was simply (un)lucky enough that none of the drivers I did test depended on that default mask. Sorry for the blip; please check whether it's now fixed in next-20180730 as it should be.
> 

Yes, I don't see the warnings and crashes anymore.

>> Crash when booting sam460ex attached below, as is a bisect log.
> 
> Nevertheless, like most of the others that came out of the woodwork, that appears to be a crash due to a broken cleanup path down the line from dma_alloc_coherent() returning NULL - that warrants fixing (or just removing) in its own right, because cleanup code which has never been tested and doesn't actually work is little more than a pointless waste of space.
> 

I had a  quick look into the code. I agree, the error path in
ppc4xx_msi_probe() is completely messed up. It will crash for all
kinds of errors (and in many cases erroneously return -EPERM
as error, but that doesn't really matter since it crashes anyway).

Guenter

> Robin.
> 
>>
>> Guenter
>>
>> ---
>> irq: type mismatch, failed to map hwirq-0 for interrupt-controller3!
>> WARNING: CPU: 0 PID: 1 at ppc4xx_msi_probe+0x2dc/0x3b8
>> Modules linked in:
>> CPU: 0 PID: 1 Comm: swapper Not tainted 4.18.0-rc6-00010-gff33d1030a6c #1
>> NIP:  c001c460 LR: c001c29c CTR: 00000000
>> REGS: cf82db60 TRAP: 0700   Not tainted  (4.18.0-rc6-00010-gff33d1030a6c)
>> MSR:  00029000 <CE,EE,ME>  CR: 24002028  XER: 00000000
>>
>> GPR00: c001c29c cf82dc10 cf828000 d1021000 d1021000 cf882108 cf82db78 00000000
>> GPR08: 00000000 c0377ae4 00000000 1000051b 24002028 00000000 c00025e8 00000000
>> GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 c0492380 0000004a
>> GPR24: 00029000 0000000c 10000000 cf8de410 c0494d60 00029000 cf8bebc0 cf8de400
>> NIP [c001c460] ppc4xx_msi_probe+0x2dc/0x3b8
>> LR [c001c29c] ppc4xx_msi_probe+0x118/0x3b8
>> Call Trace:
>> [cf82dc10] [c001c29c] ppc4xx_msi_probe+0x118/0x3b8 (unreliable)
>> [cf82dc70] [c0209fbc] platform_drv_probe+0x40/0x9c
>> [cf82dc90] [c0208240] driver_probe_device+0x2a8/0x350
>> [cf82dcc0] [c0206204] bus_for_each_drv+0x60/0xac
>> [cf82dcf0] [c0207e88] __device_attach+0xe8/0x160
>> [cf82dd20] [c02071e0] bus_probe_device+0xa0/0xbc
>> [cf82dd40] [c02050c8] device_add+0x404/0x5c4
>> [cf82dd90] [c0288978] of_platform_device_create_pdata+0x88/0xd8
>> [cf82ddb0] [c0288b70] of_platform_bus_create+0x134/0x220
>> [cf82de10] [c0288bcc] of_platform_bus_create+0x190/0x220
>> [cf82de70] [c0288cf4] of_platform_bus_probe+0x98/0xec
>> [cf82de90] [c0449650] __machine_initcall_canyonlands_ppc460ex_device_probe+0x38/0x54
>> [cf82dea0] [c0002404] do_one_initcall+0x40/0x188
>> [cf82df00] [c043daec] kernel_init_freeable+0x130/0x1d0
>> [cf82df30] [c0002600] kernel_init+0x18/0x104
>> [cf82df40] [c000c23c] ret_from_kernel_thread+0x14/0x1c
>> Instruction dump:
>> 3860000e 4bffa2a5 3860000f 7f44d378 4bffa299 4bfffe30 3860000e 4bffa28d
>> 3860000f 7f24cb78 4bffa281 4bfffde4 <0fe00000> 81290000 2f890000 409efe6c
>> ---[ end trace 8cf551077ecfc429 ]---
>> ppc4xx-msi c10000000.ppc4xx-msi: coherent DMA mask is unset
>> Unable to handle kernel paging request for data at address 0x00000000
>> Faulting instruction address: 0xc001bff0
>> Oops: Kernel access of bad area, sig: 11 [#1]
>> BE Canyonlands
>> Modules linked in:
>> CPU: 0 PID: 1 Comm: swapper Tainted: G        W         4.18.0-rc6-00010-gff33d1030a6c #1
>> NIP:  c001bff0 LR: c001c418 CTR: c01faa7c
>> REGS: cf82db40 TRAP: 0300   Tainted: G        W          (4.18.0-rc6-00010-gff33d1030a6c)
>> MSR:  00029000 <CE,EE,ME>  CR: 28002024  XER: 00000000
>> DEAR: 00000000 ESR: 00000000
>> GPR00: c001c418 cf82dbf0 cf828000 cf8de400 00000000 00000000 000000c4 000000c4
>> GPR08: c0481ea4 00000000 00000000 000000c4 22002024 00000000 c00025e8 00000000
>> GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 c0492380 0000004a
>> GPR24: 00029000 0000000c 00000000 cf8de410 c0494d60 c0494d60 cf8bebc0 00000001
>> NIP [c001bff0] ppc4xx_of_msi_remove+0x48/0xa0
>> LR [c001c418] ppc4xx_msi_probe+0x294/0x3b8
>> Call Trace:
>> [cf82dbf0] [00029000] 0x29000 (unreliable)
>> [cf82dc10] [c001c418] ppc4xx_msi_probe+0x294/0x3b8
>> [cf82dc70] [c0209fbc] platform_drv_probe+0x40/0x9c
>> [cf82dc90] [c0208240] driver_probe_device+0x2a8/0x350
>> [cf82dcc0] [c0206204] bus_for_each_drv+0x60/0xac
>> [cf82dcf0] [c0207e88] __device_attach+0xe8/0x160
>> [cf82dd20] [c02071e0] bus_probe_device+0xa0/0xbc
>> [cf82dd40] [c02050c8] device_add+0x404/0x5c4
>> [cf82dd90] [c0288978] of_platform_device_create_pdata+0x88/0xd8
>> [cf82ddb0] [c0288b70] of_platform_bus_create+0x134/0x220
>> [cf82de10] [c0288bcc] of_platform_bus_create+0x190/0x220
>> [cf82de70] [c0288cf4] of_platform_bus_probe+0x98/0xec
>> [cf82de90] [c0449650] __machine_initcall_canyonlands_ppc460ex_device_probe+0x38/0x54
>> [cf82dea0] [c0002404] do_one_initcall+0x40/0x188
>> [cf82df00] [c043daec] kernel_init_freeable+0x130/0x1d0
>> [cf82df30] [c0002600] kernel_init+0x18/0x104
>> [cf82df40] [c000c23c] ret_from_kernel_thread+0x14/0x1c
>> Instruction dump:
>> 90010024 813d0024 2f890000 83c30058 41bd0014 48000038 813d0024 7f89f800
>> 409d002c 813e000c 57ea103a 3bff0001 <7c69502e> 2f830000 419effe0 4803b26d
>> ---[ end trace 8cf551077ecfc42a ]---
>>
>> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>>
>> ---
>> # bad: [639d109b21f1413c54ca7042e40a57856e7679bb] Add linux-next specific files for 20180727
>> # good: [d72e90f33aa4709ebecc5005562f52335e106a60] Linux 4.18-rc6
>> git bisect start 'HEAD' 'v4.18-rc6'
>> # bad: [7bc81125a936a25af28f2172b593bca390b0c539] Merge remote-tracking branch 'spi-nor/spi-nor/next'
>> git bisect bad 7bc81125a936a25af28f2172b593bca390b0c539
>> # bad: [659868e6488dbad1181ad21888521ff41ae45f65] Merge remote-tracking branch 'vfs/for-next'
>> git bisect bad 659868e6488dbad1181ad21888521ff41ae45f65
>> # bad: [453ff4bb24c3fa4af40995f2615ec22176e71500] Merge remote-tracking branch 'mvebu/for-next'
>> git bisect bad 453ff4bb24c3fa4af40995f2615ec22176e71500
>> # good: [ebc949ee3c7e28b6554f00fcdaf2c0c8aae54d90] Merge branch 'next/soc' into for-next
>> git bisect good ebc949ee3c7e28b6554f00fcdaf2c0c8aae54d90
>> # good: [fef31ecbe2ecbb518ad1db37282eb97ca6dd29b8] Merge remote-tracking branch 'leaks/leaks-next'
>> git bisect good fef31ecbe2ecbb518ad1db37282eb97ca6dd29b8
>> # good: [53b9c41f0d9c35e41ea884bae6ad4b6fadc59035] Merge branch 'next/drivers' into for-next
>> git bisect good 53b9c41f0d9c35e41ea884bae6ad4b6fadc59035
>> # bad: [cd67b2d4c0ca61f7e93e622dba0164fb176975b4] Merge remote-tracking branch 'arm-soc/for-next'
>> git bisect bad cd67b2d4c0ca61f7e93e622dba0164fb176975b4
>> # good: [a0c166140d2e63a069263b6d3c39a42c61749d96] Merge branch 'next/drivers' into for-next
>> git bisect good a0c166140d2e63a069263b6d3c39a42c61749d96
>> # bad: [e5e08751da47170e6a05c09364595ec1abad7cec] Merge remote-tracking branch 'arm/for-next'
>> git bisect bad e5e08751da47170e6a05c09364595ec1abad7cec
>> # good: [52e19c3c1eaf103c2eb4f764825136abcfea1538] Merge branches 'clkdev', 'fixes', 'misc' and 'spectre' into for-next
>> git bisect good 52e19c3c1eaf103c2eb4f764825136abcfea1538
>> # good: [e8d4162413ecbf3b3d1451808bdbd212cec8b70c] ACPI/IORT: Set bus DMA mask as appropriate
>> git bisect good e8d4162413ecbf3b3d1451808bdbd212cec8b70c
>> # good: [186e2e8cc462aed36cc6845c938547833377582f] ACPI/IORT: Don't set default coherent DMA mask
>> git bisect good 186e2e8cc462aed36cc6845c938547833377582f
>> # bad: [deff076d4ce359c2d83983a75765b4ac8f635d2f] Merge remote-tracking branch 'dma-mapping/for-next'
>> git bisect bad deff076d4ce359c2d83983a75765b4ac8f635d2f
>> # bad: [ff33d1030a6ca87cea9a41e1a2ea7750a781ab3d] OF: Don't set default coherent DMA mask
>> git bisect bad ff33d1030a6ca87cea9a41e1a2ea7750a781ab3d
>> # first bad commit: [ff33d1030a6ca87cea9a41e1a2ea7750a781ab3d] OF: Don't set default coherent DMA mask
>>
> 

