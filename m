Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F41C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F3321F45
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nzJD3ZY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F3321F45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbeHIVFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 17:05:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60336 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeHIVFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 17:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=p5T2w+HfVL2jmooLqPEF/5ByRekM1JuNiSWocclykuo=; b=nzJD3ZY0+tqT6n92WF1cal+SVx
        0xHhtbTFGwrGlIXTwzNLYsQyp9S1iGTDdbj3C6IRBADtIcZHqvq67MClPJDGNBWxeqOFyAun+DsAo
        lqrrSQo2aWYG4Y7L2OODJIRXRDRGs5DIcv3jelWl4V0L+WFH4is8VS8xhssJDwVztk6K26VPTsRVz
        73fJn44LG877dvirIAp09zOwMl9engmgqSwBvc644SPWCzP//Mivx1suAzoSuGZoq8BIKKN+BDl3q
        sI9tcCN4DD88tvtbUtwQVRrgQPbToL2AWbThLp8PfNfUe3JsCEPpop6aFnRDpuYHvvrOMfYw9csFZ
        nl4L5+xg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fnpqV-00053D-R5; Thu, 09 Aug 2018 18:39:40 +0000
Subject: Re: [PATCH v2 1/7] mhi_bus: core: initial checkin for modem host
 interface bus driver
To:     Sujeev Dias <sdias@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Tony Truong <truong@codeaurora.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-2-git-send-email-sdias@codeaurora.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <54105ec4-9bf7-2d28-6525-0dae4cf859f1@infradead.org>
Date:   Thu, 9 Aug 2018 11:39:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531166894-30984-2-git-send-email-sdias@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2018 01:08 PM, Sujeev Dias wrote:
> This is the initial skeleton driver for mhi bus stack. MHI Host
> Interface is a communication protocol to be used by the host to
> control and communcate with modem over a high speed peripheral bus.

              communicate

> This module will allow host to communicate with external devices that
> support MHI protocol.
> 
> Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
> Reviewed-by: Tony Truong <truong@codeaurora.org>
> Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> ---
>  Documentation/00-INDEX                        |   2 +
>  Documentation/devicetree/bindings/bus/mhi.txt | 258 ++++++++++++
>  Documentation/mhi.txt                         | 235 +++++++++++
>  drivers/bus/Kconfig                           |   8 +
>  drivers/bus/Makefile                          |   1 +
>  drivers/bus/mhi/Makefile                      |   6 +
>  drivers/bus/mhi/core/Makefile                 |   1 +
>  drivers/bus/mhi/core/mhi_init.c               | 538 ++++++++++++++++++++++++++
>  drivers/bus/mhi/core/mhi_internal.h           | 238 ++++++++++++
>  drivers/bus/mhi/core/mhi_main.c               | 122 ++++++
>  include/linux/mhi.h                           | 341 ++++++++++++++++
>  include/linux/mod_devicetable.h               |  12 +
>  12 files changed, 1762 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/mhi.txt
>  create mode 100644 Documentation/mhi.txt
>  create mode 100644 drivers/bus/mhi/Makefile
>  create mode 100644 drivers/bus/mhi/core/Makefile
>  create mode 100644 drivers/bus/mhi/core/mhi_init.c
>  create mode 100644 drivers/bus/mhi/core/mhi_internal.h
>  create mode 100644 drivers/bus/mhi/core/mhi_main.c
>  create mode 100644 include/linux/mhi.h
> 

> diff --git a/Documentation/devicetree/bindings/bus/mhi.txt b/Documentation/devicetree/bindings/bus/mhi.txt
> new file mode 100644
> index 0000000..19deb84
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/mhi.txt
> @@ -0,0 +1,258 @@
> +MHI Host Interface
> +
> +MHI used by the host to control and communicate with modem over

   MHI is used

