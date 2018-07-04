Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A8DC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F077F208A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F077F208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeGDMvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:51:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:49280 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751075AbeGDMvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:51:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04717ACF1;
        Wed,  4 Jul 2018 12:51:22 +0000 (UTC)
Date:   Wed, 4 Jul 2018 14:51:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] m68k: switch to MEMBLOCK + NO_BOOTMEM
Message-ID: <20180704125121.GO22503@dhcp22.suse.cz>
References: <1530685696-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1530685696-14672-4-git-send-email-rppt@linux.vnet.ibm.com>
 <CAMuHMdWEHSz34bN-U3gHW972w13f_Jrx_ObEsP3w8XZ1Gx65OA@mail.gmail.com>
 <20180704075410.GF22503@dhcp22.suse.cz>
 <89f48f7a-6cbf-ac9a-cacc-cd3ca79f8c66@suse.cz>
 <20180704123627.GM22503@dhcp22.suse.cz>
 <20180704124335.GE4352@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704124335.GE4352@rapoport-lnx>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-07-18 15:43:35, Mike Rapoport wrote:
> On Wed, Jul 04, 2018 at 02:36:27PM +0200, Michal Hocko wrote:
[...]
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 03d48d8835ba..2acec4033389 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -227,7 +227,8 @@ phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
> >  		 * so we use WARN_ONCE() here to see the stack trace if
> >  		 * fail happens.
> >  		 */
> > -		WARN_ONCE(1, "memblock: bottom-up allocation failed, memory hotunplug may be affected\n");
> > +		WARN_ONCE(IS_ENABLED(CONFIG_MEMORY_HOTREMOVE),
> > +					"memblock: bottom-up allocation failed, memory hotremove may be affected\n");
> 
> nit: isn't the warning indented too much?

this is what vim did for me. The string doesn't fit into 80 even if I
indented it to the first bracket. If you feel strongly I can do that
though.

-- 
Michal Hocko
SUSE Labs
