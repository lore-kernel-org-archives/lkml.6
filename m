Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88FFC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC2C208A2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="gOOv7WWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC2C208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbeG0Ls2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:48:28 -0400
Received: from 8bytes.org ([81.169.241.247]:34740 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729431AbeG0Ls2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:48:28 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A08F5257; Fri, 27 Jul 2018 12:27:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1532687230; bh=rbO2WdppfB5xWPK+CKifcFaZObqE4HfzLXcOGIAQc1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gOOv7WWvzaJhhC0aMNajdD2e3wS0Cur1J/JdVotMdtqWNR29Kbz6I/kQ0F6aDJ64j
         dP6tvNjwmOAimzb/hkCZydZ53TrwVvTpuZEPeekpFGybFw1g4VlO33Yghd6P0MlKHI
         y+IG0KM7osnvYoCxR8nid5Qr9G9Xx02uG+nej/zmvBX65HWUEgDAqzI1aoALosmCE4
         rXJg/J145CrhWQ36ufb2wVfg3921C30cr0Vztr2tU5KZWJQmPM4OIgHZ54L6VlWLxe
         We0DoZzGuOYg7o3N7fGtGvOPxdW5kskCIWD/5zflbFX7FFl8/iY7ENvc8lRi3/IkOD
         cTICAt7g9b5EQ==
Date:   Fri, 27 Jul 2018 12:27:10 +0200
From:   =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To:     Paul Menzel <pmenzel+linux-iommu@molgen.mpg.de>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: MSI B350M MORTAR: `AMD-Vi: Unable to write to IOMMU perf
 counter.` and `pci 0000:00:00.2: can't derive routing for PCI INT A`
Message-ID: <20180727102710.GA6738@8bytes.org>
References: <605ca165-0071-eb7f-4c0d-b1e76ddd0e05@molgen.mpg.de>
 <20180720123153.GC18541@8bytes.org>
 <d2c5ee4a-e72b-672e-ae30-7b3cd5a43c63@molgen.mpg.de>
 <20180727082754.hk44xktdydduu3qo@8bytes.org>
 <92922faa-164d-002b-9a5e-1865a57f1bdb@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92922faa-164d-002b-9a5e-1865a57f1bdb@molgen.mpg.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 11:18:56AM +0200, Paul Menzel wrote:
> On the AMD site [1] I see the three family 0x17 documents below.
> 
> 1.  Open-Source Register Reference for AMD Family 17h Processors (PUB)
> 2.  Processor Programming Reference (PPR) for AMD Family 17h Models 00h-0Fh Processors (PUB)
> 3.  Software Optimization Guide for AMD Family 17h Processors (PUB)
> 
> What documented is required? The BKDG?

IIRC the PPR is the new BKDG, but the public version does not seem to
contain any references about how the IOMMU needs to be set up by
firmware.


Thanks,

	Joerg
