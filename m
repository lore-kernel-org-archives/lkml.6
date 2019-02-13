Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0052AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7432073D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403973AbfBML3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:29:42 -0500
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:53306 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbfBML3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:29:42 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id E1DD598A63
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 11:29:39 +0000 (UTC)
Received: (qmail 8247 invoked from network); 13 Feb 2019 11:29:39 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Feb 2019 11:29:39 -0000
Date:   Wed, 13 Feb 2019 11:29:38 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: 5.0-rc kernel hangs on early boot
Message-ID: <20190213112938.GP9565@techsingularity.net>
References: <20190213082134.GA21834@yury-thinkpad>
 <20190213111843.GA1912@brain-police>
 <20190213112141.GO9565@techsingularity.net>
 <20190213112520.GB1912@brain-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190213112520.GB1912@brain-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 11:25:21AM +0000, Will Deacon wrote:
> > Thanks Will.
> > 
> > While I agree that going OOM early is a problem and would explain why
> > the boosting logic was hit at all, it's still the case that the boosting
> > should not divide by zero. Even if the booting is broken due to a lack
> > of memory, I'd still not prefer to crash due to 1c30844d2dfe272d58c.
> 
> Yup, sorry, our previous mails crossed paths. Your patch looks sensible in
> its own right, I'm just left wondering why we're OOM so early during boot!
> 

I completely agree that it's worth pinning down both issues.

-- 
Mel Gorman
SUSE Labs
