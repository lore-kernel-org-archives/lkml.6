Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818C2C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4743C20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4743C20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeJWOFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 10:05:14 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:8326 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726837AbeJWOFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 10:05:14 -0400
X-IronPort-AV: E=Sophos;i="5.54,414,1534802400"; 
   d="scan'208";a="283000269"
Received: from 30.9-255-62.static.virginmediabusiness.co.uk (HELO [172.16.7.66]) ([62.255.9.30])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 07:43:22 +0200
Date:   Tue, 23 Oct 2018 06:43:21 +0100 (BST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Thayer <michael.thayer@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] staging: vboxvideo: Removed unnecessary
 parentheses
In-Reply-To: <20181022223126.smnsopiu4cavq6zh@smtp.gmail.com>
Message-ID: <alpine.DEB.2.21.1810230640320.2343@hadrien>
References: <20181022223126.smnsopiu4cavq6zh@smtp.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Oct 2018, Shayenne da Luz Moura wrote:

> This patch fixes the checkpatch.pl check:
>
> vbox_main.c:119: CHECK: Unnecessary parentheses around 'rects[i].x2 <
> crtc->x'
> vbox_main.c:119: CHECK: Unnecessary parentheses around 'rects[i].y2 <
> crtc->y'

Please use the imperative, in the subject line and in the patch.  Also,
try to say something other than "fixes" about what you do, which is not
very descriptive.  Say what you actually did and why, eg remove unneeded
parentheses around the arguments of || to reduce clutter.

It is useful to mention that the change was suggested by checkpatch.  It
is not essential to copy the whole checkpatch message, or at least not all
of them.

thanks,
julia

>
> Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
> ---
>  drivers/staging/vboxvideo/vbox_main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/vboxvideo/vbox_main.c b/drivers/staging/vboxvideo/vbox_main.c
> index 429f6a453619..10a862674789 100644
> --- a/drivers/staging/vboxvideo/vbox_main.c
> +++ b/drivers/staging/vboxvideo/vbox_main.c
> @@ -116,10 +116,10 @@ void vbox_framebuffer_dirty_rectangles(struct drm_framebuffer *fb,
>  			struct vbva_cmd_hdr cmd_hdr;
>  			unsigned int crtc_id = to_vbox_crtc(crtc)->crtc_id;
>
> -			if ((rects[i].x1 > crtc->x + crtc->hwmode.hdisplay) ||
> -			    (rects[i].y1 > crtc->y + crtc->hwmode.vdisplay) ||
> -			    (rects[i].x2 < crtc->x) ||
> -			    (rects[i].y2 < crtc->y))
> +			if (rects[i].x1 > crtc->x + crtc->hwmode.hdisplay ||
> +			    rects[i].y1 > crtc->y + crtc->hwmode.vdisplay ||
> +			    rects[i].x2 < crtc->x ||
> +			    rects[i].y2 < crtc->y)
>  				continue;
>
>  			cmd_hdr.x = (s16)rects[i].x1;
> --
> 2.19.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20181022223126.smnsopiu4cavq6zh%40smtp.gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
