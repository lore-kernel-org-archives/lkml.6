Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA45C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 02:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBC0218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 02:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiDeuYOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbeL2Cyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 21:54:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45767 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729989AbeL2Cyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 21:54:35 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so11142361pfd.12;
        Fri, 28 Dec 2018 18:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=WUAtqobh7Xcno2LIvb7W9X+mq0KfYPosTfTprbHNNSo=;
        b=FiDeuYOXGUwhSjaswYEv3T7Sex4I/j9YGWf2+VEd0YidfDCswDHCepi6zqLxfyDI/W
         jVMoSvw6wP01D9SWQx08fmyrmGZpmrKZHmu44wly67YiVpb5QEAdSGVR16k+6piEtssV
         EWLEqwa6CdJa13JwzKvS25yi9wSbY65mhyc1HvHyDtL5H4bETcmuyI6v0bhq++nQbRaq
         3Hnh0qqDh74Yh0J57c5C2l2ntDEkDuXXsE79rwnYsYTdJaW8Zi0ZYtnbfLSsMnHIfuma
         9THW0KUGI1wEs2Ucny4DN0RAE/V9Hk9UXsNONf2mNcVTzZaluHxY8OTI0hW1AoSOnuIs
         VRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=WUAtqobh7Xcno2LIvb7W9X+mq0KfYPosTfTprbHNNSo=;
        b=ALzyRV4Bels+TPPE1TaIAlu2CVnefrG7wBeq8cfeCLF/AhpxKfS9kcMwkx7BkVLe2U
         zSemnQs37R10wzakPNZS7ReqVnjrpz9LVumPWTmVzqa3vTsmZEs8bXz1sTnqJ37OVwma
         xynybLa2+BbrLEvYNW6OLVzvDj4VVrPussg+DwWYc5p7Kp9dLRzQJzUdC9NxLLTZxB3E
         Z4tV9XoMDkQEX4X+jFKqzD8KnCfo89fNVbOUv5lG7XMN5GFpXmVBZ8IdP1AgRYLVZ2Vi
         qYm+WcVx8oB9qSOejtO5E8IqjhFDLxN0H1Yga1g4+lq2jq2VIYVOcN04sGwv1S4ccLmM
         8VFA==
X-Gm-Message-State: AJcUukeV1FC6jZ3Ppvm/7rQCiYh2N53/LEVTiukrG0fbuQX9OkcmGsHA
        xJmlLAzXMOey8VygAOpTCUi0FYv0
X-Google-Smtp-Source: ALg8bN4aQji1O24JaqrLyf4HHDrY9L+ySaCDNZFmrl6fJEVAqbkpZ0jOD9AUqCYz57z9dkS64vlVuQ==
X-Received: by 2002:a63:1e17:: with SMTP id e23mr384531pge.130.1546052074054;
        Fri, 28 Dec 2018 18:54:34 -0800 (PST)
Received: from [192.168.1.101] (122-58-176-92-adsl.sparkbb.co.nz. [122.58.176.92])
        by smtp.gmail.com with ESMTPSA id h185sm41475180pfg.143.2018.12.28.18.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 18:54:33 -0800 (PST)
Subject: Re: [PATCH v8 01/25] scsi/atari_scsi: Don't select CONFIG_NVRAM
To:     Finn Thain <fthain@telegraphics.com.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <e68fcc3ec0a6cd4e14f763366d4d9445890b9b82.1545784679.git.fthain@telegraphics.com.au>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <1ece01a1-dc68-daa3-218c-4b3d45375861@gmail.com>
Date:   Sat, 29 Dec 2018 15:54:24 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <e68fcc3ec0a6cd4e14f763366d4d9445890b9b82.1545784679.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Am 26.12.2018 um 13:37 schrieb Finn Thain:
> On powerpc, setting CONFIG_NVRAM=n builds a kernel with no NVRAM support.
> Setting CONFIG_NVRAM=m enables the /dev/nvram misc device module without
> enabling NVRAM support in drivers. Setting CONFIG_NVRAM=y enables the
> misc device (built-in) and also enables NVRAM support in drivers.
>
> m68k shares the valkyriefb driver with powerpc, and since that driver uses
> NVRAM, it is affected by CONFIG_ATARI_SCSI, because of the use of
> "select NVRAM".
>
> Adopt the powerpc convention on m68k to avoid surprises.
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Tested-by: Christian T. Steigies <cts@debian.org>

