Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8546C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB01206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB01206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbeHWTRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 15:17:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:64034 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727633AbeHWTRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 15:17:02 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2018 08:46:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,278,1531810800"; 
   d="scan'208";a="83902425"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga001.fm.intel.com with ESMTP; 23 Aug 2018 08:46:48 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id D04E4301B91; Thu, 23 Aug 2018 08:46:48 -0700 (PDT)
Date:   Thu, 23 Aug 2018 08:46:48 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>, stable@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] x86/speculation/l1tf: suggest what to do on systems with
 too much RAM
Message-ID: <20180823154648.GD12066@tassilo.jf.intel.com>
References: <20180823134418.17008-1-vbabka@suse.cz>
 <20180823142812.7363-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823142812.7363-1-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 04:28:12PM +0200, Vlastimil Babka wrote:
> Two users have reported [1] that they have an "extremely unlikely" system
> with more than MAX_PA/2 memory and L1TF mitigation is not effective. Let's
> make the warning more helpful by suggesting the proper mem=X kernel boot param,
> a rough calculation of how much RAM can be lost (not precise if there's holes
> between MAX_PA/2 and max_pfn in the e820 map) and a link to the L1TF document
> to help decide if the mitigation is worth the unusable RAM.

I'm not sure anyone would really do that. After all you probably prefer
your memory. And if it's really a non ECC client part they are are
already used to to live very dangerously because their undetected RAM bit error
rate will be significant. L1TF is probably one of your smaller problems
in this case...


-Andi
