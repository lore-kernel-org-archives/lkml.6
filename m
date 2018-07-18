Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BFEECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB08020850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="kVYO68gd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VlhxaMHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB08020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbeGREDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 00:03:37 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:37629 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725721AbeGREDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 00:03:36 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E57032FD;
        Tue, 17 Jul 2018 23:27:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 17 Jul 2018 23:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=E51ZeaKeSCSZRdA9s
        nfWGr7eofIzogqKM9jkSzBBtWE=; b=kVYO68gd1kh+XOzOLYCHi9ciJRo4+ah9N
        jL8/phO+at5Fmn+U6Ept9YwSxSEjgCH2XAc5sUYalOS4kSQYwzPNrZhhwkaAmaey
        nXfzzTAJz8gYCGKcsmqiZY7T60r3qZRt/MC+WAXtNlkSDRGkh8sGdietBSJfor+V
        8+jKp3BLNHH6JGjdj8fdPu1k6e1PSXYHuKrqDOJEnE55tlGyklh2vtBwWG7ikYN7
        YzhT7Billf/FDs5PbdpiIRerSATDlU/VkMyM1SGET++D29MwyQqenmyPLdybuhry
        MTyNdfpD0b25O1L/UXYd1xljEtwKnpwymL2l6VLfWur4h60qZzYLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=E51ZeaKeSCSZRdA9snfWGr7eofIzogqKM9jkSzBBtWE=; b=VlhxaMHI
        U6A1D/3bx8Bevoroq0TOhptD3fpECqppqo6xP0YOmpFZ+vk+xiCFXFaqVnK9AMp/
        QBRwDQNyPNVP53ChJ+nh97ryT+e9Zk5xVzp8CmugEfQ4FjRjuHUUB+iDta0L8mbK
        v6/zifa9Xc81X0b8qXZ1GlBq8XI0U2/+/1Nu8cGqTOy8HA+gZ1iPeZ7yJ1TmJCUw
        6YMyzgCkWJnbAPBot7vWvZCd1p33RkJvfeD2zmCT45aPozbl1pdOSVecxm48AutN
        YVmjA3rpBu23q0yDARp/Hn2pcgrnbgnvyh1VYbOJWRBvovaODhjoRdkHsf9ce4+S
        4c8E3blBn3g0mg==
X-ME-Proxy: <xmx:uLNOW7Y3l7hEe4zaGlk4OSsPIYcf_FpP1Th6y5u21nuriB2JPnFSZQ>
    <xmx:uLNOWzW6_o2hjdNtHF4OYBDPU9E1w5WcYEqCPhMyYBWltCb6UcYgKA>
    <xmx:uLNOW_7RNI1OUzQo8KbsaofWtr0uGB4bdrjK0T-pzygc0NsFxN4cDQ>
    <xmx:uLNOW-hP5EkZYhEtYS8v_f4rC57x0KlsRYeqo6ikFqtEOs5otjpS3Q>
    <xmx:uLNOW2dtsiFEgwc5bMnDvfvkSkFoXUuqFad3Aag72ZnIlHjsad8uFA>
    <xmx:uLNOW3oIAYY25GIqtSf0bU5uzNhuQIXaeS9yDHUG8k2NwzMe5JxkRQ>
X-ME-Sender: <xms:uLNOWyyi4LTo7F505ZbsNQpFiczu5ChpAwMyr3E1oehzkn98zp-8BQ>
Received: from localhost (124-169-0-210.dyn.iinet.net.au [124.169.0.210])
        by mail.messagingengine.com (Postfix) with ESMTPA id A002CE48A9;
        Tue, 17 Jul 2018 23:27:51 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Markus Heiser <markus.heiser@darmarit.de>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] docs: networking: Convert alias.txt to rst
Date:   Wed, 18 Jul 2018 13:27:35 +1000
Message-Id: <20180718032736.8000-2-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718032736.8000-1-me@tobin.cc>
References: <20180718032736.8000-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel documentation is now restructured text. Convert the IP
aliasing documentation and include it in the toplevel kernel
documentation.

 - Fix heading adornments.
 - Correctly indent code snippets.
 - Limit line length to 72 characters inline with kernel documentation
   standards.
 - Add license identifier.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/networking/00-INDEX  |  2 --
 Documentation/networking/alias.rst | 49 ++++++++++++++++++++++++++++++
 Documentation/networking/alias.txt | 40 ------------------------
 Documentation/networking/index.rst |  1 +
 4 files changed, 50 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/networking/alias.rst
 delete mode 100644 Documentation/networking/alias.txt

