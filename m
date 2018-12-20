Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048B7C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D516521906
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389585AbeLTUbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:31:31 -0500
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:35283 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732267AbeLTUbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:31:31 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 74DA6B882E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 20:31:29 +0000 (GMT)
Received: (qmail 19325 invoked from network); 20 Dec 2018 20:31:29 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Dec 2018 20:31:29 -0000
Date:   Thu, 20 Dec 2018 20:31:27 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        torvalds@linux-foundation.org, Michal Hocko <mhocko@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/14] mm, migrate: Immediately fail migration of a page
 with no migration handler
Message-ID: <20181220203127.GB31517@techsingularity.net>
References: <20181214230310.572-1-mgorman@techsingularity.net>
 <20181214230310.572-7-mgorman@techsingularity.net>
 <CAHbLzko6jXSikw-4LQXi6KfNR9=U4XJnB_OaaZ4XcNHUj4NLUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAHbLzko6jXSikw-4LQXi6KfNR9=U4XJnB_OaaZ4XcNHUj4NLUQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 11:44:57AM -0800, Yang Shi wrote:
> On Fri, Dec 14, 2018 at 3:03 PM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > Pages with no migration handler use a fallback hander which sometimes
> > works and sometimes persistently fails such as blockdev pages. Migration
> 
> A minor correction. The above statement sounds not accurate anymore
> since Jan Kara had patch series (blkdev: avoid migration stalls for
> blkdev pages) have blockdev use its own migration handler.
> 

I'm aware given that I reviewed that series. The statement was correct
at the time of writing. I'll alter the example when rebased on top of
Jan's work.

-- 
Mel Gorman
SUSE Labs
