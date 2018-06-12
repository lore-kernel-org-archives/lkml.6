Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C54E8C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB4420693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QOcX7ub0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QOcX7ub0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB4420693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754304AbeFLIan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:30:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48316 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754113AbeFLIal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:30:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B8CE0602BD; Tue, 12 Jun 2018 08:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528792240;
        bh=oPt2DFWljhfHqKPTvcI9WtJ3dSPmoDHb+eh+fhG33Ew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QOcX7ub0U7P1aMLjltvCc722mnHkHuU0UsujAyakW0RnBqTAe+WWnG9vgT4/YNRVh
         NAFzTobRd4jgq4oLvDBMJmYwjHJP2IZe0ZKJCP9OcCCNwDyHHk5Cg1IUFms9CM+0G9
         XEZdvtt7PHBwx+11ouYBEm+US6pBeu0pyOcgbHEg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 56146602FC;
        Tue, 12 Jun 2018 08:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528792240;
        bh=oPt2DFWljhfHqKPTvcI9WtJ3dSPmoDHb+eh+fhG33Ew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QOcX7ub0U7P1aMLjltvCc722mnHkHuU0UsujAyakW0RnBqTAe+WWnG9vgT4/YNRVh
         NAFzTobRd4jgq4oLvDBMJmYwjHJP2IZe0ZKJCP9OcCCNwDyHHk5Cg1IUFms9CM+0G9
         XEZdvtt7PHBwx+11ouYBEm+US6pBeu0pyOcgbHEg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 Jun 2018 14:00:40 +0530
From:   poza@codeaurora.org
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v2 1/5] PCI: iproc: Activate PAXC bridge quirk for more
 devices
In-Reply-To: <1528762867-16823-2-git-send-email-ray.jui@broadcom.com>
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <1528762867-16823-2-git-send-email-ray.jui@broadcom.com>
Message-ID: <8c6d5faccee6723ccb635f538105f1cc@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-12 05:51, Ray Jui wrote:
> Activate PAXC bridge quirk for more PAXC based PCIe root complex with
> the following PCIe device ID:
> 0xd750, 0xd802, 0xd804
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  drivers/pci/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 2990ad1..47dfea0 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2195,6 +2195,9 @@ static void quirk_paxc_bridge(struct pci_dev 
> *pdev)
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, 
> quirk_paxc_bridge);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, 
> quirk_paxc_bridge);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, 
> quirk_paxc_bridge);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, 
> quirk_paxc_bridge);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, 
> quirk_paxc_bridge);
>  #endif
> 
>  /* Originally in EDAC sources for i82875P:

Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
