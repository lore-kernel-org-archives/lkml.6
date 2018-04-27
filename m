Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934130AbeD0PAv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:00:51 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:37960 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933698AbeD0OFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:05:46 -0400
X-Google-Smtp-Source: AB8JxZqgxv1tosq5XPJ9crb/Xt4b97aaYbh+jYJn3nvD0Hnvzz6tqKP+B9ex5ELBs7fafVxA79P63A==
Date: Fri, 27 Apr 2018 10:05:42 -0400
From: Vivek Unune <npcomplete13@gmail.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: BCM5301X: Fix NAND ECC parameters for Linksys
 Panamera
Message-ID: <20180427140542.c3t5taztkciimfny@osboxes>
References: <20180310171244.70299-1-npcomplete13@gmail.com>
 <CACna6rz1TeRbPq-60HkHz9A0TDn+iXtmXniE6FCiANpUmV-qrw@mail.gmail.com>
 <20180311100313.znonhesgh462rz65@osboxes>
 <2ef6e4fc-cce7-372e-e35f-578fd6ada9ca@gmail.com>
 <20180313010210.ws4dugy3rrpqwzmk@osboxes>
 <00df9ee9-2bd2-ad2b-fdf8-682efdb9a4d1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00df9ee9-2bd2-ad2b-fdf8-682efdb9a4d1@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 11:02:04AM +0200, Rafał Miłecki wrote:
> > [   13.530863] ubi0 warning: 0xc037c9e4: error -74 (ECC error) while reading 64 bytes from PEB 115:0, read only 64 bytes, retry
> > [   13.542763] ubi0 warning: 0xc037c9e4: error -74 (ECC error) while reading 64 bytes from PEB 115:0, read only 64 bytes, retry
> > [   13.554659] ubi0 warning: 0xc037c9e4: error -74 (ECC error) while reading 64 bytes from PEB 115:0, read only 64 bytes, retry
> > [   13.566548] ubi0 error: 0xc037ca08: error -74 (ECC error) while reading 64 bytes from PEB 115:0, read 64 bytes
> > [   13.576574] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.25 #0
> > [   13.582589] Hardware name: BCM5301X
> > [   13.586078] Backtrace:
> > [   13.588526] Function entered at [<c0105ccc>] from [<c0105fb4>]
> > [   13.594368]  r7:00000000 r6:60000013 r5:00000000 r4:c081d988
> > [   13.600032] Function entered at [<c0105f9c>] from [<c04f29a8>]
> > [   13.605872] Function entered at [<c04f2918>] from [<c037ca0c>]
> > [   13.611714]  r7:00000000 r6:00000040 r5:c7954000 r4:ffffffb6
> > [   13.617378] Function entered at [<c037c7dc>] from [<c037cd1c>]
> > [   13.623223]  r10:00000000 r9:00000040 r8:00000073 r7:c7954000 r6:c7979000 r5:c7036180
> > [   13.631071]  r4:c7b72900
> > [   13.633604] Function entered at [<c037cca4>] from [<c0381c5c>]
> > [   13.639447]  r10:00000000 r9:c7979800 r8:c7954000 r7:c7979000 r6:00000073 r5:c7036180
> > [   13.647286]  r4:c7b72900
> > [   13.649819] Function entered at [<c0381a84>] from [<c0376d74>]
> > [   13.655663]  r10:c7954040 r9:00000840 r8:c702e400 r7:00000000 r6:c702e400 r5:c7954000
> > [   13.663510]  r4:fffff800
> > [   13.666042] Function entered at [<c0376720>] from [<c0717b9c>]
> > [   13.671886]  r10:c0813a88 r9:c0651c18 r8:c0651bec r7:c084ff48 r6:c081e440 r5:c7823ea4
> > [   13.679725]  r4:c702e400
> > [   13.682258] Function entered at [<c0717954>] from [<c0101a8c>]
> > [   13.688103]  r10:c072e83c r9:c07366b8 r8:c0717954 r7:c072e838 r6:c081e440 r5:00000000
> > [   13.695949]  r4:c0803c08
> > [   13.698482] Function entered at [<c01019dc>] from [<c0700e38>]
> > [   13.704327]  r9:c07366b8 r8:c0700594 r7:c072e838 r6:c081e440 r5:c081e440 r4:00000008
> > [   13.712087] Function entered at [<c0700cf8>] from [<c0506adc>]
> > [   13.717930]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0506acc
> > [   13.725769]  r4:00000000
> > [   13.728303] Function entered at [<c0506acc>] from [<c0102788>]
> > [   13.734144]  r5:c0506acc r4:00000000
> 
> This is expected if you previously were using firmware programming flash
> in non-BCH8 mode. The main reason for what you're seeing is that when
> flashing image with CFE it doesn't erase all NAND pages.
> 
> If previously you were using firmware programming flash in BCH1 mode, it
> means that after flashing firmware using BCH8 you'll end up with mess in
> ECC.
> 
> Part of NAND flash programmed by CFE will use BCH8.
> Part of NAND flash that remained from previous fw will use BCH1.
> Linux will fail to read part of NAND flash from prev installation.
> 
> The cleanest solution: erase all NAND content of firmware partition
> before flashing firmware using BCH8.
> 
> The easiest solution: ignore all these "error -74 (ECC error) while
> reading" errors (they may last for few minutes!). I believe UBI should
> simply recreate all pages it couldn't access and once you wait long
> enough, all your NAND flash will be using BCH8.

Let me build the firmware with BCH-8 and wait it out. I'll report back my
results.

Thanks,

Vivek
