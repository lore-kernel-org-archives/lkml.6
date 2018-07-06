Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853A8C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5BA24053
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="SJ2S6wtJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5BA24053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754118AbeGFLOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:14:06 -0400
Received: from 8bytes.org ([81.169.241.247]:53146 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753455AbeGFLOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:14:04 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4EC041F0; Fri,  6 Jul 2018 13:14:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1530875640; bh=v8OsIJWB+Tvur30x16yseWrfocNsCdAlp7QL2+4iE8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SJ2S6wtJfM6Cecsn5CD0OrBJ0J0h9MxgjIsV5fZARBGOCh1jDv/JMaFguSwm4kHVW
         h2Kh7rEOLuSRSXQeXDet5Vqb3Eyl5SDMZu+JjzvYdGxO3eXH5KxV9m/pi0/o4GH926
         8Lfop/ix6B7gGEcPCGlPPtNeUrj8gMSS9sR8LWrEEDmbeuyg71WoyCBJuLS3yTsYQg
         Qb48RuVqscq74GnPfCbDOYNjOS/ZwPrBMHukBORk8Mg7K2hEiazB2PrRZNJF4u3WAb
         3OK3YMEmUaA5tAUlpncyUN2+2bgFRYJES9MXLlVD2URg7GYSBPpugTbJsnagAy2b9g
         oGozb6Rzq+NMA==
Date:   Fri, 6 Jul 2018 13:13:28 +0200
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     Nipun Gupta <nipun.gupta@nxp.com>
Cc:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bharat Bhushan <bharat.bhushan@nxp.com>,
        "stuyoder@gmail.com" <stuyoder@gmail.com>,
        Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH 0/7 v5] Support for fsl-mc bus and its devices in SMMU
Message-ID: <20180706111327.7gkerhkk6udfeirr@8bytes.org>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
 <HE1PR0401MB24250CEFBC0B7CC919C4388AE6760@HE1PR0401MB2425.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR0401MB24250CEFBC0B7CC919C4388AE6760@HE1PR0401MB2425.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nipun,

On Thu, Jun 21, 2018 at 03:59:27AM +0000, Nipun Gupta wrote:
> Will this patch-set be taken for the next kernel release (and via which tree)?

I can take this through IOMMU tree if nobody objects. Please work out
the last remaining comment on patch 7 with Robin and then re-send with
all Acks and Reviewed-by: tags included.

Oh, and please use 'iommu/of:' prefix instead of 'iommu: of:' and follow
that sheme for the other patches/prefixes as well.

Thanks,

	Joerg

