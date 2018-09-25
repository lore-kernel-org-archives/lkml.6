Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922C6C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55370208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55370208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbeIYUaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:30:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:37739 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729152AbeIYUaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:30:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 07:22:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,302,1534834800"; 
   d="scan'208";a="72745800"
Received: from thomasvo-mobl2.ger.corp.intel.com ([10.252.53.212])
  by fmsmga007.fm.intel.com with ESMTP; 25 Sep 2018 07:14:58 -0700
Message-ID: <a778571533dced1fbf2a0883848972934f145eff.camel@linux.intel.com>
Subject: Re: [PATCH v4 02/21] tpm: sort objects in the Makefile
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Sep 2018 17:14:57 +0300
In-Reply-To: <20180921135820.20549-3-tomas.winkler@intel.com>
References: <20180921135820.20549-1-tomas.winkler@intel.com>
         <20180921135820.20549-3-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-09-21 at 16:58 +0300, Tomas Winkler wrote:
> Make the tpm Makefile a bit more in order by putting
> objects in one column.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
> V2: 1. back to tpm-y notation
>     2. Partially sort files alphanumerically.
> V3: Rebase
> V4: Remove redunant sentence in commit message.
> 
>  drivers/char/tpm/Makefile | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 4e9c33ca1f8f..efc785053627 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -3,9 +3,18 @@
>  # Makefile for the kernel tpm device drivers.
>  #
>  obj-$(CONFIG_TCG_TPM) += tpm.o
> -tpm-y := tpm-interface.o tpm-dev.o tpm-sysfs.o tpm-chip.o tpm2-cmd.o \
> -	 tpm-dev-common.o tpmrm-dev.o eventlog/common.o eventlog/tpm1.o \
> -	 eventlog/tpm2.o tpm2-space.o
> +tpm-y := tpm-chip.o
> +tpm-y += tpm-dev-common.o
> +tpm-y += tpm-dev.o
> +tpm-y += tpm-interface.o
> +tpm-y += tpm2-cmd.o
> +tpm-y += tpmrm-dev.o
> +tpm-y += tpm2-space.o
> +tpm-y += tpm-sysfs.o
> +tpm-y += eventlog/common.o
> +tpm-y += eventlog/tpm1.o
> +tpm-y += eventlog/tpm2.o
> +
>  tpm-$(CONFIG_ACPI) += tpm_ppi.o eventlog/acpi.o
>  tpm-$(CONFIG_EFI) += eventlog/efi.o
>  tpm-$(CONFIG_OF) += eventlog/of.o

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
