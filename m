Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B6EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BACF2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u5BGJ8BL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfBZTHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:07:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56138 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbfBZTHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fzPfbX4O9+ukKDctqeu2GuWRrlJzV6NaLJxsLRKGzcQ=; b=u5BGJ8BLdn94aNl1UZVCCFSfk
        sydmXIbRj0G9lwFiiXfl+s8fQL1XI4uosccGXfOnPZIHKtTJtYHhPDWBM7m6Gs0waUuD7wC9bAfWw
        hC9cI3BnNWUN4VbxIeYWC12ckeRyjMexj43sjzQZF7wKyP4Theqc7GK0idL2Vs/X2cvN2Qmuo9jza
        bVcgq5dcqunnbNCrRcyDaUD0M/tg/NXee+uYMVPOFBdQM8kXRvb73RfmqpDArsFR5kNTiJm/PTx5w
        JtHQW+Nqf8ixqSifKXPp7IKhAM1B92JfbSbZbVUME6gn19ZL+pMnq26g81qZHpiJH7nQF1Xu34g26
        83mrZcfbA==;
Received: from [188.207.104.89] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyi4C-0008FC-8y; Tue, 26 Feb 2019 19:07:00 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D85AB984351; Tue, 26 Feb 2019 20:06:58 +0100 (CET)
Date:   Tue, 26 Feb 2019 20:06:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Len Brown <lenb@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 07/14] powercap/intel_rapl: Simplify rapl_find_package()
Message-ID: <20190226190658.GS2861@worktop.programming.kicks-ass.net>
References: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
 <4dd94a34999d6db4ced7a0759c02f7cd93729dc4.1551160674.git.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dd94a34999d6db4ced7a0759c02f7cd93729dc4.1551160674.git.len.brown@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 01:20:05AM -0500, Len Brown wrote:
> -static struct rapl_package *find_package_by_id(int id)
> +static struct rapl_package *rapl_find_package(int cpu)
>  {
> +	int id = topology_physical_package_id(cpu);
>  	struct rapl_package *rp;

Which you'll change to topology_physical_die_id() in the next patch.

If you respin the series again, could we pick a better name?
