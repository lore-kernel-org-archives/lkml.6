Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE688C46465
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7765F2080F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxsD3v0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7765F2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeKUHPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:15:12 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42491 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeKUHPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:15:11 -0500
Received: by mail-io1-f68.google.com with SMTP id x6so2410715ioa.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 12:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ca+kKfTYUEeOXGZ8qwsABx9DnazmQXqzRwbzeXPkKkQ=;
        b=kxsD3v0Lf+5TNQjUmFi/Nv+LHi1MqUxSwrUkHXMUxadFB5OsQT5FLDJ9uyWg/zq/am
         oNfmR1F+Iy8W7mxpuj6Z67jHhbF0NaQSyxb0XzTUKzcMQmNcXOrdrRy/10v3VOK5sdLe
         Ot81ABJGzvU09KsMg4922yFfChr90ASRklE7FQN3NMOFb+OhskHMLLAl3qODBOekWB7W
         G6Mkr5w86I/AhU38zCZIlYW8PqT347hih5HggxmkbQgMgR9eBukF6cHs00A81+ryxSZC
         seMkMoN+wNdW4tE6Ww6icuJ1+uSK+JbVgfxS8jduB3t/1dJrG49fDDmGA1nKcINaXIzS
         KAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ca+kKfTYUEeOXGZ8qwsABx9DnazmQXqzRwbzeXPkKkQ=;
        b=f2JbZCDbevS03ID8Z+dztyFhwIeFLucwCn8qR5yLkhOEBL6D0HMLG4wm0EMpNt1tAg
         TIl5O09IAQaXCapvpVdY4uyUFIYUMmUPwQWcQlk9WUiHK51e02rHNF36Lzr7rosSlCis
         pEHFFRqbd0wyDv2CU2fGSxE3g0jNAkV3x+MtkvQAwJnbHSGMYOOtaDeKTs0lS3b4uyRQ
         QD9X0PHRlEEpIrhE2zSOArseXs1PDgHNx1y39hCOK2KJ/CyNLymS2ra25+EE8tqRUvsK
         xEnYVvsE8kDGJBxuceeJTehYY/gfC0BmcmG74TthxTGevJeIX5TmJ8nvdS8sjxacPbrB
         Vfhg==
X-Gm-Message-State: AA+aEWbNtcDnLr7sSW4H1DFBARrcD2zfKyg228/Tsr77dQZ2S73HDt/w
        LM50CmarpQMEc20bSEMeSAg4dvWHO7V2pwExA7s=
X-Google-Smtp-Source: AFSGD/WZtT16vXecXpj7zFlkUBBuXjnac43n3MMUF9abuygZoycchWl8BOPTLzv7BdFNZhl55lmmfGXgc3EkZAf2+QI=
X-Received: by 2002:a6b:d005:: with SMTP id x5mr2782463ioa.46.1542746649545;
 Tue, 20 Nov 2018 12:44:09 -0800 (PST)
MIME-Version: 1.0
References: <20181114072926.13312-1-lijiang@redhat.com> <20181114072926.13312-2-lijiang@redhat.com>
 <20181114112600.GD13926@zn.tnic> <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
 <20181115103959.GB26448@zn.tnic>
In-Reply-To: <20181115103959.GB26448@zn.tnic>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Tue, 20 Nov 2018 14:43:57 -0600
Message-ID: <CABhMZUUscS3jUZUSM5Y6EYJK6weo7Mjj5-EAKGvbw0qEe+38zw@mail.gmail.com>
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
To:     bp@alien8.de
Cc:     lijiang@redhat.com, Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86 <x86@kernel.org>, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, dyoung@redhat.com,
        bhe@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 4:40 AM Borislav Petkov <bp@alien8.de> wrote:
>
> + Bjorn.
>
> On Thu, Nov 15, 2018 at 01:44:07PM +0800, lijiang wrote:
> > At present, the upstream kernel does not pass the e820 reserved ranges to the
> > second kernel, which might cause two problems:
> >
> > The first one is the MMCONFIG issue, the PCI MMCONFIG(extended mode) requires
> > the reserved region otherwise it falls back to legacy mode, which might lead to
> > the hot-plug device could not be recognized in kdump kernel.
>
> Well, this still doesn't explain it fully. Let's look at a box:
>
> [    0.000000] e820: BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x00000000000997ff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000000099800-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000065642fff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000065643000-0x0000000067fb8fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000067fb9000-0x00000000689e8fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000689e9000-0x0000000068bf5fff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x0000000068bf6000-0x000000006f7fffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000006f800000-0x000000008fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000fe7fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec80000-0x00000000fed00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000001007fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100800000-0x000000603fffffff] usable
>
> this one has 8 reserved regions. Does that mean that we need to pass
> them *all* 8 to the second kernel so that MMCONFIG works?
>
> Or is it only one reserved region which is needed for MMCONFIG?
>
> Bjorn, do you know what the detection logic should be to map the correct
> reserved region (or regions) for MMCONFIG?

MMCONFIG (aka ECAM) space is described in the ACPI MCFG table.  The
generic code to read that is in drivers/acpi/pci_mcfg.c (ignore all
the quirks at the top) and the generic code to use it is
drivers/pci/ecam.c.

Unfortunately x86 doesn't use any of that generic path.  It uses the
same MCFG table, but it's parsed in arch/x86/pci/mmconfig-shared.c,
and the code there checks to ensure the ECAM regions are reserved
somehow by firmware, e.g., via the e820 table.  There's a bunch of
grungy device-dependent code there, too, possibly to work around
firmware defects, or (just as likely) to compensate for Linux defects
that were *attributed* to firmware.

I think you should regard correct MCFG/ECAM usage in the kdump kernel
as a requirement.  If you don't have ECAM (a) PCI devices won't work
at all on non-x86 systems that use only ECAM for config access, (b)
you won't be able to access devices on non-0 segments (granted, there
aren't very many of these yet, but there will be more in the future),
and (c) you won't be able to access extended config space (addresses
0x100-0xfff), which means none of the Extended Capabilities will be
available (AER, ACS, ATS, etc).

Bjorn
