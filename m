Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB1DC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 23:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8AD520661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 23:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AD520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeIEDbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 23:31:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:46913 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbeIEDbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 23:31:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 16:03:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,330,1531810800"; 
   d="scan'208";a="70592228"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2018 16:02:40 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 88CB9300B65; Tue,  4 Sep 2018 16:02:40 -0700 (PDT)
Date:   Tue, 4 Sep 2018 16:02:40 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Eduardo Valentin <eduval@amazon.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/1] perf/x86/intel: make error messages less confusing
Message-ID: <20180904230240.GK27886@tassilo.jf.intel.com>
References: <20180823150732.11249-1-eduval@amazon.com>
 <20180904182312.GA11911@u40b0340c692b58f6553c.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904182312.GA11911@u40b0340c692b58f6553c.ant.amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 11:23:12AM -0700, Eduardo Valentin wrote:
> Hello,
> 
> On Thu, Aug 23, 2018 at 08:07:32AM -0700, Eduardo Valentin wrote:
> > On a system with X86_FEATURE_ARCH_PERFMON disabled
> > and with a model not known by family PMU drivers,
> > user gets a kernel message log like the following:
> > [ 0.100114] Performance Events: unsupported p6 CPU model 85 no PMU driver, software events only.
> > 
> > The "unsupported .. CPU" part may be confusing for some
> > users leading to wrong understanding that the kernel
> > does not support the CPU model.
> > 
> > This patch rewords the messages on the failure path to:
> > [ 0.667154] Performance Events: CPU does not support PMU: no PMU driver, software events only.
> > 
> 
> 
> Gentle ping on this patch, any further comments?

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi
