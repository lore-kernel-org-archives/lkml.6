Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D167ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5782147E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="kOeQoNSm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t+yV6wd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5782147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbeGQFAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 01:00:03 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:43809 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726753AbeGQFAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 01:00:03 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8AF29207;
        Tue, 17 Jul 2018 00:29:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 17 Jul 2018 00:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=E51ZeaKeSCSZRdA9s
        nfWGr7eofIzogqKM9jkSzBBtWE=; b=kOeQoNSmMxT29wERXH/G4mMUeMDEWQGLf
        vlP2Ulc2MwaC6i8SrMatuvDFb+B219649uO+hNXucCKPOygcbp92hTXb3QYlBIlV
        F/yjSBzGuup7gmzEi7fQyvz9nuMaWaRMH5QHk03JHBr+Q6XCKUFxbCurlD9hzpUP
        70H6GYJaaHSLxRyu2PIdpHGS0xTDWo5ZCNDe1KMDJYSbcopIhLJFeUpJ+QwHcJtX
        b+SOmtpmEmTicz0v6TOIle89TRss2QWQBYzqQkBLMVxZ7WqZGNjPF6rtM/XRgk06
        2y7SSEYKlC4QDEcL/zZgP1SuAqEHTTVX+E4uM/KN8EPtutaIEPRnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=E51ZeaKeSCSZRdA9snfWGr7eofIzogqKM9jkSzBBtWE=; b=t+yV6wd/
        F2SJzZHBbny6xE/vvwgOqwEmMAj+l+Ok8Q/6lRxRrbgEpwqvQzg6JbuhkS+Mmuxu
        0riYH0+rEoYtYwZgmu1L+R3wrWt4QnvN+KyN0gUT1EH7CYBmhWHnqlFBzlmg/nmi
        KdF8uodBbLQw5u0aHgIoMmbYm/pY2NvojB9NvTd5wzpABDfj3Fo1lC8NUjZ61dRL
        DyNkYshn0ptEcl2G56I3mMGb7LQEbSk2IjJKY0hcjS+X5Mc80z0aWajkW+0P1+YF
        6/J63blY3Q+pYyvkChkcpaKLPnJTJvbXcgaRrZmAXDUkVNgH74ZmKIn+rJBok7Ah
        CvXv34/drtYtQA==
X-ME-Proxy: <xmx:pXBNWzhzrHtnVzV9Fmg6MMxuvIAv4Q_zfa7spRyx12GDX9pd8MXH2Q>
    <xmx:pXBNW790vtgQMbj2YPPYFvBN7KelMaf5sKa8FozuznDuq5u5VYVO-Q>
    <xmx:pXBNW2JsoEWlcxkPtVXgCBkY9a_KpEu7u0PHy6WPJTENzAC6ih3eWQ>
    <xmx:pXBNW7rh1dxVN09TyQdbdVMVULkCRxDBg7goohVsHsCaGspuwQNa6w>
    <xmx:pXBNWyxOy53HffXSlqG5h8k_II15Bzozsn1AOkXhiOPhk8rSWFwUdw>
    <xmx:pXBNW6IhL274QZnGGqc90Yw9z9WvsTg7CofKnhNUyREbQQnFHJ2EfQ>
X-ME-Sender: <xms:pXBNW3jdsh9jrGaSX1HdEYSJcXFoZLHC8T2mz_LoEIa-LBuQp6D2Mw>
Received: from localhost (ppp121-44-239-37.bras2.syd2.internode.on.net [121.44.239.37])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4E4F410268;
        Tue, 17 Jul 2018 00:29:24 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] docs: networking: Convert alias.txt to rst
Date:   Tue, 17 Jul 2018 14:29:05 +1000
Message-Id: <20180717042906.17308-3-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717042906.17308-1-me@tobin.cc>
References: <20180717042906.17308-1-me@tobin.cc>
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

