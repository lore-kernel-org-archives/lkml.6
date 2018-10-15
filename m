Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE9FC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A0A2089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pB5BpjeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A0A2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeJPFFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:05:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43143 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeJPFFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 01:05:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id 80-v6so9741467pgh.10;
        Mon, 15 Oct 2018 14:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kbc8JIv+FSIw5JCLpyXMjG/tc9ww3kmUsrXEr1t4rvs=;
        b=pB5BpjeKxIhn4K5kKxd25FL24ixy9LDGPNyNvGfvWu5d5dbLzIfJiClUM0IWFrutTG
         AbaShAB8jHe8F6XieDS4luxsICaAsYgU57uXAlSBVpQKiGAFiGUPRE2SyGyRW4uUJHRD
         iBqxrzcVrur5b0S4UeP+Xq8Ex3jnmWrT68dSy/fbO1FlpBFgPtM+DEKNxkNJGBRQUnvg
         TaokKH732aCOT5VncKfEaS4ztkibRTGBSUTJJUHkE5R8XJ+rJKj1/92D5XYTqzLGdT1U
         lVaiMyXQ1oQrbjgCqX1PdOQ9rxDJuOgdfXntwgthEqiUFg+0+9qJapKptpfgVATMYH+0
         cGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kbc8JIv+FSIw5JCLpyXMjG/tc9ww3kmUsrXEr1t4rvs=;
        b=FmamOI/mY7J3xe/pUQZLfzFyrmccVGdBq6BMwBGqtju+Q6QY1qWBE9np8YGwod1c8P
         YGqyWPimrm7RkXVcwOsx0z53g9vF8ugIlQTN5peG/tdJdt9KynWwfdswDu5zezKsSIHK
         og/55jb5YVBpMQmxfC/Gy+APIrcvCXtfDcmGm99D4/A0T5zkNs0214w0KkefZ/vTAlzi
         y4mbXVVzQI8fEh4mV+wZ5lqGUE/7EQx8kCtCk3o11bgy73XdUi99DAAJo/i2mhoVPlK/
         3YZwxCjr1XJfOmVLeYL946h9u9Rz1mV5pGVD8H3D1cEBXW7jJf8GgmTwH7VxY8hfc45v
         Uv0A==
X-Gm-Message-State: ABuFfogTJYDJtXbdyCuTbqr1Kux3X/qP4it5+wluyYeVBPVMSyVCnnWW
        xZXbk/bYD33MAJ9n62osSn8=
X-Google-Smtp-Source: ACcGV61BlExDMm6NRl5LVDdpV2IutuuxjJzrCKZwZ1UGfoVs80vCrKVXefOcHD3NE5ThKVVba4GMMQ==
X-Received: by 2002:a63:eb42:: with SMTP id b2-v6mr17260503pgk.348.1539638298528;
        Mon, 15 Oct 2018 14:18:18 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id m18-v6sm15529111pfk.149.2018.10.15.14.18.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 14:18:17 -0700 (PDT)
Date:   Mon, 15 Oct 2018 14:18:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: Tree for Oct 15
Message-ID: <20181015211815.GA24993@roeck-us.net>
References: <20181015192546.15faf3a1@canb.auug.org.au>
 <20181015182637.GA16445@roeck-us.net>
 <20181016071240.3f62816d@canb.auug.org.au>
 <CAL_Jsq+DAEEa6i9xb-9MMSxu-znc9tZLZwFRADqE+kcxQYXrTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+DAEEa6i9xb-9MMSxu-znc9tZLZwFRADqE+kcxQYXrTg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 03:35:12PM -0500, Rob Herring wrote:
> On Mon, Oct 15, 2018 at 3:12 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi Guenter,
> >
> > [Just cc'ing the PPC and devicetree folks]
> >
> > On Mon, 15 Oct 2018 11:26:37 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On Mon, Oct 15, 2018 at 07:25:46PM +1100, Stephen Rothwell wrote:
> > > >
> > > > My qemu boots of a powerpc pseries_le_defconfig kernel failed today.
> > >
> > > Same here. Interestingly, this only affects little endian pseries
> > > boots; big endian works fine. I'll try to bisect later.
> > >
> > > ALl ppc qemu tests (including big endian pseries) also generate a warning.
> > >
> > > WARNING: CPU: 0 PID: 0 at mm/memblock.c:1301 .memblock_alloc_range_nid+0x20/0x68
> > > Modules linked in:
> > > CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc7-next-20181015 #1
> > > NIP:  c000000000f99198 LR: c000000000f99490 CTR: c000000000bb8364
> > > REGS: c000000001217a78 TRAP: 0700   Not tainted  (4.19.0-rc7-next-20181015)
> > > MSR:  0000000080021000 <CE,ME>  CR: 24000422  XER: 20000000
> > > IRQMASK: 1
> > > GPR00: c000000000f99490 c000000001217d00 c00000000121a500 00000000000000c0
> > > GPR04: 0000000000000000 0000000000000000 0000000000000000 ffffffffffffffff
> > > GPR08: 0000000000000000 00000000000000c0 0000000000000018 00000000000000b7
> > > GPR12: 0000000000000040 c000000000fe7840 0000000000000000 0000000000000000
> > > GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > GPR28: c000000000000304 c000000001262088 00000000000000c0 c000000000fea500
> > > NIP [c000000000f99198] .memblock_alloc_range_nid+0x20/0x68
> > > LR [c000000000f99490] .memblock_alloc_base+0x18/0x48
> > > Call Trace:
> > > [c000000001217d00] [c000000002a00000] 0xc000000002a00000 (unreliable)
> > > [c000000001217d80] [c000000000f99490] .memblock_alloc_base+0x18/0x48
> > > [c000000001217df0] [c000000000f7a274] .allocate_paca_ptrs+0x3c/0x74
> > > [c000000001217e70] [c000000000f78bf0] .early_init_devtree+0x288/0x320
> > > [c000000001217f10] [c000000000f79b6c] .early_setup+0x80/0x130
> > > [c000000001217f90] [c000000000000528] start_here_multiplatform+0x68/0x80
> > >
> > >
> > > sparc images crash, starting with next-20181009. Bisect with
> > > next-201810112 points to the merge of devicetree/for-next, though
> > > devicetree/for-next itself does not have the problem (bisect log
> > > attached below). The crash is in devicetree code.
> > >
> > > Crash logs:
> > > https://kerneltests.org/builders/qemu-sparc64-next/builds/981/steps/qemubuildcommand_1/logs/stdio
> > > https://kerneltests.org/builders/qemu-sparc-next/builds/975/steps/qemubuildcommand_1/logs/stdio
> 
> The sparc crash appears to be related to changes I made. Looking into it.
> 

Let me know if you need me to test anything or do some debugging.

Thanks,
Guenter
