Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8156C070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 03:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7568120842
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 03:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zlbb6h9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7568120842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbeJOK5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 06:57:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42378 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbeJOK5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 06:57:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id f26-v6so8914788pfn.9;
        Sun, 14 Oct 2018 20:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BrHddvKGpYUHawJpU0azhUMBZbkEXYumUQGztoEq1Mk=;
        b=Zlbb6h9+oPOdQHCE5/4KZqwKZox1skQViAmRYN46UEd/r/VckmOR+4TFYYa1GOFZ1p
         qumC2PcMMMJuoO6LVwp3o74gwmO2JrDhFNkR+eH1Kp0SAQlo32YUpoXCC0t/qkOpnAmQ
         lL/6x51flheiC6a6Wz1Pday15UBvtfWNgv9a3KW/+bW4vQqqyPxiFPCkw28BL/qQh9Td
         O13y+6E8CODiJHuT9fjyaJ64nYydFwyWHmgOkxp8O7EgQmb6PvqiRPyATHX9KuNz9YMc
         1jLmwzr+bhQZD3e/l4RPq8riYz49GeJ3PUzfHTE33BxOf5lHoH+BKzxKkRQERU9hDcmN
         T/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BrHddvKGpYUHawJpU0azhUMBZbkEXYumUQGztoEq1Mk=;
        b=MUHjcVVBOPU6ppAZX5hyWGVDvdd3OMD7Cokiwtr4otjOp6C6JIk87SgsbFSEjEzRuM
         BFg7/rQ5+cSvFT493YgB27BOsM400KgUEj/2dtaG2K/Omzz6jGvAa2u4uqFcZhQMHF99
         GcsAmCkPvpPkVL0UziQcSA/DUVzSpz4P2mnBnB8X+ll2y1r8gQ4KL9wq/9hEqHkO+tIM
         FU7qN1OeDGfsOg8Wf19jv7t5qomjkCe/tQurDnwd8Lws2wEuhwzKQXC2qn16GyDYkhtX
         y1FmRYepbMAuL4RJkm4z0VHl0b+y4enXtoltzn5An5vhXzQlTTZwZpBojjqKAsja41EB
         PqBw==
X-Gm-Message-State: ABuFfohrUD4V7fmSpqK3PsCeCfP3Bl/Qsc3FmOYR5wTsHlQEshnqxiIO
        rHcDUN4JrzrVI0SQOWbpnRw=
X-Google-Smtp-Source: ACcGV60AqGj63opk+AnM0UZAUQia9fUJbuh0nKxMiuCoJB5opphlTLpUlKuptojnKC2JY5KDiIohLQ==
X-Received: by 2002:a62:9951:: with SMTP id d78-v6mr15550455pfe.239.1539573268878;
        Sun, 14 Oct 2018 20:14:28 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id c24-v6sm13740796pgn.60.2018.10.14.20.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Oct 2018 20:14:28 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, Alan Tull <atull@kernel.org>
Subject: [PATCH] of: overlay: update documentation to match current implementation
Date:   Sun, 14 Oct 2018 20:13:03 -0700
Message-Id: <1539573183-1905-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

The overlay information in Documentation/devicetree/ is out of date.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 .../devicetree/dynamic-resolution-notes.txt        | 24 ------
 Documentation/devicetree/overlay-notes.txt         | 93 ++++++++++------------
 2 files changed, 42 insertions(+), 75 deletions(-)
 delete mode 100644 Documentation/devicetree/dynamic-resolution-notes.txt

diff --git a/Documentation/devicetree/dynamic-resolution-notes.txt b/Documentation/devicetree/dynamic-resolution-notes.txt
deleted file mode 100644
index c24ec366c5dc..000000000000
--- a/Documentation/devicetree/dynamic-resolution-notes.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Device Tree Dynamic Resolver Notes
-----------------------------------
-
-This document describes the implementation of the in-kernel
-Device Tree resolver, residing in drivers/of/resolver.c
-
-How the resolver works
-----------------------
-
-The resolver is given as an input an arbitrary tree compiled with the
-proper dtc option and having a /plugin/ tag. This generates the
-appropriate __fixups__ & __local_fixups__ nodes.
-
-In sequence the resolver works by the following steps:
-
-1. Get the maximum device tree phandle value from the live tree + 1.
-2. Adjust all the local phandles of the tree to resolve by that amount.
-3. Using the __local__fixups__ node information adjust all local references
-   by the same amount.
-4. For each property in the __fixups__ node locate the node it references
-   in the live tree. This is the label used to tag the node.
-5. Retrieve the phandle of the target of the fixup.
-6. For each fixup in the property locate the node:property:offset location
-   and replace it with the phandle value.
diff --git a/Documentation/devicetree/overlay-notes.txt b/Documentation/devicetree/overlay-notes.txt
index 725fb8d255c1..5b34b2318c59 100644
--- a/Documentation/devicetree/overlay-notes.txt
+++ b/Documentation/devicetree/overlay-notes.txt
@@ -2,8 +2,8 @@ Device Tree Overlay Notes
 -------------------------
 
 This document describes the implementation of the in-kernel
