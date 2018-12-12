Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB66C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5213D2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5213D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbeLLS3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:29:17 -0500
Received: from mga14.intel.com ([192.55.52.115]:36134 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbeLLS3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:29:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 10:29:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,345,1539673200"; 
   d="scan'208";a="127337981"
Received: from hekner-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.170])
  by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2018 10:29:11 -0800
Date:   Wed, 12 Dec 2018 20:29:10 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com,
        david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v6 4/7] tpm: modify tpm_pcr_read() definition to pass a
 TPM hash algorithm
Message-ID: <20181212182910.GJ6333@linux.intel.com>
References: <20181204082138.24600-1-roberto.sassu@huawei.com>
 <20181204082138.24600-5-roberto.sassu@huawei.com>
 <20181204234024.GC1233@linux.intel.com>
 <1e9f4b5a-c0fc-8be8-61f5-39166e948b01@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e9f4b5a-c0fc-8be8-61f5-39166e948b01@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 01:44:58PM +0530, Nayna Jain wrote:
> 
> On 12/05/2018 05:10 AM, Jarkko Sakkinen wrote:
> > On Tue, Dec 04, 2018 at 09:21:35AM +0100, Roberto Sassu wrote:
> > > Currently the TPM driver allows other kernel subsystems to read only the
> > > SHA1 PCR bank. This patch modifies the parameters of tpm_pcr_read() and
> > > tpm2_pcr_read() to pass a tpm_digest structure, which contains the desired
> > > hash algorithm. Also, since commit 125a22105410 ("tpm: React correctly to
> > > RC_TESTING from TPM 2.0 self tests") removed the call to tpm2_pcr_read(),
> > > the new parameter is expected to be always not NULL.
> > > 
> > > Due to the API change, IMA functions have been modified.
> > > 
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > Mimi, Nayna, can you help with testing this (because of the IMA change)?
> 
> Sure, I will try to do by end of my day tomorrow,

Awesome, thank you.

/Jarkko
