Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EF4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B825214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B825214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733105AbeKVE5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:57:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:55132 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729128AbeKVE5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:57:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4A76AB0AF;
        Wed, 21 Nov 2018 18:21:33 +0000 (UTC)
Date:   Wed, 21 Nov 2018 19:21:31 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        WoodhouseDavid <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        SchauflerCasey <casey.schaufler@intel.com>,
        Dave Stewart <david.c.stewart@intel.com>
Subject: Re: [PATCH 4.19 041/361] x86/speculation: Enable cross-hyperthread
 spectre v2 STIBP mitigation
In-Reply-To: <41234d20-294f-d0f4-336c-64bf9fcb92a7@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.1811211920570.21108@cbobk.fhfr.pm>
References: <20181111221619.915519183@linuxfoundation.org> <20181111221625.598298393@linuxfoundation.org> <alpine.LRH.2.00.1811211420130.18805@gjva.wvxbf.pm> <20181121135611.GA26411@kroah.com> <41234d20-294f-d0f4-336c-64bf9fcb92a7@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018, Tim Chen wrote:

> > Is it reverted in Linus's tree?  If not, then anything that comes "later
> > on" will not apply here, right?
> > 
> > I see the thread asking about this, but I got really conflicting
> > messages here, and now it's in all of the latest releases, and no
> > testing seems to have uncovered issues.  Is it just a "slow down"
> > problem?
> 
> Greg,
> 
> It could be a big slow down in excess of 20% for some applications.
> And cross sibling Spectre v2 attack is quite hard to pull off.
> 
> So till we have the accompanying patchset that only apply STIBP on processes
> that really need it instead of universally, it should be withheld from
> stable.

Agreed; it will be trivially reintroduced with the rest, once it's ready. 
It's being built on top of that patch.

Thanks,

-- 
Jiri Kosina
SUSE Labs

