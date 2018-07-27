Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE90C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D375B2088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="fFsCZ3NN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D375B2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbeG0JMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:12:16 -0400
Received: from 8bytes.org ([81.169.241.247]:32940 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729420AbeG0JMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:12:16 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7701A2B6; Fri, 27 Jul 2018 09:51:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1532677895; bh=g4IUSshUT3gS6R0oPNuPnXOhfpnK1DsBFbypMNojLEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fFsCZ3NNrQ89AL9vkIs+3vJEU+c04iUMk+QxQSfSTcDz4BBz0xaSU+Kdx21T2kONW
         CGFgYf0tNcr6vTf+us1g/9CAu1olcFEkSMV4r1G5ND/YNX1xEOItagTYcbWWid14b6
         sHqCdvdyrFnRNN1xTAn+LXX+c+nC1UGrX8RbL4FwLP0aniqx3uynhN2ZA5rKYnyLAG
         9289uqk5wW3KmfwK4aANbOM27THKsLOTa3h8HILMczD3qoZKt1XTkIi1MlSI+xJ4gy
         u6KRwyMq7vlx0+dViLcsnv2NYAPDGg9zbf1wpWxfXrETIRL+9V0QNEcNA50kZtyOb9
         EFpw3Ixs9L8iw==
Date:   Fri, 27 Jul 2018 09:51:34 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Marc Dietrich <marvin24@gmx.de>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iommu/ipmmu-vmsa: Don't register as BUS IOMMU if
 machine doesn't have IPMMU-VMSA
Message-ID: <20180727075134.ygjgrl6hxbmi6gj5@8bytes.org>
References: <20180726211916.10264-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726211916.10264-1-digetx@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 12:19:16AM +0300, Dmitry Osipenko wrote:
> This fixes kernel crashing on NVIDIA Tegra if kernel is compiled in
> a multiplatform configuration and IPMMU-VMSA driver is enabled.
> 
> Cc: <stable@vger.kernel.org> # v3.20+
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied, thanks.
