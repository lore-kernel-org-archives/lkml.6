Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FD5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E34221871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeLRVi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:38:27 -0500
Received: from mga01.intel.com ([192.55.52.88]:59373 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbeLRVi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:38:27 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 13:38:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,370,1539673200"; 
   d="scan'208";a="111635026"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga003.jf.intel.com with ESMTP; 18 Dec 2018 13:38:26 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 1BCF3300B49; Tue, 18 Dec 2018 13:38:26 -0800 (PST)
Date:   Tue, 18 Dec 2018 13:38:26 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Aubrey Li <aubrey.li@intel.com>, mingo@redhat.com,
        peterz@infradead.org, hpa@zytor.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] x86/fpu: track AVX-512 usage of tasks
Message-ID: <20181218213826.GI25620@tassilo.jf.intel.com>
References: <20181218042218.8653-1-aubrey.li@intel.com>
 <alpine.DEB.2.21.1812181448170.12686@nanos.tec.linutronix.de>
 <62997df2-0817-b54d-b11e-00a567f1d67c@linux.intel.com>
 <alpine.DEB.2.21.1812181630530.14031@nanos.tec.linutronix.de>
 <b14a9c82-3336-0f13-1a27-fba929e6b4fb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b14a9c82-3336-0f13-1a27-fba929e6b4fb@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I misunderstood, you mean 32bit kernel, not 32bit machine. Theoretically 32bit
> kernel can use AVX512, but not sure if anyone use it like this. get_jiffies_64()
> includes jiffies_lock ops so not good in context switch. So I want to use raw
> jiffies_64 here. jiffies is a good candidate but it has wraparound overflow issue.
> Other time source are expensive here.
> 
> Should I limit the code only running on 64bit kernel? 

Yes making it 64bit only should be fine.

Other alternative would be to use 32bit jiffies on 32bit. I assume
wrapping is not that big a problem here.

-Andi
