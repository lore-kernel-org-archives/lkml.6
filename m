Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932383AbeEWJdQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:33:16 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:17719 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932155AbeEWJdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:33:10 -0400
Subject: Re: [PATCH 15/61] gpu: drm: omapdrm: displays: simplify getting
 .drvdata
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-kernel@vger.kernel.org>
CC: <linux-renesas-soc@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-16-wsa+renesas@sang-engineering.com>
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <09116562-53e8-a6ca-42af-fcfd15f940ed@ti.com>
Date: Wed, 23 May 2018 12:32:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419140641.27926-16-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/18 17:05, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
> index 428de90fced1..8f8573a00e07 100644
> --- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
> +++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
> @@ -412,8 +412,7 @@ static const struct backlight_ops dsicm_bl_ops = {
>  static ssize_t dsicm_num_errors_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
> +	struct panel_drv_data *ddata = dev_get_drvdata(dev);
>  	struct omap_dss_device *in = ddata->in;
>  	u8 errors = 0;
>  	int r;
> @@ -444,8 +443,7 @@ static ssize_t dsicm_num_errors_show(struct device *dev,
>  static ssize_t dsicm_hw_revision_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
> +	struct panel_drv_data *ddata = dev_get_drvdata(dev);
>  	struct omap_dss_device *in = ddata->in;
>  	u8 id1, id2, id3;
>  	int r;
> @@ -476,8 +474,7 @@ static ssize_t dsicm_store_ulps(struct device *dev,
>  		struct device_attribute *attr,
>  		const char *buf, size_t count)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
> +	struct panel_drv_data *ddata = dev_get_drvdata(dev);
>  	struct omap_dss_device *in = ddata->in;
>  	unsigned long t;
>  	int r;
> @@ -511,8 +508,7 @@ static ssize_t dsicm_show_ulps(struct device *dev,
>  		struct device_attribute *attr,
>  		char *buf)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
> +	struct panel_drv_data *ddata = dev_get_drvdata(dev);
>  	unsigned int t;
>  
>  	mutex_lock(&ddata->lock);
> @@ -526,8 +522,7 @@ static ssize_t dsicm_store_ulps_timeout(struct device *dev,
>  		struct device_attribute *attr,
>  		const char *buf, size_t count)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
> +	struct panel_drv_data *ddata = dev_get_drvdata(dev);
>  	struct omap_dss_device *in = ddata->in;
>  	unsigned long t;
>  	int r;
> @@ -558,8 +553,7 @@ static ssize_t dsicm_show_ulps_timeout(struct device *dev,
>  		struct device_attribute *attr,
>  		char *buf)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
> +	struct panel_drv_data *ddata = dev_get_drvdata(dev);
>  	unsigned int t;
>  
>  	mutex_lock(&ddata->lock);
> 

Thanks, I have picked this up.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
