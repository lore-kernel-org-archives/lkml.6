Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6DAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3C02177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547114276;
	bh=8ozcJw3V70/jjGf+5znbTC2qfaYowAqjoDFNwItU1d4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bBOZC+L4uUGBu3/OsL/QDmDDfgO86BUma4KIxqoN4rQDoE04n7MmRlxW7Ozgg/ZT3
	 K8NLOuV/VD6fEgt9fKsYuBNlPjWP5HIsaB6MXPm/b0Pnt8v7aXBszdPVuwd78byXZH
	 F+d6FiALpWgFKjzs7URzSrYh4gA2k6I6yfK4c9Qk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfAJJ5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:57:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:34416 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727825AbfAJJ5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:57:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8D836AC4B;
        Thu, 10 Jan 2019 09:57:53 +0000 (UTC)
Date:   Thu, 10 Jan 2019 10:57:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        josef@toxicpanda.com, jack@suse.cz, hughd@google.com,
        darrick.wong@oracle.com, aryabinin@virtuozzo.com, guro@fb.com,
        mgorman@techsingularity.net, shakeelb@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] mm: Reduce IO by improving algorithm of memcg
 pagecache pages eviction
Message-ID: <20190110095752.GK31793@dhcp22.suse.cz>
References: <154703479840.32690.6504699919905946726.stgit@localhost.localdomain>
 <20190109141113.GW31793@dhcp22.suse.cz>
 <e9b64635-87cf-f330-acea-0ca681a2528e@virtuozzo.com>
 <20190109171021.GY31793@dhcp22.suse.cz>
 <3d4f4c83-44c9-c6d5-8dbe-c42a47e6c2bd@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d4f4c83-44c9-c6d5-8dbe-c42a47e6c2bd@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10-01-19 12:42:02, Kirill Tkhai wrote:
[...]
> In general, I think a some time useful design is not a Bible, that nobody
> is allowed to change. We should not limit us in something, in case of this
> has a sense and may be useful. This is just a note in general.

But any semantic exported to the userspace and real application
depending on it is carved in stone for ever. And this is the case here I
am afraid. So if we really need some sort of soft unmapping or
reparenting a memory from a memcg then we really need to find a
different way. I do not see a straightforward way right now TBH.
-- 
Michal Hocko
SUSE Labs
