Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BybHH05ZGlv6WwAAmS7hNA
	; Fri, 08 Jun 2018 10:24:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 70256605A5; Fri,  8 Jun 2018 10:24:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BFDB060590;
	Fri,  8 Jun 2018 10:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BFDB060590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbeFHKYL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 06:24:11 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48323 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbeFHKYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 06:24:10 -0400
Received: from weser.hi.pengutronix.de ([2001:67c:670:100:fa0f:41ff:fe58:4010])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fREYx-0008TL-UQ; Fri, 08 Jun 2018 12:24:07 +0200
Message-ID: <1528453446.26356.12.camel@pengutronix.de>
Subject: Re: [PATCH 3/3] drm/v3d: Add a note about locking of
 v3d_fence_create().
From: Lucas Stach <l.stach@pengutronix.de>
To: Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Date: Fri, 08 Jun 2018 12:24:06 +0200
In-Reply-To: <20180605190302.18279-3-eric@anholt.net>
References: <20180605190302.18279-1-eric@anholt.net>
         <20180605190302.18279-3-eric@anholt.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 05.06.2018, 12:03 -0700 schrieb Eric Anholt:
> This isn't the first time I've had to argue to myself why the '++' was
> safe.

And now you need to do the same thing with me...

> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/gpu/drm/v3d/v3d_fence.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_fence.c b/drivers/gpu/drm/v3d/v3d_fence.c
> index bfe31a89668b..6265e9ab4a13 100644
> --- a/drivers/gpu/drm/v3d/v3d_fence.c
> +++ b/drivers/gpu/drm/v3d/v3d_fence.c
> @@ -3,6 +3,9 @@
>  
>  #include "v3d_drv.h"
>  
> +/* Note that V3D fences are created during v3d_job_run(), so we're
> + * already implictly locked.
> + */
I don't see where you would be locked in the job_run path. I think what
you mean is that this path needs no locks, as it is driven by a single
scheduler thread, right?

Regards,
Lucas
