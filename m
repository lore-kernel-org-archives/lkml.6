Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9315C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF72217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfBFVXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:23:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:3778 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfBFVXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:23:01 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 13:23:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,341,1544515200"; 
   d="scan'208";a="124496565"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga003.jf.intel.com with ESMTP; 06 Feb 2019 13:23:00 -0800
Date:   Wed, 6 Feb 2019 13:23:00 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Edac Mailing List <linux-edac@vger.kernel.org>
Subject: Re: linux-next: Tree for Feb 6 (drivers/edac/skx* and i10nm)
Message-ID: <20190206212259.GA28490@agluck-desk>
References: <20190206170000.286b1f53@canb.auug.org.au>
 <3f095f3e-ace0-aadb-ead1-01908da5c08c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f095f3e-ace0-aadb-ead1-01908da5c08c@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 01:11:23PM -0800, Randy Dunlap wrote:
> on x86_64:
> 
> ld: drivers/edac/skx_common.o: in function `skx_mce_check_error':
> skx_common.c:(.text+0x982): undefined reference to `adxl_decode'
> ld: drivers/edac/skx_common.o: in function `skx_adxl_get':
> skx_common.c:(.init.text+0x11): undefined reference to `adxl_get_component_names'
> 
> 
> CONFIG_EDAC_I10NM=y
> but CONFIG_EDAC_SKX is not set.
> since # CONFIG_ACPI is not set
> 
> Should EDAC_I10NM depend on ACPI also?


Yes it should.

Boris applied a patch to fix this to his "for-next" branch today. So
this should be all fixed when linux-next does a new build.

-Tony
