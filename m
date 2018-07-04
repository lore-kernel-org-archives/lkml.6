Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8CEC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796DD22448
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796DD22448
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934357AbeGDI6c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:58:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932324AbeGDI61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:58:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BDC3530832C5;
        Wed,  4 Jul 2018 08:58:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-220.phx2.redhat.com [10.3.116.220])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C89B60BE5;
        Wed,  4 Jul 2018 08:58:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 180EC17445; Wed,  4 Jul 2018 10:58:25 +0200 (CEST)
Date:   Wed, 4 Jul 2018 10:58:25 +0200
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
Message-ID: <20180704085825.nfkv5i7ultaavjve@sirius.home.kraxel.org>
References: <20180703075359.30349-1-kraxel@redhat.com>
 <20180703083757.GG7880@phenom.ffwll.local>
 <20180704055338.n3b7oexltaejqmcd@sirius.home.kraxel.org>
 <20180704080807.GH3891@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704080807.GH3891@phenom.ffwll.local>
User-Agent: NeoMutt/20180622
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 04 Jul 2018 08:58:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > Hmm, does MAINTAINERS need an update then?  Maintainer and mailing lists
> > listed in the "DMA BUFFER SHARING FRAMEWORK" entry are on Cc.
> 
> Yeah, maintainers entry with you as maintainer plus dri-devel as mailing
> list plus drm-misc as repo would be good. Just grep for drm-misc.git for
> tons of examples.

There is an *existing* entry covering drivers/dma-buf/, and I've dropped
udmabuf.c into that directory, so I've assumed get_maintainers.pl picks
up all relevant dma-buf folks ...

Covering udmabuf.c maintainance is a different issue.  I could just add
myself to the existing entry, or create a new one specifically for
udmabuf.

> > Who should be Cc'ed?
> 
> dim add-missing-cc ftw :-)

That just uses get_maintainer.pl according to the docs, so that wouldn't
change things as that is wired up as sendemail.cccmd already.  Except
that dim would probably add the list of people to the commit message.

cheers,
  Gerd

