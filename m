Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE630C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6402081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A6402081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeK2VUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:20:48 -0500
Received: from ms.tdt.de ([195.243.126.94]:36756 "EHLO mail.dev.tdt.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726818AbeK2VUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:20:47 -0500
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 4020321D04;
        Thu, 29 Nov 2018 10:15:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 29 Nov 2018 11:15:53 +0100
From:   Florian Eckert <fe@dev.tdt.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Eckert.Florian@googlemail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] Add device driver for APU2/APU3 GPIOs
In-Reply-To: <CAHp75VfFYJQzTv_oe8RKPo03-FLYHy6BkrKaG23svAKtC+jVBg@mail.gmail.com>
References: <20181127132508.5501-1-fe@dev.tdt.de>
 <CAHp75VfFYJQzTv_oe8RKPo03-FLYHy6BkrKaG23svAKtC+jVBg@mail.gmail.com>
Message-ID: <583ca922b4a877a4b0577994e40ddf5f@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

Thank you very very much for your code review "again" I will update my 
patch set with your hints.
Should I send v6 or should i wait till I get feedback from you about 
ACPI?

>> 
>> Until now it was not possible to get more information to detect the
>> MMIO_BASE address from the ACPI subsystem.
> 
> I'm sorry if I already asked, please, remind me where dump of ACPI
> tables can be found?

https://www.spinics.net/lists/kernel/msg2887290.html

> Also would be nice to have the output of `lspci -nk -vv -xxx` on such 
> platform.

00:00.0 0600: 1022:1566
	Subsystem: 1022:1566
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
lspci: Unable to load libkmod resources: error -12
00: 22 10 66 15 04 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 66 15
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 80 00 00 00 00 00 00 00
50: 22 10 66 15 00 00 00 00 00 00 00 00 00 00 00 00
60: 46 00 00 00 63 10 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
80: 00 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 7f 2c 00 00 00 02 02 19 00 00 00 00 00
a0: 01 80 30 01 ef be ad de 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 04 00 10 c2 03 00 00 00
c0: 00 00 00 00 00 00 00 00 01 00 12 00 00 00 14 00
d0: b6 14 30 01 00 00 00 00 00 00 00 00 00 00 00 00
e0: 10 00 40 01 01 11 e3 80 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 80 80 00 00 00 00 00 05 00 00 00

00:02.0 0600: 1022:156b
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
00: 22 10 6b 15 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 80 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.2 0604: 1022:1439 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 24
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00001000-00001fff [size=4K]
	Memory behind bridge: fe500000-fe5fffff [size=1M]
	Prefetchable memory behind bridge: None
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s 
<512ns, L1 <64us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ 
BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- 
LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible+
		RootCap: CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not 
Supported ARIFwd-
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF 
Disabled ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, 
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [b0] Subsystem: 1022:1234
	Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
	Kernel driver in use: pcieport
00: 22 10 39 14 07 00 10 00 00 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 11 11 00 00
20: 50 fe 50 fe f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 00 02 03 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 58 03 c8 00 00 00 00 10 a0 42 01 22 80 00 00
60: 30 29 00 00 12 3c 73 01 40 00 11 70 00 00 04 00
70: 00 00 48 01 10 00 01 00 00 00 00 00 1f 00 00 00
80: 06 00 00 00 06 00 00 00 02 00 01 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 05 b0 80 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 0d b8 00 00 22 10 34 12 08 00 03 a8 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 6a 00 00 00 01 05 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.3 0604: 1022:1439 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 25
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00002000-00002fff [size=4K]
	Memory behind bridge: fe600000-fe6fffff [size=1M]
	Prefetchable memory behind bridge: None
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s 
<512ns, L1 <64us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ 
BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- 
LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible+
		RootCap: CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not 
Supported ARIFwd-
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF 
Disabled ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, 
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [b0] Subsystem: 1022:1234
	Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
	Kernel driver in use: pcieport
00: 22 10 39 14 07 00 10 00 00 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 21 21 00 00
20: 60 fe 60 fe f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 00 03 03 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 58 03 c8 00 00 00 00 10 a0 42 01 22 80 00 00
60: 30 29 00 00 12 3c 73 02 40 00 11 70 00 00 04 00
70: 00 00 48 01 10 00 01 00 00 00 00 00 1f 00 00 00
80: 06 00 00 00 06 00 00 00 02 00 01 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 05 b0 80 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 0d b8 00 00 22 10 34 12 08 00 03 a8 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 6a 00 00 00 01 05 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.4 0604: 1022:1439 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin D routed to IRQ 26
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 00003000-00003fff [size=4K]
	Memory behind bridge: fe700000-fe7fffff [size=1M]
	Prefetchable memory behind bridge: None
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s 
<512ns, L1 <64us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ 
BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- 
LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible+
		RootCap: CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not 
