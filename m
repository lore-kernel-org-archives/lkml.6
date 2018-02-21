Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeBUHbj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 02:31:39 -0500
Received: from mga12.intel.com ([192.55.52.136]:33285 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751295AbeBUHbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 02:31:38 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,543,1511856000";
   d="scan'208";a="28690543"
Date: Wed, 21 Feb 2018 09:31:32 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] tpm: Trigger only missing TPM 2.0 self tests
Message-ID: <20180221073132.vrznvdp5oh7w6n53@linux.intel.com>
References: <20180220225347.25448-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220225347.25448-1-jarkko.sakkinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 12:53:47AM +0200, Jarkko Sakkinen wrote:
> From: Alexander Steffen <Alexander.Steffen@infineon.com>
> 
> My Nuvoton 6xx in a Dell XPS-13 has been intermittently failing to work
> (necessitating a reboot). The problem seems to be that the TPM gets into a
> state where the partial self-test doesn't return TPM_RC_SUCCESS (meaning
> all tests have run to completion), but instead returns TPM_RC_TESTING
> (meaning some tests are still running in the background).  There are
> various theories that resending the self-test command actually causes the
> tests to restart and thus triggers more TPM_RC_TESTING returns until the
> timeout is exceeded.
> 
> There are several issues here: firstly being we shouldn't slow down the
> boot sequence waiting for the self test to complete once the TPM
> backgrounds them.  It will actually make available all functions that have
> passed and if it gets a failure return TPM_RC_FAILURE to every subsequent
> command.  So the fix is to kick off self tests once and if they return
> TPM_RC_TESTING log that as a backgrounded self test and continue on.  In
> order to prevent other tpm users from seeing any TPM_RC_TESTING returns
> (which it might if they send a command that needs a TPM subsystem which is
> still under test), we loop in tpm_transmit_cmd until either a timeout or we
> don't get a TPM_RC_TESTING return.
> 
> Finally, there have been observations of strange returns from a partial
> test. One Nuvoton is occasionally returning TPM_RC_COMMAND_CODE, so treat
> any unexpected return from a partial self test as an indication we need to
> run a full self test.
> 
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>
> Fixes: 2482b1bba5122b1d5516c909832bdd282015b8e9

Fixes tag is in wrong format. Should be 12 characters of the hash and
short summary in parentheses:

Fixes: 2482b1bba512 ("tpm: Trigger only missing TPM 2.0 self tests")

/Jarkko
