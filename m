Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AB8JxZob4V9e34pDEStByTtNtoFwLP4A6cqRtQRp1vx144HLOdqAd+o79ZMwGCS7WuvmVq/p9c1s
ARC-Seal: i=1; a=rsa-sha256; t=1526083145; cv=none;
        d=google.com; s=arc-20160816;
        b=S60QfZX0++uipU/iEiORat2eiS0p4tqWKMmINSRy4GUttbt6THtuFiEbZ6Rfq1tq3E
         ef5gzURwAzm/MR44Vyy+Ans54cB5M7/NKkFQsBmmpz7aUX0qrIlyDhZrOBMkiqo2Fhed
         ajrFbaydfDHKUkS0W8vCg+a8q7/8d1l4khXbq9a8Tflx0eBav3gU8tmJarpc7vki2Pi/
         WcW8TySOIX6lZW5teOVAZyxuf37hOeekHXLduAh4Ym6EB+Kdax5BTV4Yb0w15LGJVx5b
         4oVlxhnKSvzLlRMBkC9km17yu9xP/hYuLL8r57CyoNqr2XeMFNH8pvMlBlGXWjFdJmTY
         3GIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=2+Xm2SK9ogxuVwxxRLGF+CaN+ojc7k48F+j/OJqM2Jk=;
        b=GO3miC/dJITULo+3F39NOOQL3jiuPz2yO/d12g7EorfA7AA8C+IDSlyTLZEiE09NXM
         fgI46gatUPpUZAG1h3BgJnY9ru6bovEkHM+FgjcRWaxNLhp43Qm7Qyxp6W87yvgTJqDL
         zP1bR2b46Uolw15hgALdVUkX2jlgt4cLHMAR2iDfoh23qZ10XKz2D7nQsEsqRqUPBhgq
         DQlQcDyfFoPPhzhXD6jOBpw+jVTgEJ5KPPE5+w8uO8i51sof4tbbt4Er30WnQMuhT744
         KXk2BFWCwfum5iJsxNQM7ekW4k51156nNnEQL0VKLG3GzXzHrupkDFe3eivXvcMTxgtD
         FEGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-acpi@vger.kernel.org
Cc: Sudeep.Holla@arm.com,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo.Pieralisi@arm.com,
	hanjun.guo@linaro.org,
	rjw@rjwysocki.net,
	Will.Deacon@arm.com,
	Catalin.Marinas@arm.com,
	gregkh@linuxfoundation.org,
	Mark.Rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	wangxiongfeng2@huawei.com,
	vkilari@codeaurora.org,
	ahs3@redhat.com,
	Dietmar.Eggemann@arm.com,
	Morten.Rasmussen@arm.com,
	palmer@sifive.com,
	lenb@kernel.org,
	john.garry@huawei.com,
	austinwc@codeaurora.org,
	tnowicki@caviumnetworks.com,
	jhugo@codeaurora.org,
	ard.biesheuvel@linaro.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v9 03/12] cacheinfo: rename of_node to fw_token
Date: Fri, 11 May 2018 18:57:58 -0500
Message-Id: <20180511235807.30834-4-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180511235807.30834-1-jeremy.linton@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600214160167363739?=
X-GMAIL-MSGID: =?utf-8?q?1600214160167363739?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Rename and change the type of of_node to indicate
it is a generic pointer which is generally only used
for comparison purposes. In a later patch we will put
an ACPI/PPTT token pointer in fw_token so that
the code which builds the shared cpu masks can be reused.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Vijaya Kumar K <vkilari@codeaurora.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Tested-by: Tomasz Nowicki <Tomasz.Nowicki@cavium.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/base/cacheinfo.c  | 16 +++++++++-------
 include/linux/cacheinfo.h |  8 +++-----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index a872523e8951..597aacb233fc 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -35,7 +35,7 @@ struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu)
 static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 					   struct cacheinfo *sib_leaf)
 {
-	return sib_leaf->of_node == this_leaf->of_node;
+	return sib_leaf->fw_token == this_leaf->fw_token;
 }
 
 /* OF properties to query for a given cache type */
@@ -167,9 +167,10 @@ static int cache_setup_of_node(unsigned int cpu)
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	unsigned int index = 0;
 
-	/* skip if of_node is already populated */
-	if (this_cpu_ci->info_list->of_node)
+	/* skip if fw_token is already populated */
+	if (this_cpu_ci->info_list->fw_token) {
 		return 0;
+	}
 
 	if (!cpu_dev) {
 		pr_err("No cpu device for CPU %d\n", cpu);
@@ -190,7 +191,7 @@ static int cache_setup_of_node(unsigned int cpu)
 		if (!np)
 			break;
 		cache_of_set_props(this_leaf, np);
-		this_leaf->of_node = np;
+		this_leaf->fw_token = np;
 		index++;
 	}
 
@@ -278,7 +279,7 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 			cpumask_clear_cpu(cpu, &sib_leaf->shared_cpu_map);
 			cpumask_clear_cpu(sibling, &this_leaf->shared_cpu_map);
 		}
-		of_node_put(this_leaf->of_node);
+		of_node_put(this_leaf->fw_token);
 	}
 }
 
@@ -323,8 +324,9 @@ static int detect_cache_attributes(unsigned int cpu)
 	if (ret)
 		goto free_ci;
 	/*
-	 * For systems using DT for cache hierarchy, of_node and shared_cpu_map
-	 * will be set up here only if they are not populated already
+	 * For systems using DT for cache hierarchy, fw_token
+	 * and shared_cpu_map will be set up here only if they are
+	 * not populated already
 	 */
 	ret = cache_shared_cpu_map_setup(cpu);
 	if (ret) {
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 3d9805297cda..0c6f658054d2 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -34,9 +34,8 @@ enum cache_type {
  * @shared_cpu_map: logical cpumask representing all the cpus sharing
  *	this cache node
  * @attributes: bitfield representing various cache attributes
- * @of_node: if devicetree is used, this represents either the cpu node in
- *	case there's no explicit cache node or the cache node itself in the
- *	device tree
+ * @fw_token: Unique value used to determine if different cacheinfo
+ *	structures represent a single hardware cache instance.
  * @disable_sysfs: indicates whether this node is visible to the user via
  *	sysfs or not
  * @priv: pointer to any private data structure specific to particular
@@ -65,8 +64,7 @@ struct cacheinfo {
 #define CACHE_ALLOCATE_POLICY_MASK	\
 	(CACHE_READ_ALLOCATE | CACHE_WRITE_ALLOCATE)
 #define CACHE_ID		BIT(4)
-
-	struct device_node *of_node;
+	void *fw_token;
 	bool disable_sysfs;
 	void *priv;
 };
-- 
2.13.6
