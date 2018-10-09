Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C298FC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE1C2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE1C2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeJIUoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:44:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51045 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbeJIUoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:44:05 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0ACBE207C3; Tue,  9 Oct 2018 15:27:07 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id CB43720712;
        Tue,  9 Oct 2018 15:27:06 +0200 (CEST)
Date:   Tue, 9 Oct 2018 15:27:07 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] drm/v3d: Add some better documentation of the
 in_sync arguments.
Message-ID: <20181009152707.4220a7d5@bbrezillon>
In-Reply-To: <20180928232126.4332-3-eric@anholt.net>
References: <20180928232126.4332-1-eric@anholt.net>
        <20180928232126.4332-3-eric@anholt.net>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018 16:21:25 -0700
Eric Anholt <eric@anholt.net> wrote:

> Since this is UAPI, it's good to document what exactly the guarantees
> we're providing are.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  include/uapi/drm/v3d_drm.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/uapi/drm/v3d_drm.h b/include/uapi/drm/v3d_drm.h
> index 7b6627783608..f446656d00b1 100644
> --- a/include/uapi/drm/v3d_drm.h
> +++ b/include/uapi/drm/v3d_drm.h
> @@ -58,6 +58,11 @@ struct drm_v3d_submit_cl {
>  	 * coordinate shader to determine where primitives land on the screen,
>  	 * then writes out the state updates and draw calls necessary per tile
>  	 * to the tile allocation BO.
> +	 *
> +	 * This BCL will block on any previous BCL submitted on the
> +	 * same FD, but not on any RCL or BCLs submitted by other
> +	 * clients -- that is left up to the submitter to control
> +	 * using in_sync_bcl if necessary.
>  	 */
>  	__u32 bcl_start;
>  
> @@ -69,6 +74,11 @@ struct drm_v3d_submit_cl {
>  	 * This is the second set of commands executed, which will either
>  	 * execute the tiles that have been set up by the BCL, or a fixed set
>  	 * of tiles (in the case of RCL-only blits).
> +	 *
> +	 * This RCL will block on this submit's BCL, and any previous
> +	 * RCL submitted on the same FD, but not on any RCL or BCLs
> +	 * submitted by other clients -- that is left up to the
> +	 * submitter to control using in_sync_rcl if necessary.
>  	 */
>  	__u32 rcl_start;
>  

