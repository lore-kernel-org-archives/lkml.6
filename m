Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD8FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BF320880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkEX17j+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55BF320880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388360AbeGXOpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:45:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388299AbeGXOpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:45:34 -0400
Received: from localhost (unknown [171.61.90.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2366320856;
        Tue, 24 Jul 2018 13:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532439541;
        bh=ylxtXLVvwtlpzb8b+tTvZU0wnCxSID82NoRNGtR9hzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rkEX17j+jvvXZw6+HyoNxTGjblAEZBwctG2bffIUUYk7gNkFN7VC+1653xO/9j22l
         UYPXGlLBXALoUa7rVHioBtNVQiVo2dvjfUbS0pYn2gZt3L7USA7v02CDaFFpcQfLMm
         a+RIOjam1d63lXfmwao5MLHut1FmF9idkm9lwvDQ=
Date:   Tue, 24 Jul 2018 19:08:53 +0530
From:   Vinod <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3 11/18] dmaengine: dma-jz4780: Add missing residue DTC
 mask
Message-ID: <20180724133853.GH3661@vkoul-mobl>
References: <20180721110643.19624-1-paul@crapouillou.net>
 <20180721110643.19624-12-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721110643.19624-12-paul@crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-07-18, 13:06, Paul Cercueil wrote:
> From: Daniel Silsby <dansilsby@gmail.com>
> 
> The 'dtc' word in jz DMA descriptors contains two fields: The
> lowest 24 bits are the transfer count, and upper 8 bits are the DOA
> offset to next descriptor. The upper 8 bits are now correctly masked
> off when computing residue in jz4780_dma_desc_residue(). Note that
> reads of the DTCn hardware reg are automatically masked this way.
> 
> Signed-off-by: Daniel Silsby <dansilsby@gmail.com>
> Tested-by: Mathieu Malaterre <malat@debian.org>

This needs your s-o-b. Please see Documentation/process/submitting-patches.rst

I think Randy did flag this one some other patch as well. All the
patches need to be signed off by sender as well

-- 
~Vinod
