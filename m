Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3A1C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A2C2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRYD5k2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A2C2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeJPGVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:21:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33960 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbeJPGVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:21:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id f78-v6so4626407pfe.1;
        Mon, 15 Oct 2018 15:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5VJjn0qxh8BGzPUn1BkdZ8LH2wng3UZRuYsFxbKuJ20=;
        b=cRYD5k2c6dLXs9z+tyPBRUg8es8L9RQhpJ2Rsp2U4urq8rI3ukNN2/ZM6+j1P2O3lM
         2iHTDeNoWQUmgaUsCABZrz9IyLTTa3M7h6X9ZRQAodU7tkQvuCki0xT21gbNImJ7jLG6
         rtpuFu5iiJmnluz9IMYZTdcfZV88M/Wkb7n87vYDHjg4LFfAXuA+KzXQsvkiC0EGpj0M
         d02dMg9WDVRuYoe2AfHWhTMao5/TsI1UxsbDprZpt4fZRDy6N7+uFeG0ZtOj9cvPtbP4
         uwkA/IOKdC0Y4k0hdR9dkGtBl5T6G3Pz0WiKN6eA4zZJ0DmrxOctVvfEdaEE104PnWE2
         cJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5VJjn0qxh8BGzPUn1BkdZ8LH2wng3UZRuYsFxbKuJ20=;
        b=MKRfhA1gDd3EUV95J9tmBOQ6m5ROZC4xh3XwMbUlJJH1nGa8HkcNzc+vRaJxoo+d08
         hUDd4wnToRWUNJv4xDaXTIG70rqHkzBsMC4Hmrw6iz+HFMwlFSdnlGTeCqSMorO9IN4T
         XsEBjn0Dk9aPnnUPm9dehxgZhTLMCeT9EwMkpA//vg6Og/cPc+PptALuoxANOyBM8lHa
         9fp+I1mCW4q6gusqqX6Fyi+j66vrs9hGnx5cX0U9aFRb5bIM5zrDp4RS1ahWHvLl0XLT
         JG6trmhV7gGM93EprTVIP+CTsNkSAJXq8w6zugjbqpRT1x7cRTMiWyo5S+u3q4pzxM/1
         O09Q==
X-Gm-Message-State: ABuFfoj1pwIv3ouyx8R8ZZmSM2JtqkzhMOhJZT42QYVvwXZrFkbuWhxq
        RekihLNGrbIwj2m6FitpkV4=
X-Google-Smtp-Source: ACcGV63cMBgvKYN7sxzc1vGh22K9xrH+kbs35MlzlFVUFKbNt4Ouu/j2jifAIxh5pCee05rslR1A6A==
X-Received: by 2002:a62:1e42:: with SMTP id e63-v6mr11386760pfe.149.1539642866206;
        Mon, 15 Oct 2018 15:34:26 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id p4-v6sm15016491pfg.188.2018.10.15.15.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 15:34:25 -0700 (PDT)
Date:   Mon, 15 Oct 2018 15:34:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: Tree for Oct 15
Message-ID: <20181015223424.GA31977@roeck-us.net>
References: <20181015192546.15faf3a1@canb.auug.org.au>
 <20181015182637.GA16445@roeck-us.net>
 <20181016071240.3f62816d@canb.auug.org.au>
 <CAL_Jsq+DAEEa6i9xb-9MMSxu-znc9tZLZwFRADqE+kcxQYXrTg@mail.gmail.com>
 <20181015211815.GA24993@roeck-us.net>
 <CAL_JsqKXS0rmmwHgLRDy+6k=GYRt-nFJHJD1A+CkFCDEAEAKvg@mail.gmail.com>
 <20181015221053.GA19822@roeck-us.net>
 <CAL_JsqLSBE9FFB7=o5bDJ1hxfNP6mAPJ-qXyEVHfY+xwfgDuWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLSBE9FFB7=o5bDJ1hxfNP6mAPJ-qXyEVHfY+xwfgDuWw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 05:13:08PM -0500, Rob Herring wrote:
