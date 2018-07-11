Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12B1C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B54E2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B54E2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387974AbeGKTgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:36:01 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45389 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387634AbeGKTgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:36:01 -0400
Received: by mail-oi0-f67.google.com with SMTP id q11-v6so25798036oic.12;
        Wed, 11 Jul 2018 12:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kq8nBZ16kSwFWYm2L/xXnofrqG23y29jYB4Ely/7apQ=;
        b=MME6pU+CFuISd4nY/z1WqmG6c9O+Hl0Whb25bUsL73hOqt3YBZuk/F9KV3dVOL5VYH
         FDakK2al8lIhQ+yT2K6ZVlV2pcgbvvgGorCPyd+ZwAE2UsDcTb7ZiE/OJwE+Mhen9WJX
         DJ3RXy97Mt8I/GYUMoQFY/jlyicyeCyJ174Ymp1mj2oIVxkH/Zl3bC3q+L0EgWqXRSWw
         GFGmcCFhxZactZKImX5IlUz4HAzuGi8ZAVTTNCMn3TIXJL2pOqe4vUQH78ZC2Qm0hdSg
         nJv07r7axyUUuPNgdcXKI4UmPX/P4GtmhTzk/l0QBg5+urKoc1LMpwQJzWFLSUGkky/h
         I9Vg==
X-Gm-Message-State: AOUpUlEpO/P52dyKLdWxApBj8jZRZzTGbvLesYoqxpMQXDS3piBs/DuG
        t4gIaVSE7eYCBSTH+g1fZQ==
X-Google-Smtp-Source: AAOMgpfjZSrCzPYmn6G5aNG+nP1OfgWHj8LMWxPp35qE+fQ+NEq+xx9FSEcywgrf/5J9vNGRHPQ4fw==
X-Received: by 2002:aca:4ec6:: with SMTP id c189-v6mr717120oib.186.1531337413693;
        Wed, 11 Jul 2018 12:30:13 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id x5-v6sm5621004oix.3.2018.07.11.12.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 12:30:12 -0700 (PDT)
Date:   Wed, 11 Jul 2018 13:30:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sujeev Dias <sdias@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Tony Truong <truong@codeaurora.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: Re: [PATCH v2 1/7] mhi_bus: core: initial checkin for modem host
 interface bus driver
Message-ID: <20180711193011.GA8659@rob-hp-laptop>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-2-git-send-email-sdias@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531166894-30984-2-git-send-email-sdias@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 01:08:08PM -0700, Sujeev Dias wrote:
> This is the initial skeleton driver for mhi bus stack. MHI Host
> Interface is a communication protocol to be used by the host to
> control and communcate with modem over a high speed peripheral bus.
> This module will allow host to communicate with external devices that
> support MHI protocol.
> 
> Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
> Reviewed-by: Tony Truong <truong@codeaurora.org>
> Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> ---
>  Documentation/00-INDEX                        |   2 +
>  Documentation/devicetree/bindings/bus/mhi.txt | 258 ++++++++++++

As Greg said, separate patch.

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

> diff --git a/Documentation/devicetree/bindings/bus/mhi.txt b/Documentation/devicetree/bindings/bus/mhi.txt
> new file mode 100644
> index 0000000..19deb84
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/mhi.txt
> @@ -0,0 +1,258 @@
> +MHI Host Interface
> +
> +MHI used by the host to control and communicate with modem over
> +high speed peripheral bus.
> +
> +==============
> +Node Structure
> +==============
> +
> +Main node properties:
> +
> +- mhi,max-channels

mhi is not a vendor. mhi-max-channels. Same for rest. Or maybe just drop 
'mhi' completely.

> +  Usage: required
> +  Value type: <u32>
> +  Definition: Maximum number of channels supported by this controller
> +
> +- mhi,timeout
> +  Usage: optional
> +  Value type: <u32>
> +  Definition: Maximum timeout in ms wait for state and cmd completion

Needs a unit suffix.

> +
> +- mhi,use-bb
> +  Usage: optional
> +  Value type: <bool>
> +  Definition: Set true, if PCIe controller does not have full access to host
> +	DDR, and we're using a dedicated memory pool like cma, or
> +	carveout pool. Pool must support atomic allocation.

How is this related to PCI?

"atomic allocation" has nothing to do with bindings.

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

Why does the user need this?

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

typo

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

This is a lot of properties. I suspect that many of these should be 
implied by the modem device or be driver settings. If the modems are PCI 
devices, then you should be able to determine a lot from the PCI 
VID/PIDs.

I'm not sure that a bus is appropriate here either. This looks like the 
next layer up. How's it different than a programming model for some 
ethernet NIC?

Rob
