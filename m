Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAA8C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C5D20869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbfA3MB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:01:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:15195 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730592AbfA3MB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:01:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 04:01:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="140066087"
Received: from rkazants-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.254.212])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jan 2019 04:01:24 -0800
Date:   Wed, 30 Jan 2019 14:01:22 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        matthewgarrett@google.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v8 1/7] tpm: dynamically allocate the allocated_banks
 array
Message-ID: <20190130120122.GA19191@linux.intel.com>
References: <20190124154910.29948-1-roberto.sassu@huawei.com>
 <20190124154910.29948-2-roberto.sassu@huawei.com>
 <20190129192941.GB14305@linux.intel.com>
 <ddf3515d-efba-6cf0-e224-90966be9cb18@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddf3515d-efba-6cf0-e224-90966be9cb18@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 08:52:40AM +0100, Roberto Sassu wrote:
> On 1/29/2019 8:29 PM, Jarkko Sakkinen wrote:
> > On Thu, Jan 24, 2019 at 04:49:04PM +0100, Roberto Sassu wrote:
> > > +	chip->allocated_banks = kcalloc(1, sizeof(*chip->allocated_banks),
> > > +					GFP_KERNEL);
> > > +	if (!chip->allocated_banks) {
> > > +		rc = -ENOMEM;
> > > +		goto out;
> > > +	}
> > > +
> > > +	chip->allocated_banks[0] = TPM2_ALG_SHA1;
> > > +	chip->nr_allocated_banks = 1;
> > 
> > Everything else looks nice in this patch except this.
> > 
> > You always branch for TPM 1.2, and it will always have just SHA1. This
> > is unnecessary.
> 
> Without this, users of the TPM driver have to call tpm_is_tpm2() first,
> while instead they can look directly at chip->allocated_banks.

I realized this after going through the whole patch set and sleeping
one night :-) You can keep it. I was mistaken here.

/Jarkko
