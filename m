Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E11BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648F220851
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648F220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbeK1Fbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:31:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:26469 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeK1Fbu (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:31:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 10:33:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,287,1539673200"; 
   d="scan'208";a="104044398"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga003.jf.intel.com with ESMTP; 27 Nov 2018 10:33:03 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 0BA6A309C9B; Tue, 27 Nov 2018 10:33:03 -0800 (PST)
Date:   Tue, 27 Nov 2018 10:33:03 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH v2 3/3] perf report: Display average IPC and IPC coverage
 per symbol
Message-ID: <20181127183302.GW13936@tassilo.jf.intel.com>
References: <1543320588-14863-1-git-send-email-yao.jin@linux.intel.com>
 <1543320588-14863-4-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543320588-14863-4-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 08:09:48PM +0800, Jin Yao wrote:
> Support displaying the average IPC and IPC coverage for symbol
> in perf report TUI browser. We create a new sort-key 'ipc' for
> that.

Another thing that would be nice would be to automatically enable
these columns perf report when -b was enabled in the perf.data.
We can't check for timed LBR being supported without 
looking into samples, but at least can check for -b.

Otherwise a lot of people won't realize it's supported.

It would show always 0.0 when timed LBR is not supported,
but that might be ok. Perhaps make both columns empty
in this case instead of 0.0.


-Andi
