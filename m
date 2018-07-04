Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBCDC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919DD244C1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919DD244C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933678AbeGDFxn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 01:53:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932978AbeGDFxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 01:53:40 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E7A25D5EE;
        Wed,  4 Jul 2018 05:53:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-220.phx2.redhat.com [10.3.116.220])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80789308BDB2;
        Wed,  4 Jul 2018 05:53:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 184B317442; Wed,  4 Jul 2018 07:53:38 +0200 (CEST)
Date:   Wed, 4 Jul 2018 07:53:38 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v6] Add udmabuf misc device
Message-ID: <20180704055338.n3b7oexltaejqmcd@sirius.home.kraxel.org>
References: <20180703075359.30349-1-kraxel@redhat.com>
 <20180703083757.GG7880@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703083757.GG7880@phenom.ffwll.local>
User-Agent: NeoMutt/20180622
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 04 Jul 2018 05:53:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 10:37:57AM +0200, Daniel Vetter wrote:
> On Tue, Jul 03, 2018 at 09:53:58AM +0200, Gerd Hoffmann wrote:
> > A driver to let userspace turn memfd regions into dma-bufs.
> > 
> > Use case:  Allows qemu create dmabufs for the vga framebuffer or
> > virtio-gpu ressources.  Then they can be passed around to display
> > those guest things on the host.  To spice client for classic full
> > framebuffer display, and hopefully some day to wayland server for
> > seamless guest window display.
> > 
> > qemu test branch:
> >   https://git.kraxel.org/cgit/qemu/log/?h=sirius/udmabuf
> > 
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> I think some ack for a 2nd use-case, like virtio-wl or whatever would be
> really cool. To give us some assurance that this is generically useful.

Tomeu?  Laurent?

> Plus an ack from dma-buf folks (nag them on irc, you don't have them on Cc
> here).

Hmm, does MAINTAINERS need an update then?  Maintainer and mailing lists
listed in the "DMA BUFFER SHARING FRAMEWORK" entry are on Cc.

Who should be Cc'ed?

> Then this is imo good to go.
> 
> I assume you'll push it to drm-misc, like all the other dma-buf stuff?

Can do that, sure, after collecting the acks ...

thanks,
  Gerd