> +high speed peripheral bus.
> +
> +==============
> +Node Structure
> +==============
> +
> +Main node properties:
> +
> +- mhi,max-channels
> +  Usage: required
> +  Value type: <u32>
> +  Definition: Maximum number of channels supported by this controller
> +
> +- mhi,timeout
> +  Usage: optional
> +  Value type: <u32>
> +  Definition: Maximum timeout in ms wait for state and cmd completion
> +
> +- mhi,use-bb
> +  Usage: optional
> +  Value type: <bool>
> +  Definition: Set true, if PCIe controller does not have full access to host
> +	DDR, and we're using a dedicated memory pool like cma, or
> +	carveout pool. Pool must support atomic allocation.
> +
> +- mhi,buffer-len
> +  Usage: optional
> +  Value type: <bool>
> +  Definition: MHI automatically pre-allocate buffers for some channel.
> +	Set the length of buffer size to allocate. If not default
> +	size MHI_MAX_MTU will be used.
> +
> +============================
> +mhi channel node properties:
> +============================
> +
> +- reg
> +  Usage: required
> +  Value type: <u32>
> +  Definition: physical channel number
> +
> +- label
> +  Usage: required
> +  Value type: <string>
> +  Definition: given name for the channel
> +
> +- mhi,num-elements
> +  Usage: optional
> +  Value type: <u32>
> +  Definition: Number of elements transfer ring support
> +
> +- mhi,event-ring
> +  Usage: required
> +  Value type: <u32>
> +  Definition: Event ring index associated with this channel
> +
> +- mhi,chan-dir
> +  Usage: required
> +  Value type: <u32>
> +  Definition: Channel direction as defined by enum dma_data_direction
> +	0 = Bidirectional data transfer
> +	1 = UL data transfer
> +	2 = DL data transfer
> +	3 = No direction, not a regular data transfer channel
> +
> +- mhi,ee
> +  Usage: required
> +  Value type: <u32>
> +  Definition: Channel execution enviornment as defined by enum MHI_EE

                                   environment

> +	1 = Bootloader stage
> +	2 = AMSS mode
> +
> +- mhi,pollcfg
> +  Usage: optional
> +  Value type: <u32>
> +  Definition: MHI poll configuration, valid only when burst mode is enabled
> +	0 = Use default (device specific) polling configuration
> +	For UL channels, value specifies the timer to poll MHI context in
> +	milliseconds.
> +	For DL channels, the threshold to poll the MHI context in multiple of
> +	eight ring element.
> +
> +- mhi,data-type
> +  Usage: required
> +  Value type: <u32>
> +  Definition: Data transfer type accepted as defined by enum MHI_XFER_TYPE
> +	0 = accept cpu address for buffer
> +	1 = accept skb
> +	2 = accept scatterlist
> +	3 = offload channel, does not accept any transfer type
> +
> +- mhi,doorbell-mode
> +  Usage: required
> +  Value type: <u32>
> +  Definition: Channel doorbell mode configuration as defined by enum
> +	MHI_BRSTMODE
> +	2 = burst mode disabled
> +	3 = burst mode enabled
> +
> +- mhi,lpm-notify
> +  Usage: optional
> +  Value type: <bool>
> +  Definition: This channel master require low power mode enter and exit
> +  notifications from mhi bus master.
> +
> +- mhi,offload-chan
> +  Usage: optional
> +  Value type: <bool>
> +  Definition: Client managed channel, MHI host only involved in setting up
> +	the data path, not involved in active data path.
> +
> +- mhi,db-mode-switch
> +  Usage: optional
> +  Value type: <bool>
> +  Definition: Must switch to doorbell mode whenever MHI M0 state transition
> +	happens.
> +
> +- mhi,auto-queue
> +  Usage: optional
> +  Value type: <bool>
> +  Definition: MHI bus driver will pre-allocate buffers for this channel and
> +	queue to hardware. If set, client not allowed to queue buffers. Valid
> +	only for downlink direction.
> +
> +- mhi,auto-start
> +  Usage: optional
> +  Value type: <bool>
> +  Definition: MHI host driver to automatically start channels once mhi device
> +	driver probe is complete. This should be only set true if initial
> +	handshake iniaitead by external modem.

	          initiated

