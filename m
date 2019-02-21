Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAC6C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD882086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfBUMNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:13:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:38497 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfBUMNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:13:44 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 04:13:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,395,1544515200"; 
   d="scan'208";a="124132963"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.169])
  by fmsmga007.fm.intel.com with ESMTP; 21 Feb 2019 04:13:41 -0800
Date:   Thu, 21 Feb 2019 14:13:40 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     YueHaibing <yuehaibing@huawei.com>, peterhuewe@gmx.de,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 -next] tpm: Fix the type of the return value in
 calc_tpm2_event_size()
Message-ID: <20190221121340.GA7918@linux.intel.com>
References: <20190220022300.25888-1-yuehaibing@huawei.com>
 <20190220063159.GA23027@linux.intel.com>
 <20190220160042.GD8429@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220160042.GD8429@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 09:00:42AM -0700, Jason Gunthorpe wrote:
> On Wed, Feb 20, 2019 at 08:31:59AM +0200, Jarkko Sakkinen wrote:
> > On Wed, Feb 20, 2019 at 10:23:00AM +0800, YueHaibing wrote:
> > > calc_tpm2_event_size() has an invalid signature because
> > > it returns a 'size_t' where as its signature says that
> > > it returns 'int'.
> > > 
> > > Fixes: 4d23cc323cdb ("tpm: add securityfs support for TPM 2.0 firmware event log")
> > > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > 
> > Two remarks:
> > 
> > - git config user.name "Yue Haibing"
> > - "Cc: stable@vger.kernel.org" before the fixes tag.
> 
> 'Theoretical' bug fixes are not suitable for stable

AFAIK there is no hard rule here. For this one line change I think it
makes sense to backport it even if it is only for avoiding conflicts
with future backports.

/Jarkko
