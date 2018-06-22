Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D03AC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFE122BCF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="nzAltdf2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C3t3VFNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFE122BCF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934196AbeFVAhj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 20:37:39 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53019 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934129AbeFVAhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 20:37:36 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7C67F21BD2;
        Thu, 21 Jun 2018 20:37:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Jun 2018 20:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=CteCNjkOVcorqDAqT
        0ZcOmqYj3/Q4P2LuREvzUnX0yc=; b=nzAltdf2J/oVYZqqNZUDJSQIvGsOUYq3x
        6NxhikjfFVZSz4jkUygTSFkGXOWrn7ozGwRJqmlwN5Yr3azKLO/4WHkqBojDFXHi
        KQGnnLxMdgyncvThFtYBipaDifDxLvsDpt5EeCqor6LiUIhKlaGGn/JQFVoAEkSR
        BSG1B9lOouphcySYi58RgtkW2NkapzDXo/y6UHNARMCpKw+I7593kK8fbhH/iLAE
        QoJNLSETWKgwuT2uJVT2yX//US4Ny5acT7ku65ddiCMLOk1GMPglT++yXQb4dnxL
        xplbhmEcunqjOnuJbNHLZQM1DKE2tU3BIRqkzvfrcdLhcFjX+9grA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=CteCNjkOVcorqDAqT0ZcOmqYj3/Q4P2LuREvzUnX0yc=; b=C3t3VFNW
        wkNT9jdNHbPLvdLHEYbapgaDHMKr6ocjnW0t9xsGM2mrRFQJ5T4ABdlznEWWpADY
        YUag0jhlEPObSAK0dDXoIC0uOOCWy+t3Un2cIt2uhwglSjr0HWlg6Fqw+1nOy0a9
        9Htap7qpxrrCghQbrLrf3HfSJ7NdecCiGyzgktn1wm0NGBTDhiIOcuZIVpkbVMu6
        2IeQdnRsDVSmY5Vde3kR24Y1hJYs6IkzFIqRIxTXkq3AhD95QK/q+4J921wFuvmB
        Zhewd22JiyiQh6gAg8rigoHnS/oHks7Y5DCFL5mT0OzHaNixvfdCPX6GCNtBMyjO
        cro3yVF6t/VL5Q==
X-ME-Proxy: <xmx:z0QsW9BATqeEFM3BatJy4NHpx6ClBKfcayHiGruR9ky5diEdD5UB7A>
    <xmx:z0QsW6PejfzU4fD9E-oduCQ7RvEB5-7dSAdipgXDIm5ozhBU9R0Ttw>
    <xmx:z0QsW61eny7S3yc05Q3JHkZp03CkJMrJj3v63UAE1D6Cy_MhUNdpmg>
    <xmx:z0QsWw6MBBDIonLzZvUhkzNRwYNk04KL-gg_65yd2RaxHSnKCj7Pbg>
    <xmx:z0QsW3fPaohmpUfQF0n7tEQFKeXqW0H0bCZo1lcD8rKr1ydTQBz6WQ>
    <xmx:z0QsW9IUmc6cqm5_7oyiPhvYfweO427jEuYi21Vn9xeJKQ_i7ubstA>
X-ME-Sender: <xms:z0QsW2taIZ8D08HTDm-LfzQ9829jSfKB0sYaWPWNEH_1eD2f71kApg>
Received: from localhost (124-169-15-204.dyn.iinet.net.au [124.169.15.204])
        by mail.messagingengine.com (Postfix) with ESMTPA id A205DE4115;
        Thu, 21 Jun 2018 20:37:34 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Documentation: e1000: Fix docs build error
Date:   Fri, 22 Jun 2018 10:37:08 +1000
Message-Id: <20180622003708.31848-5-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622003708.31848-1-me@tobin.cc>
References: <20180622003708.31848-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent patch updated e1000 docs to rst format.  Docs build (`make
htmldocs`) is currently failing due to this file with error:

        (SEVERE/4) Unexpected section title.

This is because a section of the file is indented 2 spaces.  Build error
can be cleared by aligning the text with column 0.  While we are changing
these lines we can make sure line length does not exceed 72, that
newlines following headings are uniform, and that full stops are
followed by two spaces.

Align text with column 0, limit line length to 72, ensure two spaces
follow all full stops, ensure uniform use of newlines after heading.

Fixes commit (228046e76189 Documentation: e1000: Update kernel documentation)

CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/networking/e1000.rst | 75 +++++++++++++++---------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/Documentation/networking/e1000.rst b/Documentation/networking/e1000.rst
index 55f28e5043b6..144b87eef153 100644
--- a/Documentation/networking/e1000.rst
+++ b/Documentation/networking/e1000.rst
@@ -355,57 +355,58 @@ previously mentioned to force the adapter to the same speed and duplex.
 Additional Configurations
 =========================
 
-  Jumbo Frames
-  ------------
-  Jumbo Frames support is enabled by changing the MTU to a value larger than
-  the default of 1500.  Use the ifconfig command to increase the MTU size.
-  For example::
+Jumbo Frames
+------------
+Jumbo Frames support is enabled by changing the MTU to a value larger
+than the default of 1500.  Use the ifconfig command to increase the MTU
+size.  For example::
 
        ifconfig eth<x> mtu 9000 up
 
-  This setting is not saved across reboots.  It can be made permanent if
-  you add::
+This setting is not saved across reboots.  It can be made permanent if
+you add::
 
        MTU=9000
 
-   to the file /etc/sysconfig/network-scripts/ifcfg-eth<x>.  This example
-   applies to the Red Hat distributions; other distributions may store this
-   setting in a different location.
+to the file /etc/sysconfig/network-scripts/ifcfg-eth<x>.  This example
+applies to the Red Hat distributions; other distributions may store this
+setting in a different location.
 
-  Notes:
-  Degradation in throughput performance may be observed in some Jumbo frames
-  environments. If this is observed, increasing the application's socket buffer
-  size and/or increasing the /proc/sys/net/ipv4/tcp_*mem entry values may help.
-  See the specific application manual and /usr/src/linux*/Documentation/
-  networking/ip-sysctl.txt for more details.
+Notes: Degradation in throughput performance may be observed in some
+Jumbo frames environments.  If this is observed, increasing the
+application's socket buffer size and/or increasing the
+/proc/sys/net/ipv4/tcp_*mem entry values may help.  See the specific
+application manual and /usr/src/linux*/Documentation/
+networking/ip-sysctl.txt for more details.
 
-  - The maximum MTU setting for Jumbo Frames is 16110.  This value coincides
-    with the maximum Jumbo Frames size of 16128.
+- The maximum MTU setting for Jumbo Frames is 16110.  This value
+  coincides with the maximum Jumbo Frames size of 16128.
 
-  - Using Jumbo frames at 10 or 100 Mbps is not supported and may result in
-    poor performance or loss of link.
+- Using Jumbo frames at 10 or 100 Mbps is not supported and may result
+  in poor performance or loss of link.
 
-  - Adapters based on the Intel(R) 82542 and 82573V/E controller do not
-    support Jumbo Frames. These correspond to the following product names:
-     Intel(R) PRO/1000 Gigabit Server Adapter
-     Intel(R) PRO/1000 PM Network Connection
+- Adapters based on the Intel(R) 82542 and 82573V/E controller do not
+  support Jumbo Frames.  These correspond to the following product names:
+  Intel(R) PRO/1000 Gigabit Server Adapter Intel(R) PRO/1000 PM Network
+  Connection
 
-  ethtool
-  -------
-  The driver utilizes the ethtool interface for driver configuration and
-  diagnostics, as well as displaying statistical information.  The ethtool
-  version 1.6 or later is required for this functionality.
+ethtool
+-------
+The driver utilizes the ethtool interface for driver configuration and
+diagnostics, as well as displaying statistical information.  The ethtool
+version 1.6 or later is required for this functionality.
+
+The latest release of ethtool can be found from
+https://www.kernel.org/pub/software/network/ethtool/
 
-  The latest release of ethtool can be found from
-  https://www.kernel.org/pub/software/network/ethtool/
+Enabling Wake on LAN* (WoL)
+---------------------------
+WoL is configured through the ethtool* utility.
 
-  Enabling Wake on LAN* (WoL)
-  ---------------------------
-  WoL is configured through the ethtool* utility.
+WoL will be enabled on the system during the next shut down or reboot.
+For this driver version, in order to enable WoL, the e1000 driver must be
+loaded when shutting down or rebooting the system.
 
-  WoL will be enabled on the system during the next shut down or reboot.
-  For this driver version, in order to enable WoL, the e1000 driver must be
-  loaded when shutting down or rebooting the system.
 
 Support
 =======
-- 
2.17.1

