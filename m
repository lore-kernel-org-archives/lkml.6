Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B288CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CC22075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CC22075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeIEL0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:26:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:38800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbeIEL0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:26:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5691BADE2;
        Wed,  5 Sep 2018 06:57:49 +0000 (UTC)
Date:   Wed, 5 Sep 2018 08:57:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, linux-rdma@vger.kernel.org,
        Matan Barak <matanb@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Dimitri Sivanich <sivanich@sgi.com>
Subject: Re: [PATCH v6 1/2] mm: migration: fix migration of huge PMD shared
 pages
Message-ID: <20180905065746.GY14951@dhcp22.suse.cz>
References: <20180829183906.GF10223@dhcp22.suse.cz>
 <20180829211106.GC3784@redhat.com>
 <20180830105616.GD2656@dhcp22.suse.cz>
 <20180830140825.GA3529@redhat.com>
 <20180830161800.GJ2656@dhcp22.suse.cz>
 <20180830165751.GD3529@redhat.com>
 <e0c0c966-6706-4ca2-4077-e79322756a9b@oracle.com>
 <20180830183944.GE3529@redhat.com>
 <20180903055654.GA14951@dhcp22.suse.cz>
 <20180904140035.GA3526@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904140035.GA3526@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-09-18 10:00:36, Jerome Glisse wrote:
> On Mon, Sep 03, 2018 at 07:56:54AM +0200, Michal Hocko wrote:
[...]
> > And THP migration is still a problem with 4.4 AFAICS. All other cases
> > simply split the huge page but THP migration keeps it in one piece and
> > as such it is theoretically broken as you have explained. So I would
> > stick with what I posted with some more clarifications in the changelog
> > if you think it is appropriate (suggestions welcome).
> 
> Reading code there is no THP migration in 4.4 only huge tlb migration.

Meh, you are right. For some reason I misread unmap_and_move_huge_page
to be also for THP. Sorry for the conusion. My fault!

Then it would be indeed safer to use your backport.
-- 
Michal Hocko
SUSE Labs
