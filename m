Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BE5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7492192B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i31X/EdD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732951AbeLUQdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:33:24 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43274 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbeLUQdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:33:19 -0500
Received: by mail-io1-f66.google.com with SMTP id q17so641839ior.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 08:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Lr0kuAHZiaayO2fk3kbkYBV3siRa+sclt4+8+TlVCE=;
        b=i31X/EdDCq3TpOIwM63F89VI+KUqzZWOhv1Bz6eS0uOSb5hGiYAEBXunFyPjzpBR33
         kOmFjt4MQP+FZ7ELw45mMNJq8QYK4TUyRciVBDx5mGQS11KzjlZG3eHLFqogLbfdET/f
         PxFd0LGp38IogoI598dSffGi3HWXztUmpn2e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Lr0kuAHZiaayO2fk3kbkYBV3siRa+sclt4+8+TlVCE=;
        b=BN9cV/gZb7R0wm5b4wmvR8oXBliW7xJQceLYd5MERlEUDkeAFg2oWvFruUwagd3+m6
         CKBsPdoCwUs+hRfnIxw0nYvX8URS0UHdhsG/m+Zxge8O0l7pzvtG+MY9CGMU2qZpBVeh
         wSWjjUid03s1nUCV4T6HPDMEeOSWNNfcsb14Rzn4dOUN3kpgb5llIXVz8qXn70Rmiaee
         Suz1sMRNUBW29h8NuZSjhnyBfVIF5G1YV7QCTOuQHZVYKRebVuVo/2TLu5cnUYtYQZ67
         m76xK4+4pAhEg2bFYI3iBam5pRboBX7YXs8bJEXNctRgTkHsYUrwhyfg6iTrpgnxSXzo
         MIGw==
X-Gm-Message-State: AJcUukevMsHhke8AYHdUdUf9F86ZjSnIgojzqlkQ+lBuBOhrOGlwEmYg
        WmDyLg/YcgVXc/apjQGmE+dxO/5+zz26GZrDDfyvhg==
X-Google-Smtp-Source: ALg8bN5PVQnpD27DWJ0WfhxB+TQehw5SzkGXHYAUlD41tJ1RpG1DXM8C+Aq+H8RntuBHkkTs9mkhOW1wChnOZC/1FE4=
X-Received: by 2002:a5d:8417:: with SMTP id i23mr196059ion.173.1545409998756;
 Fri, 21 Dec 2018 08:33:18 -0800 (PST)
MIME-Version: 1.0
References: <20181221193244.3a6ed685@canb.auug.org.au> <20181221162149.GA32500@roeck-us.net>
In-Reply-To: <20181221162149.GA32500@roeck-us.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 21 Dec 2018 17:33:07 +0100
Message-ID: <CAKv+Gu9v9z71k1TzRuAYaw_NEW2jW+hqztzgJuHxB9qek4eQWA@mail.gmail.com>
Subject: Re: linux-next: Tree for Dec 21
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sinan Kaya <okaya@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wen He <wen.he_1@nxp.com>, Peng Ma <peng.ma@nxp.com>,
        Vinod Koul <vkoul@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 at 17:21, Guenter Roeck <linux@roeck-us.net> wrote:
>
...

> ---
> [8]:
>
> This problem results in a stall on reboot. Reverting the offending patch
> fixes the problem.
>
> # bad: [340ae71f9dd421227a58c14a909b63033745dca4] Add linux-next specific files for 20181221
> # good: [7566ec393f4161572ba6f11ad5171fd5d59b0fbd] Linux 4.20-rc7
> git bisect start 'HEAD' 'v4.20-rc7'
> # good: [9f3de88514b2b5666214f0be3bc98d4e7136a7f1] Merge remote-tracking branch 'mtd/mtd/next'
> git bisect good 9f3de88514b2b5666214f0be3bc98d4e7136a7f1
> # good: [f4dd556a2cc77f672b9ba585aaad094a6fe09cf7] Merge remote-tracking branch 'spi/for-next'
> git bisect good f4dd556a2cc77f672b9ba585aaad094a6fe09cf7
> # bad: [75f0840128c421df5e1741f5df22a34409bb5d72] Merge remote-tracking branch 'char-misc/char-misc-next'
> git bisect bad 75f0840128c421df5e1741f5df22a34409bb5d72
> # bad: [759c7b0b404422c61ad9de57ef74a7fbe32c398c] Merge remote-tracking branch 'edac-amd/for-next'
> git bisect bad 759c7b0b404422c61ad9de57ef74a7fbe32c398c
> # bad: [d05ef4b240949dd78c319b3e8f3f162e5d3e332c] Merge branch 'x86/fpu'
> git bisect bad d05ef4b240949dd78c319b3e8f3f162e5d3e332c
> # bad: [1bce5ee16f83cf13a2a6d95c1bd579384036adff] Merge branch 'locking/atomics'
> git bisect bad 1bce5ee16f83cf13a2a6d95c1bd579384036adff
> # good: [eaaf055f27a0eaaed0cdb0d3aa8d7fb892829ccb] Merge branches 'bug.2018.11.12a', 'consolidate.2018.12.01a', 'doc.2018.11.12a', 'fixes.2018.11.12a', 'initrd.2018.11.08b', 'sil.2018.11.12a' and 'srcu.2018.11.27a' into HEAD
> git bisect good eaaf055f27a0eaaed0cdb0d3aa8d7fb892829ccb
> # good: [a97b5635d2d670fc351f7d34a84e040a2597c185] Merge branch 'core/rcu'
> git bisect good a97b5635d2d670fc351f7d34a84e040a2597c185
> # bad: [d0e9d5b657c44e0d2584ca6272852ddc6da97b7a] Merge branch 'efi/urgent'
> git bisect bad d0e9d5b657c44e0d2584ca6272852ddc6da97b7a
> # good: [47c33a095e1fae376d74b4160a0d73c1a4e73969] x86/efi: Move efi_<reserve/free>_boot_services() to arch/x86
> git bisect good 47c33a095e1fae376d74b4160a0d73c1a4e73969
> # good: [80424b02d42bb22f8ff8839cb93a84ade53b39c0] efi: Reduce the amount of memblock reservations for persistent allocations
> git bisect good 80424b02d42bb22f8ff8839cb93a84ade53b39c0
> # bad: [793423cf07e51e3185b8680167115813589c057d] efi: Align 'efi_guid_t' to 64 bits
> git bisect bad 793423cf07e51e3185b8680167115813589c057d
> # good: [a0fc5578f1d63ba6e80d9509991b4c14f6eaf488] efi: Let kmemleak ignore false positives
> git bisect good a0fc5578f1d63ba6e80d9509991b4c14f6eaf488
> # first bad commit: [793423cf07e51e3185b8680167115813589c057d] efi: Align 'efi_guid_t' to 64 bits

This patch has already been dropped from the efi/urgent tree
