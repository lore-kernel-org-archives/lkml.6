Return-Path: <sdias@qualcomm.com>
X-Google-Smtp-Source: AB8JxZol7w0RSVKaZI9ZZEL6oNZRt1Ko5KxRhh1x7ysvw85dqdn7MT5cLE2XnXAvQdnVvrJBpAFJ
ARC-Seal: i=1; a=rsa-sha256; t=1524795824; cv=none;
        d=google.com; s=arc-20160816;
        b=Zjyfhs67bmMBEk451Y3E/DHOaKm0wV6vAVunKbQkMPZ0tKHYoZeXjj+rvevDHy7m2v
         4GqtpbEQ6JzA0Y66Y3nVxjOGq1DT6gFA1rri9fZqm9dZ8PBi9BJWzmqqiJ6jqCxTEYXR
         TxTVd0xUvTqW/MXxMsjJHccdgVlwbN8psrdv1xQ5dUaoyz+ftw+hMZbVjcjmZKsbst1f
         YQYI/2A9E1cduLcQFCRfBDD4bH8RGqLoduy8wNrcw7PphhAO8ayGUGAZcjI8unYN5AZz
         WGmt0abQGJuMkAqwCC+vdOyJu/HpBWe0vyRirUCy5yw9bnDpEWtJXVV1dUCU7kKuMf5A
         Zhlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=tQi4kCZrhsrAPy1DIj9CaRfV8Lb4LVNchziViqqARH4=;
        b=folxpkKTNSWad7BmdybDlwgDaw3PU0gKLgjtwLxDevGqIJ004bf9QVbqAQlp3mDe/T
         5s5IAjEZaNGEB242tBBdG5vPLVMlR7zOVHVUtqlqMYaDFrtBYzvsk7Re8m34w+hw7lXk
         I+7wUuND8OLXRr3fC2RLxuWNJlPcDOO76pjwy+LoJXC7BH8/qwoTkKL3CuozIKTxjk1S
         YwffErfp2Cy+ri1B60eRwHzK6XiHWIg5XpLuWUrBqj7/mZhxJ0yRG0nYPzAgbuhGREX1
         Q894HBfJT8sPJ9v0HcwmvE7vJyN6GDL6SLd9WP55AN5lhZAQQVd6L7I0ECzF95Ezbgic
         1ztA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sdias@qualcomm.com designates 129.46.98.28 as permitted sender) smtp.mailfrom=sdias@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sdias@qualcomm.com designates 129.46.98.28 as permitted sender) smtp.mailfrom=sdias@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,333,1520924400";
   d="scan'208";a="17167527"
X-IronPort-AV: E=McAfee;i="5900,7806,8875"; a="71622839"
From: Sujeev Dias <sdias@codeaurora.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Sujeev Dias <sdias@codeaurora.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Tony Truong <truong@codeaurora.org>
Subject: [PATCH v1 1/4] mhi_bus: core: Add support for MHI host interface
Date: Thu, 26 Apr 2018 19:23:28 -0700
Message-Id: <1524795811-21399-2-git-send-email-sdias@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598864306474861315?=
X-GMAIL-MSGID: =?utf-8?q?1598864306474861315?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

MHI Host Interface is a communication protocol to be used by the host
to control and communcate with modem over a high speed peripheral bus.
This module will allow host to communicate with external devices that
support MHI protocol.

Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
---
 Documentation/00-INDEX                        |    2 +
 Documentation/devicetree/bindings/bus/mhi.txt |  141 +++
 Documentation/mhi.txt                         |  235 ++++
 drivers/bus/Kconfig                           |   17 +
 drivers/bus/Makefile                          |    1 +
 drivers/bus/mhi/Makefile                      |    8 +
 drivers/bus/mhi/core/Makefile                 |    1 +
 drivers/bus/mhi/core/mhi_boot.c               |  593 ++++++++++
 drivers/bus/mhi/core/mhi_dtr.c                |  177 +++
 drivers/bus/mhi/core/mhi_init.c               | 1290 +++++++++++++++++++++
 drivers/bus/mhi/core/mhi_internal.h           |  732 ++++++++++++
 drivers/bus/mhi/core/mhi_main.c               | 1476 +++++++++++++++++++++++++
 drivers/bus/mhi/core/mhi_pm.c                 | 1177 ++++++++++++++++++++
 include/linux/mhi.h                           |  694 ++++++++++++
 include/linux/mod_devicetable.h               |   11 +
 15 files changed, 6555 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/mhi.txt
 create mode 100644 Documentation/mhi.txt
 create mode 100644 drivers/bus/mhi/Makefile
 create mode 100644 drivers/bus/mhi/core/Makefile
 create mode 100644 drivers/bus/mhi/core/mhi_boot.c
 create mode 100644 drivers/bus/mhi/core/mhi_dtr.c
 create mode 100644 drivers/bus/mhi/core/mhi_init.c
 create mode 100644 drivers/bus/mhi/core/mhi_internal.h
 create mode 100644 drivers/bus/mhi/core/mhi_main.c
 create mode 100644 drivers/bus/mhi/core/mhi_pm.c
 create mode 100644 include/linux/mhi.h

diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index 708dc4c..44e2c6b 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -270,6 +270,8 @@ memory-hotplug.txt
 	- Hotpluggable memory support, how to use and current status.
 men-chameleon-bus.txt
 	- info on MEN chameleon bus.
+mhi.txt
+	- Modem Host Interface
 mic/
 	- Intel Many Integrated Core (MIC) architecture device driver.
 mips/
diff --git a/Documentation/devicetree/bindings/bus/mhi.txt b/Documentation/devicetree/bindings/bus/mhi.txt
new file mode 100644
index 0000000..ea1b620
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/mhi.txt
@@ -0,0 +1,141 @@
+MHI Host Interface
+
+MHI used by the host to control and communicate with modem over
+high speed peripheral bus.
+
+==============
+Node Structure
+==============
+
+Main node properties:
+
+- mhi,max-channels
+  Usage: required
+  Value type: <u32>
+  Definition: Maximum number of channels supported by this controller
+
+- mhi,chan-cfg
+  Usage: required
+  Value type: Array of <u32>
+  Definition: Array of tuples describe channel configuration.
+	1st element: Physical channel number
+	2nd element: Transfer ring length in elements
+	3rd element: Event ring associated with this channel
+	4th element: Channel direction as defined by enum dma_data_direction
+		1 = UL data transfer
+		2 = DL data transfer
+	5th element: Channel doorbell mode configuration as defined by
+	enum MHI_BRSTMODE
+		2 = burst mode disabled
+		3 = burst mode enabled
+	6th element: mhi doorbell configuration, valid only when burst mode
+	enabled.
+		0 = Use default (device specific) polling configuration
+		For UL channels, value specifies the timer to poll MHI context
+		in milliseconds.
+		For DL channels, the threshold to poll the MHI context
+		in multiple of eight ring element.
+	7th element: Channel execution enviornment as defined by enum MHI_EE
+		1 = Bootloader stage
+		2 = AMSS mode
+	8th element: data transfer type accepted as defined by enum
+	MHI_XFER_TYPE
+		0 = accept cpu address for buffer
+		1 = accept skb
+		2 = accept scatterlist
+		3 = offload channel, does not accept any transfer type
+	9th element: Bitwise configuration settings for the channel
+		Bit mask:
+		BIT(0) : LPM notify, this channel master requre lpm enter/exit
+		notifications.
+		BIT(1) : Offload channel, MHI host only involved in setting up
+		the data pipe. Not involved in active data transfer.
+		BIT(2) : Must switch to doorbell mode whenever MHI M0 state
+		transition happens.
+		BIT(3) : MHI bus driver pre-allocate buffer for this channel.
+		If set, clients not allowed to queue buffers. Valid only for DL
+		direction.
+
+- mhi,chan-names
+  Usage: required
+  Value type: Array of <string>
+  Definition: Channel names configured in mhi,chan-cfg.
+
+- mhi,ev-cfg
+  Usage: required
+  Value type: Array of <u32>
+  Definition: Array of tuples describe event configuration.
+	1st element: Event ring length in elements
+	2nd element: Interrupt moderation time in ms
+	3rd element: MSI associated with this event ring
+	4th element: Dedicated channel number, if it's a dedicated event ring
+	5th element: Event ring priority, set to 1 for now
+	6th element: Event doorbell mode configuration as defined by
+	enum MHI_BRSTMODE
+		2 = burst mode disabled
+		3 = burst mode enabled
+	7th element: Bitwise configuration settings for the channel
+		Bit mask:
+		BIT(0) : Event ring associated with hardware channels
+		BIT(1) : Client manages the event ring (use by napi_poll)
+		BIT(2) : Event ring associated with offload channel
+		BIT(3) : Event ring dedicated to control events only
+
+- mhi,timeout
+  Usage: optional
+  Value type: <u32>
+  Definition: Maximum timeout in ms wait for state and cmd completion
+
+- mhi,fw-name
+  Usage: optional
+  Value type: <string>
+  Definition: Firmware image name to upload
+
+- mhi,edl-name
+  Usage: optional
+  Value type: <string>
+  Definition: Firmware image name for emergency download
+
+- mhi,fbc-download
+  Usage: optional
+  Value type: <bool>
+  Definition: If set true, image specified by fw-name is for full image
+
+- mhi,sbl-size
+  Usage: optional
+  Value type: <u32>
+  Definition: Size of SBL image in bytes
+
+- mhi,seg-len
+  Usage: optional
+  Value type: <u32>
+  Definition: Size of each segment to allocate for BHIe vector table
+
+Children node properties:
+
+MHI drivers that require DT can add driver specific information as a child node.
+
+- mhi,chan
+  Usage: Required
+  Value type: <string>
+  Definition: Channel name
+
+========
+Example:
+========
+mhi_controller {
+	mhi,max-channels = <105>;
+	mhi,chan-cfg = <0 64 2 1 2 1 2 0 0>, <1 64 2 2 2 1 2 0 0>,
+		       <2 64 1 1 2 1 1 0 0>, <3 64 1 2 2 1 1 0 0>;
+	mhi,chan-names = "LOOPBACK", "LOOPBACK",
+			 "SAHARA", "SAHARA";
+	mhi,ev-cfg = <64 1 1 0 1 2 8>
+		     <64 1 2 0 1 2 0>;
+	mhi,fw-name = "sbl1.mbn";
+	mhi,timeout = <500>;
+
+	children_node {
+		mhi,chan = "LOOPBACK"
+		<driver specific properties>
+	};
+};
diff --git a/Documentation/mhi.txt b/Documentation/mhi.txt
new file mode 100644
index 0000000..1c501f1
--- /dev/null
+++ b/Documentation/mhi.txt
@@ -0,0 +1,235 @@
+Overview of Linux kernel MHI support
+====================================
+
+Modem-Host Interface (MHI)
+=========================
+MHI used by the host to control and communicate with modem over high speed
+peripheral bus. Even though MHI can be easily adapt to any peripheral buses,
+primarily used with PCIe based devices. The host has one or more PCIe root
+ports connected to modem device. The host has limited access to device memory
+space, including register configuration and control the device operation.
+Data transfers are invoked from the device.
+
+All data structures used by MHI are in the host system memory. Using PCIe
+interface, the device accesses those data structures. MHI data structures and
+data buffers in the host system memory regions are mapped for device.
+
+Memory spaces
+-------------
+PCIe Configurations : Used for enumeration and resource management, such as
+interrupt and base addresses.  This is done by mhi control driver.
+
+MMIO
+----
+MHI MMIO : Memory mapped IO consists of set of registers in the device hardware,
+which are mapped to the host memory space through PCIe base address register
+(BAR)
+
+MHI control registers : Access to MHI configurations registers
+(struct mhi_controller.regs).
+
+MHI BHI register: Boot host interface registers (struct mhi_controller.bhi) used
+for firmware download before MHI initialization.
+
+Channel db array : Doorbell registers (struct mhi_chan.tre_ring.db_addr) used by
+host to notify device there is new work to do.
+
+Event db array : Associated with event context array
+(struct mhi_event.ring.db_addr), host uses to notify device free events are
+available.
+
+Data structures
+---------------
+Host memory : Directly accessed by the host to manage the MHI data structures
+and buffers. The device accesses the host memory over the PCIe interface.
+
+Channel context array : All channel configurations are organized in channel
+context data array.
+
+struct __packed mhi_chan_ctxt;
+struct mhi_ctxt.chan_ctxt;
+
+Transfer rings : Used by host to schedule work items for a channel and organized
+as a circular queue of transfer descriptors (TD).
+
+struct __packed mhi_tre;
+struct mhi_chan.tre_ring;
+
+Event context array : All event configurations are organized in event context
+data array.
+
+struct mhi_ctxt.er_ctxt;
+struct __packed mhi_event_ctxt;
+
+Event rings: Used by device to send completion and state transition messages to
+host
+
+struct mhi_event.ring;
+struct __packed mhi_tre;
+
+Command context array: All command configurations are organized in command
+context data array.
+
+struct __packed mhi_cmd_ctxt;
+struct mhi_ctxt.cmd_ctxt;
+
+Command rings: Used by host to send MHI commands to device
+
+struct __packed mhi_tre;
+struct mhi_cmd.ring;
+
+Transfer rings
+--------------
+MHI channels are logical, unidirectional data pipes between host and device.
+Each channel associated with a single transfer ring.  The data direction can be
+either inbound (device to host) or outbound (host to device).  Transfer
+descriptors are managed by using transfer rings, which are defined for each
+channel between device and host and resides in the host memory.
+
+Transfer ring Pointer:	  	Transfer Ring Array
+[Read Pointer (RP)] ----------->[Ring Element] } TD
+[Write Pointer (WP)]-		[Ring Element]
+                     -		[Ring Element]
+		      --------->[Ring Element]
+				[Ring Element]
+
+1. Host allocate memory for transfer ring
+2. Host sets base, read pointer, write pointer in corresponding channel context
+3. Ring is considered empty when RP == WP
+4. Ring is considered full when WP + 1 == RP
+4. RP indicates the next element to be serviced by device
+4. When host new buffer to send, host update the Ring element with buffer
+   information
+5. Host increment the WP to next element
+6. Ring the associated channel DB.
+
+Event rings
+-----------
+Events from the device to host are organized in event rings and defined in event
+descriptors.  Event rings are array of EDs that resides in the host memory.
+
+Transfer ring Pointer:	  	Event Ring Array
+[Read Pointer (RP)] ----------->[Ring Element] } ED
+[Write Pointer (WP)]-		[Ring Element]
+                     -		[Ring Element]
+		      --------->[Ring Element]
+				[Ring Element]
+
+1. Host allocate memory for event ring
+2. Host sets base, read pointer, write pointer in corresponding channel context
+3. Both host and device has local copy of RP, WP
+3. Ring is considered empty (no events to service) when WP + 1 == RP
+4. Ring is full of events when RP == WP
+4. RP - 1 = last event device programmed
+4. When there is a new event device need to send, device update ED pointed by RP
+5. Device increment RP to next element
+6. Device trigger and interrupt
+
+Example Operation for data transfer:
+
+1. Host prepare TD with buffer information
+2. Host increment Chan[id].ctxt.WP
+3. Host ring channel DB register
+4. Device wakes up process the TD
+5. Device generate a completion event for that TD by updating ED
+6. Device increment Event[id].ctxt.RP
+7. Device trigger MSI to wake host
+8. Host wakes up and check event ring for completion event
+9. Host update the Event[i].ctxt.WP to indicate processed of completion event.
+
+MHI States
+----------
+
+enum MHI_STATE {
+MHI_STATE_RESET : MHI is in reset state, POR state. Host is not allowed to
+		  access device MMIO register space.
+MHI_STATE_READY : Device is ready for initialization. Host can start MHI
+		  initialization by programming MMIO
+MHI_STATE_M0 : MHI is in fully active state, data transfer is active
+MHI_STATE_M1 : Device in a suspended state
+MHI_STATE_M2 : MHI in low power mode, device may enter lower power mode.
+MHI_STATE_M3 : Both host and device in suspended state.  PCIe link is not
+	       accessible to device.
+
+MHI Initialization
+------------------
+
+1. After system boots, the device is enumerated over PCIe interface
+2. Host allocate MHI context for event, channel and command arrays
+3. Initialize context array, and prepare interrupts
+3. Host waits until device enter READY state
+4. Program MHI MMIO registers and set device into MHI_M0 state
+5. Wait for device to enter M0 state
+
+Linux Software Architecture
+===========================
+
+MHI Controller
+--------------
+MHI controller is also the MHI bus master. In charge of managing the physical
+link between host and device.  Not involved in actual data transfer.  At least
+for PCIe based buses, for other type of bus, we can expand to add support.
+
+Roles:
+1. Turn on PCIe bus and configure the link
+2. Configure MSI, SMMU, and IOMEM
+3. Allocate struct mhi_controller and register with MHI bus framework
+2. Initiate power on and shutdown sequence
+3. Initiate suspend and resume
+
+Usage
+-----
+
+1. Allocate control data structure by calling mhi_alloc_controller()
+2. Initialize mhi_controller with all the known information such as:
+   - Device Topology
+   - IOMMU window
+   - IOMEM mapping
+   - Device to use for memory allocation, and of_node with DT configuration
+   - Configure asynchronous callback functions
+3. Register MHI controller with MHI bus framework by calling
+   of_register_mhi_controller()
+
+After successfully registering controller can initiate any of these power modes:
+
+1. Power up sequence
+   - mhi_prepare_for_power_up()
+   - mhi_async_power_up()
+   - mhi_sync_power_up()
+2. Power down sequence
+   - mhi_power_down()
+   - mhi_unprepare_after_power_down()
+3. Initiate suspend
+   - mhi_pm_suspend()
+4. Initiate resume
+   - mhi_pm_resume()
+
+MHI Devices
+-----------
+Logical device that bind to maximum of two physical MHI channels. Once MHI is in
+powered on state, each supported channel by controller will be allocated as a
+mhi_device.
+
+Each supported device would be enumerated under
+/sys/bus/mhi/devices/
+
+struct mhi_device;
+
+MHI Driver
+----------
+Each MHI driver can bind to one or more MHI devices. MHI host driver will bind
+mhi_device to mhi_driver.
+
+All registered drivers are visible under
+/sys/bus/mhi/drivers/
+
+struct mhi_driver;
+
+Usage
+-----
+
+1. Register driver using mhi_driver_register
+2. Before sending data, prepare device for transfer by calling
+   mhi_prepare_for_transfer
+3. Initiate data transfer by calling mhi_queue_transfer
+4. After finish, call mhi_unprepare_from_transfer to end data transfer
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index d1c0b60..e15d56d 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -171,6 +171,23 @@ config DA8XX_MSTPRI
 	  configuration. Allows to adjust the priorities of all master
 	  peripherals.
 
+config MHI_BUS
+	tristate "Modem Host Interface"
+	help
+	  MHI Host Interface is a communication protocol to be used by the host
+	  to control and communcate with modem over a high speed peripheral bus.
+	  Enabling this module will allow host to communicate with external
+	  devices that support MHI protocol.
+
+config MHI_DEBUG
+	 bool "MHI debug support"
+	 depends on MHI_BUS
+	 help
+	   Say yes here to enable debugging support in the MHI transport
+	   and individual MHI client drivers. This option will impact
+	   throughput as individual MHI packets and state transitions
+	   will be logged.
+
 source "drivers/bus/fsl-mc/Kconfig"
 
 endmenu
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index b8f036c..8fc0b3b 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_UNIPHIER_SYSTEM_BUS)	+= uniphier-system-bus.o
 obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
 
 obj-$(CONFIG_DA8XX_MSTPRI)	+= da8xx-mstpri.o
