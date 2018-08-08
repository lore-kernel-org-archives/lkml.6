Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF542C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D202089F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D202089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeHHLEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:04:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726979AbeHHLEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:04:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 864634023461;
        Wed,  8 Aug 2018 08:46:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-132.ams2.redhat.com [10.36.116.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 097ED215670D;
        Wed,  8 Aug 2018 08:46:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id DDA4A16E2B; Wed,  8 Aug 2018 10:46:05 +0200 (CEST)
Date:   Wed, 8 Aug 2018 10:46:05 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Adam Jackson <ajax@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Dave Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] drm/cirrus: flip default to 32bpp
Message-ID: <20180808084605.bnunbipv3uqxkmst@sirius.home.kraxel.org>
References: <20180706091249.25086-1-kraxel@redhat.com>
 <e127596f255261d78fdfe6f534a1000f60c3c605.camel@redhat.com>
 <20180709073924.GB3008@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709073924.GB3008@phenom.ffwll.local>
User-Agent: NeoMutt/20180622
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 08 Aug 2018 08:46:07 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 08 Aug 2018 08:46:07 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 09:39:24AM +0200, Daniel Vetter wrote:
> On Fri, Jul 06, 2018 at 02:35:07PM -0400, Adam Jackson wrote:
> > On Fri, 2018-07-06 at 11:12 +0200, Gerd Hoffmann wrote:
> > > cirrus can handle 1024x768 (and slightly higher) with 24bpp depth.
> > > cirrus can handle up to 800x600 with 32bpp.
> > 
> > 16bpp is maybe a better choice? Nobody's using cirrus because they care
> > about color fidelity and it'll use less CPU to update. There's
> > precedent here, mgag200 defaults to 16bpp on sufficiently memory-
> > impaired devices.
> 
> Yeah nouveau does the same fallback to 16bpp if there's not enough vram.
> So do a bunch of other drivers.

Makes sense.  But appearently 16bpp support bitrotted over time, when
just flipping the default the driver Oopses at init time.  I'll look
into it.

cheers,
  Gerd

