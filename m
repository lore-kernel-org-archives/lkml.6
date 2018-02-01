Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752543AbeBAQOT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:14:19 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:39306 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbeBAQOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:14:15 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180201161412epoutp011434fefc53736b19723529e978ee63cd~PP7aVBkpd2036620366epoutp01V
X-AuditID: b6c32a36-c91ff70000001028-95-5a733cd4efa0
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Clark <robdclark@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fbdev: don't select I2C directly
Date: Thu, 01 Feb 2018 17:14:09 +0100
Message-id: <1737876.npfVsP8Sog@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180115161431.803248-1-arnd@arndb.de>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZdlhTX/eKTXGUwfUjwhZ/Jx1jt7jy9T2b
        xcYF2RYn+j6wWnT8/cJocXnXHDaL5wt/MFu0HTvGarHyxCxmB06P378mMXpc7utl8tg56y67
        x51re9g87ncfZ/I4eeoJi8fnTXIB7FFcNimpOZllqUX6dglcGc8nqxQ06VW8mfabqYFxn3IX
        IyeHhICJxOd9V5m7GLk4hAR2MErs7ljEBuF8Z5Tof3KHqYuRA6zq6/wwiPhuRokzrUtZIJyv
        jBKLbv9kAxnFJmAlMbF9FSOILSKgKDH1xTOwscwCC5gkpm16zgSSEBawlDi3fBGYzSKgKrHj
        TQeYzSugKXH//C8wW1TAS2LLvnYwmxNo856319ggagQlfky+xwJiMwvIS+zbP5UVwtaROHts
        HSPIMgmB22wSr489YYR4zkXi/InfbBC2sMSr41vYId6Rlrh01BYiPJ1RYvtvCYjezYwSq3ZP
        YIdIWEscPn4RagGfxLuvPawQvbwSHW1CECUeEucPf4ca7yix/sMJVkiotDNK9Bw5yTaBUXYW
        krtnIbl7FpK7FzAyr2IUSy0ozk1PLTYsMNIrTswtLs1L10vOz93ECE4lWmY7GBed8znEKMDB
        qMTDmyBbHCXEmlhWXJl7iFGCg1lJhPfNvqIoId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwBAS5R
        QgLpiSWp2ampBalFMFkmDk6pBkbbqfyHlp7dKe+2r/yXe8X9FxsPrOjdcOim5AeTg1c03dcs
        PV/V+5VriXB+mJq2xmNjxTOSX5OUOWOiLYNvPXg460Dwnz8v7Zdcnraq7Puma5mLeT8HvuOO
        +nT3SBtPMfO7wj/iT8QmW5yYGs1RFrl6iehq2zVH6ybEtn5KP6CaOVdUb9dcnsZnSizFGYmG
        WsxFxYkAR2O5giEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t9jAd3LNsVRBien6ln8nXSM3eLK1/ds
        FhsXZFuc6PvAatHx9wujxeVdc9gsni/8wWzRduwYq8XKE7OYHTg9fv+axOhxua+XyWPnrLvs
        Hneu7WHzuN99nMnj5KknLB6fN8kFsEdx2aSk5mSWpRbp2yVwZTyfrFLQpFfxZtpvpgbGfcpd
        jBwcEgImEl/nh3UxcnEICexklJjTuosRwvnKKHH+eCdLFyMnB5uAlcTE9lWMILaIgKLE1BfP
        mEFsZoFFTBJN3SIgtrCApcS55YuYQGwWAVWJHW86wGxeAU2J++d/gdmiAl4SW/a1g9mcQIv3
        vL3GBmILCXQySqz+JQFRLyjxY/I9Foj58hL79k9lhbC1JNbvPM40gZF/FpKyWUjKZiEpW8DI
        vIpRMrWgODc9t9iowDAvtVyvODG3uDQvXS85P3cTIzDwtx3W6tvBeH9J/CFGAQ5GJR7eBNni
        KCHWxLLiytxDjBIczEoivG/2FUUJ8aYkVlalFuXHF5XmpBYfYpTmYFES572ddyxSSCA9sSQ1
        OzW1ILUIJsvEwSnVwCjmwSzt+9NGxOesgFpySeSymIi89Kk/YqyMmGvMmOdOWqWT4Ln56Iy0
        J8/rIzttM46yVK64eN+/6Oei1knXf9uevHX69MfpD7Ya+Mx30ZBPfKZ288kaX4GvfF0KoddF
        3R/r6jTwe5w/tfTf6tm/j/xa9MPSeeXCyzxNG8P7mjxdHrabbNW9c1yJpTgj0VCLuag4EQAZ
        ozgDeAIAAA==
