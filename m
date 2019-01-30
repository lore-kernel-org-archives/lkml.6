Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E619DC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B264D218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548872197;
	bh=kZOAGs6a80zAM9s1/wdZZ1rBlXtcurWtUPNVUeYsWrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IPLbMYoMJPpWANGbmF0iB/I8gmupZ/kdv8ONmh6ykH1zOr4PVpHUmtwy9peAUNf9W
	 JO/+dtSfT08rI9PBC+B7KmP8WV+U8IBvWImc1BblIkbF1VfVCf2ZKE+M/ywmGO1vIX
	 p6ZUmsXg8ublsw+xd/kxZ2vUfyYAIs/cQyvx++2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732907AbfA3SQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:16:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:51766 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727402AbfA3SQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:16:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7CA96B01B;
        Wed, 30 Jan 2019 18:16:34 +0000 (UTC)
Date:   Wed, 30 Jan 2019 19:16:30 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190130181630.GF18811@dhcp22.suse.cz>
References: <20190128151859.GO18811@dhcp22.suse.cz>
 <20190128154150.GQ50184@devbig004.ftw2.facebook.com>
 <20190128170526.GQ18811@dhcp22.suse.cz>
 <20190128174905.GU50184@devbig004.ftw2.facebook.com>
 <20190129144306.GO18811@dhcp22.suse.cz>
 <20190129145240.GX50184@devbig004.ftw2.facebook.com>
 <20190130165058.GA18811@dhcp22.suse.cz>
 <20190130170658.GY50184@devbig004.ftw2.facebook.com>
 <20190130174117.GC18811@dhcp22.suse.cz>
 <20190130175222.GA50184@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130175222.GA50184@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30-01-19 09:52:22, Tejun Heo wrote:
> On Wed, Jan 30, 2019 at 06:41:17PM +0100, Michal Hocko wrote:
> > But we are discussing the file name effectively. I do not see a long
> > term maintenance burden. Confusing? Probably yes but that is were the
> 
> Cost on user side.
> 
> > documentation would be helpful.
> 
> which is an a lot worse option with way higher total cost.

And how exactly does the cost get any smaller with a mount option. The
consumer of the API will likely not know there are two modes and check
for it to figure out how to interpret those values. Or maybe I still do
not follow how exactly is the mount option supposed to work.

-- 
Michal Hocko
SUSE Labs
