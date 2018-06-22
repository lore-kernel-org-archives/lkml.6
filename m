Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEECCC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A368A24277
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A368A24277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbeFVNKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:10:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:52042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbeFVNKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:10:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 75E16ACF3;
        Fri, 22 Jun 2018 13:10:14 +0000 (UTC)
Date:   Fri, 22 Jun 2018 15:10:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     jing xia <jing.xia.mail@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: dm bufio: Reduce dm_bufio_lock contention
Message-ID: <20180622131013.GA10465@dhcp22.suse.cz>
References: <20180615073201.GB24039@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806150724260.15022@file01.intranet.prod.int.rdu2.redhat.com>
 <20180615115547.GH24039@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806150832100.26650@file01.intranet.prod.int.rdu2.redhat.com>
 <20180615130925.GI24039@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806181003560.4201@file01.intranet.prod.int.rdu2.redhat.com>
 <20180619104312.GD13685@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806191228110.25656@file01.intranet.prod.int.rdu2.redhat.com>
 <20180622090151.GS10465@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806220828040.8072@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1806220828040.8072@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-06-18 08:44:52, Mikulas Patocka wrote:
> On Fri, 22 Jun 2018, Michal Hocko wrote:
[...]
> > Why? How are you going to audit all the callers that the behavior makes
> > sense and moreover how are you going to ensure that future usage will
> > still make sense. The more subtle side effects gfp flags have the harder
> > they are to maintain.
> 
> I did audit them - see the previous email in this thread: 
> https://www.redhat.com/archives/dm-devel/2018-June/thread.html

I do not see any mention about throttling expectations for those users.
You have focused only on the allocation failure fallback AFAIR
-- 
Michal Hocko
SUSE Labs