+obj-$(CONFIG_MHI_BUS) += mhi/
diff --git a/drivers/bus/mhi/Makefile b/drivers/bus/mhi/Makefile
new file mode 100644
index 0000000..9f8f3ac
--- /dev/null
+++ b/drivers/bus/mhi/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for the MHI stack
+#
+
+# core layer
+obj-y += core/
+#obj-y += controllers/
+#obj-y += devices/
diff --git a/drivers/bus/mhi/core/Makefile b/drivers/bus/mhi/core/Makefile
new file mode 100644
index 0000000..a743fbf
--- /dev/null
+++ b/drivers/bus/mhi/core/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_MHI_BUS) +=mhi_init.o mhi_main.o mhi_pm.o mhi_boot.o mhi_dtr.o
diff --git a/drivers/bus/mhi/core/mhi_boot.c b/drivers/bus/mhi/core/mhi_boot.c
new file mode 100644
index 0000000..47276a3
--- /dev/null
+++ b/drivers/bus/mhi/core/mhi_boot.c
@@ -0,0 +1,593 @@
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/firmware.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/mhi.h>
+#include "mhi_internal.h"
+
+
+/* setup rddm vector table for rddm transfer */
+static void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
+			     struct image_info *img_info)
+{
+	struct mhi_buf *mhi_buf = img_info->mhi_buf;
+	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
+	int i = 0;
+
+	for (i = 0; i < img_info->entries - 1; i++, mhi_buf++, bhi_vec++) {
+		MHI_VERB("Setting vector:%pad size:%zu\n",
+			 &mhi_buf->dma_addr, mhi_buf->len);
+		bhi_vec->dma_addr = mhi_buf->dma_addr;
+		bhi_vec->size = mhi_buf->len;
+	}
+}
+
+/* collect rddm during kernel panic */
+static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
+{
+	int ret;
+	struct mhi_buf *mhi_buf;
+	u32 sequence_id;
+	u32 rx_status;
+	enum MHI_EE ee;
+	struct image_info *rddm_image = mhi_cntrl->rddm_image;
+	const u32 delayus = 100;
+	u32 retry = (mhi_cntrl->timeout_ms * 1000) / delayus;
+	void __iomem *base = mhi_cntrl->bhi;
+
+	MHI_LOG("Entered with pm_state:%s dev_state:%s ee:%s\n",
+		to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+		TO_MHI_EXEC_STR(mhi_cntrl->ee));
+
+	/*
+	 * This should only be executing during a kernel panic, we expect all
+	 * other cores to shutdown while we're collecting rddm buffer. After
+	 * returning from this function, we expect device to reset.
+	 *
+	 * Normaly, we would read/write pm_state only after grabbing
+	 * pm_lock, since we're in a panic, skipping it.
+	 */
+
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
+		return -EIO;
+
+	/*
+	 * There is no gurantee this state change would take effect since
+	 * we're setting it w/o grabbing pmlock, it's best effort
+	 */
+	mhi_cntrl->pm_state = MHI_PM_LD_ERR_FATAL_DETECT;
+	/* update should take the effect immediately */
+	smp_wmb();
+
+	/* setup the RX vector table */
+	mhi_rddm_prepare(mhi_cntrl, rddm_image);
+	mhi_buf = &rddm_image->mhi_buf[rddm_image->entries - 1];
+
+	MHI_LOG("Starting BHIe programming for RDDM\n");
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECADDR_HIGH_OFFS,
+		      upper_32_bits(mhi_buf->dma_addr));
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECADDR_LOW_OFFS,
+		      lower_32_bits(mhi_buf->dma_addr));
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECSIZE_OFFS, mhi_buf->len);
+	sequence_id = prandom_u32() & BHIE_RXVECSTATUS_SEQNUM_BMSK;
+
+	if (unlikely(!sequence_id))
+		sequence_id = 1;
+
+
+	mhi_write_reg_field(mhi_cntrl, base, BHIE_RXVECDB_OFFS,
+			    BHIE_RXVECDB_SEQNUM_BMSK, BHIE_RXVECDB_SEQNUM_SHFT,
+			    sequence_id);
+
+	MHI_LOG("Trigger device into RDDM mode\n");
+	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_SYS_ERR);
+
+	MHI_LOG("Waiting for image download completion\n");
+	while (retry--) {
+		ret = mhi_read_reg_field(mhi_cntrl, base, BHIE_RXVECSTATUS_OFFS,
+					 BHIE_RXVECSTATUS_STATUS_BMSK,
+					 BHIE_RXVECSTATUS_STATUS_SHFT,
+					 &rx_status);
+		if (ret)
+			return -EIO;
+
+		if (rx_status == BHIE_RXVECSTATUS_STATUS_XFER_COMPL) {
+			MHI_LOG("RDDM successfully collected\n");
+			return 0;
+		}
+
+		udelay(delayus);
+	}
+
+	ee = mhi_get_exec_env(mhi_cntrl);
+	ret = mhi_read_reg(mhi_cntrl, base, BHIE_RXVECSTATUS_OFFS, &rx_status);
+
+	MHI_ERR("Did not complete RDDM transfer\n");
+	MHI_ERR("Current EE:%s\n", TO_MHI_EXEC_STR(ee));
+	MHI_ERR("RXVEC_STATUS:0x%x, ret:%d\n", rx_status, ret);
+
+	return -EIO;
+}
+
+/* download ramdump image from device */
+int mhi_download_rddm_img(struct mhi_controller *mhi_cntrl, bool in_panic)
+{
+	void __iomem *base = mhi_cntrl->bhi;
+	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
+	struct image_info *rddm_image = mhi_cntrl->rddm_image;
+	struct mhi_buf *mhi_buf;
+	int ret;
+	u32 rx_status;
+	u32 sequence_id;
+
+	if (!rddm_image)
+		return -ENOMEM;
+
+	if (in_panic)
+		return __mhi_download_rddm_in_panic(mhi_cntrl);
+
+	MHI_LOG("Waiting for device to enter RDDM state from EE:%s\n",
+		TO_MHI_EXEC_STR(mhi_cntrl->ee));
+
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->ee == MHI_EE_RDDM ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		MHI_ERR("MHI is not in valid state, pm_state:%s ee:%s\n",
+			to_mhi_pm_state_str(mhi_cntrl->pm_state),
+			TO_MHI_EXEC_STR(mhi_cntrl->ee));
+		return -EIO;
+	}
+
+	mhi_rddm_prepare(mhi_cntrl, mhi_cntrl->rddm_image);
+
+	/* vector table is the last entry */
+	mhi_buf = &rddm_image->mhi_buf[rddm_image->entries - 1];
+
+	read_lock_bh(pm_lock);
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+		read_unlock_bh(pm_lock);
+		return -EIO;
+	}
+
+	MHI_LOG("Starting BHIe Programming for RDDM\n");
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECADDR_HIGH_OFFS,
+		      upper_32_bits(mhi_buf->dma_addr));
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECADDR_LOW_OFFS,
+		      lower_32_bits(mhi_buf->dma_addr));
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECSIZE_OFFS, mhi_buf->len);
+
+	sequence_id = prandom_u32() & BHIE_RXVECSTATUS_SEQNUM_BMSK;
+	mhi_write_reg_field(mhi_cntrl, base, BHIE_RXVECDB_OFFS,
+			    BHIE_RXVECDB_SEQNUM_BMSK, BHIE_RXVECDB_SEQNUM_SHFT,
+			    sequence_id);
+	read_unlock_bh(pm_lock);
+
+	MHI_LOG("Upper:0x%x Lower:0x%x len:0x%lx sequence:%u\n",
+		upper_32_bits(mhi_buf->dma_addr),
+		lower_32_bits(mhi_buf->dma_addr),
+		mhi_buf->len, sequence_id);
+	MHI_LOG("Waiting for image download completion\n");
+
+	/* waiting for image download completion */
+	wait_event_timeout(mhi_cntrl->state_event,
+			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
+			   mhi_read_reg_field(mhi_cntrl, base,
+					      BHIE_RXVECSTATUS_OFFS,
+					      BHIE_RXVECSTATUS_STATUS_BMSK,
+					      BHIE_RXVECSTATUS_STATUS_SHFT,
+					      &rx_status) || rx_status,
+			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
+		return -EIO;
+
+	return (rx_status == BHIE_RXVECSTATUS_STATUS_XFER_COMPL) ? 0 : -EIO;
+}
+EXPORT_SYMBOL(mhi_download_rddm_img);
+
+static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
+			    const struct mhi_buf *mhi_buf)
+{
+	void __iomem *base = mhi_cntrl->bhi;
+	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
+	u32 tx_status;
+
+	read_lock_bh(pm_lock);
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+		read_unlock_bh(pm_lock);
+		return -EIO;
+	}
+
+	MHI_LOG("Starting BHIe Programming\n");
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECADDR_HIGH_OFFS,
+		      upper_32_bits(mhi_buf->dma_addr));
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECADDR_LOW_OFFS,
+		      lower_32_bits(mhi_buf->dma_addr));
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECSIZE_OFFS, mhi_buf->len);
+
+	mhi_cntrl->sequence_id = prandom_u32() & BHIE_TXVECSTATUS_SEQNUM_BMSK;
+	mhi_write_reg_field(mhi_cntrl, base, BHIE_TXVECDB_OFFS,
+			    BHIE_TXVECDB_SEQNUM_BMSK, BHIE_TXVECDB_SEQNUM_SHFT,
+			    mhi_cntrl->sequence_id);
+	read_unlock_bh(pm_lock);
+
+	MHI_LOG("Upper:0x%x Lower:0x%x len:0x%lx sequence:%u\n",
+		upper_32_bits(mhi_buf->dma_addr),
+		lower_32_bits(mhi_buf->dma_addr),
+		mhi_buf->len, mhi_cntrl->sequence_id);
+	MHI_LOG("Waiting for image transfer completion\n");
+
+	/* waiting for image download completion */
+	wait_event_timeout(mhi_cntrl->state_event,
+			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
+			   mhi_read_reg_field(mhi_cntrl, base,
+					      BHIE_TXVECSTATUS_OFFS,
+					      BHIE_TXVECSTATUS_STATUS_BMSK,
+					      BHIE_TXVECSTATUS_STATUS_SHFT,
+					      &tx_status) || tx_status,
+			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
+		return -EIO;
+
+	return (tx_status == BHIE_TXVECSTATUS_STATUS_XFER_COMPL) ? 0 : -EIO;
+}
+
+static int mhi_fw_load_sbl(struct mhi_controller *mhi_cntrl,
+			   void *buf,
+			   size_t size)
+{
+	u32 tx_status, val;
+	int i, ret;
+	void __iomem *base = mhi_cntrl->bhi;
+	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
+	dma_addr_t phys = dma_map_single(mhi_cntrl->dev, buf, size,
+					 DMA_TO_DEVICE);
+	struct {
+		char *name;
+		u32 offset;
+	} error_reg[] = {
+		{ "ERROR_CODE", BHI_ERRCODE },
+		{ "ERROR_DBG1", BHI_ERRDBG1 },
+		{ "ERROR_DBG2", BHI_ERRDBG2 },
+		{ "ERROR_DBG3", BHI_ERRDBG3 },
+		{ NULL },
+	};
+
+	if (dma_mapping_error(mhi_cntrl->dev, phys))
+		return -ENOMEM;
+
+	MHI_LOG("Starting BHI programming\n");
+
+	/* program start sbl download via  bhi protocol */
+	read_lock_bh(pm_lock);
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+		read_unlock_bh(pm_lock);
+		goto invalid_pm_state;
+	}
+
+	mhi_write_reg(mhi_cntrl, base, BHI_STATUS, 0);
+	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_HIGH, upper_32_bits(phys));
+	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_LOW, lower_32_bits(phys));
+	mhi_write_reg(mhi_cntrl, base, BHI_IMGSIZE, size);
+	mhi_cntrl->session_id = prandom_u32() & BHI_TXDB_SEQNUM_BMSK;
+	mhi_write_reg(mhi_cntrl, base, BHI_IMGTXDB, mhi_cntrl->session_id);
+	read_unlock_bh(pm_lock);
+
+	MHI_LOG("Waiting for image transfer completion\n");
+
+	/* waiting for image download completion */
+	wait_event_timeout(mhi_cntrl->state_event,
+			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
+			   mhi_read_reg_field(mhi_cntrl, base, BHI_STATUS,
+					      BHI_STATUS_MASK, BHI_STATUS_SHIFT,
+					      &tx_status) || tx_status,
+			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
+		goto invalid_pm_state;
+
+	if (tx_status == BHI_STATUS_ERROR) {
+		MHI_ERR("Image transfer failed\n");
+		read_lock_bh(pm_lock);
+		if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+			for (i = 0; error_reg[i].name; i++) {
+				ret = mhi_read_reg(mhi_cntrl, base,
+						   error_reg[i].offset, &val);
+				if (ret)
+					break;
+				MHI_ERR("reg:%s value:0x%x\n",
+					error_reg[i].name, val);
+			}
+		}
+		read_unlock_bh(pm_lock);
+		goto invalid_pm_state;
+	}
+
+	dma_unmap_single(mhi_cntrl->dev, phys, size, DMA_TO_DEVICE);
+
+	return (tx_status == BHI_STATUS_SUCCESS) ? 0 : -ETIMEDOUT;
+
+invalid_pm_state:
+	dma_unmap_single(mhi_cntrl->dev, phys, size, DMA_TO_DEVICE);
+
+	return -EIO;
+}
+
+void mhi_free_bhie_table(struct mhi_controller *mhi_cntrl,
+			 struct image_info *image_info)
+{
+	int i;
+	struct mhi_buf *mhi_buf = image_info->mhi_buf;
+
+	for (i = 0; i < image_info->entries; i++, mhi_buf++)
+		mhi_free_coherent(mhi_cntrl, mhi_buf->len, mhi_buf->buf,
+				  mhi_buf->dma_addr);
+
+	kfree(image_info->mhi_buf);
+	kfree(image_info);
+}
+
+int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
+			 struct image_info **image_info,
+			 size_t alloc_size)
+{
+	size_t seg_size = mhi_cntrl->seg_len;
+	/* requier additional entry for vec table */
+	int segments = DIV_ROUND_UP(alloc_size, seg_size) + 1;
+	int i;
+	struct image_info *img_info;
+	struct mhi_buf *mhi_buf;
+
+	MHI_LOG("Allocating bytes:%zu seg_size:%zu total_seg:%u\n",
+		alloc_size, seg_size, segments);
+
+	img_info = kzalloc(sizeof(*img_info), GFP_KERNEL);
+	if (!img_info)
+		return -ENOMEM;
+
+	/* allocate memory for entries */
+	img_info->mhi_buf = kcalloc(segments, sizeof(*img_info->mhi_buf),
+				    GFP_KERNEL);
+	if (!img_info->mhi_buf)
+		goto error_alloc_mhi_buf;
+
+	/* allocate and populate vector table */
+	mhi_buf = img_info->mhi_buf;
+	for (i = 0; i < segments; i++, mhi_buf++) {
+		size_t vec_size = seg_size;
+
+		/* last entry is for vector table */
+		if (i == segments - 1)
+			vec_size = sizeof(struct __packed bhi_vec_entry) * i;
+
+		mhi_buf->len = vec_size;
+		mhi_buf->buf = mhi_alloc_coherent(mhi_cntrl, vec_size,
+					&mhi_buf->dma_addr, GFP_KERNEL);
+		if (!mhi_buf->buf)
+			goto error_alloc_segment;
+
+		MHI_LOG("Entry:%d Address:0x%llx size:%lu\n", i,
+			mhi_buf->dma_addr, mhi_buf->len);
+	}
+
+	img_info->bhi_vec = img_info->mhi_buf[segments - 1].buf;
+	img_info->entries = segments;
+	*image_info = img_info;
+
+	MHI_LOG("Successfully allocated bhi vec table\n");
+
+	return 0;
+
+error_alloc_segment:
+	for (--i, --mhi_buf; i >= 0; i--, mhi_buf--)
+		mhi_free_coherent(mhi_cntrl, mhi_buf->len, mhi_buf->buf,
+				  mhi_buf->dma_addr);
+
+error_alloc_mhi_buf:
+	kfree(img_info);
+
+	return -ENOMEM;
+}
+
+static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
+			      const struct firmware *firmware,
+			      struct image_info *img_info)
+{
+	size_t remainder = firmware->size;
+	size_t to_cpy;
+	const u8 *buf = firmware->data;
+	int i = 0;
+	struct mhi_buf *mhi_buf = img_info->mhi_buf;
+	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
+
+	while (remainder) {
+		MHI_ASSERT(i >= img_info->entries, "malformed vector table");
+
+		to_cpy = min(remainder, mhi_buf->len);
+		memcpy(mhi_buf->buf, buf, to_cpy);
+		bhi_vec->dma_addr = mhi_buf->dma_addr;
+		bhi_vec->size = to_cpy;
+
+		MHI_VERB("Setting Vector:0x%llx size: %llu\n",
+			 bhi_vec->dma_addr, bhi_vec->size);
+		buf += to_cpy;
+		remainder -= to_cpy;
+		i++;
+		bhi_vec++;
+		mhi_buf++;
+	}
+}
+
+void mhi_fw_load_worker(struct work_struct *work)
+{
+	int ret;
+	struct mhi_controller *mhi_cntrl;
+	const char *fw_name;
+	const struct firmware *firmware;
+	struct image_info *image_info;
+	void *buf;
+	size_t size;
+
+	mhi_cntrl = container_of(work, struct mhi_controller, fw_worker);
+
+	MHI_LOG("Waiting for device to enter PBL from EE:%s\n",
+		TO_MHI_EXEC_STR(mhi_cntrl->ee));
+
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 MHI_IN_PBL(mhi_cntrl->ee) ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		MHI_ERR("MHI is not in valid state\n");
+		return;
+	}
+
+	MHI_LOG("Device current EE:%s\n", TO_MHI_EXEC_STR(mhi_cntrl->ee));
+
+	/* if device in pthru, we do not have to load firmware */
+	if (mhi_cntrl->ee == MHI_EE_PTHRU)
+		return;
+
+	fw_name = (mhi_cntrl->ee == MHI_EE_EDL) ?
+		mhi_cntrl->edl_image : mhi_cntrl->fw_image;
+
+	if (!fw_name || (mhi_cntrl->fbc_download && (!mhi_cntrl->sbl_size ||
+						     !mhi_cntrl->seg_len))) {
+		MHI_ERR("No firmware image defined or !sbl_size || !seg_len\n");
+		return;
+	}
+
+	ret = request_firmware(&firmware, fw_name, mhi_cntrl->dev);
+	if (ret) {
+		MHI_ERR("Error loading firmware, ret:%d\n", ret);
+		return;
+	}
+
+	size = (mhi_cntrl->fbc_download) ? mhi_cntrl->sbl_size : firmware->size;
+
+	/* the sbl size provided is maximum size, not necessarily image size */
+	if (size > firmware->size)
+		size = firmware->size;
+
+	buf = kmalloc(size, GFP_KERNEL);
+	if (!buf) {
+		MHI_ERR("Could not allocate memory for image\n");
+		release_firmware(firmware);
+		return;
+	}
+
+	/* load sbl image */
+	memcpy(buf, firmware->data, size);
+	ret = mhi_fw_load_sbl(mhi_cntrl, buf, size);
+	kfree(buf);
+
+	if (!mhi_cntrl->fbc_download || ret || mhi_cntrl->ee == MHI_EE_EDL)
+		release_firmware(firmware);
+
+	/* error or in edl, we're done */
+	if (ret || mhi_cntrl->ee == MHI_EE_EDL)
+		return;
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	mhi_cntrl->dev_state = MHI_STATE_RESET;
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	/*
+	 * if we're doing fbc, populate vector tables while
+	 * device transitioning into MHI READY state
+	 */
+	if (mhi_cntrl->fbc_download) {
+		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image,
+					   firmware->size);
+		if (ret) {
+			MHI_ERR("Error alloc size of %zu\n", firmware->size);
+			goto error_alloc_fw_table;
+		}
+
+		MHI_LOG("Copying firmware image into vector table\n");
+
+		/* load the firmware into BHIE vec table */
+		mhi_firmware_copy(mhi_cntrl, firmware, mhi_cntrl->fbc_image);
+	}
+
+	/* transitioning into MHI RESET->READY state */
+	ret = mhi_ready_state_transition(mhi_cntrl);
+
+	MHI_LOG("To Reset->Ready PM_STATE:%s MHI_STATE:%s EE:%s, ret:%d\n",
+		to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+		TO_MHI_EXEC_STR(mhi_cntrl->ee), ret);
+
+	if (!mhi_cntrl->fbc_download)
+		return;
+
+	if (ret) {
+		MHI_ERR("Did not transition to READY state\n");
+		goto error_read;
+	}
+
+	/* wait for BHIE event */
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->ee == MHI_EE_BHIE ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		MHI_ERR("MHI did not enter BHIE\n");
+		goto error_read;
+	}
+
+	/* start full firmware image download */
+	image_info = mhi_cntrl->fbc_image;
+	ret = mhi_fw_load_amss(mhi_cntrl,
+			       /* last entry is vec table */
+			       &image_info->mhi_buf[image_info->entries - 1]);
+
+	MHI_LOG("amss fw_load, ret:%d\n", ret);
+
+	release_firmware(firmware);
+
+	return;
+
+error_read:
+	mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
+	mhi_cntrl->fbc_image = NULL;
+
+error_alloc_fw_table:
+	release_firmware(firmware);
+}
diff --git a/drivers/bus/mhi/core/mhi_dtr.c b/drivers/bus/mhi/core/mhi_dtr.c
new file mode 100644
index 0000000..bc17359
--- /dev/null
+++ b/drivers/bus/mhi/core/mhi_dtr.c
@@ -0,0 +1,177 @@
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/termios.h>
+#include <linux/wait.h>
+#include <linux/mhi.h>
+#include "mhi_internal.h"
+
+struct __packed dtr_ctrl_msg {
+	u32 preamble;
+	u32 msg_id;
+	u32 dest_id;
+	u32 size;
+	u32 msg;
+};
+
+#define CTRL_MAGIC (0x4C525443)
+#define CTRL_MSG_DTR BIT(0)
+#define CTRL_MSG_ID (0x10)
+
+static int mhi_dtr_tiocmset(struct mhi_controller *mhi_cntrl,
+			    struct mhi_chan *mhi_chan,
+			    u32 tiocm)
+{
+	struct dtr_ctrl_msg *dtr_msg = NULL;
+	struct mhi_chan *dtr_chan = mhi_cntrl->dtr_dev->ul_chan;
+	int ret = 0;
+
+	tiocm &= TIOCM_DTR;
+	if (mhi_chan->tiocm == tiocm)
+		return 0;
+
+	mutex_lock(&dtr_chan->mutex);
+
+	dtr_msg = kzalloc(sizeof(*dtr_msg), GFP_KERNEL);
+	if (!dtr_msg) {
+		ret = -ENOMEM;
+		goto tiocm_exit;
+	}
+
+	dtr_msg->preamble = CTRL_MAGIC;
+	dtr_msg->msg_id = CTRL_MSG_ID;
+	dtr_msg->dest_id = mhi_chan->chan;
+	dtr_msg->size = sizeof(u32);
+	if (tiocm & TIOCM_DTR)
+		dtr_msg->msg |= CTRL_MSG_DTR;
+
+	reinit_completion(&dtr_chan->completion);
+	ret = mhi_queue_transfer(mhi_cntrl->dtr_dev, DMA_TO_DEVICE, dtr_msg,
+				 sizeof(*dtr_msg), MHI_EOT);
+	if (ret)
+		goto tiocm_exit;
+
+	ret = wait_for_completion_timeout(&dtr_chan->completion,
+				msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret) {
+		MHI_ERR("Failed to receive transfer callback\n");
+		ret = -EIO;
+		goto tiocm_exit;
+	}
+
+	ret = 0;
+	mhi_chan->tiocm = tiocm;
+
+tiocm_exit:
+	kfree(dtr_msg);
+	mutex_unlock(&dtr_chan->mutex);
+
+	return ret;
+}
+
+long mhi_ioctl(struct mhi_device *mhi_dev, unsigned int cmd, unsigned long arg)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan = mhi_dev->ul_chan;
+	int ret;
+
+	/* ioctl not supported by this controller */
+	if (!mhi_cntrl->dtr_dev)
+		return -EIO;
+
+	switch (cmd) {
+	case TIOCMGET:
+		return mhi_chan->tiocm;
+	case TIOCMSET:
+	{
+		u32 tiocm;
+
+		ret = get_user(tiocm, (u32 *)arg);
+		if (ret)
+			return ret;
+
+		return mhi_dtr_tiocmset(mhi_cntrl, mhi_chan, tiocm);
+	}
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(mhi_ioctl);
+
+static void mhi_dtr_xfer_cb(struct mhi_device *mhi_dev,
+			    struct mhi_result *mhi_result)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *dtr_chan = mhi_cntrl->dtr_dev->ul_chan;
+
+	MHI_VERB("Received with status:%d\n", mhi_result->transaction_status);
+	if (!mhi_result->transaction_status)
+		complete(&dtr_chan->completion);
+}
+
+static void mhi_dtr_remove(struct mhi_device *mhi_dev)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+
+	mhi_cntrl->dtr_dev = NULL;
+}
+
+static int mhi_dtr_probe(struct mhi_device *mhi_dev,
+			 const struct mhi_device_id *id)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	int ret;
+
+	MHI_LOG("Enter for DTR control channel\n");
+
+	ret = mhi_prepare_for_transfer(mhi_dev);
+	if (!ret)
+		mhi_cntrl->dtr_dev = mhi_dev;
+
+	MHI_LOG("Exit with ret:%d\n", ret);
+
+	return ret;
+}
+
+static const struct mhi_device_id mhi_dtr_table[] = {
+	{ .chan = "IP_CTRL" },
+	{ NULL },
+};
+
+static struct mhi_driver mhi_dtr_driver = {
+	.id_table = mhi_dtr_table,
+	.remove = mhi_dtr_remove,
+	.probe = mhi_dtr_probe,
+	.ul_xfer_cb = mhi_dtr_xfer_cb,
+	.dl_xfer_cb = mhi_dtr_xfer_cb,
+	.driver = {
+		.name = "MHI_DTR",
+		.owner = THIS_MODULE,
+	}
+};
+
+int __init mhi_dtr_init(void)
+{
+	return mhi_driver_register(&mhi_dtr_driver);
+}
diff --git a/drivers/bus/mhi/core/mhi_init.c b/drivers/bus/mhi/core/mhi_init.c
new file mode 100644
index 0000000..8f103ed
--- /dev/null
+++ b/drivers/bus/mhi/core/mhi_init.c
@@ -0,0 +1,1290 @@
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/mhi.h>
+#include "mhi_internal.h"
+
+const char * const mhi_ee_str[MHI_EE_MAX] = {
+	[MHI_EE_PBL] = "PBL",
+	[MHI_EE_SBL] = "SBL",
+	[MHI_EE_AMSS] = "AMSS",
+	[MHI_EE_BHIE] = "BHIE",
+	[MHI_EE_RDDM] = "RDDM",
+	[MHI_EE_PTHRU] = "PASS THRU",
+	[MHI_EE_EDL] = "EDL",
+	[MHI_EE_DISABLE_TRANSITION] = "DISABLE",
+};
+
+const char * const mhi_state_tran_str[MHI_ST_TRANSITION_MAX] = {
+	[MHI_ST_TRANSITION_PBL] = "PBL",
+	[MHI_ST_TRANSITION_READY] = "READY",
+	[MHI_ST_TRANSITION_SBL] = "SBL",
+	[MHI_ST_TRANSITION_AMSS] = "AMSS",
+	[MHI_ST_TRANSITION_BHIE] = "BHIE",
+};
+
+const char * const mhi_state_str[MHI_STATE_MAX] = {
+	[MHI_STATE_RESET] = "RESET",
+	[MHI_STATE_READY] = "READY",
+	[MHI_STATE_M0] = "M0",
+	[MHI_STATE_M1] = "M1",
+	[MHI_STATE_M2] = "M2",
+	[MHI_STATE_M3] = "M3",
+	[MHI_STATE_BHI] = "BHI",
+	[MHI_STATE_SYS_ERR] = "SYS_ERR",
+};
+
+static const char * const mhi_pm_state_str[] = {
+	"DISABLE",
+	"POR",
+	"M0",
+	"M1",
+	"M1->M2",
+	"M2",
+	"M?->M3",
+	"M3",
+	"M3->M0",
+	"FW DL Error",
+	"SYS_ERR Detect",
+	"SYS_ERR Process",
+	"SHUTDOWN Process",
+	"LD or Error Fatal Detect",
+};
+
+struct mhi_bus mhi_bus;
+
+const char *to_mhi_pm_state_str(enum MHI_PM_STATE state)
+{
+	int index = find_last_bit((unsigned long *)&state, 32);
+
+	if (index >= ARRAY_SIZE(mhi_pm_state_str))
+		return "Invalid State";
+
+	return mhi_pm_state_str[index];
+}
+
+/* MHI protocol require transfer ring to be aligned to ring length */
+static int mhi_alloc_aligned_ring(struct mhi_controller *mhi_cntrl,
+				  struct mhi_ring *ring,
+				  u64 len)
+{
+	ring->alloc_size = len + (len - 1);
+	ring->pre_aligned = mhi_alloc_coherent(mhi_cntrl, ring->alloc_size,
+					       &ring->dma_handle, GFP_KERNEL);
+	if (!ring->pre_aligned)
+		return -ENOMEM;
+
+	ring->iommu_base = (ring->dma_handle + (len - 1)) & ~(len - 1);
+	ring->base = ring->pre_aligned + (ring->iommu_base - ring->dma_handle);
+	return 0;
+}
+
+void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl)
+{
+	int i;
+	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
+
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		free_irq(mhi_cntrl->irq[mhi_event->msi], mhi_event);
+	}
+
+	free_irq(mhi_cntrl->irq[0], mhi_cntrl);
+}
+
+int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
+{
+	int i;
+	int ret;
+	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
+
+	/* for BHI INTVEC msi */
+	ret = request_threaded_irq(mhi_cntrl->irq[0], mhi_intvec_handlr,
+				   mhi_intvec_threaded_handlr, IRQF_ONESHOT,
+				   "mhi", mhi_cntrl);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		ret = request_irq(mhi_cntrl->irq[mhi_event->msi],
+				  mhi_msi_handlr, IRQF_SHARED, "mhi",
+				  mhi_event);
+		if (ret) {
+			MHI_ERR("Error requesting irq:%d for ev:%d\n",
+				mhi_cntrl->irq[mhi_event->msi], i);
+			goto error_request;
+		}
+	}
+
+	return 0;
+
+error_request:
+	for (--i, --mhi_event; i >= 0; i--, mhi_event--) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		free_irq(mhi_cntrl->irq[mhi_event->msi], mhi_event);
+	}
+	free_irq(mhi_cntrl->irq[0], mhi_cntrl);
+
+	return ret;
+}
+
+void mhi_deinit_dev_ctxt(struct mhi_controller *mhi_cntrl)
+{
+	int i;
+	struct mhi_ctxt *mhi_ctxt = mhi_cntrl->mhi_ctxt;
+	struct mhi_cmd *mhi_cmd;
+	struct mhi_event *mhi_event;
+	struct mhi_ring *ring;
+
+	mhi_cmd = mhi_cntrl->mhi_cmd;
+	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++) {
+		ring = &mhi_cmd->ring;
+		mhi_free_coherent(mhi_cntrl, ring->alloc_size,
+				  ring->pre_aligned, ring->dma_handle);
+		ring->base = NULL;
+		ring->iommu_base = 0;
+	}
+
+	mhi_free_coherent(mhi_cntrl,
+			  sizeof(*mhi_ctxt->cmd_ctxt) * NR_OF_CMD_RINGS,
+			  mhi_ctxt->cmd_ctxt, mhi_ctxt->cmd_ctxt_addr);
+
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		ring = &mhi_event->ring;
+		mhi_free_coherent(mhi_cntrl, ring->alloc_size,
+				  ring->pre_aligned, ring->dma_handle);
+		ring->base = NULL;
+		ring->iommu_base = 0;
+	}
+
+	mhi_free_coherent(mhi_cntrl, sizeof(*mhi_ctxt->er_ctxt) *
+			  mhi_cntrl->total_ev_rings, mhi_ctxt->er_ctxt,
+			  mhi_ctxt->er_ctxt_addr);
+
+	mhi_free_coherent(mhi_cntrl, sizeof(*mhi_ctxt->chan_ctxt) *
+			  mhi_cntrl->max_chan, mhi_ctxt->chan_ctxt,
+			  mhi_ctxt->chan_ctxt_addr);
+
+	kfree(mhi_ctxt);
+	mhi_cntrl->mhi_ctxt = NULL;
+}
+
+static int mhi_init_debugfs_mhi_states_open(struct inode *inode,
+					    struct file *fp)
+{
+	return single_open(fp, mhi_debugfs_mhi_states_show, inode->i_private);
+}
+
+static int mhi_init_debugfs_mhi_event_open(struct inode *inode, struct file *fp)
+{
+	return single_open(fp, mhi_debugfs_mhi_event_show, inode->i_private);
+}
+
+static int mhi_init_debugfs_mhi_chan_open(struct inode *inode, struct file *fp)
+{
+	return single_open(fp, mhi_debugfs_mhi_chan_show, inode->i_private);
+}
+
+static const struct file_operations debugfs_state_ops = {
+	.open = mhi_init_debugfs_mhi_states_open,
+	.release = single_release,
+	.read = seq_read,
+};
+
+static const struct file_operations debugfs_ev_ops = {
+	.open = mhi_init_debugfs_mhi_event_open,
+	.release = single_release,
+	.read = seq_read,
+};
+
+static const struct file_operations debugfs_chan_ops = {
+	.open = mhi_init_debugfs_mhi_chan_open,
+	.release = single_release,
+	.read = seq_read,
+};
+
+DEFINE_SIMPLE_ATTRIBUTE(debugfs_trigger_reset_fops, NULL,
+			mhi_debugfs_trigger_reset, "%llu\n");
+
+void mhi_init_debugfs(struct mhi_controller *mhi_cntrl)
+{
+	struct dentry *dentry;
+	char node[32];
+
+	if (!mhi_cntrl->parent)
+		return;
+
+	snprintf(node, sizeof(node), "%04x_%02u:%02u.%02u",
+		 mhi_cntrl->dev_id, mhi_cntrl->domain, mhi_cntrl->bus,
+		 mhi_cntrl->slot);
+
+	dentry = debugfs_create_dir(node, mhi_cntrl->parent);
+	if (IS_ERR_OR_NULL(dentry))
+		return;
+
+	debugfs_create_file("states", 0444, dentry, mhi_cntrl,
+			    &debugfs_state_ops);
+	debugfs_create_file("events", 0444, dentry, mhi_cntrl,
+			    &debugfs_ev_ops);
+	debugfs_create_file("chan", 0444, dentry, mhi_cntrl, &debugfs_chan_ops);
+	debugfs_create_file("reset", 0444, dentry, mhi_cntrl,
+			    &debugfs_trigger_reset_fops);
+	mhi_cntrl->dentry = dentry;
+}
+
+void mhi_deinit_debugfs(struct mhi_controller *mhi_cntrl)
+{
+	debugfs_remove_recursive(mhi_cntrl->dentry);
+	mhi_cntrl->dentry = NULL;
+}
+
+int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_ctxt *mhi_ctxt;
+	struct mhi_chan_ctxt *chan_ctxt;
+	struct mhi_event_ctxt *er_ctxt;
+	struct mhi_cmd_ctxt *cmd_ctxt;
+	struct mhi_chan *mhi_chan;
+	struct mhi_event *mhi_event;
+	struct mhi_cmd *mhi_cmd;
+	int ret = -ENOMEM, i;
+
+	atomic_set(&mhi_cntrl->dev_wake, 0);
+	atomic_set(&mhi_cntrl->alloc_size, 0);
+
+	mhi_ctxt = kzalloc(sizeof(*mhi_ctxt), GFP_KERNEL);
+	if (!mhi_ctxt)
+		return -ENOMEM;
+
+	/* setup channel ctxt */
+	mhi_ctxt->chan_ctxt = mhi_alloc_coherent(mhi_cntrl,
+			sizeof(*mhi_ctxt->chan_ctxt) * mhi_cntrl->max_chan,
+			&mhi_ctxt->chan_ctxt_addr, GFP_KERNEL);
+	if (!mhi_ctxt->chan_ctxt)
+		goto error_alloc_chan_ctxt;
+
+	mhi_chan = mhi_cntrl->mhi_chan;
+	chan_ctxt = mhi_ctxt->chan_ctxt;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, chan_ctxt++, mhi_chan++) {
+		/* If it's offload channel skip this step */
+		if (mhi_chan->offload_ch)
+			continue;
+
+		chan_ctxt->chstate = MHI_CH_STATE_DISABLED;
+		chan_ctxt->brstmode = mhi_chan->db_cfg.brstmode;
+		chan_ctxt->pollcfg = mhi_chan->db_cfg.pollcfg;
+		chan_ctxt->chtype = mhi_chan->dir;
+		chan_ctxt->erindex = mhi_chan->er_index;
+
+		mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
+		mhi_chan->tre_ring.db_addr = &chan_ctxt->wp;
+	}
+
+	/* setup event context */
+	mhi_ctxt->er_ctxt = mhi_alloc_coherent(mhi_cntrl,
+			sizeof(*mhi_ctxt->er_ctxt) * mhi_cntrl->total_ev_rings,
+			&mhi_ctxt->er_ctxt_addr, GFP_KERNEL);
+	if (!mhi_ctxt->er_ctxt)
+		goto error_alloc_er_ctxt;
+
+	er_ctxt = mhi_ctxt->er_ctxt;
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, er_ctxt++,
+		     mhi_event++) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		/* it's a satellite ev, we do not touch it */
+		if (mhi_event->offload_ev)
+			continue;
+
+		er_ctxt->intmodc = 0;
+		er_ctxt->intmodt = mhi_event->intmod;
+		er_ctxt->ertype = MHI_ER_TYPE_VALID;
+		er_ctxt->msivec = mhi_event->msi;
+		mhi_event->db_cfg.db_mode = true;
+
+		ring->el_size = sizeof(struct __packed mhi_tre);
+		ring->len = ring->el_size * ring->elements;
+		ret = mhi_alloc_aligned_ring(mhi_cntrl, ring, ring->len);
+		if (ret)
+			goto error_alloc_er;
+
+		ring->rp = ring->wp = ring->base;
+		er_ctxt->rbase = ring->iommu_base;
+		er_ctxt->rp = er_ctxt->wp = er_ctxt->rbase;
+		er_ctxt->rlen = ring->len;
+		ring->ctxt_wp = &er_ctxt->wp;
+	}
+
+	/* setup cmd context */
+	mhi_ctxt->cmd_ctxt = mhi_alloc_coherent(mhi_cntrl,
+				sizeof(*mhi_ctxt->cmd_ctxt) * NR_OF_CMD_RINGS,
+				&mhi_ctxt->cmd_ctxt_addr, GFP_KERNEL);
+	if (!mhi_ctxt->cmd_ctxt)
+		goto error_alloc_er;
+
+	mhi_cmd = mhi_cntrl->mhi_cmd;
+	cmd_ctxt = mhi_ctxt->cmd_ctxt;
+	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++, cmd_ctxt++) {
+		struct mhi_ring *ring = &mhi_cmd->ring;
+
+		ring->el_size = sizeof(struct __packed mhi_tre);
+		ring->elements = CMD_EL_PER_RING;
+		ring->len = ring->el_size * ring->elements;
+		ret = mhi_alloc_aligned_ring(mhi_cntrl, ring, ring->len);
+		if (ret)
+			goto error_alloc_cmd;
+
+		ring->rp = ring->wp = ring->base;
+		cmd_ctxt->rbase = ring->iommu_base;
+		cmd_ctxt->rp = cmd_ctxt->wp = cmd_ctxt->rbase;
+		cmd_ctxt->rlen = ring->len;
+		ring->ctxt_wp = &cmd_ctxt->wp;
+	}
+
+	mhi_cntrl->mhi_ctxt = mhi_ctxt;
+
+	return 0;
+
+error_alloc_cmd:
+	for (--i, --mhi_cmd; i >= 0; i--, mhi_cmd--) {
+		struct mhi_ring *ring = &mhi_cmd->ring;
+
+		mhi_free_coherent(mhi_cntrl, ring->alloc_size,
+				  ring->pre_aligned, ring->dma_handle);
+	}
+	mhi_free_coherent(mhi_cntrl,
+			  sizeof(*mhi_ctxt->cmd_ctxt) * NR_OF_CMD_RINGS,
+			  mhi_ctxt->cmd_ctxt, mhi_ctxt->cmd_ctxt_addr);
+	i = mhi_cntrl->total_ev_rings;
+	mhi_event = mhi_cntrl->mhi_event + i;
+
+error_alloc_er:
+	for (--i, --mhi_event; i >= 0; i--, mhi_event--) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		if (mhi_event->offload_ev)
+			continue;
+
+		mhi_free_coherent(mhi_cntrl, ring->alloc_size,
+				  ring->pre_aligned, ring->dma_handle);
+	}
+	mhi_free_coherent(mhi_cntrl, sizeof(*mhi_ctxt->er_ctxt) *
+			  mhi_cntrl->total_ev_rings, mhi_ctxt->er_ctxt,
+			  mhi_ctxt->er_ctxt_addr);
+
+error_alloc_er_ctxt:
+	mhi_free_coherent(mhi_cntrl, sizeof(*mhi_ctxt->chan_ctxt) *
+			  mhi_cntrl->max_chan, mhi_ctxt->chan_ctxt,
+			  mhi_ctxt->chan_ctxt_addr);
+
+error_alloc_chan_ctxt:
+	kfree(mhi_ctxt);
+
+	return ret;
+}
+
+int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
+{
+	u32 val;
+	int i, ret;
+	struct mhi_chan *mhi_chan;
+	struct mhi_event *mhi_event;
+	void __iomem *base = mhi_cntrl->regs;
+	struct {
+		u32 offset;
+		u32 mask;
+		u32 shift;
+		u32 val;
+	} reg_info[] = {
+		{
+			CCABAP_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->mhi_ctxt->chan_ctxt_addr),
+		},
+		{
+			CCABAP_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->mhi_ctxt->chan_ctxt_addr),
+		},
+		{
+			ECABAP_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->mhi_ctxt->er_ctxt_addr),
+		},
+		{
+			ECABAP_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->mhi_ctxt->er_ctxt_addr),
+		},
+		{
+			CRCBAP_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->mhi_ctxt->cmd_ctxt_addr),
+		},
+		{
+			CRCBAP_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->mhi_ctxt->cmd_ctxt_addr),
+		},
+		{
+			MHICFG, MHICFG_NER_MASK, MHICFG_NER_SHIFT,
+			mhi_cntrl->total_ev_rings,
+		},
+		{
+			MHICFG, MHICFG_NHWER_MASK, MHICFG_NHWER_SHIFT,
+			mhi_cntrl->hw_ev_rings,
+		},
+		{
+			MHICTRLBASE_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->iova_start),
+		},
+		{
+			MHICTRLBASE_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->iova_start),
+		},
+		{
+			MHIDATABASE_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->iova_start),
+		},
+		{
+			MHIDATABASE_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->iova_start),
+		},
+		{
+			MHICTRLLIMIT_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->iova_stop),
+		},
+		{
+			MHICTRLLIMIT_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->iova_stop),
+		},
+		{
+			MHIDATALIMIT_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->iova_stop),
+		},
+		{
+			MHIDATALIMIT_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->iova_stop),
+		},
+		{ 0, 0, 0 }
+	};
+
+	MHI_LOG("Initializing MMIO\n");
+
+	/* set up DB register for all the chan rings */
+	ret = mhi_read_reg_field(mhi_cntrl, base, CHDBOFF, CHDBOFF_CHDBOFF_MASK,
+				 CHDBOFF_CHDBOFF_SHIFT, &val);
+	if (ret)
+		return -EIO;
+
+	MHI_LOG("CHDBOFF:0x%x\n", val);
+
+	/* setup wake db */
+	mhi_cntrl->wake_db = base + val + (8 * MHI_DEV_WAKE_DB);
+	mhi_write_reg(mhi_cntrl, mhi_cntrl->wake_db, 4, 0);
+	mhi_write_reg(mhi_cntrl, mhi_cntrl->wake_db, 0, 0);
+	mhi_cntrl->wake_set = false;
+
+	/* setup channel db addresses */
+	mhi_chan = mhi_cntrl->mhi_chan;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, val += 8, mhi_chan++)
+		mhi_chan->tre_ring.db_addr = base + val;
+
+	/* setup event ring db addresses */
+	ret = mhi_read_reg_field(mhi_cntrl, base, ERDBOFF, ERDBOFF_ERDBOFF_MASK,
+				 ERDBOFF_ERDBOFF_SHIFT, &val);
+	if (ret)
+		return -EIO;
+
+	MHI_LOG("ERDBOFF:0x%x\n", val);
+
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, val += 8, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		mhi_event->ring.db_addr = base + val;
+	}
+
+	/* set up DB register for primary CMD rings */
+	mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING].ring.db_addr = base + CRDB_LOWER;
+
+	MHI_LOG("Programming all MMIO values.\n");
+	for (i = 0; reg_info[i].offset; i++)
+		mhi_write_reg_field(mhi_cntrl, base, reg_info[i].offset,
+				    reg_info[i].mask, reg_info[i].shift,
+				    reg_info[i].val);
+
+	return 0;
+}
+
+void mhi_deinit_chan_ctxt(struct mhi_controller *mhi_cntrl,
+			  struct mhi_chan *mhi_chan)
+{
+	struct mhi_ring *buf_ring;
+	struct mhi_ring *tre_ring;
+	struct mhi_chan_ctxt *chan_ctxt;
+
+	buf_ring = &mhi_chan->buf_ring;
+	tre_ring = &mhi_chan->tre_ring;
+	chan_ctxt = &mhi_cntrl->mhi_ctxt->chan_ctxt[mhi_chan->chan];
+
+	mhi_free_coherent(mhi_cntrl, tre_ring->alloc_size,
+			  tre_ring->pre_aligned, tre_ring->dma_handle);
+	kfree(buf_ring->base);
+
+	buf_ring->base = tre_ring->base = NULL;
+	chan_ctxt->rbase = 0;
+}
+
+int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
+		       struct mhi_chan *mhi_chan)
+{
+	struct mhi_ring *buf_ring;
+	struct mhi_ring *tre_ring;
+	struct mhi_chan_ctxt *chan_ctxt;
+	int ret;
+
+	buf_ring = &mhi_chan->buf_ring;
+	tre_ring = &mhi_chan->tre_ring;
+	tre_ring->el_size = sizeof(struct __packed mhi_tre);
+	tre_ring->len = tre_ring->el_size * tre_ring->elements;
+	chan_ctxt = &mhi_cntrl->mhi_ctxt->chan_ctxt[mhi_chan->chan];
+	ret = mhi_alloc_aligned_ring(mhi_cntrl, tre_ring, tre_ring->len);
+	if (ret)
+		return -ENOMEM;
+
+	buf_ring->el_size = sizeof(struct mhi_buf_info);
+	buf_ring->len = buf_ring->el_size * buf_ring->elements;
+	buf_ring->base = kzalloc(buf_ring->len, GFP_KERNEL);
+
+	if (!buf_ring->base) {
+		mhi_free_coherent(mhi_cntrl, tre_ring->alloc_size,
+				  tre_ring->pre_aligned, tre_ring->dma_handle);
+		return -ENOMEM;
+	}
+
+	chan_ctxt->chstate = MHI_CH_STATE_ENABLED;
+	chan_ctxt->rbase = tre_ring->iommu_base;
+	chan_ctxt->rp = chan_ctxt->wp = chan_ctxt->rbase;
+	chan_ctxt->rlen = tre_ring->len;
+	tre_ring->ctxt_wp = &chan_ctxt->wp;
+
+	tre_ring->rp = tre_ring->wp = tre_ring->base;
+	buf_ring->rp = buf_ring->wp = buf_ring->base;
+	mhi_chan->db_cfg.db_mode = 1;
+
+	/* update to all cores */
+	smp_wmb();
+
+	return 0;
+}
+
+int mhi_device_configure(struct mhi_device *mhi_dev,
+			 enum dma_data_direction dir,
+			 struct mhi_buf *cfg_tbl,
+			 int elements)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan;
+	struct mhi_event_ctxt *er_ctxt;
+	struct mhi_chan_ctxt *ch_ctxt;
+	int er_index, chan;
+
+	mhi_chan = (dir == DMA_TO_DEVICE) ? mhi_dev->ul_chan : mhi_dev->dl_chan;
+	er_index = mhi_chan->er_index;
+	chan = mhi_chan->chan;
+
+	for (; elements > 0; elements--, cfg_tbl++) {
+		/* update event context array */
+		if (!strcmp(cfg_tbl->name, "ECA")) {
+			er_ctxt = &mhi_cntrl->mhi_ctxt->er_ctxt[er_index];
+			if (sizeof(*er_ctxt) != cfg_tbl->len) {
+				MHI_ERR(
+					"Invalid ECA size, expected:%zu actual%zu\n",
+					sizeof(*er_ctxt), cfg_tbl->len);
+				return -EINVAL;
+			}
+			memcpy((void *)er_ctxt, cfg_tbl->buf, sizeof(*er_ctxt));
+			continue;
+		}
+
+		/* update channel context array */
+		if (!strcmp(cfg_tbl->name, "CCA")) {
+			ch_ctxt = &mhi_cntrl->mhi_ctxt->chan_ctxt[chan];
+			if (cfg_tbl->len != sizeof(*ch_ctxt)) {
+				MHI_ERR(
+					"Invalid CCA size, expected:%zu actual:%zu\n",
+					sizeof(*ch_ctxt), cfg_tbl->len);
+				return -EINVAL;
+			}
+			memcpy((void *)ch_ctxt, cfg_tbl->buf, sizeof(*ch_ctxt));
+			continue;
+		}
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+#if defined(CONFIG_OF)
+static int of_parse_ev_cfg(struct mhi_controller *mhi_cntrl,
+			   struct device_node *of_node)
+{
+	struct {
+		u32 ev_cfg[MHI_EV_CFG_MAX];
+	} *ev_cfg;
+	int num, i, ret;
+	struct mhi_event *mhi_event;
+	u32 bit_cfg;
+
+	num = of_property_count_elems_of_size(of_node, "mhi,ev-cfg",
+					      sizeof(*ev_cfg));
+	if (num <= 0)
+		return -EINVAL;
+
+	ev_cfg = kcalloc(num, sizeof(*ev_cfg), GFP_KERNEL);
+	if (!ev_cfg)
+		return -ENOMEM;
+
+	mhi_cntrl->total_ev_rings = num;
+	mhi_cntrl->mhi_event = kcalloc(num, sizeof(*mhi_cntrl->mhi_event),
+				       GFP_KERNEL);
+	if (!mhi_cntrl->mhi_event) {
+		kfree(ev_cfg);
+		return -ENOMEM;
+	}
+
+	ret = of_property_read_u32_array(of_node, "mhi,ev-cfg", (u32 *)ev_cfg,
+					 num * sizeof(*ev_cfg) / sizeof(u32));
+	if (ret)
+		goto error_ev_cfg;
+
+	/* populate ev ring */
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		mhi_event->er_index = i;
+		mhi_event->ring.elements =
+			ev_cfg[i].ev_cfg[MHI_EV_CFG_ELEMENTS];
+		mhi_event->intmod = ev_cfg[i].ev_cfg[MHI_EV_CFG_INTMOD];
+		mhi_event->msi = ev_cfg[i].ev_cfg[MHI_EV_CFG_MSI];
+		mhi_event->chan = ev_cfg[i].ev_cfg[MHI_EV_CFG_CHAN];
+		if (mhi_event->chan >= mhi_cntrl->max_chan)
+			goto error_ev_cfg;
+
+		/* this event ring has a dedicated channel */
+		if (mhi_event->chan)
+			mhi_event->mhi_chan =
+				&mhi_cntrl->mhi_chan[mhi_event->chan];
+
+		mhi_event->priority = ev_cfg[i].ev_cfg[MHI_EV_CFG_PRIORITY];
+		mhi_event->db_cfg.brstmode =
+			ev_cfg[i].ev_cfg[MHI_EV_CFG_BRSTMODE];
+		if (MHI_INVALID_BRSTMODE(mhi_event->db_cfg.brstmode))
+			goto error_ev_cfg;
+
+		mhi_event->db_cfg.process_db =
+			(mhi_event->db_cfg.brstmode == MHI_BRSTMODE_ENABLE) ?
+			mhi_db_brstmode : mhi_db_brstmode_disable;
+
+		bit_cfg = ev_cfg[i].ev_cfg[MHI_EV_CFG_BITCFG];
+		if (bit_cfg & MHI_EV_CFG_BIT_HW_EV) {
+			mhi_event->hw_ring = true;
+			mhi_cntrl->hw_ev_rings++;
+		} else
+			mhi_cntrl->sw_ev_rings++;
+
+		mhi_event->cl_manage = !!(bit_cfg & MHI_EV_CFG_BIT_CL_MANAGE);
+		mhi_event->offload_ev = !!(bit_cfg & MHI_EV_CFG_BIT_OFFLOAD_EV);
+		mhi_event->ctrl_ev = !!(bit_cfg & MHI_EV_CFG_BIT_CTRL_EV);
+	}
+
+	kfree(ev_cfg);
+
+	/* we need msi for each event ring + additional one for BHI */
+	mhi_cntrl->msi_required = mhi_cntrl->total_ev_rings + 1;
+
+	return 0;
+
+ error_ev_cfg:
+	kfree(ev_cfg);
+	kfree(mhi_cntrl->mhi_event);
+	return -EINVAL;
+}
+static int of_parse_ch_cfg(struct mhi_controller *mhi_cntrl,
+			   struct device_node *of_node)
+{
+	int num, i, ret;
+	struct {
+		u32 chan_cfg[MHI_CH_CFG_MAX];
+	} *chan_cfg;
+
+	ret = of_property_read_u32(of_node, "mhi,max-channels",
+				   &mhi_cntrl->max_chan);
+	if (ret)
+		return ret;
+	num = of_property_count_elems_of_size(of_node, "mhi,chan-cfg",
+					      sizeof(*chan_cfg));
+	if (num <= 0 || num >= mhi_cntrl->max_chan)
+		return -EINVAL;
+	if (of_property_count_strings(of_node, "mhi,chan-names") != num)
+		return -EINVAL;
+
+	mhi_cntrl->mhi_chan = kcalloc(mhi_cntrl->max_chan,
+				      sizeof(*mhi_cntrl->mhi_chan), GFP_KERNEL);
+	if (!mhi_cntrl->mhi_chan)
+		return -ENOMEM;
+	chan_cfg = kcalloc(num, sizeof(*chan_cfg), GFP_KERNEL);
+	if (!chan_cfg) {
+		kfree(mhi_cntrl->mhi_chan);
+		return -ENOMEM;
+	}
+
+	ret = of_property_read_u32_array(of_node, "mhi,chan-cfg",
+					 (u32 *)chan_cfg,
+					 num * sizeof(*chan_cfg) / sizeof(u32));
+	if (ret)
+		goto error_chan_cfg;
+
+	INIT_LIST_HEAD(&mhi_cntrl->lpm_chans);
+
+	/* populate channel configurations */
+	for (i = 0; i < num; i++) {
+		struct mhi_chan *mhi_chan;
+		int chan = chan_cfg[i].chan_cfg[MHI_CH_CFG_CHAN_ID];
+		u32 bit_cfg = chan_cfg[i].chan_cfg[MHI_CH_CFG_BITCFG];
+
+		if (chan >= mhi_cntrl->max_chan)
+			goto error_chan_cfg;
+
+		mhi_chan = &mhi_cntrl->mhi_chan[chan];
+		mhi_chan->chan = chan;
+		mhi_chan->buf_ring.elements =
+			chan_cfg[i].chan_cfg[MHI_CH_CFG_ELEMENTS];
+		mhi_chan->tre_ring.elements = mhi_chan->buf_ring.elements;
+		mhi_chan->er_index = chan_cfg[i].chan_cfg[MHI_CH_CFG_ER_INDEX];
+		mhi_chan->dir = chan_cfg[i].chan_cfg[MHI_CH_CFG_DIRECTION];
+
+		mhi_chan->db_cfg.pollcfg =
+			chan_cfg[i].chan_cfg[MHI_CH_CFG_POLLCFG];
+		mhi_chan->ee = chan_cfg[i].chan_cfg[MHI_CH_CFG_EE];
+		if (mhi_chan->ee >= MHI_EE_MAX_SUPPORTED)
+			goto error_chan_cfg;
+
+		mhi_chan->xfer_type =
+			chan_cfg[i].chan_cfg[MHI_CH_CFG_XFER_TYPE];
+
+		switch (mhi_chan->xfer_type) {
+		case MHI_XFER_BUFFER:
+			mhi_chan->gen_tre = mhi_gen_tre;
+			mhi_chan->queue_xfer = mhi_queue_buf;
+			break;
+		case MHI_XFER_SKB:
+			mhi_chan->queue_xfer = mhi_queue_skb;
+			break;
+		case MHI_XFER_SCLIST:
+			mhi_chan->gen_tre = mhi_gen_tre;
+			mhi_chan->queue_xfer = mhi_queue_sclist;
+			break;
+		case MHI_XFER_NOP:
+			mhi_chan->queue_xfer = mhi_queue_nop;
+			break;
+		default:
+			goto error_chan_cfg;
+		}
+
+		mhi_chan->lpm_notify = !!(bit_cfg & MHI_CH_CFG_BIT_LPM_NOTIFY);
+		mhi_chan->offload_ch = !!(bit_cfg & MHI_CH_CFG_BIT_OFFLOAD_CH);
+		mhi_chan->db_cfg.reset_req =
+			!!(bit_cfg & MHI_CH_CFG_BIT_DBMODE_RESET_CH);
+		mhi_chan->pre_alloc = !!(bit_cfg & MHI_CH_CFG_BIT_PRE_ALLOC);
+
+		if (mhi_chan->pre_alloc &&
+		    (mhi_chan->dir != DMA_FROM_DEVICE ||
+		     mhi_chan->xfer_type != MHI_XFER_BUFFER))
+			goto error_chan_cfg;
+
+		/* if mhi host allocate the buffers then client cannot queue */
+		if (mhi_chan->pre_alloc)
+			mhi_chan->queue_xfer = mhi_queue_nop;
+
+		ret = of_property_read_string_index(of_node, "mhi,chan-names",
+						    i, &mhi_chan->name);
+		if (ret)
+			goto error_chan_cfg;
+
+		if (!mhi_chan->offload_ch) {
+			mhi_chan->db_cfg.brstmode =
+				chan_cfg[i].chan_cfg[MHI_CH_CFG_BRSTMODE];
+			if (MHI_INVALID_BRSTMODE(mhi_chan->db_cfg.brstmode))
+				goto error_chan_cfg;
+
+			mhi_chan->db_cfg.process_db =
+				(mhi_chan->db_cfg.brstmode ==
+				 MHI_BRSTMODE_ENABLE) ?
+				mhi_db_brstmode : mhi_db_brstmode_disable;
+		}
+		mhi_chan->configured = true;
+
+		if (mhi_chan->lpm_notify)
+			list_add_tail(&mhi_chan->node, &mhi_cntrl->lpm_chans);
+	}
+
+	kfree(chan_cfg);
+
+	return 0;
+
+error_chan_cfg:
+	kfree(mhi_cntrl->mhi_chan);
+	kfree(chan_cfg);
+
+	return -EINVAL;
+}
+
+static int of_parse_dt(struct mhi_controller *mhi_cntrl,
+		       struct device_node *of_node)
+{
+	int ret;
+
+	/* parse firmware image info (optional parameters) */
+	of_property_read_string(of_node, "mhi,fw-name", &mhi_cntrl->fw_image);
+	of_property_read_string(of_node, "mhi,edl-name", &mhi_cntrl->fw_image);
+	mhi_cntrl->fbc_download = of_property_read_bool(of_node, "mhi,dl-fbc");
+	of_property_read_u32(of_node, "mhi,sbl-size",
+			     (u32 *)&mhi_cntrl->sbl_size);
+	of_property_read_u32(of_node, "mhi,seg-len",
+			     (u32 *)&mhi_cntrl->seg_len);
+
+	/* parse MHI channel configuration */
+	ret = of_parse_ch_cfg(mhi_cntrl, of_node);
+	if (ret)
+		return ret;
+
+	/* parse MHI event configuration */
+	ret = of_parse_ev_cfg(mhi_cntrl, of_node);
+	if (ret)
+		goto error_ev_cfg;
+
+	ret = of_property_read_u32(of_node, "mhi,timeout",
+				   &mhi_cntrl->timeout_ms);
+	if (ret)
+		mhi_cntrl->timeout_ms = MHI_TIMEOUT_MS;
+
+	return 0;
+
+ error_ev_cfg:
+	kfree(mhi_cntrl->mhi_chan);
+
+	return ret;
+}
+#else
+static int of_parse_dt(struct mhi_controller *mhi_cntrl,
+		       struct device_node *of_node)
+{
+	return -EINVAL;
+}
+#endif
+
+int of_register_mhi_controller(struct mhi_controller *mhi_cntrl)
+{
+	int ret;
+	int i;
+	struct mhi_event *mhi_event;
+	struct mhi_chan *mhi_chan;
+	struct mhi_cmd *mhi_cmd;
+
+	if (!mhi_cntrl->of_node)
+		return -EINVAL;
+
+	if (!mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put)
+		return -EINVAL;
+
+	if (!mhi_cntrl->status_cb || !mhi_cntrl->link_status)
+		return -EINVAL;
+
+	ret = of_parse_dt(mhi_cntrl, mhi_cntrl->of_node);
+	if (ret)
+		return -EINVAL;
+
+	mhi_cntrl->mhi_cmd = kcalloc(NR_OF_CMD_RINGS,
+				     sizeof(*mhi_cntrl->mhi_cmd), GFP_KERNEL);
+	if (!mhi_cntrl->mhi_cmd)
+		goto error_alloc_cmd;
+
+	INIT_LIST_HEAD(&mhi_cntrl->transition_list);
+	mutex_init(&mhi_cntrl->pm_mutex);
+	rwlock_init(&mhi_cntrl->pm_lock);
+	spin_lock_init(&mhi_cntrl->transition_lock);
+	spin_lock_init(&mhi_cntrl->wlock);
+	INIT_WORK(&mhi_cntrl->st_worker, mhi_pm_st_worker);
+	INIT_WORK(&mhi_cntrl->fw_worker, mhi_fw_load_worker);
+	INIT_WORK(&mhi_cntrl->m1_worker, mhi_pm_m1_worker);
+	INIT_WORK(&mhi_cntrl->syserr_worker, mhi_pm_sys_err_worker);
+	init_waitqueue_head(&mhi_cntrl->state_event);
+
+	mhi_cmd = mhi_cntrl->mhi_cmd;
+	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++)
+		spin_lock_init(&mhi_cmd->lock);
+
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		mhi_event->mhi_cntrl = mhi_cntrl;
+		spin_lock_init(&mhi_event->lock);
+		if (mhi_event->ctrl_ev)
+			tasklet_init(&mhi_event->task, mhi_ctrl_ev_task,
+				     (ulong)mhi_event);
+		else
+			tasklet_init(&mhi_event->task, mhi_ev_task,
+				     (ulong)mhi_event);
+	}
+
+	mhi_chan = mhi_cntrl->mhi_chan;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
+		mutex_init(&mhi_chan->mutex);
+		init_completion(&mhi_chan->completion);
+		rwlock_init(&mhi_chan->lock);
+	}
+
+	mhi_cntrl->parent = mhi_bus.dentry;
+	mhi_cntrl->klog_lvl = MHI_MSG_LVL_ERROR;
+
+	/* add to list */
+	mutex_lock(&mhi_bus.lock);
+	list_add_tail(&mhi_cntrl->node, &mhi_bus.controller_list);
+	mutex_unlock(&mhi_bus.lock);
+
+	return 0;
+
+error_alloc_cmd:
+	kfree(mhi_cntrl->mhi_chan);
+	kfree(mhi_cntrl->mhi_event);
+
+	return -ENOMEM;
+};
+EXPORT_SYMBOL(of_register_mhi_controller);
+
+void mhi_unregister_mhi_controller(struct mhi_controller *mhi_cntrl)
+{
+	kfree(mhi_cntrl->mhi_cmd);
+	kfree(mhi_cntrl->mhi_event);
+	kfree(mhi_cntrl->mhi_chan);
+
+	mutex_lock(&mhi_bus.lock);
+	list_del(&mhi_cntrl->node);
+	mutex_unlock(&mhi_bus.lock);
+}
+
+/* set ptr to control private data */
+static inline void mhi_controller_set_devdata(struct mhi_controller *mhi_cntrl,
+					 void *priv)
+{
+	mhi_cntrl->priv_data = priv;
+}
+
+
+/* allocate mhi controller to register */
+struct mhi_controller *mhi_alloc_controller(size_t size)
+{
+	struct mhi_controller *mhi_cntrl;
+
+	mhi_cntrl = kzalloc(size + sizeof(*mhi_cntrl), GFP_KERNEL);
+
+	if (mhi_cntrl && size)
+		mhi_controller_set_devdata(mhi_cntrl, mhi_cntrl + 1);
+
+	return mhi_cntrl;
+}
+EXPORT_SYMBOL(mhi_alloc_controller);
+
+int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
+{
+	int ret;
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+
+	ret = mhi_init_dev_ctxt(mhi_cntrl);
+	if (ret) {
+		MHI_ERR("Error with init dev_ctxt\n");
+		goto error_dev_ctxt;
+	}
+
+	ret = mhi_init_irq_setup(mhi_cntrl);
+	if (ret) {
+		MHI_ERR("Error setting up irq\n");
+		goto error_setup_irq;
+	}
+
+	/*
+	 * allocate rddm table if specified, this table is for debug purpose
+	 * so we'll ignore erros
+	 */
+	if (mhi_cntrl->rddm_size)
+		mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->rddm_image,
+				     mhi_cntrl->rddm_size);
+
+	mhi_cntrl->pre_init = true;
+
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	return 0;
+
+error_setup_irq:
+	mhi_deinit_dev_ctxt(mhi_cntrl);
+
+error_dev_ctxt:
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL(mhi_prepare_for_power_up);
+
+void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
+{
+	if (mhi_cntrl->fbc_image) {
+		mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
+		mhi_cntrl->fbc_image = NULL;
+	}
+
+	if (mhi_cntrl->rddm_image) {
+		mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->rddm_image);
+		mhi_cntrl->rddm_image = NULL;
+	}
+
+	mhi_deinit_free_irq(mhi_cntrl);
+	mhi_deinit_dev_ctxt(mhi_cntrl);
+	mhi_cntrl->pre_init = false;
+}
+
+/* match dev to drv */
+static int mhi_match(struct device *dev, struct device_driver *drv)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_driver *mhi_drv = to_mhi_driver(drv);
+	const struct mhi_device_id *id;
+
+	for (id = mhi_drv->id_table; id->chan; id++)
+		if (!strcmp(mhi_dev->chan_name, id->chan)) {
+			mhi_dev->id = id;
+			return 1;
+		}
+
+	return 0;
+};
+
+static void mhi_release_device(struct device *dev)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+
+	kfree(mhi_dev);
+}
+
+struct bus_type mhi_bus_type = {
+	.name = "mhi",
+	.dev_name = "mhi",
+	.match = mhi_match,
+};
+
+static int mhi_driver_probe(struct device *dev)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct device_driver *drv = dev->driver;
+	struct mhi_driver *mhi_drv = to_mhi_driver(drv);
+	struct mhi_event *mhi_event;
+	struct mhi_chan *ul_chan = mhi_dev->ul_chan;
+	struct mhi_chan *dl_chan = mhi_dev->dl_chan;
+	bool offload_ch = ((ul_chan && ul_chan->offload_ch) ||
+			   (dl_chan && dl_chan->offload_ch));
+
+	/* all offload channels require status_cb to be defined */
+	if (offload_ch) {
+		if (!mhi_dev->status_cb)
+			return -EINVAL;
+		mhi_dev->status_cb = mhi_drv->status_cb;
+	}
+
+	if (ul_chan && !offload_ch) {
+		if (!mhi_drv->ul_xfer_cb)
+			return -EINVAL;
+		ul_chan->xfer_cb = mhi_drv->ul_xfer_cb;
+	}
+
+	if (dl_chan && !offload_ch) {
+		if (!mhi_drv->dl_xfer_cb)
+			return -EINVAL;
+		dl_chan->xfer_cb = mhi_drv->dl_xfer_cb;
+		mhi_event = &mhi_cntrl->mhi_event[dl_chan->er_index];
+
+		/*
+		 * if this channal event ring manage by client, then
+		 * status_cb must be defined so we can send the async
+		 * cb whenever there are pending data
+		 */
+		if (mhi_event->cl_manage && !mhi_drv->status_cb)
+			return -EINVAL;
+		mhi_dev->status_cb = mhi_drv->status_cb;
+	}
+
+	return mhi_drv->probe(mhi_dev, mhi_dev->id);
+}
+
+static int mhi_driver_remove(struct device *dev)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_driver *mhi_drv = to_mhi_driver(dev->driver);
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan;
+	enum MHI_CH_STATE ch_state[] = {
+		MHI_CH_STATE_DISABLED,
+		MHI_CH_STATE_DISABLED
+	};
+	int dir;
+
+	MHI_LOG("Removing device for chan:%s\n", mhi_dev->chan_name);
+
+	/* reset both channels */
+	for (dir = 0; dir < 2; dir++) {
+		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
+
+		if (!mhi_chan)
+			continue;
+
+		/* wake all threads waiting for completion */
+		write_lock_irq(&mhi_chan->lock);
+		mhi_chan->ccs = MHI_EV_CC_INVALID;
+		complete_all(&mhi_chan->completion);
+		write_unlock_irq(&mhi_chan->lock);
+
+		/* move channel state to disable, no more processing */
+		mutex_lock(&mhi_chan->mutex);
+		write_lock_irq(&mhi_chan->lock);
+		ch_state[dir] = mhi_chan->ch_state;
+		mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
+		write_unlock_irq(&mhi_chan->lock);
+
+		/* reset the channel */
+		if (!mhi_chan->offload_ch)
+			mhi_reset_chan(mhi_cntrl, mhi_chan);
+	}
+
+	/* destroy the device */
+	mhi_drv->remove(mhi_dev);
+
+	/* de_init channel if it was enabled */
+	for (dir = 0; dir < 2; dir++) {
+		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
+
+		if (!mhi_chan)
+			continue;
+
+		if (ch_state[dir] == MHI_CH_STATE_ENABLED &&
+		    !mhi_chan->offload_ch)
+			mhi_deinit_chan_ctxt(mhi_cntrl, mhi_chan);
+
+		mutex_unlock(&mhi_chan->mutex);
+	}
+
+	/* relinquish any pending votes */
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	while (atomic_read(&mhi_dev->dev_wake))
+		mhi_device_put(mhi_dev);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return 0;
+}
+
+int mhi_driver_register(struct mhi_driver *mhi_drv)
+{
+	struct device_driver *driver = &mhi_drv->driver;
+
+	if (!mhi_drv->probe || !mhi_drv->remove)
+		return -EINVAL;
+
+	driver->bus = &mhi_bus_type;
+	driver->probe = mhi_driver_probe;
+	driver->remove = mhi_driver_remove;
+	return driver_register(driver);
+}
+EXPORT_SYMBOL(mhi_driver_register);
+
+void mhi_driver_unregister(struct mhi_driver *mhi_drv)
+{
+	driver_unregister(&mhi_drv->driver);
+}
+EXPORT_SYMBOL(mhi_driver_unregister);
+
+struct mhi_device *mhi_alloc_device(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_device *mhi_dev = kzalloc(sizeof(*mhi_dev), GFP_KERNEL);
+	struct device *dev;
+
+	if (!mhi_dev)
+		return NULL;
+
+	dev = &mhi_dev->dev;
+	device_initialize(dev);
+	dev->bus = &mhi_bus_type;
+	dev->release = mhi_release_device;
+	dev->parent = mhi_cntrl->dev;
+	mhi_dev->mhi_cntrl = mhi_cntrl;
+	mhi_dev->dev_id = mhi_cntrl->dev_id;
+	mhi_dev->domain = mhi_cntrl->domain;
+	mhi_dev->bus = mhi_cntrl->bus;
+	mhi_dev->slot = mhi_cntrl->slot;
+	mhi_dev->mtu = MHI_MAX_MTU;
+	atomic_set(&mhi_dev->dev_wake, 0);
+
+	return mhi_dev;
+}
+
+static int __init mhi_init(void)
+{
+	struct dentry *dentry;
+	int ret;
+
+	mutex_init(&mhi_bus.lock);
+	INIT_LIST_HEAD(&mhi_bus.controller_list);
+	dentry = debugfs_create_dir("mhi", NULL);
+	if (!IS_ERR_OR_NULL(dentry))
+		mhi_bus.dentry = dentry;
+
+	ret = bus_register(&mhi_bus_type);
+
+	if (!ret)
+		mhi_dtr_init();
+	return ret;
+}
+postcore_initcall(mhi_init);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("MHI_CORE");
+MODULE_DESCRIPTION("MHI Host Interface");
diff --git a/drivers/bus/mhi/core/mhi_internal.h b/drivers/bus/mhi/core/mhi_internal.h
new file mode 100644
index 0000000..7adc7963
--- /dev/null
+++ b/drivers/bus/mhi/core/mhi_internal.h
@@ -0,0 +1,732 @@
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _MHI_INT_H
+#define _MHI_INT_H
+
+extern struct bus_type mhi_bus_type;
+
+/* MHI mmio register mapping */
+#define PCI_INVALID_READ(val) (val == U32_MAX)
+
+#define MHIREGLEN (0x0)
+#define MHIREGLEN_MHIREGLEN_MASK (0xFFFFFFFF)
+#define MHIREGLEN_MHIREGLEN_SHIFT (0)
+
+#define MHIVER (0x8)
+#define MHIVER_MHIVER_MASK (0xFFFFFFFF)
+#define MHIVER_MHIVER_SHIFT (0)
+
+#define MHICFG (0x10)
+#define MHICFG_NHWER_MASK (0xFF000000)
+#define MHICFG_NHWER_SHIFT (24)
+#define MHICFG_NER_MASK (0xFF0000)
+#define MHICFG_NER_SHIFT (16)
+#define MHICFG_NHWCH_MASK (0xFF00)
+#define MHICFG_NHWCH_SHIFT (8)
+#define MHICFG_NCH_MASK (0xFF)
+#define MHICFG_NCH_SHIFT (0)
+
+#define CHDBOFF (0x18)
+#define CHDBOFF_CHDBOFF_MASK (0xFFFFFFFF)
+#define CHDBOFF_CHDBOFF_SHIFT (0)
+
+#define ERDBOFF (0x20)
+#define ERDBOFF_ERDBOFF_MASK (0xFFFFFFFF)
+#define ERDBOFF_ERDBOFF_SHIFT (0)
+
+#define BHIOFF (0x28)
+#define BHIOFF_BHIOFF_MASK (0xFFFFFFFF)
+#define BHIOFF_BHIOFF_SHIFT (0)
+
+#define DEBUGOFF (0x30)
+#define DEBUGOFF_DEBUGOFF_MASK (0xFFFFFFFF)
+#define DEBUGOFF_DEBUGOFF_SHIFT (0)
+
+#define MHICTRL (0x38)
+#define MHICTRL_MHISTATE_MASK (0x0000FF00)
+#define MHICTRL_MHISTATE_SHIFT (8)
+#define MHICTRL_RESET_MASK (0x2)
+#define MHICTRL_RESET_SHIFT (1)
+
+#define MHISTATUS (0x48)
+#define MHISTATUS_MHISTATE_MASK (0x0000FF00)
+#define MHISTATUS_MHISTATE_SHIFT (8)
+#define MHISTATUS_SYSERR_MASK (0x4)
+#define MHISTATUS_SYSERR_SHIFT (2)
+#define MHISTATUS_READY_MASK (0x1)
+#define MHISTATUS_READY_SHIFT (0)
+
+#define CCABAP_LOWER (0x58)
+#define CCABAP_LOWER_CCABAP_LOWER_MASK (0xFFFFFFFF)
+#define CCABAP_LOWER_CCABAP_LOWER_SHIFT (0)
+
+#define CCABAP_HIGHER (0x5C)
+#define CCABAP_HIGHER_CCABAP_HIGHER_MASK (0xFFFFFFFF)
+#define CCABAP_HIGHER_CCABAP_HIGHER_SHIFT (0)
+
+#define ECABAP_LOWER (0x60)
+#define ECABAP_LOWER_ECABAP_LOWER_MASK (0xFFFFFFFF)
+#define ECABAP_LOWER_ECABAP_LOWER_SHIFT (0)
+
+#define ECABAP_HIGHER (0x64)
+#define ECABAP_HIGHER_ECABAP_HIGHER_MASK (0xFFFFFFFF)
+#define ECABAP_HIGHER_ECABAP_HIGHER_SHIFT (0)
+
+#define CRCBAP_LOWER (0x68)
+#define CRCBAP_LOWER_CRCBAP_LOWER_MASK (0xFFFFFFFF)
+#define CRCBAP_LOWER_CRCBAP_LOWER_SHIFT (0)
+
+#define CRCBAP_HIGHER (0x6C)
+#define CRCBAP_HIGHER_CRCBAP_HIGHER_MASK (0xFFFFFFFF)
+#define CRCBAP_HIGHER_CRCBAP_HIGHER_SHIFT (0)
+
+#define CRDB_LOWER (0x70)
+#define CRDB_LOWER_CRDB_LOWER_MASK (0xFFFFFFFF)
+#define CRDB_LOWER_CRDB_LOWER_SHIFT (0)
+
+#define CRDB_HIGHER (0x74)
+#define CRDB_HIGHER_CRDB_HIGHER_MASK (0xFFFFFFFF)
+#define CRDB_HIGHER_CRDB_HIGHER_SHIFT (0)
+
+#define MHICTRLBASE_LOWER (0x80)
+#define MHICTRLBASE_LOWER_MHICTRLBASE_LOWER_MASK (0xFFFFFFFF)
+#define MHICTRLBASE_LOWER_MHICTRLBASE_LOWER_SHIFT (0)
+
+#define MHICTRLBASE_HIGHER (0x84)
+#define MHICTRLBASE_HIGHER_MHICTRLBASE_HIGHER_MASK (0xFFFFFFFF)
+#define MHICTRLBASE_HIGHER_MHICTRLBASE_HIGHER_SHIFT (0)
+
+#define MHICTRLLIMIT_LOWER (0x88)
+#define MHICTRLLIMIT_LOWER_MHICTRLLIMIT_LOWER_MASK (0xFFFFFFFF)
+#define MHICTRLLIMIT_LOWER_MHICTRLLIMIT_LOWER_SHIFT (0)
+
+#define MHICTRLLIMIT_HIGHER (0x8C)
+#define MHICTRLLIMIT_HIGHER_MHICTRLLIMIT_HIGHER_MASK (0xFFFFFFFF)
+#define MHICTRLLIMIT_HIGHER_MHICTRLLIMIT_HIGHER_SHIFT (0)
+
+#define MHIDATABASE_LOWER (0x98)
+#define MHIDATABASE_LOWER_MHIDATABASE_LOWER_MASK (0xFFFFFFFF)
+#define MHIDATABASE_LOWER_MHIDATABASE_LOWER_SHIFT (0)
+
+#define MHIDATABASE_HIGHER (0x9C)
+#define MHIDATABASE_HIGHER_MHIDATABASE_HIGHER_MASK (0xFFFFFFFF)
+#define MHIDATABASE_HIGHER_MHIDATABASE_HIGHER_SHIFT (0)
+
+#define MHIDATALIMIT_LOWER (0xA0)
+#define MHIDATALIMIT_LOWER_MHIDATALIMIT_LOWER_MASK (0xFFFFFFFF)
+#define MHIDATALIMIT_LOWER_MHIDATALIMIT_LOWER_SHIFT (0)
+
+#define MHIDATALIMIT_HIGHER (0xA4)
+#define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_MASK (0xFFFFFFFF)
+#define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_SHIFT (0)
+
+/* MHI BHI offfsets */
+#define BHI_BHIVERSION_MINOR (0x00)
+#define BHI_BHIVERSION_MAJOR (0x04)
+#define BHI_IMGADDR_LOW (0x08)
+#define BHI_IMGADDR_HIGH (0x0C)
+#define BHI_IMGSIZE (0x10)
+#define BHI_RSVD1 (0x14)
+#define BHI_IMGTXDB (0x18)
+#define BHI_TXDB_SEQNUM_BMSK (0x3FFFFFFF)
+#define BHI_TXDB_SEQNUM_SHFT (0)
+#define BHI_RSVD2 (0x1C)
+#define BHI_INTVEC (0x20)
+#define BHI_RSVD3 (0x24)
+#define BHI_EXECENV (0x28)
+#define BHI_STATUS (0x2C)
+#define BHI_ERRCODE (0x30)
+#define BHI_ERRDBG1 (0x34)
+#define BHI_ERRDBG2 (0x38)
+#define BHI_ERRDBG3 (0x3C)
+#define BHI_SERIALNU (0x40)
+#define BHI_SBLANTIROLLVER (0x44)
+#define BHI_NUMSEG (0x48)
+#define BHI_MSMHWID(n) (0x4C + (0x4 * n))
+#define BHI_OEMPKHASH(n) (0x64 + (0x4 * n))
+#define BHI_RSVD5 (0xC4)
+#define BHI_STATUS_MASK (0xC0000000)
+#define BHI_STATUS_SHIFT (30)
+#define BHI_STATUS_ERROR (3)
+#define BHI_STATUS_SUCCESS (2)
+#define BHI_STATUS_RESET (0)
+
+/* MHI BHIE offsets */
+#define BHIE_OFFSET (0x0124) /* BHIE register space offset from BHI base */
+#define BHIE_MSMSOCID_OFFS (BHIE_OFFSET + 0x0000)
+#define BHIE_TXVECADDR_LOW_OFFS (BHIE_OFFSET + 0x002C)
+#define BHIE_TXVECADDR_HIGH_OFFS (BHIE_OFFSET + 0x0030)
+#define BHIE_TXVECSIZE_OFFS (BHIE_OFFSET + 0x0034)
+#define BHIE_TXVECDB_OFFS (BHIE_OFFSET + 0x003C)
+#define BHIE_TXVECDB_SEQNUM_BMSK (0x3FFFFFFF)
+#define BHIE_TXVECDB_SEQNUM_SHFT (0)
+#define BHIE_TXVECSTATUS_OFFS (BHIE_OFFSET + 0x0044)
+#define BHIE_TXVECSTATUS_SEQNUM_BMSK (0x3FFFFFFF)
+#define BHIE_TXVECSTATUS_SEQNUM_SHFT (0)
+#define BHIE_TXVECSTATUS_STATUS_BMSK (0xC0000000)
+#define BHIE_TXVECSTATUS_STATUS_SHFT (30)
+#define BHIE_TXVECSTATUS_STATUS_RESET (0x00)
+#define BHIE_TXVECSTATUS_STATUS_XFER_COMPL (0x02)
+#define BHIE_TXVECSTATUS_STATUS_ERROR (0x03)
+#define BHIE_RXVECADDR_LOW_OFFS (BHIE_OFFSET + 0x0060)
+#define BHIE_RXVECADDR_HIGH_OFFS (BHIE_OFFSET + 0x0064)
+#define BHIE_RXVECSIZE_OFFS (BHIE_OFFSET + 0x0068)
+#define BHIE_RXVECDB_OFFS (BHIE_OFFSET + 0x0070)
+#define BHIE_RXVECDB_SEQNUM_BMSK (0x3FFFFFFF)
+#define BHIE_RXVECDB_SEQNUM_SHFT (0)
+#define BHIE_RXVECSTATUS_OFFS (BHIE_OFFSET + 0x0078)
+#define BHIE_RXVECSTATUS_SEQNUM_BMSK (0x3FFFFFFF)
+#define BHIE_RXVECSTATUS_SEQNUM_SHFT (0)
+#define BHIE_RXVECSTATUS_STATUS_BMSK (0xC0000000)
+#define BHIE_RXVECSTATUS_STATUS_SHFT (30)
+#define BHIE_RXVECSTATUS_STATUS_RESET (0x00)
+#define BHIE_RXVECSTATUS_STATUS_XFER_COMPL (0x02)
+#define BHIE_RXVECSTATUS_STATUS_ERROR (0x03)
+
+struct __packed mhi_event_ctxt {
+	u32 reserved : 8;
+	u32 intmodc : 8;
+	u32 intmodt : 16;
+	u32 ertype;
+	u32 msivec;
+	u64 rbase;
+	u64 rlen;
+	u64 rp;
+	u64 wp;
+};
+
+struct __packed mhi_chan_ctxt {
+	u32 chstate : 8;
+	u32 brstmode : 2;
+	u32 pollcfg : 6;
+	u32 reserved : 16;
+	u32 chtype;
+	u32 erindex;
+	u64 rbase;
+	u64 rlen;
+	u64 rp;
+	u64 wp;
+};
+
+struct __packed mhi_cmd_ctxt {
+	u32 reserved0;
+	u32 reserved1;
+	u32 reserved2;
+	u64 rbase;
+	u64 rlen;
+	u64 rp;
+	u64 wp;
+};
+
+struct __packed mhi_tre {
+	u64 ptr;
+	u32 dword[2];
+};
+
+struct __packed bhi_vec_entry {
+	u64 dma_addr;
+	u64 size;
+};
+
+/* no operation command */
+#define MHI_TRE_CMD_NOOP_PTR (0)
+#define MHI_TRE_CMD_NOOP_DWORD0 (0)
+#define MHI_TRE_CMD_NOOP_DWORD1 (1 << 16)
+
+/* channel reset command */
+#define MHI_TRE_CMD_RESET_PTR (0)
+#define MHI_TRE_CMD_RESET_DWORD0 (0)
+#define MHI_TRE_CMD_RESET_DWORD1(chid) ((chid << 24) | (16 << 16))
+
+/* channel stop command */
+#define MHI_TRE_CMD_STOP_PTR (0)
+#define MHI_TRE_CMD_STOP_DWORD0 (0)
+#define MHI_TRE_CMD_STOP_DWORD1(chid) ((chid << 24) | (17 << 16))
+
+/* channel start command */
+#define MHI_TRE_CMD_START_PTR (0)
+#define MHI_TRE_CMD_START_DWORD0 (0)
+#define MHI_TRE_CMD_START_DWORD1(chid) ((chid << 24) | (18 << 16))
+
+#define MHI_TRE_GET_CMD_CHID(tre) (((tre)->dword[1] >> 24) & 0xFF)
+
+/* event descriptor macros */
+#define MHI_TRE_EV_PTR(ptr) (ptr)
+#define MHI_TRE_EV_DWORD0(code, len) ((code << 24) | len)
+#define MHI_TRE_EV_DWORD1(chid, type) ((chid << 24) | (type << 16))
+#define MHI_TRE_GET_EV_PTR(tre) ((tre)->ptr)
+#define MHI_TRE_GET_EV_CODE(tre) (((tre)->dword[0] >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_LEN(tre) ((tre)->dword[0] & 0xFFFF)
+#define MHI_TRE_GET_EV_CHID(tre) (((tre)->dword[1] >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_TYPE(tre) (((tre)->dword[1] >> 16) & 0xFF)
+#define MHI_TRE_GET_EV_STATE(tre) (((tre)->dword[0] >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_EXECENV(tre) (((tre)->dword[0] >> 24) & 0xFF)
+
+
+/* transfer descriptor macros */
+#define MHI_TRE_DATA_PTR(ptr) (ptr)
+#define MHI_TRE_DATA_DWORD0(len) (len & MHI_MAX_MTU)
+#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) ((2 << 16) | (bei << 10) \
+	| (ieot << 9) | (ieob << 8) | chain)
+
+enum MHI_CMD {
+	MHI_CMD_NOOP = 0x0,
+	MHI_CMD_RESET_CHAN = 0x1,
+	MHI_CMD_STOP_CHAN = 0x2,
+	MHI_CMD_START_CHAN = 0x3,
+	MHI_CMD_RESUME_CHAN = 0x4,
+};
+
+enum MHI_PKT_TYPE {
+	MHI_PKT_TYPE_INVALID = 0x0,
+	MHI_PKT_TYPE_NOOP_CMD = 0x1,
+	MHI_PKT_TYPE_TRANSFER = 0x2,
+	MHI_PKT_TYPE_RESET_CHAN_CMD = 0x10,
+	MHI_PKT_TYPE_STOP_CHAN_CMD = 0x11,
+	MHI_PKT_TYPE_START_CHAN_CMD = 0x12,
+	MHI_PKT_TYPE_STATE_CHANGE_EVENT = 0x20,
+	MHI_PKT_TYPE_CMD_COMPLETION_EVENT = 0x21,
+	MHI_PKT_TYPE_TX_EVENT = 0x22,
+	MHI_PKT_TYPE_EE_EVENT = 0x40,
+	MHI_PKT_TYPE_STALE_EVENT, /* internal event */
+};
+
+/* MHI transfer completion events */
+enum MHI_EV_CCS {
+	MHI_EV_CC_INVALID = 0x0,
+	MHI_EV_CC_SUCCESS = 0x1,
+	MHI_EV_CC_EOT = 0x2,
+	MHI_EV_CC_OVERFLOW = 0x3,
+	MHI_EV_CC_EOB = 0x4,
+	MHI_EV_CC_OOB = 0x5,
+	MHI_EV_CC_DB_MODE = 0x6,
+	MHI_EV_CC_UNDEFINED_ERR = 0x10,
+	MHI_EV_CC_BAD_TRE = 0x11,
+};
+
+enum MHI_CH_STATE {
+	MHI_CH_STATE_DISABLED = 0x0,
+	MHI_CH_STATE_ENABLED = 0x1,
+	MHI_CH_STATE_RUNNING = 0x2,
+	MHI_CH_STATE_SUSPENDED = 0x3,
+	MHI_CH_STATE_STOP = 0x4,
+	MHI_CH_STATE_ERROR = 0x5,
+};
+
+enum MHI_CH_CFG {
+	MHI_CH_CFG_CHAN_ID = 0,
+	MHI_CH_CFG_ELEMENTS = 1,
+	MHI_CH_CFG_ER_INDEX = 2,
+	MHI_CH_CFG_DIRECTION = 3,
+	MHI_CH_CFG_BRSTMODE = 4,
+	MHI_CH_CFG_POLLCFG = 5,
+	MHI_CH_CFG_EE = 6,
+	MHI_CH_CFG_XFER_TYPE = 7,
+	MHI_CH_CFG_BITCFG = 8,
+	MHI_CH_CFG_MAX
+};
+
+#define MHI_CH_CFG_BIT_LPM_NOTIFY BIT(0) /* require LPM notification */
+#define MHI_CH_CFG_BIT_OFFLOAD_CH BIT(1) /* satellite mhi devices */
+#define MHI_CH_CFG_BIT_DBMODE_RESET_CH BIT(2) /* require db mode to reset */
+#define MHI_CH_CFG_BIT_PRE_ALLOC BIT(3) /* host allocate buffers for DL */
+
+enum MHI_EV_CFG {
+	MHI_EV_CFG_ELEMENTS = 0,
+	MHI_EV_CFG_INTMOD = 1,
+	MHI_EV_CFG_MSI = 2,
+	MHI_EV_CFG_CHAN = 3,
+	MHI_EV_CFG_PRIORITY = 4,
+	MHI_EV_CFG_BRSTMODE = 5,
+	MHI_EV_CFG_BITCFG = 6,
+	MHI_EV_CFG_MAX
+};
+
+#define MHI_EV_CFG_BIT_HW_EV BIT(0) /* hw event ring */
+#define MHI_EV_CFG_BIT_CL_MANAGE BIT(1) /* client manages the event ring */
+#define MHI_EV_CFG_BIT_OFFLOAD_EV BIT(2) /* satellite driver manges it */
+#define MHI_EV_CFG_BIT_CTRL_EV BIT(3) /* ctrl event ring */
+
+enum MHI_BRSTMODE {
+	MHI_BRSTMODE_DISABLE = 0x2,
+	MHI_BRSTMODE_ENABLE = 0x3,
+};
+
+#define MHI_INVALID_BRSTMODE(mode) (mode != MHI_BRSTMODE_DISABLE && \
+				    mode != MHI_BRSTMODE_ENABLE)
+
+enum MHI_EE {
+	MHI_EE_PBL = 0x0,
+	MHI_EE_SBL = 0x1,
+	MHI_EE_AMSS = 0x2,
+	MHI_EE_BHIE = 0x3,
+	MHI_EE_RDDM = 0x4,
+	MHI_EE_PTHRU = 0x5,
+	MHI_EE_EDL = 0x6,
+	MHI_EE_MAX_SUPPORTED = MHI_EE_EDL,
+	MHI_EE_DISABLE_TRANSITION, /* local EE, not related to mhi spec */
+	MHI_EE_MAX,
+};
+
+extern const char * const mhi_ee_str[MHI_EE_MAX];
+#define TO_MHI_EXEC_STR(ee) (((ee) >= MHI_EE_MAX) ? \
+			     "INVALID_EE" : mhi_ee_str[ee])
+
+#define MHI_IN_PBL(ee) (ee == MHI_EE_PBL || ee == MHI_EE_PTHRU || \
+			ee == MHI_EE_EDL)
+
+enum MHI_ST_TRANSITION {
+	MHI_ST_TRANSITION_PBL,
+	MHI_ST_TRANSITION_READY,
+	MHI_ST_TRANSITION_SBL,
+	MHI_ST_TRANSITION_AMSS,
+	MHI_ST_TRANSITION_BHIE,
+	MHI_ST_TRANSITION_MAX,
+};
+
+extern const char * const mhi_state_tran_str[MHI_ST_TRANSITION_MAX];
+#define TO_MHI_STATE_TRANS_STR(state) (((state) >= MHI_ST_TRANSITION_MAX) ? \
+				"INVALID_STATE" : mhi_state_tran_str[state])
+
+enum MHI_STATE {
+	MHI_STATE_RESET = 0x0,
+	MHI_STATE_READY = 0x1,
+	MHI_STATE_M0 = 0x2,
+	MHI_STATE_M1 = 0x3,
+	MHI_STATE_M2 = 0x4,
+	MHI_STATE_M3 = 0x5,
+	MHI_STATE_BHI  = 0x7,
+	MHI_STATE_SYS_ERR  = 0xFF,
+	MHI_STATE_MAX,
+};
+
+extern const char * const mhi_state_str[MHI_STATE_MAX];
+#define TO_MHI_STATE_STR(state) ((state >= MHI_STATE_MAX || \
+				  !mhi_state_str[state]) ? \
+				"INVALID_STATE" : mhi_state_str[state])
+
+/* internal power states */
+enum MHI_PM_STATE {
+	MHI_PM_DISABLE = BIT(0), /* MHI is not enabled */
+	MHI_PM_POR = BIT(1), /* reset state */
+	MHI_PM_M0 = BIT(2),
+	MHI_PM_M1 = BIT(3),
+	MHI_PM_M1_M2_TRANSITION = BIT(4), /* register access not allowed */
+	MHI_PM_M2 = BIT(5),
+	MHI_PM_M3_ENTER = BIT(6),
+	MHI_PM_M3 = BIT(7),
+	MHI_PM_M3_EXIT = BIT(8),
+	MHI_PM_FW_DL_ERR = BIT(9), /* firmware download failure state */
+	MHI_PM_SYS_ERR_DETECT = BIT(10),
+	MHI_PM_SYS_ERR_PROCESS = BIT(11),
+	MHI_PM_SHUTDOWN_PROCESS = BIT(12),
+	MHI_PM_LD_ERR_FATAL_DETECT = BIT(13), /* link not accessible */
+};
+
+#define MHI_REG_ACCESS_VALID(pm_state) ((pm_state & (MHI_PM_POR | MHI_PM_M0 | \
+		MHI_PM_M1 | MHI_PM_M2 | MHI_PM_M3_ENTER | MHI_PM_M3_EXIT | \
+		MHI_PM_SYS_ERR_DETECT | MHI_PM_SYS_ERR_PROCESS | \
+		MHI_PM_SHUTDOWN_PROCESS | MHI_PM_FW_DL_ERR)))
+#define MHI_PM_IN_ERROR_STATE(pm_state) (pm_state >= MHI_PM_FW_DL_ERR)
+#define MHI_PM_IN_FATAL_STATE(pm_state) (pm_state == MHI_PM_LD_ERR_FATAL_DETECT)
+#define MHI_DB_ACCESS_VALID(pm_state) (pm_state & (MHI_PM_M0 | MHI_PM_M1))
+#define MHI_WAKE_DB_ACCESS_VALID(pm_state) (pm_state & (MHI_PM_M0 | \
+							MHI_PM_M1 | MHI_PM_M2))
+#define MHI_EVENT_ACCESS_INVALID(pm_state) (pm_state == MHI_PM_DISABLE || \
+					    MHI_PM_IN_ERROR_STATE(pm_state))
+#define MHI_PM_IN_SUSPEND_STATE(pm_state) (pm_state & \
+					   (MHI_PM_M3_ENTER | MHI_PM_M3))
+
+/* accepted buffer type for the channel */
+enum MHI_XFER_TYPE {
+	MHI_XFER_BUFFER,
+	MHI_XFER_SKB,
+	MHI_XFER_SCLIST,
+	MHI_XFER_NOP, /* CPU offload channel, host does not accept transfer */
+};
+
+#define NR_OF_CMD_RINGS (1)
+#define CMD_EL_PER_RING (128)
+#define PRIMARY_CMD_RING (0)
+#define MHI_DEV_WAKE_DB (127)
+#define MHI_M2_DEBOUNCE_TMR_US (10000)
+#define MHI_MAX_MTU (0xffff)
+
+enum MHI_ER_TYPE {
+	MHI_ER_TYPE_INVALID = 0x0,
+	MHI_ER_TYPE_VALID = 0x1,
+};
+
+struct db_cfg {
+	bool reset_req;
+	bool db_mode;
+	u32 pollcfg;
+	enum MHI_BRSTMODE brstmode;
+	dma_addr_t db_val;
+	void (*process_db)(struct mhi_controller *mhi_cntrl,
+			   struct db_cfg *db_cfg, void __iomem *io_addr,
+			   dma_addr_t db_val);
+};
+
+struct mhi_pm_transitions {
+	enum MHI_PM_STATE from_state;
+	u32 to_states;
+};
+
+struct state_transition {
+	struct list_head node;
+	enum MHI_ST_TRANSITION state;
+};
+
+struct mhi_ctxt {
+	struct mhi_event_ctxt *er_ctxt;
+	struct mhi_chan_ctxt *chan_ctxt;
+	struct mhi_cmd_ctxt *cmd_ctxt;
+	dma_addr_t er_ctxt_addr;
+	dma_addr_t chan_ctxt_addr;
+	dma_addr_t cmd_ctxt_addr;
+};
+
+struct mhi_ring {
+	dma_addr_t dma_handle;
+	dma_addr_t iommu_base;
+	u64 *ctxt_wp; /* point to ctxt wp */
+	void *pre_aligned;
+	void *base;
+	void *rp;
+	void *wp;
+	size_t el_size;
+	size_t len;
+	size_t elements;
+	size_t alloc_size;
+	void __iomem *db_addr;
+};
+
+struct mhi_cmd {
+	struct mhi_ring ring;
+	spinlock_t lock;
+};
+
+struct mhi_buf_info {
+	dma_addr_t p_addr;
+	void *v_addr;
+	void *wp;
+	size_t len;
+	void *cb_buf;
+	enum dma_data_direction dir;
+};
+
+struct mhi_event {
+	u32 er_index;
+	u32 intmod;
+	u32 msi;
+	int chan; /* this event ring is dedicated to a channel */
+	u32 priority;
+	struct mhi_ring ring;
+	struct db_cfg db_cfg;
+	bool hw_ring;
+	bool cl_manage;
+	bool offload_ev; /* managed by a device driver */
+	bool ctrl_ev;
+	spinlock_t lock;
+	struct mhi_chan *mhi_chan; /* dedicated to channel */
+	struct tasklet_struct task;
+	struct mhi_controller *mhi_cntrl;
+};
+
+struct mhi_chan {
+	u32 chan;
+	const char *name;
+	/*
+	 * important, when consuming increment tre_ring first, when releasing
+	 * decrement buf_ring first. If tre_ring has space, buf_ring
+	 * guranteed to have space so we do not need to check both rings.
+	 */
+	struct mhi_ring buf_ring;
+	struct mhi_ring tre_ring;
+	u32 er_index;
+	u32 intmod;
+	u32 tiocm;
+	enum dma_data_direction dir;
+	struct db_cfg db_cfg;
+	enum MHI_EE ee;
+	enum MHI_XFER_TYPE xfer_type;
+	enum MHI_CH_STATE ch_state;
+	enum MHI_EV_CCS ccs;
+	bool lpm_notify;
+	bool configured;
+	bool offload_ch;
+	bool pre_alloc;
+	/* functions that generate the transfer ring elements */
+	int (*gen_tre)(struct mhi_controller *mhi_cntrl,
+		       struct mhi_chan *mhi_chan, void *buf, void *cb,
+		       size_t len, enum MHI_FLAGS flags);
+	int (*queue_xfer)(struct mhi_device *mhi_dev, struct mhi_chan *mhi_chan,
+			  void *buf, size_t len, enum MHI_FLAGS flags);
+	/* xfer call back */
+	struct mhi_device *mhi_dev;
+	void (*xfer_cb)(struct mhi_device *mhi_dev, struct mhi_result *res);
+	struct mutex mutex;
+	struct completion completion;
+	rwlock_t lock;
+	struct list_head node;
+};
+
+struct mhi_bus {
+	struct list_head controller_list;
+	struct mutex lock;
+	struct dentry *dentry;
+};
+
+/* default MHI timeout */
+#define MHI_TIMEOUT_MS (1000)
+extern struct mhi_bus mhi_bus;
+
+/* debug fs related functions */
+int mhi_debugfs_mhi_chan_show(struct seq_file *m, void *d);
+int mhi_debugfs_mhi_event_show(struct seq_file *m, void *d);
+int mhi_debugfs_mhi_states_show(struct seq_file *m, void *d);
+int mhi_debugfs_trigger_reset(void *data, u64 val);
+
+void mhi_deinit_debugfs(struct mhi_controller *mhi_cntrl);
+void mhi_init_debugfs(struct mhi_controller *mhi_cntrl);
+
+/* power management apis */
+enum MHI_PM_STATE __must_check mhi_tryset_pm_state(
+					struct mhi_controller *mhi_cntrl,
+					enum MHI_PM_STATE state);
+const char *to_mhi_pm_state_str(enum MHI_PM_STATE state);
+void mhi_reset_chan(struct mhi_controller *mhi_cntrl,
+		    struct mhi_chan *mhi_chan);
+enum MHI_EE mhi_get_exec_env(struct mhi_controller *mhi_cntrl);
+enum MHI_STATE mhi_get_m_state(struct mhi_controller *mhi_cntrl);
+int mhi_queue_state_transition(struct mhi_controller *mhi_cntrl,
+			       enum MHI_ST_TRANSITION state);
+void mhi_pm_st_worker(struct work_struct *work);
+void mhi_fw_load_worker(struct work_struct *work);
+void mhi_pm_m1_worker(struct work_struct *work);
+void mhi_pm_sys_err_worker(struct work_struct *work);
+int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl);
+void mhi_ctrl_ev_task(unsigned long data);
+int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl);
+void mhi_pm_m1_transition(struct mhi_controller *mhi_cntrl);
+int mhi_pm_m3_transition(struct mhi_controller *mhi_cntrl);
+void mhi_notify(struct mhi_device *mhi_dev, enum MHI_CB cb_reason);
+
+/* queue transfer buffer */
+int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
+		void *buf, void *cb, size_t buf_len, enum MHI_FLAGS flags);
+int mhi_queue_buf(struct mhi_device *mhi_dev, struct mhi_chan *mhi_chan,
+		  void *buf, size_t len, enum MHI_FLAGS mflags);
+int mhi_queue_skb(struct mhi_device *mhi_dev, struct mhi_chan *mhi_chan,
+		  void *buf, size_t len, enum MHI_FLAGS mflags);
+int mhi_queue_sclist(struct mhi_device *mhi_dev, struct mhi_chan *mhi_chan,
+		  void *buf, size_t len, enum MHI_FLAGS mflags);
+int mhi_queue_nop(struct mhi_device *mhi_dev, struct mhi_chan *mhi_chan,
+		  void *buf, size_t len, enum MHI_FLAGS mflags);
+
+
+/* register access methods */
+void mhi_db_brstmode(struct mhi_controller *mhi_cntrl, struct db_cfg *db_cfg,
+		     void __iomem *db_addr, dma_addr_t wp);
+void mhi_db_brstmode_disable(struct mhi_controller *mhi_cntrl,
+			     struct db_cfg *db_mode, void __iomem *db_addr,
+			     dma_addr_t wp);
+int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
+			      void __iomem *base, u32 offset, u32 *out);
+int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
+				    void __iomem *base, u32 offset, u32 mask,
+				    u32 shift, u32 *out);
+void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
+		   u32 offset, u32 val);
+void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void __iomem *base,
+			 u32 offset, u32 mask, u32 shift, u32 val);
+void mhi_ring_er_db(struct mhi_event *mhi_event);
+void mhi_write_db(struct mhi_controller *mhi_cntrl, void __iomem *db_addr,
+		  dma_addr_t wp);
+void mhi_ring_cmd_db(struct mhi_controller *mhi_cntrl, struct mhi_cmd *mhi_cmd);
+void mhi_ring_chan_db(struct mhi_controller *mhi_cntrl,
+		      struct mhi_chan *mhi_chan);
+void mhi_set_mhi_state(struct mhi_controller *mhi_cntrl, enum MHI_STATE state);
+
+/* memory allocation methods */
+static inline void *mhi_alloc_coherent(struct mhi_controller *mhi_cntrl,
+				       size_t size,
+				       dma_addr_t *dma_handle,
+				       gfp_t gfp)
+{
+	void *buf = dma_zalloc_coherent(mhi_cntrl->dev, size, dma_handle, gfp);
+
+	if (buf)
+		atomic_add(size, &mhi_cntrl->alloc_size);
+
+	return buf;
+}
+static inline void mhi_free_coherent(struct mhi_controller *mhi_cntrl,
+				     size_t size,
+				     void *vaddr,
+				     dma_addr_t dma_handle)
+{
+	atomic_sub(size, &mhi_cntrl->alloc_size);
+	dma_free_coherent(mhi_cntrl->dev, size, vaddr, dma_handle);
+}
+struct mhi_device *mhi_alloc_device(struct mhi_controller *mhi_cntrl);
+static inline void mhi_dealloc_device(struct mhi_controller *mhi_cntrl,
+				      struct mhi_device *mhi_dev)
+{
+	kfree(mhi_dev);
+}
+int mhi_destroy_device(struct device *dev, void *data);
+void mhi_create_devices(struct mhi_controller *mhi_cntrl);
+int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
+			 struct image_info **image_info, size_t alloc_size);
+void mhi_free_bhie_table(struct mhi_controller *mhi_cntrl,
+			 struct image_info *image_info);
+
+/* initialization methods */
+int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
+		       struct mhi_chan *mhi_chan);
+void mhi_deinit_chan_ctxt(struct mhi_controller *mhi_cntrl,
+			  struct mhi_chan *mhi_chan);
+int mhi_init_mmio(struct mhi_controller *mhi_cntrl);
+int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl);
+void mhi_deinit_dev_ctxt(struct mhi_controller *mhi_cntrl);
+int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl);
+void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl);
+int mhi_dtr_init(void);
+
+/* isr handlers */
+irqreturn_t mhi_msi_handlr(int irq_number, void *dev);
+irqreturn_t mhi_intvec_threaded_handlr(int irq_number, void *dev);
+irqreturn_t mhi_intvec_handlr(int irq_number, void *dev);
+void mhi_ev_task(unsigned long data);
+
+#ifdef CONFIG_MHI_DEBUG
+
+#define MHI_ASSERT(cond, msg) do { \
+	if (cond) \
+		panic(msg); \
+} while (0)
+
+#else
+
+#define MHI_ASSERT(cond, msg) do { \
+	if (cond) { \
+		MHI_ERR(msg); \
+		WARN_ON(cond); \
+	} \
+} while (0)
+
+#endif
+
+#endif /* _MHI_INT_H */
diff --git a/drivers/bus/mhi/core/mhi_main.c b/drivers/bus/mhi/core/mhi_main.c
new file mode 100644
index 0000000..761c060
--- /dev/null
+++ b/drivers/bus/mhi/core/mhi_main.c
@@ -0,0 +1,1476 @@
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/mhi.h>
+#include "mhi_internal.h"
+
+static void __mhi_unprepare_channel(struct mhi_controller *mhi_cntrl,
+				    struct mhi_chan *mhi_chan);
+
+int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
+			      void __iomem *base,
+			      u32 offset,
+			      u32 *out)
+{
+	u32 tmp = readl_relaxed(base + offset);
+
+	/* unexpected value, query the link status */
+	if (PCI_INVALID_READ(tmp) &&
+	    mhi_cntrl->link_status(mhi_cntrl, mhi_cntrl->priv_data))
+		return -EIO;
+
+	*out = tmp;
+
+	return 0;
+}
+
+int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
+				    void __iomem *base,
+				    u32 offset,
+				    u32 mask,
+				    u32 shift,
+				    u32 *out)
+{
+	u32 tmp;
+	int ret;
+
+	ret = mhi_read_reg(mhi_cntrl, base, offset, &tmp);
+	if (ret)
+		return ret;
+
+	*out = (tmp & mask) >> shift;
+
+	return 0;
+}
+
+void mhi_write_reg(struct mhi_controller *mhi_cntrl,
+		   void __iomem *base,
+		   u32 offset,
+		   u32 val)
+{
+	writel_relaxed(val, base + offset);
+}
+
+void mhi_write_reg_field(struct mhi_controller *mhi_cntrl,
+			 void __iomem *base,
+			 u32 offset,
+			 u32 mask,
+			 u32 shift,
+			 u32 val)
+{
+	int ret;
+	u32 tmp;
+
+	ret = mhi_read_reg(mhi_cntrl, base, offset, &tmp);
+	if (ret)
+		return;
+
+	tmp &= ~mask;
+	tmp |= (val << shift);
+	mhi_write_reg(mhi_cntrl, base, offset, tmp);
+}
+
+void mhi_write_db(struct mhi_controller *mhi_cntrl,
+		  void __iomem *db_addr,
+		  dma_addr_t wp)
+{
+	mhi_write_reg(mhi_cntrl, db_addr, 4, upper_32_bits(wp));
+	mhi_write_reg(mhi_cntrl, db_addr, 0, lower_32_bits(wp));
+}
+
+void mhi_db_brstmode(struct mhi_controller *mhi_cntrl,
+		     struct db_cfg *db_cfg,
+		     void __iomem *db_addr,
+		     dma_addr_t wp)
+{
+	if (db_cfg->db_mode) {
+		db_cfg->db_val = wp;
+		mhi_write_db(mhi_cntrl, db_addr, wp);
+		db_cfg->db_mode = 0;
+	}
+}
+
+void mhi_db_brstmode_disable(struct mhi_controller *mhi_cntrl,
+			     struct db_cfg *db_cfg,
+			     void __iomem *db_addr,
+			     dma_addr_t wp)
+{
+	db_cfg->db_val = wp;
+	mhi_write_db(mhi_cntrl, db_addr, wp);
+}
+
+void mhi_ring_er_db(struct mhi_event *mhi_event)
+{
+	struct mhi_ring *ring = &mhi_event->ring;
+
+	mhi_event->db_cfg.process_db(mhi_event->mhi_cntrl, &mhi_event->db_cfg,
+				     ring->db_addr, *ring->ctxt_wp);
+}
+
+void mhi_ring_cmd_db(struct mhi_controller *mhi_cntrl, struct mhi_cmd *mhi_cmd)
+{
+	dma_addr_t db;
+	struct mhi_ring *ring = &mhi_cmd->ring;
+
+	db = ring->iommu_base + (ring->wp - ring->base);
+	*ring->ctxt_wp = db;
+	mhi_write_db(mhi_cntrl, ring->db_addr, db);
+}
+
+void mhi_ring_chan_db(struct mhi_controller *mhi_cntrl,
+		      struct mhi_chan *mhi_chan)
+{
+	struct mhi_ring *ring = &mhi_chan->tre_ring;
+	dma_addr_t db;
+
+	db = ring->iommu_base + (ring->wp - ring->base);
+	*ring->ctxt_wp = db;
+	mhi_chan->db_cfg.process_db(mhi_cntrl, &mhi_chan->db_cfg, ring->db_addr,
+				    db);
+}
+
+enum MHI_EE mhi_get_exec_env(struct mhi_controller *mhi_cntrl)
+{
+	u32 exec;
+	int ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_EXECENV, &exec);
+
+	return (ret) ? MHI_EE_MAX : exec;
+}
+
+enum MHI_STATE mhi_get_m_state(struct mhi_controller *mhi_cntrl)
+{
+	u32 state;
+	int ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MHISTATUS,
+				     MHISTATUS_MHISTATE_MASK,
+				     MHISTATUS_MHISTATE_SHIFT, &state);
+	return ret ? MHI_STATE_MAX : state;
+}
+
+int mhi_queue_sclist(struct mhi_device *mhi_dev,
+		     struct mhi_chan *mhi_chan,
+		     void *buf,
+		     size_t len,
+		     enum MHI_FLAGS mflags)
+{
+	return -EINVAL;
+}
+
+int mhi_queue_nop(struct mhi_device *mhi_dev,
+		  struct mhi_chan *mhi_chan,
+		  void *buf,
+		  size_t len,
+		  enum MHI_FLAGS mflags)
+{
+	return -EINVAL;
+}
+
+static void mhi_add_ring_element(struct mhi_controller *mhi_cntrl,
+				 struct mhi_ring *ring)
+{
+	ring->wp += ring->el_size;
+	if (ring->wp >= (ring->base + ring->len))
+		ring->wp = ring->base;
+	/* smp update */
+	smp_wmb();
+}
+
+static void mhi_del_ring_element(struct mhi_controller *mhi_cntrl,
+				 struct mhi_ring *ring)
+{
+	ring->rp += ring->el_size;
+	if (ring->rp >= (ring->base + ring->len))
+		ring->rp = ring->base;
+	/* smp update */
+	smp_wmb();
+}
+
+static int get_nr_avail_ring_elements(struct mhi_controller *mhi_cntrl,
+				      struct mhi_ring *ring)
+{
+	int nr_el;
+
+	if (ring->wp < ring->rp)
+		nr_el = ((ring->rp - ring->wp) / ring->el_size) - 1;
+	else {
+		nr_el = (ring->rp - ring->base) / ring->el_size;
+		nr_el += ((ring->base + ring->len - ring->wp) /
+			  ring->el_size) - 1;
+	}
+	return nr_el;
+}
+
+static void *mhi_to_virtual(struct mhi_ring *ring, dma_addr_t addr)
+{
+	return (addr - ring->iommu_base) + ring->base;
+}
+
+dma_addr_t mhi_to_physical(struct mhi_ring *ring, void *addr)
+{
+	return (addr - ring->base) + ring->iommu_base;
+}
+
+static void mhi_recycle_ev_ring_element(struct mhi_controller *mhi_cntrl,
+					struct mhi_ring *ring)
+{
+	dma_addr_t ctxt_wp;
+
+	/* update the WP */
+	ring->wp += ring->el_size;
+	ctxt_wp = *ring->ctxt_wp + ring->el_size;
+
+	if (ring->wp >= (ring->base + ring->len)) {
+		ring->wp = ring->base;
+		ctxt_wp = ring->iommu_base;
+	}
+
+	*ring->ctxt_wp = ctxt_wp;
+
+	/* update the RP */
+	ring->rp += ring->el_size;
+	if (ring->rp >= (ring->base + ring->len))
+		ring->rp = ring->base;
+
+	/* visible to other cores */
+	smp_wmb();
+}
+
+static bool mhi_is_ring_full(struct mhi_controller *mhi_cntrl,
+			     struct mhi_ring *ring)
+{
+	void *tmp = ring->wp + ring->el_size;
+
+	if (tmp >= (ring->base + ring->len))
+		tmp = ring->base;
+
+	return (tmp == ring->rp);
+}
+
+int mhi_queue_skb(struct mhi_device *mhi_dev,
+		  struct mhi_chan *mhi_chan,
+		  void *buf,
+		  size_t len,
+		  enum MHI_FLAGS mflags)
+{
+	struct sk_buff *skb = buf;
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
+	struct mhi_ring *buf_ring = &mhi_chan->buf_ring;
+	struct mhi_buf_info *buf_info;
+	struct mhi_tre *mhi_tre;
+
+	if (mhi_is_ring_full(mhi_cntrl, tre_ring))
+		return -ENOMEM;
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (unlikely(MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))) {
+		MHI_ERR("MHI is not in activate state, pm_state:%s\n",
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+
+		return -EIO;
+	}
+
+	/* we're in M3 or transitioning to M3 */
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state)) {
+		mhi_cntrl->runtime_get(mhi_cntrl, mhi_cntrl->priv_data);
+		mhi_cntrl->runtime_put(mhi_cntrl, mhi_cntrl->priv_data);
+	}
+	mhi_cntrl->wake_get(mhi_cntrl, false);
+
+	/* generate the tre */
+	buf_info = buf_ring->wp;
+	buf_info->v_addr = skb->data;
+	buf_info->cb_buf = skb;
+	buf_info->wp = tre_ring->wp;
+	buf_info->dir = mhi_chan->dir;
+	buf_info->len = len;
+	buf_info->p_addr = dma_map_single(mhi_cntrl->dev, buf_info->v_addr, len,
+					  buf_info->dir);
+
+	if (dma_mapping_error(mhi_cntrl->dev, buf_info->p_addr))
+		goto map_error;
+
+	mhi_tre = tre_ring->wp;
+	mhi_tre->ptr = MHI_TRE_DATA_PTR(buf_info->p_addr);
+	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(buf_info->len);
+	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(1, 1, 0, 0);
+
+	MHI_VERB("chan:%d WP:0x%llx TRE:0x%llx 0x%08x 0x%08x\n", mhi_chan->chan,
+		 (u64)mhi_to_physical(tre_ring, mhi_tre), mhi_tre->ptr,
+		 mhi_tre->dword[0], mhi_tre->dword[1]);
+
+	/* increment WP */
+	mhi_add_ring_element(mhi_cntrl, tre_ring);
+	mhi_add_ring_element(mhi_cntrl, buf_ring);
+
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl->pm_state))) {
+		read_lock_bh(&mhi_chan->lock);
+		mhi_ring_chan_db(mhi_cntrl, mhi_chan);
+		read_unlock_bh(&mhi_chan->lock);
+	}
+
+	if (mhi_chan->dir == DMA_FROM_DEVICE) {
+		bool override = (mhi_cntrl->pm_state != MHI_PM_M0);
+
+		mhi_cntrl->wake_put(mhi_cntrl, override);
+	}
+
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return 0;
+
+map_error:
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return -ENOMEM;
+}
+
+int mhi_gen_tre(struct mhi_controller *mhi_cntrl,
+		struct mhi_chan *mhi_chan,
+		void *buf,
+		void *cb,
+		size_t buf_len,
+		enum MHI_FLAGS flags)
+{
+	struct mhi_ring *buf_ring, *tre_ring;
+	struct mhi_tre *mhi_tre;
+	struct mhi_buf_info *buf_info;
+	int eot, eob, chain, bei;
+
+	buf_ring = &mhi_chan->buf_ring;
+	tre_ring = &mhi_chan->tre_ring;
+
+	buf_info = buf_ring->wp;
+	buf_info->v_addr = buf;
+	buf_info->cb_buf = cb;
+	buf_info->wp = tre_ring->wp;
+	buf_info->dir = mhi_chan->dir;
+	buf_info->len = buf_len;
+	buf_info->p_addr = dma_map_single(mhi_cntrl->dev, buf, buf_len,
+					  buf_info->dir);
+
+	if (dma_mapping_error(mhi_cntrl->dev, buf_info->p_addr))
+		return -ENOMEM;
+
+	eob = !!(flags & MHI_EOB);
+	eot = !!(flags & MHI_EOT);
+	chain = !!(flags & MHI_CHAIN);
+	bei = !!(mhi_chan->intmod);
+
+	mhi_tre = tre_ring->wp;
+	mhi_tre->ptr = MHI_TRE_DATA_PTR(buf_info->p_addr);
+	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(buf_len);
+	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(bei, eot, eob, chain);
+
+	MHI_VERB("chan:%d WP:0x%llx TRE:0x%llx 0x%08x 0x%08x\n", mhi_chan->chan,
+		 (u64)mhi_to_physical(tre_ring, mhi_tre), mhi_tre->ptr,
+		 mhi_tre->dword[0], mhi_tre->dword[1]);
+
+	/* increment WP */
+	mhi_add_ring_element(mhi_cntrl, tre_ring);
+	mhi_add_ring_element(mhi_cntrl, buf_ring);
+
+	return 0;
+}
+
+int mhi_queue_buf(struct mhi_device *mhi_dev,
+		  struct mhi_chan *mhi_chan,
+		  void *buf,
+		  size_t len,
+		  enum MHI_FLAGS mflags)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_ring *tre_ring;
+	unsigned long flags;
+	int ret;
+
+	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
+	if (unlikely(MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))) {
+		MHI_ERR("MHI is not in active state, pm_state:%s\n",
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
+
+		return -EIO;
+	}
+
+	/* we're in M3 or transitioning to M3 */
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state)) {
+		mhi_cntrl->runtime_get(mhi_cntrl, mhi_cntrl->priv_data);
+		mhi_cntrl->runtime_put(mhi_cntrl, mhi_cntrl->priv_data);
+	}
+
+	mhi_cntrl->wake_get(mhi_cntrl, false);
+	read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
+
+	tre_ring = &mhi_chan->tre_ring;
+	if (mhi_is_ring_full(mhi_cntrl, tre_ring))
+		goto error_queue;
+
+	ret = mhi_chan->gen_tre(mhi_cntrl, mhi_chan, buf, buf, len, mflags);
+	if (unlikely(ret))
+		goto error_queue;
+
+	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl->pm_state))) {
+		unsigned long flags;
+
+		read_lock_irqsave(&mhi_chan->lock, flags);
+		mhi_ring_chan_db(mhi_cntrl, mhi_chan);
+		read_unlock_irqrestore(&mhi_chan->lock, flags);
+	}
+
+	if (mhi_chan->dir == DMA_FROM_DEVICE) {
+		bool override = (mhi_cntrl->pm_state != MHI_PM_M0);
+
+		mhi_cntrl->wake_put(mhi_cntrl, override);
+	}
+
+	read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
+
+	return 0;
+
+error_queue:
+	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
+
+	return -ENOMEM;
+}
+
+/* destroy specific device */
+int mhi_destroy_device(struct device *dev, void *data)
+{
+	struct mhi_device *mhi_dev;
+	struct mhi_driver *mhi_drv;
+	struct mhi_controller *mhi_cntrl;
+	struct mhi_chan *mhi_chan;
+	int dir;
+
+	if (dev->bus != &mhi_bus_type)
+		return 0;
+
+	mhi_dev = to_mhi_device(dev);
+	mhi_drv = to_mhi_driver(dev->driver);
+	mhi_cntrl = mhi_dev->mhi_cntrl;
+
+	MHI_LOG("destroy device for chan:%s\n", mhi_dev->chan_name);
+
+	for (dir = 0; dir < 2; dir++) {
+		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
+
+		if (!mhi_chan)
+			continue;
+
+		/* remove device associated with the channel */
+		mutex_lock(&mhi_chan->mutex);
+		mhi_chan->mhi_dev = NULL;
+		mutex_unlock(&mhi_chan->mutex);
+	}
+
+	/* notify the client and remove the device from mhi bus */
+	device_del(dev);
+	put_device(dev);
+
+	return 0;
+}
+
+void mhi_notify(struct mhi_device *mhi_dev, enum MHI_CB cb_reason)
+{
+	struct mhi_driver *mhi_drv;
+
+	if (!mhi_dev->dev.driver)
+		return;
+
+	mhi_drv = to_mhi_driver(mhi_dev->dev.driver);
+
+	if (mhi_drv->status_cb)
+		mhi_drv->status_cb(mhi_dev, cb_reason);
+}
+
+/* bind mhi channels into mhi devices */
+void mhi_create_devices(struct mhi_controller *mhi_cntrl)
+{
+	int i;
+	struct mhi_chan *mhi_chan;
+	struct mhi_device *mhi_dev;
+	struct device_node *controller, *node;
+	const char *dt_name;
+	int ret;
+
+	mhi_chan = mhi_cntrl->mhi_chan;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
+		if (!mhi_chan->configured || mhi_chan->ee != mhi_cntrl->ee)
+			continue;
+		mhi_dev = mhi_alloc_device(mhi_cntrl);
+		if (!mhi_dev)
+			return;
+
+		if (mhi_chan->dir == DMA_TO_DEVICE) {
+			mhi_dev->ul_chan = mhi_chan;
+			mhi_dev->ul_chan_id = mhi_chan->chan;
+			mhi_dev->ul_xfer = mhi_chan->queue_xfer;
+			mhi_dev->ul_event_id = mhi_chan->er_index;
+		} else {
+			mhi_dev->dl_chan = mhi_chan;
+			mhi_dev->dl_chan_id = mhi_chan->chan;
+			mhi_dev->dl_xfer = mhi_chan->queue_xfer;
+			mhi_dev->dl_event_id = mhi_chan->er_index;
+		}
+
+		mhi_chan->mhi_dev = mhi_dev;
+
+		/* check next channel if it matches */
+		if ((i + 1) < mhi_cntrl->max_chan && mhi_chan[1].configured) {
+			if (!strcmp(mhi_chan[1].name, mhi_chan->name)) {
+				i++;
+				mhi_chan++;
+				if (mhi_chan->dir == DMA_TO_DEVICE) {
+					mhi_dev->ul_chan = mhi_chan;
+					mhi_dev->ul_chan_id = mhi_chan->chan;
+					mhi_dev->ul_xfer = mhi_chan->queue_xfer;
+					mhi_dev->ul_event_id =
+						mhi_chan->er_index;
+				} else {
+					mhi_dev->dl_chan = mhi_chan;
+					mhi_dev->dl_chan_id = mhi_chan->chan;
+					mhi_dev->dl_xfer = mhi_chan->queue_xfer;
+					mhi_dev->dl_event_id =
+						mhi_chan->er_index;
+				}
+				mhi_chan->mhi_dev = mhi_dev;
+			}
+		}
+
+		mhi_dev->chan_name = mhi_chan->name;
+		dev_set_name(&mhi_dev->dev, "%04x_%02u.%02u.%02u_%s",
+			     mhi_dev->dev_id, mhi_dev->domain, mhi_dev->bus,
+			     mhi_dev->slot, mhi_dev->chan_name);
+
+		/* add if there is a matching DT node */
+		controller = mhi_cntrl->of_node;
+		for_each_available_child_of_node(controller, node) {
+			ret = of_property_read_string(node, "mhi,chan",
+						      &dt_name);
+			if (ret)
+				continue;
+			if (!strcmp(mhi_dev->chan_name, dt_name))
+				mhi_dev->dev.of_node = node;
+		}
+
+		ret = device_add(&mhi_dev->dev);
+		if (ret) {
+			MHI_ERR("Failed to register dev for  chan:%s\n",
+				mhi_dev->chan_name);
+			mhi_dealloc_device(mhi_cntrl, mhi_dev);
+		}
+	}
+}
+
+static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
+			    struct mhi_tre *event,
+			    struct mhi_chan *mhi_chan)
+{
+	struct mhi_ring *buf_ring, *tre_ring;
+	u32 ev_code;
+	struct mhi_result result;
+	unsigned long flags = 0;
+
+	ev_code = MHI_TRE_GET_EV_CODE(event);
+	buf_ring = &mhi_chan->buf_ring;
+	tre_ring = &mhi_chan->tre_ring;
+
+	result.transaction_status = (ev_code == MHI_EV_CC_OVERFLOW) ?
+		-EOVERFLOW : 0;
+
+	/*
+	 * if it's a DB Event then we need to grab the lock
+	 * with preemption disable and as a write because we
+	 * have to update db register and another thread could
+	 * be doing same.
+	 */
+	if (ev_code >= MHI_EV_CC_OOB)
+		write_lock_irqsave(&mhi_chan->lock, flags);
+	else
+		read_lock_bh(&mhi_chan->lock);
+
+	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED)
+		goto end_process_tx_event;
+
+	switch (ev_code) {
+	case MHI_EV_CC_OVERFLOW:
+	case MHI_EV_CC_EOB:
+	case MHI_EV_CC_EOT:
+	{
+		dma_addr_t ptr = MHI_TRE_GET_EV_PTR(event);
+		struct mhi_tre *local_rp, *ev_tre;
+		void *dev_rp;
+		struct mhi_buf_info *buf_info;
+		u16 xfer_len;
+
+		/* Get the TRB this event points to */
+		ev_tre = mhi_to_virtual(tre_ring, ptr);
+
+		/* device rp after servicing the TREs */
+		dev_rp = ev_tre + 1;
+		if (dev_rp >= (tre_ring->base + tre_ring->len))
+			dev_rp = tre_ring->base;
+
+		result.dir = mhi_chan->dir;
+
+		/* local rp */
+		local_rp = tre_ring->rp;
+		while (local_rp != dev_rp) {
+			buf_info = buf_ring->rp;
+			/* if it's last tre get len from the event */
+			if (local_rp == ev_tre)
+				xfer_len = MHI_TRE_GET_EV_LEN(event);
+			else
+				xfer_len = buf_info->len;
+
+			dma_unmap_single(mhi_cntrl->dev, buf_info->p_addr,
+					 buf_info->len, buf_info->dir);
+
+			result.buf_addr = buf_info->cb_buf;
+			result.bytes_xferd = xfer_len;
+			mhi_del_ring_element(mhi_cntrl, buf_ring);
+			mhi_del_ring_element(mhi_cntrl, tre_ring);
+			local_rp = tre_ring->rp;
+
+			/* notify client */
+			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+
+			if (mhi_chan->dir == DMA_TO_DEVICE) {
+				read_lock_bh(&mhi_cntrl->pm_lock);
+				mhi_cntrl->wake_put(mhi_cntrl, false);
+				read_unlock_bh(&mhi_cntrl->pm_lock);
+			}
+
+			/*
+			 * recycle the buffer if buffer is pre-allocated,
+			 * if there is error, not much we can do apart from
+			 * dropping the packet
+			 */
+			if (mhi_chan->pre_alloc) {
+				if (mhi_queue_buf(mhi_chan->mhi_dev, mhi_chan,
+						  buf_info->cb_buf,
+						  buf_info->len, MHI_EOT)) {
+					MHI_ERR(
+						"Error recycling buffer for chan:%d\n",
+						mhi_chan->chan);
+					kfree(buf_info->cb_buf);
+				}
+			}
+		};
+		break;
+	} /* CC_EOT */
+	case MHI_EV_CC_OOB:
+	case MHI_EV_CC_DB_MODE:
+	{
+		unsigned long flags;
+
+		MHI_VERB("DB_MODE/OOB Detected chan %d.\n", mhi_chan->chan);
+		mhi_chan->db_cfg.db_mode = 1;
+		read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
+		if (tre_ring->wp != tre_ring->rp &&
+		    MHI_DB_ACCESS_VALID(mhi_cntrl->pm_state)) {
+			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
+		}
+		read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
+		break;
+	}
+	case MHI_EV_CC_BAD_TRE:
+		MHI_ASSERT(1, "Received BAD TRE event for ring");
+		break;
+	default:
+		MHI_CRITICAL("Unknown TX completion.\n");
+
+		break;
+	} /* switch(MHI_EV_READ_CODE(EV_TRB_CODE,event)) */
+
+end_process_tx_event:
+	if (ev_code >= MHI_EV_CC_OOB)
+		write_unlock_irqrestore(&mhi_chan->lock, flags);
+	else
+		read_unlock_bh(&mhi_chan->lock);
+
+	return 0;
+}
+
+static int mhi_process_event_ring(struct mhi_controller *mhi_cntrl,
+				  struct mhi_event *mhi_event,
+				  u32 event_quota)
+{
+	struct mhi_tre *dev_rp, *local_rp;
+	struct mhi_ring *ev_ring = &mhi_event->ring;
+	struct mhi_event_ctxt *er_ctxt =
+		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
+	int count = 0;
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state))) {
+		MHI_ERR("No EV access, PM_STATE:%s\n",
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+		return -EIO;
+	}
+
+	mhi_cntrl->wake_get(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
+	local_rp = ev_ring->rp;
+
+	while (dev_rp != local_rp && event_quota > 0) {
+		enum MHI_PKT_TYPE type = MHI_TRE_GET_EV_TYPE(local_rp);
+
+		MHI_VERB("Processing Event:0x%llx 0x%08x 0x%08x\n",
+			local_rp->ptr, local_rp->dword[0], local_rp->dword[1]);
+
+		switch (type) {
+		case MHI_PKT_TYPE_TX_EVENT:
+		{
+			u32 chan;
+			struct mhi_chan *mhi_chan;
+
+			chan = MHI_TRE_GET_EV_CHID(local_rp);
+			mhi_chan = &mhi_cntrl->mhi_chan[chan];
+			parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
+			event_quota--;
+			break;
+		}
+		case MHI_PKT_TYPE_STATE_CHANGE_EVENT:
+		{
+			enum MHI_STATE new_state;
+
+			new_state = MHI_TRE_GET_EV_STATE(local_rp);
+
+			MHI_LOG("MHI state change event to state:%s\n",
+				TO_MHI_STATE_STR(new_state));
+
+			switch (new_state) {
+			case MHI_STATE_M0:
+				mhi_pm_m0_transition(mhi_cntrl);
+				break;
+			case MHI_STATE_M1:
+				mhi_pm_m1_transition(mhi_cntrl);
+				break;
+			case MHI_STATE_M3:
+				mhi_pm_m3_transition(mhi_cntrl);
+				break;
+			case MHI_STATE_SYS_ERR:
+			{
+				enum MHI_PM_STATE new_state;
+
+				MHI_ERR("MHI system error detected\n");
+				write_lock_irq(&mhi_cntrl->pm_lock);
+				new_state = mhi_tryset_pm_state(mhi_cntrl,
+							MHI_PM_SYS_ERR_DETECT);
+				write_unlock_irq(&mhi_cntrl->pm_lock);
+				if (new_state == MHI_PM_SYS_ERR_DETECT)
+					schedule_work(
+						&mhi_cntrl->syserr_worker);
+				break;
+			}
+			default:
+				MHI_ERR("Unsupported STE:%s\n",
+					TO_MHI_STATE_STR(new_state));
+			}
+
+			break;
+		}
+		case MHI_PKT_TYPE_CMD_COMPLETION_EVENT:
+		{
+			dma_addr_t ptr = MHI_TRE_GET_EV_PTR(local_rp);
+			struct mhi_cmd *cmd_ring =
+				&mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING];
+			struct mhi_ring *mhi_ring = &cmd_ring->ring;
+			struct mhi_tre *cmd_pkt;
+			struct mhi_chan *mhi_chan;
+			u32 chan;
+
+			cmd_pkt = mhi_to_virtual(mhi_ring, ptr);
+
+			/* out of order completion received */
+			MHI_ASSERT(cmd_pkt != mhi_ring->rp,
+				   "Out of order cmd completion");
+
+			chan = MHI_TRE_GET_CMD_CHID(cmd_pkt);
+
+			mhi_chan = &mhi_cntrl->mhi_chan[chan];
+			write_lock_bh(&mhi_chan->lock);
+			mhi_chan->ccs = MHI_TRE_GET_EV_CODE(local_rp);
+			complete(&mhi_chan->completion);
+			write_unlock_bh(&mhi_chan->lock);
+			mhi_del_ring_element(mhi_cntrl, mhi_ring);
+			break;
+		}
+		case MHI_PKT_TYPE_EE_EVENT:
+		{
+			enum MHI_ST_TRANSITION st = MHI_ST_TRANSITION_MAX;
+			enum MHI_EE event = MHI_TRE_GET_EV_EXECENV(local_rp);
+
+			MHI_LOG("MHI EE received event:%s\n",
+				TO_MHI_EXEC_STR(event));
+			switch (event) {
+			case MHI_EE_SBL:
+				st = MHI_ST_TRANSITION_SBL;
+				break;
+			case MHI_EE_AMSS:
+				st = MHI_ST_TRANSITION_AMSS;
+				break;
+			case MHI_EE_RDDM:
+				mhi_cntrl->status_cb(mhi_cntrl,
+						     mhi_cntrl->priv_data,
+						     MHI_CB_EE_RDDM);
+				/* fall thru to wake up the event */
+			case MHI_EE_BHIE:
+				write_lock_irq(&mhi_cntrl->pm_lock);
+				mhi_cntrl->ee = event;
+				write_unlock_irq(&mhi_cntrl->pm_lock);
+				wake_up(&mhi_cntrl->state_event);
+				break;
+			default:
+				MHI_ERR("Unhandled EE event:%s\n",
+					TO_MHI_EXEC_STR(event));
+			}
+			if (st != MHI_ST_TRANSITION_MAX)
+				mhi_queue_state_transition(mhi_cntrl, st);
+
+			break;
+		}
+		case MHI_PKT_TYPE_STALE_EVENT:
+			MHI_VERB("Stale Event received for chan:%u\n",
+				 MHI_TRE_GET_EV_CHID(local_rp));
+			break;
+		default:
+			MHI_ERR("Unsupported packet type code 0x%x\n", type);
+			break;
+		}
+
+		mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
+		local_rp = ev_ring->rp;
+		dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
+		count++;
+	}
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl->pm_state)))
+		mhi_ring_er_db(mhi_event);
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	MHI_VERB("exit er_index:%u\n", mhi_event->er_index);
+	return count;
+}
+
+void mhi_ev_task(unsigned long data)
+{
+	struct mhi_event *mhi_event = (struct mhi_event *)data;
+	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
+
+	MHI_VERB("Enter for ev_index:%d\n", mhi_event->er_index);
+
+	/* process all pending events */
+	spin_lock_bh(&mhi_event->lock);
+	mhi_process_event_ring(mhi_cntrl, mhi_event, U32_MAX);
+	spin_unlock_bh(&mhi_event->lock);
+}
+
+void mhi_ctrl_ev_task(unsigned long data)
+{
+	struct mhi_event *mhi_event = (struct mhi_event *)data;
+	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
+	enum MHI_STATE state = MHI_STATE_MAX;
+	enum MHI_PM_STATE pm_state = 0;
+	int ret;
+
+	MHI_VERB("Enter for ev_index:%d\n", mhi_event->er_index);
+
+	/* process ctrl events events */
+	ret = mhi_process_event_ring(mhi_cntrl, mhi_event, U32_MAX);
+
+	/*
+	 * we received a MSI but no events to process maybe device went to
+	 * SYS_ERR state, check the state
+	 */
+	if (!ret) {
+		write_lock_irq(&mhi_cntrl->pm_lock);
+		if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
+			state = mhi_get_m_state(mhi_cntrl);
+		if (state == MHI_STATE_SYS_ERR) {
+			MHI_ERR("MHI system error detected\n");
+			pm_state = mhi_tryset_pm_state(mhi_cntrl,
+						       MHI_PM_SYS_ERR_DETECT);
+		}
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		if (pm_state == MHI_PM_SYS_ERR_DETECT)
+			schedule_work(&mhi_cntrl->syserr_worker);
+	}
+}
+
+irqreturn_t mhi_msi_handlr(int irq_number, void *dev)
+{
+	struct mhi_event *mhi_event = dev;
+	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
+	struct mhi_event_ctxt *er_ctxt =
+		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
+	struct mhi_ring *ev_ring = &mhi_event->ring;
+	void *dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
+
+	/* confirm ER has pending events to process before scheduling work */
+	if (ev_ring->rp == dev_rp)
+		return IRQ_HANDLED;
+
+	/* client managed event ring, notify pending data */
+	if (mhi_event->cl_manage) {
+		struct mhi_chan *mhi_chan = mhi_event->mhi_chan;
+		struct mhi_device *mhi_dev = mhi_chan->mhi_dev;
+
+		if (mhi_dev)
+			mhi_dev->status_cb(mhi_dev, MHI_CB_PENDING_DATA);
+	} else
+		tasklet_schedule(&mhi_event->task);
+
+	return IRQ_HANDLED;
+}
+
+/* this is the threaded fn */
+irqreturn_t mhi_intvec_threaded_handlr(int irq_number, void *dev)
+{
+	struct mhi_controller *mhi_cntrl = dev;
+	enum MHI_STATE state = MHI_STATE_MAX;
+	enum MHI_PM_STATE pm_state = 0;
+
+	MHI_VERB("Enter\n");
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
+		state = mhi_get_m_state(mhi_cntrl);
+	if (state == MHI_STATE_SYS_ERR) {
+		MHI_ERR("MHI system error detected\n");
+		pm_state = mhi_tryset_pm_state(mhi_cntrl,
+					       MHI_PM_SYS_ERR_DETECT);
+	}
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	if (pm_state == MHI_PM_SYS_ERR_DETECT)
+		schedule_work(&mhi_cntrl->syserr_worker);
+
+	MHI_VERB("Exit\n");
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t mhi_intvec_handlr(int irq_number, void *dev)
+{
+
+	struct mhi_controller *mhi_cntrl = dev;
+
+	/* wake up any events waiting for state change */
+	MHI_VERB("Enter\n");
+	wake_up(&mhi_cntrl->state_event);
+	MHI_VERB("Exit\n");
+
+	return IRQ_WAKE_THREAD;
+}
+
+static int mhi_send_cmd(struct mhi_controller *mhi_cntrl,
+			struct mhi_chan *mhi_chan,
+			enum MHI_CMD cmd)
+{
+	struct mhi_tre *cmd_tre = NULL;
+	struct mhi_cmd *mhi_cmd = &mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING];
+	struct mhi_ring *ring = &mhi_cmd->ring;
+	int chan = mhi_chan->chan;
+
+	MHI_VERB("Entered, MHI pm_state:%s dev_state:%s ee:%s\n",
+		 to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		 TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+		 TO_MHI_EXEC_STR(mhi_cntrl->ee));
+
+	/* MHI host currently handles RESET and START cmd */
+	if (cmd != MHI_CMD_START_CHAN && cmd != MHI_CMD_RESET_CHAN)
+		return -EINVAL;
+
+	spin_lock_bh(&mhi_cmd->lock);
+	if (!get_nr_avail_ring_elements(mhi_cntrl, ring)) {
+		spin_unlock_bh(&mhi_cmd->lock);
+		return -ENOMEM;
+	}
+
+	/* prepare the cmd tre */
+	cmd_tre = ring->wp;
+	if (cmd == MHI_CMD_START_CHAN) {
+		cmd_tre->ptr = MHI_TRE_CMD_START_PTR;
+		cmd_tre->dword[0] = MHI_TRE_CMD_START_DWORD0;
+		cmd_tre->dword[1] = MHI_TRE_CMD_START_DWORD1(chan);
+	} else {
+		cmd_tre->ptr = MHI_TRE_CMD_RESET_PTR;
+		cmd_tre->dword[0] = MHI_TRE_CMD_RESET_DWORD0;
+		cmd_tre->dword[1] = MHI_TRE_CMD_RESET_DWORD1(chan);
+	}
+
+	MHI_VERB("WP:0x%llx TRE: 0x%llx 0x%08x 0x%08x\n",
+		 (u64)mhi_to_physical(ring, cmd_tre), cmd_tre->ptr,
+		 cmd_tre->dword[0], cmd_tre->dword[1]);
+
+	/* queue to hardware */
+	mhi_add_ring_element(mhi_cntrl, ring);
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl->pm_state)))
+		mhi_ring_cmd_db(mhi_cntrl, mhi_cmd);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+	spin_unlock_bh(&mhi_cmd->lock);
+
+	return 0;
+}
+
+static int __mhi_prepare_channel(struct mhi_controller *mhi_cntrl,
+				 struct mhi_chan *mhi_chan)
+{
+	int ret = 0;
+
+	MHI_LOG("Entered: preparing channel:%d\n", mhi_chan->chan);
+
+	if (mhi_cntrl->ee != mhi_chan->ee) {
+		MHI_ERR("Current EE:%s Required EE:%s for chan:%s\n",
+			TO_MHI_EXEC_STR(mhi_cntrl->ee),
+			TO_MHI_EXEC_STR(mhi_chan->ee),
+			mhi_chan->name);
+		return -ENOTCONN;
+	}
+
+	mutex_lock(&mhi_chan->mutex);
+	/* client manages channel context for offload channels */
+	if (!mhi_chan->offload_ch) {
+		ret = mhi_init_chan_ctxt(mhi_cntrl, mhi_chan);
+		if (ret) {
+			MHI_ERR("Error with init chan\n");
+			goto error_init_chan;
+		}
+	}
+
+	reinit_completion(&mhi_chan->completion);
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		MHI_ERR("MHI host is not in active state\n");
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+		ret = -EIO;
+		goto error_pm_state;
+	}
+
+	mhi_cntrl->wake_get(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->runtime_get(mhi_cntrl, mhi_cntrl->priv_data);
+	mhi_cntrl->runtime_put(mhi_cntrl, mhi_cntrl->priv_data);
+
+	ret = mhi_send_cmd(mhi_cntrl, mhi_chan, MHI_CMD_START_CHAN);
+	if (ret) {
+		MHI_ERR("Failed to send start chan cmd\n");
+		goto error_send_cmd;
+	}
+
+	ret = wait_for_completion_timeout(&mhi_chan->completion,
+				msecs_to_jiffies(mhi_cntrl->timeout_ms));
+	if (!ret || mhi_chan->ccs != MHI_EV_CC_SUCCESS) {
+		MHI_ERR("Failed to receive cmd completion for chan:%d\n",
+			mhi_chan->chan);
+		ret = -EIO;
+		goto error_send_cmd;
+	}
+
+	write_lock_irq(&mhi_chan->lock);
+	mhi_chan->ch_state = MHI_CH_STATE_ENABLED;
+	write_unlock_irq(&mhi_chan->lock);
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	/* pre allocate buffer for xfer ring */
+	if (mhi_chan->pre_alloc) {
+		struct mhi_device *mhi_dev = mhi_chan->mhi_dev;
+		int nr_el = get_nr_avail_ring_elements(mhi_cntrl,
+						       &mhi_chan->tre_ring);
+
+		while (nr_el--) {
+			void *buf;
+
+			buf = kmalloc(MHI_MAX_MTU, GFP_KERNEL);
+			if (!buf) {
+				ret = -ENOMEM;
+				goto error_pre_alloc;
+			}
+
+			ret = mhi_queue_buf(mhi_dev, mhi_chan, buf, MHI_MAX_MTU,
+					    MHI_EOT);
+			if (ret) {
+				MHI_ERR("Chan:%d error queue buffer\n",
+					mhi_chan->chan);
+				kfree(buf);
+				goto error_pre_alloc;
+			}
+		}
+	}
+
+	mutex_unlock(&mhi_chan->mutex);
+
+	MHI_LOG("Chan:%d successfully moved to start state\n", mhi_chan->chan);
+
+	return 0;
+
+error_send_cmd:
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+error_pm_state:
+	if (!mhi_chan->offload_ch)
+		mhi_deinit_chan_ctxt(mhi_cntrl, mhi_chan);
+
+error_init_chan:
+	mutex_unlock(&mhi_chan->mutex);
+
+	return ret;
+
+error_pre_alloc:
+	mutex_unlock(&mhi_chan->mutex);
+	__mhi_unprepare_channel(mhi_cntrl, mhi_chan);
+
+	return ret;
+}
+
+void mhi_reset_chan(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan)
+{
+	struct mhi_tre *dev_rp, *local_rp;
+	struct mhi_event_ctxt *er_ctxt;
+	struct mhi_event *mhi_event;
+	struct mhi_ring *ev_ring, *buf_ring, *tre_ring;
+	unsigned long flags;
+	int chan = mhi_chan->chan;
+	struct mhi_result result;
+
+	/* nothing to reset, client don't queue buffers */
+	if (mhi_chan->offload_ch)
+		return;
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_event = &mhi_cntrl->mhi_event[mhi_chan->er_index];
+	ev_ring = &mhi_event->ring;
+	er_ctxt = &mhi_cntrl->mhi_ctxt->er_ctxt[mhi_chan->er_index];
+
+	MHI_LOG("Marking all events for chan:%d as stale\n", chan);
+
+	/* mark all stale events related to channel as STALE event */
+	spin_lock_irqsave(&mhi_event->lock, flags);
+	dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
+	if (!mhi_event->mhi_chan) {
+		local_rp = ev_ring->rp;
+		while (dev_rp != local_rp) {
+			if (MHI_TRE_GET_EV_TYPE(local_rp) ==
+			    MHI_PKT_TYPE_TX_EVENT &&
+			    chan == MHI_TRE_GET_EV_CHID(local_rp))
+				local_rp->dword[1] = MHI_TRE_EV_DWORD1(chan,
+						MHI_PKT_TYPE_STALE_EVENT);
+			local_rp++;
+			if (local_rp == (ev_ring->base + ev_ring->len))
+				local_rp = ev_ring->base;
+		}
+	} else {
+		/* dedicated event ring so move the ptr to end */
+		ev_ring->rp = dev_rp;
+		ev_ring->wp = ev_ring->rp - ev_ring->el_size;
+		if (ev_ring->wp < ev_ring->base)
+			ev_ring->wp = ev_ring->base + ev_ring->len -
+				ev_ring->el_size;
+		if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl->pm_state)))
+			mhi_ring_er_db(mhi_event);
+	}
+
+	MHI_LOG("Finished marking events as stale events\n");
+	spin_unlock_irqrestore(&mhi_event->lock, flags);
+
+	/* reset any pending buffers */
+	buf_ring = &mhi_chan->buf_ring;
+	tre_ring = &mhi_chan->tre_ring;
+	result.transaction_status = -ENOTCONN;
+	result.bytes_xferd = 0;
+	while (tre_ring->rp != tre_ring->wp) {
+		struct mhi_buf_info *buf_info = buf_ring->rp;
+
+		if (mhi_chan->dir == DMA_TO_DEVICE)
+			mhi_cntrl->wake_put(mhi_cntrl, false);
+
+		dma_unmap_single(mhi_cntrl->dev, buf_info->p_addr,
+				 buf_info->len, buf_info->dir);
+		mhi_del_ring_element(mhi_cntrl, buf_ring);
+		mhi_del_ring_element(mhi_cntrl, tre_ring);
+
+		if (mhi_chan->pre_alloc) {
+			kfree(buf_info->cb_buf);
+		} else {
+			result.buf_addr = buf_info->cb_buf;
+			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+		}
+	}
+
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+	MHI_LOG("Reset complete.\n");
+}
+
+static void __mhi_unprepare_channel(struct mhi_controller *mhi_cntrl,
+				    struct mhi_chan *mhi_chan)
+{
+	int ret;
+
+	MHI_LOG("Entered: unprepare channel:%d\n", mhi_chan->chan);
+
+	/* no more processing events for this channel */
+	mutex_lock(&mhi_chan->mutex);
+	write_lock_irq(&mhi_chan->lock);
+	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED) {
+		MHI_LOG("chan:%d is already disabled\n", mhi_chan->chan);
+		write_unlock_irq(&mhi_chan->lock);
+		mutex_unlock(&mhi_chan->mutex);
+		return;
+	}
+
+	mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
+	write_unlock_irq(&mhi_chan->lock);
+
+	reinit_completion(&mhi_chan->completion);
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+		goto error_invalid_state;
+	}
+
+	mhi_cntrl->wake_get(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	mhi_cntrl->runtime_get(mhi_cntrl, mhi_cntrl->priv_data);
+	mhi_cntrl->runtime_put(mhi_cntrl, mhi_cntrl->priv_data);
+	ret = mhi_send_cmd(mhi_cntrl, mhi_chan, MHI_CMD_RESET_CHAN);
+	if (ret) {
+		MHI_ERR("Failed to send reset chan cmd\n");
+		goto error_completion;
+	}
+
+	/* even if it fails we will still reset */
+	ret = wait_for_completion_timeout(&mhi_chan->completion,
+				msecs_to_jiffies(mhi_cntrl->timeout_ms));
+	if (!ret || mhi_chan->ccs != MHI_EV_CC_SUCCESS)
+		MHI_ERR("Failed to receive cmd completion, still resetting\n");
+
+error_completion:
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+error_invalid_state:
+	if (!mhi_chan->offload_ch) {
+		mhi_reset_chan(mhi_cntrl, mhi_chan);
+		mhi_deinit_chan_ctxt(mhi_cntrl, mhi_chan);
+	}
+	MHI_LOG("chan:%d successfully resetted\n", mhi_chan->chan);
+	mutex_unlock(&mhi_chan->mutex);
+}
+
+int mhi_debugfs_mhi_states_show(struct seq_file *m, void *d)
+{
+	struct mhi_controller *mhi_cntrl = m->private;
+
+	seq_printf(m,
+		   "pm_state:%s dev_state:%s EE:%s M0:%u M1:%u M2:%u M3:%u wake:%d dev_wake:%u alloc_size:%u\n",
+		   to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		   TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+		   TO_MHI_EXEC_STR(mhi_cntrl->ee),
+		   mhi_cntrl->M0, mhi_cntrl->M1, mhi_cntrl->M2, mhi_cntrl->M3,
+		   mhi_cntrl->wake_set,
+		   atomic_read(&mhi_cntrl->dev_wake),
+		   atomic_read(&mhi_cntrl->alloc_size));
+	return 0;
+}
+
+int mhi_debugfs_mhi_event_show(struct seq_file *m, void *d)
+{
+	struct mhi_controller *mhi_cntrl = m->private;
+	struct mhi_event *mhi_event;
+	struct mhi_event_ctxt *er_ctxt;
+
+	int i;
+
+	er_ctxt = mhi_cntrl->mhi_ctxt->er_ctxt;
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, er_ctxt++,
+		     mhi_event++) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		if (mhi_event->offload_ev) {
+			seq_printf(m, "Index:%d offload event ring\n", i);
+		} else {
+			seq_printf(m,
+				   "Index:%d modc:%d modt:%d base:0x%0llx len:0x%llx",
+				   i, er_ctxt->intmodc, er_ctxt->intmodt,
+				   er_ctxt->rbase, er_ctxt->rlen);
+			seq_printf(m,
+				   " rp:0x%llx wp:0x%llx local_rp:0x%llx db:0x%llx\n",
+				   er_ctxt->rp, er_ctxt->wp,
+				   mhi_to_physical(ring, ring->rp),
+				   mhi_event->db_cfg.db_val);
+		}
+	}
+
+	return 0;
+}
+
+int mhi_debugfs_mhi_chan_show(struct seq_file *m, void *d)
+{
+	struct mhi_controller *mhi_cntrl = m->private;
+	struct mhi_chan *mhi_chan;
+	struct mhi_chan_ctxt *chan_ctxt;
+	int i;
+
+	mhi_chan = mhi_cntrl->mhi_chan;
+	chan_ctxt = mhi_cntrl->mhi_ctxt->chan_ctxt;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, chan_ctxt++, mhi_chan++) {
+		struct mhi_ring *ring = &mhi_chan->tre_ring;
+
+		if (mhi_chan->offload_ch) {
+			seq_printf(m, "%s(%u) offload channel\n",
+				   mhi_chan->name, mhi_chan->chan);
+		} else if (mhi_chan->mhi_dev) {
+			seq_printf(m,
+				   "%s(%u) state:0x%x brstmode:0x%x pllcfg:0x%x type:0x%x erindex:%u",
+				   mhi_chan->name, mhi_chan->chan,
+				   chan_ctxt->chstate, chan_ctxt->brstmode,
+				   chan_ctxt->pollcfg, chan_ctxt->chtype,
+				   chan_ctxt->erindex);
+			seq_printf(m,
+				   " base:0x%llx len:0x%llx wp:0x%llx local_rp:0x%llx local_wp:0x%llx db:0x%llx\n",
+				   chan_ctxt->rbase, chan_ctxt->rlen,
+				   chan_ctxt->wp,
+				   mhi_to_physical(ring, ring->rp),
+				   mhi_to_physical(ring, ring->wp),
+				   mhi_chan->db_cfg.db_val);
+		}
+	}
+
+	return 0;
+}
+
+/* move channel to start state */
+int mhi_prepare_for_transfer(struct mhi_device *mhi_dev)
+{
+	int ret, dir;
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan;
+
+	for (dir = 0; dir < 2; dir++) {
+		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
+
+		if (!mhi_chan)
+			continue;
+
+		ret = __mhi_prepare_channel(mhi_cntrl, mhi_chan);
+		if (ret) {
+			MHI_ERR("Error moving chan %s,%d to START state\n",
+				mhi_chan->name, mhi_chan->chan);
+			goto error_open_chan;
+		}
+	}
+
+	return 0;
+
+error_open_chan:
+	for (--dir; dir >= 0; dir--) {
+		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
+
+		if (!mhi_chan)
+			continue;
+
+		__mhi_unprepare_channel(mhi_cntrl, mhi_chan);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(mhi_prepare_for_transfer);
+
+void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan;
+	int dir;
+
+	for (dir = 0; dir < 2; dir++) {
+		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
+
+		if (!mhi_chan)
+			continue;
+
+		__mhi_unprepare_channel(mhi_cntrl, mhi_chan);
+	}
+}
+EXPORT_SYMBOL(mhi_unprepare_from_transfer);
+
+int mhi_get_no_free_descriptors(struct mhi_device *mhi_dev,
+				enum dma_data_direction dir)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ?
+		mhi_dev->ul_chan : mhi_dev->dl_chan;
+	struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
+
+	return get_nr_avail_ring_elements(mhi_cntrl, tre_ring);
+}
+EXPORT_SYMBOL(mhi_get_no_free_descriptors);
+
+struct mhi_controller *mhi_bdf_to_controller(u32 domain,
+					     u32 bus,
+					     u32 slot,
+					     u32 dev_id)
+{
+	struct mhi_controller *itr, *tmp;
+
+	list_for_each_entry_safe(itr, tmp, &mhi_bus.controller_list, node)
+		if (itr->domain == domain && itr->bus == bus &&
+		    itr->slot == slot && itr->dev_id == dev_id)
+			return itr;
+
+	return NULL;
+}
+EXPORT_SYMBOL(mhi_bdf_to_controller);
+
+int mhi_poll(struct mhi_device *mhi_dev,
+	     u32 budget)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan = mhi_dev->dl_chan;
+	struct mhi_event *mhi_event = &mhi_cntrl->mhi_event[mhi_chan->er_index];
+	int ret;
+
+	spin_lock_bh(&mhi_event->lock);
+	ret = mhi_process_event_ring(mhi_cntrl, mhi_event, budget);
+	spin_unlock_bh(&mhi_event->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(mhi_poll);
diff --git a/drivers/bus/mhi/core/mhi_pm.c b/drivers/bus/mhi/core/mhi_pm.c
new file mode 100644
index 0000000..c476a20
--- /dev/null
+++ b/drivers/bus/mhi/core/mhi_pm.c
@@ -0,0 +1,1177 @@
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/mhi.h>
+#include "mhi_internal.h"
+
+/*
+ * Not all MHI states transitions are sync transitions. Linkdown, SSR, and
+ * shutdown can happen anytime asynchronously. This function will transition to
+ * new state only if we're allowed to transitions.
+ *
+ * Priority increase as we go down, example while in any states from L0, start
+ * state from L1, L2, or L3 can be set.  Notable exception to this rule is state
+ * DISABLE.  From DISABLE state we can transition to only POR or state.  Also
+ * for example while in L2 state, user cannot jump back to L1 or L0 states.
+ * Valid transitions:
+ * L0: DISABLE <--> POR
+ *     POR <--> POR
+ *     POR -> M0 -> M1 -> M1_M2 -> M2 --> M0
+ *     POR -> FW_DL_ERR
+ *     FW_DL_ERR <--> FW_DL_ERR
+ *     M0 -> FW_DL_ERR
+ *     M1_M2 -> M0 (Device can trigger it)
+ *     M0 -> M3_ENTER -> M3 -> M3_EXIT --> M0
+ *     M1 -> M3_ENTER --> M3
+ * L1: SYS_ERR_DETECT -> SYS_ERR_PROCESS --> POR
+ * L2: SHUTDOWN_PROCESS -> DISABLE
+ * L3: LD_ERR_FATAL_DETECT <--> LD_ERR_FATAL_DETECT
+ *     LD_ERR_FATAL_DETECT -> SHUTDOWN_PROCESS
+ */
+static struct mhi_pm_transitions const mhi_state_transitions[] = {
+	/* L0 States */
+	{
+		MHI_PM_DISABLE,
+		MHI_PM_POR
+	},
+	{
+		MHI_PM_POR,
+		MHI_PM_POR | MHI_PM_DISABLE | MHI_PM_M0 |
+		MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT | MHI_PM_FW_DL_ERR
+	},
+	{
+		MHI_PM_M0,
+		MHI_PM_M1 | MHI_PM_M3_ENTER | MHI_PM_SYS_ERR_DETECT |
+		MHI_PM_SHUTDOWN_PROCESS | MHI_PM_LD_ERR_FATAL_DETECT |
+		MHI_PM_FW_DL_ERR
+	},
+	{
+		MHI_PM_M1,
+		MHI_PM_M1_M2_TRANSITION | MHI_PM_M3_ENTER |
+		MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_M1_M2_TRANSITION,
+		MHI_PM_M2 | MHI_PM_M0 | MHI_PM_SYS_ERR_DETECT |
+		MHI_PM_SHUTDOWN_PROCESS | MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_M2,
+		MHI_PM_M0 | MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_M3_ENTER,
+		MHI_PM_M3 | MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_M3,
+		MHI_PM_M3_EXIT | MHI_PM_SYS_ERR_DETECT |
+		MHI_PM_SHUTDOWN_PROCESS | MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_M3_EXIT,
+		MHI_PM_M0 | MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_FW_DL_ERR,
+		MHI_PM_FW_DL_ERR | MHI_PM_SYS_ERR_DETECT |
+		MHI_PM_SHUTDOWN_PROCESS | MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	/* L1 States */
+	{
+		MHI_PM_SYS_ERR_DETECT,
+		MHI_PM_SYS_ERR_PROCESS | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_SYS_ERR_PROCESS,
+		MHI_PM_POR | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	/* L2 States */
+	{
+		MHI_PM_SHUTDOWN_PROCESS,
+		MHI_PM_DISABLE | MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	/* L3 States */
+	{
+		MHI_PM_LD_ERR_FATAL_DETECT,
+		MHI_PM_LD_ERR_FATAL_DETECT | MHI_PM_SHUTDOWN_PROCESS
+	},
+};
+
+enum MHI_PM_STATE __must_check mhi_tryset_pm_state(
+				struct mhi_controller *mhi_cntrl,
+				enum MHI_PM_STATE state)
+{
+	unsigned long cur_state = mhi_cntrl->pm_state;
+	int index = find_last_bit(&cur_state, 32);
+
+	if (unlikely(index >= ARRAY_SIZE(mhi_state_transitions))) {
+		MHI_CRITICAL("cur_state:%s is not a valid pm_state\n",
+			     to_mhi_pm_state_str(cur_state));
+		return cur_state;
+	}
+
+	if (unlikely(mhi_state_transitions[index].from_state != cur_state)) {
+		MHI_ERR("index:%u cur_state:%s != actual_state: %s\n",
+			index, to_mhi_pm_state_str(cur_state),
+			to_mhi_pm_state_str
+			(mhi_state_transitions[index].from_state));
+		return cur_state;
+	}
+
+	if (unlikely(!(mhi_state_transitions[index].to_states & state))) {
+		MHI_LOG(
+			"Not allowing pm state transition from:%s to:%s state\n",
+			to_mhi_pm_state_str(cur_state),
+			to_mhi_pm_state_str(state));
+		return cur_state;
+	}
+
+	MHI_VERB("Transition to pm state from:%s to:%s\n",
+		 to_mhi_pm_state_str(cur_state), to_mhi_pm_state_str(state));
+
+	mhi_cntrl->pm_state = state;
+	return mhi_cntrl->pm_state;
+}
+
+void mhi_set_mhi_state(struct mhi_controller *mhi_cntrl, enum MHI_STATE state)
+{
+	if (state == MHI_STATE_RESET) {
+		mhi_write_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
+				    MHICTRL_RESET_MASK, MHICTRL_RESET_SHIFT, 1);
+	} else {
+		mhi_write_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
+			MHICTRL_MHISTATE_MASK, MHICTRL_MHISTATE_SHIFT, state);
+	}
+}
+
+/* set device wake */
+void mhi_assert_dev_wake(struct mhi_controller *mhi_cntrl, bool force)
+{
+	unsigned long flags;
+
+	/* if set, regardless of count set the bit if not set */
+	if (unlikely(force)) {
+		spin_lock_irqsave(&mhi_cntrl->wlock, flags);
+		atomic_inc(&mhi_cntrl->dev_wake);
+		if (MHI_WAKE_DB_ACCESS_VALID(mhi_cntrl->pm_state) &&
+		    !mhi_cntrl->wake_set) {
+			mhi_write_db(mhi_cntrl, mhi_cntrl->wake_db, 1);
+			mhi_cntrl->wake_set = true;
+		}
+		spin_unlock_irqrestore(&mhi_cntrl->wlock, flags);
+	} else {
+		/* if resources requested already, then increment and exit */
+		if (likely(atomic_add_unless(&mhi_cntrl->dev_wake, 1, 0)))
+			return;
+
+		spin_lock_irqsave(&mhi_cntrl->wlock, flags);
+		if ((atomic_inc_return(&mhi_cntrl->dev_wake) == 1) &&
+		    MHI_WAKE_DB_ACCESS_VALID(mhi_cntrl->pm_state) &&
+		    !mhi_cntrl->wake_set) {
+			mhi_write_db(mhi_cntrl, mhi_cntrl->wake_db, 1);
+			mhi_cntrl->wake_set = true;
+		}
+		spin_unlock_irqrestore(&mhi_cntrl->wlock, flags);
+	}
+}
+
+/* clear device wake */
+void mhi_deassert_dev_wake(struct mhi_controller *mhi_cntrl, bool override)
+{
+	unsigned long flags;
+
+	MHI_ASSERT(atomic_read(&mhi_cntrl->dev_wake) == 0, "dev_wake == 0");
+
+	/* resources not dropping to 0, decrement and exit */
+	if (likely(atomic_add_unless(&mhi_cntrl->dev_wake, -1, 1)))
+		return;
+
+	spin_lock_irqsave(&mhi_cntrl->wlock, flags);
+	if ((atomic_dec_return(&mhi_cntrl->dev_wake) == 0) &&
+	    MHI_WAKE_DB_ACCESS_VALID(mhi_cntrl->pm_state) && !override &&
+	    mhi_cntrl->wake_set) {
+		mhi_write_db(mhi_cntrl, mhi_cntrl->wake_db, 0);
+		mhi_cntrl->wake_set = false;
+	}
+	spin_unlock_irqrestore(&mhi_cntrl->wlock, flags);
+}
+
+int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl)
+{
+	void __iomem *base = mhi_cntrl->regs;
+	u32 reset = 1, ready = 0;
+	struct mhi_event *mhi_event;
+	enum MHI_PM_STATE cur_state;
+	int ret, i;
+
+	MHI_LOG("Waiting to enter READY state\n");
+
+	/* wait for RESET to be cleared and READY bit to be set */
+	wait_event_timeout(mhi_cntrl->state_event,
+			   MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state) ||
+			   mhi_read_reg_field(mhi_cntrl, base, MHICTRL,
+					      MHICTRL_RESET_MASK,
+					      MHICTRL_RESET_SHIFT, &reset) ||
+			   mhi_read_reg_field(mhi_cntrl, base, MHISTATUS,
+					      MHISTATUS_READY_MASK,
+					      MHISTATUS_READY_SHIFT, &ready) ||
+			   (!reset && ready),
+			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	/* device enter into error state */
+	if (MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state))
+		return -EIO;
+
+	/* device did not transition to ready state */
+	if (reset || !ready)
+		return -ETIMEDOUT;
+
+	MHI_LOG("Device in READY State\n");
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_POR);
+	mhi_cntrl->dev_state = MHI_STATE_READY;
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	if (cur_state != MHI_PM_POR) {
+		MHI_ERR("Error moving to state %s from %s\n",
+			to_mhi_pm_state_str(MHI_PM_POR),
+			to_mhi_pm_state_str(cur_state));
+		return -EIO;
+	}
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
+		goto error_mmio;
+
+	ret = mhi_init_mmio(mhi_cntrl);
+	if (ret) {
+		MHI_ERR("Error programming mmio registers\n");
+		goto error_mmio;
+	}
+
+	/* add elements to all sw event rings */
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		if (mhi_event->offload_ev || mhi_event->hw_ring)
+			continue;
+
+		ring->wp = ring->base + ring->len - ring->el_size;
+		*ring->ctxt_wp = ring->iommu_base + ring->len - ring->el_size;
+		/* needs to update to all cores */
+		smp_wmb();
+
+		/* ring the db for event rings */
+		spin_lock_irq(&mhi_event->lock);
+		mhi_ring_er_db(mhi_event);
+		spin_unlock_irq(&mhi_event->lock);
+	}
+
+	/* set device into M0 state */
+	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M0);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return 0;
+
+error_mmio:
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return -EIO;
+}
+
+int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl)
+{
+	enum MHI_PM_STATE cur_state;
+	struct mhi_chan *mhi_chan;
+	int i;
+
+	MHI_LOG("Entered With State:%s PM_STATE:%s\n",
+		TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+		to_mhi_pm_state_str(mhi_cntrl->pm_state));
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	mhi_cntrl->dev_state = MHI_STATE_M0;
+	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M0);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	if (unlikely(cur_state != MHI_PM_M0)) {
+		MHI_ERR("Failed to transition to state %s from %s\n",
+			to_mhi_pm_state_str(MHI_PM_M0),
+			to_mhi_pm_state_str(cur_state));
+		return -EIO;
+	}
+	mhi_cntrl->M0++;
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_get(mhi_cntrl, true);
+
+	/* ring all event rings and CMD ring only if we're in AMSS */
+	if (mhi_cntrl->ee == MHI_EE_AMSS) {
+		struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
+		struct mhi_cmd *mhi_cmd =
+			&mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING];
+
+		for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+			if (mhi_event->offload_ev)
+				continue;
+
+			spin_lock_irq(&mhi_event->lock);
+			mhi_ring_er_db(mhi_event);
+			spin_unlock_irq(&mhi_event->lock);
+		}
+
+		/* only ring primary cmd ring */
+		spin_lock_irq(&mhi_cmd->lock);
+		if (mhi_cmd->ring.rp != mhi_cmd->ring.wp)
+			mhi_ring_cmd_db(mhi_cntrl, mhi_cmd);
+		spin_unlock_irq(&mhi_cmd->lock);
+	}
+
+	/* ring channel db registers */
+	mhi_chan = mhi_cntrl->mhi_chan;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
+		struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
+
+		write_lock_irq(&mhi_chan->lock);
+		if (mhi_chan->db_cfg.reset_req)
+			mhi_chan->db_cfg.db_mode = true;
+
+		/* only ring DB if ring is not empty */
+		if (tre_ring->base && tre_ring->wp  != tre_ring->rp)
+			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
+		write_unlock_irq(&mhi_chan->lock);
+	}
+
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+	wake_up(&mhi_cntrl->state_event);
+	MHI_VERB("Exited\n");
+
+	return 0;
+}
+
+void mhi_pm_m1_worker(struct work_struct *work)
+{
+	enum MHI_PM_STATE cur_state;
+	struct mhi_controller *mhi_cntrl;
+
+	mhi_cntrl = container_of(work, struct mhi_controller, m1_worker);
+
+	MHI_LOG("M1 state transition from dev_state:%s pm_state:%s\n",
+		TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+		to_mhi_pm_state_str(mhi_cntrl->pm_state));
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+	write_lock_irq(&mhi_cntrl->pm_lock);
+
+	/* we either Entered M3 or we did M3->M0 Exit */
+	if (mhi_cntrl->pm_state != MHI_PM_M1)
+		goto invalid_pm_state;
+
+	MHI_LOG("Transitioning to M2 Transition\n");
+	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M1_M2_TRANSITION);
+	if (unlikely(cur_state != MHI_PM_M1_M2_TRANSITION)) {
+		MHI_ERR("Failed to transition to state %s from %s\n",
+			to_mhi_pm_state_str(MHI_PM_M1_M2_TRANSITION),
+			to_mhi_pm_state_str(cur_state));
+		goto invalid_pm_state;
+	}
+
+	mhi_cntrl->dev_state = MHI_STATE_M2;
+	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M2);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	mhi_cntrl->M2++;
+
+	/* during M2 transition we cannot access DB registers must sleep */
+	usleep_range(MHI_M2_DEBOUNCE_TMR_US, MHI_M2_DEBOUNCE_TMR_US + 50);
+	write_lock_irq(&mhi_cntrl->pm_lock);
+
+	/* during de-bounce time could be receiving M0 Event */
+	if (mhi_cntrl->pm_state == MHI_PM_M1_M2_TRANSITION) {
+		MHI_LOG("Entered M2 State\n");
+		cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M2);
+		if (unlikely(cur_state != MHI_PM_M2)) {
+			MHI_ERR("Failed to transition to state %s from %s\n",
+				to_mhi_pm_state_str(MHI_PM_M2),
+				to_mhi_pm_state_str(cur_state));
+			goto invalid_pm_state;
+		}
+	}
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	/* transfer pending, exit M2 */
+	if (unlikely(atomic_read(&mhi_cntrl->dev_wake))) {
+		MHI_VERB("Exiting M2 Immediately, count:%d\n",
+			atomic_read(&mhi_cntrl->dev_wake));
+		read_lock_bh(&mhi_cntrl->pm_lock);
+		mhi_cntrl->wake_get(mhi_cntrl, true);
+		mhi_cntrl->wake_put(mhi_cntrl, false);
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+	} else
+		mhi_cntrl->status_cb(mhi_cntrl, mhi_cntrl->priv_data,
+				     MHI_CB_IDLE);
+
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+	return;
+
+invalid_pm_state:
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+}
+
+void mhi_pm_m1_transition(struct mhi_controller *mhi_cntrl)
+{
+	enum MHI_PM_STATE state;
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	mhi_cntrl->dev_state = mhi_get_m_state(mhi_cntrl);
+	if (mhi_cntrl->dev_state == MHI_STATE_M1) {
+		state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M1);
+
+		/* schedule M1->M2 transition */
+		if (state == MHI_PM_M1) {
+			schedule_work(&mhi_cntrl->m1_worker);
+			mhi_cntrl->M1++;
+		}
+	}
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+}
+
+int mhi_pm_m3_transition(struct mhi_controller *mhi_cntrl)
+{
+	enum MHI_PM_STATE state;
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	mhi_cntrl->dev_state = MHI_STATE_M3;
+	state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M3);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	if (state != MHI_PM_M3) {
+		MHI_ERR("Failed to transition to state %s from %s\n",
+			to_mhi_pm_state_str(MHI_PM_M3),
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		return -EIO;
+	}
+	wake_up(&mhi_cntrl->state_event);
+	mhi_cntrl->M3++;
+
+	MHI_LOG("Entered mhi_state:%s pm_state:%s\n",
+		TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+		to_mhi_pm_state_str(mhi_cntrl->pm_state));
+	return 0;
+}
+
+static int mhi_pm_amss_transition(struct mhi_controller *mhi_cntrl)
+{
+	int i;
+	struct mhi_event *mhi_event;
+
+	MHI_LOG("Processing AMSS Transition\n");
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	mhi_cntrl->ee = MHI_EE_AMSS;
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	wake_up(&mhi_cntrl->state_event);
+
+	/* add elements to all HW event rings */
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+		return -EIO;
+	}
+
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		if (mhi_event->offload_ev || !mhi_event->hw_ring)
+			continue;
+
+		ring->wp = ring->base + ring->len - ring->el_size;
+		*ring->ctxt_wp = ring->iommu_base + ring->len - ring->el_size;
+		/* all ring updates must get updated immediately */
+		smp_wmb();
+
+		spin_lock_irq(&mhi_event->lock);
+		if (MHI_DB_ACCESS_VALID(mhi_cntrl->pm_state))
+			mhi_ring_er_db(mhi_event);
+		spin_unlock_irq(&mhi_event->lock);
+
+	}
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	MHI_LOG("Adding new devices\n");
+
+	/* add supported devices */
+	mhi_create_devices(mhi_cntrl);
+
+	MHI_LOG("Exited\n");
+
+	return 0;
+}
+
+/* handles both sys_err and shutdown transitions */
+static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
+				      enum MHI_PM_STATE transition_state)
+{
+	enum MHI_PM_STATE cur_state, prev_state;
+	struct mhi_event *mhi_event;
+	struct mhi_cmd_ctxt *cmd_ctxt;
+	struct mhi_cmd *mhi_cmd;
+	struct mhi_event_ctxt *er_ctxt;
+	int ret, i;
+
+	MHI_LOG("Enter with from pm_state:%s MHI_STATE:%s to pm_state:%s\n",
+		to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+		to_mhi_pm_state_str(transition_state));
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	prev_state = mhi_cntrl->pm_state;
+	cur_state = mhi_tryset_pm_state(mhi_cntrl, transition_state);
+	if (cur_state == transition_state) {
+		mhi_cntrl->ee = MHI_EE_DISABLE_TRANSITION;
+		mhi_cntrl->dev_state = MHI_STATE_RESET;
+	}
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	/* not handling sys_err, could be middle of shut down */
+	if (cur_state != transition_state) {
+		MHI_LOG("Failed to transition to state:0x%x from:0x%x\n",
+			transition_state, cur_state);
+		mutex_unlock(&mhi_cntrl->pm_mutex);
+		return;
+	}
+
+	/* trigger MHI RESET so device will not access host ddr */
+	if (MHI_REG_ACCESS_VALID(prev_state)) {
+		u32 in_reset = -1;
+		unsigned long timeout = msecs_to_jiffies(mhi_cntrl->timeout_ms);
+
+		MHI_LOG("Trigger device into MHI_RESET\n");
+		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
+
+		/* wait for reset to be cleared */
+		ret = wait_event_timeout(mhi_cntrl->state_event,
+					 mhi_read_reg_field(mhi_cntrl,
+						mhi_cntrl->regs, MHICTRL,
+						MHICTRL_RESET_MASK,
+						MHICTRL_RESET_SHIFT, &in_reset)
+					 || !in_reset, timeout);
+		if ((!ret || in_reset) && cur_state == MHI_PM_SYS_ERR_PROCESS) {
+			MHI_CRITICAL("Device failed to exit RESET state\n");
+			mutex_unlock(&mhi_cntrl->pm_mutex);
+			return;
+		}
+
+		/*
+		 * device cleares INTVEC as part of RESET processing,
+		 * re-program it
+		 */
+		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
+	}
+
+	MHI_LOG("Waiting for all pending event ring processing to complete\n");
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+		tasklet_kill(&mhi_event->task);
+	}
+
+	MHI_LOG("Reset all active channels and remove mhi devices\n");
+	device_for_each_child(mhi_cntrl->dev, NULL, mhi_destroy_device);
+
+	MHI_LOG("Finish resetting channels\n");
+
+	/* release lock and wait for all pending thread to complete */
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+	MHI_LOG("Waiting for all pending threads to complete\n");
+	wake_up(&mhi_cntrl->state_event);
+	flush_work(&mhi_cntrl->m1_worker);
+	flush_work(&mhi_cntrl->st_worker);
+	flush_work(&mhi_cntrl->fw_worker);
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+
+	MHI_ASSERT(atomic_read(&mhi_cntrl->dev_wake), "dev_wake != 0");
+
+	/* reset the ev rings and cmd rings */
+	MHI_LOG("Resetting EV CTXT and CMD CTXT\n");
+	mhi_cmd = mhi_cntrl->mhi_cmd;
+	cmd_ctxt = mhi_cntrl->mhi_ctxt->cmd_ctxt;
+	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++, cmd_ctxt++) {
+		struct mhi_ring *ring = &mhi_cmd->ring;
+
+		ring->rp = ring->base;
+		ring->wp = ring->base;
+		cmd_ctxt->rp = cmd_ctxt->rbase;
+		cmd_ctxt->wp = cmd_ctxt->rbase;
+	}
+
+	mhi_event = mhi_cntrl->mhi_event;
+	er_ctxt = mhi_cntrl->mhi_ctxt->er_ctxt;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, er_ctxt++,
+		     mhi_event++) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		/* do not touch offload er */
+		if (mhi_event->offload_ev)
+			continue;
+
+		ring->rp = ring->base;
+		ring->wp = ring->base;
+		er_ctxt->rp = er_ctxt->rbase;
+		er_ctxt->wp = er_ctxt->rbase;
+	}
+
+	if (cur_state == MHI_PM_SYS_ERR_PROCESS) {
+		mhi_ready_state_transition(mhi_cntrl);
+	} else {
+		/* move to disable state */
+		write_lock_irq(&mhi_cntrl->pm_lock);
+		cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_DISABLE);
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		if (unlikely(cur_state != MHI_PM_DISABLE))
+			MHI_ERR("Error moving from pm state:%s to state:%s\n",
+				to_mhi_pm_state_str(cur_state),
+				to_mhi_pm_state_str(MHI_PM_DISABLE));
+	}
+
+	MHI_LOG("Exit with pm_state:%s mhi_state:%s\n",
+		to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
+
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+}
+
+int mhi_debugfs_trigger_reset(void *data, u64 val)
+{
+	struct mhi_controller *mhi_cntrl = data;
+	enum MHI_PM_STATE cur_state;
+	int ret;
+
+	MHI_LOG("Trigger MHI Reset\n");
+
+	/* exit lpm first */
+	mhi_cntrl->runtime_get(mhi_cntrl, mhi_cntrl->priv_data);
+	mhi_cntrl->runtime_put(mhi_cntrl, mhi_cntrl->priv_data);
+
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->dev_state == MHI_STATE_M0 ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		MHI_ERR("Did not enter M0 state, cur_state:%s pm_state:%s\n",
+			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		return -EIO;
+	}
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_SYS_ERR_DETECT);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	if (cur_state == MHI_PM_SYS_ERR_DETECT)
+		schedule_work(&mhi_cntrl->syserr_worker);
+
+	return 0;
+}
+
+/* queue a new work item and scheduler work */
+int mhi_queue_state_transition(struct mhi_controller *mhi_cntrl,
+			       enum MHI_ST_TRANSITION state)
+{
+	struct state_transition *item = kmalloc(sizeof(*item), GFP_ATOMIC);
+	unsigned long flags;
+
+	if (!item)
+		return -ENOMEM;
+
+	item->state = state;
+	spin_lock_irqsave(&mhi_cntrl->transition_lock, flags);
+	list_add_tail(&item->node, &mhi_cntrl->transition_list);
+	spin_unlock_irqrestore(&mhi_cntrl->transition_lock, flags);
+
+	schedule_work(&mhi_cntrl->st_worker);
+
+	return 0;
+}
+
+void mhi_pm_sys_err_worker(struct work_struct *work)
+{
+	struct mhi_controller *mhi_cntrl = container_of(work,
+							struct mhi_controller,
+							syserr_worker);
+
+	MHI_LOG("Enter with pm_state:%s MHI_STATE:%s\n",
+		to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
+
+	mhi_pm_disable_transition(mhi_cntrl, MHI_PM_SYS_ERR_PROCESS);
+}
+
+void mhi_pm_st_worker(struct work_struct *work)
+{
+	struct state_transition *itr, *tmp;
+	LIST_HEAD(head);
+	struct mhi_controller *mhi_cntrl = container_of(work,
+							struct mhi_controller,
+							st_worker);
+	spin_lock_irq(&mhi_cntrl->transition_lock);
+	list_splice_tail_init(&mhi_cntrl->transition_list, &head);
+	spin_unlock_irq(&mhi_cntrl->transition_lock);
+
+	list_for_each_entry_safe(itr, tmp, &head, node) {
+		list_del(&itr->node);
+		MHI_LOG("Transition to state:%s\n",
+			TO_MHI_STATE_TRANS_STR(itr->state));
+
+		switch (itr->state) {
+		case MHI_ST_TRANSITION_PBL:
+			write_lock_irq(&mhi_cntrl->pm_lock);
+			if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
+				mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
+			write_unlock_irq(&mhi_cntrl->pm_lock);
+			if (MHI_IN_PBL(mhi_cntrl->ee))
+				wake_up(&mhi_cntrl->state_event);
+			break;
+		case MHI_ST_TRANSITION_SBL:
+			write_lock_irq(&mhi_cntrl->pm_lock);
+			mhi_cntrl->ee = MHI_EE_SBL;
+			write_unlock_irq(&mhi_cntrl->pm_lock);
+			mhi_create_devices(mhi_cntrl);
+			break;
+		case MHI_ST_TRANSITION_AMSS:
+			mhi_pm_amss_transition(mhi_cntrl);
+			break;
+		default:
+			break;
+		}
+		kfree(itr);
+	}
+}
+
+int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
+{
+	int ret;
+	u32 bhi_offset;
+	enum MHI_EE current_ee;
+	enum MHI_ST_TRANSITION next_state;
+
+	MHI_LOG("Requested to power on\n");
+
+	if (mhi_cntrl->msi_allocated < mhi_cntrl->total_ev_rings)
+		return -EINVAL;
+
+	/* set to default wake if not set */
+	if (!mhi_cntrl->wake_get || !mhi_cntrl->wake_put) {
+		mhi_cntrl->wake_get = mhi_assert_dev_wake;
+		mhi_cntrl->wake_put = mhi_deassert_dev_wake;
+	}
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+	mhi_cntrl->pm_state = MHI_PM_DISABLE;
+
+	if (!mhi_cntrl->pre_init) {
+		/* setup device context */
+		ret = mhi_init_dev_ctxt(mhi_cntrl);
+		if (ret) {
+			MHI_ERR("Error setting dev_context\n");
+			goto error_dev_ctxt;
+		}
+
+		ret = mhi_init_irq_setup(mhi_cntrl);
+		if (ret) {
+			MHI_ERR("Error setting up irq\n");
+			goto error_setup_irq;
+		}
+	}
+
+	/* setup bhi offset & intvec */
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, BHIOFF, &bhi_offset);
+	if (ret) {
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		MHI_ERR("Error getting bhi offset\n");
+		goto error_bhi_offset;
+	}
+
+	mhi_cntrl->bhi = mhi_cntrl->regs + bhi_offset;
+	mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
+	mhi_cntrl->pm_state = MHI_PM_POR;
+	mhi_cntrl->ee = MHI_EE_MAX;
+	current_ee = mhi_get_exec_env(mhi_cntrl);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	/* confirm device is in valid exec env */
+	if (!MHI_IN_PBL(current_ee) && current_ee != MHI_EE_AMSS) {
+		MHI_ERR("Not a valid ee for power on\n");
+		ret = -EIO;
+		goto error_bhi_offset;
+	}
+
+	/* transition to next state */
+	next_state = MHI_IN_PBL(current_ee) ?
+		MHI_ST_TRANSITION_PBL : MHI_ST_TRANSITION_READY;
+
+	if (next_state == MHI_ST_TRANSITION_PBL)
+		schedule_work(&mhi_cntrl->fw_worker);
+
+	mhi_queue_state_transition(mhi_cntrl, next_state);
+
+	mhi_init_debugfs(mhi_cntrl);
+
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	MHI_LOG("Power on setup success\n");
+
+	return 0;
+
+error_bhi_offset:
+	if (!mhi_cntrl->pre_init)
+		mhi_deinit_free_irq(mhi_cntrl);
+
+error_setup_irq:
+	if (!mhi_cntrl->pre_init)
+		mhi_deinit_dev_ctxt(mhi_cntrl);
+
+error_dev_ctxt:
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL(mhi_async_power_up);
+
+void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
+{
+	enum MHI_PM_STATE cur_state;
+
+	/* if it's not graceful shutdown, force MHI to a linkdown state */
+	if (!graceful) {
+		mutex_lock(&mhi_cntrl->pm_mutex);
+		write_lock_irq(&mhi_cntrl->pm_lock);
+		cur_state = mhi_tryset_pm_state(mhi_cntrl,
+						MHI_PM_LD_ERR_FATAL_DETECT);
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		mutex_unlock(&mhi_cntrl->pm_mutex);
+		if (cur_state != MHI_PM_LD_ERR_FATAL_DETECT)
+			MHI_ERR("Failed to move to state:%s from:%s\n",
+				to_mhi_pm_state_str(MHI_PM_LD_ERR_FATAL_DETECT),
+				to_mhi_pm_state_str(mhi_cntrl->pm_state));
+	}
+	mhi_pm_disable_transition(mhi_cntrl, MHI_PM_SHUTDOWN_PROCESS);
+
+	mhi_deinit_debugfs(mhi_cntrl);
+
+	if (!mhi_cntrl->pre_init) {
+		/* free all allocated resources */
+		if (mhi_cntrl->fbc_image) {
+			mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
+			mhi_cntrl->fbc_image = NULL;
+		}
+		mhi_deinit_free_irq(mhi_cntrl);
+		mhi_deinit_dev_ctxt(mhi_cntrl);
+	}
+
+}
+EXPORT_SYMBOL(mhi_power_down);
+
+int mhi_sync_power_up(struct mhi_controller *mhi_cntrl)
+{
+	int ret = mhi_async_power_up(mhi_cntrl);
+
+	if (ret)
+		return ret;
+
+	wait_event_timeout(mhi_cntrl->state_event,
+			   mhi_cntrl->ee == MHI_EE_AMSS ||
+			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	return (mhi_cntrl->ee == MHI_EE_AMSS) ? 0 : -EIO;
+}
+EXPORT_SYMBOL(mhi_sync_power_up);
+
+int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
+{
+	int ret;
+	enum MHI_PM_STATE new_state;
+	struct mhi_chan *itr, *tmp;
+
+	if (mhi_cntrl->pm_state == MHI_PM_DISABLE)
+		return -EINVAL;
+
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
+		return -EIO;
+
+	/* do a quick check to see if any pending data, then exit */
+	if (atomic_read(&mhi_cntrl->dev_wake)) {
+		MHI_VERB("Busy, aborting M3\n");
+		return -EBUSY;
+	}
+
+	/* exit MHI out of M2 state */
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_get(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->dev_state == MHI_STATE_M0 ||
+				 mhi_cntrl->dev_state == MHI_STATE_M1 ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		MHI_ERR(
+			"Did not enter M0||M1 state, cur_state:%s pm_state:%s\n",
+			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		return -EIO;
+	}
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+
+	if (atomic_read(&mhi_cntrl->dev_wake)) {
+		MHI_VERB("Busy, aborting M3\n");
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		return -EBUSY;
+	}
+
+	/* anytime after this, we will resume thru runtime pm framework */
+	MHI_LOG("Allowing M3 transition\n");
+	new_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M3_ENTER);
+	if (new_state != MHI_PM_M3_ENTER) {
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		MHI_ERR("Error setting to pm_state:%s from pm_state:%s\n",
+			to_mhi_pm_state_str(MHI_PM_M3_ENTER),
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		return -EIO;
+	}
+
+	/* set dev to M3 and wait for completion */
+	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M3);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	MHI_LOG("Wait for M3 completion\n");
+
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->dev_state == MHI_STATE_M3 ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		MHI_ERR("Did not enter M3 state, cur_state:%s pm_state:%s\n",
+			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		return -EIO;
+	}
+
+	/* notify any clients we enter lpm */
+	list_for_each_entry_safe(itr, tmp, &mhi_cntrl->lpm_chans, node) {
+		mutex_lock(&itr->mutex);
+		if (itr->mhi_dev)
+			mhi_notify(itr->mhi_dev, MHI_CB_LPM_ENTER);
+		mutex_unlock(&itr->mutex);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(mhi_pm_suspend);
+
+int mhi_pm_resume(struct mhi_controller *mhi_cntrl)
+{
+	enum MHI_PM_STATE cur_state;
+	int ret;
+	struct mhi_chan *itr, *tmp;
+
+	MHI_LOG("Entered with pm_state:%s dev_state:%s\n",
+		to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
+
+	if (mhi_cntrl->pm_state == MHI_PM_DISABLE)
+		return 0;
+
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
+		return -EIO;
+
+	MHI_ASSERT(mhi_cntrl->pm_state != MHI_PM_M3, "mhi_pm_state != M3");
+
+	/* notify any clients we enter lpm */
+	list_for_each_entry_safe(itr, tmp, &mhi_cntrl->lpm_chans, node) {
+		mutex_lock(&itr->mutex);
+		if (itr->mhi_dev)
+			mhi_notify(itr->mhi_dev, MHI_CB_LPM_EXIT);
+		mutex_unlock(&itr->mutex);
+	}
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M3_EXIT);
+	if (cur_state != MHI_PM_M3_EXIT) {
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		MHI_ERR("Error setting to pm_state:%s from pm_state:%s\n",
+			to_mhi_pm_state_str(MHI_PM_M3_EXIT),
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		return -EIO;
+	}
+
+	/* set dev to M0 and wait for completion */
+	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M0);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->dev_state == MHI_STATE_M0 ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		MHI_ERR("Did not enter M0 state, cur_state:%s pm_state:%s\n",
+			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int __mhi_device_get_sync(struct mhi_controller *mhi_cntrl)
+{
+	int ret;
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_get(mhi_cntrl, false);
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state)) {
+		mhi_cntrl->runtime_get(mhi_cntrl, mhi_cntrl->priv_data);
+		mhi_cntrl->runtime_put(mhi_cntrl, mhi_cntrl->priv_data);
+	}
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->dev_state == MHI_STATE_M0 ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		MHI_ERR("Did not enter M0 state, cur_state:%s pm_state:%s\n",
+			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		read_lock_bh(&mhi_cntrl->pm_lock);
+		mhi_cntrl->wake_put(mhi_cntrl, false);
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+void mhi_device_get(struct mhi_device *mhi_dev)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+
+	atomic_inc(&mhi_dev->dev_wake);
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_get(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+}
+EXPORT_SYMBOL(mhi_device_get);
+
+int mhi_device_get_sync(struct mhi_device *mhi_dev)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	int ret;
+
+	ret = __mhi_device_get_sync(mhi_cntrl);
+	if (!ret)
+		atomic_inc(&mhi_dev->dev_wake);
+
+	return ret;
+}
+EXPORT_SYMBOL(mhi_device_get_sync);
+
+void mhi_device_put(struct mhi_device *mhi_dev)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+
+	atomic_dec(&mhi_dev->dev_wake);
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+}
+EXPORT_SYMBOL(mhi_device_put);
+
+int mhi_force_rddm_mode(struct mhi_controller *mhi_cntrl)
+{
+	int ret;
+
+	MHI_LOG("Enter with pm_state:%s ee:%s\n",
+		to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		TO_MHI_EXEC_STR(mhi_cntrl->ee));
+
+	/* before rddm mode, we need to enter M0 state */
+	ret = __mhi_device_get_sync(mhi_cntrl);
+	if (ret)
+		return ret;
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
+		goto no_reg_access;
+
+	MHI_LOG("Triggering SYS_ERR to force rddm state\n");
+
+	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_SYS_ERR);
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	/* wait for rddm event */
+	MHI_LOG("Waiting for device to enter RDDM state\n");
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->ee == MHI_EE_RDDM,
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+	ret = !ret ? 0 : -EIO;
+
+	MHI_LOG("Exiting with pm_state:%s ee:%s ret:%d\n",
+		to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		TO_MHI_EXEC_STR(mhi_cntrl->ee), ret);
+
+	return ret;
+
+no_reg_access:
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	return -EIO;
+}
+EXPORT_SYMBOL(mhi_force_rddm_mode);
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
new file mode 100644
index 0000000..6eb780c
--- /dev/null
+++ b/include/linux/mhi.h
@@ -0,0 +1,694 @@
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+#ifndef _MHI_H_
+#define _MHI_H_
+
+struct mhi_chan;
+struct mhi_event;
+struct mhi_ctxt;
+struct mhi_cmd;
+struct image_info;
+struct bhi_vec_entry;
+
+/**
+ * enum MHI_CB - MHI callback
+ * @MHI_CB_IDLE: MHI entered idle state
+ * @MHI_CB_PENDING_DATA: New data available for client to process
+ * @MHI_CB_LPM_ENTER: MHI host entered low power mode
+ * @MHI_CB_LPM_EXIT: MHI host about to exit low power mode
+ * @MHI_CB_EE_RDDM: MHI device entered RDDM execution enviornment
+ */
+enum MHI_CB {
+	MHI_CB_IDLE,
+	MHI_CB_PENDING_DATA,
+	MHI_CB_LPM_ENTER,
+	MHI_CB_LPM_EXIT,
+	MHI_CB_EE_RDDM,
+};
+
+/**
+ * enum MHI_DEBUG_LEVL - various debugging level
+ */
+enum MHI_DEBUG_LEVEL {
+	MHI_MSG_LVL_VERBOSE,
+	MHI_MSG_LVL_INFO,
+	MHI_MSG_LVL_ERROR,
+	MHI_MSG_LVL_CRITICAL,
+	MHI_MSG_LVL_MASK_ALL,
+};
+
+/**
+ * enum MHI_FLAGS - Transfer flags
+ * @MHI_EOB: End of buffer for bulk transfer
+ * @MHI_EOT: End of transfer
+ * @MHI_CHAIN: Linked transfer
+ */
+enum MHI_FLAGS {
+	MHI_EOB,
+	MHI_EOT,
+	MHI_CHAIN,
+};
+
+/**
+ * struct image_info - firmware and rddm table table
+ * @mhi_buf - Contain device firmware and rddm table
+ * @entries - # of entries in table
+ */
+struct image_info {
+	struct mhi_buf *mhi_buf;
+	struct bhi_vec_entry *bhi_vec;
+	u32 entries;
+};
+
+/**
+ * struct mhi_controller - Master controller structure for external modem
+ * @dev: Device associated with this controller
+ * @of_node: DT that has MHI configuration information
+ * @regs: Points to base of MHI MMIO register space
+ * @bhi: Points to base of MHI BHI register space
+ * @wake_db: MHI WAKE doorbell register address
+ * @dev_id: PCIe device id of the external device
+ * @domain: PCIe domain the device connected to
+ * @bus: PCIe bus the device assigned to
+ * @slot: PCIe slot for the modem
+ * @iova_start: IOMMU starting address for data
+ * @iova_stop: IOMMU stop address for data
+ * @fw_image: Firmware image name for normal booting
+ * @edl_image: Firmware image name for emergency download mode
+ * @fbc_download: MHI host needs to do complete image transfer
+ * @rddm_size: RAM dump size that host should allocate for debugging purpose
+ * @sbl_size: SBL image size
+ * @seg_len: BHIe vector size
+ * @fbc_image: Points to firmware image buffer
+ * @rddm_image: Points to RAM dump buffer
+ * @max_chan: Maximum number of channels controller support
+ * @mhi_chan: Points to channel configuration table
+ * @lpm_chans: List of channels that require LPM notifications
+ * @total_ev_rings: Total # of event rings allocated
+ * @hw_ev_rings: Number of hardware event rings
+ * @sw_ev_rings: Number of software event rings
+ * @msi_required: Number of msi required to operate
+ * @msi_allocated: Number of msi allocated by bus master
+ * @irq: base irq # to request
+ * @mhi_event: MHI event ring configurations table
+ * @mhi_cmd: MHI command ring configurations table
+ * @mhi_ctxt: MHI device context, shared memory between host and device
+ * @timeout_ms: Timeout in ms for state transitions
+ * @pm_state: Power management state
+ * @ee: MHI device execution environment
+ * @dev_state: MHI STATE
+ * @status_cb: CB function to notify various power states to but master
+ * @link_status: Query link status in case of abnormal value read from device
+ * @runtime_get: Async runtime resume function
+ * @runtimet_put: Release votes
+ * @priv_data: Points to bus master's private data
+ */
+struct mhi_controller {
+	struct list_head node;
+
+	/* device node for iommu ops */
+	struct device *dev;
+	struct device_node *of_node;
+
+	/* mmio base */
+	void __iomem *regs;
+	void __iomem *bhi;
+	void __iomem *wake_db;
+
+	/* device topology */
+	u32 dev_id;
+	u32 domain;
+	u32 bus;
+	u32 slot;
+
+	/* addressing window */
+	dma_addr_t iova_start;
+	dma_addr_t iova_stop;
+
+	/* fw images */
+	const char *fw_image;
+	const char *edl_image;
+
+	/* mhi host manages downloading entire fbc images */
+	bool fbc_download;
+	size_t rddm_size;
+	size_t sbl_size;
+	size_t seg_len;
+	u32 session_id;
+	u32 sequence_id;
+	struct image_info *fbc_image;
+	struct image_info *rddm_image;
+
+	/* physical channel config data */
+	u32 max_chan;
+	struct mhi_chan *mhi_chan;
+	struct list_head lpm_chans; /* these chan require lpm notification */
+
+	/* physical event config data */
+	u32 total_ev_rings;
+	u32 hw_ev_rings;
+	u32 sw_ev_rings;
+	u32 msi_required;
+	u32 msi_allocated;
+	int *irq; /* interrupt table */
+	struct mhi_event *mhi_event;
+
+	/* cmd rings */
+	struct mhi_cmd *mhi_cmd;
+
+	/* mhi context (shared with device) */
+	struct mhi_ctxt *mhi_ctxt;
+
+	u32 timeout_ms;
+
+	/* caller should grab pm_mutex for suspend/resume operations */
+	struct mutex pm_mutex;
+	bool pre_init;
+	rwlock_t pm_lock;
+	u32 pm_state;
+	u32 ee;
+	u32 dev_state;
+	bool wake_set;
+	atomic_t dev_wake;
+	atomic_t alloc_size;
+	struct list_head transition_list;
+	spinlock_t transition_lock;
+	spinlock_t wlock;
+
+	/* debug counters */
+	u32 M0, M1, M2, M3;
+
+	/* worker for different state transitions */
+	struct work_struct st_worker;
+	struct work_struct fw_worker;
+	struct work_struct m1_worker;
+	struct work_struct syserr_worker;
+	wait_queue_head_t state_event;
+
+	/* shadow functions */
+	void (*status_cb)(struct mhi_controller *mhi_cntrl, void *piv,
+			  enum MHI_CB reason);
+	int (*link_status)(struct mhi_controller *mhi_cntrl, void *priv);
+	void (*wake_get)(struct mhi_controller *mhi_cntrl, bool override);
+	void (*wake_put)(struct mhi_controller *mhi_cntrl, bool override);
+	int (*runtime_get)(struct mhi_controller *mhi_cntrl, void *priv);
+	void (*runtime_put)(struct mhi_controller *mhi_cntrl, void *priv);
+
+	/* channel to control DTR messaging */
+	struct mhi_device *dtr_dev;
+
+	/* kernel log level */
+	enum MHI_DEBUG_LEVEL klog_lvl;
+
+	/* private log level controller driver to set */
+	enum MHI_DEBUG_LEVEL log_lvl;
+
+	/* controller specific data */
+	void *priv_data;
+	void *log_buf;
+	struct dentry *dentry;
+	struct dentry *parent;
+};
+
+/**
+ * struct mhi_device - mhi device structure associated bind to channel
+ * @dev: Device associated with the channels
+ * @mtu: Maximum # of bytes controller support
+ * @ul_chan_id: MHI channel id for UL transfer
+ * @dl_chan_id: MHI channel id for DL transfer
+ * @priv: Driver private data
+ */
+struct mhi_device {
+	struct device dev;
+	u32 dev_id;
+	u32 domain;
+	u32 bus;
+	u32 slot;
+	size_t mtu;
+	int ul_chan_id;
+	int dl_chan_id;
+	int ul_event_id;
+	int dl_event_id;
+	const struct mhi_device_id *id;
+	const char *chan_name;
+	struct mhi_controller *mhi_cntrl;
+	struct mhi_chan *ul_chan;
+	struct mhi_chan *dl_chan;
+	atomic_t dev_wake;
+	void *priv_data;
+	int (*ul_xfer)(struct mhi_device *mhi_dev, struct mhi_chan *mhi_chan,
+		       void *buf, size_t len, enum MHI_FLAGS flags);
+	int (*dl_xfer)(struct mhi_device *mhi_dev, struct mhi_chan *mhi_chan,
+		       void *buf, size_t len, enum MHI_FLAGS flags);
+	void (*status_cb)(struct mhi_device *mhi_dev, enum MHI_CB reason);
+};
+
+/**
+ * struct mhi_result - Completed buffer information
+ * @buf_addr: Address of data buffer
+ * @dir: Channel direction
+ * @bytes_xfer: # of bytes transferred
+ * @transaction_status: Status of last trasnferred
+ */
+struct mhi_result {
+	void *buf_addr;
+	enum dma_data_direction dir;
+	size_t bytes_xferd;
+	int transaction_status;
+};
+
+/**
+ * struct mhi_buf - Describes the buffer
+ * @buf: cpu address for the buffer
+ * @phys_addr: physical address of the buffer
+ * @dma_addr: iommu address for the buffer
+ * @len: # of bytes
+ * @name: Buffer label, for offload channel configurations name must be:
+ * ECA - Event context array data
+ * CCA - Channel context array data
+ */
+struct mhi_buf {
+	void *buf;
+	phys_addr_t phys_addr;
+	dma_addr_t dma_addr;
+	size_t len;
+	const char *name; /* ECA, CCA */
+};
+
+/**
+ * struct mhi_driver - mhi driver information
+ * @id_table: NULL terminated channel ID names
+ * @ul_xfer_cb: UL data transfer callback
+ * @dl_xfer_cb: DL data transfer callback
+ * @status_cb: Asynchronous status callback
+ */
+struct mhi_driver {
+	const struct mhi_device_id *id_table;
+	int (*probe)(struct mhi_device *mhi_dev,
+		     const struct mhi_device_id *id);
+	void (*remove)(struct mhi_device *mhi_dev);
+	void (*ul_xfer_cb)(struct mhi_device *mhi_dev,
+			   struct mhi_result *result);
+	void (*dl_xfer_cb)(struct mhi_device *mhi_dev,
+			   struct mhi_result *result);
+	void (*status_cb)(struct mhi_device *mhi_dev, enum MHI_CB mhi_cb);
+	struct device_driver driver;
+};
+
+#define to_mhi_driver(drv) container_of(drv, struct mhi_driver, driver)
+#define to_mhi_device(dev) container_of(dev, struct mhi_device, dev)
+
+static inline void mhi_device_set_devdata(struct mhi_device *mhi_dev,
+					  void *priv)
+{
+	mhi_dev->priv_data = priv;
+}
+
+static inline void *mhi_device_get_devdata(struct mhi_device *mhi_dev)
+{
+	return mhi_dev->priv_data;
+}
+
+/**
+ * mhi_queue_transfer - Queue a buffer to hardware
+ * All transfers are asyncronous transfers
+ * @mhi_dev: Device associated with the channels
+ * @dir: Data direction
+ * @buf: Data buffer (skb for hardware channels)
+ * @len: Size in bytes
+ * @mflags: Interrupt flags for the device
+ */
+static inline int mhi_queue_transfer(struct mhi_device *mhi_dev,
+				     enum dma_data_direction dir,
+				     void *buf,
+				     size_t len,
+				     enum MHI_FLAGS mflags)
+{
+	if (dir == DMA_TO_DEVICE)
+		return mhi_dev->ul_xfer(mhi_dev, mhi_dev->ul_chan, buf, len,
+					mflags);
+	else
+		return mhi_dev->dl_xfer(mhi_dev, mhi_dev->dl_chan, buf, len,
+					mflags);
+}
+
+static inline void *mhi_controller_get_devdata(struct mhi_controller *mhi_cntrl)
+{
+	return mhi_cntrl->priv_data;
+}
+
+static inline void mhi_free_controller(struct mhi_controller *mhi_cntrl)
+{
+	kfree(mhi_cntrl);
+}
+
+#if defined(CONFIG_MHI_BUS)
+
+/**
+ * mhi_driver_register - Register driver with MHI framework
+ * @mhi_drv: mhi_driver structure
+ */
+int mhi_driver_register(struct mhi_driver *mhi_drv);
+
+/**
+ * mhi_driver_unregister - Unregister a driver for mhi_devices
+ * @mhi_drv: mhi_driver structure
+ */
+void mhi_driver_unregister(struct mhi_driver *mhi_drv);
+
+/**
+ * mhi_device_configure - configure ECA or CCA context
+ * For offload channels that client manage, call this
+ * function to configure channel context or event context
+ * array associated with the channel
+ * @mhi_div: Device associated with the channels
+ * @dir: Direction of the channel
+ * @mhi_buf: Configuration data
+ * @elements: # of configuration elements
+ */
+int mhi_device_configure(struct mhi_device *mhi_div,
+			 enum dma_data_direction dir,
+			 struct mhi_buf *mhi_buf,
+			 int elements);
+
+/**
+ * mhi_device_get - disable all low power modes
+ * Only disables lpm, does not immediately exit low power mode
+ * if controller already in a low power mode
+ * @mhi_dev: Device associated with the channels
+ */
+void mhi_device_get(struct mhi_device *mhi_dev);
+
+/**
+ * mhi_device_get_sync - disable all low power modes
+ * Synchronously disable all low power, exit low power mode if
+ * controller already in a low power state
+ * @mhi_dev: Device associated with the channels
+ */
+int mhi_device_get_sync(struct mhi_device *mhi_dev);
+
+/**
+ * mhi_device_put - re-enable low power modes
+ * @mhi_dev: Device associated with the channels
+ */
+void mhi_device_put(struct mhi_device *mhi_dev);
+
+/**
+ * mhi_prepare_for_transfer - setup channel for data transfer
+ * Moves both UL and DL channel from RESET to START state
+ * @mhi_dev: Device associated with the channels
+ */
+int mhi_prepare_for_transfer(struct mhi_device *mhi_dev);
+
+/**
+ * mhi_unprepare_from_transfer -unprepare the channels
+ * Moves both UL and DL channels to RESET state
+ * @mhi_dev: Device associated with the channels
+ */
+void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev);
+
+/**
+ * mhi_get_no_free_descriptors - Get transfer ring length
+ * Get # of TD available to queue buffers
+ * @mhi_dev: Device associated with the channels
+ * @dir: Direction of the channel
+ */
+int mhi_get_no_free_descriptors(struct mhi_device *mhi_dev,
+				enum dma_data_direction dir);
+
+/**
+ * mhi_poll - poll for any available data to consume
+ * This is only applicable for DL direction
+ * @mhi_dev: Device associated with the channels
+ * @budget: In descriptors to service before returning
+ */
+int mhi_poll(struct mhi_device *mhi_dev, u32 budget);
+
+/**
+ * mhi_ioctl - user space IOCTL support for MHI channels
+ * Native support for setting  TIOCM
+ * @mhi_dev: Device associated with the channels
+ * @cmd: IOCTL cmd
+ * @arg: Optional parameter, iotcl cmd specific
+ */
+long mhi_ioctl(struct mhi_device *mhi_dev, unsigned int cmd, unsigned long arg);
+
+/**
+ * mhi_alloc_controller - Allocate mhi_controller structure
+ * Allocate controller structure and additional data for controller
+ * private data. You may get the private data pointer by calling
+ * mhi_controller_get_devdata
+ * @size: # of additional bytes to allocate
+ */
+struct mhi_controller *mhi_alloc_controller(size_t size);
+
+/**
+ * of_register_mhi_controller - Register MHI controller
+ * Registers MHI controller with MHI bus framework. DT must be supported
+ * @mhi_cntrl: MHI controller to register
+ */
+int of_register_mhi_controller(struct mhi_controller *mhi_cntrl);
+
+void mhi_unregister_mhi_controller(struct mhi_controller *mhi_cntrl);
+
+/**
+ * mhi_bdf_to_controller - Look up a registered controller
+ * Search for controller based on device identification
+ * @domain: RC domain of the device
+ * @bus: Bus device connected to
+ * @slot: Slot device assigned to
+ * @dev_id: Device Identification
+ */
+struct mhi_controller *mhi_bdf_to_controller(u32 domain, u32 bus, u32 slot,
+					     u32 dev_id);
+
+/**
+ * mhi_prepare_for_power_up - Do pre-initialization before power up
+ * This is optional, call this before power up if controller do not
+ * want bus framework to automatically free any allocated memory during shutdown
+ * process.
+ * @mhi_cntrl: MHI controller
+ */
+int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl);
+
+/**
+ * mhi_async_power_up - Starts MHI power up sequence
+ * @mhi_cntrl: MHI controller
+ */
+int mhi_async_power_up(struct mhi_controller *mhi_cntrl);
+int mhi_sync_power_up(struct mhi_controller *mhi_cntrl);
+
+/**
+ * mhi_power_down - Start MHI power down sequence
+ * @mhi_cntrl: MHI controller
+ * @graceful: link is still accessible, do a graceful shutdown process otherwise
+ * we will shutdown host w/o putting device into RESET state
+ */
+void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful);
+
+/**
+ * mhi_unprepare_after_powre_down - free any allocated memory for power up
+ * @mhi_cntrl: MHI controller
+ */
+void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl);
+
+/**
+ * mhi_pm_suspend - Move MHI into a suspended state
+ * Transition to MHI state M3 state from M0||M1||M2 state
+ * @mhi_cntrl: MHI controller
+ */
+int mhi_pm_suspend(struct mhi_controller *mhi_cntrl);
+
+/**
+ * mhi_pm_resume - Resume MHI from suspended state
+ * Transition to MHI state M0 state from M3 state
+ * @mhi_cntrl: MHI controller
+ */
+int mhi_pm_resume(struct mhi_controller *mhi_cntrl);
+
+/**
+ * mhi_download_rddm_img - Download ramdump image from device for
+ * debugging purpose.
+ * @mhi_cntrl: MHI controller
+ * @in_panic: If we trying to capture image while in kernel panic
+ */
+int mhi_download_rddm_img(struct mhi_controller *mhi_cntrl, bool in_panic);
+
+/**
+ * mhi_force_rddm_mode - Force external device into rddm mode
+ * to collect device ramdump. This is useful if host driver assert
+ * and we need to see device state as well.
+ * @mhi_cntrl: MHI controller
+ */
+int mhi_force_rddm_mode(struct mhi_controller *mhi_cntrl);
+
+#else
+
+static inline int mhi_driver_register(struct mhi_driver *mhi_drv)
+{
+	return -EINVAL;
+}
+
+static inline void mhi_driver_unregister(struct mhi_driver *mhi_drv)
+{
+}
+
+static inline int mhi_device_configure(struct mhi_device *mhi_div,
+				       enum dma_data_direction dir,
+				       struct mhi_buf *mhi_buf,
+				       int elements)
+{
+	return -EINVAL;
+}
+
+static inline void mhi_device_get(struct mhi_device *mhi_dev)
+{
+}
+
+static inline int mhi_device_get_sync(struct mhi_device *mhi_dev)
+{
+	return -EINVAL;
+}
+
+static inline void mhi_device_put(struct mhi_device *mhi_dev)
+{
+}
+
+static inline int mhi_prepare_for_transfer(struct mhi_device *mhi_dev)
+{
+	return -EINVAL;
+}
+
+static inline void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
+{
+
+}
+
+static inline int mhi_get_no_free_descriptors(struct mhi_device *mhi_dev,
+					      enum dma_data_direction dir)
+{
+	return -EINVAL;
+}
+
+static inline int mhi_poll(struct mhi_device *mhi_dev, u32 budget)
+{
+	return -EINVAL;
+}
+
+static inline long mhi_ioctl(struct mhi_device *mhi_dev,
+			     unsigned int cmd,
+			     unsigned long arg)
+{
+	return -EINVAL;
+}
+
+static inline struct mhi_controller *mhi_alloc_controller(size_t size)
+{
+	return NULL;
+}
+
+static inline int of_register_mhi_controller(struct mhi_controller *mhi_cntrl)
+{
+	return -EINVAL;
+}
+
+static inline void mhi_unregister_mhi_controller(
+					struct mhi_controller *mhi_cntrl)
+{
+}
+
+static inline struct mhi_controller *mhi_bdf_to_controller(u32 domain,
+							   u32 bus,
+							   u32 slot,
+							   u32 dev_id)
+{
+	return NULL;
+}
+
+static inline int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
+{
+	return -EINVAL;
+}
+
+static inline int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
+{
+	return -EINVAL;
+}
+
+static inline int mhi_sync_power_up(struct mhi_controller *mhi_cntrl)
+{
+	return -EINVAL;
+}
+
+static inline void mhi_power_down(struct mhi_controller *mhi_cntrl,
+				  bool graceful)
+{
+}
+
+static inline void mhi_unprepare_after_power_down(
+					struct mhi_controller *mhi_cntrl)
+{
+}
+
+static inline int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
+{
+	return -EINVAL;
+}
+
+static inline int mhi_pm_resume(struct mhi_controller *mhi_cntrl)
+{
+	return -EINVAL;
+}
+
+static inline int mhi_download_rddm_img(struct mhi_controller *mhi_cntrl,
+					bool in_panic)
+{
+	return -EINVAL;
+}
+
+static inlint int mhi_force_rddm_mode(struct mhi_controller *mhi_cntrl)
+{
+	return -EINVAL;
+}
+
+#endif
+
+#ifdef CONFIG_MHI_DEBUG
+
+#define MHI_VERB(fmt, ...) do { \
+		if (mhi_cntrl->klog_lvl <= MHI_MSG_LVL_VERBOSE) \
+			pr_debug("[D][%s] " fmt, __func__, ##__VA_ARGS__);\
+} while (0)
+
+#else
+
+#define MHI_VERB(fmt, ...)
+
+#endif
+
+#define MHI_LOG(fmt, ...) do {	\
+		if (mhi_cntrl->klog_lvl <= MHI_MSG_LVL_INFO) \
+			pr_info("[I][%s] " fmt, __func__, ##__VA_ARGS__);\
+} while (0)
+
+#define MHI_ERR(fmt, ...) do {	\
+		if (mhi_cntrl->klog_lvl <= MHI_MSG_LVL_ERROR) \
+			pr_err("[E][%s] " fmt, __func__, ##__VA_ARGS__); \
+} while (0)
+
+#define MHI_CRITICAL(fmt, ...) do { \
+		if (mhi_cntrl->klog_lvl <= MHI_MSG_LVL_CRITICAL) \
+			pr_alert("[C][%s] " fmt, __func__, ##__VA_ARGS__); \
+} while (0)
+
+
+#endif /* _MHI_H_ */
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 7d361be..1e11e30 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -734,4 +734,15 @@ struct tb_service_id {
 #define TBSVC_MATCH_PROTOCOL_VERSION	0x0004
 #define TBSVC_MATCH_PROTOCOL_REVISION	0x0008
 
+
+/**
+ * struct mhi_device_id - MHI device identification
+ * @chan: MHI channel name
+ * @driver_data: driver data;
+ */
+struct mhi_device_id {
+	const char *chan;
+	kernel_ulong_t driver_data;
+};
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
