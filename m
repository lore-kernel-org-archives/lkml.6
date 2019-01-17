Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510D9C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FF520652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nTLoB6CL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bluhYmJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfAQRww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:52:52 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37038 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfAQRww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:52:52 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 80AE06075A; Thu, 17 Jan 2019 17:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547747570;
        bh=bgJA5kF6sOaBdN9jp/46eL30PaIJKD9L12jLagGTIWQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nTLoB6CL92dVvY6lN+TnMGoRsVnqweoq5h8qGPC3fRonbV5kGHXDpsni9X1Zt4c/s
         nkVSYZBlUUTSBDJruI2iF375zn2cQaEXdpc/wdn+SUp1PbdxF12ygOP0WReOjnA4X3
         Sse7VrTo7x4x4ejUw4r2Vdlb5wPHpyFNZ5xgr1ms=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D5CAE605A0;
        Thu, 17 Jan 2019 17:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547747569;
        bh=bgJA5kF6sOaBdN9jp/46eL30PaIJKD9L12jLagGTIWQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bluhYmJiPxeXbFV9TTiYu3dimYeDgZmgUvfChbbzNaGPLsxr0GO7CJUmcYhKEBOsb
         r0IPf3ouv3pPP4EobPE2D1Z08xLxwkFTREtDX6JFWF9E9THiLHWvn6Wh5q5bkgk2jT
         LSqn/hy21aNS57t9ChmGFDngT0CrKoOXCeuuscX0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5CAE605A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v2 0/6] MSM8998 basic USB support
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1547483754-5296-1-git-send-email-jhugo@codeaurora.org>
 <a3602623-b0b1-2218-c801-746943f1728a@free.fr>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <b5ea4d67-1159-932d-eadc-71740f8127bb@codeaurora.org>
Date:   Thu, 17 Jan 2019 10:52:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a3602623-b0b1-2218-c801-746943f1728a@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/2019 9:35 AM, Marc Gonzalez wrote:
> On 14/01/2019 17:35, Jeffrey Hugo wrote:
> 
>> This series provides basic USB support for MSM8998.  Currently missing is
>> wiring up the Type-C detection logic so that the controller can correctly
>> switch between host and peripheral modes.  Work to implement that is
>> ongoing, and expected to appear soon in followup patches.  Also missing is
>> Display Port (DP) support which apparently is different from sdm845 and
>> needs additional investigation.
>>
>> v2:
>> -Fixed typo in QUSB2 bindings changes
>> -Split out bindings changes
>> -Fixed dual lane support in QMP to reflect Doug's updates
>> -Dropped the clock fixes which were accepted
>>
>> Jeffrey Hugo (6):
>>    clk: qcom: Add missing freq for usb30_master_clk on 8998
>>    clk: qcom: Skip halt checks on gcc_usb3_phy_pipe_clk for 8998
>>    phy: qcom-qusb2: Add QUSB2 PHY support for msm8998
>>    phy: qcom-qmp: Add QMP V3 USB3 PHY support for msm8998
>>    usb: dwc3: qcom: Add support for MSM8998
>>    arm64: dts: qcom: msm8998: Add USB-related nodes
>>
>>   .../devicetree/bindings/phy/qcom-qmp-phy.txt       |   5 +
>>   .../devicetree/bindings/phy/qcom-qusb2-phy.txt     |   1 +
>>   .../devicetree/bindings/usb/qcom,dwc3.txt          |   1 +
>>   arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi          |  22 ++++
>>   arch/arm64/boot/dts/qcom/msm8998.dtsi              |  90 +++++++++++++
>>   drivers/clk/qcom/gcc-msm8998.c                     |   3 +-
>>   drivers/phy/qualcomm/phy-qcom-qmp.c                | 142 +++++++++++++++++++++
>>   drivers/phy/qualcomm/phy-qcom-qmp.h                |   4 +
>>   drivers/phy/qualcomm/phy-qcom-qusb2.c              |  41 ++++++
>>   drivers/usb/dwc3/dwc3-qcom.c                       |   1 +
>>   10 files changed, 309 insertions(+), 1 deletion(-)
> 
> I am not able to say why (yet) but this doesn't work for me.
> Nothing happens when I insert a USB device. Any ideas?

No idea right now.  I'm out traveling.  Be back Monday.  Lets sync up 
then and figure this out for you.

