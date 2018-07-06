Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4980CC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F228224058
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="eoVxEb66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F228224058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754111AbeGFLTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:19:10 -0400
Received: from 8bytes.org ([81.169.241.247]:53218 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753708AbeGFLTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:19:07 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5749A2EE; Fri,  6 Jul 2018 13:19:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1530875945; bh=a34WeAziQBG2kuS9VmwfWYmNC0vhx2A8bt5HSkjQpgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eoVxEb66GJAdI4hKVx1XHfesjNmNrm0RG1/d4nqkQbAHTl9jCvKbhqDhZtcKGoqsj
         RnC/9enacq+iGmC6bHrXpeSXzgiklVMSjcdpGxL5oHOAxN44a1U8fVAOMZlP7qF0MU
         WWDs+vJ6yvbPyuaaIR+bG3KEXWSF4JsFTNPO821a95ymdMEj3CApgqmSpGbfH4v5Sg
         QXcEqykOMF0zt+He23FiZmDwuGo2y6/fLr+YHWzZ0g0erVSuKazJjG6zkRwbeBDHS1
         zn7L5aXziD8SA2tOaCdOxx+aEDth1KJ3N7jrKf2Hiv36QlrDb6vSxcJLgjAv6VFnSG
         wpVJEtY9ZFrAw==
Date:   Fri, 6 Jul 2018 13:18:40 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     "yzhai003@ucr.edu" <yzhai003@ucr.edu>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        csong@cs.ucr.edu, zhiyunq@cs.ucr.edu
Subject: Re: [PATCH] iommu/amd: Argument page_size could be uninitialized
Message-ID: <20180706111839.wwgnewib2r6xf4jd@8bytes.org>
References: <1527877815-11132-1-git-send-email-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527877815-11132-1-git-send-email-yzhai003@ucr.edu>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 11:30:14AM -0700, yzhai003@ucr.edu wrote:
> Argument "page_size" passing to function "fetch_pte" could be
> uninitialized if the function returns NULL
> 
> The caller "iommu_unmap_page" checks the return value but the page_size is
> used outside the if block.
> 
> Signed-off-by: yzhai003@ucr.edu <yzhai003@ucr.edu>
> ---
>  drivers/iommu/amd_iommu.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