diff --git a/Documentation/networking/00-INDEX b/Documentation/networking/00-INDEX
index 2b89d91b376f..1e5153ed8990 100644
--- a/Documentation/networking/00-INDEX
+++ b/Documentation/networking/00-INDEX
@@ -18,8 +18,6 @@ README.ipw2200
 	- README for the Intel PRO/Wireless 2915ABG and 2200BG driver.
 README.sb1000
 	- info on General Instrument/NextLevel SURFboard1000 cable modem.
-alias.txt
-	- info on using alias network devices.
 altera_tse.txt
 	- Altera Triple-Speed Ethernet controller.
 arcnet-hardware.txt
diff --git a/Documentation/networking/alias.rst b/Documentation/networking/alias.rst
new file mode 100644
index 000000000000..af7c5ee92014
--- /dev/null
+++ b/Documentation/networking/alias.rst
@@ -0,0 +1,49 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========
+IP-Aliasing
+===========
+
+IP-aliases are an obsolete way to manage multiple IP-addresses/masks
+per interface. Newer tools such as iproute2 support multiple
+address/prefixes per interface, but aliases are still supported
+for backwards compatibility.
+
+An alias is formed by adding a colon and a string when running ifconfig.
+This string is usually numeric, but this is not a must.
+
+
+Alias creation
+==============
+
+Alias creation is done by 'magic' interface naming: eg. to create a
+200.1.1.1 alias for eth0 ...
+::
+
+  # ifconfig eth0:0 200.1.1.1  etc,etc....
+	~~ -> request alias #0 creation (if not yet exists) for eth0
+
+The corresponding route is also set up by this command.  Please note:
+The route always points to the base interface.
+
+
+Alias deletion
+==============
+
+The alias is removed by shutting the alias down::
+
+  # ifconfig eth0:0 down
+	~~~~~~~~~~ -> will delete alias
+
+
+Alias (re-)configuring
+======================
+
+Aliases are not real devices, but programs should be able to configure
+and refer to them as usual (ifconfig, route, etc).
+
+
+Relationship with main device
+=============================
+
+If the base device is shut down the added aliases will be deleted too.
diff --git a/Documentation/networking/alias.txt b/Documentation/networking/alias.txt
deleted file mode 100644
index 85046f53fcfc..000000000000
--- a/Documentation/networking/alias.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-
-IP-Aliasing:
-============
-
-IP-aliases are an obsolete way to manage multiple IP-addresses/masks
-per interface. Newer tools such as iproute2 support multiple
-address/prefixes per interface, but aliases are still supported
-for backwards compatibility.
-
-An alias is formed by adding a colon and a string when running ifconfig.
-This string is usually numeric, but this is not a must.
-
-o Alias creation.
-  Alias creation is done by 'magic' interface naming: eg. to create a
-  200.1.1.1 alias for eth0 ...
-  
-    # ifconfig eth0:0 200.1.1.1  etc,etc....
-                   ~~ -> request alias #0 creation (if not yet exists) for eth0
-
-    The corresponding route is also set up by this command. 
-    Please note: The route always points to the base interface.
-	
-
-o Alias deletion.
-  The alias is removed by shutting the alias down:
-
-    # ifconfig eth0:0 down
-                 ~~~~~~~~~~ -> will delete alias
-
-  		   		   
-o Alias (re-)configuring
-
-  Aliases are not real devices, but programs should be able to configure and
-  refer to them as usual (ifconfig, route, etc).
-
-
-o Relationship with main device
-
-  If the base device is shut down the added aliases will be deleted 
-  too.
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index a4bbde70bcb9..65502f2031a8 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -17,6 +17,7 @@ Contents:
    msg_zerocopy
    failover
    net_failover
+   alias
 
 .. only::  subproject
 
-- 
2.17.1

