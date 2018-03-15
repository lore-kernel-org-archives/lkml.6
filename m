Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbeCOS2a (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:28:30 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:33473 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeCOS22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:28:28 -0400
X-Google-Smtp-Source: AG47ELte3rGxjpDkl0anCXtkM/51V0v51+flzVZspzWb02WxgezZYu5YODDbAOgXg3QS0vdzkefAugi8MEc6B55WClE=
MIME-Version: 1.0
In-Reply-To: <20180315182110.GR23100@dhcp22.suse.cz>
References: <20180314192937.12888-1-ard.biesheuvel@linaro.org>
 <CACjP9X_A1VsprX20XfEi31XVrySkScZDJsxUTh3Lf_6xr70Mug@mail.gmail.com>
 <CAKv+Gu-NfXm5YLWXAPsf6zycPs7Ti9qPLQ7FvpOrjdPz5hEP7Q@mail.gmail.com>
 <CACjP9X_xjyvQD_b1XNAZi=vjX0wGUmQuGJN8HahBmXx55OUE6A@mail.gmail.com>
 <CAKv+Gu8aVr_u4o8QR2Nquo9it54nSbvPMj4vcZ+CQa3uoOakrA@mail.gmail.com>
 <CACjP9X_bKJNeSwbPURmJ8bwDZ5BW2ZrykhT-cNapzKjddeWStQ@mail.gmail.com>
 <CAKv+Gu8dvCRUnS5KxDWa4GP2vMPo9cUWVNybx+tGY_Y8T67Uvw@mail.gmail.com>
 <CACjP9X9w-zruS8uj6j+ZRc7EUZ80MAwbvWOh=gRJZu7gAqU7hg@mail.gmail.com>
 <CAKv+Gu83VtB+ff6H88UMF9kiz5923U8tXhQoERdErYE4pQg94Q@mail.gmail.com> <20180315182110.GR23100@dhcp22.suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Mar 2018 11:28:27 -0700
X-Google-Sender-Auth: t4QJz4HrBk4hrC9pWTWJ3svS9Eg
Message-ID: <CA+55aFy0+EP14zjnYh1x_Aw3y-wCp2COpw9D-OfmhA9YFfsQiA@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "mm/page_alloc: fix memmap_init_zone pageblock alignment"
To: Michal Hocko <mhocko@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Vacek <neelx@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Paul Burton <paul.burton@imgtec.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 11:21 AM, Michal Hocko <mhocko@kernel.org> wrote:
>
> Well, pfn_valid says that a given pfn is backed by a real memory and it
> has a valid struct page backing it.

No, it really just says the latter. There should be a "struct page" for it.

It may not be "real memory". The struct page might have it marked
reserved or something. But at least you should be able to get to the
"struct page" and look at it.

                   Linus
