Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F04C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB33206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB33206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbeIYUsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:48:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:65095 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729098AbeIYUsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:48:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 07:40:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,302,1534834800"; 
   d="scan'208";a="94666561"
Received: from thomasvo-mobl2.ger.corp.intel.com ([10.252.53.212])
  by orsmga002.jf.intel.com with ESMTP; 25 Sep 2018 07:39:59 -0700
Message-ID: <c242ab6816a88011db52c658a3f5418f95ad49c4.camel@linux.intel.com>
Subject: Re: [PATCH v4 18/21] tmp1: rename tpm1_pcr_read_dev to
 tpm1_pcr_read().
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Sep 2018 17:39:58 +0300
In-Reply-To: <20180921135820.20549-19-tomas.winkler@intel.com>
References: <20180921135820.20549-1-tomas.winkler@intel.com>
         <20180921135820.20549-19-tomas.winkler@intel.com>
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
> Rename tpm1_pcr_read_dev to tpm1_pcr_read() to match
> the counterpart tpm2_pcr_read().
> 
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
> V4: New in the series.
> 
>  drivers/char/tpm/tpm-interface.c | 2 +-
>  drivers/char/tpm/tpm-sysfs.c     | 2 +-
>  drivers/char/tpm/tpm.h           | 2 +-
>  drivers/char/tpm/tpm1-cmd.c      | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-
> interface.c
> index c84d8cf84f7d..a6d9d148a3bc 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -465,7 +465,7 @@ int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u8
> *res_buf)
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  		rc = tpm2_pcr_read(chip, pcr_idx, res_buf);
>  	else
> -		rc = tpm1_pcr_read_dev(chip, pcr_idx, res_buf);
> +		rc = tpm1_pcr_read(chip, pcr_idx, res_buf);
>  
>  	tpm_put_ops(chip);
>  	return rc;
> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> index 861acafd8f29..96fc7433c57d 100644
> --- a/drivers/char/tpm/tpm-sysfs.c
> +++ b/drivers/char/tpm/tpm-sysfs.c
> @@ -114,7 +114,7 @@ static ssize_t pcrs_show(struct device *dev, struct
> device_attribute *attr,
>  
>  	num_pcrs = be32_to_cpu(cap.num_pcrs);
>  	for (i = 0; i < num_pcrs; i++) {
> -		rc = tpm1_pcr_read_dev(chip, i, digest);
> +		rc = tpm1_pcr_read(chip, i, digest);
>  		if (rc)
>  			break;
>  		str += sprintf(str, "PCR-%02d: ", i);
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index d0402aa122ec..2f06740f993d 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -525,7 +525,7 @@ int tpm1_get_timeouts(struct tpm_chip *chip);
>  unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
>  int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
>  		    const char *log_msg);
> -int tpm1_pcr_read_dev(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
> +int tpm1_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
>  ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
>  		    const char *desc, size_t min_cap_length);
>  int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max);
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index 8fd67be2d44a..ef37c91b6844 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -574,7 +574,7 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest,
> size_t max)
>  }
>  
>  #define TPM_ORD_PCRREAD 21
> -int tpm1_pcr_read_dev(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
> +int tpm1_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
>  {
>  	struct tpm_buf buf;
>  	int rc;
> @@ -662,7 +662,7 @@ int tpm1_do_selftest(struct tpm_chip *chip)
>  
>  	do {
>  		/* Attempt to read a PCR value */
> -		rc = tpm1_pcr_read_dev(chip, 0, dummy);
> +		rc = tpm1_pcr_read(chip, 0, dummy);
>  
>  		/* Some buggy TPMs will not respond to tpm_tis_ready() for
>  		 * around 300ms while the self test is ongoing, keep trying


Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
