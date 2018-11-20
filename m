Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B610CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841AD2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841AD2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732720AbeKTMXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:23:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730044AbeKTMXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 07:23:31 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 251E03002F74;
        Tue, 20 Nov 2018 01:56:53 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87AB6607D0;
        Tue, 20 Nov 2018 01:56:48 +0000 (UTC)
Date:   Tue, 20 Nov 2018 09:56:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        pifang@redhat.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aarcange@redhat.com,
        Mel Gorman <mgorman@suse.de>
Subject: Re: Memory hotplug softlock issue
Message-ID: <20181120015644.GA5727@MiWiFi-R3L-srv>
References: <20181115143204.GV23831@dhcp22.suse.cz>
 <20181116012433.GU2653@MiWiFi-R3L-srv>
 <20181116091409.GD14706@dhcp22.suse.cz>
 <20181119105202.GE18471@MiWiFi-R3L-srv>
 <20181119124033.GJ22247@dhcp22.suse.cz>
 <20181119125121.GK22247@dhcp22.suse.cz>
 <20181119141016.GO22247@dhcp22.suse.cz>
 <20181119173312.GV22247@dhcp22.suse.cz>
 <alpine.LSU.2.11.1811191215290.15640@eggly.anvils>
 <20181119205907.GW22247@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119205907.GW22247@dhcp22.suse.cz>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 20 Nov 2018 01:56:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/18 at 09:59pm, Michal Hocko wrote:
> On Mon 19-11-18 12:34:09, Hugh Dickins wrote:
> > I'm glad that I delayed, what I had then (migration_waitqueue instead
> > of using page_waitqueue) was not wrong, but what I've been using the
> > last couple of months is rather better (and can be put to use to solve
> > similar problems in collapsing pages on huge tmpfs. but we don't need
> > to get into that at this time): put_and_wait_on_page_locked().
> > 
> > What I have not yet done is verify it on latest kernel, and research
> > the interested Cc list (Linus and Tim Chen come immediately to mind),
> > and write the commit comment. I have some testing to do on the latest
> > kernel today, so I'll throw put_and_wait_on_page_locked() in too,
> > and post tomorrow I hope.
> 
> Cool, it seems that Baoquan has a reliable test case to trigger the
> pathological case.

Yes. I will test Hugh's patch.

