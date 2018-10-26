Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF64AECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F34320868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F34320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeJZWDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:03:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:28840 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbeJZWDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:03:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2018 06:26:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,428,1534834800"; 
   d="scan'208";a="100917176"
Received: from pwolsza-mobl1.ger.corp.intel.com ([10.249.254.37])
  by fmsmga004.fm.intel.com with ESMTP; 26 Oct 2018 06:25:55 -0700
Date:   Fri, 26 Oct 2018 14:25:54 +0100 (IST)
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
Subject: Re: [PATCH v2] tpm: fix kdoc for tpm2_flush_context_cmd()
In-Reply-To: <20181026101558.11753-1-tomas.winkler@intel.com>
Message-ID: <alpine.DEB.2.21.1810261420290.3511@jsakkine-mobl1>
References: <20181026101558.11753-1-tomas.winkler@intel.com>
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
> drivers/char/tpm/tpm2-cmd.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index ae86fb0218ab..ba94dd5f11a4 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -343,10 +343,9 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
> /**
>  * tpm2_flush_context_cmd() - execute a TPM2_FlushContext command
>  * @chip: TPM chip to use
> - * @payload: the key data in clear and encrypted form
> - * @options: authentication values and other options
> + * @handle: context handle
> + * @flags: tpm transmit flags - bitmap
>  *
> - * Return: same as with tpm_transmit_cmd
>  */
> void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
> 			    unsigned int flags)
> -- 
> 2.14.5
>
>

A minor request. There's some convention mismatch in the subsystem.  In
some places the arguments are aligned and in some place they are not.
In order to make educated decision what is right I checked
Documentation/doc-guide/kernel-doc.rst. In the section called 'Function
documentation' they are aligned.

Can you do one more revision where @payload and @options are aligned
(with a tab-character) now that you are updating the kdoc anyway?
Otherwise, this looks good to me.

/Jarkko
