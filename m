Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753969AbeDQOkT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:40:19 -0400
Received: from resqmta-ch2-10v.sys.comcast.net ([69.252.207.42]:44924 "EHLO
        resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753051AbeDQOkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:40:17 -0400
Date: Tue, 17 Apr 2018 09:40:15 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Mikulas Patocka <mpatocka@redhat.com>
cc: Vlastimil Babka <vbabka@suse.cz>, Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        dm-devel@redhat.com, David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: slab: introduce the flag SLAB_MINIMIZE_WASTE
In-Reply-To: <alpine.LRH.2.02.1804161650170.7237@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.DEB.2.20.1804170939420.17557@nuc-kabylake>
References: <alpine.LRH.2.02.1803201740280.21066@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1803211226350.3174@nuc-kabylake> <alpine.LRH.2.02.1803211425330.26409@file01.intranet.prod.int.rdu2.redhat.com> <20c58a03-90a8-7e75-5fc7-856facfb6c8a@suse.cz>
 <20180413151019.GA5660@redhat.com> <ee8807ff-d650-0064-70bf-e1d77fa61f5c@suse.cz> <20180416142703.GA22422@redhat.com> <alpine.LRH.2.02.1804161031300.24222@file01.intranet.prod.int.rdu2.redhat.com> <20180416144638.GA22484@redhat.com>
 <alpine.LRH.2.02.1804161054410.17807@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1804161018030.9397@nuc-kabylake> <alpine.LRH.2.02.1804161123400.17807@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1804161043430.9622@nuc-kabylake>
 <alpine.LRH.2.02.1804161532480.19492@file01.intranet.prod.int.rdu2.redhat.com> <b0e6ccf6-06ce-e50b-840e-c8d3072382fd@suse.cz> <alpine.LRH.2.02.1804161650170.7237@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfGha4BouoXvpKSvFXGW1w1uR3Qo9t68nvj95H0DOd1TMeuSMS1n82JS7oELaSztneYEgeJGKtQld4RLNiv+TyKlyhDjnttkolSBnQ4HrC7preNUvEHzr
 p6WXnOoqx8UrEYQJvwRPNYUguuP+e5QBDGMcnqTkEbUi+XAT5pYGiw/NAvmMff07ZLgG8SVXOhcCpDuos1G+4VxSFw7ONhGc/z1eVwUbJiENNiisF2KM4qH6
 E/2JdlvZzFZVqJJlqku89Nsdj8pY+ROYGnoctNDE66Gf+3MJUR672WFZ/GcTbiHERebP4H6nBb6o5h169wJMBZw+qi3Pa+g+ZypxWQs2PbC05GT5XIMCORHV
 s0YEGLM73G4ktJTZETigAMtQcDBIwMWNDJ9CSXiC8cqQl2d+TpDca3sDKFvYEbVW2Ldy5jzjZHvPxgcsIh7EKeSr6l4uYMo3Mbl3CtoQvK//xQ4I1w7hDyXS
 fbcRx9ISef3JUMm3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2018, Mikulas Patocka wrote:

> dm-bufio deals gracefully with allocation failure, because it preallocates
> some buffers with vmalloc, but other subsystems may not deal with it and
> they cound return ENOMEM randomly or misbehave in other ways. So, the
> "SLAB_MINIMIZE_WASTE" flag is also saying that the allocation may fail and
> the caller is prepared to deal with it.
>
> The slub subsystem does actual fallback to low-order when the allocation
> fails (it allows different order for each slab in the same cache), but
> slab doesn't fallback and you get NULL if higher-order allocation fails.
> So, SLAB_MINIMIZE_WASTE is needed for slab because it will just randomly
> fail with higher order.

Fix Slab instead of adding a flag that is only useful for one allocator?
