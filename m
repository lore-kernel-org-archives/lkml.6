Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418F2C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010F52683D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010F52683D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934304AbeFZJvs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:51:48 -0400
Received: from osg.samsung.com ([64.30.133.232]:50565 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933481AbeFZJtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:49:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 51C0330BAA;
        Tue, 26 Jun 2018 02:49:18 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Nxjdd3fLdDuu; Tue, 26 Jun 2018 02:49:17 -0700 (PDT)
Received: from smtp.s-opensource.com (177.41.130.70.dynamic.adsl.gvt.net.br [177.41.130.70])
        by osg.samsung.com (Postfix) with ESMTPSA id 6A58530B87;
        Tue, 26 Jun 2018 02:49:16 -0700 (PDT)
Received: from mchehab by smtp.s-opensource.com with local (Exim 4.91)
        (envelope-from <mchehab@smtp.s-opensource.com>)
        id 1fXkb4-0000m6-9b; Tue, 26 Jun 2018 06:49:14 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [PATCH 7/9] networking: e100.rst: Get rid of Sphinx warnings
Date:   Tue, 26 Jun 2018 06:49:09 -0300
Message-Id: <48ca5da5770c63ec56e9e9df76e3528c1bcb4414.1530005114.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1530005114.git.mchehab+samsung@kernel.org>
References: <cover.1530005114.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1530005114.git.mchehab+samsung@kernel.org>
References: <cover.1530005114.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    Documentation/networking/e100.rst:57: WARNING: Literal block expected; none found.
    Documentation/networking/e100.rst:68: WARNING: Literal block expected; none found.
    Documentation/networking/e100.rst:75: WARNING: Literal block expected; none found.
    Documentation/networking/e100.rst:84: WARNING: Literal block expected; none found.
    Documentation/networking/e100.rst:93: WARNING: Inline emphasis start-string without end-string.

While here, fix some highlights.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/networking/e100.rst | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/e100.rst b/Documentation/networking/e100.rst
index 9708f5fa76de..f81111eba9c5 100644
--- a/Documentation/networking/e100.rst
+++ b/Documentation/networking/e100.rst
@@ -47,41 +47,45 @@ Driver Configuration Parameters
 The default value for each parameter is generally the recommended setting,
 unless otherwise noted.
 
-Rx Descriptors: Number of receive descriptors. A receive descriptor is a data
+Rx Descriptors:
+   Number of receive descriptors. A receive descriptor is a data
    structure that describes a receive buffer and its attributes to the network
    controller. The data in the descriptor is used by the controller to write
    data from the controller to host memory. In the 3.x.x driver the valid range
    for this parameter is 64-256. The default value is 256. This parameter can be
    changed using the command::
 
-   ethtool -G eth? rx n
+     ethtool -G eth? rx n
 
    Where n is the number of desired Rx descriptors.
 
-Tx Descriptors: Number of transmit descriptors. A transmit descriptor is a data
+Tx Descriptors:
+   Number of transmit descriptors. A transmit descriptor is a data
    structure that describes a transmit buffer and its attributes to the network
    controller. The data in the descriptor is used by the controller to read
    data from the host memory to the controller. In the 3.x.x driver the valid
    range for this parameter is 64-256. The default value is 128. This parameter
    can be changed using the command::
 
-   ethtool -G eth? tx n
+     ethtool -G eth? tx n
 
    Where n is the number of desired Tx descriptors.
 
-Speed/Duplex: The driver auto-negotiates the link speed and duplex settings by
+Speed/Duplex:
+   The driver auto-negotiates the link speed and duplex settings by
    default. The ethtool utility can be used as follows to force speed/duplex.::
 
-   ethtool -s eth?  autoneg off speed {10|100} duplex {full|half}
+     ethtool -s eth?  autoneg off speed {10|100} duplex {full|half}
 
    NOTE: setting the speed/duplex to incorrect values will cause the link to
    fail.
 
-Event Log Message Level:  The driver uses the message level flag to log events
+Event Log Message Level:
+   The driver uses the message level flag to log events
    to syslog. The message level can be set at driver load time. It can also be
    set using the command::
 
-   ethtool -s eth? msglvl n
+     ethtool -s eth? msglvl n
 
 
 Additional Configurations
@@ -92,7 +96,7 @@ Configuring the Driver on Different Distributions
 
 Configuring a network driver to load properly when the system is started
 is distribution dependent.  Typically, the configuration process involves
-adding an alias line to /etc/modprobe.d/*.conf as well as editing other
+adding an alias line to `/etc/modprobe.d/*.conf` as well as editing other
 system startup scripts and/or configuration files.  Many popular Linux
 distributions ship with tools to make these changes for you.  To learn
 the proper way to configure a network device for your system, refer to
@@ -160,7 +164,10 @@ This results in unbalanced receive traffic.
 If you have multiple interfaces in a server, either turn on ARP
 filtering by
 
-(1) entering:: echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter
+(1) entering::
+
+	echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter
+
     (this only works if your kernel's version is higher than 2.4.5), or
 
 (2) installing the interfaces in separate broadcast domains (either
-- 
2.17.1

