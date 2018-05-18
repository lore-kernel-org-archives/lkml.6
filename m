Return-Path: <kim.phillips@arm.com>
X-Google-Smtp-Source: AB8JxZpDVkFZF+djeXkEN6B2j8Fq4klRN97VY05JGzL9CVMuFppD7rMttaJ9feZ0oSA5cETgwSG0
ARC-Seal: i=1; a=rsa-sha256; t=1526606467; cv=none;
        d=google.com; s=arc-20160816;
        b=y8uJk1GAaMNZCDtyT9Dn36jfls+efvc0B4YYu3nHl4bVTgOmdk4kW5udarGkrhhsV1
         GC65X+lEo+boAzBj6T8ypM+IMPcc1h/j7waX14gPuZdC8W/dMXG1H+cYp2Uijn9rCO3M
         cG+zt90IjxTJdoFDqA1NrlPJC/GqLEutrcS/Bl6dru5O0JGZh03y3p5DtbHLORiTAMdz
         ioqCRl2sbYqjZsIq9EP2yKgrE5C5uk1nyTFW0Vj1/LB9M8MG1QSGJC/buXAnBvhcARAk
         lIZTGRd2WWPptdBJ4b9b8W36LCteH3rYs4reA73D36YIhKWv7DVVPFKiI6cVTuJEJcXp
         bj7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=viIZCrcYEZp7yQw2G9I0PUv0ciPdVdUgiSZk4j3dRj4=;
        b=WEKITissQRqh4vbLP8cyUXWu/rQEnvvxsSdsuGLXnkuH3v9vzAFLsRQDBnlaAQajOD
         0uG8JnJ4deCmr/FK0HaLQVHBLvFlIYkuQXHHuwd8cLSij7Ju5VJKUAfDbeOo4igy/Ozs
         RQ1V/vBT+Sfx1/USYnr/FYLphRbfAGfZ2uPT+ZwG1wHgTYFz3sBdU9/+mL9K+VssNFw7
         i0tUBewn72EqsPPhCmi/xkMbcVDATgVlMm4lLRSjCGTPOMp/2MXAg/voVxwEb8dD8Xj1
         EHQ5SdP9/ChESdkC58q4SDwWlQ9VOBn7LIEc1ShcoaeqekXpTHg9SzCNCb1QI2uozrjB
         yF4w==
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
Subject: [PATCH 3/6] coresight: use IS_ENABLED for CONFIGs that may be modules
Date: Thu, 17 May 2018 20:20:21 -0500
Message-Id: <20180518012024.22645-3-kim.phillips@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518012024.22645-1-kim.phillips@arm.com>
References: <20180517070643.GC13919@kroah.com>
 <20180518012024.22645-1-kim.phillips@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600762903059430246?=
X-GMAIL-MSGID: =?utf-8?q?1600762903059430246?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Checking for CONFIG_x fails if CONFIG_x=m, use IS_ENABLED that is
true for built-ins and modules instead.  Required when building
various coresight components as modules.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.h | 2 +-
 drivers/hwtracing/coresight/coresight-priv.h     | 2 +-
 include/linux/coresight.h                        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 4197df4faf5e..539b250df455 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -43,7 +43,7 @@ struct etm_filters {
 };
 
 
-#ifdef CONFIG_CORESIGHT
+#if IS_ENABLED(CONFIG_CORESIGHT)
 int etm_perf_symlink(struct coresight_device *csdev, bool link);
 
 #else
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 0e5a74dae6a6..83a6f5b7a683 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -136,7 +136,7 @@ struct list_head *coresight_build_path(struct coresight_device *csdev,
 				       struct coresight_device *sink);
 void coresight_release_path(struct list_head *path);
 
-#ifdef CONFIG_CORESIGHT_SOURCE_ETM3X
+#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)
 extern int etm_readl_cp14(u32 off, unsigned int *val);
 extern int etm_writel_cp14(u32 off, u32 val);
 #else
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index e5421b83e4e6..548fa56b29bd 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -236,7 +236,7 @@ struct coresight_ops {
 	const struct coresight_ops_source *source_ops;
 };
 
-#ifdef CONFIG_CORESIGHT
+#if IS_ENABLED(CONFIG_CORESIGHT)
 extern struct coresight_device *
 coresight_register(struct coresight_desc *desc);
 extern void coresight_unregister(struct coresight_device *csdev);
-- 
2.17.0