> On Mon, Oct 15, 2018 at 5:10 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Mon, Oct 15, 2018 at 04:48:27PM -0500, Rob Herring wrote:
> > > On Mon, Oct 15, 2018 at 4:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > >
> > > > On Mon, Oct 15, 2018 at 03:35:12PM -0500, Rob Herring wrote:
> > > > > On Mon, Oct 15, 2018 at 3:12 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > > > >
> > > > > > Hi Guenter,
> > > > > >
> > > > > > [Just cc'ing the PPC and devicetree folks]
> > > > > >
> > > > > > On Mon, 15 Oct 2018 11:26:37 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > > >
> > > > > > > On Mon, Oct 15, 2018 at 07:25:46PM +1100, Stephen Rothwell wrote:
> > > > > > > >
> > > > > > > > My qemu boots of a powerpc pseries_le_defconfig kernel failed today.
> > > > > > >
> > > > > > > Same here. Interestingly, this only affects little endian pseries
> > > > > > > boots; big endian works fine. I'll try to bisect later.
> > > > > > >
> > > > > > > ALl ppc qemu tests (including big endian pseries) also generate a warning.
> > > > > > >
> > > > > > > WARNING: CPU: 0 PID: 0 at mm/memblock.c:1301 .memblock_alloc_range_nid+0x20/0x68
> > > > > > > Modules linked in:
> > > > > > > CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc7-next-20181015 #1
> > > > > > > NIP:  c000000000f99198 LR: c000000000f99490 CTR: c000000000bb8364
> > > > > > > REGS: c000000001217a78 TRAP: 0700   Not tainted  (4.19.0-rc7-next-20181015)
> > > > > > > MSR:  0000000080021000 <CE,ME>  CR: 24000422  XER: 20000000
> > > > > > > IRQMASK: 1
> > > > > > > GPR00: c000000000f99490 c000000001217d00 c00000000121a500 00000000000000c0
> > > > > > > GPR04: 0000000000000000 0000000000000000 0000000000000000 ffffffffffffffff
> > > > > > > GPR08: 0000000000000000 00000000000000c0 0000000000000018 00000000000000b7
> > > > > > > GPR12: 0000000000000040 c000000000fe7840 0000000000000000 0000000000000000
> > > > > > > GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > > > > > GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > > > > > GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > > > > > GPR28: c000000000000304 c000000001262088 00000000000000c0 c000000000fea500
> > > > > > > NIP [c000000000f99198] .memblock_alloc_range_nid+0x20/0x68
> > > > > > > LR [c000000000f99490] .memblock_alloc_base+0x18/0x48
> > > > > > > Call Trace:
> > > > > > > [c000000001217d00] [c000000002a00000] 0xc000000002a00000 (unreliable)
> > > > > > > [c000000001217d80] [c000000000f99490] .memblock_alloc_base+0x18/0x48
> > > > > > > [c000000001217df0] [c000000000f7a274] .allocate_paca_ptrs+0x3c/0x74
> > > > > > > [c000000001217e70] [c000000000f78bf0] .early_init_devtree+0x288/0x320
> > > > > > > [c000000001217f10] [c000000000f79b6c] .early_setup+0x80/0x130
> > > > > > > [c000000001217f90] [c000000000000528] start_here_multiplatform+0x68/0x80
> > > > > > >
> > > > > > >
> > > > > > > sparc images crash, starting with next-20181009. Bisect with
> > > > > > > next-201810112 points to the merge of devicetree/for-next, though
> > > > > > > devicetree/for-next itself does not have the problem (bisect log
> > > > > > > attached below). The crash is in devicetree code.
> > > > > > >
> > > > > > > Crash logs:
> > > > > > > https://kerneltests.org/builders/qemu-sparc64-next/builds/981/steps/qemubuildcommand_1/logs/stdio
> > > > > > > https://kerneltests.org/builders/qemu-sparc-next/builds/975/steps/qemubuildcommand_1/logs/stdio
> > > > >
> > > > > The sparc crash appears to be related to changes I made. Looking into it.
> > > > >
> > > >
> > > > Let me know if you need me to test anything or do some debugging.
> > >
> > > Well, I'm not having any luck getting sparc qemu to work. Here's what
> > > I'm trying with a sparc32_defconfig kernel:
> > >
> > > $ qemu-system-sparc -kernel .build-sparc/vmlinux -M SS-4 -nographic -m
> > > 256 -no-reboot
> > > rom: requested regions overlap (rom phdr #0: .build-sparc/vmlinux.
> > > free=0x000000000000057a, addr=0x0000000000000000)
> > > qemu-system-sparc: rom check and register reset failed
> > >
> >
> > What is your qemu version ?
> 
> 2.11 from ubuntu 18.04:
> QEMU emulator version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.5)
> 

Update: Works for me with
	QEMU emulator version 2.11.93 (Debian 1:2.12~rc3+dfsg-1)
with the following command line.

qemu-system-sparc -M SS-4 -kernel arch/sparc/boot/zImage -no-reboot \
	-drive file=hda.sqf,if=scsi,format=raw \
	-append 'root=/dev/sda rw init=/sbin/init.sh panic=1 console=ttyS0' \
	-nographic -monitor none

I have to enable DEVTMPFS and SQUASHFS for my root file system to work,
but otherwise it is sparc32_defconfig.

Guenter
