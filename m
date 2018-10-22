Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C896C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A53205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ameritech.net header.i=@ameritech.net header.b="IjWuR8eo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A53205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ameritech.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbeJWBhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:37:14 -0400
Received: from sonic311.consmr.mail.bf2.yahoo.com ([74.6.131.253]:33429 "EHLO
        sonic311-17.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728623AbeJWBhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameritech.net; s=s2048; t=1540228669; bh=AuZwrO4TGGsnT/EfxPGN6IlSaLNzIZQJr/6EAVfViUo=; h=To:From:Subject:Date:From:Subject; b=IjWuR8eoYzZNT1OnghToziXcj8c3AH2rhM+Fbmgg+djjRwDDQKfYhubTWbFM50MOSO3YP9QXrkIZNnEGfGbBjgf6dFcSjWY4gHUaOPJOD8ULHEtTDrvSr33p+NtZHUr1hc+UXaE0nEm2mzkmXD3+V4tX4W8PO+4FHXcW2sKJnwA2AnXnVyY4q4lQDMXf2w7fIbEU49tks3k5roc6uLguXstVpmjGPPqgJZzUu8GEKIJZmc4xfoQ+JbmHIf465wBDX/8EqDJcYkFYiKwOyv95I3uOaFV2nhHEwcJcwws10/BfRPzYy/C8klap9FhoRpPd57iicZiat2+nkbHCbsA6Eg==
X-YMail-OSG: zUNb9lwVM1ms3JU6yIyIMjHqwzqsnmPotV8thrz4hi72fFYaYZ8WZgTUWqggO7j
 PKEHDwJ5CJJdjhJx5Z8PwMa3_OldbbyH.dy_5kI5sF_js7vNNLJuoGcB9TXlO3vwbyBvIZPCDtWg
 uW199XrIb62W_S_QNukLQatzuFdbjlchjgIiqxCqpZAk58g0DeoVqsQZFb89cFErn77ZyoRH4.lF
 Qu3_tECytSwYG4CdmAIxXOQuewSa002pd81eWerD.cNEL4AYE7RvcLJ8vf4YNV5x95CAVB5XjWnf
 F65ussSRKVCSfbAJrkMUFB_NJDfIFoyl6gAald7vI41GdSBcyNCyV36dUqN5x4UJ9x00yMiDaCMJ
 YsStitFhtcUabJqwLZH4FrA_K6I9MVBsrxEQbBslkQ0i95cAq6gzH2LqGzGZ5XryMkaH78SPDt40
 pGpy8sFVO.lrsAuisR2V4BYOC9F8Ub8vnp3WnFAoWKSP2dBBFCPBOcXP4WGzSSeeNpWsfyHagxFS
 gdEJ25suQJj.326rXfH5UF_qUL2YO2N_JOrYL5cazhCYMAXGiDuLGOEhOzH6M2Aoq8FphhADx1ub
 o0iG6RyRGjOICLDafPuVbA7RmxN9gIBKfjVElGDg6KEg9k2S84axgzND__dHlPHQoIogoXHjBwCm
 5U0mNKPOCTbkg1BsGMPhxA7vR8hF4pIyIU2o_v__mt_CyxS1EGR4OrwegYt.ltENJTwrnBZiDMcH
 AnW7.ydxpTzctHukSGpLioD566lqglhk5zMh2OgiyfXU1.5JiCijQGPDE84Z6H99VI7cW_8lTC5g
 uzwGT.HvB6YedJe52Z0gtS6.byM5uV3Un19Xhc_YMlx_MnBKl6pKr5wf7sXpHh5P96cMfbmZvPxs
 42o7hd0IIIseBq5CuRwdqIrd4YdjPM0OLfx0LrNXAfvMYKw.IGnDrXh8VIbBDru7aMtD.zP08Oq8
 PWmkTd7bRVGV4JjgXd1IaksyIAPlZwM1L8q6YvhKkUIWMQNTEguTZXMhZ3gUD66y3dYmOJkieSYU
 aLE7MgiLw59b2ClSLlFczHUsxpTBYu3H0DZjl6RoviF5.g6IjVqwji8n3yLyCFLn4dOwS2JfBDqw
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Mon, 22 Oct 2018 17:17:49 +0000
Received: from user-0cdv3ih.cable.mindspring.com (EHLO [192.168.0.2]) ([24.223.142.81])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6fa3b60b755d2739cdf2b9f0badbbbf2
          for <linux-kernel@vger.kernel.org>;
          Mon, 22 Oct 2018 17:17:46 +0000 (UTC)
To:     linux-kernel@vger.kernel.org
From:   "F. Heitkamp" <heitkamp@ameritech.net>
Subject: Problem with XFX RX 580 on 4.18-19
Message-ID: <abe8f23d-6e75-2879-c7ad-4907c18a8650@ameritech.net>
Date:   Mon, 22 Oct 2018 13:17:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a XFX Radeon 580 4GB installed on X58 chipset.

I have only been able to get it to work on Linux 4.18.x and 4.19.x by 
using the amdgpu.dc=0  kernel boot parameter.

It works up to the 4.17.19 kernel but the console font comes out shitty, 
pixelated and unreadable and it will not display well on my 4K monitor. 
e.g. console font is so bad it's unusable.

In contrast I have another box which as a Radeon Vega 64 and the 
fonts/display are fantastic.  I am using almost identical kernels and 
mesa/drm configuration.

I also had the Vega 64 on the same box as the RX 580 previously and it 
worked fine; Fonts display were great.

I have done some searching and I can't tell if it's a known problem for 
the polaris 20 GPU.

Is anyone else experiencing a problem like this?

This is the kernel config stanza that I use on both boxes.

# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VM=y
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
CONFIG_DRM_RADEON=m
CONFIG_DRM_RADEON_USERPTR=y
CONFIG_DRM_AMDGPU=m
CONFIG_DRM_AMDGPU_SI=y
CONFIG_DRM_AMDGPU_CIK=y
CONFIG_DRM_AMDGPU_USERPTR=y
# CONFIG_DRM_AMDGPU_GART_DEBUGFS is not set

#
# ACP (Audio CoProcessor) Configuration
#
CONFIG_DRM_AMD_ACP=y

#
# Display Engine Configuration
#
CONFIG_DRM_AMD_DC=y
CONFIG_DRM_AMD_DC_DCN1_0=y
# CONFIG_DEBUG_KERNEL_DC is not set

# LSPCI Info:
04:00.0 VGA compatible controller: Advanced Micro Devices, Inc. 
[AMD/ATI] Ellesmere [Radeon RX 470/480/570/570X/580/580X] (rev e7) 
(prog-if 00 [VGA controller])
	Subsystem: XFX Pine Group Inc. Ellesmere [Radeon RX 470/480]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 256 bytes
	Interrupt: pin A routed to IRQ 39
	Region 0: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 2: Memory at cfe00000 (64-bit, prefetchable) [size=2M]
	Region 4: I/O ports at 9000 [size=256]
	Region 5: Memory at fb680000 (32-bit, non-prefetchable) [size=256K]
	Expansion ROM at 000c0000 [disabled] [size=128K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr+ FatalErr- UnsupReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L1, Exit Latency L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (downgraded), Width x16 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, OBFF 
Not Supported
			 AtomicOpsCap: 32bit+ 64bit+ 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF 
Disabled
			 AtomicOpsCtl: ReqEn-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, 
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee11000  Data: 4022
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
	Capabilities: [150 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP+ BadDLLP+ Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 14, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ 
ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 40000001 0000030f 000b8f9c 00000000
	Capabilities: [200 v1] Resizable BAR <?>
	Capabilities: [270 v1] Secondary PCI Express <?>
	Capabilities: [2b0 v1] Address Translation Service (ATS)
		ATSCap:	Invalidate Queue Depth: 00
		ATSCtl:	Enable+, Smallest Translation Unit: 00
	Capabilities: [2c0 v1] Page Request Interface (PRI)
		PRICtl: Enable- Reset-
		PRISta: RF- UPRGI- Stopped+
		Page Request Capacity: 00000020, Page Request Allocation: 00000000
	Capabilities: [2d0 v1] Process Address Space ID (PASID)
		PASIDCap: Exec+ Priv+, Max PASID Width: 10
		PASIDCtl: Enable- Exec- Priv-
	Capabilities: [320 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [328 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 1
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [370 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=0us PortTPowerOnTime=170us
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=0us LTR1.2_Threshold=0ns
		L1SubCtl2: T_PwrOn=10us
	Kernel driver in use: amdgpu
	Kernel modules: amdgpu


# DRM kernel output:
[    6.412518] device class 'drm': registering
[    6.723395] [drm] amdgpu kernel modesetting enabled.
[    6.831841] [drm] initializing kernel modesetting (POLARIS10 
0x1002:0x67DF 0x1682:0xC580 0xE7).
[    6.840543] [drm] register mmio base: 0xFB680000
[    6.845160] [drm] register mmio size: 262144
[    6.849440] [drm] probing gen 2 caps for device 8086:340a = 3b3d02/0
[    6.855794] [drm] probing mlw for device 8086:340a = 3b3d02
[    6.855795] [drm] add ip block number 0 <vi_common>
[    6.855796] [drm] add ip block number 1 <gmc_v8_0>
[    6.855797] [drm] add ip block number 2 <tonga_ih>
[    6.855799] [drm] add ip block number 3 <powerplay>
[    6.866245] [drm] add ip block number 4 <dce_v11_0>
[    6.866246] [drm] add ip block number 5 <gfx_v8_0>
[    6.866246] [drm] add ip block number 6 <sdma_v3_0>
[    6.866247] [drm] add ip block number 7 <uvd_v6_0>
[    6.866248] [drm] add ip block number 8 <vce_v3_0>
[    6.875837] [drm] UVD is enabled in VM mode
[    6.885588] [drm] UVD ENC is enabled in VM mode
[    6.885590] [drm] VCE enabled in VM mode
[    7.242487] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, 
fragment size is 9-bit
[    7.267232] [drm] Detected VRAM RAM=4096M, BAR=256M
[    7.272107] [drm] RAM width 256bits GDDR5
[    7.298558] [drm] amdgpu: 4096M of VRAM memory ready
[    7.303523] [drm] amdgpu: 4096M of GTT memory ready.
[    7.308646] [drm] GART: num cpu pages 65536, num gpu pages 65536
[    7.314704] [drm] PCIE GART of 256M enabled (table at 
0x000000F400900000).
[    7.321624] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    7.328241] [drm] Driver supports precise vblank timestamp query.
[    7.334612] [drm] AMDGPU Display Connectors
[    7.338798] [drm] Connector 0:
[    7.341853] [drm]   DP-1
[    7.344394] [drm]   HPD6
[    7.346934] [drm]   DDC: 0x4868 0x4868 0x4869 0x4869 0x486a 0x486a 
0x486b 0x486b
[    7.354326] [drm]   Encoders:
[    7.357299] [drm]     DFP1: INTERNAL_UNIPHY2
[    7.361570] [drm] Connector 1:
[    7.364630] [drm]   DP-2
[    7.367171] [drm]   HPD4
[    7.369709] [drm]   DDC: 0x4870 0x4870 0x4871 0x4871 0x4872 0x4872 
0x4873 0x4873
[    7.377102] [drm]   Encoders:
[    7.380075] [drm]     DFP2: INTERNAL_UNIPHY2
[    7.384348] [drm] Connector 2:
[    7.387407] [drm]   DP-3
[    7.389945] [drm]   HPD1
[    7.392486] [drm]   DDC: 0x486c 0x486c 0x486d 0x486d 0x486e 0x486e 
0x486f 0x486f
[    7.399879] [drm]   Encoders:
[    7.402850] [drm]     DFP3: INTERNAL_UNIPHY1
[    7.407123] [drm] Connector 3:
[    7.410182] [drm]   HDMI-A-1
[    7.421232] [drm]   HPD5
[    7.421233] [drm]   DDC: 0x4874 0x4874 0x4875 0x4875 0x4876 0x4876 
0x4877 0x4877
[    7.421233] [drm]   Encoders:
[    7.421234] [drm]     DFP4: INTERNAL_UNIPHY1
[    7.421234] [drm] Connector 4:
[    7.421236] [drm]   DVI-D-1
[    7.434890] [drm]   HPD3
[    7.434891] [drm]   DDC: 0x487c 0x487c 0x487d 0x487d 0x487e 0x487e 
0x487f 0x487f
[    7.434892] [drm]   Encoders:
[    7.443088] [drm]     DFP5: INTERNAL_UNIPHY
[    7.443139] [drm] Chained IB support enabled!
[    7.454738] [drm] Found UVD firmware Version: 1.130 Family ID: 16
[    7.461975] [drm] Found VCE firmware Version: 53.26 Binary ID: 3
[    7.554415] [drm] UVD and UVD ENC initialized successfully.
[    7.660372] [drm] VCE initialized successfully.
[    7.819712] [drm] fb mappable at 0xD0E28000
[    7.823904] [drm] vram apper at 0xD0000000
[    7.828002] [drm] size 33177600
[    7.831148] [drm] fb depth is 24
[    7.834381] [drm]    pitch is 15360
[    7.837919] fbcon: amdgpudrmfb (fb0) is primary device
[    8.271338] amdgpu 0000:04:00.0: fb0: amdgpudrmfb frame buffer device
[    8.279319] [drm] Initialized amdgpu 3.26.0 20150101 for 0000:04:00.0 
on minor 0
