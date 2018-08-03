Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FDFC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2B82172A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTxVj2Hd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2B82172A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbeHCJGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:06:23 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36228 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeHCJGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:06:23 -0400
Received: by mail-oi0-f50.google.com with SMTP id n21-v6so8164137oig.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 00:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O3Tuvz/QMcn4bI7Sw1vdWSkSG/4e0B2fTumQ0HVLE4Q=;
        b=MTxVj2HdAnceDw61/44ccVwH6SV1V5xo3TgzNgJccAlJUI7bI9ndK4Kqo6pchjttZM
         WPKoQ0WK56J8/D7wmy6ol1LfCiU4Knx/C29R4+sxdAAYPSC/rGuzWvxBI12jiwM6fAmo
         gzvg6sxzzpErmr9r855tZ+hx25Xt5MjEL9fGIhKa26quSjsufKxqrdnwZqhi8NnawUio
         /tmWejgaJ9RfdiK6v6DWrM3cxbob+PQIvV0MKAh+mAXngi2h392eVLp3VPx1Si4bWOSr
         mEK8CdOFpAl77ul7DnNJZ8Qv2K3xmyk8pnDd0xFA0LfRDdzgkPKtGhjVvDzxNeIfkWO3
         uV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O3Tuvz/QMcn4bI7Sw1vdWSkSG/4e0B2fTumQ0HVLE4Q=;
        b=ESEivayiSgnROi0NFLp2pUnxirMXF1MSZNETQwIczghz5dpJdR6NNB+EPCYTKyaJc5
         KIbfiwBNTfCoh/xvMPLDha0hLmiOl2uVRiviRv3m1gi0lmUT5UlvKHT6qmF9LPS7GFEV
         MmeDvZCCLG2n3hH1pwj0wg+j5tlaq/cWCGM6iNO+BubO8t3yPK8mG3cmwKKKWmRRYNpp
         0sW+30hEgAe9+bVpqsKFfA0AXzLXohKBQxcBdpTBzTgEu6GeL01jZb7i17YMgO/ZVimc
         bQkBgCmBvbPLM2fR73ZtOKiLT+Z7UL98zVTxxe7JryuUkfXKrZhvcZik2gc0j92ijxJO
         eXWQ==
X-Gm-Message-State: AOUpUlEJ6920SLKcxwc96oW16XaHUOF0CGarWcZia5txIiTI+wL2oEKN
        YfXJ9alyksaCYjZNz4aekAWTYaeJPr14iOCkEzI=
X-Google-Smtp-Source: AAOMgpczyFQx51o3iR5SnOYtxpt69KfTsW/Lt7RKRoXaPGa4aSFLOyzlBsKT/3YxlxJnNzsiHHNochwbFqbHcSo0ero=
X-Received: by 2002:a54:4f94:: with SMTP id g20-v6mr2152706oiy.130.1533280288520;
 Fri, 03 Aug 2018 00:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
From:   Andrew Pinski <pinskia@gmail.com>
Date:   Fri, 3 Aug 2018 00:11:16 -0700
Message-ID: <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     mpatocka@redhat.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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

On Thu, Aug 2, 2018 at 12:31 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> Hi
>
> I tried to use a PCIe graphics card on the MacchiatoBIN board and I hit a
> strange problem.
>
> When I use the links browser in graphics mode on the framebuffer, I get
> occasional pixel corruption. Links does memcpy, memset and 4-byte writes
> on the framebuffer - nothing else.
>
> I found out that the pixel corruption is caused by overlapping unaligned
> stp instructions inside memcpy. In order to avoid branching, the arm64
> memcpy implementation may write the same destination twice with different
> alignment. If I put "dmb sy" between the overlapping stp instructions, the
> pixel corruption goes away.
>
> This seems like a hardware bug. Is it a known errata? Do you have any
> workarounds for it?

Yes fix Links not to use memcpy on the framebuffer.
It is undefined behavior to use device memory with memcpy.

Thanks,
Andrew Pinski

>
> I tried AMD card (HD 6350) and NVidia (NVS 285) and both exhibit the same
> corruption. OpenGL doesn't work (it results in artifacts on the AMD card
> and lock-up on the NVidia card), but it's quite expected if even simple
> writing to the framebuffer doesn't work.
>
> Mikulas
