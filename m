Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78995C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5463F20856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfA2UOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:14:08 -0500
Received: from mga09.intel.com ([134.134.136.24]:40903 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbfA2UOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:14:08 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 12:14:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,538,1539673200"; 
   d="scan'208";a="314638555"
Received: from rkazants-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.254.212])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jan 2019 12:14:01 -0800
Date:   Tue, 29 Jan 2019 22:14:05 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        matthewgarrett@google.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v8 4/7] tpm: retrieve digest size of unknown algorithms
 with PCR read
Message-ID: <20190129201405.GC11615@linux.intel.com>
References: <20190124154910.29948-1-roberto.sassu@huawei.com>
 <20190124154910.29948-5-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124154910.29948-5-roberto.sassu@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 04:49:07PM +0100, Roberto Sassu wrote:
> Currently, the TPM driver retrieves the digest size from a table mapping
> TPM algorithms identifiers to identifiers defined by the crypto subsystem.
> If the algorithm is not defined by the latter, the digest size can be
> retrieved from the output of the PCR read command.
> 
> The patch modifies the definition of tpm_pcr_read() and tpm2_pcr_read() to
> pass the desired hash algorithm and obtain the digest size at TPM startup.
> Algorithms and corresponding digest sizes are stored in the new structure
> tpm_bank_info, member of tpm_chip, so that the information can be used by
> other kernel subsystems.
> 
> tpm_bank_info contains: the TPM algorithm identifier, necessary to generate
> the event log as defined by Trusted Computing Group (TCG); the digest size,
> to pad/truncate a digest calculated with a different algorithm; the crypto
> subsystem identifier, to calculate the digest of event data.
> 
> This patch also protects against data corruption that could happen in the
> bus, by checking that the digest size returned by the TPM during a PCR read
> matches the size of the algorithm passed to tpm2_pcr_read().
> 
> For the initial PCR read, when digest sizes are not yet available, this
> patch ensures that the amount of data copied from the output returned by
> the TPM does not exceed the size of the array data are copied to.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
