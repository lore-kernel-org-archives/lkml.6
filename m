Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8E2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45D92086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45D92086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeJJJsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 05:48:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:34584 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbeJJJsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 05:48:18 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2018 19:28:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,362,1534834800"; 
   d="scan'208";a="90672557"
Received: from yisun1-ubuntu.bj.intel.com (HELO localhost) ([10.238.156.104])
  by orsmga003.jf.intel.com with ESMTP; 09 Oct 2018 19:28:17 -0700
Date:   Wed, 10 Oct 2018 10:25:36 +0800
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        jgross@suse.com, chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelley@microsoft.com,
        tianyu.lan@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH v4 2/2] locking/pvqspinlock, hv: Enable PV qspinlock for
 Hyper-V
Message-ID: <20181010022536.GH11769@yi.y.sun>
References: <1538987374-51217-1-git-send-email-yi.y.sun@linux.intel.com>
 <1538987374-51217-3-git-send-email-yi.y.sun@linux.intel.com>
 <20181009105427.GA102322@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181009105427.GA102322@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-09 12:54:27, Ingo Molnar wrote:
> 
> * Yi Sun <yi.y.sun@linux.intel.com> wrote:
> 
> > Follow PV spinlock mechanism to implement the callback functions
> > to allow the CPU idling and kicking operations on Hyper-V.
> 
> > +#if defined(CONFIG_SMP)
> > +	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
> > +#endif
> 
> What's wrong with using the common pattern of:
> 
> 	#ifdef CONFIG_SMP
> 
> ?

There is no difference between "#ifdef" and "#if defined". I just copied
it from "hv_smp_prepare_boot_cpu()". Do you need me submit a fix patch
after this set is merged?

> 
> Thanks,
> 
> 	Ingo
