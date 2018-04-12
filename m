Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbeDLJPV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 05:15:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47620 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751583AbeDLJPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 05:15:19 -0400
Date: Thu, 12 Apr 2018 11:14:46 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: Fix leak of the file_priv that stored the
 perfmon.
Message-ID: <20180412111446.742450f0@bbrezillon>
In-Reply-To: <20180409205813.7077-1-eric@anholt.net>
References: <20180409205813.7077-1-eric@anholt.net>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Apr 2018 13:58:13 -0700
Eric Anholt <eric@anholt.net> wrote:

> Signed-off-by: Eric Anholt <eric@anholt.net>
> Fixes: 65101d8c9108 ("drm/vc4: Expose performance counters to userspace")

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/gpu/drm/vc4/vc4_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
> index 94b99c90425a..7c95ed5c5cac 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.c
> +++ b/drivers/gpu/drm/vc4/vc4_drv.c
> @@ -130,6 +130,7 @@ static void vc4_close(struct drm_device *dev, struct drm_file *file)
>  	struct vc4_file *vc4file = file->driver_priv;
>  
>  	vc4_perfmon_close_file(vc4file);
> +	kfree(vc4file);
>  }
>  
>  static const struct vm_operations_struct vc4_vm_ops = {
