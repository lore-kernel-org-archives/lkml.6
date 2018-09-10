Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69306C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D3D20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D3D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbeIJLO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:14:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726405AbeIJLO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:14:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 13C1D401EF31;
        Mon, 10 Sep 2018 06:22:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-66.ams2.redhat.com [10.36.116.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99A0F101040D;
        Mon, 10 Sep 2018 06:22:32 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 93EEAB04; Mon, 10 Sep 2018 08:22:31 +0200 (CEST)
Date:   Mon, 10 Sep 2018 08:22:31 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Peter Wu <peter@lekensteyn.nl>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 4/4] drm/fb-helper: improve documentation and print
 warnings
Message-ID: <20180910062231.xengx26gsxbxjr42@sirius.home.kraxel.org>
References: <20180906221810.20170-1-peter@lekensteyn.nl>
 <20180906221810.20170-5-peter@lekensteyn.nl>
 <20180907194659.GC7176@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907194659.GC7176@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 10 Sep 2018 06:22:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 10 Sep 2018 06:22:33 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >   * This function sets up generic fbdev emulation for drivers that supports
> > - * dumb buffers with a virtual address and that can be mmap'ed.
> > + * dumb buffers with a virtual address and that can be mmap'ed. If the driver
> > + * does not support these functions, it could use drm_fb_helper_fbdev_setup().
> > + * This function can only be used with devices created using drm_dev_register().
> 
> This last line is misleading, since every drm device is called with
> drm_dev_register(). It's just not all called by driver code directly.
> With this line removed:
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> I'll leave it to Gerd to apply this all.

Fixed and pushed.

cheers,
  Gerd

