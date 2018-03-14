Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AG47ELtFx2jzAsQhTVvdUoimzSiw7i8NqhP70sxVBU/SjDheIZVn1h23cniI/E7tTtBr946yJ9Jl
ARC-Seal: i=1; a=rsa-sha256; t=1521015297; cv=none;
        d=google.com; s=arc-20160816;
        b=X1jDldXpDzSfjcGqcXKoaaq7X7SizIXTVM3IugUg92zlmcAGR2Jutx8n12oLC2/N1o
         gy6DCuU4o/20QsvhBCKhVRGllWjf4osDYHbr/+EKGFM/WJtEcMymaBJ22a1a1HttXQ4M
         ex8VOkisT7/VUi/0tpG6TYf3uuyJv1izNTIRKK2UFz5zTjLQqjXbC+B+PR48KkZuuYnO
         e5wPXMAdFwi68ctQ74Rq6XYusvXMxiKiZVHxG3TF8YTBVRA00AK1iRi/KEqGxASf24L9
         1AEXjtc62YQccdrLWtIHehAuZj0CbivJwPbU4e/XeMVSOj/OyH++1iVdMqDVn1qDDcMR
         mWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=WQQhrEkCFK5SHmrPcbivXwpvGku7c2x6HG+Kmz2fnyA=;
        b=jNQG/hmOl2qDhtPY5u3GI70E9gjKEddPefIblAqIYyvPIoFbtT4OaGno77/fka4hVh
         DzDMxigA3IdfSrQvZyNdMEJxuMXt1Bb0fKrT7FCr1b4JRQPwGxPlafqQX+3hjEfCgVR3
         ok3KO1bKeCTBz5sGsduieqi/T/2z/OIR0uyUVLvHGcRQTaAZQJnGOpkEW//uPMPUB30l
         ig3kFLWZlW6GcgxahAue8PB0uNUDeeHsqusvsdnu09nQdesWHudzU4kYEAHsvKbVWjrd
         Cc6FKeVipFNcyUQM1q8Ap5xlgm67XtTgE5oaahPJKagZgZRdTijCSnGQ/70FGNlqZRee
         DxYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=OYfqop/b;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=oD965LhM;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=OYfqop/b;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=oD965LhM;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 787C960592
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: joro@8bytes.org,
	robh+dt@kernel.org,
	rafael.j.wysocki@intel.com,
	robin.murphy@arm.com,
	iommu@lists.linux-foundation.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mark.rutland@arm.com,
	will.deacon@arm.com,
	robdclark@gmail.com,
	tfiga@chromium.org,
	sricharan@codeaurora.org,
	m.szyprowski@samsung.com,
	architt@codeaurora.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	vivek.gautam@codeaurora.org,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v10 1/5] driver core: Delete the link between two given devices
Date: Wed, 14 Mar 2018 13:44:30 +0530
Message-Id: <20180314081434.30875-2-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180314081434.30875-1-vivek.gautam@codeaurora.org>
References: <20180314081434.30875-1-vivek.gautam@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594900136386574050?=
X-GMAIL-MSGID: =?utf-8?q?1594900136386574050?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Given the consumer and supplier devices, add an API to
delete the link between them.

Suggested-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 - This patch replaces an earlier patch [1] that was adding
   device_link_find() API.
   [1] https://patchwork.kernel.org/patch/10277975/

 drivers/base/core.c    | 31 +++++++++++++++++++++++++++++++
 include/linux/device.h |  1 +
 2 files changed, 32 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5847364f25d9..e13d904e1e12 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -336,6 +336,37 @@ void device_link_del(struct device_link *link)
 }
 EXPORT_SYMBOL_GPL(device_link_del);
 
+/**
+ * device_link_del_dev - Delete a link between two given devices
+ * @consumer: Consumer end of the link.
+ * @supplier: Supplier end of the link.
+ *
+ * The caller must ensure proper synchronization of this function with runtime
+ * PM.
+ */
+void device_link_del_dev(struct device *consumer, struct device *supplier)
+{
+	struct device_link *link;
+
+	if (!consumer || !supplier)
+		return;
+
+	device_links_write_lock();
+	device_pm_lock();
+
+	list_for_each_entry(link, &supplier->links.consumers, s_node) {
+		if (link->consumer == consumer) {
+			__device_link_del(link);
+			/* just one link between the devices */
+			break;
+		}
+	}
+
+	device_pm_unlock();
+	device_links_write_unlock();
+}
+EXPORT_SYMBOL_GPL(device_link_del_dev);
+
 static void device_links_missing_supplier(struct device *dev)
 {
 	struct device_link *link;
diff --git a/include/linux/device.h b/include/linux/device.h
index b093405ed525..14508d843f67 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1278,6 +1278,7 @@ extern const char *dev_driver_string(const struct device *dev);
 struct device_link *device_link_add(struct device *consumer,
 				    struct device *supplier, u32 flags);
 void device_link_del(struct device_link *link);
+void device_link_del_dev(struct device *consumer, struct device *supplier);
 
 #ifdef CONFIG_PRINTK
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
