Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392BFC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E412083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBSBAHM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E412083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936109AbeFSWAG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:00:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755392AbeFSV75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:59:57 -0400
Received: from localhost (unknown [146.7.4.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F392F20652;
        Tue, 19 Jun 2018 21:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529445597;
        bh=1+bolKhm1p/CW1/gpoEfu4nfWe7o51U0FQ/PqcXvuoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZBSBAHM413pIznAMsJACi9mmfHHxyGIJnxiZGQsVedFOjmEDq1WJB0tjOcAhYza9W
         oMQevf1gzgs9QrZCkIiPlUTGv7TA1eDF/Jdwtr4EwtXSHoGMzV7IOgbBVIml7s7DK+
         j+SGjNgh1riAC0PfH84pEv5zF9LFDo1sVlgAhSLo=
Date:   Tue, 19 Jun 2018 16:59:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
        timur@codeaurora.org, ard.biesheuvel@linaro.org,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        Peter Jones <pjones@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
Message-ID: <20180619215955.GF33049@bhelgaas-glaptop.roam.corp.google.com>
References: <1526563343-28721-1-git-send-email-okaya@codeaurora.org>
 <36cf3f12-bfe8-1c38-4d2c-b785fc64a3f6@arm.com>
 <733101d0-9051-a5a6-ef64-162d8d1e10a1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <733101d0-9051-a5a6-ef64-162d8d1e10a1@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 10:20:29AM -0400, Sinan Kaya wrote:
> On 5/18/2018 6:42 AM, Robin Murphy wrote:
> > 
> > FWIW, now that I've actually gone and looked, it appears you could simplify the whole function quite a bit by getting rid of these and just using the new local resource directly, especially since the only actual use of size is an open-coded resource_contains().
> 
> Posted V2 a minute ago. I did the simplification on a prior patch in order not to
> mix the issues.

I don't see the V2 on linux-pci, but it sounds like Ard would merge this
anyway.  So I'll drop this and you can let me know if there's anything you
need from me.
