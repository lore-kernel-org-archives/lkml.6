Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC63C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B118B21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548832685;
	bh=pOSY+xpedMk6Iz1EaSQJS3fFZXt14cT4aMpnT1Rkf14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ylNJjOXcws6j00GNfwsR1DxKiEcgOWpTSN9I7Vtdk7R0aejgVJQbwZwfeJomRFWQ5
	 igmaSGI4lvbVPljmKWMC7HLXGntSdaMppJmtMwFOHLpxBgZZ6txphMJCV/Tpz3wOP4
	 8uDTmiVnTbOx93GEwlN6lHjVtQkHlXEXG/QD4iwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfA3HSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 02:18:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:59584 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbfA3HSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 02:18:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB835AC5B;
        Wed, 30 Jan 2019 07:18:01 +0000 (UTC)
Date:   Wed, 30 Jan 2019 08:17:59 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Blake Caldwell <blake.caldwell@colorado.edu>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>
Subject: Re: [LSF/MM TOPIC] NUMA remote THP vs NUMA local non-THP under
 MADV_HUGEPAGE
Message-ID: <20190130071759.GR18811@dhcp22.suse.cz>
References: <20190129234058.GH31695@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129234058.GH31695@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 29-01-19 18:40:58, Andrea Arcangeli wrote:
> Hello,
> 
> I'd like to attend the LSF/MM Summit 2019. I'm interested in most MM
> topics and it's enlightening to listen to the common non-MM topics
> too.
> 
> One current topic that could be of interest is the THP / NUMA tradeoff
> in subject.
> 
> One issue about a change in MADV_HUGEPAGE behavior made ~3 years ago
> kept floating around for the last 6 months (~12 months since it was
> initially reported as regression through an enterprise-like workload)
> and it was hot-fixed in commit
> ac5b2c18911ffe95c08d69273917f90212cf5659, but it got quickly reverted
> for various reasons.
> 
> I posted some benchmark results showing that for tasks without strong
> NUMA locality the __GFP_THISNODE logic is not guaranteed to be optimal
> (and here of course I mean even if we ignore the large slowdown with
> swap storms at allocation time that might be caused by
> __GFP_THISNODE). The results also show NUMA remote THPs help
> intrasocket as well as intersocket.
> 
> https://lkml.kernel.org/r/20181210044916.GC24097@redhat.com
> https://lkml.kernel.org/r/20181212104418.GE1130@redhat.com
> 
> The following seems the interim conclusion which I happen to be in
> agreement with Michal and Mel:
> 
> https://lkml.kernel.org/r/20181212095051.GO1286@dhcp22.suse.cz
> https://lkml.kernel.org/r/20181212170016.GG1130@redhat.com

I am definitely interested in discussing this topic and actually wanted
to propose it myself. I would add that part of the discussion was
proposing a neww memory policy that would effectively enable per-vma
node-reclaim like behavior.
-- 
Michal Hocko
SUSE Labs
