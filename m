Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeEPVVv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 17:21:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34926 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbeEPVVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 17:21:49 -0400
X-Google-Smtp-Source: AB8JxZqY4cmK3KKiRrJbe22CLb2GWxiMFhmQ2BK6BzMwO5LO6y+9xdu7AvTol9Hi2UrIjLz/FI2iutgFac6GC9Gju70=
MIME-Version: 1.0
References: <20180516202023.167627-1-shakeelb@google.com> <90167afa-ecfb-c5ef-3554-ddb7e6ac9728@suse.cz>
In-Reply-To: <90167afa-ecfb-c5ef-3554-ddb7e6ac9728@suse.cz>
From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 16 May 2018 14:21:35 -0700
Message-ID: <CALvZod6PebHBeqp_kJ47S_vMYKmHnAP5er4+03O=5XGFiyHfHA@mail.gmail.com>
Subject: Re: [PATCH] mm: save two stranding bit in gfp_mask
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 1:41 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> On 05/16/2018 10:20 PM, Shakeel Butt wrote:
> > ___GFP_COLD and ___GFP_OTHER_NODE were removed but their bits were
> > stranded. Slide existing gfp masks to make those two bits available.
> Well, there are already available for hypothetical new flags. Is there
> anything that benefits from a smaller __GFP_BITS_SHIFT?

I am prototyping to pass along the type of kmem allocation e.g. page table,
vmalloc, stack e.t.c. (still very preliminary).
