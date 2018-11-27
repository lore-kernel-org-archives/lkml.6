Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D580C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3063521104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3063521104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbeK1DYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:24:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:58818 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726390AbeK1DYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:24:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 354C8AB6D;
        Tue, 27 Nov 2018 16:25:45 +0000 (UTC)
Date:   Tue, 27 Nov 2018 17:25:44 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/3] mm, proc: report PR_SET_THP_DISABLE in proc
Message-ID: <20181127162544.GA6923@dhcp22.suse.cz>
References: <20181120103515.25280-1-mhocko@kernel.org>
 <20181120103515.25280-4-mhocko@kernel.org>
 <0ACDD94B-75AD-4DD0-B2E3-32C0EDFBAA5E@oracle.com>
 <20181127131707.GW12455@dhcp22.suse.cz>
 <04647F77-FE93-4A8E-90C1-4245709B88A5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04647F77-FE93-4A8E-90C1-4245709B88A5@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-11-18 07:50:08, William Kucharski wrote:
> 
> 
> > On Nov 27, 2018, at 6:17 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > This is only about the process wide flag to disable THP. I do not see
> > how this can be alighnement related. I suspect you wanted to ask in the
> > smaps patch?
> 
> No, answered below.
> 
> > 
> >> I'm having to deal with both these issues in the text page THP
> >> prototype I've been working on for some time now.
> > 
> > Could you be more specific about the issue and how the alignment comes
> > into the game? The only thing I can think of is to not report VMAs
> > smaller than the THP as eligible. Is this what you are looking for?
> 
> Basically, if the faulting VA is one that cannot be mapped with a THP
> due to alignment or size constraints, it may be "eligible" for THP
> mapping but ultimately can't be.
> 
> I was just double checking that this was meant to be more of a check done
> before code elsewhere performs additional checks and does the actual THP
> mapping, not an all-encompassing go/no go check for THP mapping.

I am still not sure I follow you completely here. This just reports
per-task eligibility. The system wide eligibility is reported via sysfs
and the per vma eligibility is reported via /proc/<pid>/smaps.

-- 
Michal Hocko
SUSE Labs
