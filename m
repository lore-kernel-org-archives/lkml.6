Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366D2C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 03:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4930208E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 03:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kW4e8Psr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4930208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbeGLDzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 23:55:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeGLDzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 23:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1zZ/qMwuazyL3fOAF2SvnSRT9tiIC6FgYYrse4LXR28=; b=kW4e8PsrxDWQObtaLHfUQn2fy
        zeg1HSA9MfuMIO8KEzJ5hgN2DFgtK55gF4ij+68hjIx2uvt/IowNcZjmcxY6wGwhwMDuQPsV2hRlp
        2vmKWXRoD4ISkCN2shEAGGSphbWr4IfQvrk+T6hR/Umr3y3cHM4yYX+3TuTUtC4arC8//sW26gxbz
        RE1wh3GFMZu+KbFCcycA6IuW6CiGBrd1+vHhooklJm0E1iYfsbIqHjhhdl3j+NSRrj04fWI/WD8+Q
        UpHMEkK34iav/EMja6S0NAlqzmKL2rLiEFaelQ4J7PT+MjCYklLRAka/uJd+l6hC6lvWpvjBBJFEV
        7DoTMDhhA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdSZl-0003Pe-Nb; Thu, 12 Jul 2018 03:47:29 +0000
Subject: Re: [PATCH] headers: fix linux/mod_devicetable.h inclusions
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Gabriel Somlo <somlo@cmu.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jean-Christophe Trotin <jean-christophe.trotin@st.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
        qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20180709151947.940759-1-arnd@arndb.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f1dcc366-d375-fe1b-771a-bb310fdc1df3@infradead.org>
Date:   Wed, 11 Jul 2018 20:47:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180709151947.940759-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2018 08:19 AM, Arnd Bergmann wrote:
> A couple of drivers produced build errors after the mod_devicetable.h
> header was split out from the platform_device one, e.g.
> 
> drivers/media/platform/davinci/vpbe_osd.c:42:40: error: array type has incomplete element type 'struct platform_device_id'
> drivers/media/platform/davinci/vpbe_venc.c:42:40: error: array type has incomplete element type 'struct platform_device_id'
> 
> This adds the inclusion where needed.
> 
> Fixes: ac3167257b9f ("headers: separate linux/mod_devicetable.h from linux/platform_device.h")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/firmware/qemu_fw_cfg.c             | 1 +
>  drivers/media/platform/davinci/vpbe_osd.c  | 1 +
>  drivers/media/platform/davinci/vpbe_venc.c | 1 +
>  drivers/media/platform/qcom/venus/vdec.c   | 1 +
>  drivers/media/platform/qcom/venus/venc.c   | 1 +
>  drivers/media/platform/sti/hva/hva-v4l2.c  | 1 +
>  drivers/platform/x86/intel_punit_ipc.c     | 1 +
>  7 files changed, 7 insertions(+)
> 
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index 14fedbeca724..039e0f91dba8 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -28,6 +28,7 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/acpi.h>
>  #include <linux/slab.h>
> diff --git a/drivers/media/platform/davinci/vpbe_osd.c b/drivers/media/platform/davinci/vpbe_osd.c
> index 7f610320426d..c551a25d90d9 100644
> --- a/drivers/media/platform/davinci/vpbe_osd.c
> +++ b/drivers/media/platform/davinci/vpbe_osd.c
> @@ -18,6 +18,7 @@
>   *
>   */
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/kernel.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> diff --git a/drivers/media/platform/davinci/vpbe_venc.c b/drivers/media/platform/davinci/vpbe_venc.c
> index ba157827192c..ddcad7b3e76c 100644
> --- a/drivers/media/platform/davinci/vpbe_venc.c
> +++ b/drivers/media/platform/davinci/vpbe_venc.c
> @@ -11,6 +11,7 @@
>   * GNU General Public License for more details.
>   */
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/ctype.h>
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index f89a91d43cc9..d4e23c7df347 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -14,6 +14,7 @@
>   */
>  #include <linux/clk.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index f7a87a3dbb46..0522cf202b75 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -14,6 +14,7 @@
>   */
>  #include <linux/clk.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> diff --git a/drivers/media/platform/sti/hva/hva-v4l2.c b/drivers/media/platform/sti/hva/hva-v4l2.c
> index 15080cb00fa7..5a807c7c5e79 100644
> --- a/drivers/media/platform/sti/hva/hva-v4l2.c
> +++ b/drivers/media/platform/sti/hva/hva-v4l2.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <media/v4l2-event.h>
> diff --git a/drivers/platform/x86/intel_punit_ipc.c b/drivers/platform/x86/intel_punit_ipc.c
> index b5b890127479..f1afc0ebbc68 100644
> --- a/drivers/platform/x86/intel_punit_ipc.c
> +++ b/drivers/platform/x86/intel_punit_ipc.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/acpi.h>
>  #include <linux/delay.h>
>  #include <linux/bitops.h>
> 


-- 
~Randy
