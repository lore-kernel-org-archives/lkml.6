Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeBTO6a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 09:58:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:64516 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751476AbeBTO61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 09:58:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,539,1511856000";
   d="scan'208";a="18955578"
Message-ID: <1519138703.26293.2.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: use kmemdup() to copy the EFI event log
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>
Date: Tue, 20 Feb 2018 16:58:23 +0200
In-Reply-To: <20180219121026.14304-1-jarkko.sakkinen@linux.intel.com>
References: <20180219121026.14304-1-jarkko.sakkinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Send an updated version with corresponding change also to
tpm_eventlog_of.c

/Jarkko

On Mon, 2018-02-19 at 14:10 +0200, Jarkko Sakkinen wrote:
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  drivers/char/tpm/tpm_eventlog_efi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_eventlog_efi.c
> b/drivers/char/tpm/tpm_eventlog_efi.c
> index e3f9ffd341d2..57c8b3cc46be 100644
> --- a/drivers/char/tpm/tpm_eventlog_efi.c
> +++ b/drivers/char/tpm/tpm_eventlog_efi.c
> @@ -50,10 +50,9 @@ int tpm_read_log_efi(struct tpm_chip *chip)
>  	}
>  
>  	/* malloc EventLog space */
> -	log->bios_event_log = kmalloc(log_size, GFP_KERNEL);
> +	log->bios_event_log = kmemdup(log_tbl->log, log_size,
> GFP_KERNEL);
>  	if (!log->bios_event_log)
>  		goto err_memunmap;
> -	memcpy(log->bios_event_log, log_tbl->log, log_size);
>  	log->bios_event_log_end = log->bios_event_log + log_size;
>  
>  	tpm_log_version = log_tbl->version;
