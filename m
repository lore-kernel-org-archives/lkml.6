Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753145AbeDZSvy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 14:51:54 -0400
Received: from resqmta-ch2-05v.sys.comcast.net ([69.252.207.37]:51008 "EHLO
        resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751262AbeDZSvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 14:51:52 -0400
Date: Thu, 26 Apr 2018 13:51:51 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Mikulas Patocka <mpatocka@redhat.com>
cc: Mike Snitzer <snitzer@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        dm-devel@redhat.com, David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] slab: introduce the flag SLAB_MINIMIZE_WASTE
In-Reply-To: <alpine.LRH.2.02.1804251702250.9428@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.DEB.2.20.1804261350500.6674@nuc-kabylake>
References: <alpine.LRH.2.02.1803201740280.21066@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1803211024220.2175@nuc-kabylake> <alpine.LRH.2.02.1803211153320.16017@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1803211226350.3174@nuc-kabylake>
 <alpine.LRH.2.02.1803211425330.26409@file01.intranet.prod.int.rdu2.redhat.com> <20c58a03-90a8-7e75-5fc7-856facfb6c8a@suse.cz> <20180413151019.GA5660@redhat.com> <ee8807ff-d650-0064-70bf-e1d77fa61f5c@suse.cz> <20180416142703.GA22422@redhat.com>
 <alpine.LRH.2.02.1804161031300.24222@file01.intranet.prod.int.rdu2.redhat.com> <20180416144638.GA22484@redhat.com> <alpine.LRH.2.02.1804161530360.19492@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1804170940340.17557@nuc-kabylake>
 <alpine.LRH.2.02.1804171454020.26973@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1804180952580.1334@nuc-kabylake> <alpine.LRH.2.02.1804251702250.9428@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfJKLQ1CxPCts46KSlPJRHJI9bUIXRgK8x70TBokkjOSVfl0THl/iopA0zWEWcvTh9ZkUWjyCBS58q8m4AopiXKgZkMSiElIsc6jMB7CL7YxLrD4DXJ5E
 VIpUV74gu82glKUoDs8dzw7gUiUf/1es6qoG2Jqy+JPyG9afNY7A/ggOaZ6raFrR9WmXimVLUcLnKor2iLYwrXeYKySGxLTlQiB5oR8JBqwBrsIC9ihntqu/
 4ldJGg0aHAjrhz5ccQyiyKYKTlIQFpvH/BVLW5t67YAbA9gTnw+AWVvceBc7PPk7rO+NtDVq7HAM1nYVO/ra6vi2XgmnH6JDKfCxgXUhYe40Z4n27vHu+3wv
 Qs0gacrbQD+Y/J3KSaim1QnO/9OVCWsT9lp/V0hKFdc9LjDDa/1dxjtH5Aqg84eEHp38nGjfF4NyF91ZmHzIgELQApGSAuXpHc9+2LXI5/5TWeEYlEke/pYZ
 tsjEZBVDjYSpf10S
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018, Mikulas Patocka wrote:

> >
> > Could yo move that logic into slab_order()? It does something awfully
> > similar.
>
> But slab_order (and its caller) limits the order to "max_order" and we
> want more.
>
> Perhaps slab_order should be dropped and calculate_order totally
> rewritten?

Yes you likely need to do something creative with max_order if not with
more stuff.