X-CMS-MailID: 20180201161411epcas1p233fad3c7ed0b1301579a736ac186df0d
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180115161439epcas3p1006f02c4e49f58c30c4aec1b0b11b0a7
X-RootMTR: 20180115161439epcas3p1006f02c4e49f58c30c4aec1b0b11b0a7
References: <CGME20180115161439epcas3p1006f02c4e49f58c30c4aec1b0b11b0a7@epcas3p1.samsung.com>
        <20180115161431.803248-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, January 15, 2018 05:14:04 PM Arnd Bergmann wrote:
> Using a Kconfig 'select' statement for a user-visible symbol that other
> drivers depend on often causes circular dependencies. A new one showed
> up when I wanted to add an NVMEM dependency to the DRM_MSM driver:
> 
> drivers/i2c/Kconfig:7:error: recursive dependency detected!
> drivers/i2c/Kconfig:7:	symbol I2C is selected by FB_DDC
> drivers/video/fbdev/Kconfig:63:	symbol FB_DDC is selected by FB_CYBER2000_DDC
> drivers/video/fbdev/Kconfig:390:	symbol FB_CYBER2000_DDC depends on FB_CYBER2000
> drivers/video/fbdev/Kconfig:378:	symbol FB_CYBER2000 depends on FB
> drivers/video/fbdev/Kconfig:5:	symbol FB is selected by DRM_KMS_FB_HELPER
> drivers/gpu/drm/Kconfig:77:	symbol DRM_KMS_FB_HELPER depends on DRM_KMS_HELPER
> drivers/gpu/drm/Kconfig:71:	symbol DRM_KMS_HELPER is selected by DRM_MSM
> drivers/gpu/drm/msm/Kconfig:2:	symbol DRM_MSM depends on NVMEM
> drivers/nvmem/Kconfig:1:	symbol NVMEM is selected by EEPROM_AT24
> drivers/misc/eeprom/Kconfig:3:	symbol EEPROM_AT24 depends on I2C
> 
> Here, the problem is that many fbdev drivers have an i2c based interface
> and just 'select i2c' for that, while we also select the framebuffer
> subsystem indirectly from a DRM driver that now depends on i2c.
> 
> This does away with the 'select' statement and instead uses 'depends on',
> like almost all I2C users.

I worry that this change may cause various driver options to no longer
be visible to people configuring their kernels and not having I2C already
selected.

