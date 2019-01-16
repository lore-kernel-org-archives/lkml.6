Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9537EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAF4206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbfAPWKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:10:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:17250 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbfAPWJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:09:59 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 14:09:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,487,1539673200"; 
   d="scan'208";a="126429381"
Received: from lhaqq1-mobl2.amr.corp.intel.com (HELO localhost) ([10.249.254.231])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jan 2019 14:09:55 -0800
Date:   Thu, 17 Jan 2019 00:09:52 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jia Zhang <zhang.jia@linux.alibaba.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, tweek@google.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tpm/eventlog/tpm1: Simplify walking over *pos
 measurements
Message-ID: <20190116220952.GH25803@linux.intel.com>
References: <1547197173-52826-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1547197173-52826-2-git-send-email-zhang.jia@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547197173-52826-2-git-send-email-zhang.jia@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please use "tpm:" tag for commits, not "tpm/eventlog/tpm1".

On Fri, Jan 11, 2019 at 04:59:32PM +0800, Jia Zhang wrote:
> The responsibility of tpm1_bios_measurements_start() is to walk
> over the first *pos measurements, ensuring the skipped and
> to-be-read measurements are not out-of-boundary.
> 
> Current logic is complicated a bit. Just employ a do-while loop
> with necessary sanity check, and then get the goal.
> 
> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>

What does this fix? Even if the current logic is "complicated", it is
still a pretty simple functiion.

Applying clean ups for fun has the side-effect of making backporting
more difficult. And swapping implementation randomly has the side-effect
of potentially introducing regressions. The current code might be messy
but it is still field tested.

I'm sorry but I have to reject this patch.

/Jarkko
