Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3F2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A2B218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbeLSPVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:21:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbeLSPVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:21:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B49E81F12;
        Wed, 19 Dec 2018 15:21:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-174.ams2.redhat.com [10.36.117.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D71455DA67;
        Wed, 19 Dec 2018 15:21:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id CDCE516E29; Wed, 19 Dec 2018 16:21:29 +0100 (CET)
Date:   Wed, 19 Dec 2018 16:21:29 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Oleksandr Andrushchenko <andr2000@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] drm/bochs: add edid present check
Message-ID: <20181219152129.k7v4ttpsazguswke@sirius.home.kraxel.org>
References: <20181218073339.12160-1-kraxel@redhat.com>
 <93d72578-9567-9694-dbc7-62618b217f8f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93d72578-9567-9694-dbc7-62618b217f8f@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 19 Dec 2018 15:21:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> You could probably have a comment here explaining the magic below
> (just like in the commit message to ease the task of understanding
> while reading the code why 2 of 8 bytes of the EDID header is checked
> and why it is all needed). Of course one can use git blame... Up to you

Makes sense.

> > +	if (readb(bochs->mmio + 0) != 0x00 ||
> > +	    readb(bochs->mmio + 1) != 0xff)
> 
> bochs->mmio is defined as "void __iomem   *mmio;". Can we please avoid
> void pointer arithmetic here?

Why is that a problem?  gcc uses bytes when doing pointer arithmetic
with void pointers (even though it is undefined in the C standard),
and as far I know the linux kernel depends on that behavior anyway.

Also the driver already does it everywhere.

cheers,
  Gerd

