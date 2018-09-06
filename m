Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2276C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A233720873
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A233720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeIFL6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 07:58:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726136AbeIFL6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 07:58:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 739254021CC1;
        Thu,  6 Sep 2018 07:23:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-66.ams2.redhat.com [10.36.116.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0664E2156889;
        Thu,  6 Sep 2018 07:23:55 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id E8CAE4F968; Thu,  6 Sep 2018 09:23:54 +0200 (CEST)
Date:   Thu, 6 Sep 2018 09:23:54 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Peter Wu <peter@lekensteyn.nl>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] bochs: convert to drm_fb_helper_fbdev_setup/teardown
Message-ID: <20180906072354.2vsv67k2a2m43vx5@sirius.home.kraxel.org>
References: <20180905144127.5690-1-peter@lekensteyn.nl>
 <20180905144628.GG4929@phenom.ffwll.local>
 <20180905150630.GA25979@al>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905150630.GA25979@al>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 06 Sep 2018 07:23:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 06 Sep 2018 07:23:57 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > You can probably get rid of this one if you're refactoring even more. The
> > generic fb_probe implementation (already merged) plus gem-shmem support
> > for it (still in flight) from Noralf should be able to pull that off. That
> > gives you the fb_mmap implementation, but with 100% generic code instead
> > of a driver specific hack like Max did.
> 
> Aside from the warning, I have not observed actual issues. This patch
> was prepared on top of v4.18.1 but the new drm_fb_helper_generic_probe
> helper is in master (future 4.19). I suppose that it can be done as a
> future cleanup. Nice work Noralf on reducing duplication!

FYI: qemu kms driver patches go through drm-misc-next, so you can also
work against that branch.

> > I'll leave merging to Gerd.
> 
> Thanks, I somehow missed a patch. This one does not compile due to
> "fb.initialized" still being used in bochs_drv.c. Removal is trivial,
> I'll wait for some more feedback and then send a v2 with another patch
> prepended.

Patch looks good to me (except for the build failure which you've
noticed already).

cheers,
  Gerd

