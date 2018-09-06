Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9B8C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F94205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F94205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeIFRU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:20:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:55186 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728736AbeIFRU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:20:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0183DB015;
        Thu,  6 Sep 2018 12:45:05 +0000 (UTC)
Date:   Thu, 6 Sep 2018 14:45:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     akpm@linux-foundation.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        mpe@ellerman.id.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH V2 2/4] mm: Add get_user_pages_cma_migrate
Message-ID: <20180906124504.GW14951@dhcp22.suse.cz>
References: <20180906054342.25094-1-aneesh.kumar@linux.ibm.com>
 <20180906054342.25094-2-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906054342.25094-2-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-09-18 11:13:40, Aneesh Kumar K.V wrote:
> This helper does a get_user_pages_fast and if it find pages in the CMA area
> it will try to migrate them before taking page reference. This makes sure that
> we don't keep non-movable pages (due to page reference count) in the CMA area.
> Not able to move pages out of CMA area result in CMA allocation failures.

Again, there is no user so it is hard to guess the intention completely.
There is no documentation to describe the expected context and
assumptions about locking etc.

As noted in the previous email. You should better describe why you are
bypassing hugetlb pools. I assume that the reason is to guarantee a
forward progress because those might be sitting in the CMA pools
already, right?
-- 
Michal Hocko
SUSE Labs
