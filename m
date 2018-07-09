Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FE4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA513208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA513208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934017AbeGIRr5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:47:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933537AbeGIRrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:47:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC4D04001389;
        Mon,  9 Jul 2018 17:47:54 +0000 (UTC)
Received: from redhat.com (ovpn-120-201.rdu2.redhat.com [10.10.120.201])
        by smtp.corp.redhat.com (Postfix) with SMTP id B50872026D65;
        Mon,  9 Jul 2018 17:47:52 +0000 (UTC)
Date:   Mon, 9 Jul 2018 20:47:52 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gabriel Somlo <somlo@cmu.edu>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jean-Christophe Trotin <jean-christophe.trotin@st.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] headers: fix linux/mod_devicetable.h inclusions
Message-ID: <20180709204747-mutt-send-email-mst@kernel.org>
References: <20180709151947.940759-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709151947.940759-1-arnd@arndb.de>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 09 Jul 2018 17:47:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 09 Jul 2018 17:47:54 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 05:19:02PM +0200, Arnd Bergmann wrote:
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

Acked-by: Michael S. Tsirkin <mst@redhat.com>

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
> -- 
> 2.9.0
