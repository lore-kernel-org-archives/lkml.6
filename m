Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292F6C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EC120825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4EC120825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeKHRdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:33:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:60968 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725945AbeKHRdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:33:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 72F56AC6C;
        Thu,  8 Nov 2018 07:59:35 +0000 (UTC)
Date:   Thu, 8 Nov 2018 08:59:34 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Baoquan He <bhe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 4/5] mm, memory_hotplug: print reason for the
 offlining failure
Message-ID: <20181108075934.GL27423@dhcp22.suse.cz>
References: <20181107101830.17405-1-mhocko@kernel.org>
 <20181107101830.17405-5-mhocko@kernel.org>
 <18bd20ff-7b3c-bcf2-042d-5ab59fdd42e1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18bd20ff-7b3c-bcf2-042d-5ab59fdd42e1@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08-11-18 11:53:21, Anshuman Khandual wrote:
> 
> 
> On 11/07/2018 03:48 PM, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > The memory offlining failure reporting is inconsistent and insufficient.
> > Some error paths simply do not report the failure to the log at all.
> > When we do report there are no details about the reason of the failure
> > and there are several of them which makes memory offlining failures
> > hard to debug.
> > 
> > Make sure that the
> > 	memory offlining [mem %#010llx-%#010llx] failed
> > message is printed for all failures and also provide a short textual
> > reason for the failure e.g.
> > 
> > [ 1984.506184] rac1 kernel: memory offlining [mem 0x82600000000-0x8267fffffff] failed due to signal backoff
> > 
> > this tells us that the offlining has failed because of a signal pending
> > aka user intervention.
> > 
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> It might help to enumerate these failure reason strings and use macros.

Does it really make sense when all of them are on-off things? I would
agree if they were reused somewhere.

-- 
Michal Hocko
SUSE Labs