Acked-by: Michael Schmitz <schmitzmic@gmail.com>

> ---
> This patch temporarily disables CONFIG_NVRAM on Atari, to prevent build
> failures when bisecting the rest of this patch series. It gets enabled
> again with the introduction of CONFIG_HAVE_ARCH_NVRAM_OPS, once the
> nvram_* global functions have been moved to an ops struct.
> ---
>  drivers/char/Kconfig      | 5 +----
>  drivers/scsi/Kconfig      | 6 +++---
>  drivers/scsi/atari_scsi.c | 7 ++++---
>  3 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 9d03b2ff5df6..5b54595dfe30 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -236,7 +236,7 @@ source "drivers/char/hw_random/Kconfig"
>
>  config NVRAM
>  	tristate "/dev/nvram support"
> -	depends on ATARI || X86 || GENERIC_NVRAM
> +	depends on X86 || GENERIC_NVRAM
>  	---help---
>  	  If you say Y here and create a character special file /dev/nvram
>  	  with major number 10 and minor number 144 using mknod ("man mknod"),
> @@ -254,9 +254,6 @@ config NVRAM
>  	  should NEVER idly tamper with it. See Ralf Brown's interrupt list
>  	  for a guide to the use of CMOS bytes by your BIOS.
>
> -	  On Atari machines, /dev/nvram is always configured and does not need
> -	  to be selected.
> -
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called nvram.
>
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index 640cd1b31a18..924eb69e7fc4 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -1381,14 +1381,14 @@ config ATARI_SCSI
>  	tristate "Atari native SCSI support"
>  	depends on ATARI && SCSI
>  	select SCSI_SPI_ATTRS
> -	select NVRAM
>  	---help---
>  	  If you have an Atari with built-in NCR5380 SCSI controller (TT,
>  	  Falcon, ...) say Y to get it supported. Of course also, if you have
>  	  a compatible SCSI controller (e.g. for Medusa).
>
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called atari_scsi.
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called atari_scsi. If you also enable NVRAM support, the SCSI
> +	  host's ID is taken from the setting in TT RTC NVRAM.
>
>  	  This driver supports both styles of NCR integration into the
>  	  system: the TT style (separate DMA), and the Falcon style (via
> diff --git a/drivers/scsi/atari_scsi.c b/drivers/scsi/atari_scsi.c
> index 89f5154c40b6..99e5729d910d 100644
> --- a/drivers/scsi/atari_scsi.c
> +++ b/drivers/scsi/atari_scsi.c
> @@ -755,9 +755,10 @@ static int __init atari_scsi_probe(struct platform_device *pdev)
>  	if (ATARIHW_PRESENT(TT_SCSI) && setup_sg_tablesize >= 0)
>  		atari_scsi_template.sg_tablesize = setup_sg_tablesize;
>
> -	if (setup_hostid >= 0) {
> +	if (setup_hostid >= 0)
>  		atari_scsi_template.this_id = setup_hostid & 7;
> -	} else {
> +#ifdef CONFIG_NVRAM
> +	else
>  		/* Test if a host id is set in the NVRam */
>  		if (ATARIHW_PRESENT(TT_CLK) && nvram_check_checksum()) {
>  			unsigned char b = nvram_read_byte(16);
> @@ -768,7 +769,7 @@ static int __init atari_scsi_probe(struct platform_device *pdev)
>  			if (b & 0x80)
>  				atari_scsi_template.this_id = b & 7;
>  		}
> -	}
> +#endif
>
>  	/* If running on a Falcon and if there's TT-Ram (i.e., more than one
>  	 * memory block, since there's always ST-Ram in a Falcon), then
>
