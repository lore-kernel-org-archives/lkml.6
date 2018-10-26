Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B27BC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3172082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlOcR71F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3172082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeJZSkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbeJZSkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:40:04 -0400
Received: from localhost (unknown [80.169.156.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 853282082E;
        Fri, 26 Oct 2018 10:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540548216;
        bh=DEckJ4+SfFrZf2d/mqgE5u7DPs2hAEe5PViOUZebMW4=;
        h=Date:From:To:Cc:Subject:From;
        b=rlOcR71FyagvAzXYx5K9kF5r+XIUiUBlwEkg26YIgFbGaxLZonAXQhQdmliW1ZSsC
         rFKiVIUn3pHaVudQgvzcVINFoAJPX238UInjQD5Mk10ZsqPHBAAPMzd6CB4OovNvSF
         UO7hN7RJd4bxm9BlpceM4enlqtDiVkhMv1WYEigU=
Date:   Fri, 26 Oct 2018 11:03:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver patches for 4.20-rc1
Message-ID: <20181026100333.GA13268@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-4.20-rc1

for you to fetch changes up to 14fdc2c5318ae420e68496975f48dc1dbef52649:

  Documentation/security-bugs: Clarify treatment of embargoed information (2018-10-23 14:15:58 +0100)

----------------------------------------------------------------
Char/Misc driver patches for 4.20-rc1

Here is the big set of char/misc patches for 4.20-rc1.

Loads of things here, we have new code in all of these driver
subsystems:
	fpga
	stm
	extcon
	nvmem
	eeprom
	hyper-v
	gsmi
	coresight
	thunderbolt
	vmw_balloon
	goldfish
	soundwire

along with lots of fixes and minor changes to other small drivers.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Tull (4):
      fpga: mgr: add devm_fpga_mgr_create
      fpga: bridge: add devm_fpga_bridge_create
      fpga: add devm_fpga_region_create
      docs: fpga: document programming fpgas using regions

Alexander Shishkin (17):
      stm class: Rework policy node fallback
      stm class: Clarify configfs root type/operations names
      stm class: Clean up stp_configfs_init
      stm class: Introduce framing protocol drivers
      stm class: Add a helper for writing data packets
      stm class: Factor out default framing protocol
      stm class: Switch over to the protocol driver
      stm class: Add MIPI SyS-T protocol support
      stm class: p_sys-t: Add support for CLOCKSYNC packets
      stm class: p_sys-t: Document the configfs interface
      stm class: Document the MIPI SyS-T protocol usage
      stm class: Update documentation to match the new identification rules
      stm class: SPDX-ify the documentation
      stm class: heartbeat: Fix whitespace
      lib: Add memcat_p(): paste 2 pointer arrays together
      stm class: Use memcat_p()
      lib: Fix ia64 bootloader linkage

Alexandre Belloni (1):
      uio: ensure class is registered before devices

Andreas Kemnade (1):
      w1: omap-hdq: fix missing bus unregister at removal

Andy Shevchenko (7):
      extcon: Make static analyzer happy about union assignment
      extcon: Switch to use kasprintf() instead of open coded
      extcon: cht-wc: Return from default case to avoid warnings
      extcon: cht-wc: Fix definition names according to spec
      extcon: cht-wc: Correct USBID bit field handling
      extcon: cht-wc: Convert to use SPDX identifier
      extcon: int3496: Convert to use SPDX identifier

Arnd Bergmann (2):
      slimbus: ngd: mark PM functions as __maybe_unused
      nvmem: hide unused nvmem_find_cell_by_index function

Bartosz Golaszewski (26):
      eeprom: eeprom_93xx46: use resource management
      eeprom: at25: use devm_nvmem_register()
      nvmem: provide nvmem_dev_name()
      nvmem: remove the name field from struct nvmem_device
      nvmem: use list_for_each_entry_safe in nvmem_device_remove_all_cells()
      nvmem: remove a stray newline
      nvmem: check the return value of nvmem_add_cells()
      nvmem: use kref
      nvmem: sunxi_sid: return -ENOMEM if kzalloc() fails
      nvmem: sunxi_sid: use devm_nvmem_register()
      nvmem: lpc18xx_eeprom: use devm_nvmem_register()
      nvmem: mxs-ocotp: use devm_nvmem_register()
      nvmem: change the signature of nvmem_unregister()
      nvmem: remove the global cell list
      nvmem: add support for cell info
      nvmem: resolve cells from DT at registration time
      nvmem: add support for cell lookups from machine code
      Documentation: nvmem: document cell tables and lookup entries
      nvmem: add a notifier chain
      nvmem: use SPDX license identifiers
      nvmem: make the naming of arguments in nvmem_cell_get() consistent
      nvmem: use EOPNOTSUPP instead of ENOSYS
      nvmem: fix commenting style
      nvmem: use octal permissions instead of constants
      nvmem: fix nvmem_cell_get_from_lookup()
      nvmem: lpc18xx_eeprom: remove unused variable

Colin Ian King (6):
      drivers: fpga: fix two trivial spelling mistakes
      misc: apds990x: remove unused array ir_currents
      misc: bh1770glc: remove unused array prox_curr_ma
      firmware: google: make structure gsmi_dev static
      firmware: vpd: fix spelling mistake "partion" -> "partition"
      misc: mic: scif: remove redundant check on ret < 0

Dan Carpenter (1):
      mei: samples: fix a signedness bug in amt_host_if_call()

Dan Williams (1):
      MAINTAINERS: Clarify UIO vs UIOVEC maintainer

Dexuan Cui (4):
      Drivers: hv: vmbus: Fix the descriptions of some function parameters
      Drivers: hv: kvp: Fix the indentation of some "break" statements
      Drivers: hv: kvp: Fix two "this statement may fall through" warnings
      Drivers: hv: vmbus: Use cpumask_var_t for on-stack cpu mask

Ding Xiang (1):
      vme: remove unneeded kfree

Duncan Laurie (3):
      gsmi: Fix bug in append_to_eventlog sysfs handler
      gsmi: Add coreboot to list of matching BIOS vendors
      gsmi: Remove autoselected dependency on EFI and EFI_VARS

Furquan Shaikh (1):
      gsmi: Add GSMI commands to log S0ix info

Greg Kroah-Hartman (5):
      Merge b4.19-rc4 into char-misc-next
      Merge 4.19-rc6
      Merge tag 'extcon-next-for-4.20' of git://git.kernel.org/.../chanwoo/extcon into char-misc-next
      Merge tag 'soundwire-4.20-rc1' of git://git.kernel.org/.../vkoul/soundwire into char-misc-next
      Merge 4.19-rc7 into char-misc-next

Gustavo A. R. Silva (1):
      misc: sgi-gru: fix fall-through annotations

Jean Delvare (1):
      eeprom: New ee1004 driver for DDR4 memory

Joel Fernandes (Google) (1):
      MAINTAINERS: Add me to Android drivers

Jorgen Hansen (1):
      VMCI: Resource wildcard match fixed

Julien Folly (1):
      w1: IAD Register is yet readable trough iad sys file. Fix snprintf (%u for unsigned, count for max size).

Krzysztof Kozlowski (1):
      extcon: maxim: Add SPDX license identifiers

Lance Roy (2):
      sgi-xp: Replace spin_is_locked() with lockdep
      hv_balloon: Replace spin_is_locked() with lockdep

Laura Abbott (1):
      misc: kgdbts: Fix restrict error

Leo Yan (2):
      coresight: tmc: Refactor loops in etb dump
      coresight: tmc: Fix byte-address alignment for RRP

Martijn Coenen (1):
      binder: Add BINDER_GET_NODE_INFO_FOR_REF ioctl.

Mathieu Poirier (2):
      coresight: etb10: Refactor etb_drvdata::mode handling
      coresight: etb10: Splitting function etb_enable()

Michael Hennerich (1):
      drivers: misc: ad525x_dpot: Update MODULE AUTHOR email address

Michael Kelley (1):
      Drivers: hv: vmbus: Fix synic per-cpu context initialization

Mika Westerberg (4):
      thunderbolt: Make the driver less verbose
      thunderbolt: Print connected devices
      thunderbolt: Convert rest of the driver files to use SPDX identifier
      thunderbolt: Add Intel as copyright holder

Nadav Amit (14):
      vmw_balloon: handle commands in a single function.
      vmw_balloon: unify commands tracing and stats
      vmw_balloon: merge send_lock and send_unlock path
      vmw_balloon: simplifying batch access
      vmw_balloon: remove sleeping allocations
      vmw_balloon: change batch/single lock abstractions
      vmw_balloon: treat all refused pages equally
      vmw_balloon: rename VMW_BALLOON_2M_SHIFT to VMW_BALLOON_2M_ORDER
      vmw_balloon: refactor change size from vmballoon_work
      vmw_balloon: simplify vmballoon_send_get_target()
      vmw_balloon: stats rework
      vmw_balloon: rework the inflate and deflate loops
      vmw_balloon: general style cleanup
      vmw_balloon: add reset stat

Nathan Chancellor (2):
      misc: echo: Remove unnecessary parentheses and simplify check for zero
      misc: mic: scif: Remove unused variable

Parth Y Shah (1):
      misc: lkdtm: fixed static variable initialization

Randy Dunlap (1):
      Documentation: soundwire: fix stream.rst markup warnings

Rasmus Villemoes (1):
      android: binder: use kstrdup instead of open-coding it

Rob Herring (4):
      uio: Convert to using %pOFn instead of device_node.name
      misc: Convert to using %pOFn instead of device_node.name
      uio: Convert a few more users to using %pOFn instead of device_node.name
      nvmem: Convert to using %pOFn instead of device_node.name

Roman Kiryanov (31):
      platform: goldfish: pipe: Fix comments to fit 80 columns
      platform: goldfish: pipe: Update license
      platform: goldfish: pipe: Move an opening brace to the next line
      platform: goldfish: pipe: Separate the host interface to a separate header
      platform: goldfish: pipe: Update the comment for GFP_ATOMIC
      platform: goldfish: pipe: Fail compilation if structs are too large
      platform: goldfish: pipe: Replace an array of 1 with a variable
      platform: goldfish: pipe: Replace pr_ with dev_ for logging
      platform: goldfish: pipe: Add blank lines to separate struct members
      platform: goldfish: pipe: Remove a redundant variable
      platform: goldfish: pipe: Replace two code blocks with a function call
      platform: goldfish: pipe: Remove reduntant casting
      platform: goldfish: pipe: Remove a blank line before '}'
      platform: goldfish: pipe: Rename 'wakeBit' to 'wake_bit'
      platform: goldfish: pipe: Remove reduntant casting to (void)
      platform: goldfish: pipe: Rename goldfish_x to goldfish_pipe_x
      platform: goldfish: pipe: Fix lines to not end an opening bracket
      platform: goldfish: pipe: Fix alignment to match parenthesis
      platform: goldfish: pipe: Move logical ops to the end of the prev line
      platform: goldfish: pipe: Replace "x==NULL" to "!x"
      platform: goldfish: pipe: Remove license boilerplate
      platform: goldfish: pipe: Prevent memory corruption from several threads writing to the same variable
      platform: goldfish: pipe: Remove a redundant blank line
      platform: goldfish: pipe: Remove redundant struct declarations
      platform: goldfish: pipe: Remove redundant header include
      platform: goldfish: pipe: Move the file-scope goldfish_interrupt_tasklet variable into the driver state
      platform: goldfish: pipe: Move the file-scope goldfish_pipe_miscdev variable into the driver state
      platform: goldfish: pipe: Move the file-scope goldfish_pipe_dev variable into the driver state
      platform: goldfish: pipe: Call misc_deregister if init fails
      platform: goldfish: pipe: Remove redundant casting
      platform: goldfish: pipe: Add a blank line to separate varibles and code

Sanyog Kale (2):
      Documentation: soundwire: Add documentation for multi link
      soundwire: Add support to lock across bus instances

Sherry Yang (1):
      android: binder: no outgoing transaction when thread todo has transaction

Shreyas NC (5):
      soundwire: Initialize completion for defer messages
      soundwire: Add support for multi link bank switch
      soundwire: keep track of Masters in a stream
      soundwire: intel: Add pre/post bank switch ops
      soundwire: intel: Remove duplicate assignment

Souptick Joarder (1):
      uio: convert to vm_fault_t

Srinivas Kandagatla (10):
      nvmem: core: return error code instead of NULL from nvmem_device_get
      slimbus: ngd: register ngd driver only once.
      slimbus: ngd: return proper error code instead of zero
      silmbus: ngd: register controller after power up.
      slimbus: ngd: validate logical address assigned by remote
      slimbus: core: match device tree based devices correctly
      slimbus: core: update device status in probe
      slimbus: core: add support to uevent
      nvmem: sunxi_sid: remove unused variable in probe
      nvmem: make nvmem_add_cells() static

Stephen Boyd (6):
      firmware: coreboot: Let OF core populate platform device
      firmware: coreboot: Unmap ioregion after device population
      firmware: coreboot: Make bus registration symmetric
      firmware: coreboot: Collapse platform drivers into bus core
      firmware: coreboot: Remap RAM with memremap() instead of ioremap()
      firmware: coreboot: Only populate devices in coreboot_table_init()

Stephen Hemminger (9):
      vmbus: add driver_override support
      uio_hv_generic: increase size of receive and send buffers
      uio_hv_generic: drop #ifdef DEBUG
      vmbus: pass channel to hv_process_channel_removal
      vmbus: keep pointer to ring buffer page
      vmbus: split ring buffer allocation from open
      uio: introduce UIO_MEM_IOVA
      hv_uio_generic: map ringbuffer phys addr
      uio_hv_generic: defer opening vmbus until first use

Suzuki K Poulose (37):
      coresight: Document error handling in coresight_register
      coresight: platform: Refactor graph endpoint parsing
      coresight: platform: Fix refcounting for graph nodes
      coresight: platform: Fix leaking device reference
      coresight: Fix remote endpoint parsing
      coresight: Add helper to check if the endpoint is input
      coresight: platform: Cleanup coresight connection handling
      coresight: Cleanup coresight DT bindings
      coresight: Fix handling of sinks
      coresight: etb10: Fix handling of perf mode
      coresight: perf: Fix per cpu path management
      coresight: perf: Avoid unncessary CPU hotplug read lock
      coresight: perf: Allow tracing on hotplugged CPUs
      coresight: perf: Disable trace path upon source error
      coresight: tmc-etr: Handle driver mode specific ETR buffers
      coresight: tmc-etr: Relax collection of trace from sysfs mode
      coresight: Convert driver messages to dev_dbg
      coresight: perf: Remove reset_buffer call back for sinks
      coresight: perf: Add helper to retrieve sink configuration
      coresight: perf: Remove set_buffer call back
      coresight: etm-perf: Add support for ETR backend
      coresight: Handle failures in enabling a trace path
      coresight: tmc-etr: Refactor for handling errors
      coresight: tmc-etr: Handle errors enabling CATU
      coresight: tmc-etb/etf: Prepare to handle errors enabling
      coresight: etm4x: Add support for handling errors
      coresight: etm3: Add support for handling errors
      coresight: etb10: Handle errors enabling the device
      coresight: dynamic-replicator: Handle multiple connections
      coresight: Add support for CLAIM tag protocol
      coresight: etmx: Claim devices before use
      coresight: funnel: Claim devices before use
      coresight: catu: Claim device before use
      coresight: dynamic-replicator: Claim device for use
      coresight: dts: binding: Fix example for TPIU component
      coresight: dts: binding: Update coresight binding examples
      coreisght: tmc: Claim device before use

Todd Kjos (1):
      binder: use standard functions to allocate fds

Tomas Winkler (1):
      mei: replace POLL* with EPOLL* for write queues.

Tomasz Nowicki (1):
      coresight: etm4x: Configure EL2 exception level when kernel is running in HYP

Vinod Koul (3):
      soundwire: Handle multiple master instances in a stream
      soundwire: intel: Fix uninitialized adev deref
      MAINTAINERS: Update Vinod's email

Wei Yongjun (3):
      platform: goldfish: pipe: Make symbol 'goldfish_pipe_dev' static
      uio: make symbol 'uio_class_registered' static
      binder: make symbol 'binder_free_buf' static

Wenwen Wang (1):
      misc: mic: fix a DMA pool free failure

Will Deacon (1):
      Documentation/security-bugs: Clarify treatment of embargoed information

Will Korteland (1):
      docs/uio: fix a grammar nitpick

YueHaibing (3):
      VMCI: remove set but not used variable 'cid'
      misc: mic: scif: remove set but not used variables 'src_dma_addr, dst_dma_addr'
      eeprom: at25: remove unneeded 'at25_remove'

zhong jiang (10):
      misc: sgi-xp: remove meaningless null check before kfree
      coresight: Use ERR_CAST instead of ERR_PTR
      coresight: Remove redundant null pointer check before of_node_put and put_device
      misc: sram: remove redundant null pointer check before of_node_put
      misc: remove redundant include moduleparam.h
      misc: genwqe: should return proper error value.
      misc: genwqe: remove duplicated include file
      thunderbolt: Remove a meaningless NULL pointer check before dma_pool_destroy
      misc: card_utils: remove duplicated include file
      misc: cxl: Fix possible null pointer dereference

 .../ABI/testing/configfs-stp-policy-p_sys-t        |   41 +
 Documentation/ABI/testing/sysfs-bus-vmbus          |   21 +
 Documentation/admin-guide/security-bugs.rst        |   47 +-
 .../devicetree/bindings/arm/coresight.txt          |  120 +-
 Documentation/driver-api/fpga/fpga-bridge.rst      |   37 +-
 Documentation/driver-api/fpga/fpga-mgr.rst         |  126 +-
 Documentation/driver-api/fpga/fpga-programming.rst |  107 ++
 Documentation/driver-api/fpga/fpga-region.rst      |   91 +-
 Documentation/driver-api/fpga/index.rst            |    2 +
 Documentation/driver-api/fpga/intro.rst            |    2 +-
 Documentation/driver-api/soundwire/stream.rst      |   36 +
 Documentation/driver-api/uio-howto.rst             |    4 +-
 Documentation/nvmem/nvmem.txt                      |   31 +
 Documentation/trace/stm.rst                        |   38 +-
 Documentation/trace/sys-t.rst                      |   62 +
 MAINTAINERS                                        |   11 +-
 drivers/android/Kconfig                            |    2 +-
 drivers/android/binder.c                           |  489 ++++--
 drivers/android/binder_trace.h                     |   36 +-
 drivers/extcon/extcon-intel-cht-wc.c               |   60 +-
 drivers/extcon/extcon-intel-int3496.c              |   12 +-
 drivers/extcon/extcon-max14577.c                   |   24 +-
 drivers/extcon/extcon-max77693.c                   |   22 +-
 drivers/extcon/extcon-max77843.c                   |   19 +-
 drivers/extcon/extcon-max8997.c                    |   22 +-
 drivers/extcon/extcon.c                            |   15 +-
 drivers/firmware/google/Kconfig                    |   32 +-
 drivers/firmware/google/Makefile                   |    2 -
 drivers/firmware/google/coreboot_table-acpi.c      |   88 -
 drivers/firmware/google/coreboot_table-of.c        |   82 -
 drivers/firmware/google/coreboot_table.c           |  126 +-
 drivers/firmware/google/coreboot_table.h           |    6 -
 drivers/firmware/google/gsmi.c                     |  122 +-
 drivers/firmware/google/vpd.c                      |    2 +-
 drivers/fpga/altera-cvp.c                          |    8 +-
 drivers/fpga/altera-fpga2sdram.c                   |    8 +-
 drivers/fpga/altera-freeze-bridge.c                |   13 +-
 drivers/fpga/altera-hps2fpga.c                     |    7 +-
 drivers/fpga/altera-pr-ip-core.c                   |    9 +-
 drivers/fpga/altera-ps-spi.c                       |   11 +-
 drivers/fpga/dfl-afu-dma-region.c                  |    2 +-
 drivers/fpga/dfl-fme-br.c                          |   11 +-
 drivers/fpga/dfl-fme-mgr.c                         |   13 +-
 drivers/fpga/dfl-fme-region.c                      |    6 +-
 drivers/fpga/dfl.c                                 |    6 +-
 drivers/fpga/fpga-bridge.c                         |   68 +-
 drivers/fpga/fpga-mgr.c                            |   64 +-
 drivers/fpga/fpga-region.c                         |   65 +-
 drivers/fpga/ice40-spi.c                           |   10 +-
 drivers/fpga/machxo2-spi.c                         |   11 +-
 drivers/fpga/of-fpga-region.c                      |    6 +-
 drivers/fpga/socfpga-a10.c                         |    5 +-
 drivers/fpga/socfpga.c                             |   10 +-
 drivers/fpga/ts73xx-fpga.c                         |   11 +-
 drivers/fpga/xilinx-pr-decoupler.c                 |    4 +-
 drivers/fpga/xilinx-spi.c                          |   12 +-
 drivers/fpga/zynq-fpga.c                           |    5 +-
 drivers/hv/channel.c                               |  300 ++--
 drivers/hv/channel_mgmt.c                          |   54 +-
 drivers/hv/hv.c                                    |   15 +-
 drivers/hv/hv_balloon.c                            |    2 +-
 drivers/hv/hv_kvp.c                                |   14 +-
 drivers/hv/ring_buffer.c                           |    1 +
 drivers/hv/vmbus_drv.c                             |  118 +-
 drivers/hwtracing/coresight/coresight-catu.c       |    6 +
 .../coresight/coresight-dynamic-replicator.c       |   81 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |  183 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  132 +-
 drivers/hwtracing/coresight/coresight-etm-perf.h   |   26 +
 drivers/hwtracing/coresight/coresight-etm3x.c      |   58 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |   93 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |   28 +-
 drivers/hwtracing/coresight/coresight-priv.h       |    9 +-
 drivers/hwtracing/coresight/coresight-replicator.c |    4 +-
 drivers/hwtracing/coresight/coresight-stm.c        |    4 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  198 +--
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |  385 ++++-
 drivers/hwtracing/coresight/coresight-tmc.c        |    4 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |    4 +
 drivers/hwtracing/coresight/coresight-tpiu.c       |    6 +-
 drivers/hwtracing/coresight/coresight.c            |  184 +-
 drivers/hwtracing/coresight/of_coresight.c         |  262 ++-
 drivers/hwtracing/stm/Kconfig                      |   29 +
 drivers/hwtracing/stm/Makefile                     |    6 +
 drivers/hwtracing/stm/core.c                       |  292 +++-
 drivers/hwtracing/stm/heartbeat.c                  |    2 +-
 drivers/hwtracing/stm/p_basic.c                    |   48 +
 drivers/hwtracing/stm/p_sys-t.c                    |  382 +++++
 drivers/hwtracing/stm/policy.c                     |  147 +-
 drivers/hwtracing/stm/stm.h                        |   56 +-
 drivers/misc/ad525x_dpot-i2c.c                     |    2 +-
 drivers/misc/ad525x_dpot-spi.c                     |    2 +-
 drivers/misc/ad525x_dpot.c                         |    6 +-
 drivers/misc/apds990x.c                            |    1 -
 drivers/misc/bh1770glc.c                           |    3 -
 drivers/misc/cxl/flash.c                           |    4 +-
 drivers/misc/cxl/guest.c                           |    2 -
 drivers/misc/echo/echo.c                           |    2 +-
 drivers/misc/eeprom/Kconfig                        |   11 +
 drivers/misc/eeprom/Makefile                       |    1 +
 drivers/misc/eeprom/at25.c                         |   13 +-
 drivers/misc/eeprom/ee1004.c                       |  281 +++
 drivers/misc/eeprom/eeprom_93xx46.c                |   19 +-
 drivers/misc/genwqe/card_base.c                    |    1 -
 drivers/misc/genwqe/card_ddcb.c                    |    1 -
 drivers/misc/genwqe/card_utils.c                   |   15 +-
 drivers/misc/kgdbts.c                              |   16 +-
 drivers/misc/lkdtm/usercopy.c                      |    2 +-
 drivers/misc/mei/bus-fixup.c                       |    1 -
 drivers/misc/mei/main.c                            |    4 +-
 drivers/misc/mic/scif/scif_dma.c                   |    9 +-
 drivers/misc/mic/scif/scif_fence.c                 |    2 +-
 drivers/misc/sgi-gru/grukservices.c                |    4 +-
 drivers/misc/sgi-xp/xpc_channel.c                  |    6 +-
 drivers/misc/sgi-xp/xpc_partition.c                |    3 +-
 drivers/misc/sgi-xp/xpc_sn2.c                      |    2 +-
 drivers/misc/sgi-xp/xpc_uv.c                       |    2 +-
 drivers/misc/sram.c                                |    6 +-
 drivers/misc/vmw_balloon.c                         | 1802 ++++++++++++--------
 drivers/misc/vmw_vmci/vmci_driver.c                |    2 +-
 drivers/misc/vmw_vmci/vmci_host.c                  |    4 -
 drivers/misc/vmw_vmci/vmci_resource.c              |    3 +-
 drivers/nvmem/core.c                               |  533 ++++--
 drivers/nvmem/lpc18xx_eeprom.c                     |    7 +-
 drivers/nvmem/mxs-ocotp.c                          |    4 +-
 drivers/nvmem/sunxi_sid.c                          |   22 +-
 drivers/platform/goldfish/goldfish_pipe.c          |  399 +++--
 drivers/platform/goldfish/goldfish_pipe_qemu.h     |   98 ++
 drivers/slimbus/core.c                             |   37 +-
 drivers/slimbus/qcom-ngd-ctrl.c                    |   34 +-
 drivers/soundwire/bus.c                            |    6 +
 drivers/soundwire/bus.h                            |    4 +
 drivers/soundwire/intel.c                          |   68 +-
 drivers/soundwire/intel_init.c                     |    2 +-
 drivers/soundwire/stream.c                         |  488 ++++--
 drivers/thunderbolt/cap.c                          |    3 +-
 drivers/thunderbolt/ctl.c                          |   12 +-
 drivers/thunderbolt/ctl.h                          |    3 +-
 drivers/thunderbolt/dma_port.c                     |    5 +-
 drivers/thunderbolt/dma_port.h                     |    5 +-
 drivers/thunderbolt/domain.c                       |    7 +-
 drivers/thunderbolt/eeprom.c                       |    5 +-
 drivers/thunderbolt/icm.c                          |    5 +-
 drivers/thunderbolt/nhi.c                          |   33 +-
 drivers/thunderbolt/nhi.h                          |    3 +-
 drivers/thunderbolt/nhi_regs.h                     |    1 +
 drivers/thunderbolt/path.c                         |   26 +-
 drivers/thunderbolt/property.c                     |    5 +-
 drivers/thunderbolt/switch.c                       |   71 +-
 drivers/thunderbolt/tb.c                           |   10 +-
 drivers/thunderbolt/tb.h                           |    9 +-
 drivers/thunderbolt/tb_msgs.h                      |    5 +-
 drivers/thunderbolt/tb_regs.h                      |    3 +-
 drivers/thunderbolt/xdomain.c                      |    5 +-
 drivers/uio/uio.c                                  |   35 +-
 drivers/uio/uio_dmem_genirq.c                      |    3 +-
 drivers/uio/uio_fsl_elbc_gpcm.c                    |    3 +-
 drivers/uio/uio_hv_generic.c                       |  116 +-
 drivers/uio/uio_pdrv_genirq.c                      |    3 +-
 drivers/vme/vme.c                                  |    1 -
 drivers/w1/masters/omap_hdq.c                      |    2 +
 drivers/w1/slaves/w1_ds2438.c                      |   66 +-
 include/linux/coresight.h                          |   41 +-
 include/linux/fpga/fpga-bridge.h                   |    4 +
 include/linux/fpga/fpga-mgr.h                      |    4 +
 include/linux/fpga/fpga-region.h                   |    4 +
 include/linux/hyperv.h                             |   14 +-
 include/linux/nvmem-consumer.h                     |  100 +-
 include/linux/nvmem-provider.h                     |   50 +-
 include/linux/soundwire/sdw.h                      |   12 +-
 include/linux/string.h                             |    7 +
 include/linux/thunderbolt.h                        |    5 +-
 include/linux/uio_driver.h                         |    1 +
 include/uapi/linux/android/binder.h                |   10 +
 lib/Kconfig.debug                                  |    8 +
 lib/Makefile                                       |    3 +-
 lib/memcat_p.c                                     |   34 +
 lib/string.c                                       |    1 +
 lib/test_memcat_p.c                                |  115 ++
 samples/mei/mei-amt-version.c                      |    2 +-
 180 files changed, 6878 insertions(+), 3351 deletions(-)
 create mode 100644 Documentation/ABI/testing/configfs-stp-policy-p_sys-t
 create mode 100644 Documentation/ABI/testing/sysfs-bus-vmbus
 create mode 100644 Documentation/driver-api/fpga/fpga-programming.rst
 create mode 100644 Documentation/trace/sys-t.rst
 delete mode 100644 drivers/firmware/google/coreboot_table-acpi.c
 delete mode 100644 drivers/firmware/google/coreboot_table-of.c
 create mode 100644 drivers/hwtracing/stm/p_basic.c
 create mode 100644 drivers/hwtracing/stm/p_sys-t.c
 create mode 100644 drivers/misc/eeprom/ee1004.c
 create mode 100644 drivers/platform/goldfish/goldfish_pipe_qemu.h
 create mode 100644 lib/memcat_p.c
 create mode 100644 lib/test_memcat_p.c
