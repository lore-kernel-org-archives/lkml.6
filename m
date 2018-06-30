Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226AEC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 20:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FCD2515E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 20:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjsbWU2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FCD2515E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeF3UED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 16:04:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751409AbeF3UEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 16:04:01 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D00302539E;
        Sat, 30 Jun 2018 20:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530389041;
        bh=skYfbwbO2dDo1MTwerXPnJ5DQ34kvIOiU+JL4pCBFrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KjsbWU2T/pmiTF+dCykThUwd3hutD9ONP4Bh94DKL80eXdUBedS/W4MhdWlkMqr50
         EuPQx6YAJZ/c9whRd7Pr49LuUeqNSUy/vaMNHV1NYLCs6Zg0VVyEgaucgQCfwJy5Om
         qtwVWhAmYqhSb07+5/bICDwD18hFYGc0fwPRuBe8=
Date:   Sat, 30 Jun 2018 15:03:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tyler Baicar <tbaicar@codeaurora.org>
Cc:     bhelgaas@google.com, poza@codeaurora.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Adopt lspci naming convention for AER prints
Message-ID: <20180630200359.GE9547@bhelgaas-glaptop.roam.corp.google.com>
References: <1530027855-19709-1-git-send-email-tbaicar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530027855-19709-1-git-send-email-tbaicar@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 11:44:15AM -0400, Tyler Baicar wrote:
> lspci uses abbreviated naming for AER error strings. Adopt the
> same naming convention for the AER printing so they match.
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>

Applied with Oza's reviewed-by to pci/aer for v4.19, thanks!

> ---
>  drivers/pci/pcie/aer.c | 46 +++++++++++++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a2e8838..08a5219 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -459,22 +459,22 @@ int pci_aer_init(struct pci_dev *dev)
>  };
>  
>  static const char *aer_correctable_error_string[] = {
> -	"Receiver Error",		/* Bit Position 0	*/
> +	"RxErr",			/* Bit Position 0	*/
>  	NULL,
>  	NULL,
>  	NULL,
>  	NULL,
>  	NULL,
> -	"Bad TLP",			/* Bit Position 6	*/
> -	"Bad DLLP",			/* Bit Position 7	*/
> -	"RELAY_NUM Rollover",		/* Bit Position 8	*/
> +	"BadTLP",			/* Bit Position 6	*/
> +	"BadDLLP",			/* Bit Position 7	*/
> +	"Rollover",			/* Bit Position 8	*/
>  	NULL,
>  	NULL,
>  	NULL,
> -	"Replay Timer Timeout",		/* Bit Position 12	*/
> -	"Advisory Non-Fatal",		/* Bit Position 13	*/
> -	"Corrected Internal Error",	/* Bit Position 14	*/
> -	"Header Log Overflow",		/* Bit Position 15	*/
> +	"Timeout",			/* Bit Position 12	*/
> +	"NonFatalErr",			/* Bit Position 13	*/
> +	"CorrIntErr",			/* Bit Position 14	*/
> +	"HeaderOF",			/* Bit Position 15	*/
>  };
>  
>  static const char *aer_uncorrectable_error_string[] = {
> @@ -482,28 +482,28 @@ int pci_aer_init(struct pci_dev *dev)
>  	NULL,
>  	NULL,
>  	NULL,
> -	"Data Link Protocol",		/* Bit Position 4	*/
> -	"Surprise Down Error",		/* Bit Position 5	*/
> +	"DLP",				/* Bit Position 4	*/
> +	"SDES",				/* Bit Position 5	*/
>  	NULL,
>  	NULL,
>  	NULL,
>  	NULL,
>  	NULL,
>  	NULL,
> -	"Poisoned TLP",			/* Bit Position 12	*/
> -	"Flow Control Protocol",	/* Bit Position 13	*/
> -	"Completion Timeout",		/* Bit Position 14	*/
> -	"Completer Abort",		/* Bit Position 15	*/
> -	"Unexpected Completion",	/* Bit Position 16	*/
> -	"Receiver Overflow",		/* Bit Position 17	*/
> -	"Malformed TLP",		/* Bit Position 18	*/
> +	"TLP",				/* Bit Position 12	*/
> +	"FCP",				/* Bit Position 13	*/
> +	"CmpltTO",			/* Bit Position 14	*/
> +	"CmpltAbrt",			/* Bit Position 15	*/
> +	"UnxCmplt",			/* Bit Position 16	*/
> +	"RxOF",				/* Bit Position 17	*/
> +	"MalfTLP",			/* Bit Position 18	*/
>  	"ECRC",				/* Bit Position 19	*/
> -	"Unsupported Request",		/* Bit Position 20	*/
> -	"ACS Violation",		/* Bit Position 21	*/
> -	"Uncorrectable Internal Error",	/* Bit Position 22	*/
> -	"MC Blocked TLP",		/* Bit Position 23	*/
> -	"AtomicOp Egress Blocked",	/* Bit Position 24	*/
> -	"TLP Prefix Blocked Error",	/* Bit Position 25	*/
> +	"UnsupReq",			/* Bit Position 20	*/
> +	"ACSViol",			/* Bit Position 21	*/
> +	"UncorrIntErr",			/* Bit Position 22	*/
> +	"BlockedTLP",			/* Bit Position 23	*/
> +	"AtomicOpBlocked",		/* Bit Position 24	*/
> +	"TLPBlockedErr",		/* Bit Position 25	*/
>  };
>  
>  static const char *aer_agent_string[] = {
> -- 
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
> 
