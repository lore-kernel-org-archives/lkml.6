Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165760AbeE1Oc7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:32:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54638 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161676AbeE1Ocz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 10:32:55 -0400
Date: Mon, 28 May 2018 16:32:43 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 8/8] drm/bridge: cdns: mark PM functions as
 __maybe_unused
Message-ID: <20180528163243.538de32f@bbrezillon>
In-Reply-To: <20180525155030.3667352-8-arnd@arndb.de>
References: <20180525155030.3667352-1-arnd@arndb.de>
        <20180525155030.3667352-8-arnd@arndb.de>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Thierry

Hi Arnd,

On Fri, 25 May 2018 17:50:15 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> These two functions are unused in some configurations, and using __maybe_unused
> is the easiest way to shut up the harmless warnings:
> 
> drivers/gpu/drm/bridge/cdns-dsi.c:1353:12: error: 'cdns_dsi_suspend' defined but not used [-Werror=unused-function]
>  static int cdns_dsi_suspend(struct device *dev)
>             ^~~~~~~~~~~~~~~~
> drivers/gpu/drm/bridge/cdns-dsi.c:1340:12: error: 'cdns_dsi_resume' defined but not used [-Werror=unused-function]
>  static int cdns_dsi_resume(struct device *dev)
> 
> Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hm, I thought such a patch had already been applied by Thierry [1].

[1]https://www.spinics.net/lists/dri-devel/msg174363.html

> ---
>  drivers/gpu/drm/bridge/cdns-dsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
> index c255fc3e1be5..f2d43f24acfb 100644
> --- a/drivers/gpu/drm/bridge/cdns-dsi.c
> +++ b/drivers/gpu/drm/bridge/cdns-dsi.c
> @@ -1337,7 +1337,7 @@ static const struct mipi_dsi_host_ops cdns_dsi_ops = {
>  	.transfer = cdns_dsi_transfer,
>  };
>  
> -static int cdns_dsi_resume(struct device *dev)
> +static int __maybe_unused cdns_dsi_resume(struct device *dev)
>  {
>  	struct cdns_dsi *dsi = dev_get_drvdata(dev);
>  
> @@ -1350,7 +1350,7 @@ static int cdns_dsi_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static int cdns_dsi_suspend(struct device *dev)
> +static int __maybe_unused cdns_dsi_suspend(struct device *dev)
>  {
>  	struct cdns_dsi *dsi = dev_get_drvdata(dev);
>  
