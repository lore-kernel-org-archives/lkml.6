Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BDAC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAB620875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWijAGp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CAB620875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeJELMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 07:12:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36152 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbeJELLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 07:11:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id y11-v6so3043030plt.3;
        Thu, 04 Oct 2018 21:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XMDnNdUW/sDd17o9F9TmJbiIxv65t1vRquMBQw128TM=;
        b=FWijAGp6UNxBHqBzov0/qbX2B/wvdSAZrUN0u/24mwyFoVqvS6E3w6ECjRtCldkNBx
         VjfCXEhuUL1ZYRfX3vFKR8KCpcNATiZE6tj7BsK3/jm651cYEMLN2zAHwDFRr9fUPTC7
         VfcX6rMEktI6fjjqQniXGoGydN5ZmGb1xZVW2h4ymbrsoihJrBjoCsnEtFvd7mA+/D6M
         YhiVjmS9NmjLYTo70iEkEMUTbt5/ojx/Y7r3L0I4lufS9WA0SIdb6ox/fEIlzq8VhaAx
         F1YTJpxZNpQ9zb2bjIueeZmARE3uf91XicaLRsXJ5xoBdCt7gsmyiVqrvRw4/RZb7e+M
         vQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XMDnNdUW/sDd17o9F9TmJbiIxv65t1vRquMBQw128TM=;
        b=nqOeIT10068XUTajtzj2sz9s7pOsFxeYnTYE+ekEwJgUpPUAF2OhZpVGor5zvjrbLW
         fxfC+qmoubehvozpIY05m2J/Lz92ykqwGJWL16YCO5NOoJb2TB2W6x2iZ2SEwf8ydP6j
         2FgulFPZzmt90CVwBY5sC1/9QAuFmC4G/BjGO2BbQ9CJzWJeCUCcZe+7FdUlqpVFPS72
         +PsU7eln5CVUaDMEm6QPebEtmblkYRaXq/JB8cfNz6xpKJWBE41T6KF9114BE8rENtI2
         UD+JB/q+qToiVNNRt01mkfQMARZr56DD0KtHMoqMhRtwyZXxis+Vj3gVWSi4dyYuS+Ww
         lhjA==
X-Gm-Message-State: ABuFfoikzaU1Az+lh8vEYRxfxpAKkD6v25wbzTwFIYUvy5cSjmUVIl0C
        ACm/14azLxCW1AjpzMY44OM=
X-Google-Smtp-Source: ACcGV62FRy9PwqCLrqEV60+HHZ3O1e1z0Ny95+n/XrtRw1XEZSWFfXnts+GaZzMFvQ4CWZaGDvB2eQ==
X-Received: by 2002:a17:902:9893:: with SMTP id s19-v6mr9579926plp.130.1538712855820;
        Thu, 04 Oct 2018 21:14:15 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id n63-v6sm277975pfn.9.2018.10.04.21.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Oct 2018 21:14:15 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH 03/16] of: overlay: add missing of_node_get() in __of_attach_node_sysfs
Date:   Thu,  4 Oct 2018 21:12:34 -0700
Message-Id: <1538712767-30394-4-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
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

