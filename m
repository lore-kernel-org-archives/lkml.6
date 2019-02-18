Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7462BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C0F2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wtKG2B6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbfBRN2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:28:07 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:35789 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729702AbfBRN2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:28:06 -0500
Received: by mail-lj1-f176.google.com with SMTP id j13-v6so14389318ljc.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 05:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=eNNkhDyraVkYNiogF26JwnkgeZKItG9TfHc07XYBGNs=;
        b=wtKG2B6KmIe8EUUgQQPnYp5NHDYjM3NxKV4Ct3SkhZaeW5PD6ii7EtARdtQWmNNSeV
         mIzFBh/HQ7XJOb6XSXjyg2Lcsc1d2/nQES6/2+jDH/j4rGU2qBaRO00R7YQ7PepOsJEo
         N7Sg5IXH9J5mFy/IYACUF/bviUnJ1n7SvhabgQq0ZxeQb9eHiuApiQXL+3A0LwBjrRTb
         vMf7FJgCoNg2Lmtfy5o68jREseMFZklUm801VIbiFpqkD2H4PEyGCSwwL4QU5VfAGSzw
         CrqhcrUju+H+Xxdc8q1aZ3ZDhJUQVRvg0Fe9D1iVMz+a29LQ/c7K3isputr3Thp6kfpn
         XEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=eNNkhDyraVkYNiogF26JwnkgeZKItG9TfHc07XYBGNs=;
        b=UIvRHeOZfOQQo5sfSqXEdp/WSSFl4jIobqwXkCH4kXI6eBbmQXo0cJllFjcbywZI4q
         istb5wV+aR6Ud6yw2jHv8tiJobFZize4AE2ziPWtOuJJ5bVAlWgn+riKxCD96sdPe/35
         Hc+epmo7ETTNGl+aHc23WwuHlytKWDFumJjaQYBJVR6rw6uTjzESmNtMPYXIHl5lA6rK
         +AGqHl7i5Sm/80SCRPa2mxWVQHnk+0ZibVBTxLk+bV6W69Lv+GxEfJqsWQ/oqxf+4diC
         XfIMBlwNtt2mM4itsrLspEotpze87zqRhgRbyujJLMdpR0zPCW2cSx/xqr01GzkO2BD4
         mSGg==
X-Gm-Message-State: AHQUAuZpy3I//Ygmncm0GGOxYeSGoqrrwJHiB/22+y1LO6V1Q2SvZJ32
        BgR0ChwICPno3cDylCRDOBKhMpY4LgtoL5ETi2UbjjNAo/I=
X-Google-Smtp-Source: AHgI3IYDuxQ+StazJKZ+QwK0/QOMky3kr6BOYLq4CRgpH1Pr3UbRs3T09pMNppgKx1KahhzSSbOjQT8jkGkBho/bssc=
X-Received: by 2002:a2e:9595:: with SMTP id w21-v6mr13916344ljh.194.1550496483899;
 Mon, 18 Feb 2019 05:28:03 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 18 Feb 2019 18:57:52 +0530
Message-ID: <CA+G9fYsmC5ckLXfQxSUn-tqxLZ4NofEyb9RA69Q07RUoxc79RQ@mail.gmail.com>
Subject: Linux-next 20190218: am57xx-evm: mmc1: ADMA error
To:     open list <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-omap@vger.kernel.org
Cc:     t-kristo@ti.com, nm@ti.com, faiz_abbas@ti.com,
        Mark Rutland <mark.rutland@arm.com>, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do you see this error on am57xx-evm running Linux next 20190218 ?
I have tested on multiple devices and found this error.
Please find the full boot log [1].
Am i missing any pre required configs [2] ?

[    5.620263] mmc1: ADMA error
[    5.623266] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[    5.629740] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00003302
[    5.636215] mmc1: sdhci: Blk size:  0x00000200 | Blk cnt:  0x0000ffff
[    5.642690] mmc1: sdhci: Argument:  0x002cec70 | Trn mode: 0x00000033
[    5.649162] mmc1: sdhci: Present:   0x01f00000 | Host ctl: 0x00000010
[    5.655634] mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
[    5.662108] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
[    5.668582] mmc1: sdhci: Timeout:   0x0000000c | Int stat: 0x00000000
[    5.675055] mmc1: sdhci: Int enab:  0x027f000b | Sig enab: 0x027f000b
[    5.681529] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[    5.688002] mmc1: sdhci: Caps:      0x21e90080 | Caps_1:   0x00000f77
[    5.694474] mmc1: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
[    5.700949] mmc1: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffef
[    5.707423] mmc1: sdhci: Resp[2]:   0x0f5903ff | Resp[3]:  0xd04f0132
[    5.713896] mmc1: sdhci: Host ctl2: 0x00000004
[    5.718364] mmc1: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0xab868218

<>
[   42.425587] print_req_error: I/O error, dev mmcblk1, sector 4542872 flags 1
[   42.429013] mmc1: ADMA error
[   42.432606] EXT4-fs warning (device mmcblk1p9): ext4_end_bio:324:
I/O error 10 writing to inode 35321 (offset 0 size 4096 starting block
567860)
[   42.435475] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[   42.448543] Buffer I/O error on device mmcblk1p9, logical block 226675
[   42.454944] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00003302
[   42.461528] EXT4-fs warning (device mmcblk1p9): ext4_end_bio:324:
I/O error 10 writing to inode 35322 (offset 0 size 4096 starting block
567861)
[   42.467960] mmc1: sdhci: Blk size:  0x00000200 | Blk cnt:  0x0000ffff
[   42.480982] Buffer I/O error on device mmcblk1p9, logical block 226676
[   42.487427] mmc1: sdhci: Argument:  0x002cae20 | Trn mode: 0x00000033
[   42.494007] EXT4-fs warning (device mmcblk1p9): ext4_end_bio:324:
I/O error 10 writing to inode 315 (offset 0 size 4096 starting block
567862)

Full boot log,
[1] https://lkft.validation.linaro.org/scheduler/job/610989#L4354
config,
[2] http://snapshots.linaro.org/openembedded/lkft/lkft/rocko/am57xx-evm/lkft/linux-next/467/config

Best regards
Naresh Kamboju
