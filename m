Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F32EC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E002084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544630244;
	bh=TsmjnDlclGwDWWADF2+l23bJpUG37LPMt3S5mQYGVrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sJBhw9LRxYaM3t8LhitAiF9dUeg+kNJWe2x7/FB1WidqaypA+otFXkadThWpFi4FA
	 JtcdOjAvNKT6hNmqJXuTYyaieOCRv6w3tlcIcCHb1WiVG2xTqmqNkh8psH/7wsI/Sk
	 Vp9nrSD67MvcX8pM/EvEezCmkBrTk8GyAEOK3/vg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E002084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeLLP5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:57:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:43594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726358AbeLLP5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:57:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA285AFB6;
        Wed, 12 Dec 2018 15:57:20 +0000 (UTC)
Date:   Wed, 12 Dec 2018 16:57:15 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Liu Bo <bo.liu@linux.alibaba.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, memcg: fix reclaim deadlock with writeback
Message-ID: <20181212155715.GU1286@dhcp22.suse.cz>
References: <20181211132645.31053-1-mhocko@kernel.org>
 <201812122333.JV0874ol%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201812122333.JV0874ol%fengguang.wu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-12-18 23:33:10, kbuild test robot wrote:
> Hi Michal,
> 
> I love your patch! Yet something to improve:

Well, I hate it ;) (like all obviously broken patches) Sorry this is a
typo. v2 sent out

Thanks!
-- 
Michal Hocko
SUSE Labs
