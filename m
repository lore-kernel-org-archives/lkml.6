Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbeCEVMP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 16:12:15 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38453 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752480AbeCEVMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 16:12:12 -0500
X-Google-Smtp-Source: AG47ELsW2ryeCN4yGn+8innZKdpV5kj+G1bdKCl5tS4n7ILv0LMGhHbwrkrFh+qtnCCDad++B+QLTw==
Date: Mon, 5 Mar 2018 14:12:06 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] tpm: sort objects in the Makefile
Message-ID: <20180305211206.GB9335@ziepe.ca>
References: <20180305202017.24008-1-tomas.winkler@intel.com>
 <20180305202017.24008-2-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305202017.24008-2-tomas.winkler@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 10:20:12PM +0200, Tomas Winkler wrote:
> Make the tpm Makefile a bit more in order by putting
> objects in one column and group together tpm2 modules
> 
> Prefer tpm-objs += instead of tpm-y += notation.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
>  drivers/char/tpm/Makefile | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index acd758381c58..2fc0e9a73cd6 100644
> +++ b/drivers/char/tpm/Makefile
> @@ -3,9 +3,17 @@
>  # Makefile for the kernel tpm device drivers.
>  #
>  obj-$(CONFIG_TCG_TPM) += tpm.o
> -tpm-y := tpm-interface.o tpm-dev.o tpm-sysfs.o tpm-chip.o tpm2-cmd.o \
> -	 tpm-dev-common.o tpmrm-dev.o tpm1_eventlog.o tpm2_eventlog.o \
> -         tpm2-space.o
> +tpm-objs := tpm-interface.o
> +tpm-objs += tpm-dev.o
> +tpm-objs += tpm-chip.o
> +tpm-objs += tpm-dev-common.o
> +tpm-objs += tpmrm-dev.o
> +tpm-objs += tpm-sysfs.o
> +tpm-objs += tpm1_eventlog.o
> +tpm-objs += tpm2-cmd.o
> +tpm-objs += tpm2-space.o
> +tpm-objs += tpm2_eventlog.o

If you are going to do this then sort the list please

Seems weird to me though, there are not that many examples of this
pattern in the kernel.

What is wrong with:

tpm-objs := \
	 tpm-interface.o \
	 tpm-dev.o \
	 [..]

?
 
Jason
