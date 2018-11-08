Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C971EECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9949F20883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9949F20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeKHXk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:40:29 -0500
Received: from 8bytes.org ([81.169.241.247]:46436 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbeKHXk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:40:29 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1DB4048C; Thu,  8 Nov 2018 15:04:51 +0100 (CET)
Date:   Thu, 8 Nov 2018 15:04:50 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] iommu/amd: Add missed 'tag' to error msg in
 iommu_print_event
Message-ID: <20181108140450.GF19831@8bytes.org>
References: <1541657560-73681-1-git-send-email-yuehaibing@huawei.com>
 <1541678253-143948-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541678253-143948-1-git-send-email-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 11:57:33AM +0000, YueHaibing wrote:
> -		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
> +		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x tag=0x%08x]\n",

Changed the %08x to %03x, which is enough for a 10-bit value, and
applied it to x86/amd.

Thanks,

	Joerg
