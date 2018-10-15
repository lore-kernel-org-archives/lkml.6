Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6274CC070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 03:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281EE20652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 03:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtAVQc4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281EE20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbeJOLHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 07:07:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46726 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeJOLHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 07:07:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id a5-v6so8447437pgv.13;
        Sun, 14 Oct 2018 20:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Vg0gtScgCCP9k5IJ1dmEV5H19mxplJnOzdjL4Hp18dk=;
        b=GtAVQc4enamXx7CgJro0Dbb5szuoCJtZGGR0Xi/ckxT3BnkeQ14AymkSKpkwV8J9nv
         LYpp9qx8iVka2oeOIKUxfCfUBFLzcmVccZpv906Km5Fl3J2xhS/ObIwPX6cb296SMRd3
         QriCh/TdQdW/OHTeMMWjvHS1dYtp26J4w9m7evftDmAmQHjK9Abzgecf+C8ZBdMoZvGg
         5OYsVR5Nf+n1akcKVLrcFFoqiL8FHjeTqFKUxdpbknCFsGUruJUFSv/Za5DeNuvPopXD
         L+qdp8LrSOzRTnd/koGNEXTtjXV1W2QvE4kfuCGCJFWIXuKScGONMS9uivtqUOtVXUkf
         1CeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vg0gtScgCCP9k5IJ1dmEV5H19mxplJnOzdjL4Hp18dk=;
        b=eQed9Uf+63l2I1ezAGrt6z0wi8OWVg7vUwhFOtdGg0+/GvJSu3UlsQx7vdgDpMig7Y
         GudeMhnVjliDNIf4uHrsIzsUPsOQBwUecaspRMp1Dh8u6m6udvn76Eh7qqaHdEzzIwIK
         4IhYfkpEsBqSBpeXd/DXthjeiAv3EYmH5UY0m1YkYNg0i31W5SotwN1qGCAdvIaQsZVH
         4bdXkYo9CIFcne7PiLhG4LF1bmHlPrY9/iIJsIVJk1OlOI3ACn6ficG1ely9GjwyygNV
         7pQ9VKwPWdg8PnKbecGVGdMJkemRp6//gp6sm7FE+o+u7adl/8A8F2iQsTm1HoytxaNS
         Gw/A==
X-Gm-Message-State: ABuFfogPRbQWp/XKSz0Dsa/ftHwyEjrtEAkTuvumpwEc9k5Wmz8fhDHc
        3FJM/MEcExq0AQQEo+CBFxAKP2Lx
X-Google-Smtp-Source: ACcGV63S27ZFlW1xWHSYWT43rEc9CEGt3tBmXFd2v1BOlOAy+jXfoGMh6OsGj+55zhAsmQmghmRRWA==
X-Received: by 2002:a62:3a84:: with SMTP id v4-v6mr15677943pfj.118.1539573824683;
        Sun, 14 Oct 2018 20:23:44 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id f1-v6sm15209402pgc.4.2018.10.14.20.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Oct 2018 20:23:44 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of: Documentation: remove unmaintained todo file
Date:   Sun, 14 Oct 2018 20:22:19 -0700
Message-Id: <1539573739-2108-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

The todo.txt file was created by a previous maintainer and has
never been updated by the current OPEN FIRMWARE AND FLATTENED
DEVICE TREE maintainers.  Remove the out of date file.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 Documentation/devicetree/todo.txt | 10 ----------
 1 file changed, 10 deletions(-)
 delete mode 100644 Documentation/devicetree/todo.txt

diff --git a/Documentation/devicetree/todo.txt b/Documentation/devicetree/todo.txt
deleted file mode 100644
index b5139d1de811..000000000000
--- a/Documentation/devicetree/todo.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-Todo list for devicetree:
-
-=== General structure ===
-- Switch from custom lists to (h)list_head for nodes and properties structure
-
-=== CONFIG_OF_DYNAMIC ===
-- Switch to RCU for tree updates and get rid of global spinlock
-- Document node lifecycle for CONFIG_OF_DYNAMIC
-- Always set ->full_name at of_attach_node() time
-- pseries: Get rid of open-coded tree modification from arch/powerpc/platforms/pseries/dlpar.c
-- 
Frank Rowand <frank.rowand@sony.com>

