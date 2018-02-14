Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967228AbeBNKgG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:36:06 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:45646 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966971AbeBNKgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:36:05 -0500
X-Google-Smtp-Source: AH8x225BrMrBJXGsQOrU0OVIc8vuLBqlWsDHkcHT/DI02kt31F02Sj/ogXt7XqoyQrygXvbgWKxGno2ku/vnz9faQ8I=
MIME-Version: 1.0
In-Reply-To: <CA+7wUszh=xpNMsZXS0fNu2Vcp=GK9xkzfog5qB2_LGizhadv1Q@mail.gmail.com>
References: <20171226113717.15074-1-malat@debian.org> <20171226113717.15074-2-malat@debian.org>
 <20180102093127.GM5027@jhogan-linux.mipstec.com> <CA+7wUszh=xpNMsZXS0fNu2Vcp=GK9xkzfog5qB2_LGizhadv1Q@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 14 Feb 2018 11:35:44 +0100
X-Google-Sender-Auth: aQ_nYBWzh3QMmr9LnMwDDCLL_5U
Message-ID: <CA+7wUsyNrLzd0fM5B4_89wp8G9g=VHLu=xQ3o4bK47PLv4p1LQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Remove a warning when PHYS_OFFSET is 0x0
To: James Hogan <james.hogan@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1EAaB0l007237

On Tue, Jan 2, 2018 at 7:55 PM, Mathieu Malaterre <malat@debian.org> wrote:
> Hi James,
>
> On Tue, Jan 2, 2018 at 10:31 AM, James Hogan <james.hogan@mips.com> wrote:
>> On Tue, Dec 26, 2017 at 12:37:14PM +0100, Mathieu Malaterre wrote:
>>> Rewrite the comparison in `else if` statement, case where `min_low_pfn >
>>> ARCH_PFN_OFFSET` has already been checked in the first `if` statement:
>>>
>>>   if (min_low_pfn > ARCH_PFN_OFFSET) {
>>>
>>> Fix non-fatal warning:
>>>
>>> arch/mips/kernel/setup.c: In function ‘bootmem_init’:
>>> arch/mips/kernel/setup.c:461:25: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
>>>   } else if (min_low_pfn < ARCH_PFN_OFFSET) {
>>>                          ^
>>
>> What compiler version is that with out of interest? It isn't exactly new
>> code.
>
> I've clarified in v2, that this happen during compilation using W=1
>
> For reference:
>
> $ mipsel-linux-gnu-gcc -dumpversion
> 6.3.0
>
>
>>>
>>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>>
>> Reviewed-by: James Hogan <jhogan@kernel.org>
>
> Thanks !

ping ?

https://patchwork.linux-mips.org/project/linux-mips/list/?series=623
