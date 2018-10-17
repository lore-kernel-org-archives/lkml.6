Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B7BECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E217B2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E217B2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJQUMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:12:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:56612 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726961AbeJQUMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:12:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 89EC1AF00;
        Wed, 17 Oct 2018 12:17:07 +0000 (UTC)
Date:   Wed, 17 Oct 2018 14:17:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     vbabka@suse.cz, hpa@zytor.com, torvalds@linux-foundation.org,
        ak@linux.intel.com, dave.hansen@intel.com,
        kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Subject: Re: l1tf: Kernel suggests I throw away third of my memory. I'd
 rather not
Message-ID: <20181017121705.GQ18839@dhcp22.suse.cz>
References: <20181017105610.GA4260@amd>
 <20181017111544.GO18839@dhcp22.suse.cz>
 <20181017113226.GA5176@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017113226.GA5176@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-10-18 13:32:26, Pavel Machek wrote:
[...]
> > > Now question is... can we do better? Kernel stores information about
> > > swapped-out pages there, right? That sounds like a cool hack, but
> > > maybe it is time to get rid of that hack?
> > 
> > Patches are welcome.
> 
> Cooperation will be needed if you want to see patches. As
> in... answering the questions above.

The question is whether that is really worth it. L1TF is mostly about
virtual environments. If you are running in a native HW then I wouldn't
lose much sleep over it. a) pfns stored in PROT_NONE entries are
controlled by the OS b) swap based attacks with something interesting in
L1$ colliding with the swap entry is theoretical at best.
-- 
Michal Hocko
SUSE Labs
