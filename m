Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439FBC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB29208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="I+3La3LG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB29208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbeG0PmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:42:11 -0400
Received: from 8bytes.org ([81.169.241.247]:37744 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730376AbeG0PmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:42:11 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D47A08F0; Fri, 27 Jul 2018 16:20:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1532701201; bh=2lYfTsJLJm/0Lpj+5nbdjQfFBFTrA3QlDaP9kzpR5sg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I+3La3LGlLwMOtQ4J3no5F6cp2zwhn3YD52FIn18q6b9Jh176wmiX+0wFLd9e14SC
         zGO33JGGP2vEsRel8FN+BCDNc7Z3yRH/hw+v66dx3UHzWOAshXKi/Fa+d8x8Qwb5PO
         nu5ufjGrvagMO15OOsm14+3F4NfAb0CGVL2VC5J7fi9yTdtlCdxCA9GgawRUJbZQTl
         kiaNWJsw8rbpHL8lgjZsezIS51ID9C/+UTRu6BLVpy46QJGeCe+xYsACQRNP+IyVLt
         V5Srd0V5SPUGVQy6SSbJe95eU2BUI9ViT08jHIRWnw6+2RLx8QNJuwdklC55PWztEg
         D+2GGhBC9Uxgg==
Date:   Fri, 27 Jul 2018 16:20:01 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        devicetree@vger.kernel.org, nouveau@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/6] Resolve unwanted DMA backing with IOMMU
Message-ID: <20180727142000.76zgficpta473snl@8bytes.org>
References: <20180726231624.21084-1-digetx@gmail.com>
 <20180727082512.lpvmeuvxnw3mpeym@8bytes.org>
 <20180727090328.GH28088@arm.com>
 <4164951.xGHfcFJ9uZ@dimapc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4164951.xGHfcFJ9uZ@dimapc>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 05:10:22PM +0300, Dmitry Osipenko wrote:
> I'm not sure what you guys are meaning by the "firmware", could you elaborate 
> please? Do you mean the Open Firmware and hence the devicetree or what?

Yes, I think the best way to request this is using a device-tree
property. Letting the device driver request it is definitly a bad idea.


	Joerg

