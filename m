Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD27C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05E026E2B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eMqX/Rjh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gHjrK4IB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05E026E2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753100AbeFZRIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:08:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34548 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752278AbeFZRID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:08:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0F04D60117; Tue, 26 Jun 2018 17:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530032883;
        bh=61JtYGJ6SdaMs0OsXlqZJzlPOqSlmlFHDGlgtNzLes8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eMqX/RjhH/3KsgkowZflVof1BzeG1BYun7EWoDvcP8WIF6JbkY8ogelnQwl//zYGO
         I33W1bjnb0UO085Y4wx8iAL9J0V/iSYeP16fs8WzGDkVKf6b9nH//8wiqa+UwiW7pU
         UmCSDgRNAfZsF9Z9anQr820+Vx48v9fPWskcU0Fo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 4F3EA60117;
        Tue, 26 Jun 2018 17:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530032882;
        bh=61JtYGJ6SdaMs0OsXlqZJzlPOqSlmlFHDGlgtNzLes8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gHjrK4IBkg3Dfb11zlNjxjR2kp7TbaD6F7bnFJPNrZ7Xmoqz0bz9+CQgY8i0/pfl4
         IC6FxyjvYE0WJCxfsdDAThYJoAyFHCG8QX8pTnPhLv8t0eQM0F9BaHpVoxMmZ02VwM
         pLuTLczo3E6Hp4TVFsHX0BkyhWqYgyLKNRS8rumM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 Jun 2018 22:38:02 +0530
From:   poza@codeaurora.org
To:     Tyler Baicar <tbaicar@codeaurora.org>
Cc:     helgaas@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Adopt lspci naming convention for AER prints
In-Reply-To: <1530027855-19709-1-git-send-email-tbaicar@codeaurora.org>
References: <1530027855-19709-1-git-send-email-tbaicar@codeaurora.org>
Message-ID: <ac1a8fa22a6f9c53220fc6972c5e931b@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-26 21:14, Tyler Baicar wrote:
> lspci uses abbreviated naming for AER error strings. Adopt the
> same naming convention for the AER printing so they match.
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  drivers/pci/pcie/aer.c | 46 
> +++++++++++++++++++++++-----------------------
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


Reviewed-by: Oza Pawandeep <poza@codeaurora.org>

