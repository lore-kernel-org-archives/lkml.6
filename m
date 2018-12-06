Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB40DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D5820892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D5820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbeLFOVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:21:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbeLFOVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:21:41 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93FCA394D43;
        Thu,  6 Dec 2018 14:21:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com [10.36.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3754710018F9;
        Thu,  6 Dec 2018 14:21:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 0BEA08FE6; Thu,  6 Dec 2018 15:21:40 +0100 (CET)
Date:   Thu, 6 Dec 2018 15:21:39 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Frediano Ziglio <fziglio@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [Spice-devel] [PATCH] drm/qxl: use qxl_num_crtc directly
Message-ID: <20181206142139.afd75c6nmjsbx2m4@sirius.home.kraxel.org>
References: <20181206103352.20587-1-kraxel@redhat.com>
 <207905511.48580418.1544093965441.JavaMail.zimbra@redhat.com>
 <20181206114217.vog4fgae73us437u@sirius.home.kraxel.org>
 <1902655248.48590444.1544100790071.JavaMail.zimbra@redhat.com>
 <20181206134933.krvdvoz52lkpewb5@sirius.home.kraxel.org>
 <621894308.48603466.1544105415949.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <621894308.48603466.1544105415949.JavaMail.zimbra@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 06 Dec 2018 14:21:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > qdev->monitors_config->max_allowed is effectively set by a module
> > parameter.  So using the module parameter variable qxl_num_crtc
> > directly is better IMO.  The kernel doesn't need to dereference pointers
> > each time it needs the value, and when reading the code you don't have
> > to trace where and why qdev->monitors_config->max_allowed is set.
> 
> That should go to the commit message!
> With that the patch is fine for me.

ok, I'll improve the message.

> Maybe there's no much point on reusing the same structure used
> inside QXLRom/QXLRam but this is OT for this patch.

It's part of the qxl device ABI, the same structure is used for both
host->guest (config hint from spice-client) and guest->host (actual
configuration).

cheers,
  Gerd

