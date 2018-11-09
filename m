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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F016C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051CA2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNWnZXcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051CA2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeKIPqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 10:46:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41680 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbeKIPqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 10:46:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id p16-v6so445478plr.8;
        Thu, 08 Nov 2018 22:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5upJeVS2/PUxAj2eWycRTvspVro5k0eON4BnhkKqWZI=;
        b=nNWnZXcz7MTRqI9xbo9WBu+JIvTnd0frUv9VxjoVm8JYjGGgoH+hOLUAVZnxogp8ve
         EKfvVl5mLVpQ2WmiatSONYLheJQfimzxocWGP01zvxGzlBy7wFwFDFBz7Y+nntSN4fWw
         9+GfRykPShjkbNALgOliIZ8HG7fSLw5vwMIej2PXGN0d6ss/WzbRMAgtisSxNZpjQmUP
         +AS8fVXrkZISjiQvzPnVq3tfFRZvjQYM6kX7uURdnOZrXVAMlRW+64Ar5+OB4deIncpv
         IJze0ezhZd/0G+fH2pRFWifhvTkRMeVYjpguoLNFlOA8jVJnWXonH4k87tJfSb2aLRzu
         pKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5upJeVS2/PUxAj2eWycRTvspVro5k0eON4BnhkKqWZI=;
        b=jCA8IdNjIVQJtcZQYGgSrfdv1nQU9SVgwYum9QfHMYtYxHAIPNj+2QRSpnYOzsdg/D
         oP3MqklLo7hVZItDHa0i4Zc84+ikyvnuXj82m3Yz6NTZun7vFreoeDSM9tH8JPLHGADD
         w3FUSN27SkedCEZ2AkL8eup/DEriKkBTwKaf3GOX6dpzkG8ueLqGZKeVixFlcErCIUmk
         O0stJUDfYlngBnW13ZD2F/+RdmAzF7H79MyVeuDu7lYUKbEWdUer/+cDvb29rV7y51yh
         FoHao1YH2uE7KSo9kT6T8LCFnBUlMN7PLcgUgtLcVEniHXQW+I01F2GWp645/tKCr8N2
         XX/g==
X-Gm-Message-State: AGRZ1gJp3H2dx52UvVKsGzkgPbjGGW7s9+ajv9ocE2H02B4xHSBCW1G6
        05yosF1J1SyixsY2lirEv/U=
X-Google-Smtp-Source: AJdET5ep2KpKfuV8xsZIARBeNmHh2BIe8kMCIer1BKdGaisJOAxj24UmDk6HmcCVkMlwdQjBOoQJiw==
X-Received: by 2002:a17:902:c01:: with SMTP id 1-v6mr7647154pls.15.1541743667013;
        Thu, 08 Nov 2018 22:07:47 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id c70-v6sm6620722pfg.97.2018.11.08.22.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 22:07:46 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v7 02/17] of: overlay: add missing of_node_put() after add new node to changeset
Date:   Thu,  8 Nov 2018 22:05:50 -0800
Message-Id: <1541743565-23163-3-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
References: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
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

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index f5fc8859a7ee..7613f7d680c7 100644
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

