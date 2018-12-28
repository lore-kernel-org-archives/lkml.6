Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A7EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C95F2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546011339;
	bh=HWrSlYYcMu1dxVE+6KjO1FN8QF9HKz9AQ4RRjqBFslk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=buQMLzrgsGi9eXKayZ2VgsLXV23imVRA8zSYcg/UC4BdXgkfZza4Qig1il1uDgOh9
	 eIBj3a6kOHHElEts5L4dCU+MnHTXnUh2v5nuPEL/rgAuIlt22oAZnZzxjZ4VfJuyBN
	 pOLDLzu3tbp+iwcWvC62u5nVIRX3tZzvz8ogHQxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbeL1Pfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:35:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:52608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbeL1Pfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:35:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D690020869;
        Fri, 28 Dec 2018 15:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546011333;
        bh=HWrSlYYcMu1dxVE+6KjO1FN8QF9HKz9AQ4RRjqBFslk=;
        h=Date:From:To:Cc:Subject:From;
        b=rP5asG65H0q36frjfsJ7eK+m3TEGabKGqPrvRgbhCC7YEiNKdCaXopYHGRnDSutqX
         Npb8AkvyKB5tmupWT0EbB9YgbOCw/29HH+PMC4NJdz0e1tO2uyj7UWwntdyjBENEAg
         /EPHzmDzAAM5Ln/UqxxBrl38rOAoiIZm4XJlYoK4=
Date:   Fri, 28 Dec 2018 16:35:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Subject: [GIT PULL] Staging/IIO driver patches for 4.21-rc1
Message-ID: <20181228153531.GA23672@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-4.21-rc1

for you to fetch changes up to 215852f4b8bbf7a8d6a534dfb367bb0f1a2d5011:

  staging: mt7621-mmc: Correct spelling mistakes in comments (2018-12-20 18:11:58 +0100)

----------------------------------------------------------------
Staging/IIO driver patches for 4.21-rc1

Here is the big staging and iio driver pull request for 4.21-rc1.

Lots and lots of tiny patches here, nothing major at all.  Which is
good, tiny cleanups is nice to see.  No new huge driver removal or
addition, this release cycle, although there are lots of good IIO driver
changes, addtions, and movement from staging into the "real" part of the
kernel, which is always great.

Full details are in the shortlog, and all of these have been in
linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aaro Koskinen (2):
      staging: octeon-usb: use a helper function to set the DMA mask
      staging: octeon-ethernet: delete redundant include

Aaron Strahlberger (1):
      staging: erofs: Fix spelling issue

Adham Abozaeid (4):
      staging: wilc1000: remove unused flags in handle_cfg_param()
      staging: wilc1000: validate cfg parameters before scheduling the work
      staging: wilc1000: Don't keep a copy of wiphy parameters in the driver
      staging: wilc1000: Remove unused mutex cfg_values_lock

Ajay Singh (51):
      staging: wilc1000: refactor wilc_parse_network_info() using kernel framework api's
      staging: wilc1000: remove unused code in coreconfigurator
      staging: wilc1000: refactor get_bssid() function
      staging: wilc1000: avoid line over 80 chars in wilc_parse_network_info()
      staging: wilc1000: refactor wilc_parse_assoc_resp_info()
      staging: wilc1000: remove unnecessary MAX_STRING_LEN macro
      staging: wilc1000: remove coreconfigurator.c file
      staging: wilc1000: remove coreconfigurator.h file
      staging: wilc1000: update wilc1000 driver maintainer ids
      staging: wilc1000: use macro from ieee80211.h in register frame api's
      staging: wilc1000: use WLAN_PMKID_LEN macro from ieee80211.h header
      staging: wilc1000: remove unused macros and struct members in host_interface.h
      staging: wilc1000: move sdio_cmd52 & sdio_cmd53 struct to source file
      staging: wilc1000: use enum contants for mac status & added 'WILC_' prefix
      staging: wilc1000: restructure macros used to handle security type
      staging: wilc1000: use proper namespace for macros in wilc_wlan_if.h header
      staging: wilc1000: move current_tx_rate enum to wilc_wlan_if.h file
      staging: wilc1000: rename firmware related constants to follow better namespace
      staging: wilc1000: added 'WILC_' prefix for constants to have clear namespace
      staging: wilc1000: use ENOBUFS error code instead of WILC_TX_ERR_NO_BUF macro
      staging: wilc1000: rename tsf_hi element of network_info struct
      staging: wilc1000: remove unnecessary checks in wilc_mac_close()
      staging: wilc1000: make use of put_unaligned_le32 in handle_set_wfi_drv_handler()
      staging: wilc1000: avoid the use of the static variable to configure wiphy struct
      staging: wilc1000: use mutex lock to synchronized sending 'wid' cmd to firmware
      staging: wilc1000: handle tx power related callback from cfg80211 context
      staging: wilc1000: handle setting power management from cfg80211 context
      staging: wilc1000: handle add and edit station from the cfg80211 context
      staging: wilc1000: use void return for wilc_hif_pack_sta_param()
      staging: wilc1000: handle delete station related callback ops from cfg80211 context
      staging: wilc1000: use is_zero_ether_addr() API to check mac address
      staging: wilc1000: handle delete beacon cfg ops from cfg80211 context()
      staging: wilc1000: handle add beacon operation callback from cfg80211 context
      staging: wilc1000: handle mgmt_frame_register ops from cfg82011 context
      staging: wilc1000: refactor wilc_set_mac_chnl_num() to avoid deferred handling
      staging: wilc1000: refactor wilc_hif_set_cfg() to avoid deferred handling
      staging: wilc1000: handle station dump cfg ops from cfg80211 context
      staging: wilc1000: refactor wilc_set_operation_mode() to avoid deferred handling
      staging: wilc1000: refactor wilc_set_wfi_drv_handler() to avoid deferred handling
      staging: wilc1000: refactor wilc_get_inactive_time() to avoid deferred handling
      staging: wilc1000: handle key related cfg operation from cfg80211 context
      staging: wilc1000: delete the unused code after code refactor
      staging: wilc1000: refactor wilc_get_mac_address() to avoid deferred handling
      staging: wilc1000: use correct 'struct remain_ch' variable in scan complete
      staging: wilc1000: handle remain on channel cfg ops from cfg80211 context
      staging: wilc1000: handle get_station() ops callback in cfg80211 context
      staging: wilc1000: avoid deferred handling of cfg80211 disconnect callback
      staging: wilc1000: handle connect ops callback from cfg80211 context
      staging: wilc1000: avoid extra buffer copy while connect cfg ops
      staging: wilc1000: handle scan operation callback from cfg80211 context
      staging: wilc1000: fix NULL dereference inside wilc_scan()

Alexandru Ardelean (2):
      staging: iio: ad5933: rename ext_clk_Hz -> ext_clk_hz
      staging:iio:ad2s90: Add max frequency check at probe

Alexey Skidanov (1):
      staging: android: ion: Add per-heap counters

Amir Mahdi Ghorbanian (1):
      Staging: comedi: cb_pcidas: fixed a spelling mistake coding style issue

Andi Shyti (1):
      iio: core: check 'info' value before registering the device

André Almeida (2):
      staging: vchi: change type 'int32_t' to 's32'
      staging: vchi: Add SPDX-License-Identifier

Arnd Bergmann (5):
      staging: speakup: change semaphore to completion
      staging: rtl8723bs: change semaphores to completions
      staging: rtl8723bs: change pwrctrl lock to a mutex
      staging: rtl8723bs: remove semaphore remnants
      staging: vchiq: rework remove_event handling

Bhagyashri P. Dighole (2):
      staging: erofs: Modify coding style alignments
      staging: erofs: Modify conditional checks

Bhanusree Pola (1):
      Staging: rtlwifi: Remove Unneeded funition halbtc_get_wifi_rssi()

Carmeli Tamir (3):
      staging: emxx_udc: Added static modifier to udc_controller
      staging: emxx_udc: Added missing __iomem modifier to handle p_regs
      staging: emxx_udc: Added missing le16_to_cpu conversions

Charles-Antoine Couret (4):
      iio:adc:ad7949: Add AD7949 ADC driver family
      dt-bindings: iio: adc: Add AD7949 device tree bindings in documentation
      iio:dac:ti-dac7311 Add driver for Texas Instrument DAC7311
      dt-bindings: iio: dac: Add ti,dac7311 device tree bindings in documentation

Chris Coffey (2):
      dt-bindings: iio: potentiometer: Add Microchip MCP41xxx/42xxx
      iio: potentiometer: Add driver for Microchip MCP41xxx/42xxx

Christian Gromm (6):
      staging: most: sound: create one sound card w/ multiple PCM devices per MOST device
      staging: most: sound: correct label name
      staging: most: sound: rename variable
      staging: most: sound: use static name for ALSA card
      staging: most: sound: remove channel number from ALSA card's long name
      staging: most: Documentation: add information to driver_usage file

Chuanhong Guo (2):
      staging: mt7621-spi: drop the broken full-duplex mode
      staging: mt7621-spi: drop support for SPI mode 1/2/3

