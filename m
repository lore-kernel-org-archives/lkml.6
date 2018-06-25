Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91650C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42012250C7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnTAyd6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42012250C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeFYFXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 01:23:54 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45007 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbeFYFXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 01:23:49 -0400
Received: by mail-pg0-f68.google.com with SMTP id b10-v6so1883750pgq.11;
        Sun, 24 Jun 2018 22:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pBZFG3XvZoWG1yqVvtXsXAGlbWFC/johCxJDvYaEvcg=;
        b=PnTAyd6E0j6Ur2LbYMUCYD80iHavW4RYvtpVBUKZZwks8tZRn6XOfpOvjaTUb8BCPL
         JDDBF5Mwt9b/OBdPlfiZBDB271OiG4WDWoz4VIZmPzGKSNoIcob8OEj63ah84cYOOADY
         OC4hp2LXgw7LEpF0ZA6VeOTjxbp279NDREviOey769qcT0BnaTNOeeRS8Ddr4xr6PsSC
         /y4uJ0hIpDQkpLo4GYBf5wVbIB3ygmI1ursLpZifM4SYLm2sioYXe//kuja18Cx51OpM
         s2NOBvbdFgQqp4zUnrJFgRrImmNW/Mmpd8Bfv4xNk5DIJyZSf8Yce6tPYTLURdujExrz
         mkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pBZFG3XvZoWG1yqVvtXsXAGlbWFC/johCxJDvYaEvcg=;
        b=NK7eZXGNRS9M3Tln8kQgNI0DqNJmNp5l2NhhAIr66Fy1bO7z4dlOgSAGlVm+CnqYXN
         vSccz+kAVSPnh2hbk1vaH7AZZtFSlAQPvyUt0H47eHVkDnekYICf+K6aKu0EehbPULrP
         cIMIln1WhOT+LA+WUk6C04ffV4mbvael2Er681TtlEWlulFK1CWHbjdLOx1yPKTA5bIJ
         koZp2QtX6bhgD0YrCtpOoTPKEuTkD8QL6QxiaSd9iN+IvESQ9bNEOt82renVLRkXeqYz
         vULx3M1jDMbBkUBRDsTCk42oPx3LqTkCVfI5d0e6auq01hOogyZIQfvzTHzdzoyFYj3H
         0qAQ==
X-Gm-Message-State: APt69E2hB34jKmEeejRNev8lPcpFh0iOU37KAP8/YU+uX0Uew/6vvwaL
        kZWq5OMpypM4M541bGvJajoC
X-Google-Smtp-Source: ADUXVKJQOQGmdxO0LcNl2GliTtLtUEIbvG0Ebr1f5ttbowjBANJpGofNR+uQT7UzvHOR9w9+06b8eg==
X-Received: by 2002:a63:7d7:: with SMTP id 206-v6mr3801546pgh.137.1529904228621;
        Sun, 24 Jun 2018 22:23:48 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k71-v6sm1835936pga.62.2018.06.24.22.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 22:23:48 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] drivers/base: only reordering consumer device when probing
Date:   Mon, 25 Jun 2018 13:23:07 +0800
Message-Id: <1529904187-18673-4-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529904187-18673-1-git-send-email-kernelfans@gmail.com>
References: <1529904187-18673-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 52cdbdd49853 ("driver core: correct device's shutdown order")
places an assumption of supplier<-consumer order on the process of probe.
But it turns out to break down the parent <- child order in some scene.
E.g in pci, a bridge is enabled by pci core, and behind it, the devices
have been probed. Then comes the bridge's module, which enables extra
feature(such as hotplug) on this bridge. This will break the
parent<-children order and cause failure when "kexec -e" in some scenario.

The detailed description of the scenario:
An IBM Power9 machine on which, two drivers portdrv_pci and shpchp(a mod)
match the PCI_CLASS_BRIDGE_PCI, but neither of them success to probe due
to some issue. For this case, the bridge is moved after its children in
devices_kset. Then, when "kexec -e", a ata-disk behind the bridge can not
write back buffer in flight due to the former shutdown of the bridge which
clears the BusMaster bit.

To fix this issue, only reordering a device and all of its children
if it is a consumer.

Note, the bridge involved:
0004:00:00.0 PCI bridge: IBM Device 04c1 (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        NUMA node: 0
        Bus: primary=00, secondary=01, subordinate=12, sec-latency=0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 80000000-ffefffff
        Prefetchable memory behind bridge: 0006024000000000-0006027f7fffffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Express (v2) Root Port (Slot-), MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 256 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 8GT/s, Width x8, ASPM not supported, Exit Latency L0s <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 8GT/s, Width x4, TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd+
                DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis+, LTR-, OBFF Disabled ARIFwd+
                LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+, EqualizationPhase1+
                         EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP+ FCP- CmpltTO+ CmpltAbrt+ UnxCmplt- RxOF- MalfTLP- ECRC+ UnsupReq- ACSViol-
                UESvrt: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                AERCap: First Error Pointer: 00, GenCap+ CGenEn+ ChkCap+ ChkEn+
        Capabilities: [148 v1] #19

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 drivers/base/dd.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1435d72..c74f23c 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -434,13 +434,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 			goto probe_failed;
 	}
 
-	/*
-	 * Ensure devices are listed in devices_kset in correct order
-	 * It's important to move Dev to the end of devices_kset before
-	 * calling .probe, because it could be recursive and parent Dev
-	 * should always go first
-	 */
-	devices_kset_move_last(dev);
+	/* only reoder consumer and its children after suppliers.*/
+	device_reorder_consumer(dev);
 
 	if (dev->bus->probe) {
 		ret = dev->bus->probe(dev);
-- 
2.7.4

