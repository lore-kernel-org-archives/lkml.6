Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B5BC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E882082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhjvtIBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E882082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbeJ2Xcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:32:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbeJ2Xcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:32:52 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97EAE2082D;
        Mon, 29 Oct 2018 14:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540824233;
        bh=poxfUKiKlbD4T23DRgd1F0awvWLJr8U8lHJvE6Mg5Cc=;
        h=Date:From:To:Cc:Subject:From;
        b=RhjvtIBFe3MwI8Gs/KzaVP7vzou2ZDEQzRxPhUHtflUrxkpbwy5LC+mtmkQXcXcMD
         HuEbxOqld0jbxUgEps4zsWZP8UVCOcr7oOKtPTU2yqLCPz9ZjYtSPL4eN5CgCa22L+
         LBwhcL+Aingt5Ar121XFseMWs2JCe28nsZvDlSbQ=
Date:   Mon, 29 Oct 2018 15:43:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Subject: [GIT PULL] Staging/IIO driver patches for 4.20-rc1
Message-ID: <20181029144358.GA2018@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:

  Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-4.20-rc1

for you to fetch changes up to 4ab7e05dd070600833680bd318d6d962f010caa2:

  staging: gasket: Fix sparse "incorrect type in assignment" warnings. (2018-10-19 21:12:29 +0200)

----------------------------------------------------------------
Staging/IIO patches for 4.20-rc1

Here is the big staging and IIO driver pull request for 4.20-rc1.

There are lots of things here, we ended up adding more lines than
removing, thanks to a large influx of Comedi National Instrument device
support.  Someday soon we need to get comedi out of staging...

Other than the comedi drivers, the "big" things here are:
  - new iio drivers
  - delete dgnc driver (no one used it and no one had the hardware
    anymore)
  - vbox driver updates and fixes
  - erofs fixes
  - tons and tons of tiny checkpatch fixes for almost all staging
    drivers

All of these have been in linux-next, with the last few happening a bit
"late" due to them getting stuck on my laptop during travel to the
Mantainers summit.

When merging with your tree, there will be 2 merge conflicts, both files
will be simple to resolve, just delete them :)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ajay Singh (55):
      staging: wilc1000: move 'wilc_enable_ps' global variable into 'wilc' struct
      staging: wilc1000: move 'aging_timer' static variable to wilc_priv struct
      staging: wilc1000: fix to use correct index to free scanned info in clear_shadow_scan()
      staging: wilc1000: remove unnecessary NULL check in clear_shadow_scan()
      staging: wilc1000: moved last_scanned_shadow & last_scanned_cnt to wilc_priv struct
      staging: wilc1000: move during_ip_timer & wilc_optaining_ip to 'wilc_vif' struct
      staging: wilc1000: remove unused variable 'op_ifcs'
      staging: wilc1000: avoid use of extra 'if' condition in wilc_init()
      staging: wilc1000: move static variable clients_count to 'wilc' structure
      staging: wilc1000: refactor code to avoid use of wilc_set_multicast_list global
      staging: wilc1000: move hif_workqueue static variables to 'wilc' structure
      staging: wilc1000: move 'periodic_rssi' as part of 'wilc_vif' struct
      staging: wilc1000: rename 'dummy_statistics' variable to 'periodic_stat'
      staging: wilc1000: move 'rcv_assoc_resp' as part of hif_drv
      staging: wilc1000: refactor tcp_process() to avoid extra leading tabs
      staging: wilc1000: use lowercase for get_BSSID() and HIL variable
      staging: wilc1000: move tcp_ack_filter algo related variables to 'wilc_vif' struct
      staging: wilc1000: avoid line over 80 chars in wilc_wlan_txq_filter_dup_tcp_ack()
      staging: wilc1000: use short names to fix over 80 issue in tcp_process()
      staging: wilc1000: remove unused code to set and get IP address
      staging: wilc1000: move 'chip_ps_state' static variable as part of 'wilc' struct
      staging: wilc1000: move 'wilc_connecting' static variable to 'wilc_vif' struct
      staging: wilc1000: remove unnecessary static variable 'p2p_listen_state'
      staging: wilc1000: refactor code to move initilization in wilc_netdev_init()
      staging: wilc1000: refactor wilc_netdev_init() to handle memory free in error path
      staging: wilc1000: remove handle_hif_exit_work() function
      staging: wilc1000: change return type to 'void' for wilc_frame_register()
      staging: wilc1000: change return type to 'void' for wilc_wlan_set_bssid()
      staging: wilc1000: change return type to 'void' for lock init & deinit functions
      staging: wilc1000: change return type to 'void' for wilc_deinit_host_int()
      staging: wilc1000: change return type to 'void' for wilc_wfi_deinit_mon_interface()
      staging: wilc1000: use 'void' return type for host_int_get_assoc_res_info()
      staging: wilc1000: use 'void' return for wilc_wlan_txq_add_to_head()
      staging: wilc1000: change return type to 'void' tcp ack filter functions
      staging: wilc1000: use 'void' return for wilc_wlan_txq_filter_dup_tcp_ack()
      staging: wilc1000: change return type to 'void' for wilc_wlan_cfg_indicate_rx()
      staging: wilc1000: refactor wilc_wlan_parse_info_frame() function
      staging: wilc1000: set default value of cfg response type in wilc_wlan_cfg_indicate_rx()
      staging: wilc1000: changes 'val' type to u8 in wilc_cfg_byte struct
      staging: wilc1000: remove unused wid type values
      staging: wilc1000: remove unused wid from cfg struct
      staging: wilc1000: refactor code to remove 'mac_status' from 'wilc_mac_cfg' struct
      staging: wilc1000: refactor code to avoid static variables for config parameters
      staging: wilc1000: rename 'wilc_mac_cfg' struct to 'wilc_cfg_str_vals'
      staging: wilc1000: avoid the use of 'hif_driver_comp' completion variable
      staging: wilc1000: remove use of unnecessary 'wilc_connected_ssid' variable
      staging: wilc1000: avoid use of 'g_sdio' static variable
      staging: wilc1000: avoid use of 'g_spi' static variable
      staging: wilc1000: remove unnecessary memset in sdio_init() & wilc_spi_init()
      staging: wilc1000: remove p2p related static variables to wilc_vif struct
      staging: wilc1000: remove wilc_debugfs.c file as its not used
      staging: wilc1000: remove unnecessary option used with ccflags-y in Makefile
      staging: wilc1000: use usleep_range() in place of udelay()
      staging: wilc1000: refactor wilc_set_multicast_list() function
      staging: wilc1000: return exact error of register_netdev() from wilc_netdev_init()

Alexandru Ardelean (5):
      iio: adxl345: move null check for i2c id at start of probe
      staging:iio:ad7606: fix voltage scales
      staging:iio:ad7606: Remove incorrect kernel doc annotations
      staging:iio:ad7606: update structs with doc annotations
      staging:iio:ad7606: Add support for the ad7605-4

Alexey Khoroshilov (2):
      iio: adc: imx25-gcq: Fix leak of device_node in mx25_gcq_setup_cfgs()
      staging: axis-fifo: add error handling of class_create()

Alexey Skidanov (1):
      staging: android: ion: Clean unused debug_show memeber of the heap object

André Lehmann (2):
      Staging: rtl8712: Add space between else and opening brace
      staging: rtl8712: replace licence header with SPDX licence id

Arkadiusz Lis (2):
      Staging: One Laptop Per Child: fix SPDX-License-Identifier issue
      staging: emxx_udc: remove unnecessary nullpointer checks

Aymen Qader (13):
      staging: vc04_services: Fix "space prohibited"
      staging: vc04_services: Use tabs instead of spaces
      staging: vc04_services: Remove unused macros
      staging: vc04_services: Remove spaces after '*'
      staging: sm750fb: Fix typo frambuffer->framebuffer
      staging: bcm2835-camera: Update TODO
      staging: bcm2835-camera: Remove unused header
      staging: rts5208: Remove unnecessary braces {}
      staging: rtl8188eu: Skip unnecessary field checks
      staging: rtl8723bs: Skip unnecessary field checks
      staging: rtlwifi: Return -ENOMEM instead of -1
      staging: sm750fb: Remove extra space character
      staging: ks7010: Remove unnecessary null check

Baolin Wang (2):
      iio: adc: sc27xx: Add raw data support
      iio: adc: sc27xx: Add ADC scale calibration

Bhanusree Pola (1):
      staging: mt7621-dma: Delete unused define

Bhaskar Singh (5):
      staging: rtl8188eu: Removed unnecessary parentheses
      staging: rtl8188eu: Fix spelling mistake
      staging: rtl8188eu: Removed code valid for 5GHz
      staging: rtl8188eu: Removed a function and coded inline
      staging: rtl8188eu: Removed unneeded variable

Brian Masney (6):
      iio: imu: mpu6050: add support for regulator framework
      dt-bindings: iio: tsl2772: add new bindings
      iio: tsl2772: add support for reading proximity led settings from device tree
      dt-bindings: iio: tsl2772: add binding for avago,apds9930
      iio: tsl2772: add support for avago,apds9930
      iio: tsl2772: add support for regulator framework

Chao Yu (1):
      staging: erofs: fix potential overflow in erofs_grab_bio()

Chen Gong (2):
      staging: erofs: add trace points for reading zipped data
      staging: erofs: replace BUG_ON with DBG_BUGON in data.c

Chengguang Xu (5):
      staging: erofs: surround fault_injection ralted option parsing using CONFIG_EROFS_FAULT_INJECTION
      staging: erofs: code cleanup for erofs_kmalloc()
      staging: erofs: code cleanup for option parsing of fault_injection
      staging: erofs: code cleanup for erofs_show_options()
      staging: erofs: option validation in remount

Christian Gromm (4):
      staging: most: register channel device after init of struct members
      staging: most: do not make interface dependent attrs default for all channels
      staging: most: fix label names
      staging: most: usb: add release function for DCI device

Colin Ian King (20):
      iio: chemical: fix spelling mistake "failted" -> "failed"
      iio: max44000: remove unused variable max44000_alstim_shift
      staging: gasket: apex: remove unused array cm_mappable_regions
      staging: rtl8712: remove unused array iw_operation_mode
      staging: fsl-dpaa2/ethsw: remove redundant pointer 'port_priv'
      staging: most: net: make array 'broadcast' static, shrinks object size
      staging: most: video: fix registration of an empty comp core_component
      staging: rtl8723bs: check for i out of range before accessing szLine[i]
      staging: wilc1000: fix null checks on wilc
      staging: greybus: fix spelling mistake "entires" -> "entries"
      staging: rtl8188eu, rtl8723bs: fix spelling mistake "evet" -> "event"
      staging: rtl8723bs: fix spelling mistake "unvalid" -> "invalid"
      staging: rtl8723bs: fix spelling mistake "toogle" -> "toggle"
      staging: rtl8188eu: fix spelling mistake "transfoer_len" -> "transfer_len"
      staging: wilc1000: fix incorrect allocation size for structure
      staging: rtl8723bs: clean up clang warning on extraneous parentheses
      staging: rtl8723bs: fix spelling mistake "Abnrormal" -> "Abnormal"
      staging: rtl8188eu: fix spelling mistake "Abnornally" -> "Abnormally"
      staging: rtlwifi: phydm: fix spelling mistake "Abnrormal" -> "Abnormal"
      staging: rtl8188eu: fix spelling mistake "EINPROGESS" -> "EINPROGRESS"

