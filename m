Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AE3C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBAF21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfAVLBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:01:12 -0500
Received: from 8bytes.org ([81.169.241.247]:58804 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbfAVLBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:01:11 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8151353D; Tue, 22 Jan 2019 12:01:10 +0100 (CET)
Date:   Tue, 22 Jan 2019 12:01:09 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Eric Wong <e@80x24.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/intel: quirk to disable DMAR for QM57 igfx
Message-ID: <20190122110109.x3zoynemdl3ysbsn@8bytes.org>
References: <20181227114948.ev4b3jte3ubsc5us@dcvr>
 <154642214920.6261.102817444136744919@jlahtine-desk.ger.corp.intel.com>
 <20190104010626.e6yqdqkmdcqjepke@dcvr>
 <154659116310.4596.13613897418163029789@jlahtine-desk.ger.corp.intel.com>
 <20190118121705.a4usvhnskyblooja@dcvr>
 <20190122103914.msboylvkor5sb5lq@8bytes.org>
 <CAKMK7uEX1T6_yXoq_d4Fs2LiWC_tDaEEXv-hTL=S-_4HEeya7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uEX1T6_yXoq_d4Fs2LiWC_tDaEEXv-hTL=S-_4HEeya7A@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, Jan 22, 2019 at 11:46:39AM +0100, Daniel Vetter wrote:
> Note that the string of platforms which have various issues with iommu
> and igfx is very long, thus far we only disabled it where there's no
> workaround to stop it from hanging the box, but otherwise left it
> enabled. So if we make a policy change to also disable it anywhere
> where it doesn't work well (instead of not at all), there's a pile
> more platforms to switch.

I think its best to just disable iommu for the igfx devices on these
platforms. Can you pick up Eric's patch and extend it with the list of
affected platforms?

Thanks,

	Joerg
