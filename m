Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753845AbeBLJiQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 04:38:16 -0500
Received: from devianza.investici.org ([198.167.222.108]:29684 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeBLJiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 04:38:14 -0500
Message-ID: <1518426556.26505.2.camel@autistici.org>
Subject: intel_pmc_core does not initialize intel 8th gen PMC
From: kitestramuort <kitestramuort@autistici.org>
To: linux-kernel@vger.kernel.org
Date: Mon, 12 Feb 2018 10:09:16 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
don't know if this is intended. In 4.15.2 i have:

dmesg:
intel_pmc_core 0000:00:1f.2: enabling device (0000 -> 0002)

lspci:
00:1f.2 Memory controller: Intel Corporation Sunrise Point-LP PMC (rev
21)
	Subsystem: Intel Corporation Sunrise Point-LP PMC
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Region 0: Memory at dff00000 (32-bit, non-prefetchable)
[size=16K]
	Kernel driver in use: intel_pmc_core


in 4.16.0-rc1 this becomes
dmesg:
intel_pmc_core:  initialized

lspci:
00:1f.2 Memory controller: Intel Corporation Sunrise Point-LP PMC (rev
21)
	Subsystem: Intel Corporation Sunrise Point-LP PMC
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Region 0: Memory at dff00000 (32-bit, non-prefetchable)
[disabled] [size=16K]

regards
