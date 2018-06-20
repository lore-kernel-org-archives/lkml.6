Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BB1C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582222083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKGWxFzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582222083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932552AbeFTRXB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:23:01 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34204 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932241AbeFTRW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:22:56 -0400
Received: by mail-lf0-f65.google.com with SMTP id e13-v6so503311lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AMylSCkbzgDhVGAqXW5br7EGPsh0M0aMkU36t/fhU+E=;
        b=SKGWxFzGSktnyD6kaX9ouo+P/jXcqpXVh7WmiipKR4mu8eL4DLn1dlzEuJ1UVq8Isf
         nHglT92pBOG4HoKUm0EsljQ8CMQHU/y/4uqGOUybUW/3pWPBLcIG8lCYhELSWFIusRTq
         VjDEfxFljyJQu7hsl5Egey8JJ52Ttelgdra2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AMylSCkbzgDhVGAqXW5br7EGPsh0M0aMkU36t/fhU+E=;
        b=MeMSMAcsfUy+C4S6nU+YdjfD9tcJpP+CByxZeWfTgT3VTqNd4GUx3NK29X7MAOwrL6
         nZukvh1h62ceDuBX4P9deosoWSW9o35UGkPdv/0QmybR0dfzhlxvUVrFC00fySu7mfwd
         S+NXPbqYhzyN7AUxnfWpZiiCBUgiJOcrPCfLtcQgxXxBJrzaJXbKX9Rapdww6UQ+hUcH
         xWFc0H4Yw0c8EnoF7woSvOPkXGX+a8LfUVlLlH+XNrvl87iWKFuY2jBB4AtX9Qz6feDb
         zn+4rraFBGR7u99NuN0GfOeeKKzVSmL78Oa/hbrtE+BmHwVdJQlMOxOWZhpRjNYqtU7h
         okiQ==
X-Gm-Message-State: APt69E23c85xof1p8dWEhEjktlRNZn7tmvrhbaoLpZ5syHlJ/oboTzv6
        pDlG9Gg7JzTnMyq/32WLdWSTOw==
X-Google-Smtp-Source: ADUXVKKw7oTkqAeuPRf8L9aMhza1orF6pS8GahQhO/Ol4QGWHx/duUSlOEM0HX43isb6GIHcjbqMPQ==
X-Received: by 2002:a2e:870d:: with SMTP id m13-v6mr14276282lji.139.1529515374905;
        Wed, 20 Jun 2018 10:22:54 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b2-v6sm514441lji.85.2018.06.20.10.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:22:54 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v8 11/26] of: base: Add of_get_cpu_state_node() to get idle states for a CPU node
Date:   Wed, 20 Jun 2018 19:22:11 +0200
Message-Id: <20180620172226.15012-12-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU's idle state nodes are currently parsed at the common cpuidle DT
library, but also when initializing back-end data for the arch specific CPU
operations, as in the PSCI driver case.

To avoid open-coding, let's introduce of_get_cpu_state_node(), which takes
the device node for the CPU and the index to the requested idle state node,
as in-parameters. In case a corresponding idle state node is found, it
returns the node with the refcount incremented for it, else it returns
NULL.

Moreover, for ARM, there are two generic methods, to describe the CPU's
idle states, either via the flattened description through the
"cpu-idle-states" binding [1] or via the hierarchical layout, using the
"power-domains" and the "domain-idle-states" bindings [2]. Hence, let's
take both options into account.

[1]
Documentation/devicetree/bindings/arm/idle-states.txt
[2]
Documentation/devicetree/bindings/arm/psci.txt

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Lina Iyer <ilina@codeaurora.org>
Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/of/base.c  | 35 +++++++++++++++++++++++++++++++++++
 include/linux/of.h |  8 ++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 848f549164cd..97350cce1b8e 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -399,6 +399,41 @@ int of_cpu_node_to_id(struct device_node *cpu_node)
 }
 EXPORT_SYMBOL(of_cpu_node_to_id);
 
+/**
+ * of_get_cpu_state_node - Get CPU's idle state node at the given index
+ *
+ * @cpu_node: The device node for the CPU
+ * @index: The index in the list of the idle states
+ *
+ * Two generic methods can be used to describe a CPU's idle states, either via
+ * a flattened description through the "cpu-idle-states" binding or via the
+ * hierarchical layout, using the "power-domains" and the "domain-idle-states"
+ * bindings. This function check for both and returns the idle state node for
+ * the requested index.
+ *
+ * In case and idle state node is found at index, the refcount incremented for
+ * it, so call of_node_put() on it when done. Returns NULL if not found.
+ */
+struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
+					  int index)
+{
+	struct of_phandle_args args;
+	int err;
+
+	err = of_parse_phandle_with_args(cpu_node, "power-domains",
+					"#power-domain-cells", 0, &args);
+	if (!err) {
+		struct device_node *state_node =
+			of_parse_phandle(args.np, "domain-idle-states", index);
+
+		of_node_put(args.np);
+		return state_node;
+	}
+
+	return of_parse_phandle(cpu_node, "cpu-idle-states", index);
+}
+EXPORT_SYMBOL(of_get_cpu_state_node);
+
 /**
  * __of_device_is_compatible() - Check if the node matches given constraints
  * @device: pointer to node
diff --git a/include/linux/of.h b/include/linux/of.h
index 4d25e4f952d9..15072b10ef4d 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -348,6 +348,8 @@ extern const void *of_get_property(const struct device_node *node,
 				const char *name,
 				int *lenp);
 extern struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
+extern struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
+						 int index);
 #define for_each_property_of_node(dn, pp) \
 	for (pp = dn->properties; pp != NULL; pp = pp->next)
 
@@ -733,6 +735,12 @@ static inline struct device_node *of_get_cpu_node(int cpu,
 	return NULL;
 }
 
+static inline struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
+					int index)
+{
+	return NULL;
+}
+
 static inline int of_n_addr_cells(struct device_node *np)
 {
 	return 0;
-- 
2.17.1

