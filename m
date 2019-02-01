Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E35BC282DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242AA2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="IUEd3GXJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FJFoK3yA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbfBAOJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:09:27 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:33491 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbfBAOJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:09:26 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 758341264;
        Fri,  1 Feb 2019 09:09:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 01 Feb 2019 09:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=kh208pwU0DHoRepH3JHwazRnR9a
        3aEF0XNjNIFI4NjA=; b=IUEd3GXJ/k9uKEYr9LBZgsZ0CK3QCHH6E0bAlrLug4V
        ONOc8A2erGaRLWPCFD61ES47CdlOxsNp2139AJueSzyuTDnsbJH+Gl6YPcCuJzYx
        lQGE4qphnifqpg90s+avv+Knp5nDU2+dRPlzv3ariLgi38piOvpdbsmUliGdeU1m
        erCQJ9S7fHWf7HfO9aUj/N8fXszn6fublaQ+9OJEoICJfKQojQrz+nNeI4URIpaW
        Zp45TCqZ2b7k97ghHG4vQbJ5XPPdOUD3gWz67p/o3cpl9Igljv141Iw9+idhIiJZ
        dytIFgpUWwUz1jzTBBX0S1yRnzFzn7L5C+SHkbMFMPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=kh208p
        wU0DHoRepH3JHwazRnR9a3aEF0XNjNIFI4NjA=; b=FJFoK3yAAMjwlkttwou4Dc
        1oogG0GB1/z8YnahCoTASp98yDDpNsNECDPwOKKiUgV9a4SdrNwywMK3x/CenSC4
        CTsrsxyRd4Ule+57VsdXZrcnv8R5doD2NIny4ZzMXFC9jYoQeRk7VuEOVA1tTXd9
        Mp2rqdeOEwlRrxEE/rX9FWLnUnsIVulKOFiRPaf4ub1Fr9JuPKS56HQ2DSdefR5j
        avnxFqK1i57tbgeYQp4AbASCNBK4zIz8jnKVlPLSzcizm6HATSn1QkxjHTxXXFSe
        rQkdv2Z6bswQFAd3JnH9AC3x+Rpc0Q/pdTnzr849v7s8HMP/drt1IhaK2r99aPqQ
        ==
X-ME-Sender: <xms:EFNUXLxRhPaOdJuU0Tgfk6NFaHLiUPBPGQcFsdyHxOE00b9t-JIISA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrjeekgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgg
    gtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhr
    ohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledruddtjeenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecuvehluhhsthgvrhfuihiivgep
    td
X-ME-Proxy: <xmx:EVNUXIi-FEiGGq78XN7kGzhPgEvzRfR-3IVdFP0grPXitliVOM0O0w>
    <xmx:EVNUXHDv9sF-yGwmSKxW2-VPNAzVXBR7HT_ihWjm2JqVRsKFby3Q4g>
    <xmx:EVNUXNuIy4AN3cDjriZD3pPruPyv29igcq-mSN9x1AHQpA-qv-K2Fw>
    <xmx:FFNUXJ7MF39NRac2O6WFluDSsA0UNATsmJcnPZ3Ydj2UFdCE6HD8PQ>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 51872E409D;
        Fri,  1 Feb 2019 09:09:20 -0500 (EST)
Date:   Fri, 1 Feb 2019 15:09:18 +0100
From:   Greg KH <greg@kroah.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matthew Wilcox <willy@infradead.org>,
        Vratislav Bendel <vbendel@redhat.com>,
        Rafael Aquini <aquini@redhat.com>,
        Konstantin Khlebnikov <k.khlebnikov@samsung.com>,
        Minchan Kim <minchan@kernel.org>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 for-4.4-stable] mm: migrate: don't rely on
 __PageMovable() of newpage after unlocking it
Message-ID: <20190201140918.GB20335@kroah.com>
References: <20190131020448.072FE218AF@mail.kernel.org>
 <20190201134347.11166-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201134347.11166-1-david@redhat.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 02:43:47PM +0100, David Hildenbrand wrote:
> This is the backport for 4.4-stable.
> 
> We had a race in the old balloon compaction code before commit b1123ea6d3b3
> ("mm: balloon: use general non-lru movable page feature") refactored it
> that became visible after backporting commit 195a8c43e93d
> ("virtio-balloon: deflate via a page list") without the refactoring.
> 
> The bug existed from commit d6d86c0a7f8d ("mm/balloon_compaction: redesign
> ballooned pages management") till commit b1123ea6d3b3 ("mm: balloon: use
> general non-lru movable page feature"). commit d6d86c0a7f8d
> ("mm/balloon_compaction: redesign ballooned pages management") was
> backported to 3.12, so the broken kernels are stable kernels [3.12 - 4.7].
> 
> There was a subtle race between dropping the page lock of the newpage
> in __unmap_and_move() and checking for
> __is_movable_balloon_page(newpage).
> 
> Just after dropping this page lock, virtio-balloon could go ahead and
> deflate the newpage, effectively dequeueing it and clearing PageBalloon,
> in turn making __is_movable_balloon_page(newpage) fail.
> 
> This resulted in dropping the reference of the newpage via
> putback_lru_page(newpage) instead of put_page(newpage), leading to
> page->lru getting modified and a !LRU page ending up in the LRU lists.
> With commit 195a8c43e93d ("virtio-balloon: deflate via a page list")
> backported, one would suddenly get corrupted lists in
> release_pages_balloon():
> - WARNING: CPU: 13 PID: 6586 at lib/list_debug.c:59 __list_del_entry+0xa1/0xd0
> - list_del corruption. prev->next should be ffffe253961090a0, but was dead000000000100
> 
> Nowadays this race is no longer possible, but it is hidden behind very
> ugly handling of __ClearPageMovable() and __PageMovable().
> 
> __ClearPageMovable() will not make __PageMovable() fail, only
> PageMovable(). So the new check (__PageMovable(newpage)) will still hold
> even after newpage was dequeued by virtio-balloon.
> 
> If anybody would ever change that special handling, the BUG would be
> introduced again. So instead, make it explicit and use the information
> of the original isolated page before migration.
> 
> This patch can be backported fairly easy to stable kernels (in contrast
> to the refactoring).
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Vratislav Bendel <vbendel@redhat.com>
> Cc: Rafael Aquini <aquini@redhat.com>
> Cc: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: stable@vger.kernel.org # 3.12 - 4.7
> Fixes: d6d86c0a7f8d ("mm/balloon_compaction: redesign ballooned pages management")
> Reported-by: Vratislav Bendel <vbendel@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Rafael Aquini <aquini@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/migrate.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

What is the git commit id of this patch in Linus's tree?

thanks,

greg k-h
