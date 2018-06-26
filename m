Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04062C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A335F21386
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A335F21386
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933467AbeFZJtw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:49:52 -0400
Received: from osg.samsung.com ([64.30.133.232]:41690 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934254AbeFZJtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:49:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id AEB9730BD0;
        Tue, 26 Jun 2018 02:49:20 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lbGDswAmJjxh; Tue, 26 Jun 2018 02:49:19 -0700 (PDT)
Received: from smtp.s-opensource.com (177.41.130.70.dynamic.adsl.gvt.net.br [177.41.130.70])
        by osg.samsung.com (Postfix) with ESMTPSA id 6E76630B88;
        Tue, 26 Jun 2018 02:49:16 -0700 (PDT)
Received: from mchehab by smtp.s-opensource.com with local (Exim 4.91)
        (envelope-from <mchehab@smtp.s-opensource.com>)
        id 1fXkb4-0000mA-BG; Tue, 26 Jun 2018 06:49:14 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [PATCH 8/9] networking: e1000.rst: Get rid of Sphinx warnings
Date:   Tue, 26 Jun 2018 06:49:10 -0300
Message-Id: <687412e4b938cdf17baf87b2961a48283edd7480.1530005114.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1530005114.git.mchehab+samsung@kernel.org>
References: <cover.1530005114.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1530005114.git.mchehab+samsung@kernel.org>
References: <cover.1530005114.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    Documentation/networking/e1000.rst:83: ERROR: Unexpected indentation.
    Documentation/networking/e1000.rst:84: WARNING: Block quote ends without a blank line; unexpected unindent.
    Documentation/networking/e1000.rst:173: WARNING: Definition list ends without a blank line; unexpected unindent.
    Documentation/networking/e1000.rst:236: WARNING: Definition list ends without a blank line; unexpected unindent.

While here, fix highlights and mark a table as such.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/networking/e1000.rst | 187 +++++++++++++++++------------
 1 file changed, 112 insertions(+), 75 deletions(-)

diff --git a/Documentation/networking/e1000.rst b/Documentation/networking/e1000.rst
index 144b87eef153..f10dd4086921 100644
--- a/Documentation/networking/e1000.rst
+++ b/Documentation/networking/e1000.rst
@@ -34,7 +34,8 @@ Command Line Parameters
 The default value for each parameter is generally the recommended setting,
 unless otherwise noted.
 
-NOTES:  For more information about the AutoNeg, Duplex, and Speed
+NOTES:
+	For more information about the AutoNeg, Duplex, and Speed
         parameters, see the "Speed and Duplex Configuration" section in
         this document.
 
@@ -45,22 +46,27 @@ NOTES:  For more information about the AutoNeg, Duplex, and Speed
 
 AutoNeg
 -------
+
 (Supported only on adapters with copper connections)
-Valid Range:   0x01-0x0F, 0x20-0x2F
-Default Value: 0x2F
+
+:Valid Range:   0x01-0x0F, 0x20-0x2F
+:Default Value: 0x2F
 
 This parameter is a bit-mask that specifies the speed and duplex settings
 advertised by the adapter.  When this parameter is used, the Speed and
 Duplex parameters must not be specified.
 
-NOTE:  Refer to the Speed and Duplex section of this readme for more
+NOTE:
+       Refer to the Speed and Duplex section of this readme for more
        information on the AutoNeg parameter.
 
 Duplex
 ------
+
 (Supported only on adapters with copper connections)
-Valid Range:   0-2 (0=auto-negotiate, 1=half, 2=full)
-Default Value: 0
+
+:Valid Range:   0-2 (0=auto-negotiate, 1=half, 2=full)
+:Default Value: 0
 
 This defines the direction in which data is allowed to flow.  Can be
 either one or two-directional.  If both Duplex and the link partner are
@@ -70,18 +76,22 @@ duplex.
 
 FlowControl
 -----------
-Valid Range:   0-3 (0=none, 1=Rx only, 2=Tx only, 3=Rx&Tx)
-Default Value: Reads flow control settings from the EEPROM
+
+:Valid Range:   0-3 (0=none, 1=Rx only, 2=Tx only, 3=Rx&Tx)
+:Default Value: Reads flow control settings from the EEPROM
 
 This parameter controls the automatic generation(Tx) and response(Rx)
 to Ethernet PAUSE frames.
 
 InterruptThrottleRate
 ---------------------
+
 (not supported on Intel(R) 82542, 82543 or 82544-based adapters)
-Valid Range:   0,1,3,4,100-100000 (0=off, 1=dynamic, 3=dynamic conservative,
-                                 4=simplified balancing)
-Default Value: 3
+
+:Valid Range:
+   0,1,3,4,100-100000 (0=off, 1=dynamic, 3=dynamic conservative,
+   4=simplified balancing)
+:Default Value: 3
 
 The driver can limit the amount of interrupts per second that the adapter
 will generate for incoming packets. It does this by writing a value to the
@@ -135,13 +145,15 @@ Setting InterruptThrottleRate to 0 turns off any interrupt moderation
 and may improve small packet latency, but is generally not suitable
 for bulk throughput traffic.
 
-NOTE:  InterruptThrottleRate takes precedence over the TxAbsIntDelay and
+NOTE:
+       InterruptThrottleRate takes precedence over the TxAbsIntDelay and
        RxAbsIntDelay parameters.  In other words, minimizing the receive
        and/or transmit absolute delays does not force the controller to
        generate more interrupts than what the Interrupt Throttle Rate
        allows.
 
-CAUTION:  If you are using the Intel(R) PRO/1000 CT Network Connection
+CAUTION:
+          If you are using the Intel(R) PRO/1000 CT Network Connection
           (controller 82547), setting InterruptThrottleRate to a value
           greater than 75,000, may hang (stop transmitting) adapters
           under certain network conditions.  If this occurs a NETDEV
@@ -151,7 +163,8 @@ CAUTION:  If you are using the Intel(R) PRO/1000 CT Network Connection
           hang, ensure that InterruptThrottleRate is set no greater
           than 75,000 and is not set to 0.
 
-NOTE:  When e1000 is loaded with default settings and multiple adapters
+NOTE:
+       When e1000 is loaded with default settings and multiple adapters
        are in use simultaneously, the CPU utilization may increase non-
        linearly.  In order to limit the CPU utilization without impacting
        the overall throughput, we recommend that you load the driver as
@@ -168,9 +181,11 @@ NOTE:  When e1000 is loaded with default settings and multiple adapters
 
 RxDescriptors
 -------------
-Valid Range:   48-256 for 82542 and 82543-based adapters
-               48-4096 for all other supported adapters
-Default Value: 256
+
+:Valid Range:
+ - 48-256 for 82542 and 82543-based adapters
+ - 48-4096 for all other supported adapters
+:Default Value: 256
 
 This value specifies the number of receive buffer descriptors allocated
 by the driver.  Increasing this value allows the driver to buffer more
@@ -180,15 +195,17 @@ Each descriptor is 16 bytes.  A receive buffer is also allocated for each
 descriptor and can be either 2048, 4096, 8192, or 16384 bytes, depending
 on the MTU setting. The maximum MTU size is 16110.
 
-NOTE:  MTU designates the frame size.  It only needs to be set for Jumbo
+NOTE:
+       MTU designates the frame size.  It only needs to be set for Jumbo
        Frames.  Depending on the available system resources, the request
        for a higher number of receive descriptors may be denied.  In this
        case, use a lower number.
 
 RxIntDelay
 ----------
-Valid Range:   0-65535 (0=off)
-Default Value: 0
+
+:Valid Range:   0-65535 (0=off)
+:Default Value: 0
 
 This value delays the generation of receive interrupts in units of 1.024
 microseconds.  Receive interrupt reduction can improve CPU efficiency if
@@ -198,7 +215,8 @@ of TCP traffic.  If the system is reporting dropped receives, this value
 may be set too high, causing the driver to run out of available receive
 descriptors.
 
-CAUTION:  When setting RxIntDelay to a value other than 0, adapters may
+CAUTION:
+          When setting RxIntDelay to a value other than 0, adapters may
           hang (stop transmitting) under certain network conditions.  If
           this occurs a NETDEV WATCHDOG message is logged in the system
           event log.  In addition, the controller is automatically reset,
@@ -207,9 +225,11 @@ CAUTION:  When setting RxIntDelay to a value other than 0, adapters may
 
 RxAbsIntDelay
 -------------
+
 (This parameter is supported only on 82540, 82545 and later adapters.)
-Valid Range:   0-65535 (0=off)
-Default Value: 128
+
+:Valid Range:   0-65535 (0=off)
+:Default Value: 128
 
 This value, in units of 1.024 microseconds, limits the delay in which a
 receive interrupt is generated.  Useful only if RxIntDelay is non-zero,
@@ -220,9 +240,11 @@ conditions.
 
 Speed
 -----
+
 (This parameter is supported only on adapters with copper connections.)
-Valid Settings: 0, 10, 100, 1000
-Default Value:  0 (auto-negotiate at all supported speeds)
+
+:Valid Settings: 0, 10, 100, 1000
+:Default Value:  0 (auto-negotiate at all supported speeds)
 
 Speed forces the line speed to the specified value in megabits per second
 (Mbps).  If this parameter is not specified or is set to 0 and the link
@@ -231,22 +253,26 @@ speed.  Duplex should also be set when Speed is set to either 10 or 100.
 
 TxDescriptors
 -------------
-Valid Range:   48-256 for 82542 and 82543-based adapters
-               48-4096 for all other supported adapters
-Default Value: 256
+
+:Valid Range:
+  - 48-256 for 82542 and 82543-based adapters
+  - 48-4096 for all other supported adapters
+:Default Value: 256
 
 This value is the number of transmit descriptors allocated by the driver.
 Increasing this value allows the driver to queue more transmits.  Each
 descriptor is 16 bytes.
 
-NOTE:  Depending on the available system resources, the request for a
+NOTE:
+       Depending on the available system resources, the request for a
        higher number of transmit descriptors may be denied.  In this case,
        use a lower number.
 
 TxIntDelay
 ----------
-Valid Range:   0-65535 (0=off)
-Default Value: 8
+
+:Valid Range:   0-65535 (0=off)
+:Default Value: 8
 
 This value delays the generation of transmit interrupts in units of
 1.024 microseconds.  Transmit interrupt reduction can improve CPU
@@ -256,9 +282,11 @@ causing the driver to run out of available transmit descriptors.
 
 TxAbsIntDelay
 -------------
+
 (This parameter is supported only on 82540, 82545 and later adapters.)
-Valid Range:   0-65535 (0=off)
-Default Value: 32
+
+:Valid Range:   0-65535 (0=off)
+:Default Value: 32
 
 This value, in units of 1.024 microseconds, limits the delay in which a
 transmit interrupt is generated.  Useful only if TxIntDelay is non-zero,
@@ -269,18 +297,21 @@ network conditions.
 
 XsumRX
 ------
+
 (This parameter is NOT supported on the 82542-based adapter.)
-Valid Range:   0-1
-Default Value: 1
+
+:Valid Range:   0-1
+:Default Value: 1
 
 A value of '1' indicates that the driver should enable IP checksum
 offload for received packets (both UDP and TCP) to the adapter hardware.
 
 Copybreak
 ---------
-Valid Range:   0-xxxxxxx (0=off)
-Default Value: 256
-Usage: modprobe e1000.ko copybreak=128
+
+:Valid Range:   0-xxxxxxx (0=off)
+:Default Value: 256
+:Usage: modprobe e1000.ko copybreak=128
 
 Driver copies all packets below or equaling this size to a fresh RX
 buffer before handing it up the stack.
@@ -292,8 +323,9 @@ it is also available during runtime at
 
 SmartPowerDownEnable
 --------------------
-Valid Range: 0-1
-Default Value:  0 (disabled)
+
+:Valid Range: 0-1
+:Default Value:  0 (disabled)
 
 Allows PHY to turn off in lower power states. The user can turn off
 this parameter in supported chipsets.
@@ -309,14 +341,14 @@ fiber interface board only links at 1000 Mbps full-duplex.
 
 For copper-based boards, the keywords interact as follows:
 
-  The default operation is auto-negotiate.  The board advertises all
+- The default operation is auto-negotiate.  The board advertises all
   supported speed and duplex combinations, and it links at the highest
   common speed and duplex mode IF the link partner is set to auto-negotiate.
 
-  If Speed = 1000, limited auto-negotiation is enabled and only 1000 Mbps
+- If Speed = 1000, limited auto-negotiation is enabled and only 1000 Mbps
   is advertised (The 1000BaseT spec requires auto-negotiation.)
 
-  If Speed = 10 or 100, then both Speed and Duplex should be set.  Auto-
+- If Speed = 10 or 100, then both Speed and Duplex should be set.  Auto-
   negotiation is disabled, and the AutoNeg parameter is ignored.  Partner
   SHOULD also be forced.
 
@@ -328,13 +360,15 @@ process.
 The parameter may be specified as either a decimal or hexadecimal value as
 determined by the bitmap below.
 
+============== ====== ====== ======= ======= ====== ====== ======= ======
 Bit position   7      6      5       4       3      2      1       0
 Decimal Value  128    64     32      16      8      4      2       1
 Hex value      80     40     20      10      8      4      2       1
 Speed (Mbps)   N/A    N/A    1000    N/A     100    100    10      10
 Duplex                       Full            Full   Half   Full    Half
+============== ====== ====== ======= ======= ====== ====== ======= ======
 
-Some examples of using AutoNeg:
+Some examples of using AutoNeg::
 
   modprobe e1000 AutoNeg=0x01 (Restricts autonegotiation to 10 Half)
   modprobe e1000 AutoNeg=1 (Same as above)
@@ -357,56 +391,59 @@ Additional Configurations
 
 Jumbo Frames
 ------------
-Jumbo Frames support is enabled by changing the MTU to a value larger
-than the default of 1500.  Use the ifconfig command to increase the MTU
-size.  For example::
+
+  Jumbo Frames support is enabled by changing the MTU to a value larger than
+  the default of 1500.  Use the ifconfig command to increase the MTU size.
+  For example::
 
        ifconfig eth<x> mtu 9000 up
 
-This setting is not saved across reboots.  It can be made permanent if
-you add::
+  This setting is not saved across reboots.  It can be made permanent if
+  you add::
 
        MTU=9000
 
-to the file /etc/sysconfig/network-scripts/ifcfg-eth<x>.  This example
-applies to the Red Hat distributions; other distributions may store this
-setting in a different location.
+  to the file /etc/sysconfig/network-scripts/ifcfg-eth<x>.  This example
+  applies to the Red Hat distributions; other distributions may store this
+  setting in a different location.
 
-Notes: Degradation in throughput performance may be observed in some
-Jumbo frames environments.  If this is observed, increasing the
-application's socket buffer size and/or increasing the
-/proc/sys/net/ipv4/tcp_*mem entry values may help.  See the specific
-application manual and /usr/src/linux*/Documentation/
-networking/ip-sysctl.txt for more details.
+Notes:
+  Degradation in throughput performance may be observed in some Jumbo frames
+  environments. If this is observed, increasing the application's socket buffer
+  size and/or increasing the /proc/sys/net/ipv4/tcp_*mem entry values may help.
+  See the specific application manual and /usr/src/linux*/Documentation/
+  networking/ip-sysctl.txt for more details.
 
-- The maximum MTU setting for Jumbo Frames is 16110.  This value
-  coincides with the maximum Jumbo Frames size of 16128.
+  - The maximum MTU setting for Jumbo Frames is 16110.  This value coincides
+    with the maximum Jumbo Frames size of 16128.
 
-- Using Jumbo frames at 10 or 100 Mbps is not supported and may result
-  in poor performance or loss of link.
+  - Using Jumbo frames at 10 or 100 Mbps is not supported and may result in
+    poor performance or loss of link.
 
-- Adapters based on the Intel(R) 82542 and 82573V/E controller do not
-  support Jumbo Frames.  These correspond to the following product names:
-  Intel(R) PRO/1000 Gigabit Server Adapter Intel(R) PRO/1000 PM Network
-  Connection
+  - Adapters based on the Intel(R) 82542 and 82573V/E controller do not
+    support Jumbo Frames. These correspond to the following product names::
+
+     Intel(R) PRO/1000 Gigabit Server Adapter
+     Intel(R) PRO/1000 PM Network Connection
 
 ethtool
 -------
-The driver utilizes the ethtool interface for driver configuration and
-diagnostics, as well as displaying statistical information.  The ethtool
-version 1.6 or later is required for this functionality.
 
-The latest release of ethtool can be found from
-https://www.kernel.org/pub/software/network/ethtool/
+  The driver utilizes the ethtool interface for driver configuration and
+  diagnostics, as well as displaying statistical information.  The ethtool
+  version 1.6 or later is required for this functionality.
+
+  The latest release of ethtool can be found from
+  https://www.kernel.org/pub/software/network/ethtool/
 
 Enabling Wake on LAN* (WoL)
 ---------------------------
-WoL is configured through the ethtool* utility.
 
-WoL will be enabled on the system during the next shut down or reboot.
-For this driver version, in order to enable WoL, the e1000 driver must be
-loaded when shutting down or rebooting the system.
+  WoL is configured through the ethtool* utility.
 
+  WoL will be enabled on the system during the next shut down or reboot.
+  For this driver version, in order to enable WoL, the e1000 driver must be
+  loaded when shutting down or rebooting the system.
 
 Support
 =======
-- 
2.17.1

