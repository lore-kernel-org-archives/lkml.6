Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754867AbeEALtq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 07:49:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:20976 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751920AbeEALto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 07:49:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,350,1520924400";
   d="scan'208";a="52240613"
Date: Tue, 1 May 2018 14:49:40 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Thiebaud Weksteen <tweek@google.com>
Cc: nayna@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] tpm: Add explicit endianness cast
Message-ID: <20180501114940.GD20978@linux.intel.com>
References: <20180425132641.106385-1-tweek@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425132641.106385-1-tweek@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 03:26:41PM +0200, Thiebaud Weksteen wrote:
> Signed-off-by: Thiebaud Weksteen <tweek@google.com>
> ---
>  drivers/char/tpm/tpm_eventlog_of.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_eventlog_of.c b/drivers/char/tpm/tpm_eventlog_of.c
> index 96fd5646f866..ea0f16f19d73 100644
> --- a/drivers/char/tpm/tpm_eventlog_of.c
> +++ b/drivers/char/tpm/tpm_eventlog_of.c
> @@ -56,8 +56,8 @@ int tpm_read_log_of(struct tpm_chip *chip)
>  	 * but physical tpm needs the conversion.
>  	 */
>  	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0) {
> -		size = be32_to_cpup(sizep);
> -		base = be64_to_cpup(basep);
> +		size = be32_to_cpup((__force __be32 *)sizep);
> +		base = be64_to_cpup((__force __be64 *)basep);
>  	} else {
>  		size = *sizep;
>  		base = *basep;
> -- 
> 2.17.0.484.g0c8726318c-goog
> 

Repeal and replace, right (no change log)?

/Jarkko
