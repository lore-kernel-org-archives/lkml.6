Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1747BC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3D1218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyEYtwD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfAXXW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 18:22:57 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36669 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbfAXXWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 18:22:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so3361096pgm.3;
        Thu, 24 Jan 2019 15:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TLgfw4fM0l9uLmrBE6pG8oaLgGh5MrQeTKy2hkTuZOg=;
        b=OyEYtwD1zmDOYTnAdZBox1bzlHrxnJi0nRzcZ6EelT8HU8UXip2GBts9n0CBh2I6gS
         9hgr+YOwsrFmfoUljCgcPCjBhrGNP/9w4cSNAuE2Uc4y9yAORzwfN+8DhiYGOGWvO061
         h2CcUUYJypzz3kY0XrAlbT+1wKUS4t3t2L7DDlQfZ4ioqdOPP1rtVwl4qhoHpueRT3ps
         4J1K/7o7ZQo0hVyBF/uHJcUDNRyOSrCRWzEwf+D0dOA2HAIabe77myIHS7Oph+q65teY
         iuU+sfNM9qIRcnUw7iQ9ho5WF9hIwQLStedqBqA1gU1qY4Y+oTt94XDT92FalbQJNLHR
         qyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TLgfw4fM0l9uLmrBE6pG8oaLgGh5MrQeTKy2hkTuZOg=;
        b=XhJvTZTlCR+VgiscEG58tNi0x4Vdmj+I0YgLp/eXYCahnTucZGd+RRBgEHGJ4ez030
         jTT3CEnHDok/1Ql/2qjIhwHkjw1bzg5VBwd1eokMVWTlR+I71PM0YNCKw9qUDECVudp/
         wZ7SJnyWmfL+zx8IWWwJShELmK1ZWsjFHyXpQU9TzuVov/AFbTgMshVLhMY7FFel9mJR
         +yu9sMZA/PnNC4bzrh9/vrcwnLLZmzOwWJT7sWUbKDZLYQAWgR6oy/zPh/+c9oshgxFO
         ttWj09RS0y5eo4F0eRw81BzxJtEx0YkNijrxEkKpQ6zi1fMvc2PxGyE26bpU/dJJC0IM
         qwyg==
X-Gm-Message-State: AJcUukfBcEjGpR665NGc2xJx9CgJAWK5JpewObK1GgQ98SLVKRBOqN5V
        J5JN81G+q1UyTdvZmS1awNY=
X-Google-Smtp-Source: ALg8bN5cmtjMLTdp+Zg9sK99DRmttQJcXKAQ4qkaBbHBC9X0LOkL61c5hqaYWoDZA9//jTgt7xZS0g==
X-Received: by 2002:a63:d604:: with SMTP id q4mr7715203pgg.175.1548372173787;
        Thu, 24 Jan 2019 15:22:53 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id g15sm95216217pfj.131.2019.01.24.15.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 15:22:53 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] of: unittest: add caution to function header comment
Date:   Thu, 24 Jan 2019 15:22:14 -0800
Message-Id: <1548372134-15729-3-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548372134-15729-1-git-send-email-frowand.list@gmail.com>
References: <1548372134-15729-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Name of function attach_node_and_children() is misleading because
if the node already exists in the livetree then only the node's
properties are attached.  This works for the existing test data,
but add comment warning of this misleading name.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 3249fe259d30..872956500c27 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1127,7 +1127,11 @@ static void update_node_properties(struct device_node *np,
 
 /**
  *	attach_node_and_children - attaches nodes
- *	and its children to live tree
+ *	and its children to live tree.
+ *	CAUTION: misleading function name - if node @np already exists in
+ *	the live tree then children of @np are *not* attached to the live
+ *	tree.  This works for the current test devicetree nodes because such
+ *	nodes do not have child nodes.
  *
  *	@np:	Node to attach to live tree
  */
-- 
Frank Rowand <frank.rowand@sony.com>

