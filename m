Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305CAECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1162146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1162146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeINOMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:12:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:6818 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbeINOMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:12:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 01:59:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,372,1531810800"; 
   d="scan'208";a="263446767"
Received: from yisun1-ubuntu.bj.intel.com (HELO localhost) ([10.238.156.104])
  by fmsmga006.fm.intel.com with ESMTP; 14 Sep 2018 01:55:34 -0700
Date:   Fri, 14 Sep 2018 16:53:01 +0800
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelly@microsoft.com,
        tianyu.lan@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH v1 2/3] locking/pvqspinlock, hv: Enable PV qspinlock for
 Hyper-V
Message-ID: <20180914085301.GA11769@yi.y.sun>
References: <1536830005-37260-1-git-send-email-yi.y.sun@linux.intel.com>
 <1536830005-37260-3-git-send-email-yi.y.sun@linux.intel.com>
 <alpine.DEB.2.21.1809131304560.1473@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809131304560.1473@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-09-13 13:06:13, Thomas Gleixner wrote:
> On Thu, 13 Sep 2018, Yi Sun wrote:
> > +#include <asm/mshyperv.h>
> >  
> >  /* representing HT siblings of each logical CPU */
> >  DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
> > @@ -1335,6 +1336,7 @@ void __init native_smp_prepare_boot_cpu(void)
> >  	/* already set me in cpu_online_mask in boot_cpu_init() */
> >  	cpumask_set_cpu(me, cpu_callout_mask);
> >  	cpu_set_state_online(me);
> > +	hv_init_spinlocks();
> 
> No. We have smp_ops.smp_prepare_boot_cpu for that.
> 
Got it, will change it. Thanks!

> Thanks,
> 
> 	tglx
