Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755419AbeBOKO6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 05:14:58 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36612 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeBOKO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 05:14:56 -0500
X-Google-Smtp-Source: AH8x224HFIwuosjZpUXr0HJnzxu6ZtsS9b7Y/3BDdAXCxrr9rO4vq4VS2bfWStkrYe4VctZ4lc/aXA==
Message-ID: <1518689694.2883.68.camel@baylibre.com>
Subject: Re: [PATCH] amlogic: meson-gx-socinfo: Update soc ids
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com
Cc: linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 15 Feb 2018 11:14:54 +0100
In-Reply-To: <1518620335-17716-1-git-send-email-narmstrong@baylibre.com>
References: <1518620335-17716-1-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-14 at 15:58 +0100, Neil Armstrong wrote:
> Updates the Amlogic Meson SoCs IDs for the Armv8 based SoCs.
> It includes the new families and packages.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/soc/amlogic/meson-gx-socinfo.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
> index f2d8c3c..a7efe30 100644
> --- a/drivers/soc/amlogic/meson-gx-socinfo.c
> +++ b/drivers/soc/amlogic/meson-gx-socinfo.c
> @@ -33,6 +33,10 @@ static const struct meson_gx_soc_id {
>  	{ "GXL", 0x21 },
>  	{ "GXM", 0x22 },
>  	{ "TXL", 0x23 },
> +	{ "TXLX", 0x24 },
> +	{ "AXG", 0x25 },
> +	{ "GXLX", 0x26 },
> +	{ "TXHD", 0x27 },
>  };
>  
>  static const struct meson_gx_package_id {
> @@ -47,6 +51,10 @@ static const struct meson_gx_package_id {
>  	{ "S905L", 0x21, 0xc0 },
>  	{ "S905M2", 0x21, 0xe0 },
>  	{ "S912", 0x22, 0 },
> +	{ "962X", 0x24, 0x10 },
> +	{ "962E", 0x24, 0x20 },
> +	{ "A113X", 0x25, 0x37 },
> +	{ "A113D", 0x25, 0xd0 },
>  };
>  
>  static inline unsigned int socinfo_to_major(u32 socinfo)

Tested on my s400 board which, according to the marking, features an AXG A113D.
AXG is detected correctly but the package id read is 0x22 instead of 0xd0.
