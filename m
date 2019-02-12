Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B37AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C5021773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549957785;
	bh=HyKNorq6TjpgFi5QyJEgeekX7eUrN1l+FnH+qgHHhnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HaGe1JObGRovBCyOz7dPIGQLqnChkIJooBxjnFdEz3ZXfiWmQRh+p5ImpALlCbULo
	 Q5JG3abpggspoNrwYfzbO3/Ke34wkLzyMtODNX/OxNwOEUmDWEsCdRjdeeRRkuPG8G
	 JL+NCtkIah29O2MrrNTJ8xkDkM+LF1YXzm5Zbbbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfBLHto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:49:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfBLHtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:49:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55D11206BA;
        Tue, 12 Feb 2019 07:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549957783;
        bh=HyKNorq6TjpgFi5QyJEgeekX7eUrN1l+FnH+qgHHhnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qI/X/laNeqldkcPAOZlQYINzbJrGBYV1Lva9nJVKuZc1OZUp9C712/P2XUkscFuV4
         /QC9V+EvrtPWV67hzW+fgwrUtOraz1epXoze+I8b4zQBq/Ci0xGYLTzpdbLklie66/
         FpwqP1/4yV8HumJSWqRhgRzj0vaZRFIK8mNAvAHo=
Date:   Tue, 12 Feb 2019 08:49:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, Lee Jones <lee.jones@linaro.org>,
        x86@kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] dma-mapping: improve selection of
 dma_declare_coherent availability
Message-ID: <20190212074940.GB5924@kroah.com>
References: <20190211133554.30055-1-hch@lst.de>
 <20190211133554.30055-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211133554.30055-7-hch@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 02:35:48PM +0100, Christoph Hellwig wrote:
> This API is primarily used through DT entries, but two architectures
> and two drivers call it directly.  So instead of selecting the config
> symbol for random architectures pull it in implicitly for the actual
> users.  Also rename the Kconfig option to describe the feature better.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
