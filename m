Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B3AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCC221721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfBGVQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:16:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:2018 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfBGVQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:16:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 13:16:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,345,1544515200"; 
   d="scan'208";a="145063905"
Received: from mwesterb-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.154])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2019 13:16:41 -0800
Date:   Thu, 7 Feb 2019 23:16:40 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: linux-next: build warning after merge of the tpmdd tree
Message-ID: <20190207211640.GA23906@linux.intel.com>
References: <20190207134733.05a8e55a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207134733.05a8e55a@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 01:47:33PM +1100, Stephen Rothwell wrote:
> Hi Jarkko,
> 
> After merging the tpmdd tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> drivers/char/tpm/tpm_i2c_nuvoton.c:45: warning: "TPM_RETRY" redefined
>  #define TPM_RETRY      5
>  
> In file included from drivers/char/tpm/tpm_i2c_nuvoton.c:35:
> drivers/char/tpm/tpm.h:43: note: this is the location of the previous definition
>  #define TPM_RETRY  50
>  
> drivers/char/tpm/tpm_i2c_infineon.c:30: warning: "TPM_BUFSIZE" redefined
>  #define TPM_BUFSIZE 1260
>  
> In file included from drivers/char/tpm/tpm_i2c_infineon.c:27:
> drivers/char/tpm/tpm.h:41: note: this is the location of the previous definition
>  #define TPM_BUFSIZE  4096
>  
> In file included from drivers/char/tpm/st33zp24/i2c.c:30:
> drivers/char/tpm/st33zp24/st33zp24.h:22: warning: "TPM_BUFSIZE" redefined
>  #define TPM_BUFSIZE                     2048
>  
> In file included from drivers/char/tpm/st33zp24/i2c.c:29:
> drivers/char/tpm/st33zp24/../tpm.h:41: note: this is the location of the previous definition
>  #define TPM_BUFSIZE  4096
>  
> In file included from drivers/char/tpm/st33zp24/spi.c:30:
> drivers/char/tpm/st33zp24/st33zp24.h:22: warning: "TPM_BUFSIZE" redefined
>  #define TPM_BUFSIZE                     2048
>  
> In file included from drivers/char/tpm/st33zp24/spi.c:29:
> drivers/char/tpm/st33zp24/../tpm.h:41: note: this is the location of the previous definition
>  #define TPM_BUFSIZE  4096
>  
> In file included from drivers/char/tpm/st33zp24/st33zp24.c:34:
> drivers/char/tpm/st33zp24/st33zp24.h:22: warning: "TPM_BUFSIZE" redefined
>  #define TPM_BUFSIZE                     2048
>  
> In file included from drivers/char/tpm/st33zp24/st33zp24.c:33:
> drivers/char/tpm/st33zp24/../tpm.h:41: note: this is the location of the previous definition
>  #define TPM_BUFSIZE  4096
>  
> In file included from drivers/char/tpm/st33zp24/st33zp24.c:34:
> drivers/char/tpm/st33zp24/st33zp24.h:22: warning: "TPM_BUFSIZE" redefined
>  #define TPM_BUFSIZE                     2048
>  
> In file included from drivers/char/tpm/st33zp24/st33zp24.c:33:
> drivers/char/tpm/st33zp24/../tpm.h:41: note: this is the location of the previous definition
>  #define TPM_BUFSIZE  4096
>  
> 
> Introduced by commit
> 
>   569c1057f9ac ("tpm: move tpm_chip definition to include/linux/tpm.h")

Hi I forgot apply this before that commit:

tpm: Fix some name collisions with drivers/char/tpm.h

* Rename TPM_BUFSIZE defined in drivers/char/tpm/st33zp24/st33zp24.h to
  ST33ZP24_BUFSIZE.
* Rename TPM_BUFSIZE defined in drivers/char/tpm/tpm_i2c_infineon.c to
  TPM_I2C_INFINEON_BUFSIZE.
* Rename TPM_RETRY in tpm_i2c_nuvoton to TPM_I2C_RETRIES.
* Remove TPM_HEADER_SIZE from tpm_i2c_nuvoton.

Cc: stable@vger.kernel.org
Fixes: bf38b8710892 ("tpm/tpm_i2c_stm_st33: Split tpm_i2c_tpm_st33 in 2 layers (core + phy)")
Fixes: aad628c1d91a ("char/tpm: Add new driver for Infineon I2C TIS TPM")
Fixes: 32d33b29ba07 ("TPM: Retry SaveState command in suspend path")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

It is now pushed.

/Jarkko
