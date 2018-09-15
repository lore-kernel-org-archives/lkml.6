Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76C4ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 22:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0672083A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 22:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0672083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeIPDw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 23:52:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:14468 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727940AbeIPDw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 23:52:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Sep 2018 15:31:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,379,1531810800"; 
   d="scan'208";a="83831344"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga003.jf.intel.com with ESMTP; 15 Sep 2018 15:29:43 -0700
Date:   Sat, 15 Sep 2018 15:27:05 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Xiaochen Shen <xiaochen.shen@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH 1/9] x86/intel_rdt: Fix MBA parsing callback
Message-ID: <20180915222704.GA76410@romley-ivt3.sc.intel.com>
References: <1536957129-70380-1-git-send-email-fenghua.yu@intel.com>
 <1536957129-70380-2-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1809151206340.1650@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809151206340.1650@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 12:13:53PM +0200, Thomas Gleixner wrote:
> On Fri, 14 Sep 2018, Fenghua Yu wrote:
> > +int parse_bw(void *_data, struct rdt_resource *r, struct rdt_domain *d);
> 
> Sorry no. This keeps the code equally error prone as it was. Why is that
> argument a void pointer in the first place? 
> 
> >  extern struct mutex rdtgroup_mutex;
> 
> This is a copy of rdt_cbm_parse_data. Sigh.
> 
> The right thing to do here is
> 
>     1) rename struct rdt_cbm_parse_data to struct rdt_parse_data
> 
>     2) Move it to a header file
> 
>     3) Change the argument of parse_ctrlval from void * to struct
>        rdt_parse_data *
> 
> Everything else is just proliferating the initial underlying problem of
> having a void pointer in those callbacks for no reason at all.

Sure. I have updated this patch and patch 2, 4, 5 based on your comments.

Thanks.

-Fenghua
