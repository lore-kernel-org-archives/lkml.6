Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2DDC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BF823EB3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="XMQEpTtZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BF823EB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932412AbeGFL0p (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:26:45 -0400
Received: from 8bytes.org ([81.169.241.247]:53292 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932174AbeGFL0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:26:44 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D6C6F1F0; Fri,  6 Jul 2018 13:26:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1530876402; bh=CNXZh4gQFalwmO1OZiElS8IJRB7XDa8RIGs91e+4ko0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XMQEpTtZJzRqHg3ALTW1lIu3j8sjOkbsZ9Y/ibPyMuspKKIxAWzntygDrJe+ATrco
         Q9EKp38FM2XynhXyJeYH++h7U5f+LBODNZ0IJ+VnxGk0rfVu/PQ+/NdQpnfhUWZ1w0
         n26t0Xig5hETcs54rNrj+tU5MfNVT01s98tENlLTy0ko4Yz3LR9pQtgyMrBUGnh4V+
         /EnsPndG9o0oBP3mALAnJC1rQArRK/JATrbQXSK2wU30YzBlO9IDSmb+v7z2b7VYCe
         wOtC4ubAXikw21spG/WMkqgFsXcS6IFjE8Y+ZHreLU8bmCGnS86xIfRVUUOL2pLOtp
         oY3DwdIdpB6PA==
Date:   Fri, 6 Jul 2018 13:26:38 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2 0/2] iommu/vt-d: pfsid fix
Message-ID: <20180706112638.wpzwkx6edl6a2a5j@8bytes.org>
References: <1528390620-31565-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528390620-31565-1-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 09:56:58AM -0700, Jacob Pan wrote:
> When device invalidation throttling(DIT) is supported by an IOMMU, device TLB
> invalidation should include physical function source ID(PFSID).
> 
> Changes since v1:
> - Fixed compile error when CONFIG_PCI_ATS is not set
> - Simplified how PF source ID is retrieved
> 
> Jacob Pan (2):
>   iommu/vt-d: add definitions for PFSID
>   iommu/vt-d: fix dev iotlb pfsid use

Applied, thanks Jacob.
