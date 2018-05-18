Return-Path: <kim.phillips@arm.com>
X-Google-Smtp-Source: AB8JxZpaZgVoIkf0169zgdv1IQ/4TDEeATmYGh1S8htVIK7AGxJRR24fZAN4Xps0RjyR5D8VtMFC
ARC-Seal: i=1; a=rsa-sha256; t=1526606468; cv=none;
        d=google.com; s=arc-20160816;
        b=oLZbh/SgS+YvsyWLXIeBUTK1oR4c2VycRR/TSdlJsPHUZZl8Am1GnBGAMfSyfPQTS9
         Oh7Eo/m5SibrmfLokn/TUtos/YTtmwzXbflBDNzX9E5VBnLHjEKoXmg9zKh6Vqxg88Qb
         ixkHFZ6a1TnCKkcBQuEjv0q448xJfUAElVQbiTWhzbIQYosVLY8SuU8IrwnuHGWUyxAX
         ai2yXijeJLUR7R1tS09cWEhN7UrtQgfJ/ZBBFnhidcc5afTMo98gR+bAYRxl9utO68l9
         FnO8+Rq/iOQ034rRrbJ3jVc9DJRSbEXmiAr190ZwdUO8CGzsfd219RKzUBgoVwc6YPO1
         q0wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=6BLInIB/ZUUK2DE2Ye7c/oMuK6P4W9kg/QRwSSBJGFs=;
        b=xZ6b9lXNVLXvZlwku9GsudueUCVNPYt88nkMK3FOD2e9wAZ7LGd4eYr2fMRq15v6sL
         vAzUB1jUO4uDyFm6+EtbqrdrpA4Cqzw9Jg6sJ2239FaPFBnQoH1Q7KP1+Fv4gpAdXqNb
         Tum3lER/5DuKZxe9H6kr98uR0ux7NrLgMOfzczyPMyB8zJ6+vYnZtVsh2AkKuV26/FzK
         MYE5LqTNdioPn1TnlNbokTd40evOVk6szQT/UCAI6G08X4hTYJhN3Z5Y3pnwA2ZBGwBn
         6RUoeRb4zeifi+LGxvg8jLqnak/Vnbp48a7J0yPJr0PCxX43+abD94jjtpmaC30U0hMH
         vkAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
From: Kim Phillips <kim.phillips@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Gargi Sharma <gs051095@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kirill Tkhai <ktkhai@virtuozzo.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Rik van Riel <riel@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Thierry Reding <treding@nvidia.com>,
	Todd Kjos <tkjos@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kim Phillips <kim.phillips@arm.com>
Subject: [PATCH 4/6] coresight: move shared barrier_pkt[] to coresight_priv.h
Date: Thu, 17 May 2018 20:20:22 -0500
Message-Id: <20180518012024.22645-4-kim.phillips@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518012024.22645-1-kim.phillips@arm.com>
References: <20180517070643.GC13919@kroah.com>
 <20180518012024.22645-1-kim.phillips@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600762904147176084?=
X-GMAIL-MSGID: =?utf-8?q?1600762904147176084?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

barrier_pkt[] is used in various coresight components.
Change barrier_pkt[] to a static definition in the coresight
private header.  Needed prior to allowing coresight to be
built as modules.

Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 drivers/hwtracing/coresight/coresight-priv.h | 9 ++++++++-
 drivers/hwtracing/coresight/coresight.c      | 8 --------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 83a6f5b7a683..45de8c15b687 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -57,7 +57,14 @@ static DEVICE_ATTR_RO(name)
 #define coresight_simple_reg64(type, name, lo_off, hi_off)		\
 	__coresight_simple_func(type, NULL, name, lo_off, hi_off)
 
-extern const u32 barrier_pkt[5];
+/*
+ * When losing synchronisation a new barrier packet needs to be inserted at the
+ * beginning of the data collected in a buffer.  That way the decoder knows that
+ * it needs to look for another sync sequence.
+ */
+static const u32 barrier_pkt[5] = {0x7fffffff, 0x7fffffff,
+				   0x7fffffff, 0x7fffffff, 0x0};
+
 
 enum etm_addr_type {
 	ETM_ADDR_TYPE_NONE,
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 29e834aab539..0cbc2948defc 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -46,14 +46,6 @@ static DEFINE_PER_CPU(struct list_head *, tracer_path);
  */
 static struct list_head *stm_path;
 
-/*
- * When losing synchronisation a new barrier packet needs to be inserted at the
- * beginning of the data collected in a buffer.  That way the decoder knows that
- * it needs to look for another sync sequence.
- */
-const u32 barrier_pkt[5] = {0x7fffffff, 0x7fffffff,
-			    0x7fffffff, 0x7fffffff, 0x0};
-
 static int coresight_id_match(struct device *dev, void *data)
 {
 	int trace_id, i_trace_id;
-- 
2.17.0
