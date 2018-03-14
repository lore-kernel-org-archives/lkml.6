Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeCNO4U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 10:56:20 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:46589 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbeCNO4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 10:56:17 -0400
X-Google-Smtp-Source: AG47ELsMRFvfQVbmoPKy22goT2IYSd/4zolumf+m2R3nvBWDnYpQocooKXmUV+HnVeGdJ7GZFlJ69Fr0I1Ylgw+LnU4=
MIME-Version: 1.0
In-Reply-To: <83b23320-e9de-a0cf-144c-1b60b9b7002a@oracle.com>
References: <20180314143529.1456168-1-arnd@arndb.de> <20180314143958.1548568-1-arnd@arndb.de>
 <83b23320-e9de-a0cf-144c-1b60b9b7002a@oracle.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 15:56:16 +0100
X-Google-Sender-Auth: eBQp5tLRIf99iI1wOzcOP5QNdfs
Message-ID: <CAK8P3a1otS+2Q7qr0PE_VPXRp44kJqdZMhDFWuYK2g2jkNCCsA@mail.gmail.com>
Subject: Re: [PATCH 10/16] mm: remove obsolete alloc_remap()
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 3:50 PM, Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
> Hi Arnd,
>
> I like this cleanup, but arch/tile (which is afaik Orphaned but still in the gate) has:
>
> HAVE_ARCH_ALLOC_REMAP set to yes:
>
> arch/tile/Kconfig
>  config HAVE_ARCH_ALLOC_REMAP
>          def_bool y

It was a bit tricky to juggle the Cc lists here, but tile is removed
in patch 06/10
now. As I explained in the cover letter, it was originally planned to be marked
deprecated for a while first, but after some more discussion, nobody could come
up with a reason to keep it any longer. Same thing for mn10300,
blackfin and cris.

     Arnd
