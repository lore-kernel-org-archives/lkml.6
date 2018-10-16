Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A01DC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61816208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msottjjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61816208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeJPK1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:27:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38113 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeJPK1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:27:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id f29-v6so10657629pff.5;
        Mon, 15 Oct 2018 19:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NBR84y3mbc7GWOaSoRjimr7kNqkK04efsf5Z6wzYUy8=;
        b=msottjjT7t57byr3yNiOwhXhMihvPQXQigcvhD5f5pbFKd/ThIFvO8wHGibRyVHpRL
         Ub5ey294l0Pr4x3AV2gBbzJcMxky3UEdVbfQ2dcPwEMUS+fSuIiqyYEcSJtLdNxz+h4l
         H+mkwxYhtvAVvzrrc7fgzJj8ONhLwA+gbBEltr1BdtFbY1m51zbnw1sXTLEqNWjvTQTI
         fKgiGnrp01wg+cYHx3LuVuLrYy3R6jtGS4fonenuSzvXd3H5Ts5LIrv9TH5eELD0Lwlp
         NUvLm/OpUGQis62W0stkC3RS26QwXJf5caSTUCqX1bWBVph/VhekQTMy8t3V7nA+EEg8
         ypwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NBR84y3mbc7GWOaSoRjimr7kNqkK04efsf5Z6wzYUy8=;
        b=jp+NNpcAVrKMlxfU+tzGr9mDhxhim4N7bFlzaC7ceF+auzN/377sg45YJ7a1fgQ3uJ
         l+u644h2I7+BpXy+wuNpJHy36w+J49+9ZdWxpodkNq7D3cAoVLtUH1yDg4c1MkPGPZq9
         C1DkkCx9fmkumQJaNMUGw8pW98+ARNEfRAAKBJYhlYPSuMB6nmTX5sWDTXJ8PJMp1fLw
         W5+G1ddS0X60eYw/BWS3EeYcJ9OyHhs8ITTc00uMB87KakOaeAPHIJTvLMY3cDVgHztd
         8CSn251J29BJt7Azhazi6Cxv9mkRCKDnph3TpeZuymxQoDb8e+3mjfQWVrNi23zr1gvj
         KX7g==
X-Gm-Message-State: ABuFfoj7jTIgHEIhSWrfgUXPDV6BeHRxTvd0z1DX8SXS7Yd+PJKOG5Y4
        AjKo9TfnOlMPysKllRZ8xx0=
X-Google-Smtp-Source: ACcGV63OmN7WqcG9CbRZcHfri79HYMduxEyb95IIxSnJQLDhYJ3RfxSaOJnquiDr6rz5Ik9c5EcugQ==
X-Received: by 2002:a63:d64b:: with SMTP id d11-v6mr18251971pgj.450.1539657555084;
        Mon, 15 Oct 2018 19:39:15 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u79-v6sm18620287pfd.117.2018.10.15.19.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Oct 2018 19:39:14 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v4 03/18] of: overlay: add missing of_node_get() in __of_attach_node_sysfs
Date:   Mon, 15 Oct 2018 19:37:23 -0700
Message-Id: <1539657458-24401-4-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
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
index 24c97b7a050f..fe8816cca99b 100644
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

