Return-Path: <paulmcquad@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523126875; cv=none;
        d=google.com; s=arc-20160816;
        b=ZcCwcmHyEDqqAfvEKK6xS0gd9/DRM6U5+XvTeN0DsRTv/2hSB6BjDhM+ysSYyMJ31F
         mGI21Jl4OB1MkbAz2PhUkH48Nq7ypid3/2XsuXOU+LyPnyRlOzBOeTg0jKFoDYsrN2t2
         fv3Ayz3n4x7v99e4eZQ3s3yklKjyuMiQ0VkxkAtX39HpZG1mtvM1aLl450+qNsIRrJVp
         NnWX7++6/2EOTKK0YaiFQDXCauW4yjtB9kp/MLXCCe+hhsURanHhklpGrCffrCqkWCLs
         h22BOvYqE+hCLy0d9ARS2Dwdt3HAIJdq70JiZk2i3U564CjfTE7LTeeOLAHdoZhCSQyE
         Polg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=P1bz2I9qVb4OLF+hgVpIKrX8dBHZrfBjDMZm900DfoA=;
        b=PQ0/IEzVNYcSDQNCz2irpM+6DGH88iLJA0JxQgXphjlarXPmsc1Vv75GfM23M99uOp
         2/eNWsKtQ4lyKx0eHZ68PYD7ebTvW0mOBUAhvTp+O3XEti6OLiqXHP03k2q8S5ghE0Ef
         SLCr82tx/nlMzrI8UHHwBW0pqtZlH0Y66GSh5k7Iw2ijDBLUmC59SkJbfRT/MmPPrAMU
         E9QriJeheMXmNkj+X5xb0/bvgRrYBiR4pMjsZtIHrvg4AeK3PGgRsiSdGisj2/Gdiwaw
         4GbRjcHwtDanQhX/1BFezJL9Vh8AWNzKGA7HXIBcAZFekEgmEMKWkt4JHaZVUwJ8sxBs
         qNjw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vB/Syt1j;
       spf=pass (google.com: domain of paulmcquad@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=paulmcquad@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vB/Syt1j;
       spf=pass (google.com: domain of paulmcquad@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=paulmcquad@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49lItrYLL2zVGPfYHEafHQH9iJu1vPo8xXvc6l0W39T4/tg/cS5iu4XrGPZPAXqzXIUBid6DQ==
From: Paul McQuade <paulmcquad@gmail.com>
To: paulmcquad@gmail.com
Cc: konrad.wilk@oracle.com,
	labbott@redhat.com,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	guptap@codeaurora.org,
	vbabka@suse.cz,
	mgorman@techsingularity.net,
	hannes@cmpxchg.org,
	rientjes@google.com,
	mhocko@suse.com,
	rppt@linux.vnet.ibm.com,
	dave@stgolabs.net,
	hmclauchlan@fb.com,
	tglx@linutronix.de,
	pombredanne@nexb.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/3] mm: Replace S_IWUSR with 0200
Date: Sat,  7 Apr 2018 19:47:25 +0100
Message-Id: <20180407184726.8634-2-paulmcquad@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180407184726.8634-1-paulmcquad@gmail.com>
References: <20180407184726.8634-1-paulmcquad@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597114287199366253?=
X-GMAIL-MSGID: =?utf-8?q?1597114287199366253?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix checkpatch warnings about S_IWUSR being less readable than
providing the permissions octal as '0200'.

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
---
 mm/cma_debug.c  | 4 ++--
 mm/compaction.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/cma_debug.c b/mm/cma_debug.c
index 6494c7a7d257..f0af3f93d1e4 100644
--- a/mm/cma_debug.c
+++ b/mm/cma_debug.c
@@ -172,10 +172,10 @@ static void cma_debugfs_add_one(struct cma *cma, int idx)
 
 	tmp = debugfs_create_dir(name, cma_debugfs_root);
 
-	debugfs_create_file("alloc", S_IWUSR, tmp, cma,
+	debugfs_create_file("alloc", 0200, tmp, cma,
 				&cma_alloc_fops);
 
-	debugfs_create_file("free", S_IWUSR, tmp, cma,
+	debugfs_create_file("free", 0200, tmp, cma,
 				&cma_free_fops);
 
 	debugfs_create_file("base_pfn", 0444, tmp,
diff --git a/mm/compaction.c b/mm/compaction.c
index 88d01a50a015..50d0000a6afd 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1900,7 +1900,7 @@ static ssize_t sysfs_compact_node(struct device *dev,
 
 	return count;
 }
-static DEVICE_ATTR(compact, S_IWUSR, NULL, sysfs_compact_node);
+static DEVICE_ATTR(compact, 0200, NULL, sysfs_compact_node);
 
 int compaction_register_node(struct node *node)
 {
-- 
2.16.2
