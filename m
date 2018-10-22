Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA04C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EB120658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23EB120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeJVPdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 11:33:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:50462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727384AbeJVPdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 11:33:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1FDBDAE55;
        Mon, 22 Oct 2018 07:16:26 +0000 (UTC)
Date:   Mon, 22 Oct 2018 09:16:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        punit.agrawal@arm.com, will.deacon@arm.com, Steven.Price@arm.com,
        steve.capper@arm.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com
Subject: Re: [PATCH V2 1/5] mm/hugetlb: Enable PUD level huge page migration
Message-ID: <20181022071625.GS18839@dhcp22.suse.cz>
References: <1539316799-6064-1-git-send-email-anshuman.khandual@arm.com>
 <1539316799-6064-2-git-send-email-anshuman.khandual@arm.com>
 <20181019080959.GL18839@dhcp22.suse.cz>
 <7d32fcdc-1ee3-7666-3b33-eda14ca8b380@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d32fcdc-1ee3-7666-3b33-eda14ca8b380@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-10-18 08:31:05, Anshuman Khandual wrote:
> On 10/19/2018 01:39 PM, Michal Hocko wrote:
> > I would probably fold it into the one which defines arch specific hook.
> 
> Hmm but that may be like doing two functionality changes together. Adding one
> more conditional check and at the same time wrapping it over with a new name
> which is part of a new scheme. I would suggest keeping the patches separate.

I will surely not insist. If you think it is better this way then no
objections from me of course.

-- 
Michal Hocko
SUSE Labs
