Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8FBECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802F3208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802F3208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731618AbeGPQF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:05:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:4767 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729612AbeGPQF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:05:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 08:38:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,361,1526367600"; 
   d="scan'208";a="67348489"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga003.jf.intel.com with ESMTP; 16 Jul 2018 08:37:47 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 2143A300B4B; Mon, 16 Jul 2018 08:37:47 -0700 (PDT)
Date:   Mon, 16 Jul 2018 08:37:47 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Juan <genomeme@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        jolsa@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Perf JSON events mismatch with Intel SDM
Message-ID: <20180716153747.GC25412@tassilo.jf.intel.com>
References: <CA+eKabDFV0UZ_52jbamj+=cGdD7OSRHMhuFHbni1SkBzRrd57g@mail.gmail.com>
 <20180716035908.GA25412@tassilo.jf.intel.com>
 <CA+eKabDaAVFR-eeXDaocQQWT=82XouV8fw3zcJ9cos=O7v1W3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+eKabDaAVFR-eeXDaocQQWT=82XouV8fw3zcJ9cos=O7v1W3g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>    The semantic difference being, as far as I can tell, that the "GT"
>    counters do not sample randomly, but will rather offer a precise count of
>    loads meeting the stated condition. 

It's all the same underlying hardware event. The only difference is what threshold
is used for filtering the loads.

-Andi
