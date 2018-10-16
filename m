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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916FBC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5776F208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfCb+n7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5776F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeJPK1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:27:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33657 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeJPK1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:27:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id y18-v6so10094709pge.0;
        Mon, 15 Oct 2018 19:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6jwtNAKUA0bImQ+OzjBieSYaakSLUGtiTllRPSG9WlA=;
        b=PfCb+n7SPWybcVF+ENhWNNQeAbHWxVp087paajc+P1UcxIsL61AfFbqKZM4/DCZ8Wg
         pcXNv9h/+ZwiuJg19t/alKps71XwafwL73++Ow1sDcb5wDb7/8j0mjd//KTaQFhm7Qfa
         By/pXBWPPIg3tX1irLch02z+VoxagT/vIvSCl0a3Gl6HVk1MqA69glokpvt142LJk9nC
         etFpdLy37aJWqy4mX9OBUTlFjQ2doXsHkVqjaftykg5BTYQP4CmjFiEbUGHNZSYCGEav
         kf0136rNDXgf6Tbusj2xY/Sh9JPhyYMkkcy7XdP4vIf47orpIS+NXXbcV8lNgTOUZoIp
         K2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6jwtNAKUA0bImQ+OzjBieSYaakSLUGtiTllRPSG9WlA=;
        b=bGy3b1f8bPghPtaSrC34p6M/ef75x5ZxKxg7if7tV+MV/ap42SAJ6nb0r7wvGNA43q
         I4PQkt4evd1CQGJQv2eNn1zS1SHEO5J0W72iGVWPk/neSaNS2Y55p93xFgDe9sUh5URs
         jCCeUohnX2BsKVbHIYeYKLEbkS2rRgDU8wHodU2DWn+vBhKJJnIfQOhoIIc94aP8xW9P
         CxPQ8ER2Fx3KDQInVi0MorpKpCb8mX20iSaI9z/GsIugMYyN/N82yLe0jGC1f+uGAt4f
         +78bYIl5/i5ySGGbI4vwo3+lbbSbAlH9CxmyvSJDQFBIxZzaeM9rrFpTVewF6znjzjxT
         7z/Q==
X-Gm-Message-State: ABuFfog7etPa6a+BUMTLpOzgB7G3L9B1L1SqF2IDvsazWzELjDF5Vy+7
        cUVX+/xxCAgtoGs6PqL9bNI=
X-Google-Smtp-Source: ACcGV60a93Uk9Vf9y1ELaanVjQ0ckmAPo3W6mw6/cN+T00j9hArFUmjSH2qR7XY3dPjW1EGopBzEPg==
X-Received: by 2002:a62:fc13:: with SMTP id e19-v6mr20352542pfh.101.1539657553847;
        Mon, 15 Oct 2018 19:39:13 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u79-v6sm18620287pfd.117.2018.10.15.19.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Oct 2018 19:39:13 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v4 02/18] of: overlay: add missing of_node_put() after add new node to changeset
Date:   Mon, 15 Oct 2018 19:37:22 -0700
Message-Id: <1539657458-24401-3-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
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

