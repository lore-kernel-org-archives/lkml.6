Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F332C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C59B214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C59B214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJIQpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:45:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:53278 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725927AbeJIQpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:45:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6E2BCAF02;
        Tue,  9 Oct 2018 09:29:41 +0000 (UTC)
Date:   Tue, 9 Oct 2018 11:29:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Arun KS <arunks@codeaurora.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        vbabka@suse.cz, iamjoonsoo.kim@lge.com, gregkh@linuxfoundation.org,
        osalvador@suse.de, malat@debian.org,
        kirill.shutemov@linux.intel.com, jrdr.linux@gmail.com,
        yasu.isimatu@gmail.com, mgorman@techsingularity.net,
        aaron.lu@intel.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, vatsa@codeaurora.org,
        vinmenon@codeaurora.org, getarunks@gmail.com
Subject: Re: [PATCH v5 1/2] memory_hotplug: Free pages as higher order
Message-ID: <20181009092938.GH8528@dhcp22.suse.cz>
References: <1538727006-5727-1-git-send-email-arunks@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538727006-5727-1-git-send-email-arunks@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 05-10-18 13:40:05, Arun KS wrote:
> When free pages are done with higher order, time spend on
> coalescing pages by buddy allocator can be reduced. With
> section size of 256MB, hot add latency of a single section
> shows improvement from 50-60 ms to less than 1 ms, hence
> improving the hot add latency by 60%. Modify external
> providers of online callback to align with the change.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks for your patience with all the resubmission.
-- 
Michal Hocko
SUSE Labs
