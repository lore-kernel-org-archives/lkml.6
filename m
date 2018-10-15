Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A8CC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AE6204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TM70C+jD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7AE6204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeJPEWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:22:18 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39907 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeJPEWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:22:18 -0400
Received: by mail-qt1-f196.google.com with SMTP id e22-v6so23113291qto.6;
        Mon, 15 Oct 2018 13:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TAtnSjVe5Oy8huocfAyz3IfRC4sqlvNBpftSm57vUu0=;
        b=TM70C+jDJ9tR8DEdCXsoToUI5XyS9nR3UBV0Y8TQfu0aTVq6tOaV1grUXSLkSaRd09
         S+roWn7spaXm+1IBsFwZ+v8nTf8ELK5DtTGf/FEwd0geIWi+5FxqM/2XfMAi3BXlPSbE
         K0r/wpjX824+674Dvrpmw6gEZSKTzpjj8yx55hDoOGat39UPIbT9hKAdQxSCdQJqVvsg
         JK3C8P4VKw5KJCUQ07Ca2zRLS6vAREz9EMt4ikiGga0EADWsvD23HhBQADlP123xSsVK
         pvpNLgZ08IOcZ8wh/zhrx7Hdj+M6uM8XcBe3GMGrLSocIIvX11YS60UilAoIqOA/BVOX
         vrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAtnSjVe5Oy8huocfAyz3IfRC4sqlvNBpftSm57vUu0=;
        b=uSbCvRjOmOF3xoqBoXdo07oTYIhJn+J7V40p3XJ/Plf7oNVyl7MbUDk+R2XvINPoM/
         w830GP6HyWnMdU22gIMori9xeavK1LLLpqZFf3v77QJGAn7dwSU7VIltS8QTSvtZP1ql
         eI1kYSrTfM4lMBhzIoCm53H59vxl/2x+cKBhigzYoIw9sftJ/2ZWLyrzwieg1q1g98x0
         MwAXJdiIUQXmCiIX5Tg1P2ZiGYdAiBcefbujidUdh7sFBTJ8SGdFevw92sTGdOw5dqSg
         RSal0zJJxHnedTcRz1frGKmEf5j4D9AtMN8YIFZKJRivVcM1roGPvwNw/RCd5J+0E/gP
         5m9g==
X-Gm-Message-State: ABuFfogn4Of8Ri/m6j7MApzHYLWW+zdSeR4OZ+/HKHnfbU8GYJGYK7p3
        IoVXNGHGMbLt0C3XtkKjW0QtOwYtM6nO3eYPIBJv
X-Google-Smtp-Source: ACcGV62DWIcbOKxUfy8fn6CAQBDlWxCdNzBLfEG12UAAd1z6B6vY10IaKW0xnVVNhf+YRBzIW2bPqz24B3vkD7cKv+Y=
X-Received: by 2002:a0c:bd15:: with SMTP id m21mr18950066qvg.77.1539635725276;
 Mon, 15 Oct 2018 13:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20181015192546.15faf3a1@canb.auug.org.au> <20181015182637.GA16445@roeck-us.net>
 <20181016071240.3f62816d@canb.auug.org.au>
In-Reply-To: <20181016071240.3f62816d@canb.auug.org.au>
From:   Rob Herring <robherring2@gmail.com>
Date:   Mon, 15 Oct 2018 15:35:12 -0500
Message-ID: <CAL_Jsq+DAEEa6i9xb-9MMSxu-znc9tZLZwFRADqE+kcxQYXrTg@mail.gmail.com>
Subject: Re: linux-next: Tree for Oct 15
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        linux-next <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 3:12 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Guenter,
>
> [Just cc'ing the PPC and devicetree folks]
>
> On Mon, 15 Oct 2018 11:26:37 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Mon, Oct 15, 2018 at 07:25:46PM +1100, Stephen Rothwell wrote:
> > >
> > > My qemu boots of a powerpc pseries_le_defconfig kernel failed today.
> >
> > Same here. Interestingly, this only affects little endian pseries
> > boots; big endian works fine. I'll try to bisect later.
> >
> > ALl ppc qemu tests (including big endian pseries) also generate a warning.
> >
> > WARNING: CPU: 0 PID: 0 at mm/memblock.c:1301 .memblock_alloc_range_nid+0x20/0x68
> > Modules linked in:
> > CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc7-next-20181015 #1
> > NIP:  c000000000f99198 LR: c000000000f99490 CTR: c000000000bb8364
> > REGS: c000000001217a78 TRAP: 0700   Not tainted  (4.19.0-rc7-next-20181015)
> > MSR:  0000000080021000 <CE,ME>  CR: 24000422  XER: 20000000
> > IRQMASK: 1
> > GPR00: c000000000f99490 c000000001217d00 c00000000121a500 00000000000000c0
> > GPR04: 0000000000000000 0000000000000000 0000000000000000 ffffffffffffffff
> > GPR08: 0000000000000000 00000000000000c0 0000000000000018 00000000000000b7
> > GPR12: 0000000000000040 c000000000fe7840 0000000000000000 0000000000000000
> > GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > GPR28: c000000000000304 c000000001262088 00000000000000c0 c000000000fea500
> > NIP [c000000000f99198] .memblock_alloc_range_nid+0x20/0x68
> > LR [c000000000f99490] .memblock_alloc_base+0x18/0x48
> > Call Trace:
> > [c000000001217d00] [c000000002a00000] 0xc000000002a00000 (unreliable)
> > [c000000001217d80] [c000000000f99490] .memblock_alloc_base+0x18/0x48
> > [c000000001217df0] [c000000000f7a274] .allocate_paca_ptrs+0x3c/0x74
> > [c000000001217e70] [c000000000f78bf0] .early_init_devtree+0x288/0x320
> > [c000000001217f10] [c000000000f79b6c] .early_setup+0x80/0x130
> > [c000000001217f90] [c000000000000528] start_here_multiplatform+0x68/0x80
> >
> >
> > sparc images crash, starting with next-20181009. Bisect with
> > next-201810112 points to the merge of devicetree/for-next, though
> > devicetree/for-next itself does not have the problem (bisect log
> > attached below). The crash is in devicetree code.
> >
> > Crash logs:
> > https://kerneltests.org/builders/qemu-sparc64-next/builds/981/steps/qemubuildcommand_1/logs/stdio
> > https://kerneltests.org/builders/qemu-sparc-next/builds/975/steps/qemubuildcommand_1/logs/stdio

The sparc crash appears to be related to changes I made. Looking into it.

Rob
