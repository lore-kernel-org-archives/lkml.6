Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22455C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74E121471
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74E121471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeJIAOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:14:31 -0400
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:50355 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726159AbeJIAOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:14:31 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id 26C9498AB1
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 17:01:51 +0000 (UTC)
Received: (qmail 17427 invoked from network); 8 Oct 2018 17:01:51 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.88])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Oct 2018 17:01:51 -0000
Date:   Mon, 8 Oct 2018 18:01:49 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm,numa: Remove remaining traces of rate-limiting.
Message-ID: <20181008170149.GB5819@techsingularity.net>
References: <1538824999-31230-1-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1538824999-31230-1-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2018 at 04:53:19PM +0530, Srikar Dronamraju wrote:
> With Commit efaffc5e40ae ("mm, sched/numa: Remove rate-limiting of automatic
> NUMA balancing migration"), we no more require migrate lock and its
> initialization. Its redundant. Hence remove it.
> 
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Hi Ingo, 

Can this be sent with the rest of the patches that got merged for 4.19-rc7
so they are more or less together? It's functionally harmless to delay
until the 4.20 merge window but it's a bit untidy. The mistake was mine
switching between a backport and mainline versions of the original patch.

Thanks

-- 
Mel Gorman
SUSE Labs