> +
> +==========================
> +mhi event node properties:
> +==========================
> +
> +- mhi,num-elements
> +  Usage: required
> +  Value type: <u32>
> +  Definition: Number of elements event ring support
> +
> +- mhi,intmod
> +  Usage: required
> +  Value type: <u32>
> +  Definition: interrupt moderation time in ms
> +
> +- mhi,msi
> +  Usage: required
> +  Value type: <u32>
> +  Definition: MSI associated with this event ring
> +
> +- mhi,chan
> +  Usage: optional
> +  Value type: <u32>
> +  Definition: Dedicated channel number, if it's a dedicated event ring
> +
> +- mhi,priority
> +  Usage: required
> +  Value type: <u32>
> +  Definition: Event ring priority, set to 1 for now
> +
> +- mhi,brstmode
> +  Usage: required
> +  Value type: <u32>
> +  Definition: Event doorbell mode configuration as defined by
> +	enum MHI_BRSTMODE
> +		2 = burst mode disabled
> +		3 = burst mode enabled
> +
> +- mhi,data-type
> +  Usage: optional
> +  Value type: <u32>
> +  Definition: Type of data this event ring will process as defined
> +	by enum mhi_er_data_type
> +		0 = process data packets (default)
> +		1 = process mhi control packets
> +
> +- mhi,hw-ev
> +  Usage: optional
> +  Value type: <bool>
> +  Definition: Event ring associated with hardware channels
> +
> +- mhi,client-manage
> +  Usage: optional
> +  Value type: <bool>
> +  Definition: Client manages the event ring (use by napi_poll)
> +
> +- mhi,offload
> +  Usage: optional
> +  Value type: <bool>
> +  Definition: Event ring associated with offload channel
> +
> +
> +Children node properties:
> +
> +MHI drivers that require DT can add driver specific information as a child node.
> +
> +- mhi,chan
> +  Usage: Required
> +  Value type: <string>
> +  Definition: Channel name
> +
> +========
> +Example:
> +========
> +mhi_controller {
> +	mhi,max-channels = <105>;
> +
> +	mhi_chan@0 {
> +		reg = <0>;
> +		label = "LOOPBACK";
> +		mhi,num-elements = <64>;
> +		mhi,event-ring = <2>;
> +		mhi,chan-dir = <1>;
> +		mhi,data-type = <0>;
> +		mhi,doorbell-mode = <2>;
> +		mhi,ee = <2>;
> +	};
> +
> +	mhi_chan@1 {
> +		reg = <1>;
> +		label = "LOOPBACK";
> +		mhi,num-elements = <64>;
> +		mhi,event-ring = <2>;
> +		mhi,chan-dir = <2>;
> +		mhi,data-type = <0>;
> +		mhi,doorbell-mode = <2>;
> +		mhi,ee = <2>;
> +	};
> +
> +	mhi_event@0 {
> +		mhi,num-elements = <32>;
> +		mhi,intmod = <1>;
> +		mhi,msi = <1>;
> +		mhi,chan = <0>;
> +		mhi,priority = <1>;
> +		mhi,bstmode = <2>;
> +		mhi,data-type = <1>;
> +	};
> +
> +	mhi_event@1 {
> +		mhi,num-elements = <256>;
> +		mhi,intmod = <1>;
> +		mhi,msi = <2>;
> +		mhi,chan = <0>;
> +		mhi,priority = <1>;
> +		mhi,bstmode = <2>;
> +	};
> +
> +	mhi,timeout = <500>;
> +
> +	children_node {
> +		mhi,chan = "LOOPBACK"
> +		<driver specific properties>
> +	};
> +};
> diff --git a/Documentation/mhi.txt b/Documentation/mhi.txt
> new file mode 100644
> index 0000000..1c501f1
> --- /dev/null
> +++ b/Documentation/mhi.txt
> @@ -0,0 +1,235 @@
> +Overview of Linux kernel MHI support
> +====================================
> +
> +Modem-Host Interface (MHI)
> +=========================
> +MHI used by the host to control and communicate with modem over high speed

   MHI is used

> +peripheral bus. Even though MHI can be easily adapt to any peripheral buses,

                                                 adapted

> +primarily used with PCIe based devices. The host has one or more PCIe root

   it is primarily used with

> +ports connected to modem device. The host has limited access to device memory
> +space, including register configuration and control the device operation.

                                           and control of the

