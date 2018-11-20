Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0D7C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5F3206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5F3206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbeKUAlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:41:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbeKUAlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:41:47 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 440D036809;
        Tue, 20 Nov 2018 14:12:27 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DBFF648B9;
        Tue, 20 Nov 2018 14:12:24 +0000 (UTC)
Date:   Tue, 20 Nov 2018 22:12:21 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        pifang@redhat.com, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aarcange@redhat.com,
        Mel Gorman <mgorman@suse.de>
Subject: Re: Memory hotplug softlock issue
Message-ID: <20181120141221.GA7386@MiWiFi-R3L-srv>
References: <20181119125121.GK22247@dhcp22.suse.cz>
 <20181119141016.GO22247@dhcp22.suse.cz>
 <20181119173312.GV22247@dhcp22.suse.cz>
 <alpine.LSU.2.11.1811191215290.15640@eggly.anvils>
 <20181119205907.GW22247@dhcp22.suse.cz>
 <20181120015644.GA5727@MiWiFi-R3L-srv>
 <alpine.LSU.2.11.1811192127130.2848@eggly.anvils>
 <3f1a82a8-f2aa-ac5e-e6a8-057256162321@suse.cz>
 <20181120135803.GA3369@MiWiFi-R3L-srv>
 <20181120140524.GI22247@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120140524.GI22247@dhcp22.suse.cz>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 20 Nov 2018 14:12:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/18 at 03:05pm, Michal Hocko wrote:
> > Yes, I applied Hugh's patch 8 hours ago, then our QE Ping operated on
> > that machine, after many times of hot removing/adding, the endless
> > looping during mirgrating is not seen any more. The test result for
> > Hugh's patch is positive. I even suggested Ping increasing the memory
> > pressure to "stress -m 250", it still succeeded to offline and remove.
> > 
> > So I think this patch works to solve the issue. Thanks a lot for your
> > help, all of you. 
> 
> This is a great news! Thanks for your swift feedback. I will go and try
> to review Hugh's patch soon.

Yeah. Thanks a lot for your help on debugging and narrowing down
to position the cause of the issue, Michal, really appreciated!

> > Meanwhile we found sometime onlining page may not add back all memory
> > blocks on one memory board, then hot removing/adding them will cause
> > kernel panic. I will investigate further and collect information, see if
> > it's a kernel issue or udev issue.
> 
> It would be great to get a report in a new email thread.

Sure, will do after reproducing and inforamtion arranging.

Thanks
Baoquan
