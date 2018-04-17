Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeDQDCI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 23:02:08 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39527 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeDQDCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 23:02:06 -0400
X-Google-Smtp-Source: AIpwx48cq6pq907a+LTjDXKhJAWoVIQ1AO/I7bEPHwc4X46EC7QkLXie1PRuVIbAdXhQ7HbPMalNgw==
Date: Mon, 16 Apr 2018 21:02:02 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thiebaud Weksteen <tweek@google.com>
Cc: jarkko.sakkinen@linux.intel.com, nayna@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tpm: Add explicit endianness cast
Message-ID: <20180417030202.GA30624@ziepe.ca>
References: <20180412101350.210547-1-tweek@google.com>
 <20180412101350.210547-2-tweek@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412101350.210547-2-tweek@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 12:13:47PM +0200, Thiebaud Weksteen wrote:
> Signed-off-by: Thiebaud Weksteen <tweek@google.com>
>  drivers/char/tpm/tpm_eventlog_of.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_eventlog_of.c b/drivers/char/tpm/tpm_eventlog_of.c
> index 96fd5646f866..d74568d58a66 100644
> +++ b/drivers/char/tpm/tpm_eventlog_of.c
> @@ -56,8 +56,8 @@ int tpm_read_log_of(struct tpm_chip *chip)
>  	 * but physical tpm needs the conversion.
>  	 */
>  	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0) {
> -		size = be32_to_cpup(sizep);
> -		base = be64_to_cpup(basep);
> +		size = be32_to_cpup((__be32 *)sizep);
> +		base = be64_to_cpup((__be64 *)basep);

Er, no.. change the definitions of sizep and basep to be __be

Jason
