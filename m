Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB80C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB364218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548870532;
	bh=AXR0llYBRGSYiE2vpUusekrrRCdQMUUkAr120z4LWrI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=oCMuGuN4wbwtvxtY3dsaCTP9XkKUCjjCmsWAChNL6iuc3VgRNA0r+jq2xYH9ah4mR
	 fzWfjFOb1JFQt2IGjQnWRO80kTnGdL++Xgn3nA1hMacfN/rq6Uw6FSNE41rN3QvCRz
	 PClTmF9zXwEwB8bqXSzPbQeMmZ+Q8S5Ehq00Lr3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbfA3Rsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:48:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:45740 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728479AbfA3Rsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:48:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77E1DAF96;
        Wed, 30 Jan 2019 17:48:48 +0000 (UTC)
Date:   Wed, 30 Jan 2019 18:48:47 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Subject: [LSF/MM TOPIC] memory reclaim with NUMA rebalancing
Message-ID: <20190130174847.GD18811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I would like to propose the following topic for the MM track. Different
group of people would like to use NVIDMMs as a low cost & slower memory
which is presented to the system as a NUMA node. We do have a NUMA API
but it doesn't really fit to "balance the memory between nodes" needs.
People would like to have hot pages in the regular RAM while cold pages
might be at lower speed NUMA nodes. We do have NUMA balancing for
promotion path but there is notIhing for the other direction. Can we
start considering memory reclaim to move pages to more distant and idle
NUMA nodes rather than reclaim them? There are certainly details that
will get quite complicated but I guess it is time to start discussing
this at least.
-- 
Michal Hocko
SUSE Labs
