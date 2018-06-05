Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbeFEJ5Z convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:57:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:53898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751506AbeFEJ5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:57:23 -0400
Date: Tue, 5 Jun 2018 11:57:21 +0200
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Make elf2ecoff work on 64bit host machines
Message-Id: <20180605115721.a61f503af000e9c2b6ad1073@suse.de>
In-Reply-To: <20180604221404.u55nor4sad6cfamb@pburton-laptop>
References: <20180604081825.11995-1-tbogendoerfer@suse.de>
        <20180604221404.u55nor4sad6cfamb@pburton-laptop>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jun 2018 15:14:04 -0700
Paul Burton <paul.burton@mips.com> wrote:

> > +#include <stdint.h>
> 
> Could you move the #include <stdint.h> into ecoff.h? Since ecoff.h
> itself makes use of these types. I know the end result will be the same,
> but if anything else were ever to include ecoff.h then having the right
> includes there could make that easier.

as elf2ecoff.c uses these types, too, I'll leave the include and add an
additional one in ecoff.h.

> >			printf
> > -			    ("Section %d: %s phys %lx  size %lx	 file offset %lx\n",
> > +			    ("Section %d: %s phys %"PRIx32"  size %"PRIx32"	 file offset %x\n",
> 
> The offset (s_scnptr) format should probably be PRIx32 as well.

correct.

> I know you didn't introduce it but I think the tab before "file" in the
> string would be better represented in source using \t rather than the
> tab character itself, so perhaps you could change that for clarify here
> which would also avoid making the line so long.

ok.

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
