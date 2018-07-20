Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594A2ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1458320661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Q88kk0G1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1458320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbeGTNET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:04:19 -0400
Received: from 8bytes.org ([81.169.241.247]:59846 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbeGTNES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:04:18 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 755C52DE; Fri, 20 Jul 2018 14:16:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1532088980; bh=ISWHXuG29ZAjzGx1T40rFHFqnuLIoEatRALixHI7i7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q88kk0G1XDkfB39Z69viCtwchXp6QmZOAWu1jfAtKCMx6TepMvIp2aiBlh3w59KTL
         zNeYDU6xk+x43tMIS4nkTA2d38ig7PtoYyeKLdCbgbx5sZBSuQ0jGs9fbzC+zV3Dfz
         mm37Cfq7e9T5D2h4OQo3GjADVy0Hi7Hv0Qx77wRjqp2pwvOX8hkeQGOj2wOUZeu4Lm
         RSkEZ0HThR/jdWf6N3f7gRGU5vYG+qZz3uRDvVfvTnLtvmNm3Ugp6gWS0yLQUuU9hX
         yXC2tT9ZrSQPh/oMou9jdQdyiBk9R3mFguanowBf9quYA3J4NYb8pjum+lwDpgs8MR
         6k6qII6rEVpKA==
Date:   Fri, 20 Jul 2018 14:16:19 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu: Add config option to set passthrough as
 default
Message-ID: <20180720121619.pqrgth4zxdj7zjym@8bytes.org>
References: <20180711205936.18614-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711205936.18614-1-olof@lixom.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

On Wed, Jul 11, 2018 at 01:59:35PM -0700, Olof Johansson wrote:
> +config IOMMU_DEFAULT_PASSTHROUGH
> +	bool "IOMMU passthrough by default"
> +	depends on IOMMU_API
> +        help
> +	  Enable passthrough by default (removing the need to pass in
> +	  iommu.passthrough=on through command line). If this is enabled,
> +	  you can still disable with iommu.passthrough=off
> +
> +	  If unsure, say N here.
> +

The patch is a good start, but the description above indicates that it
affects all IOMMU driver, which it does not. Please make the Intel and
AMD IOMMU drivers also take this option into account.


	Joerg
