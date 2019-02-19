Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3610C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CD72147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oxuoAtkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfBSNF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:05:28 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42004 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfBSNF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:05:27 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1JD5Len049102;
        Tue, 19 Feb 2019 07:05:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550581521;
        bh=W3MXUIRYjrydCmiVUPaDNzLD7XNjkR6k7ZeLLEJmmQk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=oxuoAtkXDuJLp+Tbo5Y9e+4nrAeIZgGUpq9gSqJ2gIP1qrO6Gjk2iC4ptRV789JmH
         RdBgAsAOP/oZTX+2DpWBp6avX6isieeuKOq/kwPGX+3dbm4rkouFnpNTizJzMOX9jJ
         sKpx3bC/3MXIAFEDcmWBrJFSYJDWIV0gHsZbryw4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1JD5L9p121717
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Feb 2019 07:05:21 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 19
 Feb 2019 07:05:21 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 19 Feb 2019 07:05:20 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1JD5HRu002253;
        Tue, 19 Feb 2019 07:05:18 -0600
Subject: Re: Linux-next 20190218: am57xx-evm: mmc1: ADMA error
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
CC:     <t-kristo@ti.com>, <nm@ti.com>,
        Mark Rutland <mark.rutland@arm.com>, <robh+dt@kernel.org>
References: <CA+G9fYsmC5ckLXfQxSUn-tqxLZ4NofEyb9RA69Q07RUoxc79RQ@mail.gmail.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <34c78d7f-cc3c-853d-b3fd-a70abdb66293@ti.com>
Date:   Tue, 19 Feb 2019 18:38:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CA+G9fYsmC5ckLXfQxSUn-tqxLZ4NofEyb9RA69Q07RUoxc79RQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

On 18/02/19 6:57 PM, Naresh Kamboju wrote:
> Do you see this error on am57xx-evm running Linux next 20190218 ?
> I have tested on multiple devices and found this error.
> Please find the full boot log [1].
> Am i missing any pre required configs [2] ?
> 
> [    5.620263] mmc1: ADMA error
> [    5.623266] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> [    5.629740] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00003302
> [    5.636215] mmc1: sdhci: Blk size:  0x00000200 | Blk cnt:  0x0000ffff
> [    5.642690] mmc1: sdhci: Argument:  0x002cec70 | Trn mode: 0x00000033
> [    5.649162] mmc1: sdhci: Present:   0x01f00000 | Host ctl: 0x00000010
> [    5.655634] mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> [    5.662108] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
> [    5.668582] mmc1: sdhci: Timeout:   0x0000000c | Int stat: 0x00000000
> [    5.675055] mmc1: sdhci: Int enab:  0x027f000b | Sig enab: 0x027f000b
> [    5.681529] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> [    5.688002] mmc1: sdhci: Caps:      0x21e90080 | Caps_1:   0x00000f77
> [    5.694474] mmc1: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
> [    5.700949] mmc1: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffef
> [    5.707423] mmc1: sdhci: Resp[2]:   0x0f5903ff | Resp[3]:  0xd04f0132
> [    5.713896] mmc1: sdhci: Host ctl2: 0x00000004
> [    5.718364] mmc1: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0xab868218
> 

I see this as well on my setup. Trying to bisect now. Will keep you posted.

Thanks,
Faiz

> <>
> [   42.425587] print_req_error: I/O error, dev mmcblk1, sector 4542872 flags 1
> [   42.429013] mmc1: ADMA error
> [   42.432606] EXT4-fs warning (device mmcblk1p9): ext4_end_bio:324:
> I/O error 10 writing to inode 35321 (offset 0 size 4096 starting block
> 567860)
> [   42.435475] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> [   42.448543] Buffer I/O error on device mmcblk1p9, logical block 226675
> [   42.454944] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00003302
> [   42.461528] EXT4-fs warning (device mmcblk1p9): ext4_end_bio:324:
> I/O error 10 writing to inode 35322 (offset 0 size 4096 starting block
> 567861)
> [   42.467960] mmc1: sdhci: Blk size:  0x00000200 | Blk cnt:  0x0000ffff
> [   42.480982] Buffer I/O error on device mmcblk1p9, logical block 226676
> [   42.487427] mmc1: sdhci: Argument:  0x002cae20 | Trn mode: 0x00000033
> [   42.494007] EXT4-fs warning (device mmcblk1p9): ext4_end_bio:324:
> I/O error 10 writing to inode 315 (offset 0 size 4096 starting block
> 567862)
> 
> Full boot log,
> [1] https://lkft.validation.linaro.org/scheduler/job/610989#L4354
> config,
> [2] http://snapshots.linaro.org/openembedded/lkft/lkft/rocko/am57xx-evm/lkft/linux-next/467/config
> 
> Best regards
> Naresh Kamboju
> 