Supported ARIFwd-
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF 
Disabled ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, 
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [b0] Subsystem: 1022:1234
	Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
	Kernel driver in use: pcieport
00: 22 10 39 14 07 00 10 00 00 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 03 03 00 31 31 00 00
20: 70 fe 70 fe f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 00 04 03 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 58 03 c8 00 00 00 00 10 a0 42 01 22 80 00 00
60: 30 29 00 00 12 3c 73 03 40 00 11 70 00 00 04 00
70: 00 00 48 01 10 00 01 00 00 00 00 00 1f 00 00 00
80: 06 00 00 00 06 00 00 00 02 00 01 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 05 b0 80 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 0d b8 00 00 22 10 34 12 08 00 03 a8 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 6a 00 00 00 01 05 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.5 0604: 1022:1439 (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 27
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: None
	Memory behind bridge: fe200000-fe4fffff [size=3M]
	Prefetchable memory behind bridge: None
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s 
<512ns, L1 <64us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ 
BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- 
LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible+
		RootCap: CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not 
Supported ARIFwd-
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF 
Disabled ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, 
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [b0] Subsystem: 1022:1234
	Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
	Kernel driver in use: pcieport
00: 22 10 39 14 06 00 10 00 00 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 04 04 00 f1 01 00 00
20: 20 fe 40 fe f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 00 01 03 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 58 03 c8 00 00 00 00 10 a0 42 01 22 80 00 00
60: 30 29 00 00 12 3c 73 04 40 00 11 70 00 00 04 00
70: 00 00 48 01 10 00 01 00 00 00 00 00 1f 00 00 00
80: 06 00 00 00 06 00 00 00 02 00 01 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 05 b0 80 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 0d b8 00 00 22 10 34 12 08 00 03 a8 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 6a 00 00 00 01 05 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.0 1080: 1022:1537
	Subsystem: 1022:1537
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Region 0: Memory at fea00000 (64-bit, prefetchable) [size=128K]
	Region 2: Memory at fe800000 (32-bit, non-prefetchable) [size=1M]
	Region 3: Memory at fea24000 (32-bit, non-prefetchable) [size=4K]
	Region 4: Memory at fe900000 (32-bit, non-prefetchable) [size=1M]
	Region 5: Memory at fea20000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [50] MSI-X: Enable- Count=2 Masked-
		Vector table: BAR=5 offset=00000000
		PBA: BAR=5 offset=00001000
	Capabilities: [5c] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [60] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
00: 22 10 37 15 02 00 10 00 00 00 80 10 00 00 00 00
10: 0c 00 a0 fe 00 00 00 00 00 00 80 fe 00 40 a2 fe
20: 00 00 90 fe 00 00 a2 fe 00 00 00 00 22 10 37 15
30: 00 00 00 00 50 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 80 10 00 00 37 15 00 00 00 00 22 10 37 15
50: 11 5c 01 00 05 00 00 00 05 10 00 00 08 60 03 a8
60: 01 00 03 00 08 00 00 00 10 00 92 00 e0 8f 00 00
70: 10 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 13 00 06 01 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 4c 00 00 00 00 00 00 00
f0: 49 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00

00:10.0 0c03: 1022:7814 (rev 11) (prog-if 30 [XHCI])
	Subsystem: 1022:1410
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fea22000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [90] MSI-X: Enable+ Count=8 Masked-
		Vector table: BAR=0 offset=00001000
		PBA: BAR=0 offset=00001080
	Capabilities: [a0] Express (v2) Root Complex Integrated Endpoint, MSI 
00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+, OBFF 
Not Supported
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF 
Disabled
			 AtomicOpsCtl: ReqEn-
	Capabilities: [100 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Kernel driver in use: xhci_hcd
00: 22 10 14 78 06 04 10 00 11 30 03 0c 10 00 00 00
10: 04 20 a2 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 10 14
30: 00 00 00 00 50 00 00 00 00 00 00 00 00 01 00 00
40: 00 00 00 00 20 00 00 01 04 00 00 00 11 00 ff 0f
50: 01 70 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
60: 30 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 05 90 86 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 11 a0 07 80 00 10 00 00 80 10 00 00 00 00 00 00
a0: 10 00 92 00 c0 8f 00 00 00 28 10 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 10 08 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: fc 1f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 08 17 80 00 00 00 00 00 00 00 00 00 00 00 00 00

00:11.0 0106: 1022:7800 (rev 40) (prog-if 01 [AHCI 1.0])
	Subsystem: 1022:7800
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at 4010 [size=8]
	Region 1: I/O ports at 4020 [size=4]
	Region 2: I/O ports at 4018 [size=8]
	Region 3: I/O ports at 4024 [size=4]
	Region 4: I/O ports at 4000 [size=16]
	Region 5: Memory at fea25000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [60] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [70] SATA HBA v1.0 InCfgSpace
	Kernel driver in use: ahci
00: 22 10 00 78 07 00 30 02 40 01 06 01 10 40 00 00
10: 11 40 00 00 21 40 00 00 19 40 00 00 25 40 00 00
20: 01 40 00 00 00 50 a2 fe 00 00 00 00 22 10 00 78
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 01 00 00
40: 04 20 00 00 01 00 20 00 ea 10 00 80 01 03 03 fa
50: 05 d0 80 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 70 23 40 00 00 00 00 00 00 00 00 00 00 00 00
70: 12 00 10 00 0f 00 00 00 00 00 00 00 00 00 00 00
80: 10 00 00 00 06 00 14 04 ab 01 00 20 7d 00 70 60
90: 45 70 00 00 0c 00 10 00 03 31 40 00 86 0a 8f 0f
a0: 01 c8 00 00 81 10 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 20 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 10 00 00 ff 00 00 00 00
d0: 13 00 06 03 00 00 64 00 00 00 08 00 00 00 00 00
e0: 80 00 00 00 00 00 00 00 27 60 74 c7 ff 00 ff 01
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:12.0 0c03: 1022:7808 (rev 39) (prog-if 20 [EHCI])
	Subsystem: 1022:7808
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fea25400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
	Capabilities: [e4] Debug port: BAR=1 offset=00e0
	Kernel driver in use: ehci-pci
00: 22 10 08 78 16 00 b0 02 39 20 03 0c 10 40 00 00
10: 00 54 a2 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 08 78
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 41 11 2a a4 7b da 7f fb 00 00 00 00 00 00 00 00
60: 20 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: ff ff 0f 00 2c 00 00 c0 ff 00 00 80 00 00 00 00
80: 38 04 00 79 18 00 fe fc 81 00 20 00 c7 7e 32 64
90: 4c 1d 01 10 00 00 00 00 00 00 00 00 00 0f 0f 03
a0: 01 00 00 00 00 00 00 c0 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 e4 02 fe 00 00 40 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 0a 00 e0 20 00 00 00 00 20 00 00 01
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:13.0 0c03: 1022:7808 (rev 39) (prog-if 20 [EHCI])
	Subsystem: 1022:7808
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fea25500 (32-bit, non-prefetchable) [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
	Capabilities: [e4] Debug port: BAR=1 offset=00e0
	Kernel driver in use: ehci-pci
00: 22 10 08 78 16 00 b0 02 39 20 03 0c 10 40 00 00
10: 00 55 a2 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 08 78
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 41 11 2a a4 7b da 7f fb 00 00 00 00 00 00 00 00
60: 20 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: ff ff 0f 00 2c 00 00 c0 ff 00 00 80 00 00 00 00
80: 38 04 00 79 18 00 fe fc 81 00 20 00 c7 7e 32 64
90: 4c 1d 01 10 00 00 00 00 00 00 00 00 00 0f 0b 00
a0: 01 00 00 00 00 00 08 c0 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 e4 02 fe 00 00 40 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 0a 00 e0 20 00 00 00 00 20 00 00 01
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:14.0 0c05: 1022:780b (rev 42)
	Subsystem: 1022:780b
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: piix4_smbus
00: 22 10 0b 78 03 04 20 02 42 00 05 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 0b 78
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:14.3 0601: 1022:780e (rev 11)
	Subsystem: 1022:780e
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
00: 22 10 0e 78 0f 00 20 02 11 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 0e 78
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 04 00 00 00 d5 ff 03 ff 07 ff 20 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 0e 10 00 0e 00 0f 00 00 ff ff ff
70: 67 45 23 00 00 00 00 00 90 00 00 00 05 0a 00 00
80: 08 00 03 a8 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 02 00 c1 fe 2f 01 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 04 00 e9 3d 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 80 47 10 82 ff
d0: 86 ff ff 08 42 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:14.7 0805: 1022:7813 (rev 01) (prog-if 01)
	Subsystem: 1022:7806
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 71, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fea25600 (32-bit, non-prefetchable) [size=256]
	Kernel driver in use: sdhci-pci
00: 22 10 13 78 06 00 20 02 01 01 05 08 10 47 80 00
10: 00 56 a2 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 06 78
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 01 00 03 80 00 00 00 00 00 00 00 00 00 00 00 00
a0: 02 00 00 00 b2 32 fe 21 70 00 00 00 64 00 c8 00
b0: 01 0c 18 01 01 00 00 80 00 04 02 88 98 cc 44 00
c0: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 8b 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: fa 00 04 00 02 00 04 00 02 00 01 00 00 40 01 00

00:18.0 0600: 1022:1580
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
00: 22 10 80 15 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 02 04 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 03 00 e0 c8 00 00 1f 88 4e 00 00 fe 0f 58
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 20 10 11 00 00 00 00 00 13 00 00 00
90: a5 01 05 80 00 00 01 02 27 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.1 0600: 1022:1581
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
00: 22 10 81 15 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 03 00 00 00 00 00 7e 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 03 d0 fe 00 80 df fe 00 03 00 7f 00 00 cf fe 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 03 00 00 00 00 f0 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 03 00 00 ff 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.2 0600: 1022:1582
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
00: 22 10 82 15 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: e0 ff 78 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 02 00 90 00 08 18
80: 07 00 00 00 05 00 80 00 00 00 00 3c 00 00 02 00
90: 00 00 01 83 8e 88 49 9f 1f 00 0f 8d 06 60 00 00
a0: a0 03 1f 00 00 00 00 00 00 00 32 80 00 00 00 00
b0: d1 fe c5 c8 59 00 00 00 31 b7 9b a3 d2 09 54 3d
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: f6 7e be 29 f3 66 c6 da 2e ea e7 9c 76 76 d7 b9
e0: b7 69 17 dd ea 6c 9f db f5 6f 2b fb bd 36 d4 7e
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.3 0600: 1022:1583
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Capabilities: [f0] Secure device <?>
	Kernel driver in use: k10temp
00: 22 10 83 15 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 f0 00 00 00 00 00 00 00 00 00 00 00
40: ff ff ff ff 44 00 b0 48 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 25 00 6a 42 00 00 00 40 52 00 01 10
70: 53 11 13 10 01 01 1c 01 10 08 18 00 1b 06 05 00
80: 00 00 00 00 02 00 00 00 00 00 85 00 00 40 c8 40
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 48 8c a0 ef 0f a0 33 00 00 00 90 00 00 00 00
b0: 00 00 00 00 00 00 00 00 89 03 00 b0 00 80 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 0a 0f 80 98 40 00 00 00 00 64 78 68
e0: 00 00 00 00 20 00 00 00 18 4f f7 01 00 00 00 00
f0: 0f 00 10 00 00 00 00 00 00 00 00 00 01 0f 73 00

00:18.4 0600: 1022:1584
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: fam15h_power
00: 22 10 84 15 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 ff ff 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.5 0600: 1022:1585
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
00: 22 10 85 15 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 00 01 03 f0 0e 0e 01 10 0e 01 02 80 00 84
90: 4f 1d 12 60 31 00 00 00 00 00 00 01 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 a0 03 00 05 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 71 0d 00 00 00 00 00 00 28 ac 7b 00 00 00 00 00
f0: 11 00 00 00 02 00 00 40 00 00 00 00 00 00 00 00

01:00.0 0200: 8086:1539 (rev 03)
	Subsystem: 8086:0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 33
	Region 0: Memory at fe500000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at 1000 [size=32]
	Region 3: Memory at fe520000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] MSI-X: Enable+ Count=5 Masked-
		Vector table: BAR=3 offset=00000000
		PBA: BAR=3 offset=00002000
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 
<64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0.000W
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <2us, L1 <16us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not 
Supported
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF 
Disabled
			 AtomicOpsCtl: ReqEn-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, 
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ 
ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [140 v1] Device Serial Number 00-0d-b9-ff-ff-4b-48-a4
	Capabilities: [1a0 v1] Transaction Processing Hints
		Device specific mode supported
		Steering table in TPH capability structure
	Kernel driver in use: igb
00: 86 80 39 15 07 04 10 00 03 00 00 02 10 00 00 00
10: 00 00 50 fe 00 00 00 00 01 10 00 00 00 00 52 fe
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 50 23 c8 08 20 00 00 00 00 00 00 00 00 00 00
50: 05 70 80 01 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 a0 04 80 03 00 00 00 03 20 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff
a0: 10 00 02 00 c2 8c 00 10 3f 28 10 00 11 5c 42 01
b0: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 1f 00 00 00 00 00 00 00 00 00 00 00
d0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:00.0 0200: 8086:1539 (rev 03)
	Subsystem: 8086:0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 39
	Region 0: Memory at fe600000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at 2000 [size=32]
	Region 3: Memory at fe620000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] MSI-X: Enable+ Count=5 Masked-
		Vector table: BAR=3 offset=00000000
		PBA: BAR=3 offset=00002000
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 
<64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0.000W
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <2us, L1 <16us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not 
Supported
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF 
Disabled
			 AtomicOpsCtl: ReqEn-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, 
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ 
ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [140 v1] Device Serial Number 00-0d-b9-ff-ff-4b-48-a5
	Capabilities: [1a0 v1] Transaction Processing Hints
		Device specific mode supported
		Steering table in TPH capability structure
	Kernel driver in use: igb
00: 86 80 39 15 07 04 10 00 03 00 00 02 10 00 00 00
10: 00 00 60 fe 00 00 00 00 01 20 00 00 00 00 62 fe
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 50 23 c8 08 20 00 00 00 00 00 00 00 00 00 00
50: 05 70 80 01 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 a0 04 80 03 00 00 00 03 20 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff
a0: 10 00 02 00 c2 8c 00 10 3f 28 10 00 11 5c 42 02
b0: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 1f 00 00 00 00 00 00 00 00 00 00 00
d0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

03:00.0 0200: 8086:1539 (rev 03)
	Subsystem: 8086:0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 45
	Region 0: Memory at fe700000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at 3000 [size=32]
	Region 3: Memory at fe720000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] MSI-X: Enable+ Count=5 Masked-
		Vector table: BAR=3 offset=00000000
		PBA: BAR=3 offset=00002000
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 
<64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0.000W
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <2us, L1 <16us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not 
Supported
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF 
Disabled
			 AtomicOpsCtl: ReqEn-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, 
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ 
ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [140 v1] Device Serial Number 00-0d-b9-ff-ff-4b-48-a6
	Capabilities: [1a0 v1] Transaction Processing Hints
		Device specific mode supported
		Steering table in TPH capability structure
	Kernel driver in use: igb