DRM somehow manages to select I2C and I would prefer to be it the same
way for fbdev (also looking at the current next tree there are still
some drivers that 'select I2C')..

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/video/fbdev/Kconfig | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 6962b4583fd7..892eb1863100 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -64,7 +64,6 @@ config FB_DDC
>         tristate
>         depends on FB
>         select I2C_ALGOBIT
> -       select I2C
>         default n
>  
>  config FB_BOOT_VESA_SUPPORT
> @@ -390,6 +389,7 @@ config FB_CYBER2000
>  config FB_CYBER2000_DDC
>  	bool "DDC for CyberPro support"
>  	depends on FB_CYBER2000
> +	depends on I2C=y || I2C=FB_CYBER2000
>  	select FB_DDC
>  	default y
>  	help
> @@ -634,7 +634,7 @@ config FB_BF537_LQ035
>  config FB_BFIN_7393
>  	tristate "Blackfin ADV7393 Video encoder"
>  	depends on FB && BLACKFIN
> -	select I2C
> +	depends on I2C
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> @@ -1026,6 +1026,7 @@ config FB_NVIDIA
>  config FB_NVIDIA_I2C
>         bool "Enable DDC Support"
>         depends on FB_NVIDIA
> +       depends on I2C=y || I2C=FB_NVIDIA
>         select FB_DDC
>         help
>  	  This enables I2C support for nVidia Chipsets.  This is used
> @@ -1073,6 +1074,7 @@ config FB_RIVA
>  config FB_RIVA_I2C
>         bool "Enable DDC Support"
>         depends on FB_RIVA
> +       depends on I2C=y || I2C=FB_RIVA
>         select FB_DDC
>         help
>  	  This enables I2C support for nVidia Chipsets.  This is used
> @@ -1102,6 +1104,7 @@ config FB_RIVA_BACKLIGHT
>  config FB_I740
>  	tristate "Intel740 support"
>  	depends on FB && PCI
> +	depends on I2C
>  	select FB_MODE_HELPERS
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
> @@ -1155,6 +1158,7 @@ config FB_I810_GTF
>  config FB_I810_I2C
>  	bool "Enable DDC Support"
>  	depends on FB_I810 && FB_I810_GTF
> +	depends on I2C=y || I2C=FB_I810
>  	select FB_DDC
>  	help
>  
> @@ -1206,6 +1210,7 @@ config FB_INTEL_DEBUG
>  config FB_INTEL_I2C
>  	bool "DDC/I2C for Intel framebuffer support"
>  	depends on FB_INTEL
> +	depends on I2C=y || I2C=FB_INTEL
>  	select FB_DDC
>  	default y
>  	help
> @@ -1285,6 +1290,7 @@ config FB_MATROX_G
>  config FB_MATROX_I2C
>  	tristate "Matrox I2C support"
>  	depends on FB_MATROX
> +	depends on I2C
>  	select FB_DDC
>  	---help---
>  	  This drivers creates I2C buses which are needed for accessing the
> @@ -1350,6 +1356,7 @@ config FB_RADEON
>  config FB_RADEON_I2C
>  	bool "DDC/I2C for ATI Radeon support"
>  	depends on FB_RADEON
> +	depends on I2C=y || I2C=FB_RADEON
>  	select FB_DDC
>  	default y
>  	help
> @@ -1460,6 +1467,7 @@ config FB_S3
>  config FB_S3_DDC
>  	bool "DDC for S3 support"
>  	depends on FB_S3
> +	depends on I2C=y || I2C=FB_S3
>  	select FB_DDC
>  	default y
>  	help
> @@ -1485,6 +1493,7 @@ config FB_SAVAGE
>  config FB_SAVAGE_I2C
>         bool "Enable DDC2 Support"
>         depends on FB_SAVAGE
> +       depends on I2C=y || I2C=FB_SAVAGE
>         select FB_DDC
>         help
>  	  This enables I2C support for S3 Savage Chipsets.  This is used
> @@ -1629,6 +1638,7 @@ config FB_3DFX_ACCEL
>  config FB_3DFX_I2C
>  	bool "Enable DDC/I2C support"
>  	depends on FB_3DFX
> +	depends on I2C=y || I2C=FB_3DFX
>  	select FB_DDC
>  	default y
>  	help
> @@ -1669,6 +1679,7 @@ config FB_VT8623
>  config FB_TRIDENT
>  	tristate "Trident/CyberXXX/CyberBlade support"
>  	depends on FB && PCI
> +	depends on I2C
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> @@ -2299,8 +2310,8 @@ endchoice
>  
>  config FB_MB862XX_I2C
>  	bool "Support I2C bus on MB862XX GDC"
> -	depends on FB_MB862XX && I2C
> -	depends on FB_MB862XX=m || I2C=y
> +	depends on FB_MB862XX
> +	depends on I2C=y || I2C=FB_MB862XX
>  	default y
>  	help
>  	  Selecting this option adds Coral-P(A)/Lime GDC I2C bus adapter

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
