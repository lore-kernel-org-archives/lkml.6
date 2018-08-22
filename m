Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD228C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964CA214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOJIOE8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964CA214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbeHVOVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:21:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36392 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbeHVOVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:21:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id c21-v6so1079526lfh.3;
        Wed, 22 Aug 2018 03:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Etjd7jj25Pq7eRsFuvb4wwkfevjQHEK8hEcguIvg/IY=;
        b=LOJIOE8CrsZZWUUh/wGyWOHbkW8xhdoNcvpsWIfdZ2GdHnp7VgLWjCXnaIaeGUm1so
         n/cDR9rookFmBXIfQoS4SvLSsO8G8wNYQkuoGBe+p7mvok628Xck+M4UvtQ3sbKonEac
         fbWLBcS34BI6/Ygfok2+AfPHHZnmg3pzTAhEBCgQyKyqV2IZdEorB6HTCTcq8LDKwxxB
         vyxhNvJNAujxK1GcX7Gkw+3GEl0DMoZQYWwMws8g78gSGz9KcPU2/hfJxbfgTRVzHolL
         CXCTev1tGzlQijohJOk/bWtUvC8LjIJMR+4fMm4LLJRHiknhojpvgNYGQAGasUBWz1DF
         LtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Etjd7jj25Pq7eRsFuvb4wwkfevjQHEK8hEcguIvg/IY=;
        b=uOckfum3SlJlU2Ypxqv+5mniKnNWKoLVciHMtnTncb8t1Zy9b7lwTZl0x6Mbzf/kAy
         BVxJEroP9p4oD8ZbqSdY2GcxhYkFQ1Rx6S6/Es2fhW2WLCSeXJqYHROmAABRdx/hfFMQ
         QM8KTfK6biLxsipoasq/F3Ftx3Vpex2X4n3x/fgX/j/9eHSc+k/3V9Bbv6qfuod3hC7Z
         0MHJ08bpg3vOu84OunvHJBR+R5hcz2KK3P18mUa8JamE2/mua61fCQSBRJLC22VqugYL
         bJLjkB67SdhgGCfasbqK1FVCOZFo66pR/VCtOdqfflVCyo55LJEDSmJWZAI3NBJcikUR
         wAtw==
X-Gm-Message-State: APzg51BbBb8xuWGOdYShNpYUIwNxJdGglOkYvld5TsRXSi03autMx3hd
        R8HVdZQdSRFpZeMG0Jxax0Y=
X-Google-Smtp-Source: ANB0Vdb4nqo8P6sW8SchmofHZK9oufDvvxv6o5iFkNXypzOYEOUbVuRPWAA+TEgGlE4XlW7NK7QmCg==
X-Received: by 2002:a19:9a46:: with SMTP id c67-v6mr4149368lfe.117.1534935437488;
        Wed, 22 Aug 2018 03:57:17 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id s82-v6sm259237lfk.73.2018.08.22.03.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 03:57:16 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fsQpC-0002XD-Kh; Wed, 22 Aug 2018 12:57:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/9] of: add helper to lookup compatible child node
Date:   Wed, 22 Aug 2018 12:55:39 +0200
Message-Id: <20180822105547.9634-2-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180822105547.9634-1-johan@kernel.org>
References: <20180822105547.9634-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add of_get_compatible_child() helper that can be used to lookup
compatible child nodes.

Several drivers currently use of_find_compatible_node() to lookup child
nodes while failing to notice that the of_find_ functions search the
entire tree depth-first and therefore can match unrelated (non-child)
nodes. The fact that these functions also drop a reference to the node
they start searching from (e.g. the parent node) is typically also
overlooked, something which can lead to use-after-free bugs.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/of/base.c  | 25 +++++++++++++++++++++++++
 include/linux/of.h |  8 ++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 466e3c8582f0..bc420d2aa5f5 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -719,6 +719,31 @@ struct device_node *of_get_next_available_child(const struct device_node *node,
 }
 EXPORT_SYMBOL(of_get_next_available_child);
 
+/**
+ * of_get_compatible_child - Find compatible child node
+ * @parent:	parent node
+ * @compatible:	compatible string
+ *
+ * Lookup child node whose compatible property contains the given compatible
+ * string.
+ *
+ * Returns a node pointer with refcount incremented, use of_node_put() on it
+ * when done; or NULL if not found.
+ */
+struct device_node *of_get_compatible_child(const struct device_node *parent,
+				const char *compatible)
+{
+	struct device_node *child;
+
+	for_each_child_of_node(parent, child) {
+		if (of_device_is_compatible(child, compatible))
+			break;
+	}
+
+	return child;
+}
+EXPORT_SYMBOL(of_get_compatible_child);
+
 /**
  *	of_get_child_by_name - Find the child node by name for a given parent
  *	@node:	parent node
diff --git a/include/linux/of.h b/include/linux/of.h
index 4d25e4f952d9..c22982fc1bff 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -290,6 +290,8 @@ extern struct device_node *of_get_next_child(const struct device_node *node,
 extern struct device_node *of_get_next_available_child(
 	const struct device_node *node, struct device_node *prev);
 
+extern struct device_node *of_get_compatible_child(const struct device_node *parent,
+					const char *compatible);
 extern struct device_node *of_get_child_by_name(const struct device_node *node,
 					const char *name);
 
@@ -632,6 +634,12 @@ static inline bool of_have_populated_dt(void)
 	return false;
 }
 
+static struct device_node *of_get_compatible_child(const struct device_node *parent,
+					const char *compatible)
+{
+	return NULL;
+}
+
 static inline struct device_node *of_get_child_by_name(
 					const struct device_node *node,
 					const char *name)
-- 
2.18.0

