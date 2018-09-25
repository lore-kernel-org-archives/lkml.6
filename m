Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEC0C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A9A20645
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A9A20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbeIYUqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:46:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:27643 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbeIYUqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:46:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 07:39:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,302,1534834800"; 
   d="scan'208";a="86416666"
Received: from thomasvo-mobl2.ger.corp.intel.com ([10.252.53.212])
  by orsmga003.jf.intel.com with ESMTP; 25 Sep 2018 07:39:02 -0700
Message-ID: <bf9342175181934b1324d3cf118dca3d41268685.camel@linux.intel.com>
Subject: Re: [PATCH v4 14/21] tpm: tpm-interface.c drop unused macros
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Sep 2018 17:39:01 +0300
In-Reply-To: <20180921135820.20549-15-tomas.winkler@intel.com>
References: <20180921135820.20549-1-tomas.winkler@intel.com>
         <20180921135820.20549-15-tomas.winkler@intel.com>
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
> The commit:
> "tpm_tis: further simplify calculation of ordinal duration"
> left unused macros, we can drop them now.
> 
> Fixes compilation warnings:
> tpm-interface.c:37:0: warning: macro "TPM_PROTECTED_COMMAND" is not used [-
> Wunused-macros]
> tpm-interface.c:36:0: warning: macro "TSC_MAX_ORDINAL" is not used [-Wunused-
> macros]
> tpm-interface.c:38:0: warning: macro "TPM_CONNECTION_COMMAND" is not used [-
> Wunused-macros]
> 
> Fixes: f72864300139 ("tpm_tis: further simplify calculation of ordinal
> duration")
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
> V3: New in the series.
> V4: Fix the commit message.
> 
>  drivers/char/tpm/tpm-interface.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-
> interface.c
> index 6cd3aed1e190..d7059fc72c51 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -33,10 +33,6 @@
>  
>  #include "tpm.h"
>  
> -#define TSC_MAX_ORDINAL 12
> -#define TPM_PROTECTED_COMMAND 0x00
> -#define TPM_CONNECTION_COMMAND 0x40
> -
>  /*
>   * Bug workaround - some TPM's don't flush the most
>   * recently changed pcr on suspend, so force the flush

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
