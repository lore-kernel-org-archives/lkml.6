Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD9AC0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641612086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VULamfwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641612086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeKIPqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 10:46:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41680 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbeKIPqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 10:46:48 -0500
Received: by mail-pl1-f193.google.com with SMTP id p16-v6so445502plr.8;
        Thu, 08 Nov 2018 22:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PG2ocAMiVixrDeygGSkU3xeZwD7YrFAmHiDnBCDK3aM=;
        b=VULamfwBqYrbnPluR35Rr2eBZFcuavn4wc+03Gfgu0SfzcdrZ5PgTzaQ3ihFGUvP1K
         +uaBFwssybDlujMglmnXguoh9tiYRt2+3m7ArGqjcvBr6TZsSGKD3zO8IICIocj7RE2K
         Zmp2I14L+DNxESGf2khLfL4a6D7MIZRr4DbWHPuca9WS54x4tXOwI2OpmoK6hjhObM43
         MFHhnLOoqd+m9LeMQAaRia0kw48rUGaJkgGXZOPTSAa5JiViuWsaI5GeMUhA2hYH61YJ
         0nUnlEVhA9GXtEJBu1qrPOZ2ELJp4XpnfjKYv/Kzr8y7hm6/v/a7fwjr73wxI6UeACNV
         ejKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PG2ocAMiVixrDeygGSkU3xeZwD7YrFAmHiDnBCDK3aM=;
        b=UZl1M2mr9VPm/9WmW/oIjjvnAgNRzg5FcBLPMZ+F0JyNFmzFB+WDujcverqIMj72iF
         6+GyaQnNXZPzoU9EyrYqWXuGtN/7l6e0jlmynUF55LK08O3di5OtUsjznQgO3YJ0PO6G
         gVBNYSQqD3NJqPwCTcaeI5D92AOrX5q895yiAEqUQ6+xekiZ2rfFIizVi54lIRGTIhdG
         3dyFNtcf++JxcjtOYhX0pmZpOXKbtlFTtHPs26LXKyi7ZXdeivMyT4oyNr63OJp+N0z7
         a8veNKGBD+jufyj87ntZ3yT3QZTyXF2KDE/F5EcEciB9X5gPpMGDEKS7Q2hxMb3Ds+o/
         5eEg==
X-Gm-Message-State: AGRZ1gLOT5NEehheyQDRoVR8GWZB8STKunJNf68G4AKIylew8P7XlUHU
        GzuJOYuFMNbRDCaJuKyrxr0=
X-Google-Smtp-Source: AJdET5fUAG3W+kWW6lAI5VHeSX5eFd7H00nE+t9QZao+yUkyNeyOUzBl9Cwp67wU1CKdwttlFzgmSA==
X-Received: by 2002:a17:902:396a:: with SMTP id e39-v6mr4062601plg.65.1541743668182;
        Thu, 08 Nov 2018 22:07:48 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id c70-v6sm6620722pfg.97.2018.11.08.22.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 22:07:47 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v7 03/17] of: overlay: add missing of_node_get() in __of_attach_node_sysfs
Date:   Thu,  8 Nov 2018 22:05:51 -0800
Message-Id: <1541743565-23163-4-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
References: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

There is a matching of_node_put() in __of_detach_node_sysfs()

Remove misleading comment from function header comment for
of_detach_node().

This patch may result in memory leaks from code that directly calls
the dynamic node add and delete functions directly instead of
using changesets.

This commit should result in powerpc systems that dynamically
allocate a node, then later deallocate the node to have a
memory leak when the node is deallocated.

The next commit will fix the leak.

Tested-by: Alan Tull <atull@kernel.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/dynamic.c | 3 ---
 drivers/of/kobj.c    | 4 +++-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 12c3f9a15e94..146681540487 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -272,9 +272,6 @@ void __of_detach_node(struct device_node *np)
 
 /**
  * of_detach_node() - "Unplug" a node from the device tree.
- *
- * The caller must hold a reference to the node.  The memory associated with
- * the node is not freed until its refcount goes to zero.
  */
 int of_detach_node(struct device_node *np)
 {
diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
index 7a0a18980b98..c72eef988041 100644
--- a/drivers/of/kobj.c
+++ b/drivers/of/kobj.c
@@ -133,6 +133,9 @@ int __of_attach_node_sysfs(struct device_node *np)
 	}
 	if (!name)
 		return -ENOMEM;
+
+	of_node_get(np);
+
 	rc = kobject_add(&np->kobj, parent, "%s", name);
 	kfree(name);
 	if (rc)
@@ -159,6 +162,5 @@ void __of_detach_node_sysfs(struct device_node *np)
 		kobject_del(&np->kobj);
 	}
 
-	/* finally remove the kobj_init ref */
 	of_node_put(np);
 }
-- 
Frank Rowand <frank.rowand@sony.com>

