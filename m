Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6D1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B9D2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B9D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbeIFWpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:45:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:33536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728354AbeIFWpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:45:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84669ACBB;
        Thu,  6 Sep 2018 18:08:56 +0000 (UTC)
Date:   Thu, 6 Sep 2018 20:08:54 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 1/2] mm: Move page struct poisoning to
 CONFIG_DEBUG_VM_PAGE_INIT_POISON
Message-ID: <20180906180854.GG14951@dhcp22.suse.cz>
References: <20180905211041.3286.19083.stgit@localhost.localdomain>
 <20180905211328.3286.71674.stgit@localhost.localdomain>
 <20180906054735.GJ14951@dhcp22.suse.cz>
 <0c1c36f7-f45a-8fe9-dd52-0f60b42064a9@intel.com>
 <20180906151336.GD14951@dhcp22.suse.cz>
 <CAKgT0UfiKWZO6hyjc1RpRTgD+CvM=KnbYokSueLFi7X5h+GMKQ@mail.gmail.com>
 <4f154937-118c-96cf-cf8e-c95a2ca68d44@microsoft.com>
 <c5dc8ef6-587d-e286-af80-568094a65007@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5dc8ef6-587d-e286-af80-568094a65007@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-09-18 10:07:51, Dave Hansen wrote:
> On 09/06/2018 09:12 AM, Pasha Tatashin wrote:
> > 
> > I do not want to make this feature less tested. Poisoning memory allowed
> > us to catch corner case bugs like these:
> > 
> > ab1e8d8960b68f54af42b6484b5950bd13a4054b
> > mm: don't allow deferred pages with NEED_PER_CPU_KM
> > 
> > e181ae0c5db9544de9c53239eb22bc012ce75033
> > mm: zero unavailable pages before memmap init
> > 
> > And several more that were fixed by other people.
> 
> Just curious: were these found in the wild, or by a developer doing
> normal development having turned on lots of debug options?

Some of those were 0day AFAIR but my memory is quite dim. Pavel will
know better. The bottom line is, however, that those bugs depend on
strange or unexpected memory configurations or HW which is usually
deployed outside of developers machine pool. So more people have this
enabled the more likely we hit all those strange corner cases nobody
even thought of.

-- 
Michal Hocko
SUSE Labs
