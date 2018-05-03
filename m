Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbeECMDp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:03:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:42098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbeECMDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:03:44 -0400
Date: Thu, 3 May 2018 14:03:38 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Matthew Wilcox <willy6545@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Julia Lawall <julia.lawall@lip6.fr>, linux-mm@kvack.org, cl@linux.com,
        Jan Kara <jack@suse.cz>, matthew@wil.cx, x86@kernel.org,
        luto@amacapital.net, martin.petersen@oracle.com, jthumshirn@suse.de,
        broonie@kernel.org, Juergen Gross <jgross@suse.com>,
        linux-spi@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM TOPIC NOTES] x86 ZONE_DMA love
Message-ID: <20180503120338.GG4535@dhcp22.suse.cz>
References: <20180426215406.GB27853@wotan.suse.de>
 <20180427053556.GB11339@infradead.org>
 <20180427161456.GD27853@wotan.suse.de>
 <20180428084221.GD31684@infradead.org>
 <20180428185514.GW27853@wotan.suse.de>
 <CAFhKne8u7KcBkpgiQ0fFZyh5_EorfY-_MJJaEYk3feCOd9LsRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFhKne8u7KcBkpgiQ0fFZyh5_EorfY-_MJJaEYk3feCOd9LsRQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 28-04-18 19:10:47, Matthew Wilcox wrote:
> Another way we could approach this is to get rid of ZONE_DMA. Make GFP_DMA
> a flag which doesn't map to a zone. Rather, it redirects to a separate
> allocator. At boot, we hand all memory under 16MB to the DMA allocator. The
> DMA allocator can have a shrinker which just hands back all the memory once
> we're under memory pressure (if it's never had an allocation).

Yeah, that was exactly the plan with the CMA allocator... We wouldn't
need the shrinker because who cares about 16MB which is not usable
anyway.
-- 
Michal Hocko
SUSE Labs
