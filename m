Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0C6C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A188220863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfBAIBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:01:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfBAIBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:01:15 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7F27539E3;
        Fri,  1 Feb 2019 08:01:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-249.ams2.redhat.com [10.36.116.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35B3F5D9D6;
        Fri,  1 Feb 2019 08:01:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5EE15A1E8; Fri,  1 Feb 2019 09:01:13 +0100 (CET)
Date:   Fri, 1 Feb 2019 09:01:13 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v2 4/6] drm/virtio: params struct for
 virtio_gpu_cmd_create_resource_3d()
Message-ID: <20190201080113.mhlzpyek62cfc5qe@sirius.home.kraxel.org>
References: <20190130094338.14203-1-kraxel@redhat.com>
 <20190130094338.14203-5-kraxel@redhat.com>
 <4d3064ef-9993-106a-74b5-73a29c08975e@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d3064ef-9993-106a-74b5-73a29c08975e@tronnes.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 01 Feb 2019 08:01:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:47:38AM +0100, Noralf Trønnes wrote:
> 
> 
> Den 30.01.2019 10.43, skrev Gerd Hoffmann:
> > Add 3d resource parameters to virtio_gpu_object_params struct.  With
> > that in place we can use it for virtio_gpu_cmd_resource_create_3d()
> > calls.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> 
> You don't remove the struct virtio_gpu_resource_create_3d definition,
> but it looks like there's no users left?

virtio_gpu_cmd_resource_create_3d() still uses it (and has to, it is
part of the guest <-> host protocol).

cheers,
  Gerd