Craig Kewley (1):
      staging: vboxvideo: make a couple of funcs static

Dafna Hirschfeld (4):
      staging: mt7621-mmc: remove unnecessary braces from 'if' statements
      staging: mt7621-mmc: Fix comparison to NULL
      staging: mt7621-mmc: replace `printk` with preferred API
      staging: rtl8712: Remove unnecessary parentheses

Dan Carpenter (2):
      staging: pi433: eliminate a temporary variable
      staging: vboxvideo: unlock on error in vbox_cursor_atomic_update()

David Frey (8):
      iio: chemical: bme680: use clamp macro
      iio: chemical: bme680: cleanup bme680_read_calib formatting
      iio: chemical: bme680: indent #defines consistently
      iio: chemical: bme680: change MSK->MASK in #defines
      iio: chemical: bme680: use GENMASK macro
      iio: chemical: bme680: use FIELD_GET macro
      iio: chemical: bme680: simplify oversampling handling
      iio: chemical: bme680: Remove field value defines

David Lechner (3):
      spi: add new SPI_CS_WORD flag
      spi: add software implementation for SPI_CS_WORD
      iio: adc: ti-ads7950: use SPI_CS_WORD to reduce CPU usage

Deepa Dinamani (1):
      MAINTAINERS: removed staging/ft1000 driver

Eugen Hristev (3):
      iio: fix position relative kernel version
      iio: adc: at91: fix acking DRDY irq on simple conversions
      iio: adc: at91: fix wrong channel number in triggered buffer mode

