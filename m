Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5299FC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1099D208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCBx9lrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1099D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeJELLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 07:11:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40001 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeJELLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 07:11:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id n31-v6so4129597pgm.7;
        Thu, 04 Oct 2018 21:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6jwtNAKUA0bImQ+OzjBieSYaakSLUGtiTllRPSG9WlA=;
        b=MCBx9lrMtMdsz9cEW+CMd3QgO3hI+ZEPnUcsSEe7WFZdG+UobXlVKJOVX7ZGbYEIMT
         oa2rVq+Lo7V7wvGwBLZK/kdv+DC6yFUwC8QyN3E39GUtBX7bGj+itjAa8Dz41mTpTNOQ
         hy9O90b/jXdseEi+/FDQihD+OxzBjv6aAmt4MK12eclhqdEF1ZU+I2F0eU/GBHPzjjW9
         zePCXjN7k2pxIYTz7N1y7CYw+BMWw3SYM3kDXV+Kf5OiWBkM62kY2T+61Qy1Hv6DvJEr
         8aiC/7e4LHCg8b+r1VPawJzQTcU5mUfAdZHHfGM967yjFrOsQSpAJttv+nXyEmdAaj/z
         2/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6jwtNAKUA0bImQ+OzjBieSYaakSLUGtiTllRPSG9WlA=;
        b=aiMfHynKZofFPRXoiZGDiAfERK71hkY8gvx8iW+qegSZ4nwzdKHFoY7uQp+Ym9aOj+
         hBHkUG5pHRbG46hp5i8PUFjGqFoJduze8or5Ne0RQEzoNu1C/vLL0QBFhLH2j6fpebbr
         BcHFqM0bImCHjBF7O5aSWgW5bL9fPQVtFl1UHP8Ej3lMqv1B97g9p4BBOPnexYHvjNDl
         Wx6M3h0qVjtM8j5mfn2vKfilBtoU7efDxSroadnxR2etIim2ykkyCYmdX06y0WIX6ae2
         gLCO58uALQ4faANe3cRb916VBCrMn4BkLrOGCJQZcEeMnoQq7XKwddcvYhSQ0axk3jSm
         2Sag==
X-Gm-Message-State: ABuFfojtQEl9qXiFmMiOr9AmLi2OFw1k7SEV34k6OqoKFG/OmZI085rq
        m+hUEGvnl8+p+KpPE+9T+Nk=
X-Google-Smtp-Source: ACcGV63m5HexPKfKLuGqqO0tFRNmbENYi3UjC/7hSN83HFe9jfdxDst5U1GMAGI6elYY4PSnNHIOKQ==
X-Received: by 2002:a65:41c6:: with SMTP id b6-v6mr8617935pgq.421.1538712854589;
        Thu, 04 Oct 2018 21:14:14 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id n63-v6sm277975pfn.9.2018.10.04.21.14.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Oct 2018 21:14:14 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH 02/16] of: overlay: add missing of_node_put() after add new node to changeset
Date:   Thu,  4 Oct 2018 21:12:33 -0700
Message-Id: <1538712767-30394-3-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
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

