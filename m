Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00CFC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C656E2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfAWQuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:50:01 -0500
Received: from 8bytes.org ([81.169.241.247]:59296 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfAWQuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:50:01 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5DADD42C; Wed, 23 Jan 2019 17:49:59 +0100 (CET)
Date:   Wed, 23 Jan 2019 17:49:59 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Eric Wong <e@80x24.org>,
        David Woodhouse <dwmw2@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/intel: quirk to disable DMAR for QM57 igfx
Message-ID: <20190123164959.GF32526@8bytes.org>
References: <154642214920.6261.102817444136744919@jlahtine-desk.ger.corp.intel.com>
 <20190104010626.e6yqdqkmdcqjepke@dcvr>
 <154659116310.4596.13613897418163029789@jlahtine-desk.ger.corp.intel.com>
 <20190118121705.a4usvhnskyblooja@dcvr>
 <20190122103914.msboylvkor5sb5lq@8bytes.org>
 <CAKMK7uEX1T6_yXoq_d4Fs2LiWC_tDaEEXv-hTL=S-_4HEeya7A@mail.gmail.com>
 <20190122110109.x3zoynemdl3ysbsn@8bytes.org>
 <154816850584.8871.13562920355478587539@jlahtine-desk.ger.corp.intel.com>
 <20190122165135.6rkdsxqepvmaoatn@8bytes.org>
 <154825575844.19121.1110495981060533179@jlahtine-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154825575844.19121.1110495981060533179@jlahtine-desk.ger.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 05:02:38PM +0200, Joonas Lahtinen wrote:
> We have many reports where just having intel_iommu=on (and using the
> system normally, without any virtualization stuff going on) will cause
> unexplained GPU hangs. For those users, simply switching to
> intel_iommu=igfx_off solves the problems, and the debug often ends
> there.

If you can reproduce problems on your side, then you can try to enable
CONFIG_INTEL_IOMMU_BROKEN_GFX_WA to force the GFX devices into the
identity mapping. We can also add a boot-parameter and workarounds if it
turns out that this is sufficient to make the GFX devices work with
IOMMU enabled.


Regards,

	Joerg