Gao Xiang (24):
      staging: erofs: introduce erofs_grab_bio
      staging: erofs: separate erofs_get_meta_page
      staging: erofs: add error handling for xattr submodule
      staging: erofs: cleanup z_erofs_vle_work_{lookup, register}
      staging: erofs: rearrange vle clustertype definitions
      staging: erofs: fix vle_decompressed_index_clusterofs
      staging: erofs: fix integer overflow on 32-bit platform
      staging: erofs: fix compression mapping beyond EOF
      staging: erofs: fix potential overflow in z_erofs_vle_normalaccess_readpage{,s}
      Revert "staging: erofs: disable compiling temporarile"
      staging: erofs: fix a missing endian conversion
      staging: erofs: clean up z_erofs_map_blocks_iter
      staging: erofs: complete error handing of z_erofs_map_blocks_iter
      staging: erofs: fix a bug when appling cache strategy
      staging: erofs: complete error handing of z_erofs_do_read_page
      staging: erofs: avoid magic constants when initializing clusterbits
      staging: erofs: remove redundant CONFIG_EROFS_FS_XATTRs
      staging: erofs: fold in `__update_workgrp_llen'
      staging: erofs: drop multiref support temporarily
      staging: erofs: cleanup `z_erofs_vle_normalaccess_readpages'
      staging: erofs: add some comments for xattr subsystem
      staging: erofs: simplify return value of `xattr_foreach'
      staging: erofs: add the missing __init tags
      staging: erofs: harden inode lookup for 32-bit platforms

Geert Uytterhoeven (1):
      iio: light: isl29501: Simplify code to kill compiler warning

Georgios Tsotsos (1):
      Staging: octeon-usb: Replaces CVMX_WAIT_FOR_FIELD32 macro with a function

Greg Kroah-Hartman (6):
      Merge tag 'iio-for-4.20a' of git://git.kernel.org/.../jic23/iio into staging-next
      Merge 4.19-rc4 into staging-next
      Merge tag 'iio-for-4.20b' of git://git.kernel.org/.../jic23/iio into staging-next
      staging: dgnc: delete the driver
      staging: MAINTAINERS: remove NCP filesystem entry
      staging: MAINTAINERS: remove obsolete IPX staging directory

Gustavo A. R. Silva (2):
      iio: health: max30102: Mark expected switch fall-throughs
      staging: comedi: tio: fix multiple missing break in switch bugs

Hans de Goede (31):
      staging: vboxvideo: Fix modeset / page_flip error handling
      staging: vboxvideo: Skip currrent crtc when updating crtcs
      staging: vboxvideo: Remove vboxfb_create_object() wrapper
      staging: vboxvideo: Drop vbox_bo_unref() helper
      staging: vboxvideo: Let DRM core handle connector registering
      staging: vboxvideo: Move setup of modesetting from driver_load to mode_init
      staging: vboxvideo: Fold driver_load/unload into probe/remove functions
      staging: vboxvideo: Embed drm_device into driver structure
      staging: vboxvideo: Fold vbox_drm_resume() into vbox_pm_resume()
      staging: vboxvideo: Add fl_flag argument to vbox_fb_pin() helper
      staging: vboxvideo: Expose creation of universal primary plane
      staging: vboxvideo: Init fb_info.fix.smem once from fbdev_create
      staging: vboxvideo: Move pin / unpin of fb out of vbox_crtc_set_base_and_mode
      staging: vboxvideo: Fix NULL ptr deref in vbox_set_up_input_mapping()
      staging: vboxvideo: Move bo_[un]resere calls into vbox_bo_[un]pin
      staging: vboxvideo: Add vbox_bo_k[un]map helper functions
      staging: vboxvideo: Cleanup vbox_set_up_input_mapping()
      staging: vboxvideo: Remove empty encoder_helper_funcs
      staging: vboxvideo: Temporarily remove page_flip support
      staging: vboxvideo: Cache mode width, height and crtc panning in vbox_crtc
      staging: vboxvideo: Atomic phase 1: convert cursor to universal plane
      staging: vboxvideo: Atomic phase 1: Use drm_plane_helpers for primary plane
      staging: vboxvideo: Atomic phase 2: Wire up state object handlers
      staging: vboxvideo: Atomic phase 2: Stop using plane->fb and crtc->*
      staging: vboxvideo: Atomic phase 3: Switch last bits over to atomic
      staging: vboxvideo: Restore page-flip support
      staging: vboxvideo: Fix DPMS support after atomic conversion
      staging: vboxvideo: Replace crtc_helper enable/disable functions
      staging: vboxvideo: Call drm_atomic_helper_check_plane_state from atomic_check
      staging: vboxvideo: Drop unnecessary drm_connector_helper_funcs callbacks
      staging: vboxvideo: Use more drm_fb_helper functions

Himanshu Jha (1):
      iio: chemical: bme680: Add check for val2 in the write_raw function

Igor Stoppa (1):
      staging: octeon-hcd: remove unnecessary unlikely()

Ioana Radulescu (1):
      staging: fsl-dpaa2/ethsw: Fix uninitialized variables

Ioannis Valasakis (3):
      staging: axis-fifo: Remove parentheses in axis-fifo.c
      staging: clocking-wizard: match parenthesis indentation
      staging: wilc1000: prefer 'help' in KConfig

Jaakko Tyynismaa (1):
      staging: mt7621-mmc: Add blank line after declaration

Jia-Ju Bai (5):
      staging: rtl8188eu: Fix two sleep-in-atomic-context bugs in rtw_chk_hi_queue_cmd()
      staging: rtl8188eu: Fix a sleep-in-atomic-context bug in issue_deauth_ex()
      staging: dgnc: Fix a sleep-in-atomic-context bug in cls_assert_modem_signals()
      staging: rtl8723bs: Fix a sleep-in-atomic-context bug in issue_deauth_ex()
      staging: rtl8723bs: Fix two sleep-in-atomic-context bugs in _rtw_pwr_wakeup()

John Whitmore (101):
      staging:rtl8192u: Remove macro eqMacAddr - Style
      staging:rtl8192u: Remove macro cpMacAddr - Style
      staging:rtl8192u: Replace magic number 6 with ETH_ALEN - Style
      staging:rtl8192u: Rename macro parameter __pIeeeDev - Style
      staging:rtl8192u: Rename __pTa - Style
      staging:rtl8192u: Lines should not end with a '(' - Style
      staging:rtl8192u: Rename Dot11d_Init - Style
      staging:rtl8192u: Rename Dot11d_Reset - Style
      staging:rtl8192u: Rename Dot11d_UpdateCountryIe - Style
      staging:rtl8192u: Rename dot11d_update_country_ie() parameters - Style
      staging:rtl8192u: Rename DOT11D_GetMaxTxPwrInDbm - Style
      staging:rtl8192u: Rename Channel - Style
      staging:rtl8192u: Rename DOT11D_ScanComplete - Style
      staging:rtl8192u: Rename IsLegalChannel - Style
      staging:rtl8192u: Rename ToLegalChannel - Style
      staging:rtl8192u: Replace magic number with defined constant - Style
      staging:rtl8192u: Rename sHTCLng - Style
      staging:rtl8192u: Remove unnecessary blank lines - Style
      staging:rtl8192u: Add required spaces - Style
      staging:rtl8192u: Remove unused constants - Style
      staging:rtl8192u: Correct block comments - Style
      staging:rtl8192u: Remove unused CHHLOP_IN_PROGRESS - Style
      staging:rtl8192u: Removed commented out structure - Style
      staging:rtl8192u: Remove enum CHNLOP - Style
      staging:rtl8192u: Refactor struct HT_CAPABILITY_ELE - Style
      staging:rtl8192u: Remove unused defines - Style
      staging:rtl8192u: Refactor SEQUENCE_CONTROL - Style
      staging:rtl8192u: Rename ShortData - Style
      staging:rtl8192u: Rename member variables - Style
      staging:rtl8192u: Refactor BA_PARAM_SET - Style
      staging:rtl8192u: Remove charData and rename shortData - Style
      staging:rtl8192u: Rename ba_param_set members - Style
      staging:rtl8192u: Refactor DELBA_PARAM_SET - Style
      staging:rtl8192u: Refactor union delba_param_set - Style
      staging:rtl8192u: Refactor struct BA_RECORD - Style
      staging:rtl8192u: Rename member variable Timer - Style
      staging:rtl8192u: Rename bValid - Style
      staging:rtl8192u: Rename DialogToken - Style
      staging:rtl8192u: Rename BaParamSet - Style
      staging:rtl8192u: Rename BaTimeoutValue - Style
      staging:rtl8192u: Rename BaStartSeqCtrl - Style
      staging:rtl8192u: Remove commented out code and indent - Style
      staging:rtl8192u: Refactor enum VERSION_819xU - Style
      staging:rtl8192u: Refactor RT_RF_TYPE_DEF - Style
      staging:rtl8192u: Make function rtl8192_phyConfigBB static
      staging:rtl8192u: Refactor BaseBand_Config_Type - Style
      staging:rtl8192u: Remove unused definitions - Style
      staging:rtl8192u: Reorder enum _RTL8192Usb_HW members - Style
      staging:rtl8192u: Rename EEPROM_TxPowerDiff - Style
      staging:rtl8192u: Rename EEPROM_ThermalMeter - Style
      staging:rtl8192u: Rename EEPROM_PwDiff - Style
      staging:rtl8192u: Rename EEPROM_CrystalCap - Style
      staging:rtl8192u: Rename EEPROM_TxPwIndex_CCK - Style
      staging:rtl8192u: Rename EEPROM_TxPwIndex_OFDM_24G_V1 - STYLE
      staging:rtl8192u: Rename EEPROM_TxPwIndex_OFDM_24G - Style
      staging:rtl8192u: Rename EEPROM_TxPwIndex_CCK_V1 - Style
      staging:rtl8192u: rename EEPROM_TxPwIndex_Ver - Style
      staging:rtl8192u: Rename EEPROM_Default_ThermalMeter - Style
      staging:rtl8192u: Rename EEPROM_Default_PwDiff - Style
      staging:rtl8192u: Rename EEPROM_Default_CrystalCap - Style
      staging:rtl8192u: Rename EEPROM_Default_TxPower - Style
      staging:rtl8192u: Rename EEPROM_Customer_ID - Style
      staging:rtl8192u: Rename EEPROM_ChannelPlan - Style
      staging:rtl8192u: Rename PHY_SetRF8256Bandwidth() - Style
      staging:rtl8192u: Rename function PHY_RF8256_Config() - Style
      staging:rtl8192u: Refactor phy_RF8256_Config_ParaFile() - Style
      staging:rtl8192u: Rename PHY_SetRF8256CCKTxPower() - Style
      staging:rtl8192u: Rename PHY_SetRF8256OFDMTxPower() - Style
      staging:rtl8192u: Add SPDX-License-Identifier tag - Style
      staging:rtl8192u: Rename dot11d_init to fix name clash
      staging:rtl8192u: Remove unused definitions - Style
      staging:rtl8192u: Add required SPDX-License-Identifier - Style
      staging:rtl8192u: Refactor member variable enabled - Style
      staging:rtl8192u: Rename member pDot11dInfo - Style
      staging:rtl8192u: Remove write_cam() - Style
      staging:rtl8192u: Remove read_cam() - Style
      staging:rtl8192u: Remove unused functions - Style
      staging:rtl8192u: Add SPDX-License-Identifier - Style
      staging:rtl8192u: Rename RTL819xU_MODULE_NAME - Style
      staging:rtl8192u: Rename Rx_Smooth_Factor - Style
      staging:rtl8192u: Refactor RT_TRACE - Style
      staging:rtl8192u: Fix space characters - Style
      staging:rtl8192u: Remove unused RTL8190_CPU_START_OFFSET - Style
      staging:rtl8192u: Refactor GET_COMMAND_PACKET_FRAG_THRESHOLD - Style
      staging:rtl8192u: Remove typedef from firmware_init_step_e - Style
      staging:rtl8192u: Remove typedef from enum opt_rst_type_e - Style
      staging:rtl8192u: Remove HTHalfMcsToDataRate() - Style
      staging:rtl8192u: Make HTMcsToDataRate static - Style
      staging:rtl8192u: Remove definition of HTSetConnectBwMode - Style
      staging:rtl8192u: Move HTSetConnectBwModeCallback() - Style
      staging:rtl8192u: Remove potential memory leak
      staging:rtl8192u: Add missing SPDX-License-Identifier - Style
      staging:rtl8192u: Removed commented out include - Style
      staging:rtl8192u: Clear error with line ending ( - Style
      staging:rtl8192u: Remove extra blank lines - Style
      staging:rtl8192u: Add spaces around + operator - Style
      staging:rtl8192u: Correct code indentation - Style
      staging:rtl8192u: Add missing blank lines - Style
      staging:rtl8192u: Remove unnecessary line continuation - Style
      staging:rtl8192u: Correct code alignment - Style
      staging:rtl8192u: Correct comparison with NULL - Style

Jonathan Cameron (2):
      Merge tag 'regmap-noinc-read' into togreg
      Merge tag 'spi-cs-word' into togreg

Julia Lawall (1):
      iio: potentiometer: merge calls to of_match_device and of_device_get_match_data

Karthik Nishanth (1):
      Staging: rtlwifi: remove unnecessary NULL check

Kimberly Brown (1):
      staging: media: davinci_vpfe: Fix spelling mistake in enum

Larry Finger (2):
      staging: rtl8192e: Fix compiler warning from strncpy()
      staging: rtl8712u: Fix compiler warning about strncpy

Lars-Peter Clausen (1):
      iio: ad5064: Fix regulator handling

Laurence Rochfort (1):
      staging: gasket: Fix sparse "incorrect type in assignment" warnings.

Leon Imhof (1):
      staging: erofs: change 'unsigned' to 'unsigned int'

Leonardo Brás (1):
      staging: fbtft: Adds space around "/"

Lorenzo Bianconi (5):
      iio: imu: st_lsm6dsx: add read_fifo callback to fifo_ops
      iio: imu: st_lsm6dsx: make st_lsm6dsx_check_odr() non-static
      iio: imu: st_lsm6dsx: add addr/max_word_len to st_lsm6dsx_read_block()
      iio: imu: st_lsm6dsx: add support to LSM6DSO
      dt-bindings: iio: imu: st_lsm6dsx: add LSM6DSO device bindings

Lubomir Rintel (1):
      staging: olpc_dcon: add a missing dependency

Mamta Shukla (16):
      staging: fbtft: Prefer using the BIT macro
      staging: sm750fb: Remove space after cast
      staging: rtl8723bs: core: Remove true and false comparison
      staging: mt7621-pci: Do not initialise statics to 0
      staging: mt7621-pci: Add spaces around '&'
      staging: mt7621-pci: Add spaces around '|'
      staging: mt7621-pci: Add spaces around '<<'
      staging: mt7621-pci: Prefer using the BIT macro
      staging: vt6655: Add blank line after function/struct/union/enum declarations
      staging: vt6655: Add spaces around operators
      staging: vt6655: Remove space after cast
      staging: media: davinci_vpfe: Use __func__ instead of function name
      staging: rtl8723bs: os_dep: Remove true and false comparison
      staging: rtl8723bs: os_dep: Remove space after cast
      staging: rtl8723bs: os_dep: Shift * to be adjacent to pointer name
      staging: rtl8188eu: core: Use sizeof(*p) instead of sizeof(struct P) for memory allocation

Marcus Folkesson (11):
      iio: dac: max517: avoid using CONFIG_PM_SLEEP
      iio: dac: max5821: avoid using CONFIG_PM_SLEEP
      iio: dac: mcp4725: avoid using CONFIG_PM_SLEEP
      iio: adc: add support for mcp3911
      dt-bindings: iio: adc: add bindings for mcp3911
      MAINTAINERS: Add entry for mcp3911 ADC driver
      iio: dac: add support for ltc1660
      dt-bindings: iio: dac: add bindings for ltc1660
      MAINTAINERS: add entry for ltc1660 DAC driver
      iio: dac: mcp4922: fix error handling in mcp4922_write_raw
      iio: dac: ti-dac5571: provide of_match_table to driver

Martin Blumenstingl (5):
      iio: adc: meson-saradc: remove #define MESON_SAR_ADC_DELTA_10_TS_C_SHIFT
      iio: adc: meson-saradc: use of_device_get_match_data
      iio: adc: meson-saradc: simplify access to meson_sar_adc_param
      iio: adc: meson-saradc: do not use meson_sar_adc_iio_channels directly
      iio: adc: meson-saradc: use the address attribute from iio_chan_spec

Matthias Kaehlcke (3):
      iio: adc: qcom-spmi-adc5: Add ADC5_AMUX_THM[24]_100K_PU to rev2 channel list
      iio: adc: qcom-spmi-adc5: Verify channel numbers from DT
      dt-bindings: iio: vadc: Fix documentation of 'reg'

Maya Nakamura (4):
      staging: wlan-ng: Replace long int with long
      staging: speakup: Add a pair of braces
      staging: gasket: Remove extra blank line
      staging: ks7010: Remove extra blank line

Michael Hennerich (1):
      drivers: iio: Update MODULE AUTHOR email address

Michael Straube (84):
      staging: rtl8188eu: use is_multicast_ether_addr in rtw_security.c
      staging: rtl8188eu: use is_multicast_ether_addr in rtw_recv.c
      staging: rtl8188eu: use is_multicast_ether_addr in rtw_xmit.c
      staging: rtl8188eu: remove unused IS_MCAST
      staging: rtl8188eu: use phydm_reg.h from rtlwifi
      staging: rtl8188eu: simplify function comment
      staging: rtl8188eu: remove pointless comment
      staging: rtl8188eu: Remove code valid only for 5 GHz
      staging: rtl8188eu: fix comparsions to true
      staging: rtl8188eu: remove whitespace
      staging: rtl8188eu: remove unnecessary parentheses
      staging: rtl8188eu: refactor SwLedControlMode1()
      staging: rtl8188eu: remove unnecessary parentheses in rtw_led.c
      staging: rtl8188eu: fix lines over 80 characters in rtw_led.c
      staging: rtl8188eu: change array type to u8
      staging: rtl8188eu: simplify calculation
      staging: rtl8188eu: remove unnecessary parentheses
      staging: rtl8188eu: remove whitespace
      staging: rtl8188eu: fix comparsions to true
      staging: rtl8188eu: fix comparsions to false
      staging: rtl8188eu: add missing spaces around operators
      staging: rtl8188eu: fix lines over 80 characters
      staging: rtl8188eu: simplify function comments
      staging: rtl8188eu: remove 5 GHz code from Hal_GetChnlGroup88E()
      staging: rtl8188eu: change return type of Hal_GetChnlGroup88E()
      staging: rtl8188eu: rename parameter of Hal_GetChnlGroup88E()
      staging: rtl8188eu: clean function definitions - style
      staging: rtl8188eu: remove unused rtw_scan_abort()
      staging: rtl8188eu: remove rtw_qos.h
      staging: rtl8188eu: simplify function comments - style
      staging: rtl8188eu: do not line break function definition - style
      staging: rtl8188eu: rename variable - style
      staging: rtl8188eu: use break to exit while loop
      staging: rtl8188eu: remove get_right_chnl_for_iqk()
      staging: rtl8188eu: cleanup inconsistent indenting
      staging: rtl8188eu: rename odm_HWConfig
      staging: rtl8188eu: remove wrapper odm_SignalScaleMapping()
      staging: rtl8188eu: add spaces around '+' in odm_hwconfig.c
      staging: rtl8188eu: add spaces around '*' in odm_hwconfig.c
      staging: rtl8188eu: replace tabs with spaces in odm_hwconfig.c
      staging: rtl8188eu: rename parameter of odm_QueryRxPwrPercentage()
      staging: rtl8188eu: rename odm_QueryRxPwrPercentage()
      staging: rtl8188eu: rename parameter of odm_EVMdbToPercentage()
      staging: rtl8188eu: rename odm_EVMdbToPercentage()
      staging: rtl8188eu: rename parameter of odm_SignalScaleMapping()
      staging: rtl8188eu: rename variable in odm_SignalScaleMapping()
      staging: rtl8188eu: rename odm_SignalScaleMapping()
      staging: rtl8188eu: correct block comment in bb_cfg.c
      staging: rtl8188eu: simplify block comment in pwrseq.c
      staging: rtl8188eu: add spaces around '+' in fw.c
      staging: rtl8188eu: remove unnecessary parentheses in odm_rtl8188e.c
      staging: rtl8188eu: remove braces from single if statement
      staging: rtl8188eu: fix spelling mistake in comment
      staging: rtl8712: add SPDX identifiers
      staging: rtl8188eu: fix line over 80 characters - style
      staging: rtl8188eu: cleanup array declaration - style
      staging: rtl8188eu: rewrite if tests - style
      staging: rtl8188eu: change array type to const u8
      staging: rtl8188eu: make struct field of mlme_handler const
      staging: rtl8188eu: make struct field of action_handler const
      staging: rtl8188eu: remove whitespace in rtw_mlme_ext.h
      staging: rtl8188eu: remove dead code from dm_fast_training_init()
      staging: rtl8188eu: add spaces around operators in odm_rtl8188e.c
      staging: rtl8188eu: use __func__ instead of hardcoded name - style
      staging: rtl8188eu: add spaces around operators - style
      staging: rtl8188eu: cleanup lines over 80 characters - style
      staging: rtl8188eu: remove whitespace - style
      staging: rtl8188eu: cleanup missing spaces around operators
      staging: rtl8188eu: use __func__ in qos_acm()
      staging: rtl8188eu: cleanup alignment issue
      staging: rtl8188eu: remove commented code
      staging: rtl8188eu: cleanup block comments
      staging: rtl8188eu: cleanup long lines in rtw_get_sta_pending()
      staging: rtl8188eu: cleanup long lines in stop_sta_xmit()
      staging: rtl8188eu: remove whitespace in qos_acm()
      staging: rtl8188eu: remove unused parameter of HalSetBrateCfg()
      staging: rtl8188eu: rename parameters of HalSetBrateCfg() - style
      staging: rtl8188eu: rename HalSetBrateCfg() - style
      staging: rtl8188eu: remove unused parameter of hal_com_get_channel_plan()
      staging: rtl8188eu: rename parameter of hal_com_get_channel_plan() - style
      staging: rtl8188eu: rename parameters of Hal_MappingOutPipe() - style
      staging: rtl8188eu: rename Hal_MappingOutPipe() - style
      staging: rtl8188eu: remove whitespace - style
      staging: rtl8188eu: cleanup comparsions to false

Nathan Chancellor (10):
      staging: rtlwifi: Use proper enumerated types for Wi-Fi only interface
      staging: wilc1000: Remove unnecessary pointer check
      staging: rtl8188eu: Remove unnecessary parentheses
      staging: rtl8188eu: Simplify memcmp logical checks
      staging: rtl8188eu: Use proper enum in rtl8188eu_config_rf_reg
      staging: bcm2835-camera: Avoid unneeded internal declaration warning
      staging: rtl8723bs: Mark ACPI table declaration as used
      staging: rtlwifi: Remove unnecessary parentheses
      staging: rtl8723bs: Remove unnecessary parentheses and dead commented code
      staging: emxx_udc: Remove unused device_desc declaration

Nick Ewalt (15):
      staging: gasket: fix DMA direction for extended page tables
      staging: gasket: fix data page unmap DMA direction
      staging: gasket: page_table: don't unmap coherent pages
      staging: gasket: fix gasket_free_coherent_memory metadata frees
      staging: gasket: cleanup if dma_map_page fails in gasket_perform_mapping
      staging: gasket: page_table: use total_entries for max ext lvl0 page idx
      staging: gasket: page_table: handle failed dma_map_page
      staging: gasket: page_table: remove unnecessary PTE status set to free
      staging: gasket: page_table: rearrange gasket_page_table_entry
      staging: gasket: page table: fixup error path allocating coherent mem
      staging: gasket: page_table: fix comment in components_to_dev_address
      staging: gasket: page_table: simplify gasket_components_to_dev_address
      staging: gasket: apex: fix sysfs_show
      staging: gasket: sysfs: fix attribute release comment
      staging: gasket: Update device virtual address comment

Nishad Kamdar (12):
      staging: mt7621-mmc: Remove macro INIT_MSG and its usages
      staging: mt7621-mmc: Delete N_MSG() and all its users
      staging: mt7621-mmc: Fix debug macro ERR_MSG and its usages
      staging: mt7621-mmc: Delete IRQ_MSG() and its users
      staging: mt7621-mmc: Remove single statement macro msdc_irq_restore()
      staging: mt7621-mmc: Remove unused single statement macros
      staging: mt7621-mmc: Remove #if 0 blocks in sd.c
      staging: mt7621-mmc: Remove #if 0 blocks in dbg.c
      staging: mt7621-mmc: Remove #if 0 blocks in dbg.h
      staging: mt7621-mmc: Fix lines over 80 characters in dbg.c
      staging: mt7621-mmc: Fix lines over 80 characters in dbg.h
      staging: mt7621-mmc: Use BIT macro instead of explicit shifting in dbg.h

Pavel Zemlyanoy (6):
      staging: erofs: formatting fix in unzip_vle_lz4.c
      staging: erofs: formatting fix to NULL comparison
      staging: erofs: formatting spaces around '-'
      staging: erofs: formatting add spaces arround '*'
      staging: erofs: formatting alignment parenthesis
      staging: erofs: fix 1 warning and 9 checks

Peter Rosin (5):
      iio: potentiometer: mcp4018: use the correct MODULE_LICENSE
      iio: potentiometer: mcp4531: switch to SPDX license identifier
      iio: envelope-detector: switch to SPDX license identifier
      iio: dpot-dac: switch to SPDX license identifier
      iio: multiplexer: switch to SPDX license identifier

Phil Elwell (1):
      staging/vc04_services: Use correct cache line size

Rasmus Villemoes (1):
      staging: greybus: loopback.c: remove unused gb_loopback::lbid

Rick Veens (1):
      staging: rtlwifi: Removed unused define and code efuse_re_pg* from wifi.h

Rob Herring (3):
      iio: Convert to using %pOFn instead of device_node.name
      staging: Convert to using %pOFn instead of device_node.name
      staging: mt7621-pci: remove unnecessary check of device_type == pci

Robert Węcławski (1):
      staging: rtl8188eu: remove code that is valid only for 5 GHz

Sehro Rautenkranz (1):
      staging: dgnc: Fix Kconfig help header and text

Sergio Paracuellos (2):
      staging: mt7621-pci: make some function static
      staging: mt7621-pci: show N_FTS status using a loop

Siddartha Mohanadoss (3):
      dt-bindings: iio: adc: Add DT binding document for PMIC5 ADC
      iio: adc: Add QCOM SPMI PMIC5 ADC driver
      iio: adc: Update QCOM ADC license to SPDX format

Sidong Yang (1):
      staging: rtl8192u: ieee80221: Add missing space

Song Qiang (2):
      iio: magnetometer: hmc5843: Fixed a comment error.
      iio: proximity: Add driver support for ST's VL53L0X ToF ranging sensor.

Spencer E. Olson (18):
      staging: comedi: ni_mio_common: protect register write overflow
      staging: comedi: add facility to directly query subdevice timing constraints
      staging: comedi: ni_mio_common: implement INSN_CONFIG_GET_CMD_TIMING_CONSTRAINTS
      staging: comedi: ni_pcidio: implement INSN_CONFIG_GET_CMD_TIMING_CONSTRAINTS
      staging: comedi: comedi_test: implement INSN_CONFIG_GET_CMD_TIMING_CONSTRAINTS
      staging: comedi: tests: add unittest framework for comedi
      staging: comedi: add abstracted NI signal/terminal named constants
      staging: comedi: add new device-global config interface
      staging: comedi: ni_routing: Add NI signal routing info
      staging: comedi: add interface to ni routing table information
      staging: comedi: ni_mio_common: implement new routing for TRIG_EXT
      staging: comedi: ni_mio_common: implement global pfi, rtsi routing
      staging: comedi: ni_mio_common: implement output selection of GPFO_{0, 1}
      staging: comedi: tio: implement global tio/ctr routing
      staging: comedi: ni_mio_common: create device-global access to tio
      staging: comedi: ni_660x: Add NI PCI-6608 to list of supported devices
      staging: comedi: ni_660x: clean up pfi routing
      staging: comedi: ni_660x: add device-global routing

Stefan Agner (1):
      iio: adc: max9611: explicitly cast gain_selectors

Stefan Popa (10):
      iio: adxl372: New driver for Analog Devices ADXL372 Accelerometer
      dt-bindings: iio: accel: Add docs for ADXL372
      iio:adxl372: Add FIFO and interrupts support
      iio: adxl372: Provide validate_trigger and validate_device callbacks
      iio:adxl372: Add sampling frequency support
      iio:adxl372: Add filter bandwidth support
      iio: dac: ad5758: Add support for hard reset
      iio: adxl372: Refactor the driver
      iio: adxl372: Add support for I2C communication
      dt-bindings: adxl372: Document the adxl372 I2C bindings

Sumit Kumar (1):
      staging: gasket: remove null ptr check before kfree

Sumit Pundir (1):
      staging: mt7621-mmc: place a check for sscanf

Takashi Iwai (29):
      staging: bcm2835-audio: Clean up mutex locks
      staging: bcm2835-audio: Remove redundant spdif stream ctls
      staging: bcm2835-audio: Clean up include files in bcm2835-ctl.c
      staging: bcm2835-audio: Remove redundant substream mask checks
      staging: bcm2835-audio: Fix mute controls, volume handling cleanup
      staging: bcm2835-audio: Remove redundant function calls
      staging: bcm2835-audio: Remove superfluous open flag
      staging: bcm2835-audio: Drop useless running flag and check
      staging: bcm2835-audio: Fix incorrect draining handling
      staging: bcm2835-audio: Kill unused spinlock
      staging: bcm2835-audio: Use PCM runtime values instead
      staging: bcm2835-audio: Drop unnecessary pcm indirect setup
      staging: bcm2835-audio: Drop useless NULL check
      staging: bcm2835-audio: Propagate parameter setup error
      staging: bcm2835-audio: Drop debug messages in bcm2835-pcm.c
      staging: bcm2835-audio: Drop superfluous mutex lock during prepare
      staging: bcm2835-audio: Add 10ms period constraint
      staging: bcm2835-audio: Make single vchi handle
      staging: bcm2835-audio: Code refactoring of vchiq accessor codes
      staging: bcm2835-audio: Operate non-atomic PCM ops
      staging: bcm2835-audio: Use card->private_data
      staging: bcm2835-audio: Use standard error print helpers
      staging: bcm2835-audio: Remove unnecessary header file includes
      staging: bcm2835-audio: Move module parameter description
      staging: bcm2835-audio: Use coherent device buffers
      staging: bcm2835-audio: Set SNDRV_PCM_INFO_SYNC_APPLPTR
      staging: bcm2835-audio: Simplify PCM creation helpers
      staging: bcm2835-audio: Simplify kctl creation helpers
      staging: bcm2835-audio: Simplify card object management

Thomas Petazzoni (1):
      MAINTAINERS: remove myself as staging FBTFT maintainer

Thomas Weißschuh (1):
      staging: erofs: use explicit unsigned int type

Thomas Zimmermann (1):
      staging/vboxvideo: Replace ttm_bo_unref with ttm_bo_put

Tim Collier (63):
      staging: wlan-ng: remove redundant code in "#if 0" blocks
      staging: wlan-ng: rename DIDmsg_dot11req_mibget in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_dot11req_mibget_mibattribute in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_dot11req_mibget_resultcode in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_dot11req_mibset in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_dot11req_mibset_mibattribute in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_dot11req_mibset_resultcode in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_dot11req_scan in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_dot11req_scan_results in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_dot11req_start in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_dot11ind_authenticate in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_lnxreq_ifstate in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_lnxreq_wlansniff in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_lnxreq_hostwep in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_lnxreq_commsquality in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_lnxreq_autojoin in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_p2req_readpda in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_p2req_readpda_pda in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_dot11ind_associate in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_p2req_readpda_resultcode in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_p2req_ramdl_state in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_p2req_ramdl_state_enable in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_p2req_ramdl_state_exeaddr in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_p2req_ramdl_state_resultcode in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_p2req_ramdl_write in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_p2req_ramdl_write_addr in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_p2req_ramdl_write_len in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_p2req_ramdl_write_data in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_p2req_ramdl_write_resultcode in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_p2req_flashdl_state in p80211metadef.h
      staging: wlan-ng: rename DIDmsg_p2req_flashdl_write in p80211metadef.h
      staging: wlan-ng: rename DIDmib_cat_dot11smt in p80211metadef.h
      staging: wlan-ng: rename DIDmib_dot11smt_dot11WEPDefaultKeysTable in p80211metadef.h
      staging: wlan-ng: rename DIDmib_dot11smt_dot11WEPDefaultKeysTable_key in p80211metadef.h
      staging: wlan-ng: rename DIDmib_dot11smt_dot11PrivacyTable in p80211metadef.h
      staging: wlan-ng: rename DIDmib_dot11smt_dot11PrivacyTable_dot11PrivacyInvoked in p80211metadef.h
      staging: wlan-ng: rename DIDmib_dot11smt_dot11PrivacyTable_dot11WEPDefaultKeyID in p80211metadef.h
      staging: wlan-ng: rename DIDmib_dot11smt_dot11PrivacyTable_dot11ExcludeUnencrypted in p80211metadef.h
      staging: wlan-ng: rename DIDmib_dot11mac_dot11OperationTable in p80211metadef.h
      staging: wlan-ng: rename DIDmib_dot11mac_dot11OperationTable_dot11MACAddress in p80211metadef.h
      staging: wlan-ng: DIDmib_dot11mac_dot11OperationTable_dot11RTSThreshold in p80211metadef.h
      staging: wlan-ng: rename DIDmib_dot11mac_dot11OperationTable_dot11ShortRetryLimit in p80211metadef.h
      staging: wlan-ng: rename DIDmib_dot11mac_dot11OperationTable_dot11LongRetryLimit in p80211metadef.h
      staging: wlan-ng: rename DIDmib_dot11mac_dot11OperationTable_dot11FragmentationThreshold in p80211metadef.h
      staging: wlan-ng: rename DIDmib_dot11mac_dot11OperationTable_dot11MaxTransmitMSDULifetime in p80211metadef.h
      staging: wlan-ng: rename DIDmib_cat_dot11phy in p80211metadef.h
      staging: wlan-ng: rename DIDmib_dot11phy_dot11PhyOperationTable in p80211metadef.h
      staging: wlan-ng: rename DIDmib_dot11phy_dot11PhyTxPowerTable_dot11CurrentTxPowerLevel in p80211metadef.h
      staging: wlan-ng: rename DIDmib_dot11phy_dot11PhyDSSSTable in p80211metadef.h
      staging: wlan-ng: rename DIDmib_dot11phy_dot11PhyDSSSTable_dot11CurrentChannel in p80211metadef.h
      staging: wlan-ng: rename DIDmib_cat_lnx in p80211metadef.h
      staging: wlan-ng: rename DIDmib_lnx_lnxConfigTable in p80211metadef.h
      staging: wlan-ng: rename DIDmib_lnx_lnxConfigTable_lnxRSNAIE in p80211metadef.h
      staging: wlan-ng: rename DIDmib_cat_p2 in p80211metadef.h
      staging: wlan-ng: rename DIDmib_p2_p2Static in p80211metadef.h
      staging: wlan-ng: rename DIDmib_p2_p2Static_p2CnfPortType in p80211metadef.h
      staging: wlan-ng: rename DIDmib_p2_p2NIC_p2PRISupRange in p80211metadef.h
      staging: wlan-ng: rename DIDmib_p2_p2MAC in p80211metadef.h
      staging: wlan-ng: rename DIDmib_p2_p2MAC_p2CurrentTxRate in p80211metadef.h
      staging: wlan-ng: formatting cleanup in cfg80211.c
      staging: wlan-ng: make switch case block format consistent
      staging: wlan-ng: rejoin split lines shortened by case changes
      staging: wlan-ng: remove "autogenerated code" comments

Todd Poynor (21):
      staging: gasket: core: remove debug log that could crash
      staging: gasket: core: fix line continuation indent in gasket_alloc_dev
      staging: gasket: core: remove kobj_name param from gasket_alloc_dev
      staging: gasket: core: remove ftrace-style debug logs
      staging: gasket: remove gasket_exit()
      staging: gasket: page table: use dma_mapping_error for error detection
      staging: gasket: core: switch to relaxed memory-mapped I/O
      staging: gasket: page table: remove extraneous memory barriers
      staging: gasket: core: factor out generic device add code from PCI code
      staging: gasket: core: factor out generic device remove code from PCI
      staging: gasket: core: rename lookup_internal_desc to be PCI-specific
      staging: gasket: interrupt: refactor PCI MSIX-specific handler code
      staging: gasket: interrupt: simplify interrupt init parameters
      staging: gasket: interrupt: remove unimplemented interrupt types
      staging: gasket: Kconfig: describe Apex as an Edge TPU device
      staging: gasket: interrupt: remove PCI-MSIX-specific status check
      staging: gasket: page table: use GFP_KERNEL for dma_alloc_coherent
      staging: gasket: page table: return valid error code on map fail
      staging: gasket: page table: remove dead code in coherent mem alloc
      staging: gasket: remove debug logs in page table mapping calls
      staging: gasket: remove debug logs for callback invocation

Tom Todd (1):
      Staging: rtlwifi: efuse: Fixed a line length code styling issue.

Tomasz Duszynski (4):
      iio: pressure: ms5611: remove deprecated compatible strings
      iio: light: bh1750: switch to SPDX identifier
      iio: pressure: ms5611: switch to SPDX identifier
      iio: light: bh1750: simplify setting PM ops

Tuomas Tynkkynen (8):
      staging: vc04_services: Remove unused vchiq_genversion script
      staging: vc04_services: Drop pointless stub functions
      staging: vc04_services: Drop 'connection' field from SERVICE_CREATION_T
      staging: vc04_services: Drop trivially unused fields from SERVICE_CREATION_T
      staging: vc04_services: Drop declaration of vchi_crc_control()
      staging: vc04_services: Drop VCHI_SERVICE_INIT and SERVICE_INFO_T
      staging: vc04_services: Drop unused parameters from vchi_connect()
      staging: vc04_services: Drop no longer needed headers

Vladimir Zapolskiy (1):
      Documentation: filesystems: remove reminiscences of POHMELFS

YueHaibing (2):
      staging: rtlwifi: Remove set but not used variable 'ppsc'
      staging: axis-fifo: remove duplicated include from axis-fifo.c

ryang (2):
      dt-bindings: iio: light: bh1750: Add device tree binding documentation
      iio: light: bh1750: Add device tree support

zhong jiang (1):
      staging: remove unneeded static set .owner field in platform_driver

 Documentation/ABI/testing/sysfs-bus-iio            |    2 +-
 .../devicetree/bindings/iio/accel/adxl372.txt      |   33 +
 .../devicetree/bindings/iio/adc/mcp3911.txt        |   30 +
 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt |   81 +-
 .../bindings/iio/adc/sprd,sc27xx-adc.txt           |    4 +
 .../devicetree/bindings/iio/dac/ad5758.txt         |    5 +
 .../devicetree/bindings/iio/dac/ltc1660.txt        |   21 +
 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |    1 +
 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |    1 +
 .../devicetree/bindings/iio/light/bh1750.txt       |   18 +
 .../devicetree/bindings/iio/light/tsl2772.txt      |   42 +
 .../devicetree/bindings/iio/proximity/vl53l0x.txt  |   12 +
 .../devicetree/bindings/trivial-devices.txt        |   10 -
 Documentation/filesystems/00-INDEX                 |    2 -
 .../filesystems/pohmelfs/design_notes.txt          |   72 -
 Documentation/filesystems/pohmelfs/info.txt        |   99 -
 .../filesystems/pohmelfs/network_protocol.txt      |  227 --
 MAINTAINERS                                        |   52 +-
 drivers/iio/accel/Kconfig                          |   27 +
 drivers/iio/accel/Makefile                         |    3 +
 drivers/iio/accel/adxl345_i2c.c                    |    5 +-
 drivers/iio/accel/adxl372.c                        |  975 ++++++
 drivers/iio/accel/adxl372.h                        |   17 +
 drivers/iio/accel/adxl372_i2c.c                    |   61 +
 drivers/iio/accel/adxl372_spi.c                    |   52 +
 drivers/iio/adc/Kconfig                            |   30 +
 drivers/iio/adc/Makefile                           |    2 +
 drivers/iio/adc/ad7298.c                           |    2 +-
 drivers/iio/adc/ad7476.c                           |    2 +-
 drivers/iio/adc/ad7793.c                           |    2 +-
 drivers/iio/adc/ad7887.c                           |    2 +-
 drivers/iio/adc/ad7923.c                           |    2 +-
 drivers/iio/adc/ad799x.c                           |    2 +-
 drivers/iio/adc/at91_adc.c                         |    6 +-
 drivers/iio/adc/envelope-detector.c                |    5 +-
 drivers/iio/adc/fsl-imx25-gcq.c                    |    6 +
 drivers/iio/adc/max9611.c                          |    2 +-
 drivers/iio/adc/mcp3911.c                          |  363 +++
 drivers/iio/adc/meson_saradc.c                     |   70 +-
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                |    4 +-
 drivers/iio/adc/qcom-spmi-adc5.c                   |  793 +++++
 drivers/iio/adc/qcom-vadc-common.c                 |  189 +-
 drivers/iio/adc/qcom-vadc-common.h                 |   54 +
 drivers/iio/adc/rcar-gyroadc.c                     |   12 +-
 drivers/iio/adc/sc27xx_adc.c                       |  154 +-
 drivers/iio/adc/ti-ads7950.c                       |   53 +-
 drivers/iio/amplifiers/ad8366.c                    |    2 +-
 drivers/iio/chemical/bme680.h                      |   19 +-
 drivers/iio/chemical/bme680_core.c                 |  154 +-
 drivers/iio/dac/Kconfig                            |   10 +
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/ad5064.c                           |   53 +-
 drivers/iio/dac/ad5446.c                           |    2 +-
 drivers/iio/dac/ad5504.c                           |    2 +-
 drivers/iio/dac/ad5686.c                           |    2 +-
 drivers/iio/dac/ad5758.c                           |   26 +-
 drivers/iio/dac/ad5791.c                           |    2 +-
 drivers/iio/dac/dpot-dac.c                         |    5 +-
 drivers/iio/dac/ltc1660.c                          |  250 ++
 drivers/iio/dac/max517.c                           |   11 +-
 drivers/iio/dac/max5821.c                          |   11 +-
 drivers/iio/dac/mcp4725.c                          |   12 +-
 drivers/iio/dac/mcp4922.c                          |   11 +-
 drivers/iio/dac/ti-dac5571.c                       |    1 +
 drivers/iio/frequency/ad9523.c                     |    2 +-
 drivers/iio/frequency/adf4350.c                    |    2 +-
 drivers/iio/health/max30102.c                      |    6 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   62 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |    2 +
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |    2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   18 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |  166 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   51 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |    5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |    5 +
 drivers/iio/light/bh1750.c                         |   25 +-
 drivers/iio/light/max44000.c                       |    1 -
 drivers/iio/light/tsl2772.c                        |  194 +-
 drivers/iio/magnetometer/hmc5843.h                 |    2 +-
 drivers/iio/multiplexer/iio-mux.c                  |    5 +-
 drivers/iio/potentiometer/max5481.c                |    7 +-
 drivers/iio/potentiometer/mcp4018.c                |    9 +-
 drivers/iio/potentiometer/mcp4531.c                |   14 +-
 drivers/iio/pressure/ms5611.h                      |    5 +-
 drivers/iio/pressure/ms5611_core.c                 |    5 +-
 drivers/iio/pressure/ms5611_i2c.c                  |    7 +-
 drivers/iio/pressure/ms5611_spi.c                  |    7 +-
 drivers/iio/proximity/Kconfig                      |   11 +
 drivers/iio/proximity/Makefile                     |    2 +
 drivers/iio/proximity/isl29501.c                   |   12 +-
 drivers/iio/proximity/vl53l0x-i2c.c                |  164 +
 drivers/iio/trigger/iio-trig-sysfs.c               |    2 +-
 drivers/spi/spi.c                                  |   31 +-
 drivers/staging/Kconfig                            |    2 -
 drivers/staging/Makefile                           |    1 -
 drivers/staging/android/ion/ion.h                  |    5 -
 drivers/staging/android/ion/ion_system_heap.c      |   24 -
 drivers/staging/axis-fifo/axis-fifo.c              |   24 +-
 .../clocking-wizard/clk-xlnx-clock-wizard.c        |   20 +-
 drivers/staging/comedi/Kconfig                     |    4 +
 drivers/staging/comedi/comedi.h                    |  174 +-
 drivers/staging/comedi/comedi_fops.c               |   73 +
 drivers/staging/comedi/comedidev.h                 |   14 +
 drivers/staging/comedi/drivers.c                   |   19 +
 drivers/staging/comedi/drivers/Makefile            |   28 +
 drivers/staging/comedi/drivers/comedi_test.c       |   44 +
 drivers/staging/comedi/drivers/ni_660x.c           |  363 ++-
 drivers/staging/comedi/drivers/ni_mio_common.c     |  944 +++++-
 drivers/staging/comedi/drivers/ni_pcidio.c         |   13 +
 drivers/staging/comedi/drivers/ni_pcimio.c         |   21 +
 drivers/staging/comedi/drivers/ni_routes.c         |  523 +++
 drivers/staging/comedi/drivers/ni_routes.h         |  329 ++
 drivers/staging/comedi/drivers/ni_routing/README   |  240 ++
 .../comedi/drivers/ni_routing/ni_device_routes.c   |   51 +
 .../comedi/drivers/ni_routing/ni_device_routes.h   |   32 +
 .../drivers/ni_routing/ni_device_routes/all.h      |   54 +
 .../ni_routing/ni_device_routes/pci-6070e.c        |  639 ++++
 .../drivers/ni_routing/ni_device_routes/pci-6220.c | 1418 ++++++++
 .../drivers/ni_routing/ni_device_routes/pci-6221.c | 1602 ++++++++++
 .../drivers/ni_routing/ni_device_routes/pci-6229.c | 1602 ++++++++++
 .../drivers/ni_routing/ni_device_routes/pci-6251.c | 1652 ++++++++++
 .../drivers/ni_routing/ni_device_routes/pci-6254.c | 1464 +++++++++
 .../drivers/ni_routing/ni_device_routes/pci-6259.c | 1652 ++++++++++
 .../drivers/ni_routing/ni_device_routes/pci-6534.c |  290 ++
 .../drivers/ni_routing/ni_device_routes/pci-6602.c | 3378 ++++++++++++++++++++
 .../drivers/ni_routing/ni_device_routes/pci-6713.c |  400 +++
 .../drivers/ni_routing/ni_device_routes/pci-6723.c |  400 +++
 .../drivers/ni_routing/ni_device_routes/pci-6733.c |  428 +++
 .../ni_routing/ni_device_routes/pxi-6030e.c        |  608 ++++
 .../drivers/ni_routing/ni_device_routes/pxi-6224.c | 1432 +++++++++
 .../drivers/ni_routing/ni_device_routes/pxi-6225.c | 1613 ++++++++++
 .../drivers/ni_routing/ni_device_routes/pxi-6251.c | 1655 ++++++++++
 .../drivers/ni_routing/ni_device_routes/pxi-6733.c |  428 +++
 .../ni_routing/ni_device_routes/pxie-6251.c        | 1656 ++++++++++
 .../ni_routing/ni_device_routes/pxie-6535.c        |  575 ++++
 .../ni_routing/ni_device_routes/pxie-6738.c        | 3083 ++++++++++++++++++
 .../comedi/drivers/ni_routing/ni_route_values.c    |   42 +
 .../comedi/drivers/ni_routing/ni_route_values.h    |   98 +
 .../drivers/ni_routing/ni_route_values/all.h       |   37 +
 .../drivers/ni_routing/ni_route_values/ni_660x.c   |  650 ++++
 .../ni_routing/ni_route_values/ni_eseries.c        |  602 ++++
 .../ni_routing/ni_route_values/ni_mseries.c        | 1752 ++++++++++
 .../comedi/drivers/ni_routing/tools/.gitignore     |    7 +
 .../comedi/drivers/ni_routing/tools/Makefile       |   79 +
 .../drivers/ni_routing/tools/convert_c_to_py.c     |  159 +
 .../drivers/ni_routing/tools/convert_csv_to_c.py   |  503 +++
 .../drivers/ni_routing/tools/convert_py_to_csv.py  |   67 +
 .../drivers/ni_routing/tools/csv_collection.py     |   40 +
 .../drivers/ni_routing/tools/make_blank_csv.py     |   32 +
 .../comedi/drivers/ni_routing/tools/ni_names.py    |   56 +
 drivers/staging/comedi/drivers/ni_stc.h            |   79 +-
 drivers/staging/comedi/drivers/ni_tio.c            |  461 ++-
 drivers/staging/comedi/drivers/ni_tio.h            |   42 +-
 drivers/staging/comedi/drivers/ni_tio_internal.h   |    2 +
 drivers/staging/comedi/drivers/ni_tiocmd.c         |   66 +-
 drivers/staging/comedi/drivers/tests/Makefile      |    7 +
 .../staging/comedi/drivers/tests/example_test.c    |   72 +
 .../staging/comedi/drivers/tests/ni_routes_test.c  |  613 ++++
 drivers/staging/comedi/drivers/tests/unittest.h    |   63 +
 drivers/staging/dgnc/Kconfig                       |    6 -
 drivers/staging/dgnc/Makefile                      |    4 -
 drivers/staging/dgnc/TODO                          |    6 -
 drivers/staging/dgnc/dgnc_cls.c                    | 1135 -------
 drivers/staging/dgnc/dgnc_cls.h                    |   67 -
 drivers/staging/dgnc/dgnc_driver.c                 |  404 ---
 drivers/staging/dgnc/dgnc_driver.h                 |  345 --
 drivers/staging/dgnc/dgnc_tty.c                    | 2590 ---------------
 drivers/staging/dgnc/dgnc_tty.h                    |   24 -
 drivers/staging/dgnc/digi.h                        |  128 -
 drivers/staging/emxx_udc/emxx_udc.c                |   43 +-
 drivers/staging/erofs/Kconfig                      |    9 +
 drivers/staging/erofs/data.c                       |  105 +-
 drivers/staging/erofs/dir.c                        |   15 +-
 drivers/staging/erofs/erofs_fs.h                   |   11 +
 drivers/staging/erofs/include/trace/events/erofs.h |   20 +-
 drivers/staging/erofs/inode.c                      |   50 +-
 drivers/staging/erofs/internal.h                   |  111 +-
 drivers/staging/erofs/namei.c                      |   28 +-
 drivers/staging/erofs/super.c                      |   96 +-
 drivers/staging/erofs/unzip_vle.c                  |  447 +--
 drivers/staging/erofs/unzip_vle.h                  |   12 +-
 drivers/staging/erofs/unzip_vle_lz4.c              |   69 +-
 drivers/staging/erofs/utils.c                      |    2 +-
 drivers/staging/erofs/xattr.c                      |  196 +-
 drivers/staging/fbtft/fbtft.h                      |   58 +-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c            |    6 +-
 drivers/staging/gasket/Kconfig                     |    5 +-
 drivers/staging/gasket/apex_driver.c               |    6 +-
 drivers/staging/gasket/gasket_core.c               |  145 +-
 drivers/staging/gasket/gasket_core.h               |   21 +-
 drivers/staging/gasket/gasket_interrupt.c          |  110 +-
 drivers/staging/gasket/gasket_interrupt.h          |   24 +-
 drivers/staging/gasket/gasket_page_table.c         |  162 +-
 drivers/staging/gasket/gasket_sysfs.h              |    4 +-
 drivers/staging/greybus/audio_codec.c              |    1 -
 drivers/staging/greybus/loopback.c                 |    8 -
 drivers/staging/greybus/tools/README.loopback      |    2 +-
 drivers/staging/greybus/tools/loopback_test.c      |    2 +-
 drivers/staging/iio/adc/Kconfig                    |    2 +-
 drivers/staging/iio/adc/ad7192.c                   |    2 +-
 drivers/staging/iio/adc/ad7280a.c                  |    2 +-
 drivers/staging/iio/adc/ad7606.c                   |   42 +-
 drivers/staging/iio/adc/ad7606.h                   |   31 +-
 drivers/staging/iio/adc/ad7606_par.c               |    5 +-
 drivers/staging/iio/adc/ad7606_spi.c               |    3 +-
 drivers/staging/iio/adc/ad7780.c                   |    2 +-
 drivers/staging/iio/cdc/ad7746.c                   |    2 +-
 drivers/staging/iio/frequency/ad9832.c             |    2 +-
 drivers/staging/iio/frequency/ad9834.c             |    2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |    2 +-
 drivers/staging/ks7010/ks_hostif.c                 |    5 +-
 drivers/staging/media/davinci_vpfe/dm365_ipipe.c   |    6 +-
 drivers/staging/media/davinci_vpfe/dm365_resizer.c |    2 +-
 drivers/staging/media/davinci_vpfe/dm365_resizer.h |    2 +-
 drivers/staging/media/imx/imx-media-dev.c          |   15 +-
 drivers/staging/media/imx/imx-media-of.c           |    4 +-
 drivers/staging/most/cdev/cdev.c                   |   12 +-
 drivers/staging/most/core.c                        |   49 +-
 drivers/staging/most/net/net.c                     |    2 +-
 drivers/staging/most/usb/usb.c                     |   55 +-
 drivers/staging/most/video/video.c                 |    4 +-
 drivers/staging/mt7621-dma/ralink-gdma.c           |    1 -
 drivers/staging/mt7621-eth/gsw_mt7621.c            |    1 -
 drivers/staging/mt7621-eth/mdio.c                  |    4 +-
 drivers/staging/mt7621-eth/mtk_eth_soc.c           |    1 -
 drivers/staging/mt7621-mmc/dbg.c                   |  104 +-
 drivers/staging/mt7621-mmc/dbg.h                   |  100 +-
 drivers/staging/mt7621-mmc/sd.c                    |  708 +---
 drivers/staging/mt7621-pci/pci-mt7621.c            |   76 +-
 drivers/staging/octeon-usb/octeon-hcd.c            |   58 +-
 drivers/staging/olpc_dcon/Kconfig                  |    1 +
 drivers/staging/olpc_dcon/olpc_dcon.c              |    5 +-
 drivers/staging/olpc_dcon/olpc_dcon_xo_1.c         |    5 +-
 drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c       |    5 +-
 drivers/staging/pi433/rf69.c                       |    3 +-
 drivers/staging/rtl8188eu/Makefile                 |    2 +-
 drivers/staging/rtl8188eu/TODO                     |    2 +-
 drivers/staging/rtl8188eu/core/rtw_ap.c            |   25 +-
 drivers/staging/rtl8188eu/core/rtw_cmd.c           |   57 +-
 drivers/staging/rtl8188eu/core/rtw_debug.c         |   25 +-
 drivers/staging/rtl8188eu/core/rtw_efuse.c         |   80 +-
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c     |   24 +-
 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c     |  142 +-
 drivers/staging/rtl8188eu/core/rtw_led.c           |  242 +-
 drivers/staging/rtl8188eu/core/rtw_mlme.c          |   69 +-
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c      |   60 +-
 drivers/staging/rtl8188eu/core/rtw_pwrctrl.c       |    9 +-
 drivers/staging/rtl8188eu/core/rtw_recv.c          |   43 +-
 drivers/staging/rtl8188eu/core/rtw_security.c      |   13 +-
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c     |   73 +-
 drivers/staging/rtl8188eu/core/rtw_xmit.c          |  187 +-
 drivers/staging/rtl8188eu/hal/bb_cfg.c             |    8 +-
 drivers/staging/rtl8188eu/hal/fw.c                 |    6 +-
 .../staging/rtl8188eu/hal/hal8188e_rate_adaptive.c |   18 +-
 drivers/staging/rtl8188eu/hal/hal_com.c            |   11 +-
 drivers/staging/rtl8188eu/hal/odm.c                |   21 +-
 .../hal/{odm_HWConfig.c => odm_hwconfig.c}         |  100 +-
 drivers/staging/rtl8188eu/hal/odm_rtl8188e.c       |   67 +-
 drivers/staging/rtl8188eu/hal/phy.c                |   27 +-
 drivers/staging/rtl8188eu/hal/pwrseq.c             |    5 +-
 drivers/staging/rtl8188eu/hal/rf_cfg.c             |    2 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c  |  101 +-
 drivers/staging/rtl8188eu/hal/usb_halinit.c        |   26 +-
 drivers/staging/rtl8188eu/include/drv_types.h      |    7 +-
 drivers/staging/rtl8188eu/include/hal_com.h        |   12 +-
 .../include/{odm_HWConfig.h => odm_hwconfig.h}     |    0
 drivers/staging/rtl8188eu/include/odm_precomp.h    |    4 +-
 drivers/staging/rtl8188eu/include/odm_reg.h        |  106 -
 drivers/staging/rtl8188eu/include/osdep_service.h  |    2 -
 drivers/staging/rtl8188eu/include/phy.h            |    1 -
 drivers/staging/rtl8188eu/include/rtw_mlme.h       |    3 +-
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h   |   18 +-
 drivers/staging/rtl8188eu/include/rtw_qos.h        |   18 -
 drivers/staging/rtl8188eu/include/wifi.h           |    8 -
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c     |   25 +-
 drivers/staging/rtl8188eu/os_dep/mlme_linux.c      |    2 +-
 drivers/staging/rtl8188eu/os_dep/os_intfs.c        |    2 +-
 drivers/staging/rtl8188eu/os_dep/osdep_service.c   |   14 -
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c   |    4 +-
 drivers/staging/rtl8188eu/os_dep/xmit_linux.c      |   47 +-
 drivers/staging/rtl8192e/rtllib_softmac.c          |   16 +-
 drivers/staging/rtl8192u/ieee80211/dot11d.c        |  108 +-
 drivers/staging/rtl8192u/ieee80211/dot11d.h        |   77 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211.h     |   18 +-
 .../staging/rtl8192u/ieee80211/ieee80211_module.c  |   35 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c  |   12 +-
 .../staging/rtl8192u/ieee80211/ieee80211_softmac.c |   14 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c  |    4 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c  |    6 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h    |   84 +-
 .../staging/rtl8192u/ieee80211/rtl819x_BAProc.c    |  184 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h    |  161 +-
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c    |  138 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h    |    6 +-
 .../staging/rtl8192u/ieee80211/rtl819x_TSProc.c    |   16 +-
 drivers/staging/rtl8192u/r8180_93cx6.h             |   19 +-
 drivers/staging/rtl8192u/r8190_rtl8256.c           |   33 +-
 drivers/staging/rtl8192u/r8190_rtl8256.h           |   11 +-
 drivers/staging/rtl8192u/r8192U.h                  |   46 +-
 drivers/staging/rtl8192u/r8192U_core.c             |  105 +-
 drivers/staging/rtl8192u/r8192U_hw.h               |  204 +-
 drivers/staging/rtl8192u/r819xU_firmware.c         |    4 +-
 drivers/staging/rtl8192u/r819xU_firmware.h         |   11 +-
 drivers/staging/rtl8192u/r819xU_phy.c              |   31 +-
 drivers/staging/rtl8192u/r819xU_phy.h              |    6 +-
 drivers/staging/rtl8712/basic_types.h              |   10 +-
 drivers/staging/rtl8712/drv_types.h                |   10 +-
 drivers/staging/rtl8712/ethernet.h                 |   10 +-
 drivers/staging/rtl8712/hal_init.c                 |   10 +-
 drivers/staging/rtl8712/ieee80211.c                |   10 +-
 drivers/staging/rtl8712/ieee80211.h                |   13 +-
 drivers/staging/rtl8712/mlme_linux.c               |   14 +-
 drivers/staging/rtl8712/mlme_osdep.h               |   14 +-
 drivers/staging/rtl8712/mp_custom_oid.h            |   14 +-
 drivers/staging/rtl8712/os_intfs.c                 |   10 +-
 drivers/staging/rtl8712/osdep_intf.h               |   14 +-
 drivers/staging/rtl8712/osdep_service.h            |   14 +-
 drivers/staging/rtl8712/recv_linux.c               |   14 +-
 drivers/staging/rtl8712/recv_osdep.h               |   14 +-
 drivers/staging/rtl8712/rtl8712_bitdef.h           |   15 +-
 drivers/staging/rtl8712/rtl8712_cmd.c              |   14 +-
 drivers/staging/rtl8712/rtl8712_cmd.h              |   14 +-
 drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h   |   15 +-
 drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h   |   15 +-
 drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h |   15 +-
 drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h |   15 +-
 .../staging/rtl8712/rtl8712_edcasetting_bitdef.h   |   14 +-
 .../staging/rtl8712/rtl8712_edcasetting_regdef.h   |   15 +-
 drivers/staging/rtl8712/rtl8712_efuse.c            |   14 +-
 drivers/staging/rtl8712/rtl8712_event.h            |   14 +-
 drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h  |   15 +-
 drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h  |   15 +-
 drivers/staging/rtl8712/rtl8712_gp_bitdef.h        |   14 +-
 drivers/staging/rtl8712/rtl8712_gp_regdef.h        |   14 +-
 drivers/staging/rtl8712/rtl8712_hal.h              |   14 +-
 drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h |   15 +-
 drivers/staging/rtl8712/rtl8712_io.c               |   14 +-
 drivers/staging/rtl8712/rtl8712_led.c              |   14 +-
 .../staging/rtl8712/rtl8712_macsetting_bitdef.h    |   15 +-
 .../staging/rtl8712/rtl8712_macsetting_regdef.h    |   15 +-
 drivers/staging/rtl8712/rtl8712_powersave_bitdef.h |   15 +-
 drivers/staging/rtl8712/rtl8712_powersave_regdef.h |   15 +-
 drivers/staging/rtl8712/rtl8712_ratectrl_bitdef.h  |   15 +-
 drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h  |   14 +-
 drivers/staging/rtl8712/rtl8712_recv.c             |   14 +-
 drivers/staging/rtl8712/rtl8712_recv.h             |   14 +-
 drivers/staging/rtl8712/rtl8712_regdef.h           |   14 +-
 drivers/staging/rtl8712/rtl8712_security_bitdef.h  |   15 +-
 drivers/staging/rtl8712/rtl8712_spec.h             |   14 +-
 drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h    |   14 +-
 drivers/staging/rtl8712/rtl8712_syscfg_regdef.h    |   14 +-
 drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h  |   15 +-
 drivers/staging/rtl8712/rtl8712_timectrl_regdef.h  |   15 +-
 drivers/staging/rtl8712/rtl8712_wmac_bitdef.h      |   14 +-
 drivers/staging/rtl8712/rtl8712_wmac_regdef.h      |   14 +-
 drivers/staging/rtl8712/rtl8712_xmit.c             |   14 +-
 drivers/staging/rtl8712/rtl8712_xmit.h             |   14 +-
 drivers/staging/rtl8712/rtl871x_cmd.c              |   14 +-
 drivers/staging/rtl8712/rtl871x_cmd.h              |   14 +-
 drivers/staging/rtl8712/rtl871x_debug.h            |   14 +-
 drivers/staging/rtl8712/rtl871x_eeprom.c           |   14 +-
 drivers/staging/rtl8712/rtl871x_eeprom.h           |   15 +-
 drivers/staging/rtl8712/rtl871x_event.h            |   14 +-
 drivers/staging/rtl8712/rtl871x_ht.h               |   14 +-
 drivers/staging/rtl8712/rtl871x_io.c               |   20 +-
 drivers/staging/rtl8712/rtl871x_io.h               |   14 +-
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c      |   21 +-
 drivers/staging/rtl8712/rtl871x_ioctl_rtl.c        |   14 +-
 drivers/staging/rtl8712/rtl871x_ioctl_rtl.h        |   14 +-
 drivers/staging/rtl8712/rtl871x_ioctl_set.c        |   14 +-
 drivers/staging/rtl8712/rtl871x_ioctl_set.h        |   14 +-
 drivers/staging/rtl8712/rtl871x_led.h              |   14 +-
 drivers/staging/rtl8712/rtl871x_mlme.c             |   14 +-
 drivers/staging/rtl8712/rtl871x_mlme.h             |   14 +-
 drivers/staging/rtl8712/rtl871x_mp.c               |   14 +-
 drivers/staging/rtl8712/rtl871x_mp.h               |   14 +-
 drivers/staging/rtl8712/rtl871x_mp_ioctl.c         |   14 +-
 drivers/staging/rtl8712/rtl871x_mp_ioctl.h         |   14 +-
 drivers/staging/rtl8712/rtl871x_pwrctrl.c          |   14 +-
 drivers/staging/rtl8712/rtl871x_pwrctrl.h          |   14 +-
 drivers/staging/rtl8712/rtl871x_recv.c             |   14 +-
 drivers/staging/rtl8712/rtl871x_rf.h               |   14 +-
 drivers/staging/rtl8712/rtl871x_security.c         |   14 +-
 drivers/staging/rtl8712/rtl871x_security.h         |   14 +-
 drivers/staging/rtl8712/rtl871x_sta_mgt.c          |   14 +-
 drivers/staging/rtl8712/rtl871x_wlan_sme.h         |   14 +-
 drivers/staging/rtl8712/rtl871x_xmit.c             |   16 +-
 drivers/staging/rtl8712/rtl871x_xmit.h             |   14 +-
 drivers/staging/rtl8712/sta_info.h                 |   14 +-
 drivers/staging/rtl8712/usb_halinit.c              |   14 +-
 drivers/staging/rtl8712/usb_intf.c                 |   14 +-
 drivers/staging/rtl8712/usb_ops.c                  |   14 +-
 drivers/staging/rtl8712/usb_ops.h                  |   14 +-
 drivers/staging/rtl8712/usb_ops_linux.c            |   14 +-
 drivers/staging/rtl8712/usb_osintf.h               |   14 +-
 drivers/staging/rtl8712/wifi.h                     |   14 +-
 drivers/staging/rtl8712/wlan_bssdef.h              |   14 +-
 drivers/staging/rtl8712/xmit_linux.c               |   14 +-
 drivers/staging/rtl8712/xmit_osdep.h               |   14 +-
 drivers/staging/rtl8723bs/core/rtw_ap.c            |   24 +-
 drivers/staging/rtl8723bs/core/rtw_debug.c         |    2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c          |    2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |   11 +-
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c       |    4 +-
 drivers/staging/rtl8723bs/core/rtw_security.c      |    5 +-
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c     |   11 +-
 drivers/staging/rtl8723bs/hal/odm_DIG.c            |    4 +-
 drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c |    2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c  |    2 +-
 drivers/staging/rtl8723bs/include/drv_types.h      |    2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c     |   30 +-
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c       |    2 +-
 drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c   |   10 +-
 drivers/staging/rtlwifi/efuse.c                    |    3 +-
 drivers/staging/rtlwifi/halmac/rtl_halmac.c        |    4 +-
 drivers/staging/rtlwifi/phydm/phydm_adc_sampling.c |    2 +-
 drivers/staging/rtlwifi/phydm/phydm_dig.c          |    4 +-
 drivers/staging/rtlwifi/regd.c                     |    2 +-
 drivers/staging/rtlwifi/wifi.h                     |    4 -
 drivers/staging/rts5208/ms.c                       |  619 ++--
 drivers/staging/rts5208/rtsx_card.c                |   92 +-
 drivers/staging/rts5208/rtsx_card.h                |    3 +-
 drivers/staging/rts5208/rtsx_chip.c                |  396 +--
 drivers/staging/rts5208/rtsx_scsi.c                |  108 +-
 drivers/staging/rts5208/sd.c                       |  649 ++--
 drivers/staging/rts5208/spi.c                      |  141 +-
 drivers/staging/rts5208/xd.c                       |  210 +-
 drivers/staging/sm750fb/ddk750_mode.c              |    2 +-
 drivers/staging/sm750fb/ddk750_sii164.c            |    8 +-
 drivers/staging/sm750fb/sm750.c                    |   10 +-
 drivers/staging/speakup/spk_ttyio.c                |    4 +-
 drivers/staging/vboxvideo/TODO                     |    1 -
 drivers/staging/vboxvideo/vbox_drv.c               |  165 +-
 drivers/staging/vboxvideo/vbox_drv.h               |   86 +-
 drivers/staging/vboxvideo/vbox_fb.c                |  152 +-
 drivers/staging/vboxvideo/vbox_irq.c               |    8 +-
 drivers/staging/vboxvideo/vbox_main.c              |  185 +-
 drivers/staging/vboxvideo/vbox_mode.c              |  922 +++---
 drivers/staging/vboxvideo/vbox_ttm.c               |   78 +-
 .../vc04_services/bcm2835-audio/bcm2835-ctl.c      |  235 +-
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c      |  338 +-
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c    |  883 ++---
 .../staging/vc04_services/bcm2835-audio/bcm2835.c  |  222 +-
 .../staging/vc04_services/bcm2835-audio/bcm2835.h  |   86 +-
 drivers/staging/vc04_services/bcm2835-camera/TODO  |    6 -
 .../vc04_services/bcm2835-camera/controls.c        |    2 +-
 .../vc04_services/bcm2835-camera/mmal-vchiq.c      |   10 +-
 .../interface/vchi/connections/connection.h        |  324 --
 .../interface/vchi/message_drivers/message.h       |  196 --
 .../staging/vc04_services/interface/vchi/vchi.h    |  227 +-
 .../vc04_services/interface/vchi/vchi_cfg.h        |    2 +-
 .../interface/vchi/vchi_cfg_internal.h             |   71 -
 .../interface/vchiq_arm/vchiq_2835_arm.c           |    4 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |   35 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.h  |    5 +
 .../interface/vchiq_arm/vchiq_genversion           |   88 -
 .../vc04_services/interface/vchiq_arm/vchiq_shim.c |   38 +-
 drivers/staging/vt6655/rxtx.c                      |   29 +-
 drivers/staging/wilc1000/Kconfig                   |    8 +-
 drivers/staging/wilc1000/Makefile                  |    5 +-
 drivers/staging/wilc1000/coreconfigurator.c        |    4 +-
 drivers/staging/wilc1000/host_interface.c          |  277 +-
 drivers/staging/wilc1000/host_interface.h          |   19 +-
 drivers/staging/wilc1000/linux_mon.c               |    3 +-
 drivers/staging/wilc1000/linux_wlan.c              |  129 +-
 drivers/staging/wilc1000/wilc_debugfs.c            |  115 -
 drivers/staging/wilc1000/wilc_sdio.c               |   56 +-
 drivers/staging/wilc1000/wilc_spi.c                |   57 +-
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c  |  281 +-
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.h  |    4 +-
 drivers/staging/wilc1000/wilc_wfi_netdevice.h      |   55 +-
 drivers/staging/wilc1000/wilc_wlan.c               |  208 +-
 drivers/staging/wilc1000/wilc_wlan.h               |    8 +-
 drivers/staging/wilc1000/wilc_wlan_cfg.c           |  294 +-
 drivers/staging/wilc1000/wilc_wlan_cfg.h           |   26 +-
 drivers/staging/wilc1000/wilc_wlan_if.h            |    4 -
 drivers/staging/wlan-ng/cfg80211.c                 |   49 +-
 drivers/staging/wlan-ng/hfa384x_usb.c              |   46 +-
 drivers/staging/wlan-ng/p80211conv.c               |    2 +-
 drivers/staging/wlan-ng/p80211metadef.h            |  121 +-
 drivers/staging/wlan-ng/p80211metastruct.h         |    3 +-
 drivers/staging/wlan-ng/p80211netdev.c             |   12 +-
 drivers/staging/wlan-ng/p80211req.c                |   36 +-
 drivers/staging/wlan-ng/prism2fw.c                 |   37 +-
 drivers/staging/wlan-ng/prism2mib.c                |   76 +-
 drivers/staging/wlan-ng/prism2sta.c                |   86 +-
 include/dt-bindings/iio/qcom,spmi-vadc.h           |  125 +-
 include/linux/spi/spi.h                            |    2 +-
 488 files changed, 44091 insertions(+), 16531 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ltc1660.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/bh1750.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.txt
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
 delete mode 100644 Documentation/filesystems/pohmelfs/design_notes.txt
 delete mode 100644 Documentation/filesystems/pohmelfs/info.txt
 delete mode 100644 Documentation/filesystems/pohmelfs/network_protocol.txt
 create mode 100644 drivers/iio/accel/adxl372.c
 create mode 100644 drivers/iio/accel/adxl372.h
 create mode 100644 drivers/iio/accel/adxl372_i2c.c
 create mode 100644 drivers/iio/accel/adxl372_spi.c
 create mode 100644 drivers/iio/adc/mcp3911.c
 create mode 100644 drivers/iio/adc/qcom-spmi-adc5.c
 create mode 100644 drivers/iio/dac/ltc1660.c
 create mode 100644 drivers/iio/proximity/vl53l0x-i2c.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routes.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routes.h
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/README
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes.h
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes/all.h
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6220.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6221.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6229.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6251.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6254.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6259.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6534.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6602.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6713.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6723.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6733.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6030e.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6224.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6225.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6251.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6733.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxie-6251.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxie-6535.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxie-6738.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_route_values.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_route_values.h
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_route_values/all.h
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_route_values/ni_660x.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_route_values/ni_eseries.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/ni_route_values/ni_mseries.c
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/tools/.gitignore
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/tools/Makefile
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/tools/convert_c_to_py.c
 create mode 100755 drivers/staging/comedi/drivers/ni_routing/tools/convert_csv_to_c.py
 create mode 100755 drivers/staging/comedi/drivers/ni_routing/tools/convert_py_to_csv.py
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/tools/csv_collection.py
 create mode 100755 drivers/staging/comedi/drivers/ni_routing/tools/make_blank_csv.py
 create mode 100644 drivers/staging/comedi/drivers/ni_routing/tools/ni_names.py
 create mode 100644 drivers/staging/comedi/drivers/tests/Makefile
 create mode 100644 drivers/staging/comedi/drivers/tests/example_test.c
 create mode 100644 drivers/staging/comedi/drivers/tests/ni_routes_test.c
 create mode 100644 drivers/staging/comedi/drivers/tests/unittest.h
 delete mode 100644 drivers/staging/dgnc/Kconfig
 delete mode 100644 drivers/staging/dgnc/Makefile
 delete mode 100644 drivers/staging/dgnc/TODO
 delete mode 100644 drivers/staging/dgnc/dgnc_cls.c
 delete mode 100644 drivers/staging/dgnc/dgnc_cls.h
 delete mode 100644 drivers/staging/dgnc/dgnc_driver.c
 delete mode 100644 drivers/staging/dgnc/dgnc_driver.h
 delete mode 100644 drivers/staging/dgnc/dgnc_tty.c
 delete mode 100644 drivers/staging/dgnc/dgnc_tty.h
 delete mode 100644 drivers/staging/dgnc/digi.h
 rename drivers/staging/rtl8188eu/hal/{odm_HWConfig.c => odm_hwconfig.c} (83%)
 rename drivers/staging/rtl8188eu/include/{odm_HWConfig.h => odm_hwconfig.h} (100%)
 delete mode 100644 drivers/staging/rtl8188eu/include/odm_reg.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_qos.h
 delete mode 100644 drivers/staging/vc04_services/interface/vchi/connections/connection.h
 delete mode 100644 drivers/staging/vc04_services/interface/vchi/message_drivers/message.h
 delete mode 100644 drivers/staging/vc04_services/interface/vchi/vchi_cfg_internal.h
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_genversion
 delete mode 100644 drivers/staging/wilc1000/wilc_debugfs.c
