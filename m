Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE69C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA405208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbfAJRgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:36:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:32720 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729918AbfAJRgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:36:22 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 09:36:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,462,1539673200"; 
   d="scan'208";a="113735140"
Received: from vanderss-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.152])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jan 2019 09:36:17 -0800
Date:   Thu, 10 Jan 2019 19:36:16 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jia Zhang <zhang.jia@linux.alibaba.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, tweek@google.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tpm/eventlog/tpm1: Fix off-by-1 when reading
 binary_bios_measurements
Message-ID: <20190110173616.GF6589@linux.intel.com>
References: <1546759399-45360-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1546759399-45360-2-git-send-email-zhang.jia@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546759399-45360-2-git-send-email-zhang.jia@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2019 at 03:23:19PM +0800, Jia Zhang wrote:
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
> Fix: 55a82ab("tpm: add bios measurement log")

Fixes:

/Jarkko
