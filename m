Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6A6C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD88D20866
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKvuIkbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD88D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeJSGw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:52:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42270 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeJSGvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:51:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id f26-v6so15541890pfn.9;
        Thu, 18 Oct 2018 15:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9C70m4ZYW6bahYInRPebhsLk8Qt5u47Y5Ga7mt8v3gU=;
        b=IKvuIkbTbm2ZsyB6wxfEV8nvYYPxaG8Q3MWtDjHRUQXn0w4mTsaTEV0nFKlpvxqEJM
         rtskc9wujBBC8WV9CRHZQusuuIUIbiMqIp5NzT+MGqGuGcNMKTcPVVrphzylade21Gfa
         J2dA65DcFYors6/9ZFr2bc6WuW9duBueUd7mAU4WnMzvjrpiPuf27m2mlXUTwZMqiVoc
         5ePRvOCmowx8I9dwPHiGiDDG5rTFdceTkF4a49QI7Kv2DWP4DyZ2JQ9QKttVOewkOh4a
         xH5i5DpRzxVpyl9RuXW0+xHw94U0cFM7u9sal+xnS1P5Kek8anhUdz6RPWf1S5yh6OnH
         lAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9C70m4ZYW6bahYInRPebhsLk8Qt5u47Y5Ga7mt8v3gU=;
        b=joEjDiypTWbzdvIh8GC020YzUG0cOS98SndYwyyLWtDsbPHzjxjJfHZSzMkvF8iPqJ
         w2eW00CyvObVA6w/VNsW7eIdsdgA481mLZE21VQjYYxnQXCI1cxlIFq0kC8xv2B/okat
         jyn0rCyR3mexrPSeZsqBGu7fnkWO0McXybigvRmXSCrJRUN2eqGI39UwW4Z5lPeLTgLv
         +wPs1tXb1v1bEZi3iAQvOvSKiqFr24PhidnqI2qvz8gh31/QcD+Vm2BdZWA4qy0ITrO8
         lJuUbB4LZ7IUdiEvrpOYwhZ3UmFgU4t04fl3VlycCBnnRbqs+vnCRwCoMpuCAYjYNnYm
         vqwA==
X-Gm-Message-State: ABuFfoh6y7w055mQNvOZWBUW3brlS67HSKRxUee95ff7r2aJhM5omtRr
        H5iyTrs8aUO8h2sD1t/xngA=
X-Google-Smtp-Source: ACcGV60DPgY00OK9dxZfMklbl8XGA1jMZMnVsKNtGEQeN9pASNM3SPnDAnDgiPhNchc+PUSFfrOeDA==
X-Received: by 2002:a63:5d55:: with SMTP id o21-v6mr29769769pgm.349.1539902888661;
        Thu, 18 Oct 2018 15:48:08 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id v81-v6sm38129268pfj.25.2018.10.18.15.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 15:48:08 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v5 03/18] of: overlay: add missing of_node_get() in __of_attach_node_sysfs
Date:   Thu, 18 Oct 2018 15:46:21 -0700
Message-Id: <1539902796-8382-4-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
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

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

This patch should result in powerpc systems that dynamically
allocate a node, then later deallocate the node to have a
memory leak when the node is deallocated.

The next patch in the series will fix the leak.

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

