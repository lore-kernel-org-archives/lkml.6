Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF21C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A85721746
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KprIHeMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A85721746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeH0MIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:08:14 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43955 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbeH0MIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:08:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id m84-v6so11587505lje.10;
        Mon, 27 Aug 2018 01:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h2/k3apiCocm0wblFIPa3bgtEpVthP9qn7ODBdhWFdY=;
        b=KprIHeMQlLn91wZwsnMQIKblLR9KBX36ZiDo1ChO29XTQmoljzLys4LKoHYEqmmbmz
         cTWkXaWlSKdC64NlBzYd5JpGWvCUpGsZfs9/igvEccsfjC2PuYZYLvpScD/SLBTmykqW
         RxRyIa7Fu8DYWslKxniWyatJ03kfBUv19kqRNwUR4boBwzAVlBP6LAAncJUJ0Dj7HNkX
         jThMfHz7A8LWi4lhhp2PiRvJsKP7FjOH2ikMXFovKHsc3LbO7JT7ZySPo4A3O7vbI5NW
         dH0PNOIz40eRi2P7BaDERRGRKUGOPL/yj56I8nJS6WS3cKnFGkJ+VcWgLnU6TYT75+uf
         vl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=h2/k3apiCocm0wblFIPa3bgtEpVthP9qn7ODBdhWFdY=;
        b=AkBvBzQjOQDlZkUW0BRQSBaV+U9PedA9R0aJFrj5sAZaHyTAz8mdyC9pXf7Hr/F/JA
         Q4TLaoazvYeWoQbCAjqG9BPThsO3QHCEXQJzTdUWT0LPI/hnndb2MACMeX/NW7LZDsqB
         alSFmh9hti5e9CWCqNoa3rq6CRmAhtbSGTObRsybMn/EMzhGAM5ZCcs+kbk2kZJVs2CC
         99z5PEFaS7Xb+uC5K5DJC+GOj/p/x/Slm42elzu7/B1RVQeoHcU+aLLDPrBK9ndbR0dg
         kpNgo2NHevTfk8RjZvSk896Zx33rTnw57LyxFQ/TTWdWaf2ygwA+7SgXmlsz6WAnEEX7
         Kgyw==
X-Gm-Message-State: APzg51BKJY/TVSRiXTAuEiJKaEqEhaU5m84x365xnpATH/vUgTev4pm2
        gBY4CDZ5W+CjksSzlCbIfH4UpSql
X-Google-Smtp-Source: ANB0VdavjcXw5BLwbQoWaUGdue4EdsJmQ8QWPBMBM5hwuGq6XiUxdlk+L+1t6c88RlfiZPTHlFU6EA==
X-Received: by 2002:a2e:8652:: with SMTP id i18-v6mr8287060ljj.43.1535358154923;
        Mon, 27 Aug 2018 01:22:34 -0700 (PDT)
Received: from xi.terra ([85.230.190.116])
        by smtp.gmail.com with ESMTPSA id x3-v6sm2640352ljb.25.2018.08.27.01.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 01:22:31 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fuCn6-0005sS-KO; Mon, 27 Aug 2018 10:22:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 1/9] of: add helper to lookup compatible child node
Date:   Mon, 27 Aug 2018 10:21:45 +0200
Message-Id: <20180827082153.22537-2-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827082153.22537-1-johan@kernel.org>
References: <20180827082153.22537-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add of_get_compatible_child() helper that can be used to lookup
compatible child nodes.

Several drivers currently use of_find_compatible_node() to lookup child
nodes while failing to notice that the of_find_ functions search the
entire tree depth-first (from a given start node) and therefore can
match unrelated nodes. The fact that these functions also drop a
reference to the node they start searching from (e.g. the parent node)
is typically also overlooked, something which can lead to use-after-free
bugs.

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
index 4d25e4f952d9..b99a1a8c2952 100644
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
 
+static inline struct device_node *of_get_compatible_child(const struct device_node *parent,
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

