Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2990480-1526218020-2-11062424474648958016
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526218019; b=AThQDKloh4eI+iMs9UDIOy/VKB/DWGCbIXmQ9lc3gPqFK//I0/
    XOTkLD/1atn0ifuKU9YemUZuWcp5Uy/1az4CEoWjvLwpdhQN2P3fdDqGClrJynDB
    FxJPYWXlS8tgWTduyuB3sH27AZVkOT7plJiwTJrx7PqAtmXXiPcvDypvKmq9i0t4
    ZzLGee5ZSmqCdG8gFDUm64SUyu7pSAYWwSmg478/muVTh/D6rvebPAYBm3uea1Ud
    DNTVRNvd0JOPwlSZ0qXOS6P6W9QKQ+LzWURYMDd5PLbYMUTtfpCnLaW1+TPF8EiV
    17Nl2P3UViaP/okqcgU0kKulXKrhQenRbhDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526218019;
    bh=IEp1gIFE8mkuXBS4U8mYCjuw6n5Tp3OdcxV51oNJH8g=; b=HMn9FFPsEl1N
    4esCV7yC/CyLvlRjK179KyO2m0FJje2uvW1YF7Qrg+OcLezX9jiUQfwpVbFkOByG
    /O820aogCzRnxzokfVGUmc2YtA533YLJtP9/1FaeEOtUDxNU/aMWLUAqB9U/1jnX
    M5rvVHUJJdNCDuV1ZnaLQ60QQ4ObVQF1ci7WAz9iRs7Nd1p5mAxphYScGyVFozXz
    O1UwswtV0B7zJ4GNMgXylrbOOoHYmHClu20IoJTlmfvGMStC1SDuUC1GVjmh9d10
    j/W5Ib6r+8YOZPbNbtiSvNTDhe7H41D/2hcCH21yzdJ0tCmoaExgaDPRklNijHRZ
    pW0GSJVIRA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmx.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmx.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKIFdfQnKXTwQMqt5BK1wbSmO17cS/5ALSAbrZDGlUlB14iJ0SfaS/ke/7aaBfQfrauZx8s5x2GZ6SxgG8URZNp9mLKyKz+4RlFtCrgU5iD+53SRT3qa
    MiAXbbkqmRPGBvPj6zZzxG07mi6Gj3g9khsWDNsOpvpP43b2Ardtz67qTmu7CV6kZ1Rdeykro4+YQV7OSmfuz5r2Yv4madaaOP0FjJD2iQ3+jOpPlOaVDAmb
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=udSRKcfUiZYA:10
    a=VUJBJC2UJ8kA:10 a=JfrnYn6hAAAA:8 a=preA1W1IIu_PAkDiUwoA:9
    a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeEMN04 (ORCPT <rfc822;linux@kroah.com>);
        Sun, 13 May 2018 09:26:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:55933 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751345AbeEMN0y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 13 May 2018 09:26:54 -0400
Subject: Re: common non-cache coherent direct dma mapping ops
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180511075945.16548-1-hch@lst.de>
From: Helge Deller <deller@gmx.de>
Message-ID: <1834767f-0430-8f7f-61b1-560353cd6e5f@gmx.de>
Date: Sun, 13 May 2018 15:26:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180511075945.16548-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:20QWLIhFXyRzbujUp8MnwFYNwBnQjTSC3Od6k/1r6d54moMZEd+
 rq9NHZtRAHy7zFaLtMWjj+9dMaLAQh2wGIs9ROkUw1hV1CraD4thVXHYRBCM3fjX5glb4gm
 /PLoW5QkQxS1adc1l2gjiNj6qmSW0R0TqcAMAifI8YuWkWx9UvNiLOs+ZL4zT3pnio7NhFw
 AdJ/nh6pshCLan8Yw8hMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JFNPQCVINME=:Hwo7z3keqp6255cKnXUNz4
 whYHnbcUogtlkgbYHbUeuFSqYeUR1C9EL+zfMv3QM7C7t5XIDsdkdeknflP8K1nYxQm4C4V9w
 YRDT+pihsoF/5sQ8zgINAU+BKPl1EQDKl9JMWqFcVAuvPgnp01qz5lhhUJ2bXQcwt7MLFySd7
 n1dSpyoEZBjvHdbaojzh6GmK7SgrJqryciX4zwuJ5RHhFPZ/S1BpNxR13kXqyWiVIfVzoSnYd
 lzdT2RqLpP9UslQB2fw4gu9oVgektX5hWcwBzXCS7fnK0Z2TNYfHsZjKLzJZGShyJV012Qcjj
 4/X7NSFwUvuJorWCvCmgiPpWY+Y+Zy4B6f9QTiBWs4weNs2u1O0qluVNGpPJbVBM+ErXI9GbO
 qslFE5SHDVpTHsEqJhs/QntNuiPyEKgJ+snzWSpmdiZs/aK6+Eib1YDjTZInzehH06Z9ONPNw
 xwq9/ErHw00O1opb+qNW8wFjfWKrUTNI3HZTPfTyYTyFyq19r+ljFM4qla1ID0TWpWDE/fPzx
 WtOUEpjjBHfx/UIMPB8C7XF23k7bEmNaVo2iw3oJsMXrTLnv9vQFm1P4Znbs4/WStbt/c7Qf2
 +gv/NvQEpr8H5woEdj3HcUT3fNpwJskDiIBbWMGwKhPmZ/p8b8A4HTRYEzKV/A3H0yVL+kTDx
 yO0Vf32fQgj7nhO58Z+rPnN8P3CtJe/U9casZMaFZmk7E1aMmGSQ/aX/FOOIho6FDBGF8X/td
 SmjDL18V8Xa19++vF18XoJgujWVo6bWRK0NKM8dgFEtROUl7FZP3EFuHLcI16Wi+3DOi4afCz
 ZKnoC/x
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 11.05.2018 09:59, Christoph Hellwig wrote:
> this series continues consolidating the dma-mapping code, with a focus
> on architectures that do not (always) provide cache coherence for DMA.
> Three architectures (arm, mips and powerpc) are still left to be
> converted later due to complexity of their dma ops selection.
> 
> The dma-noncoherent ops calls the dma-direct ops for the actual
> translation of streaming mappins and allow the architecture to provide
> any cache flushing required for cpu to device and/or device to cpu
> ownership transfers.  The dma coherent allocator is for now still left
> entirely to architecture supplied implementations due the amount of
> variations.  Hopefully we can do some consolidation for them later on
> as well.
> 
> A lot of architectures are currently doing very questionable things
> in their dma mapping routines, which are documented in the changelogs
> for each patch.  Please review them very careful and correct me on
> incorrect assumptions.
> 
> Because this series sits on top of two previously submitted series
> a git tree might be useful to actually test it.  It is provided here:
> 
>     git://git.infradead.org/users/hch/misc.git generic-dma-noncoherent
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/generic-dma-noncoherent
> 
> Changes since RFC:
>  - fix a typo accidentally disabling the device to cpu transfer sync
>  - fixed a few compile failures


I tested it again on parisc (this time again on top of git head) and it still breaks
the same way as I reported in my mail on April 21st: the lasi82956 network driver works
unreliable. NIC gets IP, but ping doesn't work.
See drivers/net/ethernet/i825xx/lasi_82596.c, it uses dma*sync() functions.

See comment in James mail from April 21st too:
-> you just made every 32 bit parisc system unnecessarily use non-coherent.

Helge
