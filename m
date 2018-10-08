Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369B3C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3D0205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="mhLfLUn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3D0205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbeJHV7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:59:06 -0400
Received: from 8bytes.org ([81.169.241.247]:51974 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbeJHV7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:59:05 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 11E5E750; Mon,  8 Oct 2018 16:47:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1539010020; bh=zPKC3w56ZvwxzWbkqOKXLvU01R55xF7lqysBZej+W+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mhLfLUn/LB/myFpAkXAoVcnymEOXBsN9/gt32FPLj5BrabYnJ0ZvAK19ky6xr2rXw
         c0gisU6tzAqv93G50dmxkZzyLYmBKAK5yeRsitzsFnjHVYRcB5VJSLeHEGDVkcK2n+
         tyWEu3OzCfFDHO493kPXs8U8pt7b90HRqef78c7smz4kxIr8tWYNhHy+9o68xsDz6m
         tZH1USjernXqlkUvi6y5FhpHdoMKDyR0lKiwbpLaAm1Sz4FF6W7t7e2AFV8qR4PbvT
         zb4VmCW0Qqkt9kxPWN9NZVRLoiF2dni439IUi63xO08bT/irWRnjnG5VGpDSmgNQoU
         qB6rpNWHEvieA==
Date:   Mon, 8 Oct 2018 16:46:59 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/amd: Add default branch in amd_iommu_capable()
Message-ID: <20181008144659.uqt6mofdstn6ydhc@8bytes.org>
References: <20181008022419.31865-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008022419.31865-1-baolu.lu@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 10:24:19AM +0800, Lu Baolu wrote:
> Recent gcc warns about switching on an enumeration, but not having
> an explicit case statement for all members of the enumeration. To
> show the compiler this is intentional, we simply add a default case
> with nothing more than a break statement.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/amd_iommu.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.
