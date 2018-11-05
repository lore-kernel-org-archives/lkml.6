Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDD4C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8B42085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8B42085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387583AbeKFCCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:02:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:54434 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387426AbeKFCCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:02:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C94CEB08D;
        Mon,  5 Nov 2018 16:41:38 +0000 (UTC)
Date:   Mon, 5 Nov 2018 17:41:35 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Kuo-Hsin Yang <vovoy@chromium.org>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4] mm, drm/i915: mark pinned shmemfs pages as unevictable
Message-ID: <20181105164135.GM4361@dhcp22.suse.cz>
References: <20181105111348.182492-1-vovoy@chromium.org>
 <20181105130209.GI4361@dhcp22.suse.cz>
 <CAEHM+4r4gRiBdRHaziiAFzwB5VD785zpUEr31zFLbx4sNUW6TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEHM+4r4gRiBdRHaziiAFzwB5VD785zpUEr31zFLbx4sNUW6TQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-11-18 22:33:13, Kuo-Hsin Yang wrote:
> On Mon, Nov 5, 2018 at 9:02 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Mon 05-11-18 19:13:48, Kuo-Hsin Yang wrote:
[...]
> > > + * @pvec: pagevec with pages to check
> > >   *
> > > - * Checks pages for evictability and moves them to the appropriate lru list.
> > > - *
> > > - * This function is only used for SysV IPC SHM_UNLOCK.
> > > + * This function is only used to move shmem pages.
> >
> > I do not really see anything that would be shmem specific here. We can
> > use this function for any LRU pages unless I am missing something
> > obscure. I would just drop the last sentence.
> 
> OK, this function should not be specific to shmem pages.
> 
> Is it OK to remove the #ifdef SHMEM surrounding check_move_unevictable_pages?

Yes, I think so.
-- 
Michal Hocko
SUSE Labs
