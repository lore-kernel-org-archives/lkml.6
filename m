Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BFEC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3290821872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbfBANe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:34:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:5975 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfBANe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:34:56 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 05:34:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,548,1539673200"; 
   d="scan'208";a="135058337"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.172])
  by orsmga001.jf.intel.com with ESMTP; 01 Feb 2019 05:34:51 -0800
Date:   Fri, 1 Feb 2019 15:34:51 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        matthewgarrett@google.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v9 1/6] tpm: dynamically allocate the allocated_banks
 array
Message-ID: <20190201133451.GA17861@linux.intel.com>
References: <20190201100641.26936-1-roberto.sassu@huawei.com>
 <20190201100641.26936-2-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201100641.26936-2-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 11:06:36AM +0100, Roberto Sassu wrote:
> This patch renames active_banks (member of tpm_chip) to allocated_banks,
> stores the number of allocated PCR banks in nr_allocated_banks (new member
> of tpm_chip), and replaces the static array with a pointer to a dynamically
> allocated array.
> 
> tpm2_get_pcr_allocation() determines if a PCR bank is allocated by checking
> the mask in the TPML_PCR_SELECTION structure returned by the TPM for
> TPM2_Get_Capability(). If a bank is not allocated, the TPM returns that
> bank in TPML_PCR_SELECTION, with all bits in the mask set to zero. In this
> case, the bank is not included in chip->allocated_banks, to avoid that TPM
> driver users unnecessarily calculate a digest for that bank.
> 
> One PCR bank with algorithm set to SHA1 is always allocated for TPM 1.x.
> 
> As a consequence of the introduction of nr_allocated_banks,
> tpm_pcr_extend() does not check anymore if the algorithm stored in tpm_chip
> is equal to zero.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
