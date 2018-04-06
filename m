Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752236AbeDFKbI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 06:31:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:54892 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751494AbeDFKbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 06:31:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,415,1517904000";
   d="scan'208";a="43958828"
Date: Fri, 6 Apr 2018 13:31:01 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>, tomas.winkler@intel.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH v4 0/4] Migrate all TPM 2.0 commands to use struct tpm_buf
Message-ID: <20180406103101.GA14379@linux.intel.com>
References: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 03:14:02PM +0300, Jarkko Sakkinen wrote:
> In order to make struct tpm_buf the first class object for constructing TPM
> commands, this patch set migrates all TPM 2.0 commands to use it. Eventually,
> tpm_transmit_cmd() can take simply struct tpm_buf as its argument and this
> interface can be exported to be used by the kernel keyring and potentially
> other subsystems.
> 
> The ultimate goal of this work is to make constructing TPM commands inside
> the kernel simple and robust.

I pushed these commits to the master branch. Please report if you have
any issues. If the master branch continues working for you, as you test
it maybe for other reasons, I'm happy to get tested-by's for them. At
worst they have regressions. I seriously don't think that the code
changes have any major structural issues.

I would guess that Tomas' similar changes for TPM 1.x will follow at
some point. I'm looking forward to change the existing tpm_send()
as one that takes tpm_buf in. That will allow to remove a lot of
cruft code from keyring.

I take no rush to merge these to 'next' but I think it is fine to
have these in the bleeding edge.

/Jarkko
