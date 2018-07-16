Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7F5ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 03:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119F220873
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 03:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119F220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeGPEYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 00:24:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:22830 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbeGPEY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 00:24:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2018 20:59:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,359,1526367600"; 
   d="scan'208";a="73054022"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga001.jf.intel.com with ESMTP; 15 Jul 2018 20:59:08 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 55431300B4B; Sun, 15 Jul 2018 20:59:08 -0700 (PDT)
Date:   Sun, 15 Jul 2018 20:59:08 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Juan <genomeme@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        jolsa@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Perf JSON events mismatch with Intel SDM
Message-ID: <20180716035908.GA25412@tassilo.jf.intel.com>
References: <CA+eKabDFV0UZ_52jbamj+=cGdD7OSRHMhuFHbni1SkBzRrd57g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+eKabDFV0UZ_52jbamj+=cGdD7OSRHMhuFHbni1SkBzRrd57g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  now need to dive in deep into the actual implementation. Simple question: is this a bug?

These are derived events from MEM_TRANS_RETIRED.LOAD_LATENCY, which is in
the SDM.  It's not a bug. In general the event lists used by perf are 
newer versions than what is in the SDM.

-Andi
