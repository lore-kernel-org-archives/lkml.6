Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeFDHh0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:37:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750819AbeFDHhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:37:25 -0400
Date: Mon, 4 Jun 2018 09:37:23 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Jeremy Cline <jcline@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>, Ray Strode <rstrode@redhat.com>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] drm/qxl: Call qxl_bo_unref outside atomic context
Message-ID: <20180604073723.ld7b2h5veqsxoun6@sirius.home.kraxel.org>
References: <20180601200532.13619-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601200532.13619-1-jcline@redhat.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 04:05:32PM -0400, Jeremy Cline wrote:
> "qxl_bo_unref" may sleep, but calling "qxl_release_map" causes
> "preempt_disable()" to be called and "preempt_enable()" isn't called
> until "qxl_release_unmap" is used. Move the call to "qxl_bo_unref" out
> from in between the two to avoid sleeping from an atomic context.
> 
> This issue can be demonstrated on a kernel with CONFIG_LOCKDEP=y by
> creating a VM using QXL, using a desktop environment using Xorg, then
> moving the cursor on or off a window.
> 
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1571128
> Fixes: 9428088c90b6 ("drm/qxl: reapply cursor after resetting primary")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeremy Cline <jcline@redhat.com>

Pushed to drm-misc-fixes.

thanks,
  Gerd
