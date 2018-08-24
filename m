Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3636C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CA3208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CA3208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeHXHIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 03:08:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:39453 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbeHXHIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 03:08:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2018 20:35:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,280,1531810800"; 
   d="scan'208";a="85979268"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga002.jf.intel.com with ESMTP; 23 Aug 2018 20:35:40 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 63E37301B8F; Thu, 23 Aug 2018 20:35:40 -0700 (PDT)
Date:   Thu, 23 Aug 2018 20:35:40 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Andre Tomt <andre@tomt.net>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>, stable@vger.kernel.org,
        Christopher Snowhill <kode54@gmail.com>,
        George Anchev <studio@anchev.net>
Subject: Re: [PATCH] x86/speculation/l1tf: fix off-by-one error when warning
 that system has too much RAM
Message-ID: <20180824033540.GI12066@tassilo.jf.intel.com>
References: <20180823134418.17008-1-vbabka@suse.cz>
 <20180823154437.GC12066@tassilo.jf.intel.com>
 <0fa72221-2272-4489-d9d3-0f68cb874087@tomt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fa72221-2272-4489-d9d3-0f68cb874087@tomt.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 04:22:57AM +0200, Andre Tomt wrote:
> On 23. aug. 2018 17:44, Andi Kleen wrote:
> > On Thu, Aug 23, 2018 at 03:44:18PM +0200, Vlastimil Babka wrote:
> > > Two users have reported [1] that they have an "extremely unlikely" system
> > > with more than MAX_PA/2 memory and L1TF mitigation is not effective. In fact
> > > it's a CPU with 36bits phys limit (64GB) and 32GB memory, but due to holes
> > > in the e820 map, the main region is almost 500MB over the 32GB limit:
> > 
> > Ah I see it's a client part with very large DIMMs and someone being
> > very brave and using that much memory without ECC.
> 
> FYI; It is also happening on Xeon E3v2 (Ivy Bridge generation) w/ 32GB of
> ECC RAM here, a low-end server part that officially supports up to 32GB.

Good point.

-andi
