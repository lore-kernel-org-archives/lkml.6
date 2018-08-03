Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B703FC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBFA2174C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mYxiXJiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BBFA2174C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbeHCLLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:11:18 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:40883 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbeHCLLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:11:18 -0400
Received: by mail-ua0-f171.google.com with SMTP id m13-v6so3594132uaq.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 02:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dBQBMMYTDcETJ0Up5rgAPd9eoi4Ge2rTP70yMTSlvtc=;
        b=mYxiXJiObeTyBz7a4vWICwKpPZuIl9AtmJgsj9kk98NVx4jSJRAacHYrBWhGi2BDOV
         JznAekzFcTp6u7vWWYzzj21CMkwEEgRmMdSAf0+U+7mmdhLcvWcJ2/UsoF+k4NNmrinX
         QK/kzTsSoAlWqX2yUeoS/FWcnXECkUv1WW4h5c3x2hon+bOKOcGqHX8ks7ZrgxthoONU
         OUdN7nojXqD1v5zEyXBHEjogeGcMKyYQfBGzRvDBltye6nXmbIBGho9NGDThXUKD3zrK
         KHn9Xs1vHdhGedSIHZtTsw6BRDpmPAUT4frekeRRU5DabL4exzvJQAyYeglf9paVt6AP
         UvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dBQBMMYTDcETJ0Up5rgAPd9eoi4Ge2rTP70yMTSlvtc=;
        b=Ga2QZUylGVO3zWsdIXaLjpa77LBu2ZJj4Qol9WZYvkGJwbKZTx/oe6/mqTaMKKrTuL
         i5xROOjk6Gf34G4sqlGmdwaDd2OLcRMXwshlbMx0UvJgOFMBxhFpqbF62mRftKZco82Q
         sUbGx2iOxZOdnzt59Yazj0/znxA07gw+qlQEnpJL5eDKQTXNhb5++XBfHtxdSWX8ih4e
         sSoCW0KOY4Jy2akhC/qeFfbjaOqiLkzFrhIJ8ENqw4pKEmuaeh/jRh6aakPZF9v58Fp9
         ZQrJb713/l9YQAhAX1XTVyaksOLbWu4gVvzI2Pxo243gzez5XKanaUHV+luF48WHPklT
         jpPA==
X-Gm-Message-State: AOUpUlEneMcE26fClnBLEm0VxJ5dl8/yc/hUUeKaMFEPcveX/RR2hFTY
        H7fdpkRktkAi6FiKwUI0LdVxZeHDR0dw3lrb2zo=
X-Google-Smtp-Source: AAOMgpfb0QpqhOejB16gFTbTpQ+bHtAoW8AcNvME4vGdmwthbjrS5mxQ83azI4qAVEMIMJAUJ8Ovojt3op+wm5MDh7I=
X-Received: by 2002:a1f:311:: with SMTP id 17-v6mr1938708vkd.13.1533287753126;
 Fri, 03 Aug 2018 02:15:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:6044:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 02:15:52 -0700 (PDT)
In-Reply-To: <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com> <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
From:   Ramana Radhakrishnan <ramana.gcc@googlemail.com>
Date:   Fri, 3 Aug 2018 10:15:52 +0100
Message-ID: <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andrew Pinski <pinskia@gmail.com>, mpatocka@redhat.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux@armlinux.org.uk,
        thomas.petazzoni@free-electrons.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 8:53 AM, Florian Weimer <fweimer@redhat.com> wrote:
> On 08/03/2018 09:11 AM, Andrew Pinski wrote:
>>
>> Yes fix Links not to use memcpy on the framebuffer.
>> It is undefined behavior to use device memory with memcpy.
>
>
> Some (de facto) ABIs require that it is supported, though.  For example, the
> POWER string functions avoid unaligned loads and stores for this reason
> because the platform has the same issue with device memory.  And yes, GCC
> will expand memcpy on POWER to something that is incompatible with device
> memory. 8-(

GCC for AArch64 - use -mstrict-align
GCC for AArch32 - use -mno-unaligned-access.

If you see unaligned accesses coming out of the compiler for well
defined programs then that's a bug. Frequently we see undefined
programs that get the compiler to produce traps - atleast one or 2
bugs a year  in  GCC .


>
> If we don't want people to use memcpy, we probably need to provide a
> credible alternative.

I believe a number of packages have rolled their own to take these
constraints into account
for AArch32, perhaps it needs to be expanded for AArch64 as well.

regards
Ramana

>
> Thanks,
> Florian
