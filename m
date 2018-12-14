Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F9DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F36206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544808726;
	bh=L+7lIXikbdRSdx2/zxt1KwLwhpjTYDDqDgES5Raw/b4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0pHx7JxgsTQjXPj7cRG7Jvyrh7AHoqj+xxpvp6M2pKk8Es27GoLW/Y75X4CqWgLVO
	 9mqmq0xRiuBOydoU3oiWVsnSpZU4gsciJXDcRtr7Wa6xT/VyYJWvWWpOivotx06K87
	 nWUOb36u9jCJ9h3Hi5fVBIWwu0Rn7rqQb39iPI40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbeLNRcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:32:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:59764 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726662AbeLNRcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:32:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E33BAEB4;
        Fri, 14 Dec 2018 17:32:01 +0000 (UTC)
Date:   Fri, 14 Dec 2018 18:31:59 +0100
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
Message-ID: <20181214173159.GK5343@dhcp22.suse.cz>
References: <20181211132645.31053-1-mhocko@kernel.org>
 <201812150151.vUxN4ozA%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201812150151.vUxN4ozA%fengguang.wu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 15-12-18 01:13:53, kbuild test robot wrote:
> Hi Michal,
> 
> I love your patch! Yet something to improve:

Could you point the bot to v3 please? http://lkml.kernel.org/r/20181213092221.27270-1-mhocko@kernel.org
-- 
Michal Hocko
SUSE Labs
