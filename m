Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AD6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FC320818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfBVHOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:14:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfBVHOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:14:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38A803680A;
        Fri, 22 Feb 2019 07:14:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-228.ams2.redhat.com [10.36.116.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBD9F5C28F;
        Fri, 22 Feb 2019 07:14:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id EBB0811AAB; Fri, 22 Feb 2019 08:14:18 +0100 (CET)
Date:   Fri, 22 Feb 2019 08:14:18 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] drm/qxl: kick out vgacon
Message-ID: <20190222071418.mafr3rtrtspd44fr@sirius.home.kraxel.org>
References: <20190221113534.20764-1-kraxel@redhat.com>
 <20190221113534.20764-3-kraxel@redhat.com>
 <20190221122011.GP2665@phenom.ffwll.local>
 <20190221151139.ul2ihzd2yi4m47tf@sirius.home.kraxel.org>
 <CAKMK7uE+YzvBuaJVrNc0VzTQKmnDzNMoZDXohrh0M+PAfRFcBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uE+YzvBuaJVrNc0VzTQKmnDzNMoZDXohrh0M+PAfRFcBw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 22 Feb 2019 07:14:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> PCI_COMMAND_MEM and PCI_COMMAND_IO. There doesn't seem to be any
> separate bits really. That's at least what I've gleaned from vgaarb.c.
> The magic legacy vga decode bits only seem to exist on bridges, maybe
> we can extract that logic from vgaarb.c (yes this is all a bit
> spiralling out of control).

Also makes me wonder whenever vgaarb is the better place (compared to
drm_fb_helper).  Tried that, doesn't look too bad, should continue
working with CONFIG_FB=n.  Will send patches in a moment.

cheers,
  Gerd