00: 86 80 39 15 07 04 10 00 03 00 00 02 10 00 00 00
10: 00 00 70 fe 00 00 00 00 01 30 00 00 00 00 72 fe
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 50 23 c8 08 20 00 00 00 00 00 00 00 00 00 00
50: 05 70 80 01 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 a0 04 80 03 00 00 00 03 20 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff
a0: 10 00 02 00 c2 8c 00 10 3f 28 10 00 11 5c 42 03
b0: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 1f 00 00 00 00 00 00 00 00 00 00 00
d0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

04:00.0 0280: 168c:003c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 52
	Region 0: Memory at fe200000 (64-bit, non-prefetchable) [size=2M]
	Expansion ROM at fe400000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/8 Maskable+ 64bit-
		Address: fee0f00c  Data: 41e3
		Masking: 00fe00fe  Pending: 00000000
	Capabilities: [70] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 
<64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <4us, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF 
Not Supported
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF 
Disabled
			 AtomicOpsCtl: ReqEn-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, 
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- 
ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [140 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
	Kernel driver in use: ath10k_pci
00: 8c 16 3c 00 06 04 10 00 00 00 80 02 10 00 00 00
10: 04 00 20 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 40 fe 40 00 00 00 00 00 00 00 00 01 00 00
40: 01 50 c2 07 00 00 00 00 00 00 00 00 00 00 00 00
50: 05 70 07 01 0c f0 e0 fe e3 41 00 00 fe 00 fe 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 10 00 02 00 c1 8d 00 00 30 20 00 00 11 6c 03 00
80: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 10 00 00 00 00 00 00 00 02 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

