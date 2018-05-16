Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752219AbeEPWrj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 18:47:39 -0400
Received: from ozlabs.org ([203.11.71.1]:53505 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751406AbeEPWri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 18:47:38 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 17 May 2018 08:47:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the mvebu tree with the arm-soc tree
Message-ID: <20180517084727.1d6772e1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zLIlbNt=53mPg0nMhHY1YBm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zLIlbNt=53mPg0nMhHY1YBm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mvebu tree got a conflict in:

  arch/arm/configs/multi_v7_defconfig

between various commits from the arm-soc tree and commit:

  873edb2930ef ("ARM: multi_v7_defconfig: Update with current configuration=
")

from the mvebu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/configs/multi_v7_defconfig
index 0c7abc87f01a,2b008248fb52..000000000000
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@@ -169,26 -153,14 +153,16 @@@ CONFIG_IPV6_MIP6=3D
  CONFIG_IPV6_TUNNEL=3Dm
  CONFIG_IPV6_MULTIPLE_TABLES=3Dy
  CONFIG_NET_DSA=3Dm
- CONFIG_NET_SWITCHDEV=3Dy
  CONFIG_CAN=3Dy
- CONFIG_CAN_RAW=3Dy
- CONFIG_CAN_BCM=3Dy
- CONFIG_CAN_DEV=3Dy
  CONFIG_CAN_AT91=3Dm
  CONFIG_CAN_FLEXCAN=3Dm
- CONFIG_CAN_RCAR=3Dm
+ CONFIG_CAN_SUN4I=3Dy
  CONFIG_CAN_XILINXCAN=3Dy
+ CONFIG_CAN_RCAR=3Dm
  CONFIG_CAN_MCP251X=3Dy
- CONFIG_NET_DSA_BCM_SF2=3Dm
- CONFIG_B53=3Dm
- CONFIG_B53_SPI_DRIVER=3Dm
- CONFIG_B53_MDIO_DRIVER=3Dm
- CONFIG_B53_MMAP_DRIVER=3Dm
- CONFIG_B53_SRAB_DRIVER=3Dm
- CONFIG_CAN_SUN4I=3Dy
  CONFIG_BT=3Dm
 +CONFIG_BT_HCIUART=3Dm
 +CONFIG_BT_HCIUART_BCM=3Dy
  CONFIG_BT_MRVL=3Dm
  CONFIG_BT_MRVL_SDIO=3Dm
  CONFIG_CFG80211=3Dm
@@@ -272,17 -247,15 +249,16 @@@ CONFIG_DWMAC_DWC_QOS_ETH=3D
  CONFIG_TI_CPSW=3Dy
  CONFIG_XILINX_EMACLITE=3Dy
  CONFIG_AT803X_PHY=3Dy
- CONFIG_MARVELL_PHY=3Dy
- CONFIG_SMSC_PHY=3Dy
  CONFIG_BROADCOM_PHY=3Dy
  CONFIG_ICPLUS_PHY=3Dy
- CONFIG_REALTEK_PHY=3Dy
+ CONFIG_MARVELL_PHY=3Dy
  CONFIG_MICREL_PHY=3Dy
- CONFIG_FIXED_PHY=3Dy
+ CONFIG_REALTEK_PHY=3Dy
  CONFIG_ROCKCHIP_PHY=3Dy
+ CONFIG_SMSC_PHY=3Dy
  CONFIG_USB_PEGASUS=3Dy
  CONFIG_USB_RTL8152=3Dm
 +CONFIG_USB_LAN78XX=3Dm
  CONFIG_USB_USBNET=3Dy
  CONFIG_USB_NET_SMSC75XX=3Dy
  CONFIG_USB_NET_SMSC95XX=3Dy
@@@ -363,13 -334,10 +337,11 @@@ CONFIG_SERIAL_ST_ASC=3D
  CONFIG_SERIAL_ST_ASC_CONSOLE=3Dy
  CONFIG_SERIAL_STM32=3Dy
  CONFIG_SERIAL_STM32_CONSOLE=3Dy
 +CONFIG_SERIAL_DEV_BUS=3Dy
- CONFIG_HVC_DRIVER=3Dy
  CONFIG_VIRTIO_CONSOLE=3Dy
+ CONFIG_HW_RANDOM=3Dy
+ CONFIG_HW_RANDOM_ST=3Dy
  CONFIG_I2C_CHARDEV=3Dy
- CONFIG_I2C_DAVINCI=3Dy
- CONFIG_I2C_MESON=3Dy
- CONFIG_I2C_MUX=3Dy
  CONFIG_I2C_ARB_GPIO_CHALLENGE=3Dm
  CONFIG_I2C_MUX_PCA954x=3Dy
  CONFIG_I2C_MUX_PINCTRL=3Dy
@@@ -381,8 -350,7 +354,8 @@@ CONFIG_I2C_DESIGNWARE_PLATFORM=3D
  CONFIG_I2C_DIGICOLOR=3Dm
  CONFIG_I2C_EMEV2=3Dm
  CONFIG_I2C_GPIO=3Dm
- CONFIG_I2C_EXYNOS5=3Dy
  CONFIG_I2C_IMX=3Dy
++CONFIG_I2C_MESON=3Dy
  CONFIG_I2C_MV64XXX=3Dy
  CONFIG_I2C_RIIC=3Dy
  CONFIG_I2C_RK3X=3Dy
@@@ -643,13 -602,17 +608,18 @@@ CONFIG_DRM_RCAR_LVDS=3D
  CONFIG_DRM_SUN4I=3Dm
  CONFIG_DRM_FSL_DCU=3Dm
  CONFIG_DRM_TEGRA=3Dy
+ CONFIG_DRM_PANEL_SIMPLE=3Dy
  CONFIG_DRM_PANEL_SAMSUNG_LD9040=3Dm
 +CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=3Dm
  CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=3Dm
- CONFIG_DRM_PANEL_SIMPLE=3Dy
+ CONFIG_DRM_DUMB_VGA_DAC=3Dm
+ CONFIG_DRM_NXP_PTN3460=3Dm
+ CONFIG_DRM_PARADE_PS8622=3Dm
  CONFIG_DRM_SII9234=3Dm
+ CONFIG_DRM_I2C_ADV7511=3Dm
+ CONFIG_DRM_I2C_ADV7511_AUDIO=3Dy
  CONFIG_DRM_STI=3Dm
- CONFIG_DRM_VC4=3Dy
+ CONFIG_DRM_VC4=3Dm
  CONFIG_DRM_ETNAVIV=3Dm
  CONFIG_DRM_MXSFB=3Dm
  CONFIG_FB_ARMCLCD=3Dy
@@@ -953,8 -901,9 +908,10 @@@ CONFIG_PWM=3D
  CONFIG_PWM_ATMEL=3Dm
  CONFIG_PWM_ATMEL_HLCDC_PWM=3Dm
  CONFIG_PWM_ATMEL_TCB=3Dm
+ CONFIG_PWM_BCM2835=3Dy
+ CONFIG_PWM_BRCMSTB=3Dm
  CONFIG_PWM_FSL_FTM=3Dm
 +CONFIG_PWM_MESON=3Dm
  CONFIG_PWM_RCAR=3Dm
  CONFIG_PWM_RENESAS_TPU=3Dy
  CONFIG_PWM_ROCKCHIP=3Dm
@@@ -962,31 -912,25 +920,26 @@@ CONFIG_PWM_STI=3D
  CONFIG_PWM_SUN4I=3Dy
  CONFIG_PWM_TEGRA=3Dy
  CONFIG_PWM_VT8500=3Dy
+ CONFIG_KEYSTONE_IRQ=3Dy
++CONFIG_PHY_STM32_USBPHYC=3Dy
+ CONFIG_PHY_SUN4I_USB=3Dy
+ CONFIG_PHY_SUN9I_USB=3Dy
  CONFIG_PHY_HIX5HD2_SATA=3Dy
- CONFIG_E1000E=3Dy
- CONFIG_PWM_STI=3Dy
- CONFIG_PWM_BCM2835=3Dy
- CONFIG_PWM_BRCMSTB=3Dm
- CONFIG_PHY_DM816X_USB=3Dm
- CONFIG_OMAP_USB2=3Dy
- CONFIG_TI_PIPE3=3Dy
- CONFIG_TWL4030_USB=3Dm
+ CONFIG_PHY_BERLIN_SATA=3Dy
  CONFIG_PHY_BERLIN_USB=3Dy
  CONFIG_PHY_CPCAP_USB=3Dm
- CONFIG_PHY_BERLIN_SATA=3Dy
+ CONFIG_PHY_QCOM_APQ8064_SATA=3Dm
+ CONFIG_PHY_RCAR_GEN2=3Dm
  CONFIG_PHY_ROCKCHIP_DP=3Dm
  CONFIG_PHY_ROCKCHIP_USB=3Dy
- CONFIG_PHY_QCOM_APQ8064_SATA=3Dm
+ CONFIG_PHY_SAMSUNG_USB2=3Dm
  CONFIG_PHY_MIPHY28LP=3Dy
- CONFIG_PHY_RCAR_GEN2=3Dm
  CONFIG_PHY_STIH407_USB=3Dy
- CONFIG_PHY_STM32_USBPHYC=3Dy
- CONFIG_PHY_SUN4I_USB=3Dy
- CONFIG_PHY_SUN9I_USB=3Dy
- CONFIG_PHY_SAMSUNG_USB2=3Dm
  CONFIG_PHY_TEGRA_XUSB=3Dy
- CONFIG_PHY_BRCM_SATA=3Dy
- CONFIG_NVMEM=3Dy
+ CONFIG_PHY_DM816X_USB=3Dm
+ CONFIG_OMAP_USB2=3Dy
+ CONFIG_TI_PIPE3=3Dy
+ CONFIG_TWL4030_USB=3Dm
  CONFIG_NVMEM_IMX_OCOTP=3Dy
  CONFIG_NVMEM_SUNXI_SID=3Dy
  CONFIG_NVMEM_VF610_OCOTP=3Dy

--Sig_/zLIlbNt=53mPg0nMhHY1YBm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr8tQAACgkQAVBC80lX
0GzHtAgAiGFH87nNHHkjWZhjLYWabNG9Dy7DYzVxWl285CxZzIRAwG1HKe6XZkJg
tuWYVk2Xm8izQ9H9HfEDalQov5b4uXjff3qLynRjYbsjZ1Mm3yOqqaKEDzVe/7Tw
qjzLM8eXFluNwTUIUAy4sfKpaTtGfktFrtgxoXLlzGk9a/uKDlJ4sqHk+bA3mApF
/FzHBqtiFhIsdyPHeYt/5zX9xgS699DChVUtFvazR6ef+nqcwt/0KEL7PbCIYvkm
4Sry1fk6gZCaLNcaZAzP/9GRO0iQLKI9iDG9+1/sRAuRLaiim3RvCPqt38l6Tvy1
23vbx/2W/j45E+h4/Px4XuT3svKsFA==
=p1zQ
-----END PGP SIGNATURE-----

--Sig_/zLIlbNt=53mPg0nMhHY1YBm--
