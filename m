Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715D1ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299CC2081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299CC2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbeKEP40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 10:56:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729182AbeKEP40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 10:56:26 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4485B308AA12;
        Mon,  5 Nov 2018 06:38:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-158.ams2.redhat.com [10.36.116.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E421E17AEC;
        Mon,  5 Nov 2018 06:38:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id DBF04945; Mon,  5 Nov 2018 07:38:18 +0100 (CET)
Date:   Mon, 5 Nov 2018 07:38:18 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Robert Foss <robert.foss@collabora.com>
Cc:     Emil Velikov <emil.l.velikov@gmail.com>,
        David Airlie <airlied@linux.ie>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Subject: Re: [PATCH 1/5] drm/virtio: add virtio_gpu_alloc_fence()
Message-ID: <20181105063818.b2yvncgzlnat5qn2@sirius.home.kraxel.org>
References: <20181025183739.9375-1-robert.foss@collabora.com>
 <20181025183739.9375-2-robert.foss@collabora.com>
 <CACvgo516JGdfBZ8zM73bQ-TCeNEbOp9ioBy9jh0AAtpUsu5tOg@mail.gmail.com>
 <1c92b6dc-4152-c81b-5180-2f48799b959f@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c92b6dc-4152-c81b-5180-2f48799b959f@collabora.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 05 Nov 2018 06:38:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Thu, 25 Oct 2018 at 19:38, Robert Foss <robert.foss@collabora.com> wrote:
> > > 
> > > From: Gustavo Padovan <gustavo.padovan@collabora.com>
> > > 
> > > Refactor fence creation to remove the potential allocation failure from
> > > the cmd_submit and atomic_commit paths. Now the fence should be allocated
> > > first and just after we should proceed with the rest of the execution.
> > > 
> > 
> > Commit does a bit more that what the above says:
> >   - dummy, factor out fence creation/destruction
> >   - use per virtio_gpu_framebuffer fence
> > 
> > Personally I'd keep the two separate patches and elaborate on the latter.
> > Obviously in that case, one will need to add 3 lines worth of
> > virtio_gpu_fence_alloc() in virtio_gpu_cursor_plane_update which will be nuked
> > with the next patch.
> > 
> > Not a big deal, but it's up-to the maintainer to make the final call if it's
> > worth splitting or not.
> 
> Agreed, I'll hold off with this change until then.

No need to split this, but a bit more verbose commit message would be
good.

cheers,
  Gerd

