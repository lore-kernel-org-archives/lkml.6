Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9504FC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5333E215EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5333E215EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbeHRTFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:05:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46948 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeHRTFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:05:43 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BB4C7BD4;
        Sat, 18 Aug 2018 15:57:27 +0000 (UTC)
Date:   Sat, 18 Aug 2018 17:57:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Subject: [GIT PULL] Staging/IIO driver patches for 4.19-rc1
Message-ID: <20180818155724.GA22569@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit acb1872577b346bd15ab3a3f8dff780d6cca4b70:

  Linux 4.18-rc7 (2018-07-29 14:44:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-4.19-rc1

for you to fetch changes up to e4f6a44c4aeca9eda153302abb0c14d053914f72:

  staging:rtl8192u: Remove unused macro definitions - Style (2018-08-08 14:27:03 +0200)

----------------------------------------------------------------
Staging/IIO patches for 4.19-rc1

Here are the big staging/iio patches for 4.19-rc1.

Lots of churn here, with tons of cleanups happening in staging drivers,
a removal of an old crypto driver that no one was using (skein), and the
addition of some new IIO drivers.  Also added was a "gasket" driver from
Google that needs loads of work and the erofs filesystem.

Even with adding all of the new drivers and a new filesystem, we are
only adding about 1000 lines overall to the kernel linecount, which
shows just how much cleanup happened, and how big the unused crypto
driver was.

All of these have been in the linux-next tree for a while now with no
reported issues.

Note, you will have a merge problem with a device tree IIO file and the
MAINTAINERS file, both resolutions are easy, just take all changed.
There will be a skein file merge issue as well, but that file got
deleted so just drop that.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abdun Nihaal (1):
      staging: mt7621-pci: Fix coding style error

Ajay Singh (56):
      staging: wilc1000: use list_head to maintain 'txq_entry_t' elements of tx queue
      staging: wilc1000: use list_head to maintain 'rxq_entry_t elements in rx queue
      staging: wilc1000: remove 'rxq_entries' from 'wilc' struct
      staging: wilc1000: move 'txq_spinlock_flags' from 'wilc' structure to local variable
      staging: wilc1000: remove host_if_work() to handle TODO list issue
      staging: wilc1000: remove unused marco related to HIF commands
      staging: wilc1000: move the allocation of cmd out of wilc_enqueue_cmd()
      staging: wilc1000: added 'work_comp' completion as part of host_if_msg
      staging: wilc1000: remove 'hif_thread_comp' completions
      staging: wilc1000: rename wilc_enqueue_cmd() to wilc_enqueue_work()
      staging: wilc1000: handle freeing of key data in wep add key
      staging: wilc1000: handle freeing of key data in wilc_add_ptk()
      staging: wilc1000: handle freeing of 'key' & 'seq' data in wilc_add_rx_gtk()
      staging: wilc1000: avoid use of static variable 'inactive_time'
      staging: wilc1000: avoid use of static variable 'rssi'
      staging: wilc1000: updated TODO file
      staging: wilc1000: fix static checker warning to unlock mutex in wilc_deinit()
      staging: wilc1000: remove unused enum declaration
      staging: wilc1000: remove enum connect_status instead use ieee80211_statuscode
      staging: wilc1000: remove extra enum defined for data rates
      staging: wilc1000: remove extra enums defined for ieee80211_eid
      staging: wilc1000: rename goto to avoid leading '_' in label name
      staging: wilc1000: rename enum CURRENT_TXRATE to use lowercase
      staging: wilc1000: rename enum SITESURVEY to use lowercase
      staging: wilc1000: rename enum AUTHTYPE to use lowercase
      staging: wilc1000: remove unused elements in 'wilc' struct
      staging: wilc1000: remove unnecessary elements from 'wilc_priv' struct
      staging: wilc1000: removed unused element from wilc_cfg_frame struct
      staging: wilc1000: remove the mutliple #define used for same macro
      staging: wilc1000: use lowercase for 'IFC_UP' struct element name
      staging: wilc1000: remove unnecessary blank line between variable declaration
      staging: wilc1000: use single space before opening brances '{'
      staging: wilc1000: remove unnecessary type used for wid id
      staging: wilc1000: avoid forward declaration for handle_scan_done()
      staging: wilc1000: avoid host_int_get_assoc_res_info() forward declaration
      staging: wilc1000: avoid forward declaration of host_int_parse_join_bss_param()
      staging: wilc1000: avoid setting default value for variable at declaration
      staging: wilc1000: use 'int' inplace of 's32' date type
      staging: wilc1000: remove unnecessary 'NULL' check from cfg80211_ops callbacks
      staging: wilc1000: move variable assignment along with its declaration
      staging: wilc1000: remove gpio parameter from wilc_netdev_init()
      staging: wilc1000: rename variable from 'gpio' to 'gpio_irq'
      staging: wilc1000: change compatible string from atmel to microchip
      staging: wilc1000: use descriptor-based interface for GPIO
      staging: wilc1000: fix TODO to compile spi and sdio components in single module
      staging: wilc1000: remove unnecessary comments and comments description
      staging: wilc1000: modified debug log messages description
      staging: wilc1000: added comments for 'hif_cs' mutex lock
      staging: wilc1000: rename 'rcvd_ch_cnt' element in 'user_scan_req' struct
      staging: wilc1000: refactor wilc_wlan_handle_isr_ext to avoid goto statement
      staging: wilc1000: use 'u16' data type for config id parameter
      staging: wilc1000: fix endianness warnings reported by sparse
      staging: wilc1000: fix compilation warning for ARCH PowerPC
      staging: wilc1000: added Microchip copyright notice header
      staging: wilc1000: replace ISWILC1000() macro with inline function
      staging: wilc1000: remove TODO item for comments and code style

Akinobu Mita (5):
      iio: accel: adxl345: add link to datasheet
      iio: accel: adxl345: convert address field usage in iio_chan_spec
      iio: accel: adxl345: add calibration offset support
      iio: adc: ina2xx: avoid kthread_stop() with stale task_struct
      iio: accel: adxl345: add sampling frequency support

Ali Aminian (1):
      staging: rts5208: xd.c fixed a brace coding style issue

Alistair Strachan (2):
      staging: android: ashmem: Remove use of unlikely()
      staging: android: ashmem: Fix mmap size validation

Andreas Klinger (4):
      iio: hx711: add maintainer for driver
      iio: hx711: add clock-frequency property in DT
      iio: hx711: add delay until DOUT is ready
      iio: hx711: fix spurious unit-address in example

Anton Vasilyev (1):
      staging: rts5208: add error handling into rtsx_probe

Arnd Bergmann (6):
      iio: adc: sun4i-gpadc: select REGMAP_IRQ
      iio: use timespec64 based interfaces for iio_get_time_ns()
      staging: android/vsoc: stop using 'timespec'
      staging: rtl8723bs: remove get_monotonic_boottime()
      staging: rtsx: remove rtsx_trace() and related code
      staging: rtl8188eu/rtl8723bs: fix character encoding

Baolin Wang (1):
      dt-bindings: iio: Add Spreadtrum SC27XX PMICs ADC controller documentation

Bjorn Helgaas (1):
      staging: rtlwifi: Remove empty halmac_pcie_reg.h

Brian Masney (2):
      iio: imu: mpu6050: add support for 6515 variant
      iio: pressure: bmp280: remove unused options from device tree documentation

Chao Yu (4):
      staging: erofs: support special inode
      staging: erofs: introduce error injection infrastructure
      staging: erofs: support tracepoint
      staging: erofs: disable compiling temporarile

Chris Opperman (2):
      staging: comedi: Improved readability of function comedi_nsamples_left.
      staging: wlan-ng: improved readability of function prism2_add_key

Christian Lütke-Stetzkamp (34):
      staging: mt7621-mmc: Remove unused variable in msdc_command_resp
      staging: mt7621-mmc: Remove unused macro msdc_fifo_write8
      staging: mt7621-mmc: Remove unused macro msdc_fifo_read8
      staging: mt7621-mmc: Remove unused macro msdc_fifo_write32
      staging: mt7621-mmc: Remove unused macro msdc_fifo_read32
      staging: mt7621-mmc: Remove unused macro msdc_txfifocnt
      staging: mt7621-mmc: Remove unused macro msdc_rxfifocnt
      staging: mt7621-mmc: Replace sdr_write32 with writel
      staging: mt7621-mmc: Replace sdr_read32 with readl
      staging: mt7621-mmc: Remove unused macro sdr_read8
      staging: mt7621-mmc: Remove unused macro sdr_write8
      staging: mt7621-mmc: Remove register debugging structures
      staging: mt7621-mmc: Remove DMA basic mode code
      staging: mt7621-mmc: Remove unused field mode from msdc_dma
      staging: mt7621-mmc: Refactor dma setup process
      staging: mt7621-mmc: Remove unused field sg from msdc_dma
      staging: mt7621-mmc: Remove unused field sglen from msdc_dma
      staging: mt7621-mmc: Remove variable num form msdc_dma_setup
      staging: mt7621-mmc: Remove unnecessary BUG_ON() in msdc_dma_setup
      staging: mt7621-mmc: Make msdc_clr_fifo a function and relax cpu
      staging: mt7621-mmc: Remove unused macro msdc_retry
      staging: mt7621-mmc: Remove unused macro MAX_BD_PER_GPD
      staging: mt7621-mmc: Remove unused variable from msdc_tune_request
      staging: mt7621-mmc: Remove MSDC_MODE_* defines
      staging: mt7621-mmc: Cleanup source of base address for io
      staging: mt7621-mmc: Remove unused define RALINK_MSDC_BASE
      staging: mt7621-mmc: Remove unused define IRQ_SDC
      staging: mt7621-mmc: Remove unused enum msdc_mode
      staging: mt7621-mmc: Remove unused define MAX_PHY_SGMTS
      staging: mt7621-mmc: Remove unused macro is_card_present
      staging: mt7621-mmc: Remove unused argument from msdc_do_command
      staging: mt7621-mmc: Factor out from msdc_command_start()
      staging: mt7621-mmc: Find response of MMC_SEND_OP_COND by default
      staging: mt7621-mmc: Find response of SD_APP_OP_COND by default

Colin Ian King (14):
      staging: vc04_services: make a couple of pointers static
      staging: rts5208: fix missing error check on call to rtsx_write_register
      iio: dac: ti-dac5571 remove redundant variable 'shift'
      iio: dac: ltc2632 remove redundant pointer chip_info and spi_dev_id
      staging: comedi: remove redundant variable segpos
      staging: gasket: remove redundant pointer bar_data
      staging: gdm724x: redundant variables idProduct and idVendor
      staging: ks7010: remove redundant variable eth_proto
      staging: sm750fb: remove redundant pointer 'output'
      staging: speakup: remove redundant variable l
      staging: vt6655: remove some redundant variables
      staging: rtl8712: remove redundant pointer 'nic'
      iio: light: si1133 fix test for val being not zero or not one.
      staging: rtl8188eu: remove unused array dB_Invert_Table

Cristian Kubis (2):
      staging: olpc_dcon: prefer 'help' in KConfig
      staging: olpc_dcon: add missing identifier names

Dan Carpenter (4):
      Staging: Gasket: uninitialized return in gasket_mmap()
      Staging: Gasket: fix a couple off by one bugs
      Staging: Gasket: shift wrapping bug in gasket_read_modify_write_64()
      iio: adc: at91-sama5d2_adc: fix up casting in at91_adc_read_info_raw()

David Lechner (2):
      iio: adc: ti-ads7950: use SPDX-License-Identifier
      iio: adc: ti-ads7950: allow simultaneous use of buffer and direct mode

Dmitriy Cherkasov (1):
      staging: gasket: use NULL instead of 0 for null pointer

Dominique Martinet (1):
      iio: change strncpy+truncation to strlcpy

Eugen Hristev (8):
      MAINTAINERS: add generic resistive touchscreen adc
      iio: Add channel for Position Relative
      dt-bindings: input: touchscreen: add minimum pressure touchscreen property
      dt-bindings: input: touchscreen: resistive-adc-touch: create bindings
      iio: adc: at91-sama5d2_adc: add support for position and pressure channels
      input: touchscreen: resistive-adc-touch: add generic resistive ADC touchscreen
      dt-bindings: iio: adc: at91-sama5d2_adc: add channel specific consumer info
      iio: adc: at91-sama5d2_adc: add support for oversampling resolution

Fabian Bläse (2):
      rtl8192u/rtl819x_Qos.h: Adjust spaces to coding guidelines
      rtl8192u/rtl819x_BAProc.c: Adjust spaces to coding guidelines

Fabio Rafael da Rosa (1):
      staging: vboxvideo: Update driver to use drm_dev_register.

Fabrice Gasnier (1):
      dt-bindings: iio: sigma-delta-modulator: fix unit-address in example

Felix Siegel (4):
      staging: gasket: Move open-curly brace to match kernel code style
      staging: gasket: fix multi line comments style
      staging: gasket: remove "function entered" log messages
      staging: gasket: Use __func__ instead of hardcoded string - Style

Freeman Liu (1):
      iio: adc: Add Spreadtrum SC27XX PMICs ADC support

Gao Xiang (29):
      staging: erofs: add on-disk layout
      staging: erofs: add erofs in-memory stuffs
      staging: erofs: add super block operations
      staging: erofs: add raw address_space operations
      staging: erofs: add inode operations
      staging: erofs: add directory operations
      staging: erofs: add namei functions
      staging: erofs: update Kconfig and Makefile
      staging: erofs: introduce xattr & acl support
      staging: erofs: <linux/tagptr.h>: introduce tagged pointer
      staging: erofs: introduce pagevec for unzip subsystem
      staging: erofs: add erofs_map_blocks_iter
      staging: erofs: add erofs_allocpage
      staging: erofs: globalize prepare_bio and __submit_bio
      staging: erofs: introduce a customized LZ4 decompression
      staging: erofs: add a generic z_erofs VLE decompressor
      staging: erofs: introduce superblock registration
      staging: erofs: introduce erofs shrinker
      staging: erofs: introduce workstation for decompression
      staging: erofs: introduce VLE decompression support
      staging: erofs: introduce cached decompression
      staging: erofs: add a TODO and update MAINTAINERS for staging
      staging: erofs: fix a compile warning of Z_EROFS_VLE_VMAP_ONSTACK_PAGES
      staging: erofs: fix compile error without built-in decompression support
      staging: erofs: fix conditional uninitialized `pcn' in z_erofs_map_blocks_iter
      staging: erofs: use the wrapped PTR_ERR_OR_ZERO instead of open code
      staging: erofs: add the missing break in z_erofs_map_blocks_iter
      staging: erofs: remove a redundant marco in xattr
      staging: erofs: remove an extra semicolon in z_erofs_vle_unzip_all

Geert Uytterhoeven (1):
      iio: adc: Remove depends on HAS_DMA in case of platform dependency

Georgios Tsotsos (1):
      Staging: octeon-usb: Adding SPDX license identifier

Giulio Benetti (9):
      staging: iio: adc: ad7606: fix function pointer parameter names missing.
      staging: comedi: comedi_fops: make bool bit-field unsigned int bit-fields.
      staging: comedi: comedidev: make bool bit-field unsigned int bit-fields.
      staging: comedi: drivers: amplc_dio200: make bool bit-field unsigned int bit-fields.
      staging: comedi: drivers: amplc_dio200_common: make bool bit-field unsigned int bit-fields.
      staging: comedi: drivers: amplc_pci230: make bool bit-field unsigned int bit-fields.
      staging: comedi: drivers: daqboard2000: make bool bit-field unsigned int bit-fields.
      staging: comedi: drivers: cb_pcimdda: fix warning on quoted string split across lines.
      staging: comedi: drivers: ni_mio_common: add names to function pointer parameters.

Greg Kroah-Hartman (20):
      Merge tag 'iio-for-4.19a' of git://git.kernel.org/.../jic23/iio into staging-next
      Merge 4.18-rc3 into staging-next
      staging: gasket: add SPDX identifiers to all files.
      staging: gasket: remove redundant license information
      staging: gasket: remove TODO item about SPDX usage
      staging: gasket: remove pointless gasket_interrupt_pause()
      staging: gasket: remove gasket_interrupt_get_eventfd_ctxs()
      staging: gasket: remove gasket_interrupt_trigger_eventfd()
      staging: gasket: remove gasket_interrupt_get_msix_entries()
      staging: gasket: remove gasket_page_table_num_extended_entries()
      staging: gasket: remove GASKET_SYSFS_REG()
      staging: gasket: remove gasket_sysfs_register_show()
      staging: gasket: sysfs: remove legacy_device field
      staging: gasket: remove gasket_wait_sync()
      Merge 4.18-rc5 into staging-next
      Merge tag 'iio-for-4.19b' of git://git.kernel.org/.../jic23/iio into staging-next
      Merge 4.18-rc7 into staging-next
      Revert "staging:r8188eu: Use lib80211 to encrypt (TKIP) tx frames"
      staging: comedi: drop serial2002 driver
      Merge tag 'iio-for-4.19c' of git://git.kernel.org/.../jic23/iio into staging-next

Guenter Roeck (1):
      staging: speakup: Replace strncpy with memcpy

Gustavo A. R. Silva (3):
      iio:imu:adis: Mark expected switch fall-throughs
      iio: mma8452: Mark expected switch fall-through
      iio: sca3000: Fix missing return in switch

Henriette Hofmeier (3):
      staging: rtl8723bs: Move definition open brace
      staging: rtl8723bs: Remove unnecessary initializations
      staging: rtl8723bs: Fix comment on variable init

Himanshu Jha (1):
      iio: chemical: Add support for Bosch BME680 sensor

Hugo Lefeuvre (2):
      staging: pi433: fix race condition in pi433_ioctl
      staging: pi433: fix race condition in pi433_open

Ian Abbott (1):
      staging: comedi: ni_mio_common: fix subdevice flags for PFI subdevice

Ioana Ciornei (4):
      staging: fsl-dpaa2/eth: document nested structs as per kernel-doc
      staging: fsl-dpaa2/ethsw: document nested structs as per kernel-doc
      staging: fsl-dpaa2/eth: convert documentation to .rst format
      staging: fsl-dpaa2/eth: add SPDX license identifiers

Ioana Radulescu (14):
      staging: fsl-dpaa2/eth: Fix DMA mapping direction
      staging: fsl-dpaa2/eth: Remove obsolete reference
      staging: fsl-dpaa2/eth: Remove pointless instruction
      staging: fsl-dpaa2/eth: MTU cleanup
      staging: fsl-dpaa2/eth: Remove Rx frame size check
      staging: fsl-dpaa2/eth: Remove unnecessary cast
      staging: fsl-dpaa2/ethsw: Fix error message
      staging: fsl-dpaa2/eth: Update default hash key
      staging: fsl-dpaa2/eth: Remove unused driver version
      staging: fsl-dpaa2/eth: Cleanup comments
      staging: fsl-dpaa2/eth: Remove dead code
      staging: fsl-dpaa2/eth: Use BIT() macro
      staging: fsl-dpaa2/eth: Merge header files
      staging: fsl-dpaa2/eth: Use named arguments in function definition

Ivan Bornyakov (3):
      staging: gasket: fix plain integer as NULL pointer warning
      staging: gasket: use vzalloc instead of vmalloc/memset
      staging: gasket: sysfs: fix potential null dereference

Ivan Safonov (3):
      staging:r8188eu: Use lib80211 to encrypt (WEP) tx frames
      staging:r8188eu: Use lib80211 to encrypt (TKIP) tx frames
      staging:r8188eu: Use lib80211 to encrypt (CCMP) tx frames

Jacob Feder (1):
      staging: add driver for Xilinx AXI-Stream FIFO v4.1 IP core

Janani Sankara Babu (3):
      Staging:rtl8192e Fix Comparison to False is error prone
      Staging:rtl8192e Fix Comparison to true is error prone
      Staging:rtl8192e Cleanup comparison to NULL

Jason Cooper (1):
      staging/skein: Remove Skein and Threefish code

Jean-Baptiste Maneyrol (5):
      iio: imu: inv_mpu6050: replace timestamp fifo by generic timestamp
      iio: imu: inv_mpu6050: switch to use sample rate divider
      iio: imu: inv_mpu6050: fix fifo count reading
      iio: imu: inv_mpu6050: better fifo overflow handling
      iio: imu: inv_mpu6050: new timestamp mechanism

Jia-Ju Bai (3):
      staging: rtl8188eu: Fix a possible sleep-in-atomic-context bug in rtw_disassoc_cmd()
      staging: rtl8723bs: Fix two possible sleep-in-atomic-context bugs in translate_scan()
      staging: rtlwifi: Fix a possible sleep-in-atomic-context bug in _is_fw_read_cmd_down()

Joe Perches (1):
      staging: Convert random_ether_addr to eth_random_addr

Johan Hovold (1):
      MAINTAINERS: update two greybus sections

John Whitmore (222):
      staging: rtl8192e: Add and remove blank lines - Coding style
      staging: rtl8192e: Addition of prefered spacing - Coding style
      staging: rtl8192e: Remove unnecessary return statements - Coding style
      staging: rtl8192e: Correct alignment of if statements - Coding Style
      staging: rtl8192e: Remove unrequired space at start of line - Coding Style
      staging: rtl8192e: Correct declaration of HTResetIOTSetting - Coding Style
      staging: rtl8192e: Optimise Comparison to NULL tests - Coding Style
      staging: rtl8192e: remove unnecessary parentheses - Coding Style
      staging: rtl8192u: change block comments to prefered style - Coding Style
      staging: rtl8192u: Correct indentation of switch statement - Coding Style
      staging: rtl8192u: Truncate block comments to 80 character length - Style
      staging: rtl8192u: Remove braces from single statement blocks - Style
      staging: rtl8192u: Correct if statement - Coding Style
      staging: rtl8192u: Correction of spelling mistake in comment.
      staging: rtl8192u Remove redundant #include directive
      staging: rtl8192u: Use __func__ instead of hardcoded string - Style
      staging: rtl8192u: Use memset to initialize memory, instead of loop.
      staging: rtl8192u: Remove redundant definitions in header
      staging: rtl8192u: Remove superfluous blank lines - Coding Style
      staging: rtl8192u: Add space required around '==' opeartor - Style
      staging: rtl8192u: Add required spaces around '||' operator - Sytle
      staging: rtl8192u: Remove space after cast - Coding Style
      staging: rtl8192u: Add required space around '=' operator - Style
      staging: rtl8192u: Add space after ', ' character - Coding Style
      staging:rtl8192u: rename HT_CHANNEL_WIDTH -> enum ht_channel_width
      staging:rtl8192u: Add space required before '(' - Style
      staging:rtl8192u: Add spaces required around operators - Coding Style
      staging:rtl8192u: rename HT_EXTCHNL_OFFSET -> enum ht_extension_chan_width
      staging:rtl8192u: Remove blank lines before '}' and after '{' characters
      staging:rtl8192u: Correct indentation and spacing for braces of code blocks
      staging:rtl8192u: Correct spacing before and after parenthesis - Style
      staging:rtl8192u: Remove prohibited spaces - Coding Style
      staging:rtl8192u: Move trailing conditional statement to the following line
      staging:rtl8192u: Remove unnecessary parentheses - Coding Style
      staging:rtl8192u: Correct indentation of ieee80211_softmac_new_net()
      staging:rtl8192u: Correction of indentation issues - Coding Style
      staging:rtl8192u: typedef struct tx_desc_819x_usb > struct tx_desc_819x_usb
      staging:rtl8192u: trim multiple blank lines - Coding Style
      staging:rtl8192u: remove unused structure tx_desc_819x_usb_aggr_subframe
      staging:rtl8192u: typedef struct tx_desc_cmd_819x_usb remove typedef
      staging:rtl8192u: typedef struct tx_fwinfo_819x_usb remove typedef
      staging:rtl8192u: typedef struct rx_desc_819x_usb remove typedef
      staging:rtl8192u: Remove struct rx_desc_819x_usb_aggr_subframe
      staging:rtl8192u: remove typedef from struct rx_drvinfo_819x_usb
      staging:rtl8192u: Change struct r8192_priv member Rf_Mode from u8 > enum
      staging:rtl8192u: remove typedef of enumeration SwChnlCmdID - Style
      staging:rtl8192u: remove typdef from enumeration HW90_BLOCK_E - Style
      staging:rtl8192u: Remove typdef from enumeration RF90_RADIO_PATH_E - Style
      staging:rtl8192u: remove typedef from structure SwChnlCmd - Style
      staging:rtl8192u: Rename SwChnlCmdID > switch_chan_cmd_id - Coding Style
      staging:rtl8192u: Rename enum label CmdID_End > CMD_ID_END - Style
      staging:rtl8192u: rename CmdID_SetTxPowerLevel > CMD_ID_SET_TX_PWR_LEVEL
      staging:rtl8192u: Remove unused enum label CmdID_BBRegWrite10
      staging:rtl8192u: Rename CmdID_WritePortUlong > CMD_ID_WRITE_PORT_ULONG
      staging:rtl8192u: Rename CmdID_WritePortUshort > CMD_ID_WRITE_PORT_USHORT
      staging:rtl8192u: Rename CmdID_WritePortUchar > CMD_ID_WRITE_PORT_UCHAR
      staging:rtl8192u: Rename CmdID_RF_WriteReg > CMD_ID_RF_WRITE_REG - Style
      staging:rtl8192u: Rename file macro to avoid camel case - Coding Style
      staging:rtl8192u: remove typedef of enumeration TR_SELECT - Style
      staging:rtl8192u: remove typedef of struct TS_COMMON_INFO - Style
      staging:rtl8192u: Rename List > list - Coding style
      staging:rtl8192u: rename SetupTimer > setup_timer - Style
      staging:rtl8192u: Rename InactTimer > inact_timer - Style
      staging:rtl8192u: Rename Addr > addr - Style
      staging:rtl8192u: Rename TSpec > t_spec - Style
      staging:rtl8192u: Rename TClass > t_class - Style
      staging:rtl8192u: Remove multiple blank lines - Style
      staging:rtl8192u: Remove typedef from structure - Style
      staging:rtl8192u: Rename structure member FirstChnl - Style
      staging:rtl8192u: Rename variable NumChnls - Style
      staging:rtl8192u: Rename variable MaxTxPowerInDbm - Style
      staging:rtl8192u: Remove typedef and rename DOT11D_STATE - Style
      staging:rtl8192u: Rename TClasProc > t_clas_proc - Style
      staging:rtl8192u: Rename TClasNum > t_clas_num - Style
      staging:rtl8192u: Remove typedef and rename struct RT_DOT11D_INFO - Style
      staging:rtl8192u: Rename bEnabled > enabled - Style
      staging:rtl8192u: Rename CountryIeLen > country_ie_len - Style
      staging:rtl8192u: Rename CountryIeBuf to country_ie_buf - Style
      staging:rtl8192u: Rename variable CountryIeSrcAddr - Style
      staging:rtl8192u: Rename CountryIeWatchdog > country_ie_watchdog - Style
      staging:rtl8192u: Rename MaxTxPwrDbmList > max_tx_pwr_dbm_list - Style
      staging:rtl8192u: Rename variable State > state - Style
      staging:rtl8192u: Remove unused page 1 definitions - Style
      staging:rtl8192u: Remove unused page 8 definitions - Style
      staging:rtl8192u: Remove unused page 9 definitions - Style
      staging:rtl8192u: Remove unused page a definitions - Style
      staging:rtl8192u: Remove unused page c definitions - Style
      staging:rtl8192u: Remove unused page d definitions - Style
      staging:rtl8192u: Remove unused Zebra1 definitions - Style
      staging:rtl8192u: Remove unused Zebra4 definitions - Style
      staging:rtl8192u: Remove unused RTL8258 definitions - Style
      staging:rtl8192u: Remove unused page-1 Bit Masks - Style
      staging:rtl8192u: Remove unused page-8 Bit Mask definitions - Style
      staging:rtl8192u: Remove unused page-9 Bit Mask definitions - Style
      staging:rtl8192u: Remove unused page-a Bit Mask definitions - Style
      staging:rtl8192u: Remove unused page c Bit Mask definitions - Style
      staging:rtl8192u: Remove unused page d Bit Mask definitions - Style
      staging:rtl8192u: Remove unused page e Bit Mask definitions - Style
      staging:rtl8192u: Remove unused Rx Pseduo noise Bit Mask defs - Style
      staging:rtl8192u: Remove unused RF Zebra1 Bit Mask definitions - Style
      staging:rtl8192u: Remove unused Zebra4 bit mask definitions - Style
      staging:rtl8192u: Remove unused RTL8258 bit mask definitions - Style
      staging:rtl8192u: Remove typedef of u32 to QOS_MODE - Style
      staging:rtl8192u: Remove unused enumerated type ACK_POLICY - Style
      staging:rtl8192u: Remove unused QOS definitions - Style
      staging:rtl8192u: Removed unused structure BSS_QOS - Style
      staging:rtl8192u: Remove unused structure STA_QOS - Style
      staging:rtl8192u: Remove unused structure QOS_CTRL_FIELD - Style
      staging:rtl8192u: Remove unused union QOS_INFO_FIELD - Style
      staging:rtl8192u: Remove the unused AC_CODING definitions - Style
      staging:rtl8192u: Remove unused enumerated type QOS_ELE_SUBTYPE - Style
      staging:rtl8192u: Remove unused structure QOS_TSTREAM - Style
      staging:rtl8192u: Remove unused structure WMM_TSPEC - Style
      staging:rtl8192u: Remove unused enumerated type ACM_METHOD - Style
      staging:rtl8192u: Remove unused structure ACM - Style
      staging:rtl8192u: Remove unused AC_UAPSD definitions - Style
      staging:rtl8192u: Remove unused definition of sQoSCtlLng - Style
      staging:rtl8192u: Rename bit definition ISR_TxBcnOk - Style
      staging:rtl8192u: Rename ISR_TxBcnErr bit definition - Style
      staging:rtl8192u: Rename ISR_BcnTimerIntr - Style
      staging:rtl8192u: Remove multiple blank lines - Style
      staging:rtl8192u: Rename SwChnlCmd - Style
      staging:rtl8192u: Rename CmdID - Style
      staging:rtl8192u: Rename Para1 > para_1 - Style
      staging:rtl8192u: Rename Para2 to para_2 - style
      staging:rtl8192u: Rename msDelay to ms_delay - Style
      staging:rtl8192u: Remove proxy struct rtl819XMACPHY_Array_PG - Style
      staging:rtl8192u: Remove proxy struct rtl819XPHY_REG_1T2RArray - Style
      staging:rtl8192u: Remove proxy array rtl819XAGCTAB_Array - Style
      staging:rtl8192u: Remove proxy rtl819XRadioA_Array - Style
      staging:rtl8192u: Remove proxy rtl819XRadioB_Array - Style
      staging:rtl8192u: Remove proxy rtl819XRadioC_Array - Style
      staging:rtl8192u: Remove proxy rtl819XRadioD_Array - Style
      staging:rtl8192u: Rename HW90_BLOCK_E - Style
      staging:rtl8192u: Rename RF90_RADIO_PATH_E - Style
      staging:rtl8192u: Remove repeated definitions - Style
      staging:rtl8192u: Rename eRFPath - Style
      staging:rtl8192u: Remove typedef and rename TX_TS_RECORD - Style
      staging:rtl8192u: Rename TsCommonInfo - Style
      staging:rtl8192u: Rename TxCurSeq - Style
      staging:rtl8192u: Rename TxPendingBARecord - Style
      staging:rtl8192u: Rename TxAdmittedBARecord - Style
      staging:rtl8192u: Rename bAddBaReqInProgress - Style
      staging:rtl8192u: Rename bAddBaReqDelayed - Style
      staging:rtl8192u: Rename bUsingBa - Style
      staging:rtl8192u: Rename TsAddBaTimer - Style
      staging:rtl8192u: Remove typedef and rename RX_TS_RECORD - Style
      staging:rtl8192u: Remove commented out code - Style
      staging:rtl8192u: Remove unused timer values - Style
      staging:rtl8192u: Rename RxIndicateSeq - Style
      staging:rtl8192u: Rename RxTimeoutIndicateSeq _Style
      staging:rtl8192u: Rename RxPendingPktList - Style
      staging:rtl8192u: Rename RxPktPendingTimer - Style
      staging:rtl8192u: Rename RxAdmittedBARecord - Style
      staging:rtl8192u: Rename RxLastSeqNum - Style
      staging:rtl8192u: Rename RxLastFragNum - Style
      staging:rtl8192u: Remove blank line - Style
      staging:rtl8192u: Remove unused DM_check_fsync_time_interval - Style
      staging:rtl8192u: Add spaces around operators - Style
      staging:rtl8192u: Rename ACI_AIFSN - Style
      staging:rtl8192u: Rename member variables - Style
      staging:rtl8192u: Remove unused union AC_PARAM - Style
      staging:rtl8192u: Remove unused union ECW -Style
      staging:rtl8192u: Rename enum DIRECTION_VALUE - Style
      staging:rtl8192u: Rename union QOS_TSINFO - Style
      staging:rtl8192u: Remove unused constants - Style
      staging:rtl8192u: Remove typedef of struct cmpk_txfb_t - Style
      staging:rtl8192u: Remove unused CMPK_TX_SET_CONFIG_SIZE - Style
      staging:rtl8192u: Removed unused CMPK_RX_DBG_MSG_SIZE - Style
      staging:rtl8192u: Correct spelling in comments - style
      staging:rtl8192u: Remove typedef of cmpk_intr_sta_t - Style
      staging:rtl8192u: Remove typedef of cmpk_set_cfg_t - Style
      staging:rtl8192u: Refactor use of enum dm_dig_sta_e - Style
      staging:rtl8192u: Refactor enum dm_ratr_sta_e usage - Style
      staging:rtl8192u: Remove enum dm_dig_op_e - Style
      staging:rtl8192u: Refactor enum dm_dig_alg_e - Style
      staging:rtl8192u: Remove unused enum dm_dig_dbg_e - Style
      staging:rtl8192u: Refactor dm_dig_connect_e - Style
      staging:rtl8192u: Refactor enum dm_dig_pd_th_e - Style
      staging:rtl8192u: Refactor enum dm_dig_cs_ratio_e - Style
      staging:rtl8192u: Refactor enum DM_CCK_Rx_Path_Method - Style
      staging:rtl8192u: Clean cmpk_counttxstatistic() comments - Style
      staging:rtl8192u: Remove union from aci_aifsn - Style
      staging:rtl8192u: Remove union from qos_tsinfo - Style
      staging:rtl8192u: Rename members of struct qos_tsinfo - Style
      staging:rtl8192u: Refactor union TSPEC_BODY - Style
      staging:rtl8192u: Rename TSInfo - Style
      staging:rtl8192u: Rename tspec_body members - Style
      staging:rtl8192u: Remove commented out code - Style
      staging:rtl8192u: Move QOS_TCLAS to rtl819x_TS.h - Style
      staging:rtl8192u: rename OCTET_STRING - Style
      staging:rtl8192u: Rename octet_string members - Style
      staging:rtl8192u: Remove unused UP2AC - Style
      staging:rtl8192u: Rename IsACValid and add parenthesis - Style
      staging:rtl8192u: Change clock comment - Style
      staging:rtl8192u: Remove debug member from structures - Style
      staging:rtl8192u: Remove member variable rx_gain_range_max - Style
      staging:rtl8192u: Remove member initialgain_lowerbound_state - Style
      staging:rtl8192u: Rename enum constants - Style
      staging:rtl8192u: Remove unused extern DM_RxPathSelTable - Style
      staging:rtl8192u: Remove member variable Enable - Style
      staging:rtl8192u: Rename cck_Rx_path - Style
      staging:rtl8192u: Remove SS_TH_low - Style
      staging:rtl8192u: Remove member diff_TH - Style
      staging:rtl8192u: Rename member disabledRF - Style
      staging:rtl8192u: Remove member reserved - Style
      staging:rtl8192u: Refactor DCMD_TXCMD_T structure - Style
      staging:rtl8192u: Rename DM_DIG_MIN_Netcore - Style
      staging:rtl8192u: Rename RateAdaptiveTH_High - Style
      staging:rtl8192u: Rename constants RateAdaptiveTH_Low_* - Style
      staging:rtl8192u: Rename constants - Style
      staging:rtl8192u: Rename Register Constants - Style
      staging:rtl8192u: Clean up of spacing - Style
      staging:rtl8192u: Remove typedef and rename QOS_TCLAS - Style
      staging:rtl8192u: Rename types in QOS_TCLAS union - Style
      staging:rtl8192u: Rename multiple variables - Style
      staging:rtl8192u: Remove blank line - Style
      staging:rtl8192u: Remove comments - Style
      staging:rtl8192u: Replace magic number with defined constant - Style
      staging:rtl8192u: Remove stale comment - Style
      staging:rtl8192u: Add spaces around '+' operator - Style
      staging:rtl8192u: Remove unused macro definitions - Style

Jonathan Cameron (2):
      staging: iio: Drop ADIS16060 driver from staging
      Merge branch 'fixes-togreg' into togreg

Joshua Lang (1):
      staging: goldfish: Clear audio read buffer status after each read

Julia Lawall (2):
      staging: rtl8723bs: drop test
      iio: adc: max1363: merge calls to of_match_device and of_device_get_match_data

Justin Skists (1):
      staging: speakup: refactor synths array to use a list

Kacper Kołodziej (1):
      staging: rtl8188eu: break line longer than 80 cols

Kamal Heib (2):
      staging: mt7621-eth: Fix memory leak in mtk_add_mac() error path
      staging: mt7621-eth: Use eth_hw_addr_random()

Karim Eshapa (3):
      staging:iio:accel:adis16203: sign extend function rather code duplication
      staging:iio:accel:adis16240: sign extend function replace hard code duplication
      staging:iio:impedance-analyzer:ad5933: Macro replacement Cleanups.

Kees Cook (3):
      drivers/staging/gasket: Use 2-factor allocator calls
      staging: rtl8192e: ieee80211: Convert from ahash to shash
      staging: rtl8192u: ieee80211: Convert from ahash to shash

Kenneth Lu (1):
      staging: rtl8192u: remove redundant variables

Kristaps Čivkulis (1):
      staging: erofs: fix if assignment style issue

Kyle Buzby (1):
      staging: clocking-wizard: prefer 'help' in Kconfig

Lars-Peter Clausen (4):
      iio: adxl345: Add support for the ADXL375
      iio: ad9523: replace core mlock with local lock
      iio: ad9523: Fix displayed phase
      iio: ad9523: Fix return value for ad952x_store()

Leonardo Brás (8):
      staging: fbtft: Puts macro arguments in parenthesis to avoid precedence issues - Style
      staging: fbtft: Fixes some alignment issues - Style
      staging: fbtft: A bit more information on dev_err.
      staging: fbtft: Changes gamma table to define.
      staging: fbtft: Removes one nesting level to help readability - Style
      staging: fbtft: Adjust some empty-line problems - Style
      staging: fbtft: Erases some repetitive usage of function name - Style
      staging: fbtft: Add spaces around / - Style

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: add error logs to st_lsm6dsx_read_fifo()

Luke Triantafyllidis (1):
      staging: rtlwifi: refactor rtl_get_tcb_desc

Manish Narani (5):
      iio: adc: xilinx: Remove dead code from xadc_zynq_setup
      iio: adc: xilinx: Check for return values in clk related functions
      iio: adc: xilinx: limit pcap clock frequency value
      iio: adc: xilinx: Remove platform_get_irq from xadc_remove function
      iio: adc: xilinx: Move request_irq before enabling interrupts

Marcin Ciupak (1):
      staging: most: fix sparse warning Using plain integer as NULL pointer

Martin Blumenstingl (2):
      dt-bindings: iio: adc: add Meson8m2 support
      iio: adc: meson-saradc: add support for the Meson8m2 SoCs

Mathieu Othacehe (2):
      iio: Add channel for Phase
      iio: light: isl29501: Add support for the ISL29501 ToF sensor.

Matthias Wolf (2):
      staging: fbtft: Fix line over 80 characters
      staging: fbtft: Fix line continuation

Maxime Roussin-Bélanger (3):
      iio: Add modifier for DUV light
      iio: light: introduce si1133
      iio: light: si1133: fix uninitialized resp variable

Michael Hennerich (1):
      iio: ad9523: support for external signals via gpios

Michael Straube (101):
      staging: rtl8188eu: add SPDX identifiers
      staging: rtl8723bs: remove rtw_set_tx_chksum_offload()
      staging: rtl8188eu: remove blank lines
      staging: rtl8723bs: fix comparsion to NULL - coding style
      staging: rtl8723bs: refactor rtw_macaddr_cfg()
      staging: rtl8723bs: use ether_addr_copy() in rtw_macaddr_cfg()
      staging: rtl8723bs: use mac_pton() in rtw_macaddr_cfg()
      staging: rtl8188eu: remove whitespace - coding style
      staging: rtl8188eu: remove rtw_ioctl_rtl.h
      staging: rtl8723bs: fix line over 80 characters
      staging: rtl8188eu: remove unnecessary parentheses
      staging: rtl8723bs: remove pointless if else in rtw_sdio_resume()
      staging: rtl8723bs: fix comparsion to true/false and brace issues
      staging: rtl8723bs: simplify if else statement
      staging: rtl8188eu: reorder switch cases and remove default break
      staging: rtl8188eu: move return type to functions definition line
      staging: rtl8188eu: fix block comments - coding style
      staging: rtl8188eu: remove rtw_mp_phy_regdef.h
      staging: rtl8723bs: remove rtl8192c_rf.h
      staging: rtl8188eu: rename Hal8188EPhyCfg.h
      staging: rtl8188eu: rename Hal8188EPhyReg.h
      staging: rtl8188eu: rename Hal8188ERateAdaptive
      staging: rtl8723bs: remove rtw_br_ext.h
      staging: rtl8723bs: remove rtw_beamforming.h
      staging: rtl8188eu: replace while with shorter for loop
      staging: rtl8723bs: replace while with shorter for loop
      staging: rtl8723bs: replace tab with space
      staging: rtl8723bs: fix indentation
      staging: rtl8723bs: remove blank lines
      staging: rtl8723bs: add missing blank lines
      staging: rtl8723bs: remove braces from single if statement
      staging: rtl8188eu: refactor rtw_macaddr_cfg()
      staging: rtl8188eu: replace tabs with spaces
      staging: rtl8723bs: use mac_pton()
      staging: rtl8723bs: add spaces around '|'
      staging: rtl8723bs: fix lines over 80 characters
      staging: rtl8723bs: remove blank lines
      staging: rtl8723bs: fix comparsions to NULL
      staging: rtl8723bs: simplify ratetbl_val_2wifirate()
      staging: rtl8188eu: add spaces around '|'
      staging: rtl8188eu: fix lines over 80 characters
      staging: rtl8188eu: remove blank lines
      staging: rtl8188eu: use strlcpy instead of strncpy
      staging: rtl8723bs: remove unused code
      staging: rtl8723bs: refactor rtw_is_cckrates_included()
      staging: rtl8723bs: refactor rtw_is_cckratesonly_included
      staging: rtl8723bs: change return type to bool
      staging: rtl8723bs: fix comparsions to true
      staging: rtl8188eu: remove is_{multicast,broadcast}_mac_addr
      staging: rtl8188eu: do not line break function definition
      staging: rtl8188eu: rename Efuse_PowerSwitch
      staging: rtl8188eu: rename function parameters
      staging: rtl8188eu: rename variable
      staging: rtl8188eu: add spaces around '+'
      staging: rtl8188eu: remove redundant header file
      staging: rtl8188eu: remove MacAddr_isBcst macro
      staging: rtl8188eu: use is_multicast_ether_addr
      staging: rtl8188eu: remove blank lines
      staging: rtl8188eu: remove blank lines
      staging: rtl8188eu: refactor rtw_is_cckrates_included()
      staging: rtl8188eu: refactor rtw_is_cckratesonly_included()
      staging: rtl8188eu: change return type to bool
      staging: rtl8188eu: fix comparsions to true
      staging: rtl8188eu: remove unnecessary parentheses
      staging: rtl8188eu: replace tabs with spaces
      staging: rtl8188eu: fix lines over 80 characters
      staging: rtl8188eu: remove unused sreset_get_wifi_status()
      staging: rtl8188eu: remove unused ODM_RASupport_Init()
      staging: rtl8188eu: remove unused CAM_empty_entry()
      staging: rtl8188eu: remove unused rtw_get_oper_bw()
      staging: rtl8188eu: remove unused rtw_get_oper_choffset()
      staging: rtl8188eu: fix comparsions to NULL - coding style
      staging: rtl8188eu: replace tabs with spaces
      staging: rtl8188eu: remove unused rtw_calculate_wlan_pkt_size_by_attribue()
      staging: rtl8188eu: remove unused dump_txrpt_ccx_88e()
      staging: rtl8188eu: remove unused should_forbid_n_rate()
      staging: rtl8188eu: remove redundant includes
      staging: rtl8188eu: replace tabs with spaces
      staging: rtl8188eu: fix comparsion to true
      staging: rtl8188eu: remove unnecessary parentheses
      staging: rtl8188eu: use is_multicast_ether_addr
      staging: rtl8188eu: use is_broadcast_ether_addr
      staging: rtl8188eu: fix indentation - style
      staging: rtl8188eu: fix comparsions to NULL - style
      staging: rtl8188eu: remove unnecessary parentheses - style
      staging: rtl8188eu: remove unused rtw_add_bcn_ie()
      staging: rtl8188eu: remove unused rtw_remove_bcn_ie()
      staging: rtl8188eu: rename odm_RTL8188E - style
      staging: rtl8188eu: use phydm_regdefine11n.h from rtlwifi
      staging: rtl8188eu: rename rtw_IOL_applied
      staging: rtl8188eu: remove unnecessary parentheses
      staging: rtl8188eu: remove redundant include
      staging: rtl8188eu: remove unnecessary includes
      Revert "staging:r8188eu: Use lib80211 to encrypt (CCMP) tx frames"
      staging: rtl8188eu: use is_multicast_ether_addr in recv_linux.c
      staging: rtl8188eu: use is_multicast_ether_addr in rtl8188eu_xmit.c
      staging: rtl8188eu: cleanup block comment - style
      staging: rtl8188eu: remove whitespace - style
      staging: rtl8188eu: use is_multicast_ether_addr in rtw_sta_mgt.c
      staging: rtl8188eu: remove whitespace, add missing blank line
      staging: rtl8188eu: remove unused mp_custom_oid.h

NeilBrown (5):
      staging: mt7621-pci: use rt_sysc_?32() to access system-control register.
      staging: mt7621-spi: change mt7621_spi_wait_till_ready to take struct mt7621_spi
      staging: mt7621-spi: revised half-duplex message handling
      staging: mt7621-dts: correct various clock frequencies.
      staging: mt7621-dts: convert to gpio-keys

Nicholas Mc Guire (3):
      staging: bcm2835-camera: handle wait_for_completion_timeout return properly
      staging: bcm2835-camera: fix timeout handling in wait_for_completion_timeout
      iio: ad_sigma_delta: use unsigned long for timeout

Nikolaus Voss (2):
      IIO: st_accel_i2c.c: Simplify access to driver data
      IIO: st_accel_i2c.c: Use probe_new() instead of probe()

Nishad Kamdar (3):
      staging: comedi: comedi_fops: Shift assignment operator '=' to previous line
      staging: dgnc: dgnc_tty.c: Avoid '(' at the end of line
      staging: mt7621-mmc: Use BIT macro instead of explicit shifting in board.h

Oliver Hübers (2):
      staging: mt7621-pci: Include preferred headers
      staging: mt7621: Add SPDX license identifier

Omer Efrat (1):
      staging: use BIT_ULL for NL80211_STA_INFO_* attribute types

Peter Vernia (4):
      staging: mt7621-pci: Fix spaces around parenthesis in pci-7621.c
      staging: mt7621-pci: Fix spacing around equals sign
      staging: mt7621-pci: Add spaces after commas in pci-mt7621.c
      staging: mt7621-pci: Move open-braces to match kernel code style

Quytelda Kahja (11):
      staging: rtl8723bs: Clean up whitespace in 'PHY_GetTxPowerLimit()'.
      staging: rtl8723bs: Rename PHY_GetTxPowerLimit().
      staging: rtl8723bs: Fix camel-case names in phy_get_tx_pwr_lmt().
      staging: rtl8723bs: Combine if statements with equivalent body.
      staging: rtl8723bs: Remove empty else-if conditional.
      staging: rtl8723bs: Move rate section index lookup to new function.
      staging: rtl8723bs: Move bandwidth index lookup to new function.
      staging: rtl8723bs: Fix spelling mistake in comment.
      staging: rtl8723bs: Merge conditionals with similar bodies.
      staging: rtl8723bs: Merge workaround conditionals into single else-if.
      staging: rtl8723bs: Add missing curly braces on else statement.

Radek Dostál (1):
      staging: fbtft: indent fbtft_device_display - last entry - pdev - dev

Randy Dunlap (1):
      staging/rtl8192u: fix defined but not used build warnings

Razvan Stefanescu (1):
      staging: fsl-dpaa2/ethsw: Update maintainers for Ethernet Switch driver

Roman Kiryanov (5):
      staging: goldfish: Replace read and write macros with functions
      staging: goldfish: Fix checkpatch CHECK in goldfish_audio.c
      staging: goldfish: Remove references to the retired driver from README
      staging: goldfish: fix whitespace in goldfish_audio
      staging: goldfish: add a blank line into struct goldfish_audio

Rosen Penev (1):
      staging: mt7621-dts: Fix remaining pcie warnings

Sabin Mihai Rapan (3):
      staging: rtlwifi: Fix "Trafic"->"Traffic"
      staging: rtlwifi: Fix "writen"->"written"
      staging: rtlwifi: Fix "Alwyas"->"Always"

Sankalp Negi (5):
      staging: mt7621-spi: Indent case labels and switch at the same level.
      staging: mt7621-spi: Fix line over 80 characters by refactoring.
      staging: mt7621-spi: Use tabs for indentation instead of spaces.
      staging: mt7621-spi: Add a space before open paranthesis.
      staging: mt7621-spi: Remove unnecessary braces {} from single statement if block.

Sergej Perschin (1):
      staging: mt7621-mmc: Fix printk() facility level

Sergio Paracuellos (59):
      staging: mt7621-pinctrl: add SPDX identifier
      staging: mt7621-pinctrl: replace 'unsigned' types with 'unsigned int'
      staging: mt7621-pinctrl: remove unnecessary 'out of memory' message
      staging: mt7621-pinctrl: replace ENOSYS with better fitting error code
      staging: mt7621-gpio: make use 'bgpio_init' from GPIO_GENERIC
      staging: mt7621-gpio: avoid including 'gpio.h'
      staging: mt7621-gpio: make use of 'builtin_platform_driver'
      staging: mt7621-gpio: implement '.irq_[request|release]_resources' functions
      staging: mt7621-gpio: add COMPILE_TEST
      staging: mt7621-gpio: add kerneldoc for state data containers
      staging: mt7621-gpio: implement high level and low level irqs
      staging: mt7621-gpio: avoid custom irq_domain for gpio
      staging: mt7621-gpio: remove no more necessary PIN_MASK macro
      staging: mt7621-gpio: update kerneldoc for state containers
      staging: mt7621-gpio: align indentation for all defines
      staging: mt7621-gpio: avoid check for NULL in 'to_mediatek_gpio' calls
      staging: mt7621-gpio: avoid to set up irqs if not defined in dts
      staging: mt7621-gpio: avoid one level indentation in interrupt handler
      staging: mt7621-gpio: set different names for each gpio_chip and irq_chip
      staging: mt7621-gpio: avoid long line in a comment
      staging: mt7621-gpio: update Kconfig with SoC details
      staging: mt7621-gpio: avoid use banks in device tree
      staging: mt7621-gpio: set irq chip name only once
      staging: mt7621-gpio: use custom xlate function
      staging: mt7621-gpio: assign gpio chip custom changes after bgpio_init
      staging: mt7621-gpio: use devm_kasprintf to set gpio banks labels
      staging: mt7621-pinctrl: avoid space after if condition
      staging: mt7621-pinctrl: avoid lines over 80 chars
      staging: mt7621-pinctrl: replace seq_printf with seq_puts
      staging: mt7621-pinctrl: align function parameters in some functions
      staging: mt7621-pinctrl: use tabs instead of spaces in some indentations
      staging: mt7621-pinctrl: make use of pinctrl_utils_free_map
      staging: mt7621-pinctrl: replace uint8_t type with u8 for 'gpio' field
      staging: mt7621-pinctrl: make use of pinctrl_utils_reserve_map
      staging: mt7621-dts: use 'function' and 'group' for pinctrl bindings
      staging: mt7621-pinctrl: refactor rt2880_pinctrl_dt_node_to_map function
      staging: mt7621-pinctrl: use ternary operator return in rt2880_get_group_name
      staging: mt7621-pinctrl: remove 'rt2880_pinctrl_pin_dbg_show' callback
      staging: mt7621-pinctrl: replace core_initcall_sync with builtin_platform_driver
      staging: mt7621-pinctrl: init *map to NULL for correct memory assignation
      Revert "staging: mt7621-pinctrl: replace core_initcall_sync with builtin_platform_driver"
      staging: mt7621-gpio: remove driver from staging
      staging: mt7621-pci: remove unused macro MV_READ_DATA
      staging: mt7621-pci: factor out mt7621_pci_get_cfgaddr function
      staging: mt7621-pci: use generic kernel pci subsystem read and write
      staging: mt7621-pci: remove dead code derived to not use custom reads and writes
      staging: mt7621-pci: add pcie_write and pcie_read helpers
      staging: mt7621-pci: use pcie_[read|write] in [write|read]_config
      staging: mt7621-pci: simplify read_config function
      staging: mt7621-pci: simplify write_config function
      staging: mt7621-pci: remove unused macros
      staging: mt7621-pci: avoid register duplication per controller using pcie_[read|write]
      staging: mt7621-pci: review includes putting them in alphabethic order
      staging: mt7621-pci: use pcie_[read|write] in RALINK_PCI_PCICFG_ADDR and RALINK_PCI_PCIMSK_ADDR
      staging: mt7621-pci: remove RALINK_PCI_BASE from remaining definitions
      staging: mt7621-pci: use BIT macro in preprocessor definitions
      staging: mt7621-pci: rename RALINK_PCI_CONFIG_DATA_VIRTUAL_REG definition
      staging: mt7621-pci: remove remaining pci_legacy dependant code
      staging: mt7621-dts: add pcie controller port registers

Simon Que (1):
      drivers/staging: Gasket driver framework + Apex driver

Sohil Ladhani (1):
      Staging: rtlwifi: base: Modified the line ending with a parenthesis

Sophie Matter (3):
      staging: pi433: Comply with 80 character column limit
      staging: pi433: Use preferred commenting style
      staging: pi433: Make only one statement per line

Stefan Popa (3):
      iio:dac:ad5686: Add AD5311R support
      iio: dac: Add AD5758 support
      dt-bindings: iio: dac: Add docs for AD5758 DAC

Steve Longerbeam (2):
      staging: vboxvideo: Pass a new framebuffer to vbox_crtc_do_set_base
      staging: vboxvideo: Add page-flip support

Sumit Pundir (1):
      staging: gasket: fix code indent for conditional statement

Thibaut Robert (1):
      staging: wilc1000: Use common structs to parse ip packets

Tim Collier (10):
      staging: wlan-ng: fix coding style (indentation) in prism2mib.c
      staging: wlan-ng: replace WLAN_CTL_FRAMELEN with inline function in p80211hdr.h
      staging: wlan-ng: replace macro with inline function in prism2mgmt.c
      staging: wlan-ng: add parentheses to macro argument usage in prism2mgmt.c
      staging: wlan-ng: fix expression continuation in prism2fw.c
      staging: wlan-ng: fix expression continuation in prism2mgmt.c
      staging: wlan-ng: remove unneeded parentheses from prism2mgmt.c
      staging: wlan-ng: remove volatile from reapable field in hfa384x_usbctlx
      staging: wlan-ng: correction to comment in hfa384x_usb
      staging: wlan-ng: remove unused definitions from p80211types.h

Tobias Lindskog (1):
      staging: android: ashmem: Shrink directly through shmem_fallocate

Todd Poynor (114):
      drivers/staging/gasket: Use refcount_read()
      staging: gasket: fix typo in apex_enter_reset
      staging: gasket: fix typo in gasket_core.h comments
      staging: gasket: whitespace fix in gasket_page_table_init
      staging: gasket: remove driver registration on class creation failure
      staging: gasket: hold mutex on gasket driver unregistration
      staging: gasket: Return EBUSY on mapping create when already in use
      staging: gasket: Remove stale pointers on error allocating attr array
      staging: gasket: convert gasket_mmap_has_permissions to bool return
      staging: gasket: fix gasket_wait_with_reschedule timeout return code
      staging: gasket: gasket_wait_with_reschedule use msleep
      staging: gasket: gasket_wait_with_reschedule simplify logic
      staging: gasket: gasket_wait_with_reschedule use 32 bits of retry count
      staging: gasket: bail out of reset sequence on device callback error
      staging: gasket: drop gasket_cdev_get_info, use container_of
      staging: gasket: allow compile for ARM64 in Kconfig
      staging: gasket: gasket_enable_dev remove unnecessary variable
      staging: gasket: remove code for no physical device
      staging: gasket: fix class create bug handling
      staging: gasket: remove unnecessary code in coherent allocator
      staging: gasket: don't treat no device reset callback as an error
      staging: gasket: gasket_mmap return error instead of valid BAR index
      staging: gasket: apex_clock_gating simplify logic, reduce indentation
      staging: gasket: gasket page table functions use bool return type
      staging: gasket: remove else clause after return in if clause
      staging: gasket: fix comment syntax in apex.h
      staging: gasket: remove unnecessary parens in page table code
      staging: gasket: gasket_mmap use PAGE_MASK
      staging: gasket: remove extra parens in gasket_write_mappable_regions
      staging: gasket: fix multi-line comment syntax in gasket_core.h
      staging: gasket: always allow root open for write
      staging: gasket: top ioctl handler add __user annotations
      staging: gasket: apex ioctl add __user annotations
      staging: gasket: common ioctl dispatcher add __user annotations
      staging: gasket: common ioctls add __user annotations
      staging: gasket: fix check_and_invoke_callback log param
      staging: gasket: remove duplicate call to retrieve device callback
      staging: gasket: gasket_handle_ioctl fix ioctl exit trace param
      staging: gasket: avoid copy to user on error in coherent alloc config
      staging: gasket: print mmap starting address as unsigned long
      staging: gasket: remove unnecessary NULL checks on calls from VFS
      staging: gasket: gasket_get_device drop check for NULL pci_dev
      staging: gasket: apex return error on sysfs show of missing attribute
      staging: gasket: core: convert various logs to debug level
      staging: gasket: interrupts: convert various logs to debug level
      staging: gasket: ioctl common: convert various logs to debug level
      staging: gasket: page table: convert various logs to debug level
      staging: gasket: page table: remove unnecessary logs
      staging: gasket: apex: convert various logs to debug level
      staging: gasket: save struct device for a gasket device
      staging: gasket: core: convert to standard logging
      staging: gasket: interrupt: convert to standard logging
      staging: gasket: ioctl: convert to standard logging
      staging: gasket: page table: convert to standard logging
      staging: gasket: sysfs: convert to standard logging
      staging: gasket: apex: convert to standard logging
      staging: gasket: remove gasket logging header
      staging: gasket: TODO: remove entry for convert to standard logging
      staging: gasket: don't print device addresses as kernel pointers
      staging: gasket: sysfs: remove check for refcount already zero
      staging: gasket: apex: fixup undefined PCI class
      staging: gasket: sysfs: remove unnecessary NULL check on device ptr
      staging: gasket: page table: remove code for "no dma_ops"
      staging: gasket: core: hold reference on device while in use
      staging: gasket: core: hold reference to pci_dev while used
      staging: gasket: sysfs: hold reference to device while in use
      staging: gasket: page table: hold references to device and pci_dev
      staging: gasket: core: allow root access based on user namespace
      staging: gasket: apex: simplify comments for static functions
      staging: gasket: core: simplify comments for static functions
      staging: gasket: ioctl: simplify comments for static functions
      staging: gasket: page table: simplify comments for static functions
      staging: gasket: interrupt: simplify comments for static functions
      staging: gasket: sysfs: simplify comments for static functions
      staging: gasket: TODO: remove entry for static function kernel docs
      staging: gasket: apex: remove static function forward declarations
      staging: gasket: apex: fix function param line continuation style
      staging: gasket: core: remove static function forward declarations
      staging: gasket: ioctl: remove static function forward declarations
      staging: gasket: interrupt: remove static function forward declarations
      staging: gasket: pg tbl: remove static function forward declarations
      staging: gasket: TODO: remove entry for static function declarations
      staging: gasket: core: fix function param line continuation style
      staging: gasket: ioctl: fix function param line continuation style
      staging: gasket: page table: fix function param line continuation style
      staging: gasket: sysfs: fix function param line continuation style
      staging: gasket: interrupt: fix function param line continuation style
      staging: gasket: TODO: remove entry for multi-line alignment style
      staging: gasket: apex: move driver-private defines out of apex.h
      staging: gasket: core: use bool type for ns_capable result
      Revert "staging: gasket: page table: hold references to device and pci_dev"
      staging: gasket: page table: fix header file include guard symbol
      staging: gasket: remove "reset type" param from framework
      staging: gasket: apex: drop reset type param
      staging: gasket: apex: enable power save mode by default
      staging: gasket: core: remove registration logs
      staging: gasket: core: device register debug log cleanups
      staging: gasket: core: add subsystem and device info to logs
      Revert "staging: gasket: core: hold reference to pci_dev while used"
      staging: gasket: sysfs: clean up state if ENOMEM removing mapping
      staging: gasket: core: move core PCI calls to device drivers
      staging: gasket: apex: move PCI core calls to apex driver
      staging: gasket: core: convert remaining info logs to debug
      staging: gasket: core: remove device enable and disable callbacks
      staging: gasket: apex: remove device enable and disable callbacks
      staging: gasket: core: let device driver enable/disable gasket device
      staging: gasket: apex: enable/disable gasket device from apex
      staging: gasket: core: delete device add and remove callbacks
      staging: gasket: apex: fold device add/remove logic inline
      staging: gasket: core: remove sysfs setup and cleanup callbacks
      staging: gasket: apex: move sysfs setup code to probe function
      staging: gasket: core: protect against races during unregister
      staging: gasket: apex: place in low power reset until opened
      staging: gasket: core: remove incorrect extraneous comment

Tomas Novotny (4):
      iio: vcnl4000: make the driver extendable
      iio: vcnl4000: add VCNL4010 and VCNL4020 device id
      iio: vcnl4000: warn on incorrectly specified device id
      iio: vcnl4000: add support for VCNL4200

Tuomas Tynkkynen (2):
      staging: bcm2835-audio: Check if workqueue allocation failed
      staging: bcm2835-audio: Don't leak workqueue if open fails

Valentin Vidic (3):
      staging: pi433: replace simple switch statements
      staging: pi433: add SPDX-License-Identifier tag
      staging: pi433: cleanup comments in rf69.h

Wei Yongjun (2):
      staging: pi433: fix error return code in pi433_probe()
      staging: axis-fifo: fix return value check in axis_fifo_probe()

William Breathitt Gray (2):
      iio: 104-quad-8: Fix off-by-one error in register selection
      iio: 104-quad-8: Provide defines for magic numbers

Yisheng Xie (1):
      Staging: gdm724x: use match_string() helper

Yu Ning (1):
      staging: goldfish: Enable ACPI-based enumeration for goldfish audio

ankit patel (5):
      Staging: comedi: comedi.h: fixed missing or malformed SPDX-License-Identifier
      Staging: comedi: comedilib.h: fixed missing or malformed SPDX-License-Identifier
      Staging: comedi: comedi_pcmcia.h: fixed missing or malformed SPDX-License-Identifier
      Staging: comedi: comedi_pci.h: fixed missing or malformed SPDX-License-Identifier
      Staging: comedi: comedi_compat32.h: fixed missing or malformed SPDX-License-Identifier

kbuild test robot (1):
      staging: fix platform_no_drv_owner.cocci warnings

zhong jiang (2):
      drivers/staging/mt7621-eth: Use dma_zalloc_coherent to replace dma_alloc_coherent+memset
      staging: gasket: remove some extra semicolon

 Documentation/ABI/testing/sysfs-bus-iio            |   26 +-
 Documentation/ABI/testing/sysfs-bus-iio-isl29501   |   47 +
 .../ABI/testing/sysfs-bus-iio-light-si1133         |   22 +
 .../devicetree/bindings/iio/accel/adxl345.txt      |    7 +-
 .../bindings/iio/adc/amlogic,meson-saradc.txt      |    1 +
 .../bindings/iio/adc/at91-sama5d2_adc.txt          |    9 +
 .../devicetree/bindings/iio/adc/avia-hx711.txt     |    8 +-
 .../bindings/iio/adc/sigma-delta-modulator.txt     |    2 +-
 .../bindings/iio/adc/sprd,sc27xx-adc.txt           |   36 +
 .../devicetree/bindings/iio/dac/ad5758.txt         |   78 +
 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |    1 +
 .../devicetree/bindings/iio/light/isl29501.txt     |   13 +
 .../devicetree/bindings/iio/pressure/bmp085.txt    |    7 -
 .../input/touchscreen/resistive-adc-touch.txt      |   30 +
 .../bindings/input/touchscreen/touchscreen.txt     |    3 +
 MAINTAINERS                                        |   44 +-
 drivers/iio/accel/Kconfig                          |    4 +-
 drivers/iio/accel/adxl345.h                        |    7 +-
 drivers/iio/accel/adxl345_core.c                   |  140 +-
 drivers/iio/accel/adxl345_i2c.c                    |    7 +-
 drivers/iio/accel/adxl345_spi.c                    |    6 +-
 drivers/iio/accel/mma8452.c                        |    1 +
 drivers/iio/accel/sca3000.c                        |    1 +
 drivers/iio/accel/st_accel_i2c.c                   |   64 +-
 drivers/iio/adc/Kconfig                            |   13 +-
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad_sigma_delta.c                   |    5 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |  783 +-
 drivers/iio/adc/hx711.c                            |   39 +
 drivers/iio/adc/ina2xx-adc.c                       |   17 +-
 drivers/iio/adc/max1363.c                          |    8 +-
 drivers/iio/adc/meson_saradc.c                     |    9 +
 drivers/iio/adc/sc27xx_adc.c                       |  522 ++
 drivers/iio/adc/ti-ads7950.c                       |   43 +-
 drivers/iio/adc/xilinx-xadc-core.c                 |   44 +-
 drivers/iio/adc/xilinx-xadc.h                      |    1 +
 drivers/iio/chemical/Kconfig                       |   23 +
 drivers/iio/chemical/Makefile                      |    3 +
 drivers/iio/chemical/bme680.h                      |   96 +
 drivers/iio/chemical/bme680_core.c                 |  959 +++
 drivers/iio/chemical/bme680_i2c.c                  |   85 +
 drivers/iio/chemical/bme680_spi.c                  |  125 +
 drivers/iio/common/st_sensors/st_sensors_core.c    |    3 +-
 drivers/iio/counter/104-quad-8.c                   |   87 +-
 drivers/iio/dac/Kconfig                            |   10 +
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/ad5686.c                           |    7 +
 drivers/iio/dac/ad5686.h                           |    1 +
 drivers/iio/dac/ad5696-i2c.c                       |    1 +
 drivers/iio/dac/ad5758.c                           |  897 +++
 drivers/iio/dac/ltc2632.c                          |    5 -
 drivers/iio/dac/ti-dac5571.c                       |    6 -
 drivers/iio/frequency/ad9523.c                     |   68 +-
 drivers/iio/imu/adis.c                             |    3 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   37 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |    5 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |   38 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |  143 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |   16 +-
 drivers/iio/industrialio-core.c                    |   29 +-
 drivers/iio/light/Kconfig                          |   17 +-
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/si1133.c                         | 1071 +++
 drivers/iio/light/vcnl4000.c                       |  220 +-
 drivers/iio/pressure/st_pressure_i2c.c             |    3 +-
 drivers/iio/proximity/Kconfig                      |   13 +
 drivers/iio/proximity/Makefile                     |    1 +
 drivers/iio/proximity/isl29501.c                   | 1027 +++
 drivers/input/touchscreen/Kconfig                  |   13 +
 drivers/input/touchscreen/Makefile                 |    1 +
 drivers/input/touchscreen/resistive-adc-touch.c    |  204 +
 drivers/staging/Kconfig                            |   12 +-
 drivers/staging/Makefile                           |    5 +-
 drivers/staging/android/ashmem.c                   |   46 +-
 drivers/staging/android/vsoc.c                     |   11 +-
 drivers/staging/axis-fifo/Kconfig                  |    9 +
 drivers/staging/axis-fifo/Makefile                 |    1 +
 drivers/staging/axis-fifo/README                   |    0
 drivers/staging/axis-fifo/axis-fifo.c              | 1107 +++
 drivers/staging/axis-fifo/axis-fifo.txt            |   89 +
 drivers/staging/clocking-wizard/Kconfig            |    2 +-
 drivers/staging/comedi/Kconfig                     |    8 -
 drivers/staging/comedi/comedi.h                    |    2 +-
 drivers/staging/comedi/comedi_compat32.h           |    2 +-
 drivers/staging/comedi/comedi_fops.c               |    6 +-
 drivers/staging/comedi/comedi_pci.h                |    2 +-
 drivers/staging/comedi/comedi_pcmcia.h             |    2 +-
 drivers/staging/comedi/comedidev.h                 |    4 +-
 drivers/staging/comedi/comedilib.h                 |    2 +-
 drivers/staging/comedi/drivers.c                   |   26 +-
 drivers/staging/comedi/drivers/Makefile            |    1 -
 drivers/staging/comedi/drivers/amplc_dio200.h      |    6 +-
 .../staging/comedi/drivers/amplc_dio200_common.c   |    2 +-
 drivers/staging/comedi/drivers/amplc_pci230.c      |   12 +-
 drivers/staging/comedi/drivers/cb_pcimdda.c        |    4 +-
 drivers/staging/comedi/drivers/daqboard2000.c      |    2 +-
 drivers/staging/comedi/drivers/ni_mio_common.c     |    5 +-
 drivers/staging/comedi/drivers/pcl816.c            |    4 +-
 drivers/staging/comedi/drivers/pcl818.c            |    4 +-
 drivers/staging/comedi/drivers/serial2002.c        |  778 --
 drivers/staging/dgnc/dgnc_tty.c                    |    7 +-
 drivers/staging/erofs/Kconfig                      |  141 +
 drivers/staging/erofs/Makefile                     |   13 +
 drivers/staging/erofs/TODO                         |   45 +
 drivers/staging/erofs/data.c                       |  385 +
 drivers/staging/erofs/dir.c                        |  145 +
 drivers/staging/erofs/erofs_fs.h                   |  266 +
 drivers/staging/erofs/include/linux/tagptr.h       |  110 +
 drivers/staging/erofs/include/trace/events/erofs.h |  240 +
 drivers/staging/erofs/inode.c                      |  283 +
 drivers/staging/erofs/internal.h                   |  556 ++
 drivers/staging/erofs/lz4defs.h                    |  227 +
 drivers/staging/erofs/namei.c                      |  251 +
 drivers/staging/erofs/super.c                      |  649 ++
 drivers/staging/erofs/unzip_lz4.c                  |  251 +
 drivers/staging/erofs/unzip_pagevec.h              |  172 +
 drivers/staging/erofs/unzip_vle.c                  | 1656 ++++
 drivers/staging/erofs/unzip_vle.h                  |  239 +
 drivers/staging/erofs/unzip_vle_lz4.c              |  209 +
 drivers/staging/erofs/utils.c                      |  271 +
 drivers/staging/erofs/xattr.c                      |  577 ++
 drivers/staging/erofs/xattr.h                      |   93 +
 drivers/staging/fbtft/fb_hx8347d.c                 |    2 +-
 drivers/staging/fbtft/fb_ili9163.c                 |    2 +-
 drivers/staging/fbtft/fb_ili9320.c                 |    2 +-
 drivers/staging/fbtft/fb_ili9325.c                 |    2 +-
 drivers/staging/fbtft/fb_ili9341.c                 |    2 +-
 drivers/staging/fbtft/fb_s6d02a1.c                 |   31 +-
 drivers/staging/fbtft/fb_s6d1121.c                 |    3 +-
 drivers/staging/fbtft/fb_sh1106.c                  |    2 +-
 drivers/staging/fbtft/fb_ssd1289.c                 |    9 +-
 drivers/staging/fbtft/fb_ssd1306.c                 |    2 +-
 drivers/staging/fbtft/fb_ssd1325.c                 |    2 +-
 drivers/staging/fbtft/fb_ssd1331.c                 |    2 +-
 drivers/staging/fbtft/fb_ssd1351.c                 |   41 +-
 drivers/staging/fbtft/fb_st7735r.c                 |   15 +-
 drivers/staging/fbtft/fb_st7789v.c                 |   13 +-
 drivers/staging/fbtft/fb_uc1611.c                  |    2 +-
 drivers/staging/fbtft/fb_watterott.c               |   26 +-
 drivers/staging/fbtft/fbtft-bus.c                  |   17 +-
 drivers/staging/fbtft/fbtft-core.c                 |   41 +-
 drivers/staging/fbtft/fbtft-io.c                   |   17 +-
 drivers/staging/fbtft/fbtft-sysfs.c                |    3 +-
 drivers/staging/fbtft/fbtft.h                      |   15 +-
 drivers/staging/fbtft/fbtft_device.c               |   50 +-
 drivers/staging/fbtft/flexfb.c                     |   31 +-
 drivers/staging/fsl-dpaa2/ethernet/Makefile        |    1 +
 .../staging/fsl-dpaa2/ethernet/dpaa2-eth-trace.h   |   29 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     |   71 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     |   43 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c |   31 +-
 drivers/staging/fsl-dpaa2/ethernet/dpkg.h          |  450 +-
 drivers/staging/fsl-dpaa2/ethernet/dpni-cmd.h      |   30 +-
 drivers/staging/fsl-dpaa2/ethernet/dpni.c          |   30 +-
 drivers/staging/fsl-dpaa2/ethernet/dpni.h          |  159 +-
 .../ethernet/{README => ethernet-driver.rst}       |   39 +-
 drivers/staging/fsl-dpaa2/ethernet/net.h           |  480 --
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h             |   27 +-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c            |    2 +-
 drivers/staging/gasket/Kconfig                     |   23 +
 drivers/staging/gasket/Makefile                    |    9 +
 drivers/staging/gasket/TODO                        |    9 +
 drivers/staging/gasket/apex.h                      |   30 +
 drivers/staging/gasket/apex_driver.c               |  741 ++
 drivers/staging/gasket/gasket.h                    |  122 +
 drivers/staging/gasket/gasket_constants.h          |   47 +
 drivers/staging/gasket/gasket_core.c               | 1816 +++++
 drivers/staging/gasket/gasket_core.h               |  649 ++
 drivers/staging/gasket/gasket_interrupt.c          |  550 ++
 drivers/staging/gasket/gasket_interrupt.h          |  117 +
 drivers/staging/gasket/gasket_ioctl.c              |  391 +
 drivers/staging/gasket/gasket_ioctl.h              |   28 +
 drivers/staging/gasket/gasket_page_table.c         | 1381 ++++
 drivers/staging/gasket/gasket_page_table.h         |  249 +
 drivers/staging/gasket/gasket_sysfs.c              |  400 +
 drivers/staging/gasket/gasket_sysfs.h              |  179 +
 drivers/staging/gdm724x/gdm_tty.c                  |   18 +-
 drivers/staging/gdm724x/gdm_usb.c                  |    5 -
 drivers/staging/goldfish/README                    |    6 -
 drivers/staging/goldfish/goldfish_audio.c          |   79 +-
 drivers/staging/iio/Kconfig                        |    1 -
 drivers/staging/iio/Makefile                       |    1 -
 drivers/staging/iio/accel/adis16203.c              |    6 +-
 drivers/staging/iio/accel/adis16240.c              |   11 +-
 drivers/staging/iio/adc/ad7606.h                   |    2 +-
 drivers/staging/iio/gyro/Kconfig                   |   16 -
 drivers/staging/iio/gyro/Makefile                  |    6 -
 drivers/staging/iio/gyro/adis16060_core.c          |  234 -
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   57 +-
 drivers/staging/ks7010/ks_hostif.c                 |    2 -
 drivers/staging/most/dim2/dim2.c                   |    2 +-
 drivers/staging/mt7621-dts/gbpc1.dts               |   24 +-
 drivers/staging/mt7621-dts/mt7621.dtsi             |  110 +-
 drivers/staging/mt7621-eth/mtk_eth_soc.c           |   19 +-
 drivers/staging/mt7621-gpio/Kconfig                |    6 -
 drivers/staging/mt7621-gpio/Makefile               |    3 -
 drivers/staging/mt7621-gpio/TODO                   |    3 -
 drivers/staging/mt7621-gpio/gpio-mt7621.c          |  370 -
 .../staging/mt7621-gpio/mediatek,mt7621-gpio.txt   |   68 -
 drivers/staging/mt7621-mmc/board.h                 |    8 +-
 drivers/staging/mt7621-mmc/dbg.c                   |   54 +-
 drivers/staging/mt7621-mmc/dbg.h                   |    6 -
 drivers/staging/mt7621-mmc/mt6575_sd.h             |  588 +-
 drivers/staging/mt7621-mmc/sd.c                    |  584 +-
 drivers/staging/mt7621-pci/Kconfig                 |    7 +
 drivers/staging/mt7621-pci/pci-mt7621.c            |  827 +-
 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c    |  174 +-
 drivers/staging/mt7621-spi/spi-mt7621.c            |  206 +-
 drivers/staging/octeon-usb/Makefile                |    1 +
 drivers/staging/octeon-usb/octeon-hcd.c            |    1 +
 drivers/staging/octeon-usb/octeon-hcd.h            |    1 +
 drivers/staging/olpc_dcon/Kconfig                  |    6 +-
 drivers/staging/olpc_dcon/olpc_dcon.h              |    6 +-
 drivers/staging/pi433/pi433_if.c                   |   93 +-
 drivers/staging/pi433/pi433_if.h                   |    9 +-
 drivers/staging/pi433/rf69.c                       |  283 +-
 drivers/staging/pi433/rf69.h                       |   12 +-
 drivers/staging/pi433/rf69_enum.h                  |    3 +-
 drivers/staging/pi433/rf69_registers.h             |    3 +-
 drivers/staging/rtl8188eu/Makefile                 |    4 +-
 drivers/staging/rtl8188eu/core/rtw_ap.c            |  126 +-
 drivers/staging/rtl8188eu/core/rtw_cmd.c           |   12 +-
 drivers/staging/rtl8188eu/core/rtw_debug.c         |   10 +-
 drivers/staging/rtl8188eu/core/rtw_efuse.c         |   65 +-
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c     |  121 +-
 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c     |   28 +-
 drivers/staging/rtl8188eu/core/rtw_iol.c           |   17 +-
 drivers/staging/rtl8188eu/core/rtw_led.c           |   12 +-
 drivers/staging/rtl8188eu/core/rtw_mlme.c          |   19 +-
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c      |   56 +-
 drivers/staging/rtl8188eu/core/rtw_pwrctrl.c       |   16 +-
 drivers/staging/rtl8188eu/core/rtw_recv.c          |   19 +-
 drivers/staging/rtl8188eu/core/rtw_rf.c            |   10 +-
 drivers/staging/rtl8188eu/core/rtw_security.c      |   92 +-
 drivers/staging/rtl8188eu/core/rtw_sreset.c        |   37 +-
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c       |   71 +-
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c     |   83 +-
 drivers/staging/rtl8188eu/core/rtw_xmit.c          |   74 +-
 drivers/staging/rtl8188eu/hal/bb_cfg.c             |   10 +-
 drivers/staging/rtl8188eu/hal/fw.c                 |   13 +-
 ...188ERateAdaptive.c => hal8188e_rate_adaptive.c} |   10 -
 drivers/staging/rtl8188eu/hal/hal_com.c            |   75 +-
 drivers/staging/rtl8188eu/hal/hal_intf.c           |   26 +-
 drivers/staging/rtl8188eu/hal/mac_cfg.c            |   19 +-
 drivers/staging/rtl8188eu/hal/odm.c                |   21 +-
 drivers/staging/rtl8188eu/hal/odm_HWConfig.c       |   10 +-
 .../hal/{odm_RTL8188E.c => odm_rtl8188e.c}         |   10 +-
 drivers/staging/rtl8188eu/hal/phy.c                |   14 +-
 drivers/staging/rtl8188eu/hal/pwrseq.c             |   10 +-
 drivers/staging/rtl8188eu/hal/pwrseqcmd.c          |   10 +-
 drivers/staging/rtl8188eu/hal/rf.c                 |   11 +-
 drivers/staging/rtl8188eu/hal/rf_cfg.c             |   18 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c       |   15 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_dm.c        |   10 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c  |   16 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c    |   10 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_xmit.c      |   32 +-
 drivers/staging/rtl8188eu/hal/rtl8188eu_led.c      |   11 +-
 drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c     |   11 +-
 drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c     |   43 +-
 drivers/staging/rtl8188eu/hal/usb_halinit.c        |   13 +-
 drivers/staging/rtl8188eu/include/HalVerDef.h      |   10 +-
 drivers/staging/rtl8188eu/include/basic_types.h    |   12 +-
 drivers/staging/rtl8188eu/include/drv_types.h      |   10 +-
 drivers/staging/rtl8188eu/include/fw.h             |   13 +-
 .../{Hal8188EPhyCfg.h => hal8188e_phy_cfg.h}       |   10 +-
 .../{Hal8188EPhyReg.h => hal8188e_phy_reg.h}       |   10 +-
 ...188ERateAdaptive.h => hal8188e_rate_adaptive.h} |    2 -
 drivers/staging/rtl8188eu/include/hal_com.h        |   10 +-
 drivers/staging/rtl8188eu/include/hal_intf.h       |   12 +-
 drivers/staging/rtl8188eu/include/ieee80211.h      |   25 +-
 drivers/staging/rtl8188eu/include/mlme_osdep.h     |   10 +-
 drivers/staging/rtl8188eu/include/mon.h            |   10 +-
 drivers/staging/rtl8188eu/include/mp_custom_oid.h  |  347 -
 drivers/staging/rtl8188eu/include/odm.h            |   12 +-
 drivers/staging/rtl8188eu/include/odm_HWConfig.h   |   11 +-
 .../staging/rtl8188eu/include/odm_RegDefine11N.h   |  166 -
 drivers/staging/rtl8188eu/include/odm_debug.h      |   10 +-
 drivers/staging/rtl8188eu/include/odm_precomp.h    |   16 +-
 drivers/staging/rtl8188eu/include/odm_reg.h        |   10 +-
 .../include/{odm_RTL8188E.h => odm_rtl8188e.h}     |   10 +-
 drivers/staging/rtl8188eu/include/odm_types.h      |   10 +-
 drivers/staging/rtl8188eu/include/osdep_intf.h     |   10 +-
 drivers/staging/rtl8188eu/include/osdep_service.h  |   10 +-
 drivers/staging/rtl8188eu/include/pwrseq.h         |   11 +-
 drivers/staging/rtl8188eu/include/pwrseqcmd.h      |   10 +-
 drivers/staging/rtl8188eu/include/recv_osdep.h     |   10 +-
 drivers/staging/rtl8188eu/include/rtl8188e_cmd.h   |   10 +-
 drivers/staging/rtl8188eu/include/rtl8188e_dm.h    |   10 +-
 drivers/staging/rtl8188eu/include/rtl8188e_hal.h   |   14 +-
 drivers/staging/rtl8188eu/include/rtl8188e_led.h   |   28 -
 drivers/staging/rtl8188eu/include/rtl8188e_recv.h  |   10 +-
 drivers/staging/rtl8188eu/include/rtl8188e_spec.h  |   10 +-
 drivers/staging/rtl8188eu/include/rtl8188e_xmit.h  |   11 +-
 drivers/staging/rtl8188eu/include/rtw_android.h    |   10 +-
 drivers/staging/rtl8188eu/include/rtw_ap.h         |   14 +-
 drivers/staging/rtl8188eu/include/rtw_cmd.h        |   10 +-
 drivers/staging/rtl8188eu/include/rtw_debug.h      |   10 +-
 drivers/staging/rtl8188eu/include/rtw_eeprom.h     |   10 +-
 drivers/staging/rtl8188eu/include/rtw_efuse.h      |   12 +-
 drivers/staging/rtl8188eu/include/rtw_event.h      |   10 +-
 drivers/staging/rtl8188eu/include/rtw_ht.h         |   10 +-
 drivers/staging/rtl8188eu/include/rtw_ioctl.h      |   10 +-
 drivers/staging/rtl8188eu/include/rtw_ioctl_rtl.h  |   74 -
 drivers/staging/rtl8188eu/include/rtw_ioctl_set.h  |   10 +-
 drivers/staging/rtl8188eu/include/rtw_iol.h        |   13 +-
 drivers/staging/rtl8188eu/include/rtw_led.h        |   11 +-
 drivers/staging/rtl8188eu/include/rtw_mlme.h       |   10 +-
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h   |   14 +-
 .../staging/rtl8188eu/include/rtw_mp_phy_regdef.h  | 1086 ---
 drivers/staging/rtl8188eu/include/rtw_pwrctrl.h    |   10 +-
 drivers/staging/rtl8188eu/include/rtw_qos.h        |   10 +-
 drivers/staging/rtl8188eu/include/rtw_recv.h       |   10 +-
 drivers/staging/rtl8188eu/include/rtw_rf.h         |   10 +-
 drivers/staging/rtl8188eu/include/rtw_security.h   |   10 +-
 drivers/staging/rtl8188eu/include/rtw_sreset.h     |   11 +-
 drivers/staging/rtl8188eu/include/rtw_xmit.h       |   12 +-
 drivers/staging/rtl8188eu/include/sta_info.h       |   10 +-
 drivers/staging/rtl8188eu/include/usb_ops_linux.h  |   10 +-
 drivers/staging/rtl8188eu/include/wifi.h           |   17 +-
 drivers/staging/rtl8188eu/include/wlan_bssdef.h    |   10 +-
 drivers/staging/rtl8188eu/include/xmit_osdep.h     |   10 +-
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c     |   72 +-
 drivers/staging/rtl8188eu/os_dep/mlme_linux.c      |   13 +-
 drivers/staging/rtl8188eu/os_dep/mon.c             |   10 +-
 drivers/staging/rtl8188eu/os_dep/os_intfs.c        |   16 +-
 drivers/staging/rtl8188eu/os_dep/osdep_service.c   |   10 +-
 drivers/staging/rtl8188eu/os_dep/recv_linux.c      |   27 +-
 drivers/staging/rtl8188eu/os_dep/rtw_android.c     |   10 +-
 drivers/staging/rtl8188eu/os_dep/usb_intf.c        |   19 +-
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c   |   38 +-
 drivers/staging/rtl8188eu/os_dep/xmit_linux.c      |   16 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c          |   22 +-
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c       |   56 +-
 drivers/staging/rtl8192u/ieee80211/dot11d.c        |   60 +-
 drivers/staging/rtl8192u/ieee80211/dot11d.h        |   59 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211.h     |   22 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c      |   57 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c  |   86 +-
 .../staging/rtl8192u/ieee80211/ieee80211_softmac.c | 1018 +--
 .../rtl8192u/ieee80211/ieee80211_softmac_wx.c      |    6 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c  |   18 +-
 .../staging/rtl8192u/ieee80211/rtl819x_BAProc.c    |  179 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h    |  127 +-
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c    |  643 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h   |  595 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h    |  126 +-
 .../staging/rtl8192u/ieee80211/rtl819x_TSProc.c    |  280 +-
 drivers/staging/rtl8192u/r8190_rtl8256.c           |   44 +-
 drivers/staging/rtl8192u/r8190_rtl8256.h           |    2 +-
 drivers/staging/rtl8192u/r8192U.h                  |  114 +-
 drivers/staging/rtl8192u/r8192U_core.c             |   75 +-
 drivers/staging/rtl8192u/r8192U_dm.c               |  195 +-
 drivers/staging/rtl8192u/r8192U_dm.h               |  240 +-
 drivers/staging/rtl8192u/r819xU_cmdpkt.c           |   38 +-
 drivers/staging/rtl8192u/r819xU_cmdpkt.h           |   33 +-
 drivers/staging/rtl8192u/r819xU_phy.c              |  276 +-
 drivers/staging/rtl8192u/r819xU_phy.h              |   71 +-
 drivers/staging/rtl8192u/r819xU_phyreg.h           |  735 +-
 drivers/staging/rtl8712/rtl8712_led.c              |    3 -
 drivers/staging/rtl8723bs/core/rtw_btcoex.c        |   14 +-
 drivers/staging/rtl8723bs/core/rtw_efuse.c         |   18 +-
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c     |  143 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |    6 +-
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c     |  108 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c          |    4 +-
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c     |    5 +-
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c     |  268 +-
 drivers/staging/rtl8723bs/hal/odm.h                |    2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c    |    2 +-
 drivers/staging/rtl8723bs/include/hal_com_phycfg.h |    2 +-
 drivers/staging/rtl8723bs/include/ieee80211.h      |    4 +-
 drivers/staging/rtl8723bs/include/rtl8192c_rf.h    |   28 -
 drivers/staging/rtl8723bs/include/rtl8723b_rf.h    |    1 -
 .../staging/rtl8723bs/include/rtw_beamforming.h    |  127 -
 drivers/staging/rtl8723bs/include/rtw_br_ext.h     |   55 -
 drivers/staging/rtl8723bs/include/xmit_osdep.h     |    2 -
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |   19 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c     |  108 +-
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c       |   19 +-
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c      |    5 -
 drivers/staging/rtlwifi/base.c                     |  107 +-
 drivers/staging/rtlwifi/halmac/halmac_api.h        |    1 -
 drivers/staging/rtlwifi/halmac/halmac_pcie_reg.h   |   17 -
 drivers/staging/rtlwifi/halmac/rtl_halmac.c        |    2 +-
 drivers/staging/rtlwifi/phydm/phydm.c              |    2 +-
 drivers/staging/rtlwifi/rtl8822be/fw.c             |    2 +-
 drivers/staging/rtlwifi/rtl8822be/sw.c             |    2 +-
 drivers/staging/rts5208/Makefile                   |    2 +-
 drivers/staging/rts5208/ms.c                       |  337 -
 drivers/staging/rts5208/rtsx.c                     |   38 +-
 drivers/staging/rts5208/rtsx.h                     |   25 -
 drivers/staging/rts5208/rtsx_card.c                |   29 -
 drivers/staging/rts5208/rtsx_card.h                |    1 -
 drivers/staging/rts5208/rtsx_chip.c                |  140 -
 drivers/staging/rts5208/rtsx_chip.h                |   18 -
 drivers/staging/rts5208/rtsx_scsi.c                |  216 -
 drivers/staging/rts5208/rtsx_transport.c           |    1 -
 drivers/staging/rts5208/sd.c                       |  328 +-
 drivers/staging/rts5208/spi.c                      |   71 -
 drivers/staging/rts5208/trace.c                    |   27 -
 drivers/staging/rts5208/trace.h                    |   40 -
 drivers/staging/rts5208/xd.c                       |  115 +-
 drivers/staging/skein/Kconfig                      |   16 -
 drivers/staging/skein/Makefile                     |   11 -
 drivers/staging/skein/TODO                         |    8 -
 drivers/staging/skein/skein_api.c                  |  231 -
 drivers/staging/skein/skein_api.h                  |  230 -
 drivers/staging/skein/skein_base.c                 |  870 ---
 drivers/staging/skein/skein_base.h                 |  336 -
 drivers/staging/skein/skein_block.c                |  469 --
 drivers/staging/skein/skein_block.h                |  347 -
 drivers/staging/skein/skein_generic.c              |  214 -
 drivers/staging/skein/skein_iv.h                   |  187 -
 drivers/staging/skein/threefish_api.c              |   78 -
 drivers/staging/skein/threefish_api.h              |  171 -
 drivers/staging/skein/threefish_block.c            | 8244 --------------------
 drivers/staging/sm750fb/sm750.c                    |    2 -
 drivers/staging/speakup/kobjects.c                 |    4 +-
 drivers/staging/speakup/spk_types.h                |    2 +
 drivers/staging/speakup/synth.c                    |   40 +-
 drivers/staging/speakup/varhandlers.c              |    5 +-
 drivers/staging/vboxvideo/TODO                     |    1 -
 drivers/staging/vboxvideo/vbox_drv.c               |   34 +-
 drivers/staging/vboxvideo/vbox_drv.h               |    2 +-
 drivers/staging/vboxvideo/vbox_main.c              |    2 +-
 drivers/staging/vboxvideo/vbox_mode.c              |   34 +-
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c    |  127 +-
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  |    7 +-
 .../vc04_services/bcm2835-camera/mmal-vchiq.c      |   11 +-
 .../interface/vchiq_arm/vchiq_debugfs.c            |    4 +-
 drivers/staging/vt6655/dpc.c                       |    4 +-
 drivers/staging/vt6656/dpc.c                       |    4 +-
 drivers/staging/vt6656/rxtx.c                      |    5 +-
 drivers/staging/wilc1000/Makefile                  |    3 +-
 drivers/staging/wilc1000/TODO                      |   11 -
 drivers/staging/wilc1000/coreconfigurator.c        |   89 +-
 drivers/staging/wilc1000/coreconfigurator.h        |   25 +-
 drivers/staging/wilc1000/host_interface.c          | 2513 +++---
 drivers/staging/wilc1000/host_interface.h          |   34 +-
 drivers/staging/wilc1000/linux_mon.c               |   23 +-
 drivers/staging/wilc1000/linux_wlan.c              |  177 +-
 .../staging/wilc1000/microchip,wilc1000,sdio.txt   |   32 +
 .../staging/wilc1000/microchip,wilc1000,spi.txt    |   26 +
 drivers/staging/wilc1000/wilc_debugfs.c            |   28 +-
 drivers/staging/wilc1000/wilc_sdio.c               |   57 +-
 drivers/staging/wilc1000/wilc_spi.c                |   54 +-
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c  |  347 +-
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.h  |    5 +
 drivers/staging/wilc1000/wilc_wfi_netdevice.h      |   41 +-
 drivers/staging/wilc1000/wilc_wlan.c               |  291 +-
 drivers/staging/wilc1000/wilc_wlan.h               |   21 +-
 drivers/staging/wilc1000/wilc_wlan_cfg.c           |   38 +-
 drivers/staging/wilc1000/wilc_wlan_cfg.h           |   16 +-
 drivers/staging/wilc1000/wilc_wlan_if.h            |   70 +-
 drivers/staging/wlan-ng/cfg80211.c                 |   44 +-
 drivers/staging/wlan-ng/hfa384x.h                  |    2 +-
 drivers/staging/wlan-ng/hfa384x_usb.c              |    2 +-
 drivers/staging/wlan-ng/p80211hdr.h                |   30 +-
 drivers/staging/wlan-ng/p80211types.h              |   27 -
 drivers/staging/wlan-ng/prism2fw.c                 |    7 +-
 drivers/staging/wlan-ng/prism2mgmt.c               |   41 +-
 drivers/staging/wlan-ng/prism2mib.c                |    8 +-
 include/dt-bindings/iio/adc/at91-sama5d2_adc.h     |   16 +
 include/uapi/linux/iio/types.h                     |    3 +
 tools/iio/iio_event_monitor.c                      |    6 +
 466 files changed, 28224 insertions(+), 27633 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-isl29501
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-si1133
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5758.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/isl29501.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt
 create mode 100644 drivers/iio/adc/sc27xx_adc.c
 create mode 100644 drivers/iio/chemical/bme680.h
 create mode 100644 drivers/iio/chemical/bme680_core.c
 create mode 100644 drivers/iio/chemical/bme680_i2c.c
 create mode 100644 drivers/iio/chemical/bme680_spi.c
 create mode 100644 drivers/iio/dac/ad5758.c
 create mode 100644 drivers/iio/light/si1133.c
 create mode 100644 drivers/iio/proximity/isl29501.c
 create mode 100644 drivers/input/touchscreen/resistive-adc-touch.c
 create mode 100644 drivers/staging/axis-fifo/Kconfig
 create mode 100644 drivers/staging/axis-fifo/Makefile
 create mode 100644 drivers/staging/axis-fifo/README
 create mode 100644 drivers/staging/axis-fifo/axis-fifo.c
 create mode 100644 drivers/staging/axis-fifo/axis-fifo.txt
 delete mode 100644 drivers/staging/comedi/drivers/serial2002.c
 create mode 100644 drivers/staging/erofs/Kconfig
 create mode 100644 drivers/staging/erofs/Makefile
 create mode 100644 drivers/staging/erofs/TODO
 create mode 100644 drivers/staging/erofs/data.c
 create mode 100644 drivers/staging/erofs/dir.c
 create mode 100644 drivers/staging/erofs/erofs_fs.h
 create mode 100644 drivers/staging/erofs/include/linux/tagptr.h
 create mode 100644 drivers/staging/erofs/include/trace/events/erofs.h
 create mode 100644 drivers/staging/erofs/inode.c
 create mode 100644 drivers/staging/erofs/internal.h
 create mode 100644 drivers/staging/erofs/lz4defs.h
 create mode 100644 drivers/staging/erofs/namei.c
 create mode 100644 drivers/staging/erofs/super.c
 create mode 100644 drivers/staging/erofs/unzip_lz4.c
 create mode 100644 drivers/staging/erofs/unzip_pagevec.h
 create mode 100644 drivers/staging/erofs/unzip_vle.c
 create mode 100644 drivers/staging/erofs/unzip_vle.h
 create mode 100644 drivers/staging/erofs/unzip_vle_lz4.c
 create mode 100644 drivers/staging/erofs/utils.c
 create mode 100644 drivers/staging/erofs/xattr.c
 create mode 100644 drivers/staging/erofs/xattr.h
 rename drivers/staging/fsl-dpaa2/ethernet/{README => ethernet-driver.rst} (94%)
 delete mode 100644 drivers/staging/fsl-dpaa2/ethernet/net.h
 create mode 100644 drivers/staging/gasket/Kconfig
 create mode 100644 drivers/staging/gasket/Makefile
 create mode 100644 drivers/staging/gasket/TODO
 create mode 100644 drivers/staging/gasket/apex.h
 create mode 100644 drivers/staging/gasket/apex_driver.c
 create mode 100644 drivers/staging/gasket/gasket.h
 create mode 100644 drivers/staging/gasket/gasket_constants.h
 create mode 100644 drivers/staging/gasket/gasket_core.c
 create mode 100644 drivers/staging/gasket/gasket_core.h
 create mode 100644 drivers/staging/gasket/gasket_interrupt.c
 create mode 100644 drivers/staging/gasket/gasket_interrupt.h
 create mode 100644 drivers/staging/gasket/gasket_ioctl.c
 create mode 100644 drivers/staging/gasket/gasket_ioctl.h
 create mode 100644 drivers/staging/gasket/gasket_page_table.c
 create mode 100644 drivers/staging/gasket/gasket_page_table.h
 create mode 100644 drivers/staging/gasket/gasket_sysfs.c
 create mode 100644 drivers/staging/gasket/gasket_sysfs.h
 delete mode 100644 drivers/staging/iio/gyro/Kconfig
 delete mode 100644 drivers/staging/iio/gyro/Makefile
 delete mode 100644 drivers/staging/iio/gyro/adis16060_core.c
 delete mode 100644 drivers/staging/mt7621-gpio/Kconfig
 delete mode 100644 drivers/staging/mt7621-gpio/Makefile
 delete mode 100644 drivers/staging/mt7621-gpio/TODO
 delete mode 100644 drivers/staging/mt7621-gpio/gpio-mt7621.c
 delete mode 100644 drivers/staging/mt7621-gpio/mediatek,mt7621-gpio.txt
 create mode 100644 drivers/staging/mt7621-pci/Kconfig
 rename drivers/staging/rtl8188eu/hal/{Hal8188ERateAdaptive.c => hal8188e_rate_adaptive.c} (99%)
 rename drivers/staging/rtl8188eu/hal/{odm_RTL8188E.c => odm_rtl8188e.c} (96%)
 rename drivers/staging/rtl8188eu/include/{Hal8188EPhyCfg.h => hal8188e_phy_cfg.h} (92%)
 rename drivers/staging/rtl8188eu/include/{Hal8188EPhyReg.h => hal8188e_phy_reg.h} (98%)
 rename drivers/staging/rtl8188eu/include/{Hal8188ERateAdaptive.h => hal8188e_rate_adaptive.h} (97%)
 delete mode 100644 drivers/staging/rtl8188eu/include/mp_custom_oid.h
 delete mode 100644 drivers/staging/rtl8188eu/include/odm_RegDefine11N.h
 rename drivers/staging/rtl8188eu/include/{odm_RTL8188E.h => odm_rtl8188e.h} (73%)
 delete mode 100644 drivers/staging/rtl8188eu/include/rtl8188e_led.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_ioctl_rtl.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_mp_phy_regdef.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtl8192c_rf.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_beamforming.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_br_ext.h
 delete mode 100644 drivers/staging/rtlwifi/halmac/halmac_pcie_reg.h
 delete mode 100644 drivers/staging/rts5208/trace.c
 delete mode 100644 drivers/staging/rts5208/trace.h
 delete mode 100644 drivers/staging/skein/Kconfig
 delete mode 100644 drivers/staging/skein/Makefile
 delete mode 100644 drivers/staging/skein/TODO
 delete mode 100644 drivers/staging/skein/skein_api.c
 delete mode 100644 drivers/staging/skein/skein_api.h
 delete mode 100644 drivers/staging/skein/skein_base.c
 delete mode 100644 drivers/staging/skein/skein_base.h
 delete mode 100644 drivers/staging/skein/skein_block.c
 delete mode 100644 drivers/staging/skein/skein_block.h
 delete mode 100644 drivers/staging/skein/skein_generic.c
 delete mode 100644 drivers/staging/skein/skein_iv.h
 delete mode 100644 drivers/staging/skein/threefish_api.c
 delete mode 100644 drivers/staging/skein/threefish_api.h
 delete mode 100644 drivers/staging/skein/threefish_block.c
 create mode 100644 drivers/staging/wilc1000/microchip,wilc1000,sdio.txt
 create mode 100644 drivers/staging/wilc1000/microchip,wilc1000,spi.txt
 create mode 100644 include/dt-bindings/iio/adc/at91-sama5d2_adc.h