> 
> # lsusb -v
> 
> Bus 002 Device 001: ID 1d6b:0003
> Device Descriptor:
>    bLength                18
>    bDescriptorType         1
>    bcdUSB               3.00
>    bDeviceClass            9
>    bDeviceSubClass         0
>    bDeviceProtocol         3
>    bMaxPacketSize0         9
>    idVendor           0x1d6b
>    idProduct          0x0003
>    bcdDevice            5.00
>    iManufacturer           3 Linux 5.0.0-rc1 xhci-hcd
>    iProduct                2 xHCI Host Controller
>    iSerial                 1 xhci-hcd.0.auto
>    bNumConfigurations      1
>    Configuration Descriptor:
>      bLength                 9
>      bDescriptorType         2
>      wTotalLength       0x001f
>      bNumInterfaces          1
>      bConfigurationValue     1
>      iConfiguration          0
>      bmAttributes         0xe0
>        Self Powered
>        Remote Wakeup
>      MaxPower                0mA
>      Interface Descriptor:
>        bLength                 9
>        bDescriptorType         4
>        bInterfaceNumber        0
>        bAlternateSetting       0
>        bNumEndpoints           1
>        bInterfaceClass         9
>        bInterfaceSubClass      0
>        bInterfaceProtocol      0
>        iInterface              0
>        Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType         5
>          bEndpointAddress     0x81  EP 1 IN
>          bmAttributes            3
>            Transfer Type            Interrupt
>            Synch Type               None
>            Usage Type               Data
>          wMaxPacketSize     0x0004  1x 4 bytes
>          bInterval              12
>          bMaxBurst               0
> Hub Descriptor:
>    bLength              12
>    bDescriptorType      42
>    nNbrPorts             1
>    wHubCharacteristic 0x000a
>      No power switching (usb 1.0)
>      Per-port overcurrent protection
>    bPwrOn2PwrGood       10 * 2 milli seconds
>    bHubContrCurrent      0 milli Ampere
>    bHubDecLat          0.0 micro seconds
>    wHubDelay             0 nano seconds
>    DeviceRemovable    0x00
>   Hub Port Status:
>     Port 1: 0000.02a0 5Gbps power Rx.Detect
> Binary Object Store Descriptor:
>    bLength                 5
>    bDescriptorType        15
>    wTotalLength       0x000f
>    bNumDeviceCaps          1
>    SuperSpeed USB Device Capability:
>      bLength                10
>      bDescriptorType        16
>      bDevCapabilityType      3
>      bmAttributes         0x02
>        Latency Tolerance Messages (LTM) Supported
>      wSpeedsSupported   0x0008
>        Device can operate at SuperSpeed (5Gbps)
>      bFunctionalitySupport   3
>        Lowest fully-functional device speed is SuperSpeed (5Gbps)
>      bU1DevExitLat           0 micro seconds
>      bU2DevExitLat           0 micro seconds
> can't get debug descriptor: Resource temporarily unavailable
> Device Status:     0x0001
>    Self Powered
> 
> Bus 001 Device 001: ID 1d6b:0002
> Device Descriptor:
>    bLength                18
>    bDescriptorType         1
>    bcdUSB               2.00
>    bDeviceClass            9
>    bDeviceSubClass         0
>    bDeviceProtocol         1
>    bMaxPacketSize0        64
>    idVendor           0x1d6b
>    idProduct          0x0002
>    bcdDevice            5.00
>    iManufacturer           3 Linux 5.0.0-rc1 xhci-hcd
>    iProduct                2 xHCI Host Controller
>    iSerial                 1 xhci-hcd.0.auto
>    bNumConfigurations      1
>    Configuration Descriptor:
>      bLength                 9
>      bDescriptorType         2
>      wTotalLength       0x0019
>      bNumInterfaces          1
>      bConfigurationValue     1
>      iConfiguration          0
>      bmAttributes         0xe0
>        Self Powered
>        Remote Wakeup
>      MaxPower                0mA
>      Interface Descriptor:
>        bLength                 9
>        bDescriptorType         4
>        bInterfaceNumber        0
>        bAlternateSetting       0
>        bNumEndpoints           1
>        bInterfaceClass         9
>        bInterfaceSubClass      0
>        bInterfaceProtocol      0
>        iInterface              0
>        Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType         5
>          bEndpointAddress     0x81  EP 1 IN
>          bmAttributes            3
>            Transfer Type            Interrupt
>            Synch Type               None
>            Usage Type               Data
>          wMaxPacketSize     0x0004  1x 4 bytes
>          bInterval              12
> Hub Descriptor:
>    bLength               9
>    bDescriptorType      41
>    nNbrPorts             1
>    wHubCharacteristic 0x000a
>      No power switching (usb 1.0)
>      Per-port overcurrent protection
>      TT think time 8 FS bits
>    bPwrOn2PwrGood       10 * 2 milli seconds
>    bHubContrCurrent      0 milli Ampere
>    DeviceRemovable    0x00
>    PortPwrCtrlMask    0xff
>   Hub Port Status:
>     Port 1: 0000.0100 power
> can't get device qualifier: Resource temporarily unavailable
> can't get debug descriptor: Resource temporarily unavailable
> Device Status:     0x0001
>    Self Powered
> 
> 
> NET: Registered protocol family 1
> workingset: timestamp_bits=62 max_order=20 bucket_order=0
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
> qcom-qmp-phy c010000.phy: Linked as a consumer to regulator.15
> qcom-qmp-phy c010000.phy: Linked as a consumer to regulator.16
> qcom-qmp-phy c010000.phy: Registered Qcom-QMP phy
> qcom-qusb2-phy c012000.phy: Linked as a consumer to regulator.26
> l24: supplied by bob
> qcom-qusb2-phy c012000.phy: Linked as a consumer to regulator.38
> qcom-qusb2-phy c012000.phy: Registered Qcom-QUSB2 phy
> Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> msm_serial c1b0000.serial: msm_serial: detected port #0
> msm_serial c1b0000.serial: uartclk = 1843200
> c1b0000.serial: ttyMSM0 at MMIO 0xc1b0000 (irq = 17, base_baud = 115200) is a MSM
> msm_serial: console setup on port #0
> printk: console [ttyMSM0] enabled
> msm_serial: driver initialized
> dwc3 a800000.dwc3: Failed to get clk 'ref': -2
> xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
> xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 1
> xhci-hcd xhci-hcd.0.auto: hcc params 0x0230fe65 hci version 0x110 quirks 0x0000000002010010
> xhci-hcd xhci-hcd.0.auto: irq 18, io mem 0x0a800000
> usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.00
> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: Product: xHCI Host Controller
> usb usb1: Manufacturer: Linux 5.0.0-rc1 xhci-hcd
> usb usb1: SerialNumber: xhci-hcd.0.auto
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 1 port detected
> xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
> xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 2
> xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0  SuperSpeed
> usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
> usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.00
> usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb2: Product: xHCI Host Controller
> usb usb2: Manufacturer: Linux 5.0.0-rc1 xhci-hcd
> usb usb2: SerialNumber: xhci-hcd.0.auto
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 1 port detected
> usbcore: registered new interface driver usb-storage
> 


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
