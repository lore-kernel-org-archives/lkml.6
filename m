Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D279C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C64C2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbfBSRb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:31:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:61718 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbfBSRbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:31:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 09:31:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="125622201"
Received: from vanderss-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.177])
  by fmsmga008.fm.intel.com with ESMTP; 19 Feb 2019 09:31:22 -0800
Date:   Tue, 19 Feb 2019 19:31:20 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     YueHaibing <yuehaibing@huawei.com>, peterhuewe@gmx.de,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH -next] tpm: change the return type of
 calc_tpm2_event_size to size_t
Message-ID: <20190219173120.GA15462@linux.intel.com>
References: <20190219072618.23048-1-yuehaibing@huawei.com>
 <20190219085921.GA5609@linux.intel.com>
 <820d3cf7-03ab-5434-5306-292b41aed860@huawei.com>
 <20190219103532.GA16707@linux.intel.com>
 <20190219163456.GB752@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219163456.GB752@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 09:34:56AM -0700, Jason Gunthorpe wrote:
> > - Your real name is formatted incorrectly. It should be like "Yue Haibig"
> >   as shown in [1].
> > - If there is no actual regression, this change is useless.
> 
> Clarity of the code is a laudible goal - not everything is about
> fixing bugs or adding features.
> 
> It is much easier to write the code properly than to try and prove
> that event_size can not exceed INT_MAX.

I think it is actually a regression in 4d23cc323cdb.  Should carry a
fixes tag. I did not quite undersand what commit message was saying.
What it should would just

"""
tpm: Fix the type of the return value in calc_tpm2_event_size()

calc_tpm2_event_size() has an invalid signature because it returns a 'size_t'
where as its signature says that it returns 'int'.
"""

Should be also Cc'd to linux-security-module and have cc to stable.

/Jarkko
