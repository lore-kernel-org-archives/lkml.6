Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12420C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D985C2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D985C2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeJ2ToM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:44:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbeJ2ToM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:44:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6BBE23082137;
        Mon, 29 Oct 2018 10:56:03 +0000 (UTC)
Received: from sky.random (ovpn-120-69.rdu2.redhat.com [10.10.120.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB6B25D756;
        Mon, 29 Oct 2018 10:56:02 +0000 (UTC)
Date:   Mon, 29 Oct 2018 06:56:01 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Balbir Singh <bsingharora@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
Message-ID: <20181029105601.GB3823@redhat.com>
References: <20180925120326.24392-1-mhocko@kernel.org>
 <20180925120326.24392-2-mhocko@kernel.org>
 <20181029051752.GB16399@350D>
 <20181029090035.GE32673@dhcp22.suse.cz>
 <20181029094253.GC16399@350D>
 <20181029100834.GG32673@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029100834.GG32673@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 29 Oct 2018 10:56:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Oct 29, 2018 at 11:08:34AM +0100, Michal Hocko wrote:
> This seems like a separate issue which should better be debugged. Please
> open a new thread describing the problem and the state of the node.

Yes, in my view it should be evaluated separately too, because it's
overall less concerning: __GFP_THISNODE there can only be set by the
root user there. So it has a chance to be legitimate behavior
there. Let's focus on solving the __GFP_THISNODE that any user in the
system can set (not only root) and cause severe and unexpected swap
storms or slowdowns to all other processes run by other users.

ls -l /sys/kernel/mm/hugepages/*/nr_hugepages

(and boot command line)

Thanks,
Andrea
