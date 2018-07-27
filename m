Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B13C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5525A2088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="F1wGyepu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5525A2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbeG0Jsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:48:43 -0400
Received: from 8bytes.org ([81.169.241.247]:33212 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729431AbeG0Jsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:48:43 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1C4F3301; Fri, 27 Jul 2018 10:27:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1532680075; bh=m6+etlJd/jrH81yzea9R2RtuP3/RY55XqqwVVZQuXqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F1wGyepu7odEf7TenDh+5hQJ8vxcYJQtw5jH5yp+ZBDeioGi8WOJMRMLKrZIRSfNY
         sDDiYtA80lBvK4m+wJvibt9mTVUCgk9kFYoAXh+Knn5Wd+xsl/sIKdXUjDz400uT4t
         a4hLMU/b0OY1+/yEuKkj1kZI/Ue/9nOqXXfbwf3d+MNC5K/kJureUWuiziFaYGxBd2
         RwRZZPOxc+sLwAd7kuqVR3vBGarFRkXV5rlTMxO1sOW/YqENP6i/MQaVANcL+c0UIO
         SILCo4Exc2az9FeiHe61+Nz4vatS7LeEQRCmkMGfslcuuIhKLsQ9ZtQyoMM0nBJrCT
         Uu5RFcCYJ7T7A==
Date:   Fri, 27 Jul 2018 10:27:54 +0200
From:   =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To:     Paul Menzel <pmenzel+linux-iommu@molgen.mpg.de>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: MSI B350M MORTAR: `AMD-Vi: Unable to write to IOMMU perf
 counter.` and `pci 0000:00:00.2: can't derive routing for PCI INT A`
Message-ID: <20180727082754.hk44xktdydduu3qo@8bytes.org>
References: <605ca165-0071-eb7f-4c0d-b1e76ddd0e05@molgen.mpg.de>
 <20180720123153.GC18541@8bytes.org>
 <d2c5ee4a-e72b-672e-ae30-7b3cd5a43c63@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2c5ee4a-e72b-672e-ae30-7b3cd5a43c63@molgen.mpg.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Mon, Jul 23, 2018 at 12:09:37PM +0200, Paul Menzel wrote:
> > or the BIOS did not enable the performance counter feature in the IOMMU
> > hardware.
> 
> Is it possible to check that from the OS side?

It would be if we had the NB documentation, but I guess those details
are not publicly available.

> > Are you running on the latest BIOS?
> 
> Yes, I am even using a “beta“ one from [1].
> 
> DMI: MSI MS-7A37/B350M MORTAR (MS-7A37), BIOS 1.G1 05/17/2018

I think the best you can do is to report this as a bug to your BIOS
vendor and hope they'll fix it.


	Joerg
