Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B49EC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B5C27B79
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B5C27B79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753974AbeF2Hbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:31:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:47464 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751594AbeF2Hbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:31:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D409CAE61;
        Fri, 29 Jun 2018 07:31:49 +0000 (UTC)
Date:   Fri, 29 Jun 2018 09:31:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Cannon Matthews <cannonmatthews@google.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        nyc@holomorphy.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andres Lagar-Cavilla <andreslc@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH] mm: hugetlb: yield when prepping struct pages
Message-ID: <20180629073146.GB13860@dhcp22.suse.cz>
References: <20180627214447.260804-1-cannonmatthews@google.com>
 <20180628112139.GC32348@dhcp22.suse.cz>
 <CAJfu=Uc8zkN1fc73_UtiREW061xakrnMNP27oV5i3AreP1XS+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfu=Uc8zkN1fc73_UtiREW061xakrnMNP27oV5i3AreP1XS+w@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-06-18 15:16:46, Cannon Matthews wrote:
> Thanks for the quick turnaround.
> 
> Good to know about the how the 2M code path differs, I have been
> trying to trace through some of this and it's easy to get lost between
> which applies to which size.

Yeah, GB hugetlb pages implementation has been hacked into the existing
hugetlb code in a quite ugly way. We have done some cleanups since then
but there is still a lot of room for improvements.
-- 
Michal Hocko
SUSE Labs
