Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932314AbeCERvd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 12:51:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:12265 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbeCERvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 12:51:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="209015356"
Date: Mon, 5 Mar 2018 19:51:29 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] tpm: cmd_ready command can be issued only after
 granting locality
Message-ID: <20180305175128.GB5791@linux.intel.com>
References: <20180305113449.8876-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305113449.8876-1-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 01:34:49PM +0200, Tomas Winkler wrote:
> The correct sequence is to first request locality and only after
> that perform cmd_ready handshake, otherwise the hardware will drop
> the subsequent message as from the device point of view the cmd_ready
> handshake wasn't performed. Symmetrically locality has to be relinquished
> only after going idle handshake has completed, this requires that
> go_idle has to poll for the completion and as well locality
> relinquish has to poll for completion so it is not overridden
> in back to back commands flow.
> 
> Two wrapper functions are added (request_locality relinquish_locality)
> to simplify the error handling.
> 
> The issue is only visible on devices that support multiple localities.
> 
> Fixes: 877c57d0d0ca ("tpm_crb: request and relinquish locality 0")
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Tested-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>

/Jarkko
