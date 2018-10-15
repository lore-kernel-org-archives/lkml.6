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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC324C070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F0820652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYiaTm9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F0820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbeJOIIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 04:08:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41205 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeJOIIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 04:08:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id 23-v6so8291709pgc.8;
        Sun, 14 Oct 2018 17:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6jwtNAKUA0bImQ+OzjBieSYaakSLUGtiTllRPSG9WlA=;
        b=BYiaTm9Mf5LbmJ5N7U+2g/I5x34CyW/qXhGU63isvMPHa6v43UylPoMGsYp3Z28jOz
         PYl5YjbMrZh78LkYxRr1kl4g21hr8YYZFqItJd5+jRjK1t6EDvTHyYV4jVynBXLzMCVQ
         fNf4iZNRFm99eDsj0tG5Fyel5nMXIg4kMWb3YZCQqkng88TWZ/+xNhnO2LLqx9t1ZeLr
         TjHvAtDUvBS3/FLNmdL8Y5UEQ/BbLMUVdQaOMVG1dzGKne6C8HK7QDmmCyvndFMTkj9X
         53edHuD/QwJKftiemwVxdbbOxN/aLHX3a3CQwba9tbAxDF0YSibVK8wJRZsKHI7R+T+O
         eOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6jwtNAKUA0bImQ+OzjBieSYaakSLUGtiTllRPSG9WlA=;
        b=NPbMCVD2cuQnY8EwwkdvoG4KvxkmXPTZ/qDjvAXooYHZad0y/uP8DOKZrtTOJG91cI
         ea4A3ywKGikvEJh6JoG4xW/cyZYG+me49wysK9gP+R5JAin3ifP20otTmrBLL7l31ISU
         5HfyATLb6dOTV8o/MQgX3gsOtRBxZe7O1IN6RhAgj1+DvD7wKOurBrC3LvDMxm5NqdRs
         wXLBKRiJEkxMoS910jipIAzc2RZXjv2UpOs2P193BG1lI3wkIP4bFpisKvxNSKUnJQnP
         uahFPszNxXWCRKpl1T/qhRCO6Z0egqshua1us5iPkm+iTkTKZ+7crqhsVNGalvziN3bW
         E6yA==
X-Gm-Message-State: ABuFfohJJQuZUpv1V8wKlz5B3FGy4znDdfTTA1tcmhHVx8AHYDpkIAIX
        oi7gIECgHsvF8KGaOfD8VCk=
X-Google-Smtp-Source: ACcGV61bTCYF5x9UYhIzNsm/Qtb2Zv3fJBPszdApXHSBQp/9PoPVwi16dtocxt2lVI3BWXDsCZMkxg==
X-Received: by 2002:a62:564e:: with SMTP id k75-v6mr15351308pfb.33.1539563162140;
        Sun, 14 Oct 2018 17:26:02 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id j14-v6sm11387110pgh.52.2018.10.14.17.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Oct 2018 17:26:01 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v3 02/18] of: overlay: add missing of_node_put() after add new node to changeset
Date:   Sun, 14 Oct 2018 17:24:14 -0700
Message-Id: <1539563070-12969-3-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
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

  OF: ERROR: memory leak of_node_release() overlay node /testcase-data/overlay-node/test-bus/test-unittest4 before free overlay changeset

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

