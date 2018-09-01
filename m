Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A612C43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 15:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F362083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 15:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F362083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeIATpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 15:45:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:48392 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbeIATpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 15:45:18 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Sep 2018 08:32:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,315,1531810800"; 
   d="scan'208";a="80132769"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.160.116])
  by orsmga003.jf.intel.com with ESMTP; 01 Sep 2018 08:32:44 -0700
Date:   Sat, 1 Sep 2018 23:38:54 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Gu Zhimin <kookoo.gu@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] x86, hibernate: Fix nosave_regions setup for
 hibernation
Message-ID: <20180901153853.GA16196@chenyu-desktop>
References: <cover.1535361949.git.kookoo.gu@intel.com>
 <73b18a8b87a465fc442366cccf5542307c4f1ae9.1535361949.git.kookoo.gu@intel.com>
 <alpine.DEB.2.21.1808301441550.1210@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808301441550.1210@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, Aug 30, 2018 at 02:45:26PM +0200, Thomas Gleixner wrote:
> On Mon, 27 Aug 2018, Gu Zhimin wrote:
> > 
> > Fix this problem by changing pfn limit from max_low_pfn to max_pfn.
> > This issue should also exist on 64bits systems, if there are reserved
> > regions above 4GB.
> 
> Should? Can we please have facts and not some half baken assumptions? 
> 
> On 64bit max_low_pfn is the same as max_pfn. See init_mem_mapping().
>
Thanks for pointing this out, we've overlooked the reassignment of max_low_pfn,
but just take a glance within setup_arch().
Best,
Yu

> Thanks,
> 
> 	tglx
