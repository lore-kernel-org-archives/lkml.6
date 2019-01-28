Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D26FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C902148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lTRFHakf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfA1Kxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:53:45 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47026 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfA1Kxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 05:53:44 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190128105342euoutp0172ea9bc2d8e765bc68154e6f69c2e45f~9-bn2DnMv2679126791euoutp01n
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:53:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190128105342euoutp0172ea9bc2d8e765bc68154e6f69c2e45f~9-bn2DnMv2679126791euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548672822;
        bh=MKKCe7fkoYZAi1LKlZjNTKiWd+STj86IKeZCj+4N/Jk=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=lTRFHakf5D26rLpKv2CtbW+o5A2B0cElVFdiRI6bOz3+WE1TF82Oy11WGOS9zhX0p
         FvO0yX/2KvV9AooOq0ihGtOh/NfSiOMikmp2nhFlfPejlT/1qRzoi2u87f29GnFjGw
         T6bDCFQHkpTCyaLhq4o7j8Ym8Z8GNWutgAqDL6vU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190128105341eucas1p16e4c6066ef3389633b2584c1ce91170d~9-bnY3liB0600606006eucas1p11;
        Mon, 28 Jan 2019 10:53:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 23.BD.04806.53FDE4C5; Mon, 28
        Jan 2019 10:53:41 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190128105340eucas1p2a4d8f9619f7fb50d35a58271589f012b~9-bmipkjj2080820808eucas1p2U;
        Mon, 28 Jan 2019 10:53:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190128105340eusmtrp1333cc734712c461e80a8c17ca7c0da1a~9-bmUPCFk0252402524eusmtrp1P;
        Mon, 28 Jan 2019 10:53:40 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-67-5c4edf354679
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3E.36.04128.43FDE4C5; Mon, 28
        Jan 2019 10:53:40 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190128105339eusmtip15c6fab8800866149f1f34bfa940e7caa~9-bl6ViQ71918319183eusmtip1h;
        Mon, 28 Jan 2019 10:53:39 +0000 (GMT)
Subject: Re: [PATCH v2] drm/bridge: sil_sii8620: make remote control
 optional.
To:     Inki Dae <inki.dae@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <d7e8493b-a1fc-3f7d-c715-5f72f15f9320@samsung.com>
Date:   Mon, 28 Jan 2019 11:53:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125013355.GA6722@innovation.ch>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djPc7qm9/1iDKb95bc4vOgFo8WVr+/Z
        LCbdn8Bi0TlxCbvFzU/fWC0u75rDZvHiubQDu8fOWXfZPWZ3zGT1uN99nMmjb8sqRo/Pm+Q8
        ZrRvYw1gi+KySUnNySxLLdK3S+DK6N43jblgi2HF1fknmRoYd2h0MXJySAiYSHzt/8vexcjF
        ISSwglHi7ZyZTBDOF0aJu0daGSGcz4wSXb2bWGFaPkyeBFW1nFHid9tyNgjnLaPExsnbwKqE
        BQIkzj+eygKSEBHoYpLYPGEpWIJNQFPi7+abbCA2r4CdRN+a+YwgNouAqsSV5zvAakQFIiQO
        975jhKgRlDg58wkLiM0pYCSxb9o1sDizgLxE89bZzBC2uMStJ/OZIM5bxy4x+2lwFyMHkO0i
        8eJ6NkRYWOLV8S3sELaMxOnJPSwQdr1E08wrzCB3Sgh0MEqcWLycDSJhLXH4+EVWkDnMQDev
        36UPEXaU6H50lBliPJ/EjbeCEBfwSUzaNh0qzCvR0SYEUa0ocf/sVmYIW1xi6YWvUMM9JL6+
        28o2gVFxFpIfZyH5axaSv2Yh3LCAkWUVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYCo6
        /e/41x2M+/4kHWIU4GBU4uHd8N83Rog1say4MvcQowQHs5II79TrfjFCvCmJlVWpRfnxRaU5
        qcWHGKU5WJTEeasZHkQLCaQnlqRmp6YWpBbBZJk4OKUaGE841sS9y+T8obTNPEjJ637++dxt
        07p4ltfc547UW8f1ON02T3lT2t8PzhuuzlVguDHXt5B91qKV3a/lv++Tck/Zdf/fA6tPZSsO
        3cn9f/9fUsvd1qPLprV8N361J+jgTKGn4aaShZm2u/eoyj1dfJ3tgciDzgOdHHeMYh055Du3
        6pbrz7s6Y68SS3FGoqEWc1FxIgDRQRDtQQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xu7om9/1iDH7uELQ4vOgFo8WVr+/Z
        LCbdn8Bi0TlxCbvFzU/fWC0u75rDZvHiubQDu8fOWXfZPWZ3zGT1uN99nMmjb8sqRo/Pm+Q8
        ZrRvYw1gi9KzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3
        S9DL6N43jblgi2HF1fknmRoYd2h0MXJySAiYSHyYPImpi5GLQ0hgKaPEy+mbGSES4hK7579l
        hrCFJf5c62KDKHrNKNHatJUJJCEs4Cdx/sxpVpCEiEAXk0TzqtMsIAkhgXWMEusXSYPYbAKa
        En8332QDsXkF7CT61swH28AioCpx5fkOVhBbVCBC4uPTfUwQNYISJ2c+AZvDKWAksW/aNbB6
        ZgF1iT/zLjFD2PISzVtnQ9niEreezGeawCg4C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGR
        XnFibnFpXrpecn7uJkZgnG079nPLDsaud8GHGAU4GJV4eDf8940RYk0sK67MPcQowcGsJMI7
        9bpfjBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnA1NAXkm8oamhuYWlobmxubGZhZI473mD
        yighgfTEktTs1NSC1CKYPiYOTqkGRlOJxd3iu3+ds6x1Oi5/L+Br/q0n8g+DVhVueXNrKvum
        Qg6jGTXLSm1sdnQ8rDrNavLj3kHZLYWNUs5L6zrFK041915rtcrq6rNmsfq3/3hohArP3iLm
        75zH1fIWu30PPxz9Wsc/SHLt2huhH0sPKgheUe0MiK07fLhLjPfFVOUDJku+b6i1VGIpzkg0
        1GIuKk4EAOv656nJAgAA
