Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF16C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA51D20841
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA51D20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbeHWW5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:57:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:59496 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726083AbeHWW47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:56:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 60B1FAEC0;
        Thu, 23 Aug 2018 19:25:50 +0000 (UTC)
Date:   Thu, 23 Aug 2018 21:25:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/speculation/l1tf: suggest what to do on systems with
 too much RAM
Message-ID: <20180823192547.GS29735@dhcp22.suse.cz>
References: <20180823134418.17008-1-vbabka@suse.cz>
 <20180823142812.7363-1-vbabka@suse.cz>
 <20180823154648.GD12066@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823154648.GD12066@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23-08-18 08:46:48, Andi Kleen wrote:
> On Thu, Aug 23, 2018 at 04:28:12PM +0200, Vlastimil Babka wrote:
> > Two users have reported [1] that they have an "extremely unlikely" system
> > with more than MAX_PA/2 memory and L1TF mitigation is not effective. Let's
> > make the warning more helpful by suggesting the proper mem=X kernel boot param,
> > a rough calculation of how much RAM can be lost (not precise if there's holes
> > between MAX_PA/2 and max_pfn in the e820 map) and a link to the L1TF document
> > to help decide if the mitigation is worth the unusable RAM.
> 
> I'm not sure anyone would really do that. After all you probably prefer
> your memory. And if it's really a non ECC client part they are are
> already used to to live very dangerously because their undetected RAM bit error
> rate will be significant. L1TF is probably one of your smaller problems
> in this case...

There are people who care about L1TF mitigations. I am not going to
question their motivation. In any case a hint how to make the mitigation
active again sounds more useful than something that sounds as scary as
"you are vulnerable".

-- 
Michal Hocko
SUSE Labs
