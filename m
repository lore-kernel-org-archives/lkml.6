Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FC8C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D16218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfBANjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:39:54 -0500
Received: from mga18.intel.com ([134.134.136.126]:20338 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfBANjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:39:54 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 05:39:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,548,1539673200"; 
   d="scan'208";a="135059102"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.172])
  by orsmga001.jf.intel.com with ESMTP; 01 Feb 2019 05:39:49 -0800
Date:   Fri, 1 Feb 2019 15:39:49 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        matthewgarrett@google.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v9 6/6] tpm: pass an array of tpm_extend_digest
 structures to tpm_pcr_extend()
Message-ID: <20190201133949.GE17861@linux.intel.com>
References: <20190201100641.26936-1-roberto.sassu@huawei.com>
 <20190201100641.26936-7-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201100641.26936-7-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 11:06:41AM +0100, Roberto Sassu wrote:
> Currently, tpm_pcr_extend() accepts as an input only a SHA1 digest.
> 
> This patch replaces the hash parameter of tpm_pcr_extend() with an array of
> tpm_digest structures, so that the caller can provide a digest for each PCR
> bank currently allocated in the TPM.
> 
> tpm_pcr_extend() will not extend banks for which no digest was provided,
> as it happened before this patch, but instead it requires that callers
> provide the full set of digests. Since the number of digests will always be
> chip->nr_allocated_banks, the count parameter has been removed.
> 
> Due to the API change, ima_pcr_extend() and pcrlock() have been modified.
> Since the number of allocated banks is not known in advance, the memory for
> the digests must be dynamically allocated. To avoid performance degradation
> and to avoid that a PCR extend is not done due to lack of memory, the array
> of tpm_digest structures is allocated by the users of the TPM driver at
> initialization time.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
