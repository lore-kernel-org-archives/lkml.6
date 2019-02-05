Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8CAC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F243520818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfBEVAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:00:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:45665 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfBEVAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 16:00:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 13:00:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,336,1544515200"; 
   d="scan'208";a="124222060"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.171])
  by orsmga003.jf.intel.com with ESMTP; 05 Feb 2019 12:59:57 -0800
Date:   Tue, 5 Feb 2019 22:59:55 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, roberto.sassu@huawei.com,
        zohar@linux.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] tpm/st33zp24: Fix the name collisions in
 tpm_st33zp24_spi and tpm_i2c_infineon
Message-ID: <20190205205955.GC13023@linux.intel.com>
References: <20190204133749.14176-1-jarkko.sakkinen@linux.intel.com>
 <1549395622.2923.14.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549395622.2923.14.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 02:40:22PM -0500, James Bottomley wrote:
> On Mon, 2019-02-04 at 15:37 +0200, Jarkko Sakkinen wrote:
> > diff --git a/drivers/char/tpm/tpm_i2c_infineon.c
> > b/drivers/char/tpm/tpm_i2c_infineon.c
> > index 9086edc9066b..b9d5a1dda8d2 100644
> > --- a/drivers/char/tpm/tpm_i2c_infineon.c
> > +++ b/drivers/char/tpm/tpm_i2c_infineon.c
> [...]
> > @@ -527,8 +528,8 @@ static int tpm_tis_i2c_send(struct tpm_chip
> > *chip, u8 *buf, size_t len)
> >  	u8 retries = 0;
> >  	u8 sts = TPM_STS_GO;
> >  
> > -	if (len > TPM_BUFSIZE)
> > -		return -E2BIG;	/* command is too long for our
> > tpm, sorry */
> > +	if (len > TPM_I2C_INFINEON_BUFSIZE)
> 
> TPM_I2C_INFINEON_MAX_BUFSIZE, surely, otherwise it won't compile ...
> the kbuild robot just spotted this as well.

Correct, unluckily, I had unstaged diff.

/Jarkko
