Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A7CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB38F20862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB38F20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbeKHCYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:24:49 -0500
Received: from 8bytes.org ([81.169.241.247]:42830 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727546AbeKHCYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:24:48 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 59A93247; Wed,  7 Nov 2018 17:53:36 +0100 (CET)
Date:   Wed, 7 Nov 2018 17:53:36 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Fix crash on early domain free
Message-ID: <20181107165336.GB19831@8bytes.org>
References: <20181107131850.11584-1-geert+renesas@glider.be>
 <e4dcd8b2-768e-b11d-b6de-337b7e942050@arm.com>
 <20181107153418.cge2dj5zmztahxrf@8bytes.org>
 <CAMuHMdWPkMtnGrxrtFGmyJ5NEvSSCiMUVXXBWX+NS-J4tQXLAw@mail.gmail.com>
 <20181107160341.pfpukoqhyhapfzpn@8bytes.org>
 <f8259910-3e07-497b-9f18-6bcb47430cff@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8259910-3e07-497b-9f18-6bcb47430cff@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 04:17:09PM +0000, Robin Murphy wrote:
> FWIW it looks like it *has* always been possible to hit this crash by
> allocating a domain and freeing it again without attaching any devices, it's
> just highly improbable for any sane code to do that explicitly, so the real
> latent triggers are failure paths in external callers (which in this case
> are themselves only being reached thanks to my bug elsewhere).

Okay, given this, it probably makes more sense to change the fixes tag.
This is what I just committed:

Fixes: d25a2a16f0889 ('iommu: Add driver for Renesas VMSA-compatible IPMMU')

Regards,

	Joerg
