Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E779C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B876C20BEC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B876C20BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeHVBbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 21:31:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:20214 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbeHVBbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 21:31:37 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2018 15:09:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,271,1531810800"; 
   d="scan'208";a="82297838"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga004.fm.intel.com with ESMTP; 21 Aug 2018 15:09:37 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 935E7301B91; Tue, 21 Aug 2018 15:09:37 -0700 (PDT)
Date:   Tue, 21 Aug 2018 15:09:37 -0700
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
Subject: Re: [PATCH 1/1] perf/x86/intel: make error messages less confusing
Message-ID: <20180821220937.GV12066@tassilo.jf.intel.com>
References: <20180821211528.8575-1-eduval@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821211528.8575-1-eduval@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 02:15:28PM -0700, Eduardo Valentin wrote:
> On a system with X86_FEATURE_ARCH_PERFMON disabled
> and with a model not known by family PMU drivers,
> user gets a kernel message log like the following:
> [ 0.100114] Performance Events: unsupported p6 CPU model 85 no PMU driver, software events only.
> 
> The "unsupported .. CPU" part may be confusing for some
> users. Rewording the messages on the failure path to:
> [ 0.667154] Performance Events: unknown p6 PMU on CPU model 85: !X86_FEATURE_ARCH_PERFMON: no PMU driver, software events only.

Are you sure users even know what ARCH_PERFMON is?

Maybe it is confusing (why exactly?), but it doesn't seem to me that your
new message is any better.

If you refer to VMs not exposing the PMU perhaps that should be explicitely mentioned.

Of course the real fix is to always expose the PMU, not improve the error messages...

-Andi

