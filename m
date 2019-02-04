Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59137C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E86214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbfBDMGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:06:22 -0500
Received: from mga06.intel.com ([134.134.136.31]:1842 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbfBDMGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:06:22 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 04:06:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="123774095"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.172])
  by orsmga003.jf.intel.com with ESMTP; 04 Feb 2019 04:06:18 -0800
Date:   Mon, 4 Feb 2019 14:06:18 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, roberto.sassu@huawei.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] tpm/st33zp24: Fix name collision with TPM_BUFSIZE
Message-ID: <20190204120618.GF26799@linux.intel.com>
References: <20190201174117.23440-1-jarkko.sakkinen@linux.intel.com>
 <1549234854.4146.24.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549234854.4146.24.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03, 2019 at 06:00:54PM -0500, Mimi Zohar wrote:
> Hi Jarkko,
> 
> On Fri, 2019-02-01 at 19:41 +0200, Jarkko Sakkinen wrote:
> > Rename TPM_BUFSIZE defined in drivers/char/tpm/st33zp24/st33zp24.h to
> > ST33ZP24_BUFSIZE as it collides with TPM_BUFSIZE defined in
> > drivers/char/tpm/tpm.h.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: bf38b8710892 ("tpm/tpm_i2c_stm_st33: Split tpm_i2c_tpm_st33 in 2 layers (core + phy)")
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> FYI, I'm seeing a similar redefined TPM_BUFSIZE in tpm_i2c_infineon.c.

Ugh, I'll fix that one too and send a revised patch. Thanks for pointing
that one out!

/Jarkko
