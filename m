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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B8EC7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1E820876
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uzv6Yjjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1E820876
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeJOIIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 04:08:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37593 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeJOIIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 04:08:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id c10-v6so8302731pgq.4;
        Sun, 14 Oct 2018 17:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LkfoWFcm35ZeWsmFJr143DG24LEUdEKPjd4pwB8vYwk=;
        b=Uzv6YjjxexlLzpyU+vjvP21HgRYfNv92lYn/zG7KSH2fGoP3pgfyjAjHPzNdVF3LPg
         SNve7sEbcEVMTRbSGO+4c3Dmq8fR9CthPMJw9tFMUVzBo2d+JqcpJfMaT/TRyrNgvfN+
         CiPUaOHBdAPQAWhZsGI6XHFk6hhnVG6egN3bM7LS3r7pvPM9srLgW4HURs8AgrJsP+tO
         /6qTvoisEioyMFau2UAhuL4mTmZfJ9n1zDrKGiADiPT8y0c7khGZwWvZke44vh847DAF
         3gARD4Tl8o/no2EyXjTKUkJG953PpXqY7EUngcm08NTM36fMim5OWWskPrpPTBJbuQYy
         ACNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LkfoWFcm35ZeWsmFJr143DG24LEUdEKPjd4pwB8vYwk=;
        b=ChenuvCo8suufmXKb8Rq4ceXu5Jlf+GSwimKVqASr8hd7e65XQXA/ASYKzZpopTlb0
         2WZXooN1MxjdEx44GGQ6cFLiQ/Kcn1e31hToQiEqip9j/JIvkSHLwZ7WQRcR1Nbn/8ar
         Zh4lZp2QzxHG+e6aH8ffvwZXDcWnDR2tmH3HCVK48nrF52BgNT6Kbl0y5x0AY3roFGjS
         fDxJN0PU/XMmxGFuwacJz6NuvEGOw0oOuSREURPd0edF3A2lYBesH6nvbDypjWoIRioP
         l7ZRPXBIlphXZuQZ2gRClYHbIgKIklDYnMmjvcvqH5O5b6ECAECpZkHyu/OTGz43KVZO
         uD4g==
X-Gm-Message-State: ABuFfohWO9j50VVPAZL1BS3WevWoFPCTcQts9UaYeNwEantmQjE6nhbd
        7RG2s/ktidJnL0lsFMS18co=
X-Google-Smtp-Source: ACcGV63OIkeAqDgCl/OdYrs584MihorD9M9bqZZ8Kbp8SsSc4pi9nWKmqCOzvVGHS/DHhbEg0pz5vw==
X-Received: by 2002:a65:664e:: with SMTP id z14-v6mr13542613pgv.347.1539563163410;
        Sun, 14 Oct 2018 17:26:03 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id j14-v6sm11387110pgh.52.2018.10.14.17.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Oct 2018 17:26:02 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v3 03/18] of: overlay: add missing of_node_get() in __of_attach_node_sysfs
Date:   Sun, 14 Oct 2018 17:24:15 -0700
Message-Id: <1539563070-12969-4-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
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
 drivers/of/dynamic.c | 3 ---
 drivers/of/kobj.c    | 4 +++-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index b04ee021a891..275c0d7e2268 100644
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