-device tree overlay functionality residing in drivers/of/overlay.c and is a
-companion document to Documentation/devicetree/dynamic-resolution-notes.txt[1]
+device tree overlay functionality residing in drivers/of/overlay.c and
+drivers/of/resolver.c.
 
 How overlays work
 -----------------
@@ -34,26 +34,23 @@ Lets take an example where we have a foo board with the following base tree:
 	};
 ---- foo.dts -----------------------------------------------------------------
 
-The overlay bar.dts, when loaded (and resolved as described in [1]) should
+The overlay bar.dts, when processed by the devicetree resolver (as described
+later in this document) and applied to the live devicetree) will result in a
+live devicetree that is equivalent to foo+bar.dts.
 
 ---- bar.dts -----------------------------------------------------------------
 /plugin/;	/* allow undefined label references and record them */
 / {
-	....	/* various properties for loader use; i.e. part id etc. */
-	fragment@0 {
-		target = <&ocp>;
-		__overlay__ {
-			/* bar peripheral */
-			bar {
-				compatible = "corp,bar";
-				... /* various properties and child nodes */
-			}
-		};
+	&ocp: {
+		/* bar peripheral */
+		bar {
+			compatible = "corp,bar";
+			... /* various properties and child nodes */
+		}
 	};
 };
 ---- bar.dts -----------------------------------------------------------------
 
-result in foo+bar.dts
 
 ---- foo+bar.dts -------------------------------------------------------------
 	/* FOO platform + bar peripheral */
@@ -78,14 +75,16 @@ result in foo+bar.dts
 	};
 ---- foo+bar.dts -------------------------------------------------------------
 
-As a result of the overlay, a new device node (bar) has been created
-so a bar platform device will be registered and if a matching device driver
-is loaded the device will be created as expected.
+As a result of the overlay, a new device node (bar) has been created.  Thus
+a bar platform device will have been registered.  If a matching device
+driver is loaded the device will have been created as expected.
 
-Overlay in-kernel API
---------------------------------
+An overlay may specify the location of a node in the overlay with path
+notation as the label reference.  In the bar.dts example above, '&ocp:'
+can also be expressed as '&{/ocp/}'.
 
-The API is quite easy to use.
+Overlay in-kernel API
+---------------------
 
 1. Call of_overlay_fdt_apply() to create and apply an overlay changeset. The
 return value is an error or a cookie identifying this overlay.
@@ -106,34 +105,26 @@ Note that a notifier callback is not supposed to store pointers to a device
 tree node or its content beyond OF_OVERLAY_POST_REMOVE corresponding to the
 respective node it received.
 
-Overlay DTS Format
-------------------
-
-The DTS of an overlay should have the following format:
-
-{
-	/* ignored properties by the overlay */
-
-	fragment@0 {	/* first child node */
-
-		target=<phandle>;	/* phandle target of the overlay */
-	or
-		target-path="/path";	/* target path of the overlay */
-
-		__overlay__ {
-			property-a;	/* add property-a to the target */
-			node-a {	/* add to an existing, or create a node-a */
-				...
-			};
-		};
-	}
-	fragment@1 {	/* second child node */
-		...
-	};
-	/* more fragments follow */
-}
-
-Using the non-phandle based target method allows one to use a base DT which does
-not contain a __symbols__ node, i.e. it was not compiled with the -@ option.
-The __symbols__ node is only required for the target=<phandle> method, since it
-contains the information required to map from a phandle to a tree location.
+How the devicetree resolver works
+---------------------------------
+
+The resolver is given as an input an arbitrary devicetree source that contains
+a /plugin/ tag and has been compiled into an FDT.  The FDT is unflattened into
+a detached devicetree.  The resolver is responsible for updating the node
+phandle values the detached tree is updating the phandle values contained
+in properties in the detached tree.
+
+In sequence the resolver works by the following steps:
+
+1. Get the maximum devicetree phandle value from the live tree + 1.  This
+   will be used as the phandle offset.
+2. Adjust all the node phandles of the detached tree by adding the phandle
+   offset.
+3. The local fixups metadata in the detached tree contains a list of property
+   values in the detached tree that are references to symbols in the detached
+   tree.  Adjust these property values by adding the phandle offset.
+4. The fixups metadata in the detached tree contains a list of property
+   values in the detached tree that are references to symbols in the live
+   devicetree.  For each of these property values, determine the phandle
+   value corresponding the the symbol and update the property value
+   accordingly.
-- 
Frank Rowand <frank.rowand@sony.com>