Colin Ian King (15):
      iio: adc: ina2xx: add in early -EINVAL returns in case statements
      staging: rtl8188eu: fix typo in function name rtw_sctx_chk_waring_status
      staging: rtl8723bs: fix typo in function name rtw_sctx_chk_waring_status
      drivers: staging: rtl*: fix spelling mistake "Orginial" -> "Original"
      staging: xgifb: clean an indentation issue
      staging: speakup: clean up few indentation issues
      staging: rtl8192u: rename struct name _rt_firmare_seg_container
      media: staging: tegra-vde: print long unsigned using %lu format specifier
      iio: hid-sensor-hub: clean up indentation, remove extraneous tab
      staging: speakup: i18n: fix spelling mistake "phoneticly" -> "phonetically"
      staging: rtl8188eu: fix spelling mistake "inferface" -> "interface"
      staging: rtlwifi: fix spelling mistake "disnabled" -> "disabled"
      staging: comedi: fix spelling mistake "desination" -> "destination"
      staging: most: sound: replace snprintf with strscpy
      staging: wilc1000: fix missing read_write setting when reading data

Cristian Sicilia (12):
      staging: rtlwifi: Modified the line ending with a parenthesis
      staging: rtlwifi: SET_RATE_ID inline no arg reuse
      staging: rtlwifi: Add spaces to match open parenthesis
      staging: rtlwifi: Add new line to stay in 80 characters
      staging: axis-fifo: Split line to stay in 80 characters.
      staging: emxx_udc: Fixing function naming
      staging: erofs: unzip_vle.c: Replace comparison to NULL.
      staging: erofs: unzip_vle.c: Constant in comparison on right side
      staging: erofs: unzip_vle.c: Align parameter to the parentesis
      staging: greybus: Parenthesis alignment
      staging: emxx_udc: Remove cast and move all in one line.
      staging: greybus: Added space between string concatenated

Dan Carpenter (1):
      staging: bcm2835-audio: double free in init error path

Dan O'Donovan (1):
      iio: adc128s052: use SPDX-License-Identifier

Daniel Bovensiepen (1):
      staging: android: ashmem: doc: Fix spelling

Dominic Braun (33):
      staging: vc04_services: Remove DUMP_CONTEXT_T typedef
      staging: vc04_services: Remove PAGELIST_T typedef
      staging: vc04_services: Remove REMOTE_EVENT_T typedef
      staging: vc04_services: Remove SERVICE_CREATION_T typedef
      staging: vc04_services: Remove USER_SERVICE_T typedef
      staging: vc04_services: Remove VCHI_HELD_MSG_T typedef
      staging: vc04_services: Remove VCHI_MSG_ITER_T typedef
      staging: vc04_services: Remove VCHI_MSG_VECTOR_T typedef
      staging: vc04_services: Remove VCHIQ_ARM_STATE_T typedef
      staging: vc04_services: Remove VCHIQ_AWAIT_COMPLETION_T typedef
      staging: vc04_services: Remove VCHIQ_BULK_QUEUE_T typedef
      staging: vc04_services: Remove VCHIQ_BULK_T typedef
      staging: vc04_services: Remove VCHIQ_COMPLETION_DATA_T typedef
      staging: vc04_services: Remove VCHIQ_CONFIG_T typedef
      staging: vc04_services: Remove VCHIQ_CREATE_SERVICE_T typedef
      staging: vc04_services: Remove VCHIQ_DEBUGFS_NODE_T typedef
      staging: vc04_services: Remove VCHIQ_DEQUEUE_MESSAGE_T typedef
      staging: vc04_services: Remove VCHIQ_DUMP_MEM_T typedef
      staging: vc04_services: Remove VCHIQ_GET_CONFIG_T typedef
      staging: vc04_services: Remove VCHIQ_HEADER_T typedef
      staging: vc04_services: Remove VCHIQ_QUEUE_BULK_TRANSFER_T typedef
      staging: vc04_services: Remove VCHIQ_QUEUE_MESSAGE_T typedef
      staging: vc04_services: Remove VCHIQ_SERVICE_BASE_T typedef
      staging: vc04_services: Remove VCHIQ_SERVICE_PARAMS_T typedef
      staging: vc04_services: Remove VCHIQ_SERVICE_QUOTA_T typedef
      staging: vc04_services: Remove VCHIQ_SERVICE_T typedef
      staging: vc04_services: Remove VCHIQ_SET_SERVICE_OPTION_T typedef
      staging: vc04_services: Remove VCHIQ_SHARED_STATE_T typedef
      staging: vc04_services: Remove VCHIQ_SLOT_INFO_T typedef
      staging: vc04_services: Remove VCHIQ_SLOT_T typedef
      staging: vc04_services: Remove VCHIQ_SLOT_ZERO_T
      staging: vc04_services: Remove VCHIQ_STATE_T typedef
      staging: vc04_services: Remove VCHIU_QUEUE_T typedef

Evan Green (1):
      iio: adc: qcom-spmi-adc5: Initialize prescale properly

Fabrice Gasnier (3):
      iio: adc: stm32-adc: move self-calibration to prepare routine
      iio: adc: stm32-adc: add power management support
      iio: adc: stm32-adc: switch off running adc when going to low power

Freeman Liu (1):
      iio: adc: sc27xx: Add ADC data conversion timeout

