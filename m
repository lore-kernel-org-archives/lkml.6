Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB037C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8557D22BCC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="auK9XTCV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RnNwX3gI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8557D22BCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934166AbeFVAhg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 20:37:36 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48099 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933452AbeFVAhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 20:37:32 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B6D8B21D37;
        Thu, 21 Jun 2018 20:37:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Jun 2018 20:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=6rpt39HG8d4J4p6Eh
        f5PRQ9qfrd56/XFTdB7cYupSh4=; b=auK9XTCVWfQvDAokvHiKLi4bdlIyiKzG6
        dFLYUdrUX2SOrOi4nsDicnWRmg0V26Y57GRz2T7AJX0pUvZeig/8ykGnMbqI3l0F
        htqvkF/CS+M3wfLeTOl3bkLlQHFy4uezzQl1fGkKVT+wJVlSqwqPuOKKfwdOQi4G
        QY3bMBoIIuoP6NA6S/oOr4VEca2Kxa4TUtUB2+/I1No/n3CoW1mrRqmvtF9e+0uL
        quUuBNfQJkf8fdN72/iG/LcsNF33piQwpGbl6nFOof/SdbACQd5xFDfMqX+hvGQE
        OhQlRVUrst2Gx4wPfBtlQpQC3ZO2Bh5aGyOoSkIPXdYXn791Ugoiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=6rpt39HG8d4J4p6Ehf5PRQ9qfrd56/XFTdB7cYupSh4=; b=RnNwX3gI
        rmROp038kU1cazZIeZDtt1U9BR5aSVk7GGnIBdP22NHBIDPjxSUl+kAId9sVOi3U
        TbQ+n6C6bP3TMjKTlYKSRipke61utLZpU9JCjsHJaacRL7uBcKHSKmUfBAFpT58f
        prGPft06k51UJPnwf6hPmozq5SO4segQBdpD6IEKi4EE4NzjmbuOpX3LsZRL3otl
        w2S4+z5bw6s/DNGzKb7tnm/IdV5aYuTSUS8s3IqKU8idFwCn6I0VAZO0u5PF3Y6o
        erUt6nvrXzRnbZUIKxF/Ieg3vJiM+n+JXVSLoIQu6Ld4EZrhj6l2im/jpxh/Wzew
        8DsVcfVaL+S1Qw==
X-ME-Proxy: <xmx:y0QsW3asfRrAaV8-NKLeWlryL5EFfmfWlkH2IGO2N19Yht2GsKFVDw>
    <xmx:y0QsWxBlzuEf8SM6xFlNVVaYp6iADSGYIKrFb98iowJIiXYr5ENlCA>
    <xmx:y0QsW1_0v4XEHPWSdfIkBSxSmMcwz48ktSAkdN4A9C7GKk8BKpz3Mw>
    <xmx:y0QsW94zl-SOfAVfc9cU_QjhJzH_20D8517F2We3dPgJv2wDTtKIQQ>
    <xmx:y0QsW3oAEqgVnmjm7yXW_feLi8kc2uTGTix2tTu-YF8_s4Js8jjuDw>
    <xmx:y0QsW8Sa5zEYzuDbMYSRLJPT6KinmwhsVmBBkiNNfT-amBVDl5Rs-A>
X-ME-Sender: <xms:y0QsW2BuXZlWU7R1yr-f_rGlgHpEOGm0q2QefDsB5GTk2B2001pdmQ>
Received: from localhost (124-169-15-204.dyn.iinet.net.au [124.169.15.204])
        by mail.messagingengine.com (Postfix) with ESMTPA id EE1CEE4448;
        Thu, 21 Jun 2018 20:37:30 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Documentation: e100: Fix docs build error
Date:   Fri, 22 Jun 2018 10:37:07 +1000
Message-Id: <20180622003708.31848-4-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622003708.31848-1-me@tobin.cc>
References: <20180622003708.31848-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent patch updated e100 docs to rst format.  Docs build (`make
htmldocs`) is currently failing due to this file with error:

	(SEVERE/4) Unexpected section title.

This is because a section of the file is indented 2 spaces.  Build error
can be cleared by aligning the text with column 0.  While we are changing
these lines we can make sure line length does not exceed 72, that
newlines following headings are uniform, and that full stops are
followed by two spaces.

Align text with column 0, limit line length to 72, ensure two spaces
follow all full stops, ensure uniform use of newlines after heading.

Fixes commit (85d63445f411 Documentation: e100: Update the Intel 10/100 driver doc)

CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/networking/e100.rst | 115 +++++++++++++++---------------
 1 file changed, 58 insertions(+), 57 deletions(-)

diff --git a/Documentation/networking/e100.rst b/Documentation/networking/e100.rst
index 59b80608e27d..9708f5fa76de 100644
--- a/Documentation/networking/e100.rst
+++ b/Documentation/networking/e100.rst
@@ -87,83 +87,84 @@ Event Log Message Level:  The driver uses the message level flag to log events
 Additional Configurations
 =========================
 
