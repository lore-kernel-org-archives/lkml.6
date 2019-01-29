Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F24C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C730520989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548773567;
	bh=pIvkSIY5HLdqWxlSiqCqaxZ0p0e2iM64/RJDf/nXUdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CF++6ICQhHpW/z1VXMEjJEi94pDtdgRJPNZ286VIz5YvtUTnNeZJE9TKNzjLLDc8w
	 cXSfHDUAl+fnjCRrqLj51ti7rFTuD+8fefmQm70HHPufRHivfs2bTgUctEu4fV4dpz
	 lVDp809CDKmYgjMHeIBQb9F3dSXO0qNgMPYbrOuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfA2Owq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:52:46 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40684 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfA2Owp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 09:52:45 -0500
Received: by mail-yw1-f68.google.com with SMTP id g194so8271607ywe.7;
        Tue, 29 Jan 2019 06:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zQdBRqPFHOQNaO1SDGHuI8AHS8ubhF0Kp7ZKbPRa6WM=;
        b=Dz35RfkmFlIAefYXONkJks2DWh4gCYSnDKx7Ic9HCprDFYX5Ou5vbuEIkXMn+z+fVO
         JlHPuKDsGHYaZ5pZSVsoIO7EAEa11SntplExSN4clqxj1CByxBGlYVrJST4PezDYw34n
         Vc/jMONPC/0IrDFDJG3YbY7XtYxPITE6fLy2D7OpGo1S1N/Z/E02SXKASbQoaIFKVk7G
         gBWy0pe9nZYbE5UcQFeAvBwRLg+/EDPeW4VWsHdPRYpsNKmZdE398QzmsTJKW9nGvl+i
         92Mpet2l+ATxjKuy62Xea++iKrZ7k8T3k3Rk3Aj5HsH1IS3R+V/R7YoWg5HgP5Pd274u
         s6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zQdBRqPFHOQNaO1SDGHuI8AHS8ubhF0Kp7ZKbPRa6WM=;
        b=FTHzog2ib7550f0duCHqT+KZG9OEfq2v5eLQtz0MJUtRIT2SoanVatYepV0Lnmkce/
         5vgEF5iWP+8uBBOvAIYL5jH/CbkTfI/8MU39FwfgictCBq6laFM2bbCAdgsL+IUoK3a7
         1ZEJUUwr5b8dLXPmuy3BQtVLCNAfIooQeeVoa57dub3/tlDYfow1IkjbYlLTSQl2Wqp/
         3VBaxIj5Y8XBA+DHl8PSzhlXzdf80BV93jTcNPJYeMbI1cmxAhMPdNiYiXlyH1EYDaGo
         d3UGW+rRVvM3JufJgJrLzJlmchw7ys0AmCUGt0oYLX6jGT5FJtAGSjnd58uC+Pj1YONI
         6ebg==
X-Gm-Message-State: AJcUukftVLeHku10jBZOCNU0cikwY2/h6Vd/FDHAYNZPF9Tt0GZ4XBrp
        b9nntRVKy130DRRk+0QV9Tc=
X-Google-Smtp-Source: ALg8bN4aink6rsz+TOQ2if0OOpZyL9ApwVWIWHdHrCpHq2n7sxOckKcbDvWJxHmW4VOUUW11u4088w==
X-Received: by 2002:a81:8a07:: with SMTP id a7mr24626349ywg.403.1548773564329;
        Tue, 29 Jan 2019 06:52:44 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:19ad])
        by smtp.gmail.com with ESMTPSA id d4sm13949191ywe.104.2019.01.29.06.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 06:52:43 -0800 (PST)
Date:   Tue, 29 Jan 2019 06:52:40 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190129145240.GX50184@devbig004.ftw2.facebook.com>
References: <20190125182808.GL50184@devbig004.ftw2.facebook.com>
 <20190128125151.GI18811@dhcp22.suse.cz>
 <20190128142816.GM50184@devbig004.ftw2.facebook.com>
 <20190128145210.GM18811@dhcp22.suse.cz>
 <20190128145407.GP50184@devbig004.ftw2.facebook.com>
 <20190128151859.GO18811@dhcp22.suse.cz>
 <20190128154150.GQ50184@devbig004.ftw2.facebook.com>
 <20190128170526.GQ18811@dhcp22.suse.cz>
 <20190128174905.GU50184@devbig004.ftw2.facebook.com>
 <20190129144306.GO18811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129144306.GO18811@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jan 29, 2019 at 03:43:06PM +0100, Michal Hocko wrote:
> All memcg events are represented non-hierarchical AFAICS
> memcg_memory_event() simply accounts at the level when it happens. Or do
> I miss something? Or are you talking about .events files for other
> controllers?

Yeah, cgroup.events and .stat files as some of the local stats would
be useful too, so if we don't flip memory.events we'll end up with sth
like cgroup.events.local, memory.events.tree and memory.stats.local,
which is gonna be hilarious.

If you aren't willing to change your mind, the only option seems to be
introducing a mount option to gate the flip and additions of local
files.  Most likely, userspace will enable the option by default
everywhere, so the end result will be exactly the same but I guess
it'll better address your concern.

Thanks.

-- 
tejun