> +Data transfers are invoked from the device.
> +
> +All data structures used by MHI are in the host system memory. Using PCIe
> +interface, the device accesses those data structures. MHI data structures and
> +data buffers in the host system memory regions are mapped for device.
> +
> +Memory spaces
> +-------------
> +PCIe Configurations : Used for enumeration and resource management, such as
> +interrupt and base addresses.  This is done by mhi control driver.
> +
> +MMIO
> +----
> +MHI MMIO : Memory mapped IO consists of set of registers in the device hardware,
> +which are mapped to the host memory space through PCIe base address register
> +(BAR)

   (BAR).

> +
> +MHI control registers : Access to MHI configurations registers
> +(struct mhi_controller.regs).
> +
> +MHI BHI register: Boot host interface registers (struct mhi_controller.bhi) used
> +for firmware download before MHI initialization.
> +
> +Channel db array : Doorbell registers (struct mhi_chan.tre_ring.db_addr) used by
> +host to notify device there is new work to do.
> +
> +Event db array : Associated with event context array
> +(struct mhi_event.ring.db_addr), host uses to notify device free events are
> +available.
> +
> +Data structures
> +---------------
> +Host memory : Directly accessed by the host to manage the MHI data structures
> +and buffers. The device accesses the host memory over the PCIe interface.
> +
> +Channel context array : All channel configurations are organized in channel
> +context data array.
> +
> +struct __packed mhi_chan_ctxt;
> +struct mhi_ctxt.chan_ctxt;
> +
> +Transfer rings : Used by host to schedule work items for a channel and organized
> +as a circular queue of transfer descriptors (TD).
> +
> +struct __packed mhi_tre;
> +struct mhi_chan.tre_ring;
> +
> +Event context array : All event configurations are organized in event context
> +data array.
> +
> +struct mhi_ctxt.er_ctxt;
> +struct __packed mhi_event_ctxt;
> +
> +Event rings: Used by device to send completion and state transition messages to
> +host
> +
> +struct mhi_event.ring;
> +struct __packed mhi_tre;
> +
> +Command context array: All command configurations are organized in command
> +context data array.
> +
> +struct __packed mhi_cmd_ctxt;
> +struct mhi_ctxt.cmd_ctxt;
> +
> +Command rings: Used by host to send MHI commands to device
> +
> +struct __packed mhi_tre;
> +struct mhi_cmd.ring;
> +
> +Transfer rings
> +--------------
> +MHI channels are logical, unidirectional data pipes between host and device.
> +Each channel associated with a single transfer ring.  The data direction can be

        channel is associated

> +either inbound (device to host) or outbound (host to device).  Transfer
> +descriptors are managed by using transfer rings, which are defined for each
> +channel between device and host and resides in the host memory.
> +
> +Transfer ring Pointer:	  	Transfer Ring Array
> +[Read Pointer (RP)] ----------->[Ring Element] } TD
> +[Write Pointer (WP)]-		[Ring Element]
> +                     -		[Ring Element]
> +		      --------->[Ring Element]
> +				[Ring Element]
> +
> +1. Host allocate memory for transfer ring

           allocates

> +2. Host sets base, read pointer, write pointer in corresponding channel context
> +3. Ring is considered empty when RP == WP
> +4. Ring is considered full when WP + 1 == RP
> +4. RP indicates the next element to be serviced by device
> +4. When host new buffer to send, host update the Ring element with buffer

           host has new buffer to send, host updates

> +   information
> +5. Host increment the WP to next element

           increments

> +6. Ring the associated channel DB.
> +
> +Event rings
> +-----------
> +Events from the device to host are organized in event rings and defined in event
> +descriptors.  Event rings are array of EDs that resides in the host memory.
> +
> +Transfer ring Pointer:	  	Event Ring Array
> +[Read Pointer (RP)] ----------->[Ring Element] } ED
> +[Write Pointer (WP)]-		[Ring Element]
> +                     -		[Ring Element]
> +		      --------->[Ring Element]
> +				[Ring Element]
> +
> +1. Host allocate memory for event ring

           allocates

