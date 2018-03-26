Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeCZUJm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 16:09:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:35041 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751076AbeCZUJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 16:09:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,365,1517904000";
   d="scan'208";a="214848069"
Date: Mon, 26 Mar 2018 23:09:36 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] tpm: separate cmd_ready/go_idle from runtime_pm
Message-ID: <20180326200936.GA3810@linux.intel.com>
References: <20180324183935.20784-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180324183935.20784-1-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 24, 2018 at 09:39:35PM +0300, Tomas Winkler wrote:
> From: "Winkler, Tomas" <tomas.winkler@intel.com>
> 
> We cannot use go_idle cmd_ready commands via runtime_pm handles
> as with the introduction of localities this is no longer an optional
> feature, while runtime pm can be not enabled.
> Though cmd_ready/go_idle provides power saving feature, it's also part of
> TPM2 protocol and should be called explicitly.
> This patch exposes cmd_read/go_idle via tpm class ops and removes
> runtime pm support as it is not used by any driver.
> 
> tpm_crb no longer needs own power saving functions and can drop using
> tpm_pm_suspend/resume.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Still fails on Kabylake exactly the same way. With this I get
RC_UNBALANCED in these four test cases:

test_flush_context (tpm2_smoke.SpaceTest) ... ERROR
test_get_handles (tpm2_smoke.SpaceTest) ... ERROR
test_make_two_spaces (tpm2_smoke.SpaceTest) ... ERROR

Without this patch applied these errors do not occur.

/Jarkko
