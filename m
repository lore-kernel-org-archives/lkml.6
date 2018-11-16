Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849C9C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3189C2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3189C2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389914AbeKPXtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:49:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:51187 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbeKPXs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:48:59 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 05:36:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,240,1539673200"; 
   d="scan'208";a="281677638"
Received: from unknown (HELO localhost) ([10.249.254.86])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2018 05:36:31 -0800
Date:   Fri, 16 Nov 2018 15:36:30 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v5 1/7] tpm: dynamically allocate the allocated_banks
 array
Message-ID: <20181116133630.GA4163@linux.intel.com>
References: <20181114153108.12907-1-roberto.sassu@huawei.com>
 <20181114153108.12907-2-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114153108.12907-2-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 04:31:02PM +0100, Roberto Sassu wrote:
> This patch renames active_banks (member of tpm_chip) to allocated_banks,
> stores the number of allocated PCR banks in nr_allocated_banks (new member
> of tpm_chip), and replaces the static array with a pointer to a dynamically
> allocated array.
> 
> tpm2_get_pcr_allocation() determines if a PCR bank is allocated by checking
> the mask in the TPML_PCR_SELECTION structure returned by the TPM for
> TPM2_Get_Capability(). One PCR bank with algorithm set to SHA1 is always
> allocated for TPM 1.x.
> 
> As a consequence of the introduction of nr_allocated_banks,
> tpm_pcr_extend() does not check anymore if the algorithm stored in tpm_chip
> is equal to zero.
> 
> Fixes: 1db15344f874 ("tpm: implement TPM 2.0 capability to get active
> PCR banks")
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

There should not be a newline between tags and I don't think this should
have fixes tag. Otherwise, looks good.

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