X-CMS-MailID: 20190128105340eucas1p2a4d8f9619f7fb50d35a58271589f012b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190125013406epcas3p2971d09f6836084e51cbf5d326593a93e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190125013406epcas3p2971d09f6836084e51cbf5d326593a93e
References: <20190124072125.GA28127@innovation.ch>
        <CGME20190125013406epcas3p2971d09f6836084e51cbf5d326593a93e@epcas3p2.samsung.com>
        <20190125013355.GA6722@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.01.2019 02:33, Ronald Tschalär wrote:
> commit d6abe6df706c (drm/bridge: sil_sii8620: do not have a dependency
> of RC_CORE) changed the driver to select both RC_CORE and INPUT.
> However, this causes problems with other drivers, in particular an input
> driver that depends on MFD_INTEL_LPSS_PCI (to be added in a separate
> commit):
>
>   drivers/clk/Kconfig:9:error: recursive dependency detected!
>   drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
>   drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
>   drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
>   drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
>   drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
>   drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
>   drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
>   drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK
>
> According to the docs and general consensus, select should only be used
> for non user-visible symbols, but both RC_CORE and INPUT are
> user-visible. Furthermore almost all other references to INPUT
> throughout the kernel config are depends, not selects. For this reason
> the first part of this change reverts commit d6abe6df706c.
>
> In order to address the original reason for commit d6abe6df706c, namely
> that not all boards use the remote controller functionality and hence
> should not need have to deal with RC_CORE, the second part of this
> change now makes the remote control support in the driver optional and
> contingent on RC_CORE being defined. And with this the hard dependency
> on INPUT also goes away as that is only needed if RC_CORE is defined
> (which in turn already depends on INPUT).


Thanks for fixing it, this seems to be a best way to deal with it, more
comments below.


>
> CC: Inki Dae <inki.dae@samsung.com>
> CC: Andrzej Hajda <a.hajda@samsung.com>
> CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> ---
> Resending this, as I somehow managed to forget to cc dri-devel.
> Apologies for the duplication.
>
> Changes in v2:
>  - completely remove dependencies on both RC_CORE and INPUT in Kconfig,
>  - make remote control functionality in driver contingent on RC_CORE
>    being defined
>
>  drivers/gpu/drm/bridge/Kconfig       |  2 --
>  drivers/gpu/drm/bridge/sil-sii8620.c | 17 +++++++++++++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 2fee47b0d50b..a11198a36005 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -85,8 +85,6 @@ config DRM_SIL_SII8620
>  	depends on OF
>  	select DRM_KMS_HELPER
>  	imply EXTCON
> -	select INPUT
> -	select RC_CORE


