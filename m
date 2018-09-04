Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2884DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB77C20659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IAN7WsvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB77C20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeIDVi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:38:26 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36898 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbeIDVi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:38:26 -0400
Received: by mail-io0-f196.google.com with SMTP id v14-v6so3640355iob.4;
        Tue, 04 Sep 2018 10:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LNzBG5pGV6EojKq7EBEUw6ktl2I8dAwisfYUZ5sCKXM=;
        b=IAN7WsvD0VpuKaxWpKRTVKczB+PlCaGAtezELT8O2ol7r9WpspiRldt7nBOSywqJrj
         kfG98rk8hBWw2td0YyHKhF47SL3pHOS7H+ehfKe39QONtK2XbSZONY5txBltFMoEBPYU
         D497vekDYC++LOuhggKBc7BQt97++StuGgRpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LNzBG5pGV6EojKq7EBEUw6ktl2I8dAwisfYUZ5sCKXM=;
        b=WSJtgijqhGJ0nDuQz1obAAEBOvizFXJq+fT1QTgXkjbYu0YSX7biNh9UeYp8ZtQti4
         kWuGZNQC/o8LfNOGMFMb+rfPItzL6jGpaWhIR9WP+j0oNuQMHT8Apixht+yBbadQRKg5
         KksfcA2o+r5xNkOP4xQApHWXNzythDp0VA0uOGpXnboS5lN6QRPLXSmE3OEOLlT4bK+T
         +xFiE/kvJJgCPM/SYUMorENSe3mwXkp2rArErM2/y4LCpsEkoOyVWoO9Eg/S01eWNEbA
         jnXeUmkRuj0I3C5it868vSoVibXfRfJkAhwSYU5IXMIBhS+KYcAd/fu7sSb9FirTQrpP
         cuQg==
X-Gm-Message-State: APzg51AHoK2fop5vgwa2DY5GoIAY0siDpGgnUeVzSX3N3Yjc9fqzRiQi
        BrH+R7iQJETtLmmaGcUsElAMTcYCzFWLIDWUlew=
X-Google-Smtp-Source: ANB0VdZ0npQIzp+4HcZRW3vD/eicn6J86lDayGQfMRjoBEJrWHaLJulbo/gyolwsPgs/wqPsL8cDryznkyRF9Sjdptg=
X-Received: by 2002:a6b:97c6:: with SMTP id z189-v6mr23752116iod.120.1536081144698;
 Tue, 04 Sep 2018 10:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180903165719.499675257@linuxfoundation.org> <64889a4a-c095-3db8-b496-631acbafcf9a@applied-asynchrony.com>
In-Reply-To: <64889a4a-c095-3db8-b496-631acbafcf9a@applied-asynchrony.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Sep 2018 10:12:13 -0700
Message-ID: <CA+55aFyDZR4SGotsxUA7ahCGCDr+PGnn=_13e_0_W2SnoQbM5w@mail.gmail.com>
Subject: Re: [PATCH 4.18 000/123] 4.18.6-stable review
To:     holger@applied-asynchrony.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 11:39 AM Holger Hoffst=C3=A4tte
<holger@applied-asynchrony.com> wrote:
>
> Sep  3 20:19:38 ragnarok kernel:  tlb_flush_mmu_tlbonly+0x76/0xc0
> Sep  3 20:19:38 ragnarok kernel:  tlb_table_flush.part.13+0xe/0x30
> Sep  3 20:19:38 ragnarok kernel:  tlb_flush_mmu_tlbonly+0x54/0xc0
> ..a few hundred times..
> Sep  3 20:19:38 ragnarok kernel:  tlb_table_flush.part.13+0xe/0x30
> Sep  3 20:19:38 ragnarok kernel:  tlb_flush_mmu_tlbonly+0x54/0xc0
> Sep  3 20:19:38 ragnarok kernel:  arch_tlb_finish_mmu+0x3a/0x70
> Sep  3 20:19:38 ragnarok kernel:  tlb_finish_mmu+0x1f/0x30

Yeah, so what seems to have happened is that commit db7ddef30112 ("mm:
move tlb_table_flush to tlb_flush_mmu_free") wasn't applied to the
stable tree (because it wasn't an obvious dependency).

And without that, the backport of d86564a2f085 ("mm/tlb, x86/mm:
Support invalidating TLB caches for RCU_TABLE_FREE") ends up with
recursion from tlb_flush_mmu_tlbonly() calling tlb_table_flush(),
which in turn calls tlb_table_invalidate(), which calls back to
tlb_flush_mmu_tlbonly().

So you have endless recursion - at least until you run out of stack.
Then, if you have VMAP_STACK enabled (x86-64 without KASAN), you get a
nice clean kernel stack overflow message like you did.

Or if you have KASAN enabled and no VMAP stack, you just end up with
random hangs and huge memory corruption as the recursion stomps all
over your memory.

          Linus
