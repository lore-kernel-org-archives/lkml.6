Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754954AbeDWLw7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 07:52:59 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:6351 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754820AbeDWLw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 07:52:58 -0400
X-IronPort-AV: E=Sophos;i="5.49,318,1520899200";
   d="scan'208";a="52433439"
Date: Mon, 23 Apr 2018 12:52:43 +0100
From: Wei Liu <wei.liu2@citrix.com>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
CC: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        <jgross@suse.com>, Artem Mygaiev <Artem_Mygaiev@epam.com>,
        Dongwon Kim <dongwon.kim@intel.com>, <konrad.wilk@oracle.com>,
        <airlied@linux.ie>,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        "Potrola, MateuszX" <mateuszx.potrola@intel.com>,
        <xen-devel@lists.xenproject.org>, <daniel.vetter@intel.com>,
        <boris.ostrovsky@oracle.com>, Wei Liu <wei.liu2@citrix.com>
Subject: Re: [Xen-devel] [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy helper
 DRM driver
Message-ID: <20180423115242.ywdwqblj2aseu3fr@citrix.com>
References: <5d8fec7f-956c-378f-be90-f45029385740@gmail.com>
 <20180416192905.GA18096@downor-Z87X-UD5H>
 <20180417075928.GT31310@phenom.ffwll.local>
 <20180417205744.GA15930@downor-Z87X-UD5H>
 <41487acb-a67a-8933-d0c3-702c19b0938e@gmail.com>
 <20180418073508.ptvntwedczpvl7bx@MacBook-Pro-de-Roger.local>
 <ebcbf6ce-1d7a-5f3e-cff8-546d1c010e59@gmail.com>
 <20180418101058.hyqk3gr3b2ibxswu@MacBook-Pro-de-Roger.local>
 <20180420071914.GG31310@phenom.ffwll.local>
 <76cdc65a-7bb1-9377-7bc5-6164e32f7b5d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <76cdc65a-7bb1-9377-7bc5-6164e32f7b5d@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 02:25:20PM +0300, Oleksandr Andrushchenko wrote:
> > >     the gntdev.
> > > 
> > > I think this is generic enough that it could be implemented by a
> > > device not tied to Xen. AFAICT the hyper_dma guys also wanted
> > > something similar to this.
> > You can't just wrap random userspace memory into a dma-buf. We've just had
> > this discussion with kvm/qemu folks, who proposed just that, and after a
> > bit of discussion they'll now try to have a driver which just wraps a
> > memfd into a dma-buf.
> So, we have to decide either we introduce a new driver
> (say, under drivers/xen/xen-dma-buf) or extend the existing
> gntdev/balloon to support dma-buf use-cases.
> 
> Can anybody from Xen community express their preference here?
> 

Oleksandr talked to me on IRC about this, he said a few IOCTLs need to
be added to either existing drivers or a new driver.

I went through this thread twice and skimmed through the relevant
documents, but I couldn't see any obvious pros and cons for either
approach. So I don't really have an opinion on this.

But, assuming if implemented in existing drivers, those IOCTLs need to
be added to different drivers, which means userspace program needs to
write more code and get more handles, it would be slightly better to
implement a new driver from that perspective.

Wei.
