Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAFBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89B32148D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550733959;
	bh=B3mMy3bnM3mCBp9+yXEjBmHD3xO/bIZw+20h8wpJDbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f5pXGVaRdIq2MjBjPPEe1MbQ5RwbgkNAeszAarZ4W5TnyiS2bwfdWChydFBJ2Avez
	 rzDtZhTFXjtxt30OP8zNMM+prSIght6Wt8tLtKS2a8cAYekbWxUTLxE+zsbr+cvoB/
	 mh5Q1NW6tWPei85o2iFR9VXYTUglQIkMwztA4+nU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfBUHZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 02:25:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:34644 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726419AbfBUHZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 02:25:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B2164AF15;
        Thu, 21 Feb 2019 07:25:55 +0000 (UTC)
Date:   Thu, 21 Feb 2019 08:25:50 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Oscar Salvador <OSalvador@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, lkp@01.org
Subject: Re: [LKP] [RFC PATCH] mm, memory_hotplug: fix off-by-one in
 is_pageblock_removable
Message-ID: <20190221072550.GF4525@dhcp22.suse.cz>
References: <20190218052823.GH29177@shao2-debian>
 <20190218181544.14616-1-mhocko@kernel.org>
 <20190220125732.GB4525@dhcp22.suse.cz>
 <e3fc1372-f3bb-d734-9e3f-d715b85d781d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3fc1372-f3bb-d734-9e3f-d715b85d781d@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-02-19 11:18:07, Rong Chen wrote:
> Hi,
> 
> The patch can fix the issue for me.

Thanks for the confirmation!
-- 
Michal Hocko
SUSE Labs