Shouldn't you put here "imply RC_CORE"? To avoid RC_CORE as module and
sii8620 built-in.


>  	help
>  	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
>  
> diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
> index 0cc293a6ac24..dee47752791e 100644
> --- a/drivers/gpu/drm/bridge/sil-sii8620.c
> +++ b/drivers/gpu/drm/bridge/sil-sii8620.c
> @@ -66,7 +66,9 @@ enum sii8620_mt_state {
>  struct sii8620 {
>  	struct drm_bridge bridge;
>  	struct device *dev;
> +#if IS_ENABLED(CONFIG_RC_CORE)
>  	struct rc_dev *rc_dev;
> +#endif
>  	struct clk *clk_xtal;
>  	struct gpio_desc *gpio_reset;
>  	struct gpio_desc *gpio_int;
> @@ -1756,6 +1758,7 @@ static void sii8620_send_features(struct sii8620 *ctx)
>  	sii8620_write_buf(ctx, REG_MDT_XMIT_WRITE_PORT, buf, ARRAY_SIZE(buf));
>  }
>  
> +#if IS_ENABLED(CONFIG_RC_CORE)
>  static bool sii8620_rcp_consume(struct sii8620 *ctx, u8 scancode)
>  {
>  	bool pressed = !(scancode & MHL_RCP_KEY_RELEASED_MASK);
> @@ -1774,6 +1777,12 @@ static bool sii8620_rcp_consume(struct sii8620 *ctx, u8 scancode)
>  
>  	return true;
>  }
> +#else
> +static bool sii8620_rcp_consume(struct sii8620 *ctx, u8 scancode)
> +{
> +	return false;
> +}
> +#endif
>  
>  static void sii8620_msc_mr_set_int(struct sii8620 *ctx)
>  {
> @@ -2097,6 +2106,7 @@ static void sii8620_cable_in(struct sii8620 *ctx)
>  	enable_irq(to_i2c_client(ctx->dev)->irq);
>  }
>  
> +#if IS_ENABLED(CONFIG_RC_CORE)
>  static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
>  {
>  	struct rc_dev *rc_dev;
> @@ -2126,6 +2136,11 @@ static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
>  	}
>  	ctx->rc_dev = rc_dev;
>  }
> +#else
> +static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
> +{
> +}
> +#endif
>  
>  static void sii8620_cable_out(struct sii8620 *ctx)
>  {
> @@ -2214,9 +2229,11 @@ static int sii8620_attach(struct drm_bridge *bridge)
>  
>  static void sii8620_detach(struct drm_bridge *bridge)
>  {
> +#if IS_ENABLED(CONFIG_RC_CORE)
>  	struct sii8620 *ctx = bridge_to_sii8620(bridge);
>  
>  	rc_unregister_device(ctx->rc_dev);
> +#endif
>  }


In two cases you create stub functions, in the third you put ifdefs
inside function, some lack of consistency.

I wonder if it wouldn't be better to create stubs just for rc_core
functions, the best would be to put stubs into rc-core.h, but if the
case of 'optional rc-core' is too rare you can put stubs into the driver:

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c
b/drivers/gpu/drm/bridge/sil-sii8620.c

index a6e8f4591e63..6ca838d30f93 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -35,6 +35,13 @@
 
 #include "sil-sii8620.h"
 
+#if !IS_ENABLED(CONFIG_RC_CORE)
+#define rc_unregister_device(dev) ({ (void)(dev); })
+#define rc_allocate_device(type) ({ NULL; })
+#define rc_keydown(...) ({ })
+#define rc_keyup(...) ({ })
+#endif
+
 #define SII8620_BURST_BUF_LEN 288
 #define VAL_RX_HDMI_CTRL2_DEFVAL VAL_RX_HDMI_CTRL2_IDLE_CNT(3)

Regards

Andrzej


>  
>  static int sii8620_is_packing_required(struct sii8620 *ctx,