-  Configuring the Driver on Different Distributions
-  -------------------------------------------------
-
-  Configuring a network driver to load properly when the system is started is
-  distribution dependent. Typically, the configuration process involves adding
-  an alias line to /etc/modprobe.d/*.conf as well as editing other system
-  startup scripts and/or configuration files.  Many popular Linux
-  distributions ship with tools to make these changes for you. To learn the
-  proper way to configure a network device for your system, refer to your
-  distribution documentation.  If during this process you are asked for the
-  driver or module name, the name for the Linux Base Driver for the Intel
-  PRO/100 Family of Adapters is e100.
-
-  As an example, if you install the e100 driver for two PRO/100 adapters
-  (eth0 and eth1), add the following to a configuration file in /etc/modprobe.d/
+Configuring the Driver on Different Distributions
+-------------------------------------------------
+
+Configuring a network driver to load properly when the system is started
+is distribution dependent.  Typically, the configuration process involves
+adding an alias line to /etc/modprobe.d/*.conf as well as editing other
+system startup scripts and/or configuration files.  Many popular Linux
+distributions ship with tools to make these changes for you.  To learn
+the proper way to configure a network device for your system, refer to
+your distribution documentation.  If during this process you are asked
+for the driver or module name, the name for the Linux Base Driver for
+the Intel PRO/100 Family of Adapters is e100.
+
+As an example, if you install the e100 driver for two PRO/100 adapters
+(eth0 and eth1), add the following to a configuration file in
+/etc/modprobe.d/::
 
        alias eth0 e100
        alias eth1 e100
 
-  Viewing Link Messages
-  ---------------------
-  In order to see link messages and other Intel driver information on your
-  console, you must set the dmesg level up to six. This can be done by
-  entering the following on the command line before loading the e100 driver::
+Viewing Link Messages
+---------------------
 
-       dmesg -n 6
-
-  If you wish to see all messages issued by the driver, including debug
-  messages, set the dmesg level to eight.
+In order to see link messages and other Intel driver information on your
+console, you must set the dmesg level up to six.  This can be done by
+entering the following on the command line before loading the e100
+driver::
 
-  NOTE: This setting is not saved across reboots.
+       dmesg -n 6
 
+If you wish to see all messages issued by the driver, including debug
+messages, set the dmesg level to eight.
 
-  ethtool
-  -------
+NOTE: This setting is not saved across reboots.
 
-  The driver utilizes the ethtool interface for driver configuration and
-  diagnostics, as well as displaying statistical information.  The ethtool
-  version 1.6 or later is required for this functionality.
+ethtool
+-------
 
-  The latest release of ethtool can be found from
-  https://www.kernel.org/pub/software/network/ethtool/
+The driver utilizes the ethtool interface for driver configuration and
+diagnostics, as well as displaying statistical information.  The ethtool
+version 1.6 or later is required for this functionality.
 
-  Enabling Wake on LAN* (WoL)
-  ---------------------------
-  WoL is provided through the ethtool* utility.  For instructions on enabling
-  WoL with ethtool, refer to the ethtool man page.
+The latest release of ethtool can be found from
+https://www.kernel.org/pub/software/network/ethtool/
 
-  WoL will be enabled on the system during the next shut down or reboot. For
-  this driver version, in order to enable WoL, the e100 driver must be
-  loaded when shutting down or rebooting the system.
+Enabling Wake on LAN* (WoL)
+---------------------------
+WoL is provided through the ethtool* utility.  For instructions on
+enabling WoL with ethtool, refer to the ethtool man page.  WoL will be
+enabled on the system during the next shut down or reboot.  For this
+driver version, in order to enable WoL, the e100 driver must be loaded
+when shutting down or rebooting the system.
 
-  NAPI
-  ----
+NAPI
+----
 
-  NAPI (Rx polling mode) is supported in the e100 driver.
+NAPI (Rx polling mode) is supported in the e100 driver.
 
-  See https://wiki.linuxfoundation.org/networking/napi for more information
-  on NAPI.
+See https://wiki.linuxfoundation.org/networking/napi for more
+information on NAPI.
 
-  Multiple Interfaces on Same Ethernet Broadcast Network
-  ------------------------------------------------------
+Multiple Interfaces on Same Ethernet Broadcast Network
+------------------------------------------------------
 
-  Due to the default ARP behavior on Linux, it is not possible to have
-  one system on two IP networks in the same Ethernet broadcast domain
-  (non-partitioned switch) behave as expected. All Ethernet interfaces
-  will respond to IP traffic for any IP address assigned to the system.
-  This results in unbalanced receive traffic.
+Due to the default ARP behavior on Linux, it is not possible to have one
+system on two IP networks in the same Ethernet broadcast domain
+(non-partitioned switch) behave as expected.  All Ethernet interfaces
+will respond to IP traffic for any IP address assigned to the system.
+This results in unbalanced receive traffic.
 
-  If you have multiple interfaces in a server, either turn on ARP
-  filtering by
+If you have multiple interfaces in a server, either turn on ARP
+filtering by
 
-  (1) entering:: echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter
-      (this only works if your kernel's version is higher than 2.4.5), or
+(1) entering:: echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter
+    (this only works if your kernel's version is higher than 2.4.5), or
 
-  (2) installing the interfaces in separate broadcast domains (either
-      in different switches or in a switch partitioned to VLANs).
+(2) installing the interfaces in separate broadcast domains (either
+    in different switches or in a switch partitioned to VLANs).
 
 
 Support
-- 
2.17.1

