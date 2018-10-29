Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9914DC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB7F2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB7F2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbeJ2XFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:05:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:15879 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbeJ2XFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:05:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 07:16:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,440,1534834800"; 
   d="scan'208";a="81799828"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.111])
  by fmsmga007.fm.intel.com with ESMTP; 29 Oct 2018 07:16:21 -0700
Date:   Mon, 29 Oct 2018 16:16:20 +0200 (EET)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     Tomas Winkler <tomas.winkler@intel.com>
cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tpm: fix kdoc for tpm2_flush_context_cmd()
In-Reply-To: <20181026184043.5524-1-tomas.winkler@intel.com>
Message-ID: <alpine.DEB.2.21.1810291615520.28525@jsakkine-mobl1>
References: <20181026184043.5524-1-tomas.winkler@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2018, Tomas Winkler wrote:
> kdoc for tpm2_flush_context_cmd() was off.
>
> Fixes: 9aa36b399a50 ("tpm: export tpm2_flush_context_cmd")'
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
> V2: drop 'commit' from Fixes:
> V3: Align arguments with tab.
> drivers/char/tpm/tpm2-cmd.c | 7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index ae86fb0218ab..a6bec13afa69 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -342,11 +342,10 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>
> /**
>  * tpm2_flush_context_cmd() - execute a TPM2_FlushContext command
> - * @chip: TPM chip to use
> - * @payload: the key data in clear and encrypted form
> - * @options: authentication values and other options
> + * @chip:	TPM chip to use
> + * @handle:	context handle
> + * @flags:	tpm transmit flags - bitmap
>  *
> - * Return: same as with tpm_transmit_cmd
>  */
> void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
> 			    unsigned int flags)
> -- 
> 2.14.5
>
>

Great, thank you.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
