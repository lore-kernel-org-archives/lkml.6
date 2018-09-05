Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED5DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FB920861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FB920861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeIEP6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:58:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:55557 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbeIEP6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:58:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 04:28:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,333,1531810800"; 
   d="scan'208";a="83207174"
Received: from kfitzx-mobl.ger.corp.intel.com (HELO localhost) ([10.252.37.75])
  by fmsmga002.fm.intel.com with ESMTP; 05 Sep 2018 04:28:49 -0700
Date:   Wed, 5 Sep 2018 14:28:47 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Peter Huewe <peterhuewe@gmx.de>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tpm: Make SECURITYFS a weak dependency
Message-ID: <20180905112847.GC9696@linux.intel.com>
References: <20180903195151.7576-1-peterhuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903195151.7576-1-peterhuewe@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 09:51:51PM +0200, Peter Huewe wrote:
> While having SECURITYFS enabled for the tpm subsystem is beneficial in
> most cases, it is not strictly necessary to have it enabled at all.
> Especially on platforms without any boot firmware integration of the TPM
> (e.g. raspberry pi) it does not add any value for the tpm subsystem,
> as there is no eventlog present.
> 
> By turning it from 'select' to 'imply' it still gets selected per
> default, but enables users who want to save some kb of ram by turning
> SECURITYFS off.
> 
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> ---
>  drivers/char/tpm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 18c81cbe4704..536e55d3919f 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -5,7 +5,7 @@
>  menuconfig TCG_TPM
>  	tristate "TPM Hardware Support"
>  	depends on HAS_IOMEM
> -	select SECURITYFS
> +	imply SECURITYFS
>  	select CRYPTO
>  	select CRYPTO_HASH_INFO
>  	---help---
> -- 
> 2.16.4
> 

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
