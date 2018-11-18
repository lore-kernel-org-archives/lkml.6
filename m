Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E589C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 07:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1374620817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 07:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1374620817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeKRSBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 13:01:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:18904 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbeKRSBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 13:01:35 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2018 23:42:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,247,1539673200"; 
   d="scan'208";a="280925295"
Received: from kaczmarx-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.89])
  by fmsmga005.fm.intel.com with ESMTP; 17 Nov 2018 23:42:00 -0800
Date:   Sun, 18 Nov 2018 09:41:58 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tpm: rename data_pending to transmit_result
Message-ID: <20181118074158.GF5897@linux.intel.com>
References: <154239067364.2880.13752725056462237016.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154239067364.2880.13752725056462237016.stgit@tstruk-mobl1.jf.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 09:51:13AM -0800, Tadeusz Struk wrote:
> The file_priv->data_pending name is not adequate as it
> doesn't contain any data, but the result from the last
> successful call to tpm_transmit() function, so rename it
> to transmit_result. Also its type should be size_t instead
> of ssize_t as it will never be negative. Change it as well.
> 
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
> ---
>  drivers/char/tpm/tpm-dev-common.c |   20 ++++++++++----------
>  drivers/char/tpm/tpm-dev.h        |    4 ++--
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index 99b5133a9d05..67a70e2fde7f 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -40,7 +40,7 @@ static void tpm_async_work(struct work_struct *work)
>  
>  	tpm_put_ops(priv->chip);
>  	if (ret > 0) {
> -		priv->data_pending = ret;
> +		priv->transmit_result = ret;

I don't know if you saw my later response before sending this but
since you made the remark that it does not carry the error code
more proper name is response_length because that is exactly the
data it contains.

/Jarkko
