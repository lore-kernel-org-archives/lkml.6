Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031600AbeBNV46 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 16:56:58 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35956 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031452AbeBNV44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 16:56:56 -0500
X-Google-Smtp-Source: AH8x2279lXoDrbssiHGIARtGy46AhqoAd0o0p3WpVP8yo4XEgYM1LmSa0EYjkm8L0yYf3jXg7wITbA==
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Bartlomiej Zolnierkiewicz'" <b.zolnierkie@samsung.com>,
        <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
References: <CGME20180214120041epcas2p37afd51e693a9cad842e59128a77d45ac@epcas2p3.samsung.com> <2621881.tniV7NOQqn@amdc3058>
In-Reply-To: <2621881.tniV7NOQqn@amdc3058>
Subject: Re: [PATCH] video: fbdev: s3c-fb: remove dead platform code for Exynos and S5PV210 platforms
Date: Wed, 14 Feb 2018 16:56:53 -0500
Message-ID: <000001d3a5de$b9d2d080$2d787180$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDUKqHbLQa96xveCpHkrbN/LhrfHAGkShWhpZZFhhA=
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, February 14, 2018 7:01 AM wrote:
> 
> Exynos5, Exynos4 and S5PV210 platforms have been converted to
> use Device Tree and Exynos DRM driver long time ago.  Remove
> dead platform code for these platforms and update Kconfig
> s3c-fb entry accordingly.
> 
> Cc: Jingoo Han <jingoohan1@gmail.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/video/fbdev/Kconfig  |    3
>  drivers/video/fbdev/s3c-fb.c |  162 -------------------------------------
> ------
>  2 files changed, 1 insertion(+), 164 deletions(-)
> 
> Index: b/drivers/video/fbdev/Kconfig
> ===================================================================
> --- a/drivers/video/fbdev/Kconfig	2018-02-12 14:28:32.392677896
> +0100
> +++ b/drivers/video/fbdev/Kconfig	2018-02-14 12:54:06.399057592
> +0100
> @@ -2020,8 +2020,7 @@ config FB_TMIO_ACCELL
> 
>  config FB_S3C
>  	tristate "Samsung S3C framebuffer support"
> -	depends on FB && (CPU_S3C2416 || ARCH_S3C64XX || \
> -		ARCH_S5PV210 || ARCH_EXYNOS)
> +	depends on FB && (CPU_S3C2416 || ARCH_S3C64XX)
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> Index: b/drivers/video/fbdev/s3c-fb.c
> ===================================================================
> --- a/drivers/video/fbdev/s3c-fb.c	2017-10-18 14:35:22.063448310
> +0200
> +++ b/drivers/video/fbdev/s3c-fb.c	2018-02-14 12:04:00.719262463
> +0100
> @@ -1716,63 +1716,6 @@ static struct s3c_fb_win_variant s3c_fb_
>  	},
>  };
> 
> -static struct s3c_fb_win_variant s3c_fb_data_s5p_wins[] = {
> -	[0] = {
> -		.has_osd_c	= 1,
> -		.osd_size_off	= 0x8,
> -		.palette_sz	= 256,
> -		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(13) |
> -				   VALID_BPP(15) | VALID_BPP(16) |
> -				   VALID_BPP(18) | VALID_BPP(19) |
> -				   VALID_BPP(24) | VALID_BPP(25) |
> -				   VALID_BPP(32)),
> -	},
> -	[1] = {
> -		.has_osd_c	= 1,
> -		.has_osd_d	= 1,
> -		.osd_size_off	= 0xc,
> -		.has_osd_alpha	= 1,
> -		.palette_sz	= 256,
> -		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(13) |
> -				   VALID_BPP(15) | VALID_BPP(16) |
> -				   VALID_BPP(18) | VALID_BPP(19) |
> -				   VALID_BPP(24) | VALID_BPP(25) |
> -				   VALID_BPP(32)),
> -	},
> -	[2] = {
> -		.has_osd_c	= 1,
> -		.has_osd_d	= 1,
> -		.osd_size_off	= 0xc,
> -		.has_osd_alpha	= 1,
> -		.palette_sz	= 256,
> -		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(13) |
> -				   VALID_BPP(15) | VALID_BPP(16) |
> -				   VALID_BPP(18) | VALID_BPP(19) |
> -				   VALID_BPP(24) | VALID_BPP(25) |
> -				   VALID_BPP(32)),
> -	},
> -	[3] = {
> -		.has_osd_c	= 1,
> -		.has_osd_alpha	= 1,
> -		.palette_sz	= 256,
> -		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(13) |
> -				   VALID_BPP(15) | VALID_BPP(16) |
> -				   VALID_BPP(18) | VALID_BPP(19) |
> -				   VALID_BPP(24) | VALID_BPP(25) |
> -				   VALID_BPP(32)),
> -	},
> -	[4] = {
> -		.has_osd_c	= 1,
> -		.has_osd_alpha	= 1,
> -		.palette_sz	= 256,
> -		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(13) |
> -				   VALID_BPP(15) | VALID_BPP(16) |
> -				   VALID_BPP(18) | VALID_BPP(19) |
> -				   VALID_BPP(24) | VALID_BPP(25) |
> -				   VALID_BPP(32)),
> -	},
> -};
> -
>  static struct s3c_fb_driverdata s3c_fb_data_64xx = {
>  	.variant = {
>  		.nr_windows	= 5,
> @@ -1804,102 +1747,6 @@ static struct s3c_fb_driverdata s3c_fb_d
>  	.win[4]	= &s3c_fb_data_64xx_wins[4],
>  };
> 
> -static struct s3c_fb_driverdata s3c_fb_data_s5pv210 = {
> -	.variant = {
> -		.nr_windows	= 5,
> -		.vidtcon	= VIDTCON0,
> -		.wincon		= WINCON(0),
> -		.winmap		= WINxMAP(0),
> -		.keycon		= WKEYCON,
> -		.osd		= VIDOSD_BASE,
> -		.osd_stride	= 16,
> -		.buf_start	= VIDW_BUF_START(0),
> -		.buf_size	= VIDW_BUF_SIZE(0),
> -		.buf_end	= VIDW_BUF_END(0),
> -
> -		.palette = {
> -			[0] = 0x2400,
> -			[1] = 0x2800,
> -			[2] = 0x2c00,
> -			[3] = 0x3000,
> -			[4] = 0x3400,
> -		},
> -
> -		.has_shadowcon	= 1,
> -		.has_blendcon	= 1,
> -		.has_clksel	= 1,
> -		.has_fixvclk	= 1,
> -	},
> -	.win[0]	= &s3c_fb_data_s5p_wins[0],
> -	.win[1]	= &s3c_fb_data_s5p_wins[1],
> -	.win[2]	= &s3c_fb_data_s5p_wins[2],
> -	.win[3]	= &s3c_fb_data_s5p_wins[3],
> -	.win[4]	= &s3c_fb_data_s5p_wins[4],
> -};
> -
> -static struct s3c_fb_driverdata s3c_fb_data_exynos4 = {
> -	.variant = {
> -		.nr_windows	= 5,
> -		.vidtcon	= VIDTCON0,
> -		.wincon		= WINCON(0),
> -		.winmap		= WINxMAP(0),
> -		.keycon		= WKEYCON,
> -		.osd		= VIDOSD_BASE,
> -		.osd_stride	= 16,
> -		.buf_start	= VIDW_BUF_START(0),
> -		.buf_size	= VIDW_BUF_SIZE(0),
> -		.buf_end	= VIDW_BUF_END(0),
> -
> -		.palette = {
> -			[0] = 0x2400,
> -			[1] = 0x2800,
> -			[2] = 0x2c00,
> -			[3] = 0x3000,
> -			[4] = 0x3400,
> -		},
> -
> -		.has_shadowcon	= 1,
> -		.has_blendcon	= 1,
> -		.has_fixvclk	= 1,
> -	},
> -	.win[0]	= &s3c_fb_data_s5p_wins[0],
> -	.win[1]	= &s3c_fb_data_s5p_wins[1],
> -	.win[2]	= &s3c_fb_data_s5p_wins[2],
> -	.win[3]	= &s3c_fb_data_s5p_wins[3],
> -	.win[4]	= &s3c_fb_data_s5p_wins[4],
> -};
> -
> -static struct s3c_fb_driverdata s3c_fb_data_exynos5 = {
> -	.variant = {
> -		.nr_windows	= 5,
> -		.vidtcon	= FIMD_V8_VIDTCON0,
> -		.wincon		= WINCON(0),
> -		.winmap		= WINxMAP(0),
> -		.keycon		= WKEYCON,
> -		.osd		= VIDOSD_BASE,
> -		.osd_stride	= 16,
> -		.buf_start	= VIDW_BUF_START(0),
> -		.buf_size	= VIDW_BUF_SIZE(0),
> -		.buf_end	= VIDW_BUF_END(0),
> -
> -		.palette = {
> -			[0] = 0x2400,
> -			[1] = 0x2800,
> -			[2] = 0x2c00,
> -			[3] = 0x3000,
> -			[4] = 0x3400,
> -		},
> -		.has_shadowcon	= 1,
> -		.has_blendcon	= 1,
> -		.has_fixvclk	= 1,
> -	},
> -	.win[0]	= &s3c_fb_data_s5p_wins[0],
> -	.win[1]	= &s3c_fb_data_s5p_wins[1],
> -	.win[2]	= &s3c_fb_data_s5p_wins[2],
> -	.win[3]	= &s3c_fb_data_s5p_wins[3],
> -	.win[4]	= &s3c_fb_data_s5p_wins[4],
> -};
> -
>  /* S3C2443/S3C2416 style hardware */
>  static struct s3c_fb_driverdata s3c_fb_data_s3c2443 = {
>  	.variant = {
> @@ -1942,15 +1789,6 @@ static const struct platform_device_id s
>  		.name		= "s3c-fb",
>  		.driver_data	= (unsigned long)&s3c_fb_data_64xx,
>  	}, {
> -		.name		= "s5pv210-fb",
> -		.driver_data	= (unsigned long)&s3c_fb_data_s5pv210,
> -	}, {
> -		.name		= "exynos4-fb",
> -		.driver_data	= (unsigned long)&s3c_fb_data_exynos4,
> -	}, {
> -		.name		= "exynos5-fb",
> -		.driver_data	= (unsigned long)&s3c_fb_data_exynos5,
> -	}, {
>  		.name		= "s3c2443-fb",
>  		.driver_data	= (unsigned long)&s3c_fb_data_s3c2443,
>  	},
