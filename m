Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6076AECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6F82064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6F82064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbeKAGmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:42:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:37762 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbeKAGmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:42:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C194EAD64;
        Wed, 31 Oct 2018 21:42:09 +0000 (UTC)
Date:   Wed, 31 Oct 2018 22:42:08 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@gmail.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memory_hotplug: cond_resched in __remove_pages
Message-ID: <20181031214208.GA5564@dhcp22.suse.cz>
References: <20181031125840.23982-1-mhocko@kernel.org>
 <20181031121550.2f0cbd10a948880e534beaf7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031121550.2f0cbd10a948880e534beaf7@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31-10-18 12:15:50, Andrew Morton wrote:
> On Wed, 31 Oct 2018 13:58:40 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > We have received a bug report that unbinding a large pmem (>1TB)
> > can result in a soft lockup:
> > 
> > ...
> >
> > It has been reported on an older (4.12) kernel but the current upstream
> > code doesn't cond_resched in the hot remove code at all and the given
> > range to remove might be really large. Fix the issue by calling cond_resched
> > once per memory section.
> > 
> 
> Worthy of a cc:stable, I suggest?

It is simple enough and we will surely have it in 4.12 based SLES
kernels. So I do not really mind cc: stable.

-- 
Michal Hocko
SUSE Labs
