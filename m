Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeCPNC4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 09:02:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:64845 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750749AbeCPNCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 09:02:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,315,1517904000";
   d="scan'208";a="24611624"
Date: Fri, 16 Mar 2018 15:02:50 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, hdegoede@redhat.com,
        tweek@google.com, javierm@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] efi/libstub: tpm: zero initialize pointer variables
 for mixed mode
Message-ID: <20180316130250.GD5035@linux.intel.com>
References: <20180313140922.17266-1-ard.biesheuvel@linaro.org>
 <20180313140922.17266-2-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313140922.17266-2-ard.biesheuvel@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 02:09:21PM +0000, Ard Biesheuvel wrote:
> As reported by Jeremy, running the new TPM libstub code in mixed mode
> (i.e., 64-bit kernel on 32-bit UEFI) results in hangs when invoking
> the TCG2 protocol, or when accessing the log_tbl pool allocation.
> 
> The reason turns out to be that in both cases, the 64-bit pointer
> variables are not fully initialized by the 32-bit EFI code, and so
> we should take care to zero initialize these variables beforehand,
> or we'll end up dereferencing bogus pointers.
> 
> Reported-by: Jeremy Cline <jeremy@jcline.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