Gao Xiang (25):
      staging: erofs: remove the redundant d_rehash() for the root dentry
      staging: erofs: use the new LZ4_decompress_safe_partial()
      staging: erofs: fix undefined LZ4_decompress_safe_partial()
      staging: erofs: fix `trace_erofs_readpage' position
      staging: erofs: fix the definition of DBG_BUGON
      staging: erofs: fix race when the managed cache is enabled
      staging: erofs: atomic_cond_read_relaxed on ref-locked workgroup
      staging: erofs: fix `erofs_workgroup_{try_to_freeze, unfreeze}'
      staging: erofs: add a full barrier in erofs_workgroup_unfreeze
      staging: erofs: separate into init_once / always
      staging: erofs: locked before registering for all new workgroups
      staging: erofs: decompress asynchronously if PG_readahead page at first
      staging: erofs: rename strange variable names in z_erofs_vle_frontend
      staging: erofs: {dir,inode,super}.c: rectify BUG_ONs
      staging: erofs: update erofs-utils information in TODO
      staging: erofs: fix use-after-free of on-stack `z_erofs_vle_unzip_io'
      staging: erofs: introduce MNGD_MAPPING helper
      staging: erofs: localize UNALLOCATED_CACHED_PAGE placeholder
      staging: erofs: revisit the page submission flow
      staging: erofs: refine compressed pages preload flow
      staging: erofs: redefine where `owned_workgrp_t' points
      staging: erofs: simplify `z_erofs_vle_submit_all'
      staging: erofs: unzip_{pagevec.h,vle.c}: rectify BUG_ONs
      staging: erofs: unzip_vle_lz4.c,utils.c: rectify BUG_ONs
      staging: erofs: remove __EROFS_BIT

Giuliano Belinassi (2):
      staging: iio: ad7780: check if ad778x before gain update
      staging: iio: ad7780: generates pattern_mask from PAT bits

Greg Kroah-Hartman (6):
      Revert "staging: greybus: remove multiple blank lines"
      Revert "staging: greybus: remove extra space before tab"
      Merge tag 'iio-for-4.21a' of git://git.kernel.org/.../jic23/iio into staging-testing
      Merge 4.20-rc5 into staging-next
      Merge 4.20-rc6 into staging-next
      Merge tag 'iio-for-4.21b' of git://git.kernel.org/.../jic23/iio into staging-next

Gustavo A. R. Silva (1):
      iio: dpot-dac: mark expected switch fall-through with text GCC expects.

Hans de Goede (14):
      iio: accel: kxcjk1013: Add KIOX0009 ACPI Hardware-ID
      staging: vboxvideo: Stop accessing crtc_state->active
      staging: vboxvideo: Keep old mode when disable crtc
      staging: vboxvideo: Drop duplicate vbox_err.h file
      staging: vboxvideo: Cleanup the comments
      staging: vboxvideo: Change licence headers over to SPDX
      staging: vboxvideo: Stop disabling/enabling accel support on master set / drop
      staging: vboxvideo: Cleanup header use
      staging: vboxvideo: Use PCI_DEVICE() for our pci_id table
      staging: vboxvideo: Fixup some #ifdef-s
      staging: vboxvideo: Add myself as MODULE_AUTHOR
      staging: vboxvideo: Drop DRM_MODE_FB_CMD define
      staging: vboxvideo: Use DRM_FB_HELPER_DEFAULT_OPS
      iio: accel: kxcjk1013: Add KIOX010A ACPI Hardware-ID

Hardik Singh Rathore (1):
      Staging: rtl8723bs: Fix code style issue in rtl8723bs driver

Heiko Stuebner (1):
      iio: st-accel: add support for lis3de

Ian Abbott (6):
      staging: comedi: cb_pcidas64: Use insn->n in AO insn_write handler
      staging: comedi: cb_pcidas64: Use insn->n in EEPROM insn_read handler
      staging: comedi: Check length of INSN_CONFIG_TIMER_1 instruction
      staging: comedi: addi_apci_3501: Use insn->n in EEPROM insn_read handler
      staging: comedi: cb_pcidda: Use insn->n in AO insn_write handler
      staging: comedi: ni_labpc_common: Use insn->n in AO insn_write handler

Ioannis Valasakis (20):
      staging: octeon: Fix style issues
      staging: bcm2048: add SPDX License Identifier
      staging: speakup: add spaces around minus
      staging: speakup: move arguments to reduce 80 chars limit
      staging: speakup: move arguments to adhere to 80 chars
      staging: tegravde: replace bit assignment with macro
      staging: davinci: remove FSF mail address from copyright
      staging: davinci: add SPDX License Identifier
      staging: greybus: shorten comparison to NULL
      staging: greybus: align parameters to parentheses
      staging: greybus: fix SPDX License Identifier
      staging: greybus: align arguments with parentheses
      staging: greybus: correct SPDX License Identifier
      staging: greybus: remove multiple blank lines
      staging: greybus: remove space before tab
      staging: greybus: remove multiple blank lines
      staging: greybus: add extra space around OR operator
      staging: greybus: remove extra space before tab
      staging: greybus: remove comparison to BOOL
      staging: greybus: remove unmatched right bracket

Irenge Jules Bashizi (2):
      staging: davinci_vpfe: Change to !format
      staging: davinci_vpfe: Remove multiple blank space

Javier Arteaga (1):
      iio: adc128s052: Add pin-compatible IDs

Jeeeun Evans (1):
      staging: ks7010: remove unnecessary blank line

Jeremy Fertic (1):
      Revert "Staging: iio: adt7316: Add an extra check for 'ret' equals to 0"

Jiri Olsa (1):
      tools iio: Override CFLAGS assignments

Jona Crasselt (6):
      mt7621-mmc: Fix some coding style issues
      mt7621-mmc: Removed unnecessary blank lines
      mt7621-mmc: Alignment should match open parenthesis
      mt7621-mmc: return statement in void function unnecessary
      mt7621-mmc: char * array declaration might be better as static const
      staging: mt7621-mmc: Correct spelling mistakes in comments

Jonathan Bakker (3):
      iio: adc: exynos-adc: Add S5PV210 variant
      iio: adc: Allow selection of Exynos ADC on S5PV210
      dt-bindings: iio: adc: exynos-adc: Add S5PV210 variant

Josenivaldo Benito Jr (1):
      staging: rtl8723bs: Correct errors from checkpatch

Kim Bradley (2):
      Staging: rts5208: Add SPDX license tags
      Staging: rts5208: Capitalise preprocessor variable names

Kimberly Brown (8):
      staging: gasket: use sizeof(*p) for memory allocation
      staging: mt7621-dma: Add braces around else branches
      staging: xgifb: vb_setmode: fix multiple line dereference
      staging: xgifb: vb_setmode: adjust descendant indentation to right
      staging: rtl8723bs: core: remove unnecessary blank lines
      staging: rtl8192u: Fix misspelling in struct member name - Style
      staging: rtl8192u: Fix misspelling in variable name - Style
      staging: rtl8192u: Fix misspellings in comments - Style

Kuninori Morimoto (3):
      iio: adc: max9611: convert to SPDX identifiers
      iio: adc: max11100: convert to SPDX identifiers
      iio: adc: rcar-gyroadc: convert to SPDX identifiers

Lars-Peter Clausen (1):
      iio: ad_sigma_delta: Allow to provide custom data register address

Laís Pessine do Carmo (1):
      staging: sm750fb: Add spaces around '+'

Lorenzo Bianconi (12):
      iio: imu: st_lsm6dsx: introduce locked read/write utility routines
      iio: imu: st_lsm6dsx: reload trimming parameter at bootstrap
      iio: imu: st_lsm6dsx: remove static from st_lsm6dsx_set_watermark
      iio: imu: st_lsm6dsx: introduce ST_LSM6DSX_ID_EXT sensor ids
      iio: imu: st_lsm6dsx: introduce st_lsm6dsx_sensor_set_enable routine
      iio: imu: st_lsm6dsx: add i2c embedded controller support
      iio: imu: st_lsm6dsx: add st_lsm6dsx_push_tagged_data routine
      iio: imu: st_lsm6dsx: add hw FIFO support to i2c controller
      dt-bindings: iio: imu: st_lsm6dsx: add support to i2c pullup resistors
      iio: imu: st_lsm6dsx: add entry in MAINTAINERS file
      iio: imu: st_lsm6dsx: do not use a fixed read len in read_oneshot
      iio: humidity: hts221: add entry in MAINTAINERS file

Lou Knauer (1):
      staging: mt7621-dma: fix unbalanced braces

Lubomir Rintel (1):
      dt-bindings: iio: accel: use a generic node name for lis302

Marcelo Schmitt (2):
      Staging:iio:adc:ad7606: Match parenthesis alignment
      staging: iio: ad5933: add device tree support

Marco Wang (1):
      Staging: comedi: dt9812: fixed a typo in comment.

Marek Vasut (1):
      iio: adc: Fix Renesas GyroADC MAINTAINERS entry

Martin Blumenstingl (3):
      dt-bindings: iio: adc: meson-saradc: add temperature sensor support
      iio: adc: meson-saradc: add support for the chip's temperature sensor
      iio: adc: meson-saradc: fix internal clock names

Martin Kelly (6):
      iio: st_sensors: miscellaneous cleanup
      iio: magnetometer: add clarifying comment
      iio:magnetometer: st_magn: add LSM9DS1 support
      iio:magnetometer: st_magn: add BDU settings
      dt-bindings: iio: magn: add LSM9DS1 bindings
      iio: bmi160: use all devm functions in probe

Matheus Tavares (11):
      staging: iio: ad2s1210: fix 'assignment operator' style checks
      staging:iio:ad2s90: Make read_raw return spi_read's error code
      staging:iio:ad2s90: Make probe handle spi_setup failure
      staging:iio:ad2s90: Remove always overwritten assignment
      staging:iio:ad2s90: Move device registration to the end of probe
      staging:iio:ad2s90: Check channel type at read_raw
      staging:iio:ad2s90: Add device tree support
      staging:iio:ad2s90: Remove spi setup that should be done via dt
      dt-bindings:iio:resolver: Add docs for ad2s90
      staging:iio:ad2s90: Replace license text w/ SPDX identifier
      staging:iio:ad2s90: Move out of staging

Matt Ranostay (2):
      iio: potentiometer: tpl0102: switch to using pointer to chip config
      iio: potentiometer: tpl0102: add IIO_AVAIL_RANGE support

Maya Nakamura (9):
      staging: rtlwifi: Remove function that only returns the second argument
      staging: rtlwifi: Remove function that only returns zero
      staging: rtlwifi: Remove unused functions
      staging: rtlwifi: Replace 1 with true and remove comparison for bool
      staging: rtlwifi: Remove unnecessary conditions
      staging: rtlwifi: Keep expressions on one line
      staging: rtlwifi: Improve line endings
      staging: rtlwifi: Remove empty comment
      staging: rtlwifi: Add spaces for comments

Michael Straube (82):
      staging: rtl8188eu: simplify odm_evm_db_to_percentage()
      staging: rtl8188eu: rename variable Max_spatial_stream - style
      staging: rtl8188eu: rename variable isCCKrate - style
      staging: rtl8188eu: change type of is_cck_rate - style
      staging: rtl8188eu: remove unnecessary ternary operator
      staging: rtl8188eu: change type of a struct field
      staging: rtl8188eu: change return type of rtl8188eu_xmitframe_complete()
      staging: rtl8188eu: change return type of rtw_hal_xmit()
      staging: rtl8188eu: cleanup long line in rtw_hal_xmit()
      staging: rtl8188eu: use __func__ in recv_linux.c
      staging: rtl8188eu: add spaces around '*' in recv_linux.c
      staging: rtl8188eu: remove unnecessary parentheses in recv_linux.c
      staging: pi433: remove GPL boiler plate text
      staging: rtl8188eu: remove unnecessary parentheses in rtl8188eu_led.c
      staging: rtl8188eu: cleanup comments in rtl8188eu_led.c
      staging: rtl8188eu: add spaces around '&' in rtl8188eu_led.c
      staging: rtl8188eu: rename LedCfg to avoid CamelCase
      staging: rtl8188eu: rename SwLedOn to avoid CamelCase
      staging: rtl8188eu: rename SwLedOff to avoid CamelCase
      staging: rtl8188eu: rename BlinkHandler to avoid CamelCase
      staging: rtl8188eu: cleanup a function comment
      staging: rtl8188eu: rename LedControl8188eu to avoid CamelCase
      staging: rtl8188eu: rename SwLed0 to avoid CamelCase
      staging: rtl8188eu: use __func__ in usb_ops_linux.c
      staging: rtl8188eu: cleanup line ending with a '('
      staging: rtl8188eu: remove braces from single if else statement
      staging: rtl8188eu: correct spelling mistake in a comment
      staging: rtl8188eu: remove unnecessary parentheses
      staging: rtl8188eu: add spaces around '>>' and '&'
      staging: rtl8188eu: cleanup declarations in usb_ops_linux.c
      staging: rtl8188eu: remove variable from rtl8188eu_xmit_tasklet()
      staging: rtl8188eu: cleanup remaining comparsions to true
      staging: rtl8188eu: remove unnecessary parentheses in rtw_mlme.c
      staging: rtl8188eu: use __func__ in rtw_mlme.c
      staging: rtl8188eu: remove rtw_android_set_block()
      staging: rtl8188eu: cleanup declarations in rtw_mlme.c
      staging: rtl8188eu: refactor if else statement
      staging: rtl8188eu: remove return from void function
      staging: rtl8188eu: correct indentation
      staging: rtl8188eu: cleanup lines over 80 characters
      staging: pi433: fix potential null dereference
      staging: pi433: add missing call to cdev_del()
      staging: rtl8188eu: use __func__ in hal8188e_rate_adaptive.c
      staging: rtl8188eu: remove parentheses in hal8188e_rate_adaptive.c
      staging: rtl8188eu: add spaces around operators in hal8188e_rate_adaptive.c
      staging: rtl8188eu: cleanup lines ending with '('
      staging: rtl8188eu: cleanup alignment issues in hal8188e_rate_adaptive.c
      staging: rtl8188eu: cleanup comment in hal8188e_rate_adaptive.c
      staging: wilc1000: correct inconsistent indenting
      staging: rtl8188eu: refactor cckrates_included()
      staging: rtl8188eu: refactor cckratesonly_included()
      staging: rtl8188eu: simplify array initializations
      staging: rtl8188eu: remove unnecessary parentheses in rtw_wlan_util.c
      staging: rtl8188eu: cleanup declarations in rtw_wlan_util.c
      staging: rtl8188eu: cleanup block comment in rtw_wlan_util.c
      staging: rtl8188eu: cleanup long lines in rtw_wlan_util.c
      staging: rtl8188eu: add spaces around operators in rtw_wlan_util.c
      staging: rtl8188eu: write out multiplying in wifirate2_ratetbl_inx()
      staging: rtl8188eu: replace if else with ternary operator
      staging: rtl8188eu: rename struct field Wifi_Error_Status
      staging: rtl8188eu: remove unused code in rtw_cmd.c
      staging: rtl8188eu: simplify loop in rtl88eu_phy_iq_calibrate()
      staging: rtl8188eu: reuse Hal_GetChnlGroup88E()
      staging: rtl8723bs: remove dead code, rtw_port_switch_chk()
      staging: rtl8723bs: fix typo in the TODO file
      staging: rtl8188eu: cleanup declarations in rtw_mlme_ext.c
      staging: rtl8188eu: replace tabs with spaces in rtw_mlme_ext.c
      staging: rtl8188eu: remove commented declarations in rtw_mlme_ext.c
      staging: rtl8188eu: remove blank lines between declarations
      staging: rtl8188eu: add blank line after declarations
      staging: rtl8188eu: remove unnecessary comments in rtw_mlme_ext.c
      staging: rtl8188eu: remove unnecessary parentheses in rtw_mlme_ext.c
      staging: rtl8188eu: remove unused arrays WFD_OUI and WMM_INFO_OUI
      staging: rtl8188eu: remove redundant declaration in rtw_mlme_ext.c
      staging: rtl8188eu: convert unsigned char arrays to u8
      staging: rtl8188eu: constify some arrays
      staging: rtl8188eu: make some arrays static in rtw_mlme_ext.c
      staging: rtl8188eu: change order of declarations to improve readability
      staging: rtl8188eu: simplify null array initializations
      staging: rtl8188eu: change return type of is_basicrate() to bool
      staging: rtl8188eu: add spaces around '&' in rtw_mlme_ext.c
      staging: rtl8188eu: cleanup brace coding style issues

Michelle Darcy (1):
      staging: davinci_vpfe: Align brackets to open parentheses

Mike Brady (1):
      staging: bcm2835-audio: interpolate audio delay

Mircea Caprioru (1):
      iio: dac: ad5686: fix bit shift read register

NeilBrown (7):
      staging: mt7621-eth: set correct dma mask.
      staging: mt7621-mmc: set correct dma mask.
      staging: mt7621-dts: allow gnubee to reboot cleanly.
      staging: mt7621-eth: fix compile warning.
      staging: mt7621-mmc: add missing header.
      staging: mt7621-mmc: fix compile warnging: cmd_buf
      staging: mt7621-dts: avoid warnings in pinctrl definitions

Nicholas Mc Guire (2):
      iio: adc: meson-saradc: check for devm_kasprintf failure
      staging: iio: adc: ad7280a: check for devm_kasprint() failure

Nicola Lunghi (1):
      iio: adc128s052: add ACPI _HID AANT1280

Nicolas Saenz Julienne (26):
      staging: bcm2835-audio: unify FOURCC command definitions
      staging: bcm2835-audio: don't initialize memory twice
      staging: bcm2835-audio: reorder variable declarations & remove trivial comments
      staging: bcm2835-audio: use anonymous union in struct vc_audio_msg
      staging: bcm2835-audio: more generic probe function name
      staging: bcm2835-audio: rename platform_driver structure
      staging: bcm2835-audio: update TODO
      staging: vchiq_core: rework vchiq_get_config
      staging: vchiq_arm: rework close/remove_service IOCTLS
      staging: vchiq_shim: delete vchi_service_create
      staging: vchiq_arm: use list_for_each_entry when accessing bulk_waiter_list
      staging: vchiq_arm: get rid of vchi_mh.h
      staging: vchiq_arm: rework vchiq_ioc_copy_element_data
      staging: vchiq-core: get rid of is_master distinction
      staging: vchiq_core: remove unnecessary safety checks in vchiq_init_state
      staging: vchiq_core: do not initialize semaphores twice
      staging: vchiq_core: don't add a wmb() before remote_event_signal()
      staging: vchiq: use completions instead of semaphores
      staging: vchiq_util: get rid of unneeded memory barriers
      staging: vchiq_core: fix logic redundancy in parse_open
      staging: vchiq_arm: rework probe and init functions
      staging: vchiq_arm: fix open/release cdev functions
      staging: vchiq: add more tasks to the TODO list
      staging: vchiq: switch to wait_for_completion_killable
      staging: vchiq_2835_arm: quit using custom down_interruptible()
      staging: vchiq: delete vchiq_killable.h

Nishad Kamdar (9):
      staging: iio: ad7816: Switch to the gpio descriptor interface
      staging: olpc_dcon: olpc_dcon_xo_1.c: Switch to the gpio descriptor interface
      staging: iio: ad2s1210: Switch to the gpio descriptor interface
      staging: iio: ad2s1210: Drop the gpioin flag.
      staging: iio: ad2s1210: Add device tree table.
      staging: iio: ad7816: Do not use busy_pin in case of AD7818
      staging: iio: ad7816: Set RD/WR pin and CONVST pin as outputs.
      staging: iio: ad7816: Add device tree table.
      staging: mt7621-mmc: Fix incompletely removed #if 0 block in sd.c

Nícolas F. R. A. Prado (1):
      staging: mt7621-mmc: Add blank line after declaration

Parthiban Nallathambi (2):
      iio: light: Add support for vishay vcnl4035
      iio: light: Add device tree binding for vishay vcnl4035

Rasmus Villemoes (1):
      staging: greybus: loopback.c: remove unused lists

Renato Lui Geh (4):
      staging: iio: adt7316: fix parenthesis alignment
      staging: iio: ad7780: fix offset read value
      staging: iio: ad7780: update voltage on read
      staging: iio: ad7780: remove unnecessary stashed voltage value

Ricardo Reis Marques Silva (1):
      staging: vboxvideo: Rename uint32_t type to u32

Ricardo Silva (1):
      staging: rb8822be Change line not to end with '('

Robert Deal (1):
      staging: gasket: formatting fixes

Robert Eshleman (1):
      staging: rtl8712: fix CamelCase in fw_priv struct

Rohit Sarkar (2):
      staging: goldfish: Add SPDX license identifier.
      staging: wlan-ng: Fix a typo.

Sergio Paracuellos (40):
      staging: mt7621-pci: parse and init port data from device tree
      staging: mt7621-pci: replace return value if devm_pci_alloc_host_bridge call fails
      staging: mt7621-pci: add two helpers for read and write pcie register ports
      staging: mt7621-pci: factor out 'mt7621_pcie_enable_port' function
      staging: mt7621-pci: remove [ASSERT|DEASSERT]_SYSRST_PCIE macros
      staging: mt7621-pci: remove GPL2+ text from license header
      staging: mt7621-pci: remove two commented code lines
      staging: mt7621-pci: remove reset related unused macros
      staging: mt7621-pci: reagroup reset related macros all together
      staging: mt7621-pci: rewrite pcie phy related functions
      staging: mt7621-pci: factor out 'mt7621_enable_phy' function
      staging: mt7621-pci: debug port N_FTS inside 'mt7621_pcie_enable_port'
      staging: mt7621-pci: rename 'mt7621_pcie_enable_port' into 'mt7621_pcie_init_port'
      staging: mt7621-dts: add sysctl registers base address to pcie
      staging: mt7621-pci: remap and use sysctl from device tree
      staging: mt7621-pci: use a trailing */ on a separate line
      staging: mt7621-pci: use dev_* functions instead of printk
      staging: mt7621-pci: factor out 'mt7621_pcie_enable_ports' function
      staging: mt7621-pci: avoid use of global variable 'pcie_link_status'
      staging: mt7621-pci: factor out 'mt7621_pcie_init_ports' function
      staging: mt7621-pci: remove unused preprocessor definitions
      staging: mt7621-pci: reorder preprocessor definitions
      staging: mt7621-pci: remove non sense comment
      staging: mt7621-pci: align function definition style along the code
      staging: mt7621-pci: rewrite RC FTS configuration
      staging: mt7621-pci: rewrite hardcoded code for enabling ports
      staging: mt7621-pci: add some definitions for enabling and disabling GEN and GEN1 clocks
      staging: mt7621-pci: use PERST_N instead of gpio control
      staging: mt7621-pci: use PCIE_PORT_LINKUP instead of hardcode value
      staging: mt7621-pci: enable interrupt when port is being enabled
      staging: mt7621-pci: factor out 'mt7621_pcie_enable_port' function
      staging: mt7621-pci: move some code into 'mt7621_pcie_init_ports'
      staging: mt7621-pci: replace 'mdelay()' with 'msleep()'
      staging: mt7621-pci: dt-bindings: add dt bindings for mt7621 pcie controller
      staging: mt7621-pci: avoid mapping sysctls registers
      staging: mt7621-dts: remove sysctl registers from pcie bindings
      staging: mt7621-pci: dt-bindings: update bindings doc removing sysctls registers
      staging: mt7621-pci: fix reset lines for each pcie port
      staging: mt7621-pci: avoid using clk_* operations
      staging: mt7621-pci: add comment clarifying inverted reset lines

Shayenne da Luz Moura (1):
      staging: vboxvideo: Remove unnecessary parentheses

Shreeya Patel (6):
      Staging: iio: adt7316: Fix i2c data reading, set the data field
      Staging: iio: adt7316: Add an extra check for 'ret' equals to 0
      Staging: iio: adt7316: Add of_device_id table
      Staging: iio: adt7316: Use device tree data to set ldac_pin
      Staging: iio: adt7316: Switch irq_flags to a local variable
      Staging: iio: adt7316: Change the name from irq_flags to irq_type

Slawomir Stepien (9):
      staging: iio: cdc: ad7150: use value copy to shorten the line length
      staging: iio: cdc: ad7150: fix misaligned lines
      staging: iio: adc: ad7280a: handle error from __ad7280_read32()
      staging: iio: adc: ad7280a: use crc8.h API to build crc table
      staging: iio: adc: ad7280a: don't cast type inside switch expression
      staging: iio: adc: ad7280a: power down the device on error in probe
      staging: iio: adc: ad7280a: use devm_* APIs
      iio: potentiometer: mcp4131: use of_device_get_match_data()
      staging: iio: adc: ad7280a: fix overwrite of the returned value

Song Qiang (3):
      dt-bindings: Add PNI to the vendor prefixes
      iio: magnetometer: Add DT support for PNI RM3100
      iio: magnetometer: Add driver support for PNI RM3100

Spencer E. Olson (1):
      staging: comedi: change do_insn*_ioctl to allow more samples

Stefan Popa (4):
      dt-bindings: iio: adc: Add common ADCs properties to a separate file
      iio: adc: Add ad7124 support
      dt-bindings: iio: adc: Add docs for ad7124
      iio:dac:ad5686: Add AD5310R support

Stefan Wahren (10):
      staging: bcm2835-camera: Abort probe if there is no camera
      staging: bcm2835-camera: fix module autoloading
      staging: bcm2835-camera: Move module info to the end
      staging: vchiq_arm: Fix camera device registration
      staging: vchiq_arm: Register a platform device for audio
      staging: bcm2835-audio: Enable compile test
      staging: bcm2835-audio: use module_platform_driver() macro
      staging: bcm2835-audio: Drop DT dependency
      staging: bcm2835-camera: Provide more specific probe error messages
      staging: bcm2835-camera: Add hint about possible faulty config

Stephan Gerhold (2):
      iio: accel: kxcjk-1013: Add the "KXJ2109" ACPI HID
      iio: magnetometer: ak8975: Add the "AKM9911" ACPI HID

Stephen Davies (2):
      staging: comedi: drivers: Cleanup malformed license identifier
      staging: comedi: drivers: Cleanup malformed licence identifier

Szilveszter Székely (1):
      staging: vchiq_arm: add __user pointer annotations

Tim Collier (3):
      staging: wlan-ng: formatting change in cfg80211.c
      staging: wlan-ng: reformatting in prism2mib.c to fit 80 character limit
      staging: wlan-ng: remove unused variable in prism2fw.c

Uwe Kleine-König (1):
      iio: ssp_sensors: don't manually free devm managed resources

Victor Colombo (4):
      staging: iio: ad5933: Remove unnecessary space on casting
      staging: iio: ad5933: Remove unnecessary blank line
      staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to channel spec and read_raw
      staging:iio:ad2s90: Add comment to device state mutex

Wen Yang (1):
      staging: rtl8723bs: remove redundant null check on pregpriv

Yangtao Li (8):
      staging: rtl8723bs: fix small typo
      Staging: rtl8712: fix small typo
      staging: vt6655: fix small typo
      staging: android: ion: Remove unused header files
      staging: fwserial: convert to DEFINE_SHOW_ATTRIBUTE
      staging: unisys: convert to DEFINE_SHOW_ATTRIBUTE
      staging: vc04_services: convert to DEFINE_SHOW_ATTRIBUTE
      staging: greybus: convert to DEFINE_SHOW_ATTRIBUTE

YueHaibing (1):
      staging: fbtft: fix strncmp() size warning

Zach Turner (2):
      staging: rtl8192e: add braces to if statement - style
      staging: rtl8192e: Add SPDX-License-Identifier - Style

 .../devicetree/bindings/iio/accel/lis302.txt       |    4 +-
 .../devicetree/bindings/iio/adc/ad7949.txt         |   16 +
 Documentation/devicetree/bindings/iio/adc/adc.txt  |   23 +
 .../devicetree/bindings/iio/adc/adi,ad7124.txt     |   75 +
 .../bindings/iio/adc/amlogic,meson-saradc.txt      |    6 +
 .../bindings/iio/adc/samsung,exynos-adc.txt        |    4 +-
 .../devicetree/bindings/iio/adc/ti-adc128s052.txt  |    9 +-
 .../devicetree/bindings/iio/dac/ti,dac7311.txt     |   23 +
 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |    1 +
 .../devicetree/bindings/iio/light/vcnl4035.txt     |   18 +
 .../bindings/iio/magnetometer/pni,rm3100.txt       |   20 +
 .../bindings/iio/potentiometer/mcp41010.txt        |   28 +
 .../devicetree/bindings/iio/resolver/ad2s90.txt    |   31 +
 .../devicetree/bindings/iio/st-sensors.txt         |    2 +
 .../devicetree/bindings/vendor-prefixes.txt        |    2 +
 MAINTAINERS                                        |   38 +-
 drivers/iio/accel/Kconfig                          |    2 +-
 drivers/iio/accel/kxcjk-1013.c                     |    3 +
 drivers/iio/accel/st_accel.h                       |    1 +
 drivers/iio/accel/st_accel_core.c                  |    1 +
 drivers/iio/accel/st_accel_i2c.c                   |    5 +
 drivers/iio/accel/st_accel_spi.c                   |    5 +
 drivers/iio/adc/Kconfig                            |   23 +-
 drivers/iio/adc/Makefile                           |    2 +
 drivers/iio/adc/ad7124.c                           |  684 +++++
 drivers/iio/adc/ad7949.c                           |  347 +++
 drivers/iio/adc/ad_sigma_delta.c                   |   22 +-
 drivers/iio/adc/exynos_adc.c                       |   14 +
 drivers/iio/adc/ina2xx-adc.c                       |    2 +
 drivers/iio/adc/max11100.c                         |    5 +-
 drivers/iio/adc/max9611.c                          |    5 +-
 drivers/iio/adc/meson_saradc.c                     |  243 +-
 drivers/iio/adc/qcom-spmi-adc5.c                   |   58 +-
 drivers/iio/adc/rcar-gyroadc.c                     |   11 +-
 drivers/iio/adc/sc27xx_adc.c                       |   12 +-
 drivers/iio/adc/stm32-adc-core.c                   |  182 +-
 drivers/iio/adc/stm32-adc.c                        |  303 ++-
 drivers/iio/adc/ti-adc128s052.c                    |   37 +-
 .../iio/common/hid-sensors/hid-sensor-attributes.c |    2 +-
 drivers/iio/common/ssp_sensors/ssp_dev.c           |   20 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |    3 +-
 drivers/iio/common/st_sensors/st_sensors_trigger.c |    4 +-
 drivers/iio/dac/Kconfig                            |    9 +
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/ad5686-spi.c                       |   21 +-
 drivers/iio/dac/ad5686.c                           |   19 +-
 drivers/iio/dac/ad5686.h                           |    7 +
 drivers/iio/dac/dpot-dac.c                         |    4 +-
 drivers/iio/dac/ti-dac7311.c                       |  338 +++
 drivers/iio/imu/bmi160/bmi160.h                    |    1 -
 drivers/iio/imu/bmi160/bmi160_core.c               |   38 +-
 drivers/iio/imu/bmi160/bmi160_i2c.c                |    8 -
 drivers/iio/imu/bmi160/bmi160_spi.c                |    8 -
 drivers/iio/imu/st_lsm6dsx/Makefile                |    3 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |  167 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |  165 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  283 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |  779 ++++++
 drivers/iio/industrialio-core.c                    |    3 +
 drivers/iio/light/Kconfig                          |   13 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/vcnl4035.c                       |  676 +++++
 drivers/iio/magnetometer/Kconfig                   |   29 +
 drivers/iio/magnetometer/Makefile                  |    4 +
 drivers/iio/magnetometer/ak8975.c                  |    1 +
 drivers/iio/magnetometer/rm3100-core.c             |  616 +++++
 drivers/iio/magnetometer/rm3100-i2c.c              |   54 +
 drivers/iio/magnetometer/rm3100-spi.c              |   64 +
 drivers/iio/magnetometer/rm3100.h                  |   17 +
 drivers/iio/magnetometer/st_magn.h                 |    1 +
 drivers/iio/magnetometer/st_magn_core.c            |   11 +-
 drivers/iio/magnetometer/st_magn_i2c.c             |    5 +
 drivers/iio/magnetometer/st_magn_spi.c             |    7 +
 drivers/iio/potentiometer/Kconfig                  |   12 +
 drivers/iio/potentiometer/Makefile                 |    1 +
 drivers/iio/potentiometer/mcp41010.c               |  203 ++
 drivers/iio/potentiometer/mcp4131.c                |   11 +-
 drivers/iio/potentiometer/tpl0102.c                |   42 +-
 drivers/iio/resolver/Kconfig                       |   10 +
 drivers/iio/resolver/Makefile                      |    1 +
 drivers/{staging => }/iio/resolver/ad2s90.c        |   77 +-
 drivers/staging/android/ashmem.c                   |    4 +-
 drivers/staging/android/ion/ion.c                  |   51 +-
 drivers/staging/android/ion/ion.h                  |    9 +
 drivers/staging/android/ion/ion_system_heap.c      |    1 -
 drivers/staging/axis-fifo/axis-fifo.c              |    3 +-
 drivers/staging/comedi/comedi_fops.c               |   49 +-
 drivers/staging/comedi/drivers/8255.h              |    2 +-
 drivers/staging/comedi/drivers/addi_apci_3501.c    |    9 +-
 drivers/staging/comedi/drivers/amplc_dio200.h      |    2 +-
 drivers/staging/comedi/drivers/amplc_pc236.h       |    2 +-
 drivers/staging/comedi/drivers/cb_pcidas.c         |    2 +-
 drivers/staging/comedi/drivers/cb_pcidas64.c       |   44 +-
 drivers/staging/comedi/drivers/cb_pcidda.c         |    4 +-
 drivers/staging/comedi/drivers/comedi_8254.h       |    2 +-
 drivers/staging/comedi/drivers/comedi_isadma.h     |    2 +-
 drivers/staging/comedi/drivers/das08.h             |    2 +-
 drivers/staging/comedi/drivers/dt9812.c            |    2 +-
 drivers/staging/comedi/drivers/mite.h              |    2 +-
 drivers/staging/comedi/drivers/ni_labpc.h          |    2 +-
 drivers/staging/comedi/drivers/ni_labpc_common.c   |    9 +-
 drivers/staging/comedi/drivers/ni_stc.h            |    2 +-
 drivers/staging/comedi/drivers/ni_tio.h            |    2 +-
 drivers/staging/comedi/drivers/ni_tio_internal.h   |    2 +-
 drivers/staging/comedi/drivers/plx9052.h           |    2 +-
 drivers/staging/comedi/drivers/plx9080.h           |    2 +-
 drivers/staging/comedi/drivers/s626.h              |    2 +-
 .../staging/comedi/drivers/tests/ni_routes_test.c  |    2 +-
 drivers/staging/emxx_udc/emxx_udc.c                |  292 +-
 drivers/staging/emxx_udc/emxx_udc.h                |    2 +-
 drivers/staging/erofs/Kconfig                      |    3 +-
 drivers/staging/erofs/Makefile                     |    2 +-
 drivers/staging/erofs/TODO                         |   15 +-
 drivers/staging/erofs/data.c                       |   65 +-
 drivers/staging/erofs/dir.c                        |   11 +-
 drivers/staging/erofs/erofs_fs.h                   |    8 +-
 drivers/staging/erofs/inode.c                      |   10 +-
 drivers/staging/erofs/internal.h                   |   79 +-
 drivers/staging/erofs/lz4defs.h                    |  227 --
 drivers/staging/erofs/super.c                      |   19 +-
 drivers/staging/erofs/unzip_lz4.c                  |  251 --
 drivers/staging/erofs/unzip_pagevec.h              |    2 +-
 drivers/staging/erofs/unzip_vle.c                  |  753 +++--
 drivers/staging/erofs/unzip_vle.h                  |    4 +-
 drivers/staging/erofs/unzip_vle_lz4.c              |   27 +-
 drivers/staging/erofs/utils.c                      |  146 +-
 drivers/staging/fbtft/fbtft_device.c               |    2 +-
 drivers/staging/fwserial/fwserial.c                |   32 +-
 drivers/staging/gasket/gasket_interrupt.c          |   17 +-
 drivers/staging/gasket/gasket_page_table.c         |   27 +-
 drivers/staging/goldfish/goldfish_audio.c          |    1 +
 drivers/staging/greybus/arche-apb-ctrl.c           |    1 -
 drivers/staging/greybus/arche_platform.h           |    2 +-
 drivers/staging/greybus/arpc.h                     |    2 +-
 drivers/staging/greybus/audio_apbridgea.h          |    2 +-
 drivers/staging/greybus/audio_codec.h              |    2 +-
 drivers/staging/greybus/audio_manager.h            |    2 +-
 drivers/staging/greybus/audio_manager_module.c     |    4 +-
 drivers/staging/greybus/audio_manager_private.h    |    2 +-
 drivers/staging/greybus/audio_manager_sysfs.c      |   22 +-
 drivers/staging/greybus/audio_module.c             |   20 +-
 drivers/staging/greybus/audio_topology.c           |   63 +-
 drivers/staging/greybus/bootrom.c                  |   25 +-
 drivers/staging/greybus/bundle.h                   |    2 +-
 drivers/staging/greybus/camera.c                   |   13 +-
 drivers/staging/greybus/connection.c               |   86 +-
 drivers/staging/greybus/connection.h               |    2 +-
 drivers/staging/greybus/control.c                  |   53 +-
 drivers/staging/greybus/control.h                  |    4 +-
 drivers/staging/greybus/core.c                     |    4 +-
 drivers/staging/greybus/es2.c                      |   74 +-
 drivers/staging/greybus/gpio.c                     |   39 +-
 drivers/staging/greybus/greybus_protocols.h        |    8 +-
 drivers/staging/greybus/hid.c                      |   18 +-
 drivers/staging/greybus/i2c.c                      |   21 +-
 drivers/staging/greybus/loopback.c                 |   60 +-
 drivers/staging/greybus/module.c                   |   19 +-
 drivers/staging/greybus/operation.c                |  135 +-
 drivers/staging/greybus/svc.c                      |   93 +-
 drivers/staging/greybus/uart.c                     |    4 +-
 drivers/staging/iio/adc/Kconfig                    |    1 +
 drivers/staging/iio/adc/ad7280a.c                  |  208 +-
 drivers/staging/iio/adc/ad7606.c                   |    2 +-
 drivers/staging/iio/adc/ad7780.c                   |   72 +-
 drivers/staging/iio/adc/ad7816.c                   |  113 +-
 drivers/staging/iio/addac/adt7316-i2c.c            |   16 +-
 drivers/staging/iio/addac/adt7316-spi.c            |    1 -
 drivers/staging/iio/addac/adt7316.c                |  484 ++--
 drivers/staging/iio/addac/adt7316.h                |    3 +-
 drivers/staging/iio/cdc/ad7150.c                   |    9 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   20 +-
 drivers/staging/iio/resolver/Kconfig               |   10 -
 drivers/staging/iio/resolver/Makefile              |    1 -
 drivers/staging/iio/resolver/ad2s1210.c            |  140 +-
 drivers/staging/iio/resolver/ad2s1210.h            |   20 -
 drivers/staging/ks7010/michael_mic.c               |    1 -
 drivers/staging/media/bcm2048/radio-bcm2048.c      |    1 +
 drivers/staging/media/bcm2048/radio-bcm2048.h      |    1 +
 .../staging/media/davinci_vpfe/davinci_vpfe_user.h |    5 +-
 drivers/staging/media/davinci_vpfe/dm365_ipipe.c   |   71 +-
 drivers/staging/media/davinci_vpfe/dm365_ipipe.h   |    5 +-
 .../staging/media/davinci_vpfe/dm365_ipipe_hw.c    |    5 +-
 .../staging/media/davinci_vpfe/dm365_ipipe_hw.h    |    5 +-
 drivers/staging/media/davinci_vpfe/dm365_ipipeif.c |    5 +-
 drivers/staging/media/davinci_vpfe/dm365_ipipeif.h |    5 +-
 .../media/davinci_vpfe/dm365_ipipeif_user.h        |    5 +-
 drivers/staging/media/davinci_vpfe/dm365_isif.c    |    5 +-
 drivers/staging/media/davinci_vpfe/dm365_isif.h    |    5 +-
 .../staging/media/davinci_vpfe/dm365_isif_regs.h   |    5 +-
 drivers/staging/media/davinci_vpfe/dm365_resizer.c |    5 +-
 drivers/staging/media/davinci_vpfe/dm365_resizer.h |    5 +-
 drivers/staging/media/davinci_vpfe/vpfe.h          |    5 +-
 .../staging/media/davinci_vpfe/vpfe_mc_capture.c   |    5 +-
 .../staging/media/davinci_vpfe/vpfe_mc_capture.h   |    5 +-
 drivers/staging/media/davinci_vpfe/vpfe_video.c    |    5 +-
 drivers/staging/media/davinci_vpfe/vpfe_video.h    |    5 +-
 drivers/staging/media/tegra-vde/tegra-vde.c        |    2 +-
 drivers/staging/media/tegra-vde/uapi.h             |    4 +-
 .../staging/most/Documentation/driver_usage.txt    |   16 +-
 drivers/staging/most/sound/sound.c                 |  143 +-
 drivers/staging/mt7621-dma/mtk-hsdma.c             |    6 +-
 drivers/staging/mt7621-dma/ralink-gdma.c           |   25 +-
 drivers/staging/mt7621-dts/gbpc1.dts               |    1 +
 drivers/staging/mt7621-dts/mt7621.dtsi             |   23 +-
 drivers/staging/mt7621-eth/mdio.c                  |    2 +-
 drivers/staging/mt7621-eth/mtk_eth_soc.c           |    5 +-
 drivers/staging/mt7621-mmc/dbg.c                   |    2 +-
 drivers/staging/mt7621-mmc/sd.c                    |   75 +-
 drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt |   99 +
 drivers/staging/mt7621-pci/pci-mt7621.c            |  930 ++++---
 drivers/staging/mt7621-spi/spi-mt7621.c            |  147 +-
 drivers/staging/octeon-usb/octeon-hcd.c            |    6 +-
 drivers/staging/octeon/ethernet-mdio.c             |    1 -
 drivers/staging/octeon/ethernet.c                  |   11 +-
 drivers/staging/olpc_dcon/olpc_dcon_xo_1.c         |   90 +-
 drivers/staging/pi433/pi433_if.c                   |   18 +-
 drivers/staging/pi433/pi433_if.h                   |   10 -
 drivers/staging/pi433/rf69.c                       |   10 -
 drivers/staging/pi433/rf69.h                       |   10 -
 drivers/staging/pi433/rf69_enum.h                  |   10 -
 drivers/staging/pi433/rf69_registers.h             |   10 -
 drivers/staging/rtl8188eu/core/rtw_ap.c            |    4 +-
 drivers/staging/rtl8188eu/core/rtw_cmd.c           |   31 +-
 drivers/staging/rtl8188eu/core/rtw_led.c           |   20 +-
 drivers/staging/rtl8188eu/core/rtw_mlme.c          |  354 +--
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c      |  770 +++---
 drivers/staging/rtl8188eu/core/rtw_pwrctrl.c       |    2 +-
 drivers/staging/rtl8188eu/core/rtw_recv.c          |   20 +-
 drivers/staging/rtl8188eu/core/rtw_security.c      |    4 +-
 drivers/staging/rtl8188eu/core/rtw_sreset.c        |    4 +-
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c       |    2 +-
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c     |  314 ++-
 drivers/staging/rtl8188eu/core/rtw_xmit.c          |   19 +-
 .../staging/rtl8188eu/hal/hal8188e_rate_adaptive.c |  156 +-
 drivers/staging/rtl8188eu/hal/odm.c                |    8 +-
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c       |   37 +-
 drivers/staging/rtl8188eu/hal/phy.c                |   17 +-
 drivers/staging/rtl8188eu/hal/rf.c                 |   17 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c       |    7 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c  |    5 +-
 drivers/staging/rtl8188eu/hal/rtl8188eu_led.c      |   46 +-
 drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c     |    7 +-
 drivers/staging/rtl8188eu/include/hal_intf.h       |    2 +-
 drivers/staging/rtl8188eu/include/rtl8188e_hal.h   |    2 +
 drivers/staging/rtl8188eu/include/rtl8188e_xmit.h  |    4 +-
 drivers/staging/rtl8188eu/include/rtw_led.h        |   12 +-
 drivers/staging/rtl8188eu/include/rtw_mlme.h       |    8 +-
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h   |   15 +-
 drivers/staging/rtl8188eu/include/rtw_recv.h       |    2 +-
 drivers/staging/rtl8188eu/include/rtw_sreset.h     |    2 +-
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c     |   36 +-
 drivers/staging/rtl8188eu/os_dep/os_intfs.c        |   10 +-
 drivers/staging/rtl8188eu/os_dep/recv_linux.c      |   10 +-
 drivers/staging/rtl8188eu/os_dep/rtw_android.c     |    8 -
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c   |  171 +-
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c       |   14 +-
 drivers/staging/rtl8192u/r8192U.h                  |    4 +-
 drivers/staging/rtl8192u/r8192U_dm.c               |   10 +-
 drivers/staging/rtl8192u/r819xU_cmdpkt.c           |    2 +-
 drivers/staging/rtl8192u/r819xU_firmware.c         |    4 +-
 drivers/staging/rtl8192u/r819xU_phyreg.h           |    2 +-
 drivers/staging/rtl8712/hal_init.c                 |   10 +-
 drivers/staging/rtl8712/rtl8712_hal.h              |    8 +-
 drivers/staging/rtl8712/rtl871x_cmd.h              |    2 +-
 drivers/staging/rtl8723bs/TODO                     |    2 +-
 drivers/staging/rtl8723bs/core/rtw_ap.c            |  236 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c           |   60 +-
 drivers/staging/rtl8723bs/core/rtw_debug.c         |    2 +-
 drivers/staging/rtl8723bs/core/rtw_efuse.c         |    6 +-
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c     |   26 +-
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c     |   16 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c          |   40 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |  128 +-
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c       |   84 +-
 drivers/staging/rtl8723bs/core/rtw_recv.c          |   34 +-
 drivers/staging/rtl8723bs/core/rtw_security.c      |    6 +-
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c       |    2 +-
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c     |   26 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c          |   34 +-
 drivers/staging/rtl8723bs/hal/hal_btcoex.c         |    4 +-
 drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c |    8 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c  |    4 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c     |   10 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c     |   22 +-
 drivers/staging/rtl8723bs/hal/sdio_ops.c           |    2 +-
 .../rtl8723bs/include/osdep_service_linux.h        |    2 -
 drivers/staging/rtl8723bs/include/rtw_cmd.h        |    9 +-
 drivers/staging/rtl8723bs/include/rtw_io.h         |    1 -
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h   |    1 -
 drivers/staging/rtl8723bs/include/rtw_mp.h         |    1 -
 drivers/staging/rtl8723bs/include/rtw_pwrctrl.h    |    8 +-
 drivers/staging/rtl8723bs/include/rtw_xmit.h       |    9 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c     |    4 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c        |    6 +-
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c      |    2 +-
 drivers/staging/rtlwifi/base.c                     |   71 +-
 drivers/staging/rtlwifi/base.h                     |    6 +-
 drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c   |   13 +-
 drivers/staging/rtlwifi/core.c                     |    3 +-
 drivers/staging/rtlwifi/phydm/phydm.c              |    2 +-
 drivers/staging/rtlwifi/phydm/phydm_adc_sampling.c |   11 +-
 drivers/staging/rtlwifi/phydm/phydm_ccx.c          |   11 +-
 drivers/staging/rtlwifi/phydm/phydm_debug.c        |   35 +-
 drivers/staging/rtlwifi/phydm/phydm_dig.c          |    9 +-
 .../staging/rtlwifi/phydm/phydm_edcaturbocheck.c   |    8 +-
 drivers/staging/rtlwifi/phydm/phydm_hwconfig.c     |  113 +-
 drivers/staging/rtlwifi/phydm/phydm_hwconfig.h     |   12 -
 drivers/staging/rtlwifi/phydm/phydm_psd.c          |    7 +-
 drivers/staging/rtlwifi/ps.c                       |    4 +-
 drivers/staging/rts5208/general.c                  |   17 +-
 drivers/staging/rts5208/general.h                  |   18 +-
 drivers/staging/rts5208/ms.c                       |   17 +-
 drivers/staging/rts5208/ms.h                       |   18 +-
 drivers/staging/rts5208/rtsx.c                     |   17 +-
 drivers/staging/rts5208/rtsx.h                     |   18 +-
 drivers/staging/rts5208/rtsx_card.c                |   17 +-
 drivers/staging/rts5208/rtsx_card.h                |   18 +-
 drivers/staging/rts5208/rtsx_chip.c                |   17 +-
 drivers/staging/rts5208/rtsx_chip.h                |   18 +-
 drivers/staging/rts5208/rtsx_scsi.c                |   17 +-
 drivers/staging/rts5208/rtsx_scsi.h                |   18 +-
 drivers/staging/rts5208/rtsx_sys.h                 |   18 +-
 drivers/staging/rts5208/rtsx_transport.c           |   14 +-
 drivers/staging/rts5208/rtsx_transport.h           |   18 +-
 drivers/staging/rts5208/sd.c                       |   17 +-
 drivers/staging/rts5208/sd.h                       |   18 +-
 drivers/staging/rts5208/spi.c                      |   17 +-
 drivers/staging/rts5208/spi.h                      |   18 +-
 drivers/staging/rts5208/xd.c                       |   17 +-
 drivers/staging/rts5208/xd.h                       |   20 +-
 drivers/staging/sm750fb/sm750_accel.c              |    3 +-
 drivers/staging/speakup/i18n.c                     |    2 +-
 drivers/staging/speakup/kobjects.c                 |    2 +-
 drivers/staging/speakup/speakup_acntpc.c           |    3 +-
 drivers/staging/speakup/speakup_decpc.c            |    6 +-
 drivers/staging/speakup/speakup_keypc.c            |    2 +-
 drivers/staging/speakup/spk_priv.h                 |    6 +-
 drivers/staging/speakup/spk_ttyio.c                |    9 +-
 drivers/staging/unisys/visorhba/visorhba_main.c    |   14 +-
 drivers/staging/vboxvideo/Makefile                 |    2 -
 drivers/staging/vboxvideo/hgsmi_base.c             |   99 +-
 drivers/staging/vboxvideo/hgsmi_ch_setup.h         |   40 +-
 drivers/staging/vboxvideo/hgsmi_channels.h         |   23 +-
 drivers/staging/vboxvideo/hgsmi_defs.h             |   23 +-
 drivers/staging/vboxvideo/modesetting.c            |   71 +-
 drivers/staging/vboxvideo/vbox_drv.c               |   55 +-
 drivers/staging/vboxvideo/vbox_drv.h               |   40 +-
 drivers/staging/vboxvideo/vbox_err.h               |   50 -
 drivers/staging/vboxvideo/vbox_fb.c                |   33 +-
 drivers/staging/vboxvideo/vbox_hgsmi.c             |   22 +-
 drivers/staging/vboxvideo/vbox_irq.c               |   26 +-
 drivers/staging/vboxvideo/vbox_main.c              |  101 +-
 drivers/staging/vboxvideo/vbox_mode.c              |   56 +-
 drivers/staging/vboxvideo/vbox_prime.c             |   20 +-
 drivers/staging/vboxvideo/vbox_ttm.c               |   35 +-
 drivers/staging/vboxvideo/vboxvideo.h              |  143 +-
 drivers/staging/vboxvideo/vboxvideo_guest.h        |   50 +-
 drivers/staging/vboxvideo/vboxvideo_vbe.h          |   34 +-
 drivers/staging/vboxvideo/vbva_base.c              |   27 +-
 .../staging/vc04_services/bcm2835-audio/Kconfig    |    2 +-
 drivers/staging/vc04_services/bcm2835-audio/TODO   |   25 +-
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c      |   30 +-
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c    |   42 +-
 .../staging/vc04_services/bcm2835-audio/bcm2835.c  |   73 +-
 .../staging/vc04_services/bcm2835-audio/bcm2835.h  |    1 +
 .../bcm2835-audio/vc_vchi_audioserv_defs.h         |    6 +-
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  |   78 +-
 .../vc04_services/bcm2835-camera/mmal-vchiq.c      |   35 +-
 drivers/staging/vc04_services/interface/vchi/TODO  |   42 +
 .../staging/vc04_services/interface/vchi/vchi.h    |   46 +-
 .../vc04_services/interface/vchi/vchi_common.h     |   12 +-
 .../staging/vc04_services/interface/vchi/vchi_mh.h |   42 -
 .../interface/vchiq_arm/vchiq_2835_arm.c           |   64 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |  938 +++----
 .../vc04_services/interface/vchiq_arm/vchiq_arm.h  |   61 +-
 .../interface/vchiq_arm/vchiq_connected.c          |    1 -
 .../vc04_services/interface/vchiq_arm/vchiq_core.c |  930 +++----
 .../vc04_services/interface/vchiq_arm/vchiq_core.h |  245 +-
 .../interface/vchiq_arm/vchiq_debugfs.c            |   17 +-
 .../interface/vchiq_arm/vchiq_debugfs.h            |    4 +-
 .../vc04_services/interface/vchiq_arm/vchiq_if.h   |   42 +-
 .../interface/vchiq_arm/vchiq_ioctl.h              |   64 +-
 .../interface/vchiq_arm/vchiq_killable.h           |   55 -
 .../interface/vchiq_arm/vchiq_pagelist.h           |    4 +-
 .../vc04_services/interface/vchiq_arm/vchiq_shim.c |   64 +-
 .../vc04_services/interface/vchiq_arm/vchiq_util.c |   68 +-
 .../vc04_services/interface/vchiq_arm/vchiq_util.h |   27 +-
 drivers/staging/vt6655/baseband.c                  |    2 +-
 drivers/staging/wilc1000/Makefile                  |    3 +-
 drivers/staging/wilc1000/coreconfigurator.c        |  287 --
 drivers/staging/wilc1000/coreconfigurator.h        |   81 -
 drivers/staging/wilc1000/host_interface.c          | 2872 ++++++--------------
 drivers/staging/wilc1000/host_interface.h          |  242 +-
 drivers/staging/wilc1000/linux_wlan.c              |   92 +-
 drivers/staging/wilc1000/wilc_sdio.c               |   23 +-
 drivers/staging/wilc1000/wilc_spi.c                |   13 +-
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c  |  328 +--
 drivers/staging/wilc1000/wilc_wfi_netdevice.h      |   74 +-
 drivers/staging/wilc1000/wilc_wlan.c               |  115 +-
 drivers/staging/wilc1000/wilc_wlan_cfg.c           |    1 -
 drivers/staging/wilc1000/wilc_wlan_if.h            |  221 +-
 drivers/staging/wlan-ng/cfg80211.c                 |    3 +-
 drivers/staging/wlan-ng/prism2fw.c                 |    4 +-
 drivers/staging/wlan-ng/prism2mib.c                |   26 +-
 drivers/staging/xgifb/XGI_main_26.c                |    5 +-
 drivers/staging/xgifb/vb_setmode.c                 |    7 +-
 include/linux/iio/adc/ad_sigma_delta.h             |    3 +
 include/linux/iio/common/st_sensors.h              |    2 +-
 include/linux/platform_data/st_sensors_pdata.h     |    2 +
 tools/iio/Makefile                                 |    2 +-
 410 files changed, 12689 insertions(+), 11298 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ad7949.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4035.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
 create mode 100644 drivers/iio/adc/ad7124.c
 create mode 100644 drivers/iio/adc/ad7949.c
 create mode 100644 drivers/iio/dac/ti-dac7311.c
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
 create mode 100644 drivers/iio/light/vcnl4035.c
 create mode 100644 drivers/iio/magnetometer/rm3100-core.c
 create mode 100644 drivers/iio/magnetometer/rm3100-i2c.c
 create mode 100644 drivers/iio/magnetometer/rm3100-spi.c
 create mode 100644 drivers/iio/magnetometer/rm3100.h
 create mode 100644 drivers/iio/potentiometer/mcp41010.c
 rename drivers/{staging => }/iio/resolver/ad2s90.c (58%)
 delete mode 100644 drivers/staging/erofs/lz4defs.h
 delete mode 100644 drivers/staging/erofs/unzip_lz4.c
 delete mode 100644 drivers/staging/iio/resolver/ad2s1210.h
 create mode 100644 drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
 delete mode 100644 drivers/staging/vboxvideo/vbox_err.h
 delete mode 100644 drivers/staging/vc04_services/interface/vchi/vchi_mh.h
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_killable.h
 delete mode 100644 drivers/staging/wilc1000/coreconfigurator.c
 delete mode 100644 drivers/staging/wilc1000/coreconfigurator.h
