Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B6AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE45F206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE45F206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeIDWLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:11:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:45086 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726052AbeIDWLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:11:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 80EA6AF3A;
        Tue,  4 Sep 2018 17:45:44 +0000 (UTC)
Date:   Tue, 4 Sep 2018 19:45:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        jing xia <jing.xia.mail@gmail.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: dm bufio: Reduce dm_bufio_lock contention
Message-ID: <20180904174543.GQ14951@dhcp22.suse.cz>
References: <20180612212007.GA22717@redhat.com>
 <alpine.LRH.2.02.1806131001250.15845@file01.intranet.prod.int.rdu2.redhat.com>
 <CAN=25QMQiJ7wvfvYvmZnEnrkeb-SA7_hPj+N2RnO8y-aVO8wOQ@mail.gmail.com>
 <20180614073153.GB9371@dhcp22.suse.cz>
 <CAN=25QNrENVFbb9UAAAJJqKsEeMY+qNs5cQA4EGwgB2dMYTZug@mail.gmail.com>
 <alpine.LRH.2.02.1809031816120.27063@file01.intranet.prod.int.rdu2.redhat.com>
 <20180904070824.GH14951@dhcp22.suse.cz>
 <20180904151844.GB10112@redhat.com>
 <20180904160732.GO14951@dhcp22.suse.cz>
 <alpine.LRH.2.02.1809041328320.8875@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1809041328320.8875@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-09-18 13:30:44, Mikulas Patocka wrote:
> 
> 
> On Tue, 4 Sep 2018, Michal Hocko wrote:
> 
> > Regarding other other workloads. AFAIR the problem was due to the
> > wait_iff_congested in the direct reclaim. And I've been arguing that
> > special casing __GFP_NORETRY is not a propoer way to handle that case.
> > We have PF_LESS_THROTTLE to handle cases where the caller cannot be
> > really throttled because it is a part of the congestion control. I dunno
> > what happened in that regards since then though.
> > -- 
> > Michal Hocko
> > SUSE Labs
> 
> So, could you take this patch https://patchwork.kernel.org/patch/10505523/ 
> and commit it to the kernel?
> 
> You agreed with that patch, but you didn't commit it.

Because I do not maintain any tree that Linus pulls from. You need to
involve Andrew Morton to get this to the mm tree and then to Linus.
-- 
Michal Hocko
SUSE Labs
