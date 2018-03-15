Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeCOQcv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:32:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:41645 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeCOQct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:32:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,311,1517904000";
   d="scan'208";a="39200644"
Message-ID: <9c096454a78283ee3871b5dd47ed0bf664d26b7e.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/8] tpm: factor out tpm1_get_random into tpm1-cmd.c
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Thu, 15 Mar 2018 18:32:44 +0200
In-Reply-To: <20180310082428.31519-4-tomas.winkler@intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
         <20180310082428.31519-4-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.27.90-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> +		rlength = be32_to_cpu(tpm_cmd.header.out.length);
> +		if (rlength < offsetof(struct tpm_getrandom_out, rng_data) +
> +			      recd) {
> +			total = -EFAULT;
> +			break;
> +		}
> +		memcpy(dest, tpm_cmd.params.getrandom_out.rng_data, recd);

This rlength stuff can be handled with tpm_buf_length() as I do
in my pendig-for-review patch set:

https://patchwork.kernel.org/patch/10259331/

/Jarkko
