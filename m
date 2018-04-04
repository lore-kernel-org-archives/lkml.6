Date: Wed, 4 Apr 2018 12:32:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Subject: [GIT PULL] Staging/IIO driver changes for 4.17-rc1
Message-ID: <20180404103219.GA11115@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit 3eb2ce825ea1ad89d20f7a3b5780df850e4be274:

  Linux 4.16-rc7 (2018-03-25 12:44:30 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/ tags/staging-4.17-rc1

for you to fetch changes up to 049b5e2ae30b3c2f870cc9550af6f9a947fbd5b5:

  staging: rtl8723bs: Remove yield call, replace with cond_resched() (2018-03-29 12:00:15 +0200)

----------------------------------------------------------------
Staging/IIO patches for 4.17-rc1

Here is the big set of Staging/IIO driver patches for 4.17-rc1.

It is a lot, over 500 changes, but not huge by previous kernel release
standards.  We deleted more lines than we added again (27k added vs. 91k
remvoed), thanks to finally being able to delete the IRDA drivers and
networking code.

We also deleted the ccree crypto driver, but that's coming back in
through the crypto tree to you, in a much cleaned-up form.

Added this round is at lot of "mt7621" device support, which is for an
embedded device that Neil Brown cares about, and of course a handful of
new IIO drivers as well.

And finally, the fsl-mc core code moved out of the staging tree to the
"real" part of the kernel, which is nice to see happen as well.

Full details are in the shortlog, which has all of the tiny cleanup
patches described.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ajay Singh (101):
      staging: wilc1000: rename variables using camelCase in host_int_ParseJoinBssParam()
      staging: wilc1000: rename Handle_DelAllSta() and its variable using camelCase
      staging: wilc1000: rename strWIDList variable to avoid camelCase
      staging: wilc1000: rename u32WidsCount to avoid camelCase
      staging: wilc1000: rename pu8CurrByte variable to avoid camelCase
      staging: wilc1000: rename Handle_ScanDone function to avoid camelCase
      staging: wilc1000: rename Handle_Key() and Handle_ConnectTimeout()
      staging: wilc1000: modified code comments as per linux coding style
      staging: wilc1000: removed the unnecessary commented code
      staging: wilc1000: fix line over 80 characters in spi_cmd_complete()
      staging: wilc1000: fix line over 80 characters in wilc_spi_init()
      staging: wilc1000: fix line over 80 characters in wilc_spi_read_int()
      staging: wilc1000: fix line over 80 chars in wilc_spi_clear_int_ext()
      staging: wilc1000: remove unnecessary comments to avoid line over 80 char issue
      staging: wilc1000: fix too many leading tabs warning in sdio_clear_int_ext()
      staging: wilc1000: fix line over 80 characters in sdio_clear_int_ext()
      staging: wilc1000: fix open parenthesis alignment mismatch in wilc_parse_network_info()
      staging: wilc1000: fix line over 80 char in wilc_wlan_cfg_set_str()
      staging: wilc1000: remove blank line before close brace in wilc_wlan_cfg_get_wid_value()
      staging: wilc1000: fix line over 80 chars in wilc_wlan_cfg_indicate_rxi()
      staging: wilc1000: fix line over 80 chars in wilc_wlan_cfg_get_wid_value()
      staging: wilc1000: fix line over 80 chars in add_tcp_pending_ack()
      staging: wilc1000: fix line over 80 characters in tcp_process()
      staging: wilc1000: fix line over 80 chars in wilc_wlan_txq_filter_dup_tcp_ack()
      staging: wilc1000: fix line over 80 chars in wilc_wlan_handle_txq()
      staging: wilc1000: rename s8PowerMode & strPowerMgmtParam to avoid camelCase
      staging: wilc1000: rename strHostIfSetMulti to avoid camelCase
      staging: wilc1000: rename host_int_get_assoc_res_info() parameters to avoid camelCase
      staging: wilc1000: rename pstrHostIfRemainOnChan to avoid camelCase
      staging: wilc1000: rename pstrHostIfRegisterFrame to avoid camelCase
      staging: wilc1000: rename strHostIfStaInactiveT to avoid camelCase
      staging: wilc1000: rename pstrRcvdGnrlAsyncInfo to avoid camelCase
      staging: wilc1000: rename pstrRcvdNetworkInfo to avoid camelCase
      staging: wilc1000: rename functions starting with Handle_ to avoid camelCase
      staging: wilc1000: rename functions starting with TimerCB_ to avoid camelCase
      staging: wilc1000: rename ListenTimerCB to avoid camelCase
      staging: wilc1000: rename GetPeriodicRSSI to avoid camelCase
      staging: wilc1000: rename wilc_remove_key() parameters to avoid camelCase
      staging: wilc1000: remove Unnecessary parentheses around 'hif_set_mc->cnt'
      staging: wilc1000: rename pu8HdnNtwrksWidVal to avoid camelCase
      staging: wilc1000: rename ptstrJoinBssParam to avoid camelCase
      staging: wilc1000: rename variables using camelCase in handle_rcvd_ntwrk_info()
      staging: wilc1000: rename pu32InactiveTime to avoid camelCase
      staging: wilc1000: rename Handle_SetMulticastFilter to avoid camelCase
      staging: wilc1000: rename pstrSetBeaconParam to avoid camelCase
      staging: wilc1000: rename pstrStatistics to avoid camelCase
      staging: wilc1000: rename strDisconnectNotifInfo to avoid camelCase
      staging: wilc1000: rename pstrDelStaParam to avoid camelCase
      staging: wilc1000: rename pstrStationParam to avoid camelCase
      staging: wilc1000: rename _WPAPtk_end_case_ label to avoid camelCase
      staging: wilc1000: rename _WPARxGtk_end_case_ label to avoid camelCase
      staging: wilc1000: remove unnecessary while(0) in wilc_wlan_handle_txq()
      staging: wilc1000: rename label _end_ in wilc_wlan_handle_txq()
      staging: wilc1000: fix line over 80 char in wilc_wlan_handle_txq()
      staging: wilc1000: move multiple definition of same macro to common header
      staging: wilc1000: rename WILC_WFI_mgmt_rx() to avoid camelCase
      staging: wilc1000: fix open parenthesis mismatch in wilc_wlan_cfg_get()
      staging: wilc1000: fix line over 80 char in wilc_wlan_cfg_set()
      staging: wilc1000: fix line over 80 char in wilc_wlan_handle_rxq()
      staging: wilc1000: rename enuEvent to avoid camelCase
      staging: wilc1000: remove always 'true' check from 'if' statement
      staging: wilc1000: fix line over 80 char in handle_cfg_param()
      staging: wilc1000: fix line over 80 char in wilc_network_info_received()
      staging: wilc1000: fix line over 80 char for wilc_gnrl_async_info_received()
      staging: wilc1000: fix line over 80 char in host_int_parse_join_bss_param()
      staging: wilc1000: rename pstrHostIFkeyAttr to avoid camelCase issue
      staging: wilc1000: fix line over 80 char in wilc_add_ptk()
      staging: wilc1000: fix line over 80 char in wilc_del_allstation() & wilc_deinit()
      staging: wilc1000: fix line over 80 char in wilc_scan_complete_received()
      staging: wilc1000: rename handle_connect_timeout() variables to avoid camelCase
      staging: wilc1000: fix line over 80 char in handle_rcvd_ntwrk_info()
      staging: wilc1000: rename u16DummyReasonCode to avoid camelCase
      staging: wilc1000: rename strHiddenNetwork to avoid camelCase
      staging: wilc1000: rename pstrNetworkInfo to avoid camelCase
      staging: wilc1000: rename CfgScanResult to avoid camelCase
      staging: wilc1000: rename au8ScanChanList to avoid camelCase
      staging: wilc1000: fix line over 80 char in change_virtual_intf()
      staging: wilc1000: fix line over 80 char in get_key() & set_default_key()
      staging: wilc1000: fix line over 80 char for cfg parse RX and TX function
      staging: wilc1000: fix line over 80 char in mgmt_tx_cancel_wait()
      staging: wilc1000: rename pJoinParams to avoid camelCase
      staging: wilc1000: fix line over 80 char in cfg_scan_result()
      staging: wilc1000: rename pstrHostIFconnectAttr to avoid camelCase issue
      staging: wilc1000: rename strConnectInfo to avoid camelCase
      staging: wilc1000: rename label 'ERRORHANDLER' to avoid uppercase name
      staging: wilc1000: fix line over 80 char in handle_scan()
      staging: wilc1000: fix line over 80 char in handle_connect()
      staging: wilc1000: fix line over 80 character in handle_disconnect()
      staging: wilc1000: rename variables prefix using datatype 'u8'
      staging: wilc1000: rename WILC_HostIf_PackStaParam to avoid camelCase
      staging: wilc1000: rename variables using camelCase in handle_rcvd_gnrl_async_info()
      staging: wilc1000: fix line over 80 char issue in handle_scan_done()
      staging: wilc1000: remove unused global variables related to p2p
      staging: wilc1000: avoid 'NULL' pointer access in wilc_network_info_received()
      staging: wilc1000: free allocated memory in edit and add station functions
      staging: wilc1000: free memory allocated in add wep key functions
      staging: wilc1000: free allocated memory after processing wilc_send_config_pkt()
      staging: wilc1000: fix to free allocated memory in wilc_add_ptk()
      staging: wilc1000: free allocated memory in wilc_add_rx_gtk()
      staging: wilc1000: split handle_rcvd_gnrl_async_info() to avoid leading tabs
      staging: wilc1000: free memory allocated for general info message from firmware

Alexandru Ardelean (1):
      staging: iio: adc: ad7192: disable burnout currents on misconfig

Anders Roxell (1):
      staging: fsl-mc/dpio: remove unused function

Andy Shevchenko (2):
      iio: accel: bmc150: Remove redundant __func__ in dev_dbg()
      iio: proximity: sx9500: Add GPIO ACPI mapping table

Arnd Bergmann (3):
      staging: vc04_services: merge vchiq_kern_lib.c into vchiq_arm.c
      staging: lustre: use module_name() macro for debug printf
      staging: lustre: fid: avoid false-positive uninitialized variable warning

Arushi Singhal (15):
      staging: comedi: Replace "dont" with "don't
      staging: lustre: Replace "be be" with "be"
      staging: lustre: Replace "to to" with "to"
      staging: lustre: Replace "dont" with "don't"
      staging: rtlwifi: Remove nonessential semicolon
      staging: rtl8712: Fixed 'tabstop' coding style warning
      staging: rtl8712: match alignment with open parenthesis
      staging: rtl8712: Remove multiple blank line(s)
      staging: rtl8712: Added spaces around '+'
      staging: rtl8712: Add spaces around '|'
      staging: rtl8712: remove unnecessary parentheses
      staging: rtl8723bs: Remove unnecessary semicolon.
      staging: rtl8723bs: Replace memset with eth_zero_addr
      staging: iio: Remove unnecessary cast on void pointer
      staging: rtl8192u: Replace printk() with more standardize output format.

Baruch Siach (1):
      uapi: remove telephony headers

Bogdan Purcareata (5):
      staging: fsl-mc: Move core bus out of staging
      staging: fsl-mc: Move irqchip code out of staging
      staging: fsl-mc: Cleanup dpbp and dpcon API
      staging: fsl-mc: Move DPBP out of staging
      staging: fsl-mc: Move DPCON out of staging

Brian Masney (11):
      staging: iio: tsl2x7x: remove power functions from tsl2X7X_platform_data
      staging: iio: tsl2x7x: add common function for clearing interrupts
      staging: iio: tsl2x7x: add common function for reading chip status
      staging: iio: tsl2x7x: add common function for writing to the control register
      staging: iio: tsl2x7x: convert mutex_trylock() to mutex_lock()
      staging: iio: tsl2x7x: correctly return errors in tsl2x7x_get_prox()
      staging: iio: tsl2x7x: correct 'Avoid CamelCase' warning from checkpatch
      staging: iio: tsl2x7x: add error handling to tsl2x7x_prox_cal()
      staging: iio: tsl2x7x: add missing error checks
      staging: iio: tsl2x7x: remove unnecessary sysfs attribute
      staging: iio: tsl2x7x: make proximity sensor function correctly

Christian Luetke-Stetzkamp (1):
      staging: sm750fb: Remove typedefs from enums

Christian Lütke-Stetzkamp (7):
      staging: mt7621-dma: Fix Pointer Location
      staging: mt7621-dma: Fix Spacing
      staging: mt7621-dma: Fix open brace position
      staging: mt7621-dma: Remove assignment in if
      staging: mt7621-dma: Fix ident by space
      staging: mt7621-dma: Removing unnecessary braces
      staging: mt7621-dma: Fixing parenthesis alignment

Christophe JAILLET (1):
      staging: vme: vme_user: Fix some error handling paths in 'vme_user_probe()'

Christopher Diaz Riveros (4):
      staging: net: netlogic: Remove unneeded cast
      staging: rtl8723bs: Remove unneeded cast
      staging: emxx_udc: Remove unneeded cast
      staging: rtl8188eu: Remove unneeded cast

Colin Ian King (6):
      staging: rtl8192u: return -ENOMEM on failed allocation of priv->oldaddr
      staging: rtl8723bs: fix u8 less than zero check
      staging: comedi: adl_pci6208: remove redundant initialization of 'val'
      staging: wilc1000: check for kmalloc allocation failures
      staging: mt7621-eth: fix spelling mistake: "devictree" -> "devicetree"
      staging: r8822be: fix typos in header guard macros

Corentin Labbe (1):
      staging: vc04_services: remove unused files

Crt Mori (3):
      lib: Add strongly typed 64bit int_sqrt
      dt-bindings: iio: temperature: add MLX90632 device bindings
      iio: temperature: Adding support for MLX90632

Dafna Hirschfeld (14):
      staging: rtl8188eu: Move a blank line
      staging: rtl8188eu: Replace function name in string with __func__
      staging: rtl8723bs: clean up conditionals
      staging: lustre: use memdup_user to allocate memory and copy from user
      staging: wilc1000: remove 'if' on field address
      staging: rtl8192u: Fix alignments in 'if' statements
      staging: wilc1000: merge 'if' statements that test the same condition
      staging: rtl8723bs: use kmemdup for allocation and copy
      staging: lustre: obdclass: Fix comparison to NULL
      staging: lustre: obdclass: Add 'const' to char* array
      staging: lustre: obdclass: Replace 'unsigned' with 'unsigned int'
      staging: rtl8192e: Fix issues regarding blank lines
      staging: rtl8192e: Remove unnecessary parentheses
      staging: rtl8192e: Add spaces around operators.

Dan Carpenter (3):
      staging: lustre: selftest: freeing an error pointer
      iio temperature/mlx90632: silence a static checker warning
      staging: emxx_udc: Remove unnecessary NULL checks

David Kershner (5):
      staging: unisys: visorinput: Clean up Makefile includes
      staging: unisys: visorinput: remove duplicate comments
      staging: unisys: visorinput: combine ultrainputreport.h with visorinput.c
      staging: unisys: visorinput: Fix spacing after open paranthesis
      staging: unisys: visorinput: use the full 80 characters of the screen

David Veenstra (2):
      Staging: iio: adt7316: Move symbol export to definition
      Staging: iio: ad7746: Adjust arguments to match open parenthesis

Dileep Sankhla (1):
      staging: vt6656: Remove unnecessary 'out of memory' message

Eisha Chen-yen-su (7):
      staging: comedi: Remove a newline inside a dereference
      staging: comedi: Add a missing space
      staging: comedi: Use '"%s:", __func__' instead of function name
      staging: pi433: Split some function calls
      staging: pi433: Split subtraction across 2 lines
      staging: comedi: Remove a "tracing" call
      staging: comedi: Use '"%s:", __func__' instead of function name

Eric Anholt (7):
      staging: vc04_services: Remove dead FRAGMENTS_T
      staging: vc04_services: Replace "firmware" node with a compatible lookup.
      staging: vc04_services: Remove cache-line-size property (v3)
      dt-bindings: soc: Add a binding for the Broadcom VCHIQ services. (v3)
      ARM: dts: bcm2835: Add VCHIQ node to the Raspberry Pi boards. (v3)
      staging: vc04_services: Mark the "DT bindings" job done.
      staging: vc04_services: Remove vchiq_queue_bulk_{transmit,receive}.

Erik Liodden (1):
      staging: rtlwifi: add identifier names to function definition arguments

Fabrice Gasnier (1):
      dt-bindings: iio: adc: stm32-dfsdm: fix types, add missing pinctrl

Fengguang Wu (2):
      staging: fsl-mc/dpio: qbman_pull_desc_set_token() can be static
      staging: wilc1000: fix memdup.cocci warnings

Frank Mori Hess (1):
      staging: comedi: ni_mio_common: ack ai fifo error interrupts.

Greg Kroah-Hartman (9):
      Merge tag 'iio-for-4.17a' of git://git.kernel.org/.../jic23/iio into staging-next
      Merge 4.16-rc3 into staging-next
      Revert "Staging: bcm2048: Fix function argument alignment in radio-bcm2048.c."
      staging: fsl-mc: dpio: remove foolish -Werror Makefile addtion
      Merge tag 'iio-for-4.17b' of git://git.kernel.org/.../jic23/iio into staging-next
      staging: ccree: remove ccree staging driver copy
      staging: irda: remove the irda network stack and drivers
      Merge 4.16-rc6 into staging-next
      Merge 4.16-rc7 into staging-next

Gwendal Grignou (1):
      iio: cros_ec: Relax sampling frequency before suspending

Harald Geyer (1):
      iio: dht11: Improve detection of sensor type

HariPrasath Elango (9):
      staging: iio: meter: Remove reduntant __func__ from debug print
      staging: pi433: Remove comments inside code
      staging: wilc1000: Fix code block alignment
      staging: wilc1000: Destroy mutex object in deinitialization
      staging: wilc1000: use kmemdup instead of kmalloc and memcpy
      staging: wilc1000: destroy initialized mutex object
      staging: mt7621-gpio: remove redundant owner assignments of drivers
      staging: wilc1000: replace switch statement by simple if condition
      staging: wilc1000: remove unused return variable

Himanshu Jha (3):
      Staging: iio: accel: adis16201: Prefer alphabetical sequence of header files
      Staging: iio: accel: adis16201: Add a blank space before returns
      iio: potentiometer: ds1803: Remove VLA usage

Ian Abbott (2):
      Revert "staging: comedi: cb_pcidas64: change params to external_ai_queue_in_use()"
      staging: comedi: cb_pcidas64: Fix external_ai_queue_in_use()

Ioana Ciornei (2):
      bus: fsl-mc: change mc_command in fsl_mc_command
      bus: fsl-mc: add fsl_mc_allocator cleanup function

Ioana Radulescu (21):
      staging: fsl-mc/dpio: Fix incorrect casts
      staging: fsl-mc/dpio: allow the driver to compile multi-arch
      staging: fsl-dpaa2/eth: Fix incorrect casts
      staging: fsl-mc/dpio: Fix incorrect cast
      staging: fsl-mc/dpio: Fix cast truncate warning
      staging: fsl-mc/dpio: Use __leXX types where needed
      staging: fsl-mc/dpio: Fix incorrect masking
      staging: fsl-dpaa2/eth: Use __leXX types where needed
      staging: fsl-dpaa2/eth: allow the driver to compile multi-arch
      staging: fsl-dpaa2/eth: Fix incorrect kfree
      staging: fsl-dpaa2/eth: Defer probing if no MC portal available
      staging: fsl-dpaa2/eth: Use generic irq handler
      staging: fsl-dpaa2/eth: Move print message
      staging: fsl-dpaa2/eth: Remove unused field
      staging: fsl-dpaa2/eth: Remove packed attribute
      staging: fsl-dpaa2/eth: Add DPNI version check
      staging: fsl-dpaa2/eth: Change link settings on the fly
      staging: fsl-dpaa2/eth: Cleanup TX frame freeing code
      staging: fsl-dpaa2/eth: Fix SGT allocation
      staging: fsl-dpaa2/eth: Change max number of Tx queues
      staging: fsl-dpaa2/eth: Use debug level for message

Ivan Safonov (7):
      staging:r8188eu: Remove struct pkt_file from set_qos()
      staging:r8188eu: Remove struct pkt_file from update_attrib()
      staging:r8188eu: Remove struct pkt_file from rtw_xmitframe_coalesce()
      staging:r8188eu: Remove unused struct pkt_file
      staging:r8188eu: Use lib80211 to decrypt WEP-frames
      staging:r8188eu: use lib80211 CCMP decrypt
      staging:r8188eu: Use lib80211 to support TKIP

James Simmons (1):
      staging: lustre: update the TODO list

Jeff LaBundy (1):
      iio: light: lv0104cs: Add support for LV0104CS light sensor

Jeremy Fertic (1):
      staging: vt6655: remove unnecessary blank lines

Jeremy Sowden (1):
      staging: ccree: fixed pointer signedness warnings.

Ji-Hun Kim (1):
      staging: rtl8723bs: core: rtw_cmd: remove unnecessary initialization

Jian Zhang (1):
      Staging: comedi: fix multiple line dereference coding style issue in cb_pcidas64.c

John Crispin (12):
      staging: mt7621-pci: MIPS/ralink: add MT7621 pcie driver
      staging: mt7621-pinctrl: ralink: add pinctrl driver
      staging: mt7621-gpio: ralink: add mt7621 gpio controller
      staging: mt7621-spi: add mt7621 support
      staging: mt7621-dma: ralink: add rt2880 dma engine
      staging: mt7621-mmc: MIPS: ralink: add sdhci for mt7620a SoC
      staging: mt7621-eth: Document ralink/mediatek SoC ethernet binding
      staging: mt7621-eth: add the drivers core files
      staging: mt7621-eth: add gigabit switch driver (GSW)
      staging: mt7621-eth: add mdio support for mt762X family
      staging: mt7621-eth: add support for mt7621
      staging: mt7621-eth: mediatek: add Kconfig and Makefile

Justin Skists (2):
      staging: lustre: Fix unneeded byte-ordering cast
      staging: lustre: lnet: use correct 'magic' test

Kees Cook (1):
      staging: lustre: Remove VLA usage

Kirill Marinushkin (1):
      staging: bcm2835-audio: Release resources on module_exit()

Liam Mark (1):
      staging: android: ion: Initialize dma_address of new sg list

Lorenzo Bianconi (5):
      iio: humidity: hts221: remove warnings in hts221_parse_{temp,rh}_caldata()
      iio: humidity: hts221: remove trailing whitespace from a comment
      iio: humidity: hts221: add regmap API support
      iio: humidity: hts221: remove unnecessary get_unaligned_le16()
      iio: imu: st_lsm6dsx: add hw timestamp support

Maciek Fijalkowski (1):
      staging: rtl8723bs: make 'myid' function to follow kernel coding rules

Matt Ranostay (2):
      iio: sysfs-bus-iio-*: update email contact
      iio: add SPDX identifier for various drivers

Milan Stevanovic (2):
      iio: adc: driver for ti adc081s/adc101s/adc121s
      iio: adc: change license description

NeilBrown (68):
      staging: lustre: fix inverted test on strcmp
      staging: lustre: honor error code from ll_iget().
      staging: lustre: llite: handle DCACHE_PAR_LOOKUP in ll_dcompare
      staging: lustre: llite: use d_splice_alias for directories.
      staging: lustre: llite: remove directory-specific code from ll_find_alias()
      staging: lustre: llite: simplify ll_find_alias()
      staging: lustre: llite: refine ll_find_alias based on d_exact_alias
      sched/wait: add wait_event_idle() functions.
      staging: lustre: discard SVC_SIGNAL and related functions
      staging: lustre: replace simple cases of l_wait_event() with wait_event().
      staging: lustre: discard cfs_time_seconds()
      staging: lustre: use wait_event_idle_timeout() where appropriate.
      staging: lustre: introduce and use l_wait_event_abortable()
      staging: lustre: simplify l_wait_event when intr handler but no timeout.
      staging: lustre: simplify waiting in ldlm_completion_ast()
      staging: lustre: open code polling loop instead of using l_wait_event()
      staging: lustre: simplify waiting in ptlrpc_invalidate_import()
      staging: lustre: remove back_to_sleep()
      staging: lustre: make polling loop in ptlrpc_unregister_bulk more obvious
      staging: lustre: use wait_event_idle_timeout in ptlrpcd()
      staging: lustre: improve waiting in sptlrpc_req_refresh_ctx
      staging: lustre: use explicit poll loop in ptlrpc_service_unlink_rqbd
      staging: lustre: use explicit poll loop in ptlrpc_unregister_reply
      staging: lustre: remove l_wait_event from ptlrpc_set_wait
      staging: lustre: replace l_wait_event_exclusive_head() with wait_event_idle_exclusive
      staging: lustre: remove l_wait_event() and related code
      staging: lustre: replace all CFS_CAP_* macros with CAP_*
      staging: lustre: opencode cfs_cap_{raise, lower, raised}
      staging: lustre: remove linux-curproc.c
      staging: lustre: remove unnecessary cfs_block_allsigs() calls
      staging: lustre: lnet: remove cfs_block_allsigs calls.
      staging: lustre: simplify linux-prim.c
      staging: lustre: improve API and implementation of blocking signals.
      staging: lustre: make signal-blocking functions inline
      staging: lustre: discard libcfs_kvzalloc_cpt()
      staging: lustre: discard lu_buf allocation library.
      staging: lustre: improve some libcfs_kvzalloc calls.
      staging: lustre: discard libcfs_kvzalloc and linux-mem.c
      staging: lustre: remove phantom struct cfs_crypto_hash_desc
      staging: lustre: fix assorted checkpatch errors
      staging: lustre: ptlrpc: list_for_each improvements.
      staging: lustre: fid: convert lcs_mutex to a spinlock
      staging: lustre: fid: use wait_event_cmd()
      staging: lustre: fid: remove seq_fid_alloc_fini() and simplify
      staging: lustre: fid: fix up debugfs access to ->lcs_space
      staging: lustre: fid: perform sanity checks before commiting
      staging: lustre: socklnd: simplify ksnc_rx_iov_space
      staging: lustre: lov: use correct env in lov_io_data_version_end()
      staging: lustre: lmv: correctly iput lmo_root
      staging: lustre: lnet/selftest: don't ignore status from lstcon_test_add
      staging: lustre: obd_mount: use correct niduuid suffix.
      staging: lustre: fix bug in osc_enter_cache_try
      staging: lustre: statahead: remove incorrect test on agl_list_empty()
      staging: lustre: obdclass: don't require lct_owner to be non-NULL.
      staging: lustre: lnet: keep ln_nportals consistent
      staging: lustre: get entropy from nid when nid set.
      staging: lustre: ptlrpc: change GFP_NOFS to GFP_KERNEL
      staging: lustre: obdclass: use workqueue for zombie management.
      staging: lustre: ldlm: use delayed_work for pools_recalc
      staging: lustre: ptlrpc: use delayed_work in sec_gc
      staging: lustre: ptlrpc: use workqueue for pinger
      staging: lustre: remove unused flag from ptlrpc_thread
      staging: lustre: remove 'ptlrpc_thread usage' for sai_agl_thread
      staging: lustre: change sai_thread to sai_task.
      staging: lustre: ptlrpc: move thread creation out of module initialization
      staging: lustre: allow monolithic builds
      Revert "staging: Disable lustre file system for MIPS, SH, and XTENSA"
      staging: mt7621-dts: add dts files

Nishka Dasgupta (13):
      staging: vc04_services: bcm2835-audio: Add blank line after declaration
      staging: vc04_services: bcm2835-audio Format multiline comment
      staging: vc04_services: bcm2835-audio: Change to unsigned int *
      staging: speakup: Add blank line after declaration
      staging: ks7010: Remove braces around single statement
      staging: sm750fb: Remove typedef
      staging: vc04_services: bcm2835-camera: Add blank line after declaration
      staging: vt6655: Change typedef enum to enum
      staging: vt6655: Delete unused enum CARD_PKT_TYPE
      staging: vt6655: Delete unused typedef enum _CARD_STATUS_TYPE
      staging: vt6655: Delete unused typedef struct _version
      staging: vt6655: Delete unused typedef enum _chip_type
      staging: mt7621-dts: Replace spaces with tabs in indentation

Palle Christensen (1):
      staging:mt29f_spinand: MT29F2G failing as only 16 bits used for addressing.

Paul McQuade (5):
      Staging:rtl8723bs static variables are always 0
      Staging:rtl8723bs Remove unnecessary braces
      Staging:rtl8723bs clean up spaces
      Staging:rtl8723bs:Add blank line after declaration
      staging: comedi: s626: Use Preferred kernel type

Peter Rosin (1):
      iio: potentiometer: mcp4018: driver for Microchip digital potentiometers

Phil Reid (2):
      dt-bindings: ad5272: Add bindings for Analog Devices digital potentiometers
      iio: ad5272: Add support for Analog Devices digital potentiometers

Phillip Potter (1):
      staging: android: ion: Update wording in drivers/staging/android/ion/Kconfig

Pratik Jain (2):
      Staging: comedi: drivers: ni_atmio.c: fixed multi-line derefernce issue
      Staging: xgifb: XGI_main_26.c: Refactored the function

Quentin Schulz (5):
      iio: adc: axp20x_adc: put ADC rate setting in a per-variant function
      dt-bindings: iio: adc: add binding for X-Powers AXP PMICs ADC
      iio: adc: axp20x_adc: make it possible to probe from DT
      iio: adc: axp20x_adc: add support for AXP813 ADC
      iio: adc: axp20x_adc: remove !! in favor of ternary condition

Quytelda Kahja (57):
      Staging: gdm724x: LTE: Fix argument list not aligned with parenthesis.
      Staging: gdm724x: mux: Check return value of register_lte_tty_driver().
      Staging: gdm724x: tty: Remove unnecessary macro 'gdm_tty_send'.
      Staging: gdm724x: tty: Remove unnecessary macro 'gdm_tty_recv'.
      Staging: gdm724x: tty: Remove unused macro 'gdm_tty_send_control'.
      Staging: ks7010: sdio: Convert RX/TX queue macros into real functions.
      Staging: ks7010: hostif: Convert SME queue macros to real functions.
      Staging: ks7010: hostif: Convert the ps_confirm_wait_inc() macro to a real function.
      Staging: bcm2048: Fix function argument alignment in radio-bcm2048.c.
      Staging: gdm724x: LTE: Fix trailing open parentheses.
      Staging: gdm724x: Simplify the struct gdm_endian to a variable.
      Staging: gdm724x: LTE: Refactor gdm_lte_pdn_table().
      staging: most: Remove unnecessary OOM messages.
      staging: most: Fix missing identifier in function definition argument.
      staging: ks7010: Use constants from ieee80211_eid instead of literal ints.
      staging: ks7010: Replace SSID_MAX_SIZE with IEEE80211_MAX_SSID_LEN.
      staging: ks7010: Factor out repeated code into function 'ks_wlan_cap()'.
      staging: ks7010: Replace local capability constants with kernel constants.
      staging: ks7010: Replace local frame type constants with kernel constants.
      staging: ks7010: Replace literal with constant.
      staging: most: Add a blank line.
      staging: most: Indent function parameter.
      staging: most: Remove unnecessary usage of BUG_ON().
      staging: ks7010: Fix line over 80 characters.
      staging: ks7010: Fix lines over 80 characters due to comments.
      staging: ks7010: Factor out common members in request structs.
      staging: ks7010: Remove duplicate #define's
      staging: ks7010: Replace memcmp() operation with ether_addr_equal().
      staging: ks7010: Factor out repeated code for reading IEs.
      staging: ks7010: Remove hostif_infrastructure_set2_request_t.
      staging: ks7010: Fix spelling mistakes.
      staging: rtl8723bs: Remove duplicate #defines.
      staging: ks7010: Remove unecessary cast.
      staging: ks7010: Change mac_address_valid to a bool instead of int.
      staging: ks7010: Remove unused member 'reg_net' from 'ks_wlan_private'.
      staging: rtl8723bs: Remove #defines shadowing enums in 'linux/ieee80211.h'
      staging: rtl8723bs: Replace RTW_IEEE80211_FCTL_* with IEEE80211_FCTL_*.
      staging: rtl8723bs: Replace RTW_IEEE80211_FTYPE_* with IEEE80211_FTYPE_*.
      staging: rtl8723bs: Replace RTW_IEEE80211_STYPE_* with IEEE80211_STYPE_*.
      staging: rtl8723bs: Fix newlines in rtw_wx_set_auth().
      staging: rtl8723bs: Remove unecessary braces from switch statement.
      staging: rtl8723bs: Remove braces from single statement conditionals.
      staging: rtl8723bs: Fix alignment in rtw_wx_set_auth().
      staging: rtl8723bs: Fix IEEE80211 authentication algorithm constants.
      staging: rtl8723bs: Remove unnecessary length #define's.
      staging: rtl8723bs: Fix lines with trailing open parentheses.
      staging: rtl8723bs: Add spaces around ternary operators.
      staging: rtl8723bs: Add missing braces in else statement.
      staging: rtl8723bs: Change camel case to snake case in 'rtl8723bs_recv.c'.
      staging: rtl8723bs: Remove unnecessary blank lines in 'rtl8723bs_recv.c'.
      staging: rtl8723bs: Fix lines too long in update_recvframe_attrib().
      staging: rtl8723bs: Fix function signature that goes over 80 characters.
      staging: rtl8723bs: Factor out rtl8723bs_recv_tasklet() sections.
      staging: rtl8723bs: Replace NULL pointer comparison with '!'.
      staging: rtl8723bs: Rework 'struct _ODM_Per_Pkt_Info_' coding style.
      staging: rtl8723bs: Rework 'struct _ODM_Phy_Status_Info_' coding style.
      staging: rtl8723bs: Remove unecessary newlines from 'odm.h'.

Randy Dunlap (1):
      iio/adc: depend on SYSFS instead of selecting it

Razvan Stefanescu (6):
      staging: fsl-dpaa2/ethsw: Add APIs for DPSW object
      staging: fsl-dpaa2/ethsw: Add Freescale DPAA2 Ethernet Switch driver
      staging: fsl-dpaa2/ethsw: Add ethtool support
      staging: fsl-dpaa2/ethsw: Add maintainer for Ethernet Switch driver
      staging: fsl-dpaa2/ethsw: Add README
      staging: fsl-dpaa2/ethsw: Add TODO

Rene Hickersberger (1):
      drivers: staging: rtl8192e: fixed a space coding style issue

Richard Lai (2):
      iio: chemical: ccs811: Typo correction in HW_ID_VALUE constant define naming
      iio: chemical: ccs811: Renamed resistance member in ccs811_reading struct

Rinkle Jain (1):
      staging: vt6655: Fix style violation for line ending in '('

Rodrigo Siqueira (11):
      staging:iio:meter: Add name to function definition arguments
      iio: dummy: Add correct tabs and spaces to Kconfig
      iio:dummy: Add extra paragraphs on Kconfig
      iio:magnetometer: Replace magic number 0 by IIO_CHAN_INFO_RAW
      staging:iio:meter: Replaces IIO_DEV_ATTR_CH_OFF by IIO_DEVICE_ATTR
      staging:iio:meter: Remove unused macro IIO_DEV_ATTR_CH_OFF
      staging:iio:meter: Aligns open parenthesis
      iio: Replace occurrences of magic number 0 by IIO_CHAN_INFO_RAW
      staging:iio:ad2s1210: Remove end of line with '['
      staging:iio:ad2s1210: Remove unused #define directive
      staging:iio:ad2s1210: Remove old_data from ad2s1210_state

Rohit Kumar (1):
      drivers:staging:android:ashmem: Changing return type from int to loff_t

Roy Pledge (1):
      staging: fsl-mc/dpio: Add missing argument identifier

Samuel Thibault (1):
      staging: speakup: Add unicode support to the speakup_dummy driver

Santha Meena Ramamoorthy (19):
      Staging: fsl-dpaa2: ethernet: dpaa2-eth.c: Fixed a style issue
      staging: vt6655: remove additional blank line
      staging: speakup: add spaces around arithmetic operators
      staging: speakup: match alignment with open parenthesis
      staging: speakup: remove space after a cast
      staging: speakup: add braces around else statement
      staging: rtl8192e: use struct pointer to get the size of the struct
      staging: lustre: fix block comment style
      staging: vt6655: replace NULL comparison with variable
      staging: rtl8192e: move logical continuation to previous line
      staging: speakup: match alignment with open parenthesis
      staging: vt6655: remove unnecessary parentheses
      staging: rtlwifi: remove condition where it has no effect
      staging: rtlwifi: remove unneeded semicolon
      staging: rtl8188eu: place constant on the right side of test
      staging: rtl8188eu: replace NULL comparison with variable
      staging: lustre: remove else after return statement
      staging: rtl8188eu: fix typo in comment
      staging: rtl8188eu: use __func__ instead of function name

Sergio Paracuellos (26):
      staging: ks7010: replace custom rotation operations in favour of the kernel ones
      staging: ks7010: remove useless DPRINTK traces
      staging: ks7010: replace DPRINTK traces in favour of netdev_*
      staging: ks7010: replace KS_WLAN_DEBUG with DEBUG preprocessor directive
      staging: ks7010: remove max_event_count field which is only being used in debug
      staging: ks7010: remove not used function signature ks_wlan_read_config_file
      staging: ks7010: replace some custom defines with the ones in uapi/linux/if_ether.h
      staging: ks7010: review custom bit defines using macros from bitops header file
      staging: ks7010: use lower case names in michael_mic_t struct fields
      staging: ks7010: use GENMASK instead of custom defines in SME_WEP_VAL_MASK
      staging: ks7010: avoid camel case in function name get_BYTE
      staging: ks7010: avoid camel case in function name get_WORD
      staging: ks7010: avoid camel case in function name get_DWORD
      staging: ks7010: factor out some functions from hostif_init
      staging: ks7010: avoid camel cases in MichaelMICFunction
      staging: ks7010: avoid camel cases for MichaelInitFunction
      staging: ks7010: avoid camel cases in MichaelAppend function
      staging: ks7010: replace macro MichaelClear with inline function
      staging: ks7010: avoid camel cases in MichaelGetMIC function
      staging: ks7010: replace PutUInt32 macro with put_unaligned_le32()
      staging: ks7010: replace GetUInt32 macro with get_unaligned_le32
      staging: ks7010: replace MichaelBlockFunction macro with inline function
      staging: ks7010: remove some dead code from ks_wlan_set_essid function
      staging: ks7010: replace uint8_t in favour of u8 in michael_init
      staging: ks7010: replace uint8_t in favour of u8 in michael_append
      staging: ks7010: replace uint8_t in favour of u8 in michael_get_mic

Shreeya Patel (8):
      Staging: iio: ade7758: Expand buf_lock to cover both buffer and state protection
      Staging: iio: adis16209: Arrange headers in alphabetical order
      Staging: iio: adis16209: Change the definition name
      Staging: iio: adis16209: Add _REG postfix for registers
      Staging: iio: adis16209: Remove and add some comments and group the definitions
      Staging: iio: adis16209: Change some macro names
      Staging: iio: adis16209: Adjust a switch statement
      Staging: iio: adis16209: Use sign_extend32 function

Stefan Wahren (2):
      staging: vc04_services: Remove import of bcm2835-camera from TODO
      staging: vc04_services: Add outstanding VCHI TODOs

Stefano Manni (2):
      staging: rtl8712: make unsigned length for rtl8717_get{_wpa_, _wpa2_, _}ie
      staging: rtl8712: fix signedness of length to rtl8717_set_ie

Stephen Rothwell (1):
      staging: fsl-mc: merge fix for CONFIG_FSL_MC_BUS moving

Sumit Pundir (1):
      staging: lustre: lnet: return of an error code should be negative

Thomas Avery (3):
      staging: lustre: Remove yield() call
      staging: rtl8723bs: Replace yield() call with cond_resched()
      staging: rtl8723bs: Remove yield call, replace with cond_resched()

Tim Sell (1):
      staging: unisys: visorinput: remove need for 'depends on FB'

Tom Lebreux (2):
      staging:iio:ad7152: Align arguments to match open parenthesis
      staging:iio:ad7150: Align arguments to match open parenthesis

Valentin Vidic (24):
      staging: pi433: fix CamelCase for syncValues
      staging: pi433: fix CamelCase for powerLevel
      staging: pi433: fix CamelCase for antennaImpedance
      staging: pi433: fix CamelCase for Ohm identifiers
      staging: pi433: fix CamelCase for currentValue
      staging: pi433: fix CamelCase for newValue
      staging: pi433: fix CamelCase for regValue
      staging: pi433: fix CamelCase for txStartCondition
      staging: pi433: fix CamelCase for thresholdDecrement
      staging: pi433: fix CamelCase for addressFiltering
      staging: pi433: fix CamelCase for packetFormat enum
      staging: pi433: fix CamelCase for flag enum
      staging: pi433: fix CamelCase for afterSyncInterrupt
      staging: pi433: fix CamelCase for address_filtering enum
      staging: pi433: fix CamelCase for Address variables
      staging: pi433: fix CamelCase for paRamp enum
      staging: pi433: fix CamelCase for GPIO functions
      staging: pi433: fix CamelCase for preambleLength variable
      staging: pi433: fix CamelCase for syncSize variable
      staging: pi433: fix CamelCase for bitRate variables
      staging: pi433: fix CamelCase for DIONumber variable
      staging: pi433: fix CamelCase for lnaGain enum
      staging: pi433: fix CamelCase for dagc enum
      staging: pi433: cleanup local variable

Wei Yongjun (5):
      iio: ep93xx: remove redundant return value check of platform_get_resource()
      staging: mt7621-gpio: mt7621: make symbol gc_map static
      staging: mt7621-eth: fix return value check in mtk_probe()
      staging: mt7621-eth: fix return value check in mtk_connect_phy_node()
      staging: mt7621-eth: fix return value check in mt7621_gsw_probe()

Xiongfeng Wang (1):
      iio: accel: use strlcpy() instead of strncpy()

Yash Omer (1):
      Staging: wlan-ng: fix unnecessary parantheses in prism2mgmt.c

Yisheng Xie (11):
      staging: android: ion: Remove unused declaration ion_buffer_fault_user_mappings
      staging: android: ion: Remove unused include files for ion_page_pool.c
      staging: android: ion: Nuke ion_page_pool_init
      staging: android: ion: Avoid NULL point in error path
      staging: android: ion: Remove lable debugfs_done
      staging: android: ion: Remove dead code in ion_page_pool_free
      staging: android: ion: Return void instead of int
      staging: android: ion: Cleanup ion_page_pool_alloc_pages
      staging: android: ion: Combine cache and uncache pools
      staging: android: ion: Remove check of debug_file
      staging: android: ion: Remove check of idev->debug_root

rodrigosiqueira (2):
      staging: ade7759: Fix open parenthesis alignment
      iio:pressure:ms5611: Fix coding style in probe function

 .../ABI/testing/sysfs-bus-iio-chemical-vz89x       |    2 +-
 .../ABI/testing/sysfs-bus-iio-proximity-as3935     |    4 +-
 .../devicetree/bindings/iio/adc/axp20x_adc.txt     |   48 +
 .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        |    8 +-
 .../bindings/iio/potentiometer/ad5272.txt          |   27 +
 .../bindings/iio/temperature/mlx90632.txt          |   28 +
 .../bindings/soc/bcm/brcm,bcm2835-vchiq.txt        |   16 +
 Documentation/networking/dpaa2/index.rst           |    8 +
 .../networking/dpaa2}/overview.rst                 |    0
 Documentation/networking/index.rst                 |    1 +
 Documentation/networking/irda.txt                  |   10 -
 MAINTAINERS                                        |   19 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |    6 +
 drivers/bus/Kconfig                                |    2 +
 drivers/bus/Makefile                               |    4 +
 drivers/bus/fsl-mc/Kconfig                         |   16 +
 drivers/bus/fsl-mc/Makefile                        |   18 +
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c  |   85 +-
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpcon.c |   20 +-
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp.c |    8 +-
 .../fsl-mc/bus => bus/fsl-mc}/dprc-driver.c        |    2 +-
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc.c  |   31 +-
 .../fsl-mc/bus => bus/fsl-mc}/fsl-mc-allocator.c   |    7 +-
 .../fsl-mc/bus => bus/fsl-mc}/fsl-mc-bus.c         |    2 +-
 .../fsl-mc/bus => bus/fsl-mc}/fsl-mc-msi.c         |    1 +
 .../fsl-mc/bus => bus/fsl-mc}/fsl-mc-private.h     |   91 +-
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-io.c |    2 +-
 .../{staging/fsl-mc/bus => bus/fsl-mc}/mc-sys.c    |   22 +-
 drivers/iio/accel/bmc150-accel-core.c              |    6 +-
 drivers/iio/accel/hid-sensor-accel-3d.c            |    2 +-
 drivers/iio/accel/st_accel_i2c.c                   |    3 +-
 drivers/iio/adc/Kconfig                            |    3 +-
 drivers/iio/adc/ad7476.c                           |   26 +-
 drivers/iio/adc/axp20x_adc.c                       |  168 +-
 drivers/iio/adc/ep93xx_adc.c                       |    4 -
 drivers/iio/adc/ti-adc161s626.c                    |   16 +-
 drivers/iio/chemical/ams-iaq-core.c                |   17 +-
 drivers/iio/chemical/atlas-ph-sensor.c             |   16 +-
 drivers/iio/chemical/ccs811.c                      |   10 +-
 drivers/iio/chemical/vz89x.c                       |   17 +-
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |    1 +
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   49 +
 .../common/cros_ec_sensors/cros_ec_sensors_core.h  |    2 +
 drivers/iio/dac/ad5380.c                           |    2 +-
 drivers/iio/dac/ad5764.c                           |    2 +-
 drivers/iio/dummy/Kconfig                          |   27 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |    2 +-
 drivers/iio/health/max30100.c                      |   16 +-
 drivers/iio/humidity/Kconfig                       |    2 +
 drivers/iio/humidity/dht11.c                       |    2 +-
 drivers/iio/humidity/hdc100x.c                     |   16 +-
 drivers/iio/humidity/hts221.h                      |   21 +-
 drivers/iio/humidity/hts221_buffer.c               |   39 +-
 drivers/iio/humidity/hts221_core.c                 |  132 +-
 drivers/iio/humidity/hts221_i2c.c                  |   64 +-
 drivers/iio/humidity/hts221_spi.c                  |   81 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   29 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |  161 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  104 +-
 drivers/iio/light/Kconfig                          |   10 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/apds9960.c                       |   16 +-
 drivers/iio/light/cros_ec_light_prox.c             |    1 +
 drivers/iio/light/hid-sensor-als.c                 |    2 +-
 drivers/iio/light/lm3533-als.c                     |    2 +-
 drivers/iio/light/lv0104cs.c                       |  531 ++++
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |    2 +-
 drivers/iio/potentiometer/Kconfig                  |   21 +
 drivers/iio/potentiometer/Makefile                 |    2 +
 drivers/iio/potentiometer/ad5272.c                 |  231 ++
 drivers/iio/potentiometer/ds1803.c                 |    2 +-
 drivers/iio/potentiometer/mcp4018.c                |  194 ++
 drivers/iio/potentiometer/tpl0102.c                |   16 +-
 drivers/iio/potentiostat/lmp91000.c                |   16 +-
 drivers/iio/pressure/ms5611.h                      |    2 +-
 drivers/iio/proximity/as3935.c                     |   17 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |   16 +-
 drivers/iio/proximity/sx9500.c                     |   25 +-
 drivers/iio/temperature/Kconfig                    |   12 +
 drivers/iio/temperature/Makefile                   |    1 +
 drivers/iio/temperature/maxim_thermocouple.c       |   16 +-
 drivers/iio/temperature/mlx90632.c                 |  752 +++++
 drivers/irqchip/Kconfig                            |    6 +
 drivers/irqchip/Makefile                           |    1 +
 .../bus => irqchip}/irq-gic-v3-its-fsl-mc-msi.c    |    4 +-
 drivers/staging/Kconfig                            |   18 +-
 drivers/staging/Makefile                           |   11 +-
 drivers/staging/android/ashmem.c                   |    2 +-
 drivers/staging/android/ion/Kconfig                |    2 +-
 drivers/staging/android/ion/ion.c                  |   26 +-
 drivers/staging/android/ion/ion.h                  |   22 +-
 drivers/staging/android/ion/ion_page_pool.c        |   33 +-
 drivers/staging/android/ion/ion_system_heap.c      |   76 +-
 drivers/staging/ccree/Kconfig                      |   27 -
 drivers/staging/ccree/Makefile                     |    7 -
 drivers/staging/ccree/TODO                         |   10 -
 drivers/staging/ccree/cc_aead.c                    | 2701 -----------------
 drivers/staging/ccree/cc_aead.h                    |  109 -
 drivers/staging/ccree/cc_buffer_mgr.c              | 1651 -----------
 drivers/staging/ccree/cc_buffer_mgr.h              |   74 -
 drivers/staging/ccree/cc_cipher.c                  | 1164 --------
 drivers/staging/ccree/cc_cipher.h                  |   74 -
 drivers/staging/ccree/cc_crypto_ctx.h              |  170 --
 drivers/staging/ccree/cc_debugfs.c                 |  101 -
 drivers/staging/ccree/cc_debugfs.h                 |   32 -
 drivers/staging/ccree/cc_driver.c                  |  474 ---
 drivers/staging/ccree/cc_driver.h                  |  194 --
 drivers/staging/ccree/cc_fips.c                    |  111 -
 drivers/staging/ccree/cc_fips.h                    |   37 -
 drivers/staging/ccree/cc_hash.c                    | 2295 ---------------
 drivers/staging/ccree/cc_hash.h                    |  114 -
 drivers/staging/ccree/cc_host_regs.h               |  142 -
 drivers/staging/ccree/cc_hw_queue_defs.h           |  590 ----
 drivers/staging/ccree/cc_ivgen.c                   |  280 --
 drivers/staging/ccree/cc_ivgen.h                   |   55 -
 drivers/staging/ccree/cc_kernel_regs.h             |  167 --
 drivers/staging/ccree/cc_lli_defs.h                |   59 -
 drivers/staging/ccree/cc_pm.c                      |  122 -
 drivers/staging/ccree/cc_pm.h                      |   57 -
 drivers/staging/ccree/cc_request_mgr.c             |  713 -----
 drivers/staging/ccree/cc_request_mgr.h             |   51 -
 drivers/staging/ccree/cc_sram_mgr.c                |  107 -
 drivers/staging/ccree/cc_sram_mgr.h                |   65 -
 drivers/staging/comedi/drivers/adl_pci6208.c       |    3 +-
 drivers/staging/comedi/drivers/cb_pcidas64.c       |   40 +-
 drivers/staging/comedi/drivers/das16.c             |    2 +-
 drivers/staging/comedi/drivers/das16m1.c           |    2 +-
 drivers/staging/comedi/drivers/jr3_pci.c           |    1 -
 drivers/staging/comedi/drivers/ni_atmio.c          |    9 +-
 drivers/staging/comedi/drivers/ni_mio_common.c     |   10 +-
 drivers/staging/comedi/drivers/ni_stc.h            |    2 +-
 drivers/staging/comedi/drivers/quatech_daqp_cs.c   |    2 +-
 drivers/staging/comedi/drivers/s626.c              |   10 +-
 drivers/staging/emxx_udc/emxx_udc.c                |   10 +-
 drivers/staging/fsl-dpaa2/Kconfig                  |   10 +-
 drivers/staging/fsl-dpaa2/Makefile                 |    1 +
 drivers/staging/fsl-dpaa2/ethernet/README          |    2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     |   69 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     |   22 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c |   26 +-
 drivers/staging/fsl-dpaa2/ethernet/dpni-cmd.h      |    4 +-
 drivers/staging/fsl-dpaa2/ethernet/dpni.c          |   86 +-
 drivers/staging/fsl-dpaa2/ethsw/Makefile           |   10 +
 drivers/staging/fsl-dpaa2/ethsw/README             |  106 +
 drivers/staging/fsl-dpaa2/ethsw/TODO               |   14 +
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h         |  346 +++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c             | 1123 +++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h             |  586 ++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c    |  182 ++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c            | 1508 ++++++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h            |   67 +
 drivers/staging/fsl-mc/TODO                        |   18 -
 drivers/staging/fsl-mc/bus/Kconfig                 |   12 +-
 drivers/staging/fsl-mc/bus/Makefile                |   13 -
 drivers/staging/fsl-mc/bus/dpbp-cmd.h              |   54 -
 drivers/staging/fsl-mc/bus/dpcon-cmd.h             |   53 -
 drivers/staging/fsl-mc/bus/dpio/Makefile           |    2 -
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.c      |    2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio-service.c     |    6 +-
 drivers/staging/fsl-mc/bus/dpio/dpio.c             |   14 +-
 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c     |   27 +-
 drivers/staging/fsl-mc/bus/dpio/qbman-portal.h     |   24 +-
 drivers/staging/fsl-mc/include/dpaa2-fd.h          |    6 +-
 drivers/staging/fsl-mc/include/dpaa2-io.h          |    2 +-
 drivers/staging/fsl-mc/include/dpbp.h              |   63 -
 drivers/staging/fsl-mc/include/dpcon.h             |   79 -
 drivers/staging/gdm724x/gdm_endian.c               |   24 +-
 drivers/staging/gdm724x/gdm_endian.h               |   13 +-
 drivers/staging/gdm724x/gdm_lte.c                  |   62 +-
 drivers/staging/gdm724x/gdm_lte.h                  |    2 +-
 drivers/staging/gdm724x/gdm_mux.c                  |    6 +-
 drivers/staging/gdm724x/gdm_tty.c                  |   29 +-
 drivers/staging/gdm724x/gdm_usb.c                  |   30 +-
 drivers/staging/gdm724x/gdm_usb.h                  |    2 +-
 drivers/staging/iio/accel/adis16201.c              |   10 +-
 drivers/staging/iio/accel/adis16209.c              |  272 +-
 drivers/staging/iio/adc/ad7192.c                   |    6 +-
 drivers/staging/iio/adc/ad7816.c                   |    2 +-
 drivers/staging/iio/addac/adt7316.c                |    3 +-
 drivers/staging/iio/cdc/ad7150.c                   |    5 +-
 drivers/staging/iio/cdc/ad7152.c                   |    6 +-
 drivers/staging/iio/cdc/ad7746.c                   |   12 +-
 drivers/staging/iio/light/tsl2x7x.c                |  290 +-
 drivers/staging/iio/light/tsl2x7x.h                |    6 +-
 drivers/staging/iio/meter/ade7753.c                |   18 +-
 drivers/staging/iio/meter/ade7754.c                |    6 +-
 drivers/staging/iio/meter/ade7758.h                |    2 +-
 drivers/staging/iio/meter/ade7758_core.c           |   52 +-
 drivers/staging/iio/meter/ade7758_trigger.c        |    8 +-
 drivers/staging/iio/meter/ade7759.c                |   98 +-
 drivers/staging/iio/meter/ade7854-i2c.c            |   28 +-
 drivers/staging/iio/meter/ade7854-spi.c            |   60 +-
 drivers/staging/iio/meter/ade7854.h                |   28 +-
 drivers/staging/iio/meter/meter.h                  |    3 -
 drivers/staging/iio/resolver/ad2s1210.c            |   20 +-
 drivers/staging/irda/TODO                          |    4 -
 drivers/staging/irda/drivers/Kconfig               |  398 ---
 drivers/staging/irda/drivers/Makefile              |   44 -
 drivers/staging/irda/drivers/act200l-sir.c         |  250 --
 drivers/staging/irda/drivers/actisys-sir.c         |  245 --
 drivers/staging/irda/drivers/ali-ircc.c            | 2217 --------------
 drivers/staging/irda/drivers/ali-ircc.h            |  227 --
 drivers/staging/irda/drivers/au1k_ir.c             |  985 -------
 drivers/staging/irda/drivers/bfin_sir.c            |  819 ------
 drivers/staging/irda/drivers/bfin_sir.h            |   93 -
 drivers/staging/irda/drivers/donauboe.c            | 1732 -----------
 drivers/staging/irda/drivers/donauboe.h            |  362 ---
 drivers/staging/irda/drivers/esi-sir.c             |  157 -
 drivers/staging/irda/drivers/girbil-sir.c          |  252 --
 drivers/staging/irda/drivers/irda-usb.c            | 1906 ------------
 drivers/staging/irda/drivers/irda-usb.h            |  175 --
 drivers/staging/irda/drivers/irtty-sir.c           |  570 ----
 drivers/staging/irda/drivers/irtty-sir.h           |   34 -
 drivers/staging/irda/drivers/kingsun-sir.c         |  634 ----
 drivers/staging/irda/drivers/ks959-sir.c           |  912 ------
 drivers/staging/irda/drivers/ksdazzle-sir.c        |  813 ------
 drivers/staging/irda/drivers/litelink-sir.c        |  199 --
 drivers/staging/irda/drivers/ma600-sir.c           |  253 --
 drivers/staging/irda/drivers/mcp2120-sir.c         |  224 --
 drivers/staging/irda/drivers/mcs7780.c             |  990 -------
 drivers/staging/irda/drivers/mcs7780.h             |  165 --
 drivers/staging/irda/drivers/nsc-ircc.c            | 2410 ---------------
 drivers/staging/irda/drivers/nsc-ircc.h            |  281 --
 drivers/staging/irda/drivers/old_belkin-sir.c      |  146 -
 drivers/staging/irda/drivers/pxaficp_ir.c          | 1075 -------
 drivers/staging/irda/drivers/sa1100_ir.c           | 1150 --------
 drivers/staging/irda/drivers/sh_sir.c              |  810 ------
 drivers/staging/irda/drivers/sir-dev.h             |  191 --
 drivers/staging/irda/drivers/sir_dev.c             |  987 -------
 drivers/staging/irda/drivers/sir_dongle.c          |  133 -
 drivers/staging/irda/drivers/smsc-ircc2.c          | 3026 -------------------
 drivers/staging/irda/drivers/smsc-ircc2.h          |  191 --
 drivers/staging/irda/drivers/smsc-sio.h            |  100 -
 drivers/staging/irda/drivers/stir4200.c            | 1134 --------
 drivers/staging/irda/drivers/tekram-sir.c          |  225 --
 drivers/staging/irda/drivers/toim3232-sir.c        |  358 ---
 drivers/staging/irda/drivers/via-ircc.c            | 1593 ----------
 drivers/staging/irda/drivers/via-ircc.h            |  846 ------
 drivers/staging/irda/drivers/vlsi_ir.c             | 1872 ------------
 drivers/staging/irda/drivers/vlsi_ir.h             |  757 -----
 drivers/staging/irda/drivers/w83977af.h            |   53 -
 drivers/staging/irda/drivers/w83977af_ir.c         | 1285 --------
 drivers/staging/irda/drivers/w83977af_ir.h         |  198 --
 drivers/staging/irda/include/net/irda/af_irda.h    |   87 -
 drivers/staging/irda/include/net/irda/crc.h        |   29 -
 drivers/staging/irda/include/net/irda/discovery.h  |   95 -
 .../staging/irda/include/net/irda/ircomm_core.h    |  106 -
 .../staging/irda/include/net/irda/ircomm_event.h   |   83 -
 drivers/staging/irda/include/net/irda/ircomm_lmp.h |   36 -
 .../staging/irda/include/net/irda/ircomm_param.h   |  147 -
 drivers/staging/irda/include/net/irda/ircomm_ttp.h |   37 -
 drivers/staging/irda/include/net/irda/ircomm_tty.h |  121 -
 .../irda/include/net/irda/ircomm_tty_attach.h      |   92 -
 drivers/staging/irda/include/net/irda/irda.h       |  115 -
 .../staging/irda/include/net/irda/irda_device.h    |  285 --
 drivers/staging/irda/include/net/irda/iriap.h      |  108 -
 .../staging/irda/include/net/irda/iriap_event.h    |   85 -
 .../staging/irda/include/net/irda/irias_object.h   |  108 -
 .../staging/irda/include/net/irda/irlan_client.h   |   42 -
 .../staging/irda/include/net/irda/irlan_common.h   |  230 --
 drivers/staging/irda/include/net/irda/irlan_eth.h  |   32 -
 .../staging/irda/include/net/irda/irlan_event.h    |   81 -
 .../staging/irda/include/net/irda/irlan_filter.h   |   35 -
 .../staging/irda/include/net/irda/irlan_provider.h |   52 -
 drivers/staging/irda/include/net/irda/irlap.h      |  311 --
 .../staging/irda/include/net/irda/irlap_event.h    |  129 -
 .../staging/irda/include/net/irda/irlap_frame.h    |  167 --
 drivers/staging/irda/include/net/irda/irlmp.h      |  295 --
 .../staging/irda/include/net/irda/irlmp_event.h    |   98 -
 .../staging/irda/include/net/irda/irlmp_frame.h    |   62 -
 drivers/staging/irda/include/net/irda/irmod.h      |  109 -
 drivers/staging/irda/include/net/irda/irqueue.h    |   96 -
 drivers/staging/irda/include/net/irda/irttp.h      |  210 --
 drivers/staging/irda/include/net/irda/parameters.h |  100 -
 drivers/staging/irda/include/net/irda/qos.h        |  101 -
 drivers/staging/irda/include/net/irda/timer.h      |  102 -
 drivers/staging/irda/include/net/irda/wrapper.h    |   58 -
 drivers/staging/irda/net/Kconfig                   |   96 -
 drivers/staging/irda/net/Makefile                  |   17 -
 drivers/staging/irda/net/af_irda.c                 | 2694 -----------------
 drivers/staging/irda/net/discovery.c               |  417 ---
 drivers/staging/irda/net/ircomm/Kconfig            |   12 -
 drivers/staging/irda/net/ircomm/Makefile           |    8 -
 drivers/staging/irda/net/ircomm/ircomm_core.c      |  563 ----
 drivers/staging/irda/net/ircomm/ircomm_event.c     |  246 --
 drivers/staging/irda/net/ircomm/ircomm_lmp.c       |  350 ---
 drivers/staging/irda/net/ircomm/ircomm_param.c     |  501 ----
 drivers/staging/irda/net/ircomm/ircomm_ttp.c       |  350 ---
 drivers/staging/irda/net/ircomm/ircomm_tty.c       | 1329 ---------
 .../staging/irda/net/ircomm/ircomm_tty_attach.c    |  987 -------
 drivers/staging/irda/net/ircomm/ircomm_tty_ioctl.c |  291 --
 drivers/staging/irda/net/irda_device.c             |  316 --
 drivers/staging/irda/net/iriap.c                   | 1085 -------
 drivers/staging/irda/net/iriap_event.c             |  496 ----
 drivers/staging/irda/net/irias_object.c            |  555 ----
 drivers/staging/irda/net/irlan/Kconfig             |   14 -
 drivers/staging/irda/net/irlan/Makefile            |    7 -
 drivers/staging/irda/net/irlan/irlan_client.c      |  559 ----
 .../staging/irda/net/irlan/irlan_client_event.c    |  511 ----
 drivers/staging/irda/net/irlan/irlan_common.c      | 1176 --------
 drivers/staging/irda/net/irlan/irlan_eth.c         |  340 ---
 drivers/staging/irda/net/irlan/irlan_event.c       |   60 -
 drivers/staging/irda/net/irlan/irlan_filter.c      |  240 --
 drivers/staging/irda/net/irlan/irlan_provider.c    |  408 ---
 .../staging/irda/net/irlan/irlan_provider_event.c  |  233 --
 drivers/staging/irda/net/irlap.c                   | 1207 --------
 drivers/staging/irda/net/irlap_event.c             | 2316 ---------------
 drivers/staging/irda/net/irlap_frame.c             | 1407 ---------
 drivers/staging/irda/net/irlmp.c                   | 1996 -------------
 drivers/staging/irda/net/irlmp_event.c             |  886 ------
 drivers/staging/irda/net/irlmp_frame.c             |  476 ---
 drivers/staging/irda/net/irmod.c                   |  199 --
 drivers/staging/irda/net/irnet/Kconfig             |   13 -
 drivers/staging/irda/net/irnet/Makefile            |    7 -
 drivers/staging/irda/net/irnet/irnet.h             |  522 ----
 drivers/staging/irda/net/irnet/irnet_irda.c        | 1885 ------------
 drivers/staging/irda/net/irnet/irnet_irda.h        |  178 --
 drivers/staging/irda/net/irnet/irnet_ppp.c         | 1189 --------
 drivers/staging/irda/net/irnet/irnet_ppp.h         |  116 -
 drivers/staging/irda/net/irnetlink.c               |  162 --
 drivers/staging/irda/net/irproc.c                  |   96 -
 drivers/staging/irda/net/irqueue.c                 |  912 ------
 drivers/staging/irda/net/irsysctl.c                |  258 --
 drivers/staging/irda/net/irttp.c                   | 1886 ------------
 drivers/staging/irda/net/parameters.c              |  584 ----
 drivers/staging/irda/net/qos.c                     |  771 -----
 drivers/staging/irda/net/timer.c                   |  231 --
 drivers/staging/irda/net/wrapper.c                 |  492 ----
 drivers/staging/ks7010/Makefile                    |    1 -
 drivers/staging/ks7010/eap_packet.h                |   41 +-
 drivers/staging/ks7010/ks7010_sdio.c               |  197 +-
 drivers/staging/ks7010/ks_hostif.c                 |  756 ++---
 drivers/staging/ks7010/ks_hostif.h                 |   95 +-
 drivers/staging/ks7010/ks_wlan.h                   |   21 +-
 drivers/staging/ks7010/ks_wlan_ioctl.h             |    1 -
 drivers/staging/ks7010/ks_wlan_net.c               |  117 +-
 drivers/staging/ks7010/michael_mic.c               |  144 +-
 drivers/staging/ks7010/michael_mic.h               |   19 +-
 drivers/staging/lustre/TODO                        |  310 +-
 .../staging/lustre/include/linux/libcfs/curproc.h  |   37 +-
 .../staging/lustre/include/linux/libcfs/libcfs.h   |   27 +-
 .../lustre/include/linux/libcfs/libcfs_crypto.h    |   11 +-
 .../lustre/include/linux/libcfs/libcfs_debug.h     |    4 +-
 .../lustre/include/linux/libcfs/libcfs_time.h      |    2 +-
 .../lustre/include/linux/libcfs/linux/linux-time.h |    7 +-
 drivers/staging/lustre/include/linux/lnet/api.h    |    1 +
 drivers/staging/lustre/lnet/Kconfig                |    2 +-
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c    |    8 +-
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c |   10 +-
 .../staging/lustre/lnet/klnds/socklnd/socklnd.c    |    6 +-
 .../staging/lustre/lnet/klnds/socklnd/socklnd.h    |   11 +-
 .../staging/lustre/lnet/klnds/socklnd/socklnd_cb.c |   32 +-
 .../lustre/lnet/klnds/socklnd/socklnd_lib.c        |    2 +-
 drivers/staging/lustre/lnet/libcfs/Makefile        |    4 +-
 drivers/staging/lustre/lnet/libcfs/debug.c         |    4 +-
 drivers/staging/lustre/lnet/libcfs/fail.c          |    2 +-
 .../staging/lustre/lnet/libcfs/linux/linux-cpu.c   |    2 +-
 .../lustre/lnet/libcfs/linux/linux-crypto.c        |   29 +-
 .../lustre/lnet/libcfs/linux/linux-curproc.c       |  108 -
 .../staging/lustre/lnet/libcfs/linux/linux-mem.c   |   51 -
 .../staging/lustre/lnet/libcfs/linux/linux-prim.c  |  113 -
 drivers/staging/lustre/lnet/libcfs/tracefile.c     |    4 +-
 drivers/staging/lustre/lnet/lnet/acceptor.c        |    6 +-
 drivers/staging/lustre/lnet/lnet/api-ni.c          |   26 +-
 drivers/staging/lustre/lnet/lnet/lib-eq.c          |   10 +-
 drivers/staging/lustre/lnet/lnet/lib-move.c        |    4 +-
 drivers/staging/lustre/lnet/lnet/lib-ptl.c         |    5 +-
 drivers/staging/lustre/lnet/lnet/net_fault.c       |   14 +-
 drivers/staging/lustre/lnet/lnet/peer.c            |    2 +-
 drivers/staging/lustre/lnet/lnet/router.c          |   10 +-
 drivers/staging/lustre/lnet/selftest/conctl.c      |   14 +-
 drivers/staging/lustre/lnet/selftest/conrpc.c      |    4 +-
 drivers/staging/lustre/lnet/selftest/framework.c   |    2 +-
 drivers/staging/lustre/lnet/selftest/rpc.c         |    2 +-
 drivers/staging/lustre/lnet/selftest/selftest.h    |    2 +-
 drivers/staging/lustre/lnet/selftest/timer.c       |    4 +-
 drivers/staging/lustre/lustre/Kconfig              |    1 -
 drivers/staging/lustre/lustre/fid/fid_request.c    |  107 +-
 drivers/staging/lustre/lustre/fid/lproc_fid.c      |   44 +-
 drivers/staging/lustre/lustre/fld/fld_cache.c      |    2 +-
 drivers/staging/lustre/lustre/include/cl_object.h  |    2 +-
 .../staging/lustre/lustre/include/lprocfs_status.h |    2 +-
 drivers/staging/lustre/lustre/include/lu_object.h  |    7 -
 drivers/staging/lustre/lustre/include/lustre_dlm.h |    2 +-
 .../staging/lustre/lustre/include/lustre_export.h  |    2 +
 drivers/staging/lustre/lustre/include/lustre_fid.h |    2 +-
 .../staging/lustre/lustre/include/lustre_import.h  |    4 +-
 drivers/staging/lustre/lustre/include/lustre_lib.h |  296 +-
 drivers/staging/lustre/lustre/include/lustre_lmv.h |    2 +-
 drivers/staging/lustre/lustre/include/lustre_mdc.h |    2 +-
 drivers/staging/lustre/lustre/include/lustre_net.h |   22 +-
 drivers/staging/lustre/lustre/include/lustre_sec.h |    3 -
 drivers/staging/lustre/lustre/include/obd.h        |    2 +-
 drivers/staging/lustre/lustre/include/obd_class.h  |    8 +-
 .../staging/lustre/lustre/include/obd_support.h    |    2 +-
 drivers/staging/lustre/lustre/ldlm/ldlm_flock.c    |   30 +-
 drivers/staging/lustre/lustre/ldlm/ldlm_lock.c     |   14 +-
 drivers/staging/lustre/lustre/ldlm/ldlm_lockd.c    |   24 +-
 drivers/staging/lustre/lustre/ldlm/ldlm_pool.c     |  104 +-
 drivers/staging/lustre/lustre/ldlm/ldlm_request.c  |   53 +-
 drivers/staging/lustre/lustre/ldlm/ldlm_resource.c |   14 +-
 drivers/staging/lustre/lustre/llite/dcache.c       |   10 +
 drivers/staging/lustre/lustre/llite/dir.c          |   10 +-
 drivers/staging/lustre/lustre/llite/file.c         |   12 +-
 .../staging/lustre/lustre/llite/llite_internal.h   |    4 +-
 drivers/staging/lustre/lustre/llite/llite_lib.c    |   60 +-
 drivers/staging/lustre/lustre/llite/llite_mmap.c   |    8 +-
 drivers/staging/lustre/lustre/llite/namei.c        |   60 +-
 drivers/staging/lustre/lustre/llite/statahead.c    |  215 +-
 drivers/staging/lustre/lustre/llite/super25.c      |   17 +-
 drivers/staging/lustre/lustre/llite/xattr.c        |   21 +-
 drivers/staging/lustre/lustre/lmv/lmv_obd.c        |    6 +-
 drivers/staging/lustre/lustre/lov/lov_ea.c         |    2 +-
 drivers/staging/lustre/lustre/lov/lov_io.c         |    4 +-
 drivers/staging/lustre/lustre/lov/lov_lock.c       |    2 +-
 drivers/staging/lustre/lustre/lov/lov_object.c     |   22 +-
 drivers/staging/lustre/lustre/lov/lov_pack.c       |    2 +-
 drivers/staging/lustre/lustre/lov/lov_request.c    |   12 +-
 drivers/staging/lustre/lustre/mdc/mdc_locks.c      |    2 +-
 drivers/staging/lustre/lustre/mdc/mdc_request.c    |   16 +-
 drivers/staging/lustre/lustre/mgc/mgc_request.c    |   19 +-
 drivers/staging/lustre/lustre/obdclass/cl_io.c     |   23 +-
 drivers/staging/lustre/lustre/obdclass/cl_lock.c   |    2 +-
 drivers/staging/lustre/lustre/obdclass/cl_object.c |    2 +-
 drivers/staging/lustre/lustre/obdclass/genops.c    |  211 +-
 drivers/staging/lustre/lustre/obdclass/linkea.c    |   16 +-
 .../lustre/lustre/obdclass/linux/linux-module.c    |    4 +-
 drivers/staging/lustre/lustre/obdclass/llog.c      |   22 +-
 drivers/staging/lustre/lustre/obdclass/llog_obd.c  |    5 +-
 .../lustre/lustre/obdclass/lprocfs_status.c        |    4 +-
 drivers/staging/lustre/lustre/obdclass/lu_object.c |   89 +-
 .../lustre/lustre/obdclass/lustre_handles.c        |    4 +-
 .../staging/lustre/lustre/obdclass/obd_config.c    |    2 +-
 drivers/staging/lustre/lustre/obdclass/obd_mount.c |    2 +-
 .../staging/lustre/lustre/obdecho/echo_client.c    |   10 +-
 drivers/staging/lustre/lustre/osc/osc_cache.c      |   34 +-
 drivers/staging/lustre/lustre/osc/osc_object.c     |    6 +-
 drivers/staging/lustre/lustre/osc/osc_page.c       |    8 +-
 drivers/staging/lustre/lustre/osc/osc_request.c    |    8 +-
 drivers/staging/lustre/lustre/ptlrpc/client.c      |  194 +-
 drivers/staging/lustre/lustre/ptlrpc/events.c      |    7 +-
 drivers/staging/lustre/lustre/ptlrpc/import.c      |   85 +-
 drivers/staging/lustre/lustre/ptlrpc/layout.c      |    2 +-
 drivers/staging/lustre/lustre/ptlrpc/niobuf.c      |   15 +-
 .../staging/lustre/lustre/ptlrpc/pack_generic.c    |    9 +-
 drivers/staging/lustre/lustre/ptlrpc/pinger.c      |   99 +-
 .../staging/lustre/lustre/ptlrpc/ptlrpc_internal.h |    2 +-
 .../staging/lustre/lustre/ptlrpc/ptlrpc_module.c   |   56 +-
 drivers/staging/lustre/lustre/ptlrpc/ptlrpcd.c     |   33 +-
 drivers/staging/lustre/lustre/ptlrpc/recover.c     |   38 +-
 drivers/staging/lustre/lustre/ptlrpc/sec.c         |   44 +-
 drivers/staging/lustre/lustre/ptlrpc/sec_bulk.c    |    6 +-
 drivers/staging/lustre/lustre/ptlrpc/sec_gc.c      |   99 +-
 drivers/staging/lustre/lustre/ptlrpc/sec_null.c    |    8 +-
 drivers/staging/lustre/lustre/ptlrpc/sec_plain.c   |    8 +-
 drivers/staging/lustre/lustre/ptlrpc/service.c     |  111 +-
 drivers/staging/most/core.c                        |    9 +-
 drivers/staging/most/core.h                        |    2 +-
 drivers/staging/mt29f_spinand/mt29f_spinand.c      |    3 +
 drivers/staging/mt7621-dma/Kconfig                 |   12 +
 drivers/staging/mt7621-dma/Makefile                |    4 +
 drivers/staging/mt7621-dma/TODO                    |    5 +
 drivers/staging/mt7621-dma/mtk-hsdma.c             |  768 +++++
 drivers/staging/mt7621-dma/ralink-gdma.c           |  930 ++++++
 drivers/staging/mt7621-dts/Kconfig                 |    5 +
 drivers/staging/mt7621-dts/Makefile                |    3 +
 drivers/staging/mt7621-dts/TODO                    |    5 +
 drivers/staging/mt7621-dts/gbpc1.dts               |  143 +
 drivers/staging/mt7621-dts/mt7621.dtsi             |  471 +++
 .../devicetree/bindings/net/mediatek-net-gsw.txt   |   48 +
 drivers/staging/mt7621-eth/Kconfig                 |   39 +
 drivers/staging/mt7621-eth/Makefile                |   14 +
 drivers/staging/mt7621-eth/TODO                    |   13 +
 drivers/staging/mt7621-eth/ethtool.c               |  225 ++
 drivers/staging/mt7621-eth/ethtool.h               |   22 +
 drivers/staging/mt7621-eth/gsw_mt7620.h            |  277 ++
 drivers/staging/mt7621-eth/gsw_mt7621.c            |  298 ++
 drivers/staging/mt7621-eth/mdio.c                  |  271 ++
 drivers/staging/mt7621-eth/mdio.h                  |   27 +
 drivers/staging/mt7621-eth/mdio_mt7620.c           |  173 ++
 drivers/staging/mt7621-eth/mtk_eth_soc.c           | 2178 ++++++++++++++
 drivers/staging/mt7621-eth/mtk_eth_soc.h           |  721 +++++
 drivers/staging/mt7621-eth/soc_mt7621.c            |  160 +
 drivers/staging/mt7621-gpio/Kconfig                |    6 +
 drivers/staging/mt7621-gpio/Makefile               |    3 +
 drivers/staging/mt7621-gpio/TODO                   |    5 +
 drivers/staging/mt7621-gpio/gpio-mt7621.c          |  352 +++
 drivers/staging/mt7621-mmc/Kconfig                 |   16 +
 drivers/staging/mt7621-mmc/Makefile                |   42 +
 drivers/staging/mt7621-mmc/TODO                    |    8 +
 drivers/staging/mt7621-mmc/board.h                 |  137 +
 drivers/staging/mt7621-mmc/dbg.c                   |  347 +++
 drivers/staging/mt7621-mmc/dbg.h                   |  156 +
 drivers/staging/mt7621-mmc/mt6575_sd.h             | 1001 +++++++
 drivers/staging/mt7621-mmc/sd.c                    | 3074 ++++++++++++++++++++
 drivers/staging/mt7621-pci/Makefile                |    1 +
 drivers/staging/mt7621-pci/TODO                    |   12 +
 drivers/staging/mt7621-pci/pci-mt7621.c            |  840 ++++++
 drivers/staging/mt7621-pinctrl/Kconfig             |    4 +
 drivers/staging/mt7621-pinctrl/Makefile            |    3 +
 drivers/staging/mt7621-pinctrl/TODO                |    6 +
 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c    |  472 +++
 drivers/staging/mt7621-spi/Kconfig                 |    6 +
 drivers/staging/mt7621-spi/Makefile                |    1 +
 drivers/staging/mt7621-spi/TODO                    |    5 +
 drivers/staging/mt7621-spi/spi-mt7621.c            |  489 ++++
 drivers/staging/netlogic/xlr_net.c                 |    3 +-
 drivers/staging/pi433/Documentation/pi433.txt      |   28 +-
 drivers/staging/pi433/pi433_if.c                   |   87 +-
 drivers/staging/pi433/pi433_if.h                   |   12 +-
 drivers/staging/pi433/rf69.c                       |  178 +-
 drivers/staging/pi433/rf69.h                       |   28 +-
 drivers/staging/pi433/rf69_enum.h                  |   52 +-
 drivers/staging/rtl8188eu/Kconfig                  |    4 +
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c     |   16 +-
 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c     |   14 +-
 drivers/staging/rtl8188eu/core/rtw_mlme.c          |   14 +-
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c      |   72 +-
 drivers/staging/rtl8188eu/core/rtw_recv.c          |  227 +-
 drivers/staging/rtl8188eu/core/rtw_security.c      |  450 +--
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c       |    4 +-
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c     |    6 +-
 drivers/staging/rtl8188eu/core/rtw_xmit.c          |  125 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c       |    5 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_dm.c        |    2 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c  |    8 +-
 drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c     |    2 +-
 drivers/staging/rtl8188eu/hal/usb_halinit.c        |    2 +-
 drivers/staging/rtl8188eu/include/rtw_security.h   |    2 +-
 drivers/staging/rtl8188eu/include/xmit_osdep.h     |   13 -
 drivers/staging/rtl8188eu/os_dep/usb_intf.c        |    2 +-
 drivers/staging/rtl8188eu/os_dep/xmit_linux.c      |   37 -
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c         |   51 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c          |    2 +-
 drivers/staging/rtl8192e/rtllib_rx.c               |    4 +-
 drivers/staging/rtl8192e/rtllib_wx.c               |    3 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c      |   22 +-
 .../staging/rtl8192u/ieee80211/rtl819x_BAProc.c    |    7 +-
 drivers/staging/rtl8192u/r8192U_core.c             |    2 +
 drivers/staging/rtl8712/drv_types.h                |    2 +-
 drivers/staging/rtl8712/ieee80211.c                |   11 +-
 drivers/staging/rtl8712/ieee80211.h                |    6 +-
 drivers/staging/rtl8712/mlme_linux.c               |    2 +-
 drivers/staging/rtl8712/os_intfs.c                 |    3 +-
 drivers/staging/rtl8712/recv_linux.c               |    4 +-
 drivers/staging/rtl8712/rtl8712_bitdef.h           |    1 -
 drivers/staging/rtl8712/rtl8712_cmd.c              |    8 +-
 drivers/staging/rtl8712/rtl8712_cmd.h              |    4 +-
 drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h   |    2 +-
 drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h   |    2 -
 drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h |    1 -
 drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h |    2 -
 drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h  |    1 -
 drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h  |    2 -
 drivers/staging/rtl8712/rtl8712_gp_bitdef.h        |    2 +-
 drivers/staging/rtl8712/rtl8712_gp_regdef.h        |    1 -
 drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h |    1 -
 drivers/staging/rtl8712/rtl8712_led.c              |   70 +-
 drivers/staging/rtl8712/rtl871x_mlme.c             |    3 +-
 drivers/staging/rtl8712/rtl871x_xmit.c             |    2 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c           |    2 +-
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c     |    4 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c          |    3 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |    8 +-
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c       |    2 +-
 drivers/staging/rtl8723bs/core/rtw_recv.c          |    2 +-
 drivers/staging/rtl8723bs/hal/hal_com.c            |   10 +-
 drivers/staging/rtl8723bs/hal/odm.h                |   90 +-
 drivers/staging/rtl8723bs/hal/odm_CfoTracking.c    |    4 +-
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c       |  122 +-
 drivers/staging/rtl8723bs/hal/odm_HWConfig.h       |    4 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c  |    3 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c    |    2 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c     |  205 +-
 drivers/staging/rtl8723bs/include/drv_types.h      |    4 +-
 drivers/staging/rtl8723bs/include/ieee80211.h      |  154 +-
 drivers/staging/rtl8723bs/include/rtw_mlme.h       |    2 +-
 drivers/staging/rtl8723bs/include/rtw_recv.h       |   10 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |   13 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c     |   99 +-
 drivers/staging/rtl8723bs/os_dep/recv_linux.c      |    7 +-
 drivers/staging/rtl8723bs/os_dep/rtw_proc.c        |   18 +-
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c       |    2 +-
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c      |   24 +-
 drivers/staging/rtlwifi/base.c                     |    6 +-
 .../staging/rtlwifi/btcoexist/halbtc8822b2ant.c    |    8 +-
 drivers/staging/rtlwifi/phydm/phydm_features.h     |    2 +-
 drivers/staging/rtlwifi/phydm/phydm_kfree.h        |    2 +-
 drivers/staging/rtlwifi/phydm/phydm_rainfo.c       |    1 -
 .../rtlwifi/phydm/rtl8822b/phydm_iqk_8822b.c       |    2 +-
 drivers/staging/rtlwifi/rtl8822be/phy.c            |    2 +-
 drivers/staging/rtlwifi/wifi.h                     |   29 +-
 drivers/staging/sm750fb/ddk750_chip.c              |    4 +-
 drivers/staging/sm750fb/ddk750_chip.h              |   14 +-
 drivers/staging/sm750fb/ddk750_display.c           |    2 +-
 drivers/staging/sm750fb/ddk750_display.h           |    7 +-
 drivers/staging/sm750fb/ddk750_mode.c              |    2 +-
 drivers/staging/sm750fb/ddk750_mode.h              |    2 +-
 drivers/staging/sm750fb/sm750_hw.c                 |    4 +-
 drivers/staging/speakup/main.c                     |    8 +-
 drivers/staging/speakup/speakup_decpc.c            |    6 +-
 drivers/staging/speakup/speakup_dectlk.c           |    4 +-
 drivers/staging/speakup/speakup_dtlk.c             |   25 +-
 drivers/staging/speakup/speakup_dummy.c            |    2 +-
 drivers/staging/speakup/speakup_keypc.c            |    4 +-
 drivers/staging/speakup/spk_priv.h                 |    1 +
 drivers/staging/speakup/spk_ttyio.c                |   21 +-
 drivers/staging/speakup/spk_types.h                |    1 +
 drivers/staging/speakup/synth.c                    |   25 +-
 drivers/staging/unisys/visorinput/Kconfig          |    2 +-
 drivers/staging/unisys/visorinput/Makefile         |    1 -
 .../staging/unisys/visorinput/ultrainputreport.h   |   57 -
 drivers/staging/unisys/visorinput/visorinput.c     |  169 +-
 drivers/staging/vc04_services/Makefile             |    1 -
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c      |    6 +-
 .../staging/vc04_services/bcm2835-audio/bcm2835.c  |   54 +-
 .../vc04_services/bcm2835-camera/controls.c        |    1 +
 drivers/staging/vc04_services/interface/vchi/TODO  |   45 +-
 .../interface/vchiq_arm/vchiq_2835_arm.c           |   20 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |  352 ++-
 .../interface/vchiq_arm/vchiq_build_info.h         |   37 -
 .../vc04_services/interface/vchiq_arm/vchiq_if.h   |   10 -
 .../interface/vchiq_arm/vchiq_kern_lib.c           |  431 ---
 .../interface/vchiq_arm/vchiq_memdrv.h             |   59 -
 .../interface/vchiq_arm/vchiq_pagelist.h           |    6 -
 .../interface/vchiq_arm/vchiq_version.c            |   59 -
 drivers/staging/vme/devices/vme_user.c             |    4 +-
 drivers/staging/vt6655/baseband.h                  |   11 +-
 drivers/staging/vt6655/card.h                      |   13 -
 drivers/staging/vt6655/device_cfg.h                |   11 -
 drivers/staging/vt6655/device_main.c               |    6 +-
 drivers/staging/vt6655/rxtx.c                      |   12 +-
 drivers/staging/vt6656/usbpipe.c                   |    3 -
 drivers/staging/wilc1000/coreconfigurator.c        |   32 +-
 drivers/staging/wilc1000/host_interface.c          | 2247 +++++++-------
 drivers/staging/wilc1000/host_interface.h          |    2 +-
 drivers/staging/wilc1000/linux_mon.c               |   12 +-
 drivers/staging/wilc1000/linux_wlan.c              |   22 +-
 drivers/staging/wilc1000/wilc_sdio.c               |  145 +-
 drivers/staging/wilc1000/wilc_spi.c                |  551 ++--
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c  |  351 ++-
 drivers/staging/wilc1000/wilc_wfi_netdevice.h      |    2 +-
 drivers/staging/wilc1000/wilc_wlan.c               |  501 ++--
 drivers/staging/wilc1000/wilc_wlan.h               |    5 +
 drivers/staging/wilc1000/wilc_wlan_cfg.c           |   21 +-
 drivers/staging/wlan-ng/prism2mgmt.c               |    2 +-
 drivers/staging/xgifb/XGI_main_26.c                |   59 +-
 .../fsl-mc/include => include/linux/fsl}/mc.h      |  118 +-
 include/linux/kernel.h                             |    9 +
 include/linux/mfd/axp20x.h                         |    2 +
 include/linux/wait.h                               |  114 +
 include/uapi/linux/irda.h                          |  252 --
 include/uapi/linux/ixjuser.h                       |  721 -----
 include/uapi/linux/telephony.h                     |  263 --
 lib/int_sqrt.c                                     |   30 +
 655 files changed, 27014 insertions(+), 91104 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
 create mode 100644 Documentation/networking/dpaa2/index.rst
 rename {drivers/staging/fsl-mc => Documentation/networking/dpaa2}/overview.rst (100%)
 delete mode 100644 Documentation/networking/irda.txt
 create mode 100644 drivers/bus/fsl-mc/Kconfig
 create mode 100644 drivers/bus/fsl-mc/Makefile
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c (69%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpcon.c (94%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp.c (95%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc-driver.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc.c (96%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-allocator.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-bus.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-msi.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-private.h (86%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-io.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-sys.c (93%)
 create mode 100644 drivers/iio/light/lv0104cs.c
 create mode 100644 drivers/iio/potentiometer/ad5272.c
 create mode 100644 drivers/iio/potentiometer/mcp4018.c
 create mode 100644 drivers/iio/temperature/mlx90632.c
 rename drivers/{staging/fsl-mc/bus => irqchip}/irq-gic-v3-its-fsl-mc-msi.c (97%)
 delete mode 100644 drivers/staging/ccree/Kconfig
 delete mode 100644 drivers/staging/ccree/Makefile
 delete mode 100644 drivers/staging/ccree/TODO
 delete mode 100644 drivers/staging/ccree/cc_aead.c
 delete mode 100644 drivers/staging/ccree/cc_aead.h
 delete mode 100644 drivers/staging/ccree/cc_buffer_mgr.c
 delete mode 100644 drivers/staging/ccree/cc_buffer_mgr.h
 delete mode 100644 drivers/staging/ccree/cc_cipher.c
 delete mode 100644 drivers/staging/ccree/cc_cipher.h
 delete mode 100644 drivers/staging/ccree/cc_crypto_ctx.h
 delete mode 100644 drivers/staging/ccree/cc_debugfs.c
 delete mode 100644 drivers/staging/ccree/cc_debugfs.h
 delete mode 100644 drivers/staging/ccree/cc_driver.c
 delete mode 100644 drivers/staging/ccree/cc_driver.h
 delete mode 100644 drivers/staging/ccree/cc_fips.c
 delete mode 100644 drivers/staging/ccree/cc_fips.h
 delete mode 100644 drivers/staging/ccree/cc_hash.c
 delete mode 100644 drivers/staging/ccree/cc_hash.h
 delete mode 100644 drivers/staging/ccree/cc_host_regs.h
 delete mode 100644 drivers/staging/ccree/cc_hw_queue_defs.h
 delete mode 100644 drivers/staging/ccree/cc_ivgen.c
 delete mode 100644 drivers/staging/ccree/cc_ivgen.h
 delete mode 100644 drivers/staging/ccree/cc_kernel_regs.h
 delete mode 100644 drivers/staging/ccree/cc_lli_defs.h
 delete mode 100644 drivers/staging/ccree/cc_pm.c
 delete mode 100644 drivers/staging/ccree/cc_pm.h
 delete mode 100644 drivers/staging/ccree/cc_request_mgr.c
 delete mode 100644 drivers/staging/ccree/cc_request_mgr.h
 delete mode 100644 drivers/staging/ccree/cc_sram_mgr.c
 delete mode 100644 drivers/staging/ccree/cc_sram_mgr.h
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/Makefile
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/README
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/TODO
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/dpsw.c
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/dpsw.h
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/ethsw.c
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/ethsw.h
 delete mode 100644 drivers/staging/fsl-mc/TODO
 delete mode 100644 drivers/staging/fsl-mc/bus/dpbp-cmd.h
 delete mode 100644 drivers/staging/fsl-mc/bus/dpcon-cmd.h
 delete mode 100644 drivers/staging/fsl-mc/include/dpbp.h
 delete mode 100644 drivers/staging/fsl-mc/include/dpcon.h
 delete mode 100644 drivers/staging/irda/TODO
 delete mode 100644 drivers/staging/irda/drivers/Kconfig
 delete mode 100644 drivers/staging/irda/drivers/Makefile
 delete mode 100644 drivers/staging/irda/drivers/act200l-sir.c
 delete mode 100644 drivers/staging/irda/drivers/actisys-sir.c
 delete mode 100644 drivers/staging/irda/drivers/ali-ircc.c
 delete mode 100644 drivers/staging/irda/drivers/ali-ircc.h
 delete mode 100644 drivers/staging/irda/drivers/au1k_ir.c
 delete mode 100644 drivers/staging/irda/drivers/bfin_sir.c
 delete mode 100644 drivers/staging/irda/drivers/bfin_sir.h
 delete mode 100644 drivers/staging/irda/drivers/donauboe.c
 delete mode 100644 drivers/staging/irda/drivers/donauboe.h
 delete mode 100644 drivers/staging/irda/drivers/esi-sir.c
 delete mode 100644 drivers/staging/irda/drivers/girbil-sir.c
 delete mode 100644 drivers/staging/irda/drivers/irda-usb.c
 delete mode 100644 drivers/staging/irda/drivers/irda-usb.h
 delete mode 100644 drivers/staging/irda/drivers/irtty-sir.c
 delete mode 100644 drivers/staging/irda/drivers/irtty-sir.h
 delete mode 100644 drivers/staging/irda/drivers/kingsun-sir.c
 delete mode 100644 drivers/staging/irda/drivers/ks959-sir.c
 delete mode 100644 drivers/staging/irda/drivers/ksdazzle-sir.c
 delete mode 100644 drivers/staging/irda/drivers/litelink-sir.c
 delete mode 100644 drivers/staging/irda/drivers/ma600-sir.c
 delete mode 100644 drivers/staging/irda/drivers/mcp2120-sir.c
 delete mode 100644 drivers/staging/irda/drivers/mcs7780.c
 delete mode 100644 drivers/staging/irda/drivers/mcs7780.h
 delete mode 100644 drivers/staging/irda/drivers/nsc-ircc.c
 delete mode 100644 drivers/staging/irda/drivers/nsc-ircc.h
 delete mode 100644 drivers/staging/irda/drivers/old_belkin-sir.c
 delete mode 100644 drivers/staging/irda/drivers/pxaficp_ir.c
 delete mode 100644 drivers/staging/irda/drivers/sa1100_ir.c
 delete mode 100644 drivers/staging/irda/drivers/sh_sir.c
 delete mode 100644 drivers/staging/irda/drivers/sir-dev.h
 delete mode 100644 drivers/staging/irda/drivers/sir_dev.c
 delete mode 100644 drivers/staging/irda/drivers/sir_dongle.c
 delete mode 100644 drivers/staging/irda/drivers/smsc-ircc2.c
 delete mode 100644 drivers/staging/irda/drivers/smsc-ircc2.h
 delete mode 100644 drivers/staging/irda/drivers/smsc-sio.h
 delete mode 100644 drivers/staging/irda/drivers/stir4200.c
 delete mode 100644 drivers/staging/irda/drivers/tekram-sir.c
 delete mode 100644 drivers/staging/irda/drivers/toim3232-sir.c
 delete mode 100644 drivers/staging/irda/drivers/via-ircc.c
 delete mode 100644 drivers/staging/irda/drivers/via-ircc.h
 delete mode 100644 drivers/staging/irda/drivers/vlsi_ir.c
 delete mode 100644 drivers/staging/irda/drivers/vlsi_ir.h
 delete mode 100644 drivers/staging/irda/drivers/w83977af.h
 delete mode 100644 drivers/staging/irda/drivers/w83977af_ir.c
 delete mode 100644 drivers/staging/irda/drivers/w83977af_ir.h
 delete mode 100644 drivers/staging/irda/include/net/irda/af_irda.h
 delete mode 100644 drivers/staging/irda/include/net/irda/crc.h
 delete mode 100644 drivers/staging/irda/include/net/irda/discovery.h
 delete mode 100644 drivers/staging/irda/include/net/irda/ircomm_core.h
 delete mode 100644 drivers/staging/irda/include/net/irda/ircomm_event.h
 delete mode 100644 drivers/staging/irda/include/net/irda/ircomm_lmp.h
 delete mode 100644 drivers/staging/irda/include/net/irda/ircomm_param.h
 delete mode 100644 drivers/staging/irda/include/net/irda/ircomm_ttp.h
 delete mode 100644 drivers/staging/irda/include/net/irda/ircomm_tty.h
 delete mode 100644 drivers/staging/irda/include/net/irda/ircomm_tty_attach.h
 delete mode 100644 drivers/staging/irda/include/net/irda/irda.h
 delete mode 100644 drivers/staging/irda/include/net/irda/irda_device.h
 delete mode 100644 drivers/staging/irda/include/net/irda/iriap.h
 delete mode 100644 drivers/staging/irda/include/net/irda/iriap_event.h
 delete mode 100644 drivers/staging/irda/include/net/irda/irias_object.h
 delete mode 100644 drivers/staging/irda/include/net/irda/irlan_client.h
 delete mode 100644 drivers/staging/irda/include/net/irda/irlan_common.h
 delete mode 100644 drivers/staging/irda/include/net/irda/irlan_eth.h
 delete mode 100644 drivers/staging/irda/include/net/irda/irlan_event.h
 delete mode 100644 drivers/staging/irda/include/net/irda/irlan_filter.h
 delete mode 100644 drivers/staging/irda/include/net/irda/irlan_provider.h
 delete mode 100644 drivers/staging/irda/include/net/irda/irlap.h
 delete mode 100644 drivers/staging/irda/include/net/irda/irlap_event.h
 delete mode 100644 drivers/staging/irda/include/net/irda/irlap_frame.h
 delete mode 100644 drivers/staging/irda/include/net/irda/irlmp.h
 delete mode 100644 drivers/staging/irda/include/net/irda/irlmp_event.h
 delete mode 100644 drivers/staging/irda/include/net/irda/irlmp_frame.h
 delete mode 100644 drivers/staging/irda/include/net/irda/irmod.h
 delete mode 100644 drivers/staging/irda/include/net/irda/irqueue.h
 delete mode 100644 drivers/staging/irda/include/net/irda/irttp.h
 delete mode 100644 drivers/staging/irda/include/net/irda/parameters.h
 delete mode 100644 drivers/staging/irda/include/net/irda/qos.h
 delete mode 100644 drivers/staging/irda/include/net/irda/timer.h
 delete mode 100644 drivers/staging/irda/include/net/irda/wrapper.h
 delete mode 100644 drivers/staging/irda/net/Kconfig
 delete mode 100644 drivers/staging/irda/net/Makefile
 delete mode 100644 drivers/staging/irda/net/af_irda.c
 delete mode 100644 drivers/staging/irda/net/discovery.c
 delete mode 100644 drivers/staging/irda/net/ircomm/Kconfig
 delete mode 100644 drivers/staging/irda/net/ircomm/Makefile
 delete mode 100644 drivers/staging/irda/net/ircomm/ircomm_core.c
 delete mode 100644 drivers/staging/irda/net/ircomm/ircomm_event.c
 delete mode 100644 drivers/staging/irda/net/ircomm/ircomm_lmp.c
 delete mode 100644 drivers/staging/irda/net/ircomm/ircomm_param.c
 delete mode 100644 drivers/staging/irda/net/ircomm/ircomm_ttp.c
 delete mode 100644 drivers/staging/irda/net/ircomm/ircomm_tty.c
 delete mode 100644 drivers/staging/irda/net/ircomm/ircomm_tty_attach.c
 delete mode 100644 drivers/staging/irda/net/ircomm/ircomm_tty_ioctl.c
 delete mode 100644 drivers/staging/irda/net/irda_device.c
 delete mode 100644 drivers/staging/irda/net/iriap.c
 delete mode 100644 drivers/staging/irda/net/iriap_event.c
 delete mode 100644 drivers/staging/irda/net/irias_object.c
 delete mode 100644 drivers/staging/irda/net/irlan/Kconfig
 delete mode 100644 drivers/staging/irda/net/irlan/Makefile
 delete mode 100644 drivers/staging/irda/net/irlan/irlan_client.c
 delete mode 100644 drivers/staging/irda/net/irlan/irlan_client_event.c
 delete mode 100644 drivers/staging/irda/net/irlan/irlan_common.c
 delete mode 100644 drivers/staging/irda/net/irlan/irlan_eth.c
 delete mode 100644 drivers/staging/irda/net/irlan/irlan_event.c
 delete mode 100644 drivers/staging/irda/net/irlan/irlan_filter.c
 delete mode 100644 drivers/staging/irda/net/irlan/irlan_provider.c
 delete mode 100644 drivers/staging/irda/net/irlan/irlan_provider_event.c
 delete mode 100644 drivers/staging/irda/net/irlap.c
 delete mode 100644 drivers/staging/irda/net/irlap_event.c
 delete mode 100644 drivers/staging/irda/net/irlap_frame.c
 delete mode 100644 drivers/staging/irda/net/irlmp.c
 delete mode 100644 drivers/staging/irda/net/irlmp_event.c
 delete mode 100644 drivers/staging/irda/net/irlmp_frame.c
 delete mode 100644 drivers/staging/irda/net/irmod.c
 delete mode 100644 drivers/staging/irda/net/irnet/Kconfig
 delete mode 100644 drivers/staging/irda/net/irnet/Makefile
 delete mode 100644 drivers/staging/irda/net/irnet/irnet.h
 delete mode 100644 drivers/staging/irda/net/irnet/irnet_irda.c
 delete mode 100644 drivers/staging/irda/net/irnet/irnet_irda.h
 delete mode 100644 drivers/staging/irda/net/irnet/irnet_ppp.c
 delete mode 100644 drivers/staging/irda/net/irnet/irnet_ppp.h
 delete mode 100644 drivers/staging/irda/net/irnetlink.c
 delete mode 100644 drivers/staging/irda/net/irproc.c
 delete mode 100644 drivers/staging/irda/net/irqueue.c
 delete mode 100644 drivers/staging/irda/net/irsysctl.c
 delete mode 100644 drivers/staging/irda/net/irttp.c
 delete mode 100644 drivers/staging/irda/net/parameters.c
 delete mode 100644 drivers/staging/irda/net/qos.c
 delete mode 100644 drivers/staging/irda/net/timer.c
 delete mode 100644 drivers/staging/irda/net/wrapper.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/linux/linux-curproc.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/linux/linux-mem.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/linux/linux-prim.c
 create mode 100644 drivers/staging/mt7621-dma/Kconfig
 create mode 100644 drivers/staging/mt7621-dma/Makefile
 create mode 100644 drivers/staging/mt7621-dma/TODO
 create mode 100644 drivers/staging/mt7621-dma/mtk-hsdma.c
 create mode 100644 drivers/staging/mt7621-dma/ralink-gdma.c
 create mode 100644 drivers/staging/mt7621-dts/Kconfig
 create mode 100644 drivers/staging/mt7621-dts/Makefile
 create mode 100644 drivers/staging/mt7621-dts/TODO
 create mode 100644 drivers/staging/mt7621-dts/gbpc1.dts
 create mode 100644 drivers/staging/mt7621-dts/mt7621.dtsi
 create mode 100644 drivers/staging/mt7621-eth/Documentation/devicetree/bindings/net/mediatek-net-gsw.txt
 create mode 100644 drivers/staging/mt7621-eth/Kconfig
 create mode 100644 drivers/staging/mt7621-eth/Makefile
 create mode 100644 drivers/staging/mt7621-eth/TODO
 create mode 100644 drivers/staging/mt7621-eth/ethtool.c
 create mode 100644 drivers/staging/mt7621-eth/ethtool.h
 create mode 100644 drivers/staging/mt7621-eth/gsw_mt7620.h
 create mode 100644 drivers/staging/mt7621-eth/gsw_mt7621.c
 create mode 100644 drivers/staging/mt7621-eth/mdio.c
 create mode 100644 drivers/staging/mt7621-eth/mdio.h
 create mode 100644 drivers/staging/mt7621-eth/mdio_mt7620.c
 create mode 100644 drivers/staging/mt7621-eth/mtk_eth_soc.c
 create mode 100644 drivers/staging/mt7621-eth/mtk_eth_soc.h
 create mode 100644 drivers/staging/mt7621-eth/soc_mt7621.c
 create mode 100644 drivers/staging/mt7621-gpio/Kconfig
 create mode 100644 drivers/staging/mt7621-gpio/Makefile
 create mode 100644 drivers/staging/mt7621-gpio/TODO
 create mode 100644 drivers/staging/mt7621-gpio/gpio-mt7621.c
 create mode 100644 drivers/staging/mt7621-mmc/Kconfig
 create mode 100644 drivers/staging/mt7621-mmc/Makefile
 create mode 100644 drivers/staging/mt7621-mmc/TODO
 create mode 100644 drivers/staging/mt7621-mmc/board.h
 create mode 100644 drivers/staging/mt7621-mmc/dbg.c
 create mode 100644 drivers/staging/mt7621-mmc/dbg.h
 create mode 100644 drivers/staging/mt7621-mmc/mt6575_sd.h
 create mode 100644 drivers/staging/mt7621-mmc/sd.c
 create mode 100644 drivers/staging/mt7621-pci/Makefile
 create mode 100644 drivers/staging/mt7621-pci/TODO
 create mode 100644 drivers/staging/mt7621-pci/pci-mt7621.c
 create mode 100644 drivers/staging/mt7621-pinctrl/Kconfig
 create mode 100644 drivers/staging/mt7621-pinctrl/Makefile
 create mode 100644 drivers/staging/mt7621-pinctrl/TODO
 create mode 100644 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
 create mode 100644 drivers/staging/mt7621-spi/Kconfig
 create mode 100644 drivers/staging/mt7621-spi/Makefile
 create mode 100644 drivers/staging/mt7621-spi/TODO
 create mode 100644 drivers/staging/mt7621-spi/spi-mt7621.c
 delete mode 100644 drivers/staging/unisys/visorinput/ultrainputreport.h
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_build_info.h
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_memdrv.h
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_version.c
 rename {drivers/staging/fsl-mc/include => include/linux/fsl}/mc.h (82%)
 delete mode 100644 include/uapi/linux/irda.h
 delete mode 100644 include/uapi/linux/ixjuser.h
 delete mode 100644 include/uapi/linux/telephony.h
