Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E8AECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D452098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="taqEy43K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D452098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeJSGvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:51:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45686 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbeJSGvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:51:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id s3-v6so1642812pga.12;
        Thu, 18 Oct 2018 15:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UkGmi/9uJ2cCYbyUNwZsGr2ZdTjlRhMEjWVQ61ER+Cw=;
        b=taqEy43Kxhig/LXfGVWqTBnelE+49dshuohkZnlQdp3Qjip9G1jBeYbkAkQxQE345D
         ZWnI9hdFl7fFXx6XOjTL2zN05hRu/1x+wXFl10W8/nK2PAmQD9iqNNBpRcRQOqho7cmU
         wzyEvm2y5U2MobAaXQ2sctltsP9zH6+USVIrtwxUbtX+M1+gEADn9iRildNFjFuCEbVi
         5xQb8wnNKPlNsgelXgY8AgwPWFM7F8B8W4oCVqzdfc8eKfIuR0D407XmtQDceTlLFBB8
         XnBlDSrv+dAZNZkCpdL3CorPp6qeWpaRMMgxyksqL9EDOi+/+jH/Lp4baRJX9sAl1Wi+
         YOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UkGmi/9uJ2cCYbyUNwZsGr2ZdTjlRhMEjWVQ61ER+Cw=;
        b=EGtXF37BCnsR85X0VtBHv2JKap6HZHlTwQJX/KV9ofSYQu558cq5dLukqd8JVJ6jon
         sSIoWUpKKKUY6dYHKodQWECqTl/QXDqNQpJ/cWTYrVZZtCY+9UbL99PUI+/jJvbdSee8
         nciOzYJ9pm4/ZbgR/xc8rs1m/z7bqgsB57o/XNi1N2hlZXFUX111hwJJW5r79FcUWiOc
         LH4Bw3Tr+K4V1TGO+J/4cYNZdGpNT5RoQk1PYFHwA2MvPSThSZcO8GOn74KHi1sichEt
         +JNFrQxIWtBuOBdQXiVnPFHmwPiPMUJMLgEUMo1Xk7VICDLSpYSqHwBCVZvb5cEGFJ37
         PHOQ==
X-Gm-Message-State: ABuFfojuAwMrswVrO/0LVyTefxuPWLV8ic8kBzWRLRnwAvYgt3KoYnOu
        xOFIAcWR8kMmp0xwlg/NW3M=
X-Google-Smtp-Source: ACcGV60ZLNKzt1yoclqWHTuCOhkBSXlJ4phdE8lj8UWvA7DtMGvVDgAmSbswV9Beh+dA23ANl2h1RA==
X-Received: by 2002:a63:7c5e:: with SMTP id l30-v6mr29773428pgn.45.1539902887329;
        Thu, 18 Oct 2018 15:48:07 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id v81-v6sm38129268pfj.25.2018.10.18.15.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 15:48:06 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v5 02/18] of: overlay: add missing of_node_put() after add new node to changeset
Date:   Thu, 18 Oct 2018 15:46:20 -0700
Message-Id: <1539902796-8382-3-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

The refcount of a newly added overlay node decrements to one
(instead of zero) when the overlay changeset is destroyed.  This
change will cause the final decrement be to zero.

After applying this patch, new validation warnings will be
reported from the devicetree unittest during boot due to
a pre-existing devicetree bug.  The warnings will be similar to:

  OF: ERROR: memory leak before free overlay changeset,  /testcase-data/overlay-node/test-bus/test-unittest4

This pre-existing devicetree bug will also trigger a WARN_ONCE() from
refcount_sub_and_test_checked() when an overlay changeset is
destroyed without having first been applied.  This scenario occurs
when an error in the overlay is detected during the overlay changeset
creation:

  WARNING: CPU: 0 PID: 1 at lib/refcount.c:187 refcount_sub_and_test_checked+0xa8/0xbc
  refcount_t: underflow; use-after-free.

  (unwind_backtrace) from (show_stack+0x10/0x14)
  (show_stack) from (dump_stack+0x6c/0x8c)
  (dump_stack) from (__warn+0xdc/0x104)
  (__warn) from (warn_slowpath_fmt+0x44/0x6c)
  (warn_slowpath_fmt) from (refcount_sub_and_test_checked+0xa8/0xbc)
  (refcount_sub_and_test_checked) from (kobject_put+0x24/0x208)
  (kobject_put) from (of_changeset_destroy+0x2c/0xb4)
  (of_changeset_destroy) from (free_overlay_changeset+0x1c/0x9c)
  (free_overlay_changeset) from (of_overlay_remove+0x284/0x2cc)
  (of_overlay_remove) from (of_unittest_apply_revert_overlay_check.constprop.4+0xf8/0x1e8)
  (of_unittest_apply_revert_overlay_check.constprop.4) from (of_unittest_overlay+0x960/0xed8)
  (of_unittest_overlay) from (of_unittest+0x1cc4/0x2138)
  (of_unittest) from (do_one_initcall+0x4c/0x28c)
  (do_one_initcall) from (kernel_init_freeable+0x29c/0x378)
  (kernel_init_freeable) from (kernel_init+0x8/0x110)
  (kernel_init) from (ret_from_fork+0x14/0x2c)

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 1176cb4b6e4e..32cfee68f2e3 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -379,7 +379,9 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
 		if (ret)
 			return ret;
 
-		return build_changeset_next_level(ovcs, tchild, node);
+		ret = build_changeset_next_level(ovcs, tchild, node);
+		of_node_put(tchild);
+		return ret;
 	}
 
 	if (node->phandle && tchild->phandle)
-- 
Frank Rowand <frank.rowand@sony.com>

