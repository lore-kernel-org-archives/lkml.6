Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0265CC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A503D2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UsqqJTbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A503D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeIEUeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:34:10 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:39197 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeIEUeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1536163400; x=1567699400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sk40h4uc6u5xEPoShpVWsI299btrzxvalVuxeTLqL/I=;
  b=UsqqJTbn8B7a0PM/3X4WftkChfw+EwioASDxKULR4YUekJBirKLaWJo6
   DOyREN36oKe3dDKyjQEfZiKcmCdpXaTb8pd/yHF/XSxEs/lnLIIFARnQR
   hlj8vN3XntvqgAZm6HVhKnhJL1LYK90dssQWhiHWsE9yQgOc73tWyHwJK
   w=;
X-IronPort-AV: E=Sophos;i="5.53,334,1531785600"; 
   d="scan'208";a="629418261"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Sep 2018 15:54:37 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w85FrKPE120775
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 5 Sep 2018 15:53:22 GMT
Received: from EX13D05UWB003.ant.amazon.com (10.43.161.26) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 5 Sep 2018 15:53:20 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D05UWB003.ant.amazon.com (10.43.161.26) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 5 Sep 2018 15:53:19 +0000
Received: from localhost (10.85.220.85) by mail-relay.amazon.com
 (10.43.60.129) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 5 Sep 2018 15:53:18 +0000
Date:   Wed, 5 Sep 2018 08:53:17 -0700
From:   Eduardo Valentin <eduval@amazon.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Eduardo Valentin <eduval@amazon.com>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Jia Zhang" <qianyue.zj@alibaba-inc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 1/1] perf/x86/intel: make error messages less confusing
Message-ID: <20180905155317.GA20320@u40b0340c692b58f6553c.ant.amazon.com>
References: <20180823150732.11249-1-eduval@amazon.com>
 <20180905085212.GS24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180905085212.GS24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 10:52:12AM +0200, Peter Zijlstra wrote:
> On Thu, Aug 23, 2018 at 08:07:32AM -0700, Eduardo Valentin wrote:
> > On a system with X86_FEATURE_ARCH_PERFMON disabled
> > and with a model not known by family PMU drivers,
> > user gets a kernel message log like the following:
> > [ 0.100114] Performance Events: unsupported p6 CPU model 85 no PMU driver, software events only.
> > 
> > The "unsupported .. CPU" part may be confusing for some
> > users leading to wrong understanding that the kernel
> > does not support the CPU model.
> 
> Send them back to first grade, such that they might learn to read?
> 

:-)

-- 
All the best,
Eduardo Valentin
