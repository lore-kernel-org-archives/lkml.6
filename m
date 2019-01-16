Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF42C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82F620675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733010AbfAPWRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:17:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:31825 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729384AbfAPWRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:17:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 14:17:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,487,1539673200"; 
   d="scan'208";a="117282574"
Received: from lhaqq1-mobl2.amr.corp.intel.com (HELO localhost) ([10.249.254.231])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jan 2019 14:17:31 -0800
Date:   Thu, 17 Jan 2019 00:17:29 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jia Zhang <zhang.jia@linux.alibaba.com>, nayna@linux.ibm.com
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, tweek@google.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tpm/eventlog/tpm1: Fix off-by-1 when reading
 binary_bios_measurements
Message-ID: <20190116221729.GI25803@linux.intel.com>
References: <1547197173-52826-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1547197173-52826-3-git-send-email-zhang.jia@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547197173-52826-3-git-send-email-zhang.jia@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 04:59:33PM +0800, Jia Zhang wrote:
> It is unable to read the entry when it is the only one in
> binary_bios_measurements:
> 
> 00000000  00 00 00 00 08 00 00 00  c4 2f ed ad 26 82 00 cb
> 00000010  1d 15 f9 78 41 c3 44 e7  9d ae 33 20 00 00 00 00
> 00000020
> 
> This is obviously a firmware problem on my linux machine:
> 
> 	Manufacturer: Inspur
> 	Product Name: SA5212M4
> 	Version: 01
> 
> However, binary_bios_measurements should return it any way,
> rather than nothing, after all its content is completely
> valid.
> 
> Fixes: 55a82ab("tpm: add bios measurement log")
> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>

LGTM, Nayna?

/Jarkko
