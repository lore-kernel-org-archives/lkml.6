Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631E7C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E85E21738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfA1Lkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:40:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbfA1Lkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:40:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C59880F9B;
        Mon, 28 Jan 2019 11:40:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-116.ams2.redhat.com [10.36.116.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D94C5C2E0;
        Mon, 28 Jan 2019 11:40:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 13448A1E3; Mon, 28 Jan 2019 12:40:41 +0100 (CET)
Date:   Mon, 28 Jan 2019 12:40:41 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH v3 10/23] drm/qxl: move qxl_primary_apply_cursor to
 correct place
Message-ID: <20190128114041.ujyrq4ls6kbi7w3a@sirius.home.kraxel.org>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-11-kraxel@redhat.com>
 <b3c756b3-c7b6-f4d3-5208-c8de0168d655@tronnes.org>
 <20190128081005.j6z2ecnytuocfidh@sirius.home.kraxel.org>
 <44e41026-e091-659d-ac9c-fefa47e2335b@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44e41026-e091-659d-ac9c-fefa47e2335b@tronnes.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 28 Jan 2019 11:40:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > If the above explains things better to you I should probably replace the
> > commit message with that.
> 
> This is actually my first review of a driver that I'm not familiar with.
> I'm not quite sure how much in depth understanding that is required to
> put my ack on it.

Usually I try to show that by picking either Reviewed-by (I'm confident
the changes are fine) or Acked-by (Changes look sane, but I don't know
the code base and/or hardware good enough to be sure).

> Going further into the patchset I realised that
> there's no way that I can verify the logic without being intimate with
> the driver.

Yep.  Same for me when looking at patches for other drivers.  I think
this is one reason why it isn't that easy to get patches for drivers
reviewed where effectively only a single maintainer/developer is working
on.

> I liked your expanded explanation better.

Updated the commit message.

cheers,
  Gerd