> +2. Host sets base, read pointer, write pointer in corresponding channel context
> +3. Both host and device has local copy of RP, WP
> +3. Ring is considered empty (no events to service) when WP + 1 == RP
> +4. Ring is full of events when RP == WP
> +4. RP - 1 = last event device programmed
> +4. When there is a new event device need to send, device update ED pointed by RP

                                       needs to send, device updates


> +5. Device increment RP to next element

             increments

> +6. Device trigger and interrupt

             triggers an interrupt

> +
> +Example Operation for data transfer:
> +
> +1. Host prepare TD with buffer information

           prepares

> +2. Host increment Chan[id].ctxt.WP

           increments

> +3. Host ring channel DB register

           rings

> +4. Device wakes up process the TD

             wakes up to process the TD

> +5. Device generate a completion event for that TD by updating ED

             generates

> +6. Device increment Event[id].ctxt.RP

             increments

> +7. Device trigger MSI to wake host

             triggers

> +8. Host wakes up and check event ring for completion event

                    and checks

> +9. Host update the Event[i].ctxt.WP to indicate processed of completion event.

           updates                                 processing

> +
> +MHI States
> +----------
> +
> +enum MHI_STATE {
> +MHI_STATE_RESET : MHI is in reset state, POR state. Host is not allowed to
> +		  access device MMIO register space.
> +MHI_STATE_READY : Device is ready for initialization. Host can start MHI
> +		  initialization by programming MMIO

		                                MMIO.

> +MHI_STATE_M0 : MHI is in fully active state, data transfer is active
> +MHI_STATE_M1 : Device in a suspended state
> +MHI_STATE_M2 : MHI in low power mode, device may enter lower power mode.
> +MHI_STATE_M3 : Both host and device in suspended state.  PCIe link is not
> +	       accessible to device.
> +
> +MHI Initialization
> +------------------
> +
> +1. After system boots, the device is enumerated over PCIe interface
> +2. Host allocate MHI context for event, channel and command arrays

           allocates

> +3. Initialize context array, and prepare interrupts
> +3. Host waits until device enter READY state

                              enters

> +4. Program MHI MMIO registers and set device into MHI_M0 state
> +5. Wait for device to enter M0 state
> +
> +Linux Software Architecture
> +===========================
> +
> +MHI Controller
> +--------------
> +MHI controller is also the MHI bus master. In charge of managing the physical
> +link between host and device.  Not involved in actual data transfer.  At least
> +for PCIe based buses, for other type of bus, we can expand to add support.

^^^^^ Too many sentence fragments...

> +
> +Roles:
> +1. Turn on PCIe bus and configure the link
> +2. Configure MSI, SMMU, and IOMEM
> +3. Allocate struct mhi_controller and register with MHI bus framework
> +2. Initiate power on and shutdown sequence
> +3. Initiate suspend and resume
> +
> +Usage
> +-----
> +
> +1. Allocate control data structure by calling mhi_alloc_controller()
> +2. Initialize mhi_controller with all the known information such as:
> +   - Device Topology
> +   - IOMMU window
> +   - IOMEM mapping
> +   - Device to use for memory allocation, and of_node with DT configuration
> +   - Configure asynchronous callback functions
> +3. Register MHI controller with MHI bus framework by calling
> +   of_register_mhi_controller()
> +
> +After successfully registering controller can initiate any of these power modes:
> +
> +1. Power up sequence
> +   - mhi_prepare_for_power_up()
> +   - mhi_async_power_up()
> +   - mhi_sync_power_up()
> +2. Power down sequence
> +   - mhi_power_down()
> +   - mhi_unprepare_after_power_down()
> +3. Initiate suspend
> +   - mhi_pm_suspend()
> +4. Initiate resume
> +   - mhi_pm_resume()
> +
> +MHI Devices
> +-----------
> +Logical device that bind to maximum of two physical MHI channels. Once MHI is in

^^^^^ not-a-sentence.

> +powered on state, each supported channel by controller will be allocated as a

                                                                            as an

> +mhi_device.
> +
> +Each supported device would be enumerated under

how about:
Each supported device is enumerated in /sys/bus/mhi/devices

> +/sys/bus/mhi/devices/
> +
> +struct mhi_device;
> +
> +MHI Driver
> +----------
> +Each MHI driver can bind to one or more MHI devices. MHI host driver will bind
> +mhi_device to mhi_driver.
> +
> +All registered drivers are visible under
> +/sys/bus/mhi/drivers/
> +
> +struct mhi_driver;
> +
> +Usage
> +-----
> +
> +1. Register driver using mhi_driver_register
> +2. Before sending data, prepare device for transfer by calling
> +   mhi_prepare_for_transfer
> +3. Initiate data transfer by calling mhi_queue_transfer
> +4. After finish, call mhi_unprepare_from_transfer to end data transfer


> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> new file mode 100644
> index 0000000..c80685e9
> --- /dev/null
> +++ b/include/linux/mhi.h
> @@ -0,0 +1,341 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + *
> + */
> +#ifndef _MHI_H_
> +#define _MHI_H_
> +
> +struct mhi_chan;
> +struct mhi_event;
> +struct mhi_ctxt;
> +struct mhi_cmd;
> +struct mhi_buf_info;
> +
> +/**
> + * enum MHI_CB - MHI callback
> + * @MHI_CB_IDLE: MHI entered idle state
> + * @MHI_CB_PENDING_DATA: New data available for client to process
> + * @MHI_CB_LPM_ENTER: MHI host entered low power mode
> + * @MHI_CB_LPM_EXIT: MHI host about to exit low power mode
> + * @MHI_CB_EE_RDDM: MHI device entered RDDM execution enviornment
> + */
> +enum MHI_CB {
> +	MHI_CB_IDLE,
> +	MHI_CB_PENDING_DATA,
> +	MHI_CB_LPM_ENTER,
> +	MHI_CB_LPM_EXIT,
> +	MHI_CB_EE_RDDM,
> +};
> +
> +/**
> + * enum MHI_FLAGS - Transfer flags
> + * @MHI_EOB: End of buffer for bulk transfer
> + * @MHI_EOT: End of transfer
> + * @MHI_CHAIN: Linked transfer
> + */
> +enum MHI_FLAGS {
> +	MHI_EOB,
> +	MHI_EOT,
> +	MHI_CHAIN,
> +};
> +
> +/**
> + * enum mhi_device_type - Device types
> + * @MHI_XFER_TYPE: Handles data transfer
> + * @MHI_TIMESYNC_TYPE: Use for timesync feature
> + * @MHI_CONTROLLER_TYPE: Control device
> + */
> +enum mhi_device_type {
> +	MHI_XFER_TYPE,
> +	MHI_TIMESYNC_TYPE,
> +	MHI_CONTROLLER_TYPE,
> +};
> +

> +/**
> + * struct mhi_device - mhi device structure associated bind to channel

                                               ^^^ I don't understand what that
                                               is trying to say.

> + * @dev: Device associated with the channels
> + * @mtu: Maximum # of bytes controller support
> + * @ul_chan_id: MHI channel id for UL transfer
> + * @dl_chan_id: MHI channel id for DL transfer
> + * @tiocm: Device current terminal settings
> + * @priv: Driver private data
> + */
> +struct mhi_device {
> +	struct device dev;
> +	u32 dev_id;
> +	u32 domain;
> +	u32 bus;
> +	u32 slot;
> +	size_t mtu;
> +	int ul_chan_id;
> +	int dl_chan_id;
> +	int ul_event_id;
> +	int dl_event_id;
> +	u32 tiocm;
> +	const struct mhi_device_id *id;
> +	const char *chan_name;
> +	struct mhi_controller *mhi_cntrl;
> +	struct mhi_chan *ul_chan;
> +	struct mhi_chan *dl_chan;
> +	atomic_t dev_wake;
> +	enum mhi_device_type dev_type;
> +	void *priv_data;
> +	int (*ul_xfer)(struct mhi_device *mhi_dev, struct mhi_chan *mhi_chan,
> +		       void *buf, size_t len, enum MHI_FLAGS flags);
> +	int (*dl_xfer)(struct mhi_device *mhi_dev, struct mhi_chan *mhi_chan,
> +		       void *buf, size_t len, enum MHI_FLAGS flags);
> +	void (*status_cb)(struct mhi_device *mhi_dev, enum MHI_CB cb);
> +};
> +
> +/**
> + * struct mhi_result - Completed buffer information
> + * @buf_addr: Address of data buffer
> + * @dir: Channel direction
> + * @bytes_xfer: # of bytes transferred
> + * @transaction_status: Status of last trasnferred

                                  of last transfer

> + */
> +struct mhi_result {
> +	void *buf_addr;
> +	enum dma_data_direction dir;
> +	size_t bytes_xferd;
> +	int transaction_status;
> +};
> +
> +/**
> + * struct mhi_driver - mhi driver information
> + * @id_table: NULL terminated channel ID names
> + * @ul_xfer_cb: UL data transfer callback
> + * @dl_xfer_cb: DL data transfer callback
> + * @status_cb: Asynchronous status callback
> + */
> +struct mhi_driver {
> +	const struct mhi_device_id *id_table;
> +	int (*probe)(struct mhi_device *mhi_dev,
> +		     const struct mhi_device_id *id);
> +	void (*remove)(struct mhi_device *mhi_dev);
> +	void (*ul_xfer_cb)(struct mhi_device *mhi_dev,
> +			   struct mhi_result *result);
> +	void (*dl_xfer_cb)(struct mhi_device *mhi_dev,
> +			   struct mhi_result *result);
> +	void (*status_cb)(struct mhi_device *mhi_dev, enum MHI_CB mhi_cb);
> +	struct device_driver driver;
> +};
> +
> +#define to_mhi_driver(drv) container_of(drv, struct mhi_driver, driver)
> +#define to_mhi_device(dev) container_of(dev, struct mhi_device, dev)
> +
> +static inline void mhi_device_set_devdata(struct mhi_device *mhi_dev,
> +					  void *priv)
> +{
> +	mhi_dev->priv_data = priv;
> +}
> +
> +static inline void *mhi_device_get_devdata(struct mhi_device *mhi_dev)
> +{
> +	return mhi_dev->priv_data;
> +}
> +
> +static inline void *mhi_controller_get_devdata(struct mhi_controller *mhi_cntrl)
> +{
> +	return mhi_cntrl->priv_data;
> +}
> +
> +static inline void mhi_free_controller(struct mhi_controller *mhi_cntrl)
> +{
> +	kfree(mhi_cntrl);
> +}
> +
> +/**
> + * mhi_driver_register - Register driver with MHI framework
> + * @mhi_drv: mhi_driver structure
> + */
> +int mhi_driver_register(struct mhi_driver *mhi_drv);
> +
> +/**
> + * mhi_driver_unregister - Unregister a driver for mhi_devices
> + * @mhi_drv: mhi_driver structure
> + */
> +void mhi_driver_unregister(struct mhi_driver *mhi_drv);
> +
> +/**
> + * mhi_alloc_controller - Allocate mhi_controller structure
> + * Allocate controller structure and additional data for controller
> + * private data. You may get the private data pointer by calling
> + * mhi_controller_get_devdata
> + * @size: # of additional bytes to allocate
> + */
> +struct mhi_controller *mhi_alloc_controller(size_t size);
> +
> +/**
> + * of_register_mhi_controller - Register MHI controller
> + * Registers MHI controller with MHI bus framework. DT must be supported
> + * @mhi_cntrl: MHI controller to register
> + */
> +int of_register_mhi_controller(struct mhi_controller *mhi_cntrl);
> +
> +void mhi_unregister_mhi_controller(struct mhi_controller *mhi_cntrl);
> +
> +/**
> + * mhi_bdf_to_controller - Look up a registered controller
> + * Search for controller based on device identification
> + * @domain: RC domain of the device

What is an RC domain?

> + * @bus: Bus device connected to
> + * @slot: Slot device assigned to
> + * @dev_id: Device Identification
> + */
> +struct mhi_controller *mhi_bdf_to_controller(u32 domain, u32 bus, u32 slot,
> +					     u32 dev_id);
> +
> +#endif /* _MHI_H_ */


thanks,
-- 
~Randy
