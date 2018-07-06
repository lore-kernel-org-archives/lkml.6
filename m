Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78D3C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B1823FC4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="oy1+Hs9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B1823FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932724AbeGFLzZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:55:25 -0400
Received: from 8bytes.org ([81.169.241.247]:53400 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932502AbeGFLzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:55:21 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3E7F81F0; Fri,  6 Jul 2018 13:55:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1530878117; bh=BVfQ4J4reG3xaQQdahTX/wpLd9k+rtzNDzPzmKrtrU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oy1+Hs9aVTsbE8XgCELgC5BUyKCDKA8frln1HQG4Yie9OBvmcKdN1uK7u922TJlHV
         KIYDG0q+JguTATJ8UaHhqhxqYzAiN/kxgRwQUS1eInkRas4em1tMTG7hwrQDF2srYI
         NIzUMXDHGjuyLTeaGGaE20/JxK33YOdMeOMjAphwfAlASRSDKwv1PGOkO4cGboMlxm
         FfyY+TlYQp5IGglhiy9nngnKr2ED7Ilq6MsVEUs1iJjpPpq8AJp5MCHYzQlVxcM/AS
         fMogsxQnfUEXRmZBAhyMHy9gvIl+PVZwAmkRcHuMHiVQcTWlcQBJChbBJW26ZwaZwh
         d8UjaRP6n/Mnw==
Date:   Fri, 6 Jul 2018 13:55:13 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] iommu/msm: Don't call iommu_device_{,un}link from
 atomic context
Message-ID: <20180706115513.azbd732k2zd3bvpu@8bytes.org>
References: <20180612140610.31190-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612140610.31190-1-niklas.cassel@linaro.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 04:06:10PM +0200, Niklas Cassel wrote:
> 
> Fixes: 42df43b36163 ("iommu/msm: Make use of iommu_device_register interface")
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  drivers/iommu/msm_iommu.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)

Applied, thanks.
