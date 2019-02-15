Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A8EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BBB21929
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437006AbfBOM23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 07:28:29 -0500
Received: from mout.gmx.net ([212.227.17.20]:35221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729332AbfBOM21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 07:28:27 -0500
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx103 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MHH3P-1gptlr0ISZ-00E7bi; Fri, 15 Feb 2019 13:28:24 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     gregkh@linuxfoundation.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH v2 3/4] chardev: code cleanup for __register_chrdev_region()
Date:   Fri, 15 Feb 2019 20:27:13 +0800
Message-Id: <20190215122714.28842-3-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215122714.28842-1-cgxu519@gmx.com>
References: <20190215122714.28842-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NX9feo77qaDNYt9vub7pm0v/+JuJ3oOpCeMsZxTuZEAHrmnzl8i
 OWn+qw/F/751cAEBIGqZ4t/1okagY4+DaXBk3doJPaOh9v9iviRsQfowpixS776Kru04ZBN
 VpBdfuxgDHfpmhe1Q1FmtXNOjeSU+/tjB9+s6QCHvIgS3e0wIEvXO2PAvUS5yU3uS3x6GWj
 wYrn2Rl9YHwgFdHv490WQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GSu2pvZnJcU=:S9rTQZgyVxHT5dUEC5aqqE
 Ng9tgw6t/iSu8FO3esHOiil+4WMGxyHnwj8xceck1sM5/ReazR/13Z+uu10lj1gZv7tSlmvd/
 3Wj4JpUy3G8XruKRJg19V1CKvFr4w8cmvjO0XpIHlAiblf18wuIz9NlwLVLF3bCwgY171EeWL
 zoRXLLsAJIrup5O0SiUAAEWvS2b0UhCYedely8GHbtsyb1BlYQ8Xfll49FXpDLDgtY/VvshkY
 2pfATQHxGEFX+LR3QKzmTe8u9H4IQrkFHajUt2PZ/KT3x3QlObVPa3Z36N0xrDaBtdG0vs1XZ
 zgIdb+ix0+1j3OIyG7cVIpPjIOzIX+1GgKxt+UxP6P8JdXvT5rgheo37DWicI3uuxJdVhnB+2
 uVUMeW69eNaoysei/QVy16r6qZ6RphInQIeBkwIMVWFCeBA6jhEnvDNcs+Su1bkShonff8o63
 7kJo9x+fOQsYP6zBNOa/iRdKFUkkUTxLO+7lV8cdgz05wBLaAHbl8BWc9TtFSDWX3P6ZnaC1D
 kQYD/8K5KUm4UuD0g3hVSrm6klIIg5GGmbxd9OQYcNoemQRSl9aiUUEUkDiap3n0QLKf1fP2G
 9chRQ3kUNyEDvZuNGOwFqQWN6JOaOxaqR2RKFttPvvCIMezoYYzSV7GSeXF1GfIDMi/mt6xzw
 yB1AcebwAr7iT5vcgWE0r/mSPOIiT5wweNuyYXq+ii7dgxZBIIdy0RAzV2m9nb3Nf/ksWj+7s
 tq7Nreqiapxt0rUibwjg691G+rKtEgB5MGBFpk3VN3fEr8qElhbd6NzKPx7RYrPy4mp/yVhRe
 d8htBRSxWnMEKGgYph3pOYNtaRr7uA8lRZvv6oopuMi2KCEcYfC92+uWaIQjW8JFpag2WgQDj
 DDc0gaRFrXRsEezfeHr+xJ8zxK5OcO8mzgZPu2ylj1zkKu5nBqAZOwD8BTyB4c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's just code cleanup, not functional change.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
v1->v2:
- Split fix and cleanup patches.
- Remove printing minor range in chrdev_show().

 fs/char_dev.c | 69 +++++++++++++++++++++------------------------------
 1 file changed, 28 insertions(+), 41 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 6803e98414f1..bd2bf1fd847e 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -100,10 +100,16 @@ static struct char_device_struct *
 __register_chrdev_region(unsigned int major, unsigned int baseminor,
 			   int minorct, const char *name)
 {
-	struct char_device_struct *cd, **cp;
-	int ret = 0;
+	struct char_device_struct *cd, *curr, *prev = NULL;
+	int ret = -EBUSY;
 	int i;
 
+	if (major >= CHRDEV_MAJOR_MAX) {
+		pr_err("CHRDEV \"%s\" major requested (%u) is greater than the maximum (%u)\n",
+		       name, major, CHRDEV_MAJOR_MAX-1);
+		return ERR_PTR(-EINVAL);
+	}
+
 	if (minorct > MINORMASK + 1 - baseminor) {
 		pr_err("CHRDEV \"%s\" minor range requested (%u-%u) is out of range of maximum range (%u-%u) for a single major\n",
 			name, baseminor, baseminor + minorct - 1, 0, MINORMASK);
@@ -126,55 +132,36 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
 		major = ret;
 	}
 
-	if (major >= CHRDEV_MAJOR_MAX) {
-		pr_err("CHRDEV \"%s\" major requested (%u) is greater than the maximum (%u)\n",
-		       name, major, CHRDEV_MAJOR_MAX-1);
-		ret = -EINVAL;
-		goto out;
-	}
-
-	cd->major = major;
-	cd->baseminor = baseminor;
-	cd->minorct = minorct;
-	strlcpy(cd->name, name, sizeof(cd->name));
-
 	i = major_to_index(major);
+	for (curr = chrdevs[i]; curr; prev = curr, curr = curr->next) {
+		if (curr->major < major)
+			continue;
 
-	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next)
-		if ((*cp)->major > major ||
-		    ((*cp)->major == major &&
-		     (((*cp)->baseminor >= baseminor) ||
-		      ((*cp)->baseminor + (*cp)->minorct > baseminor))))
+		if (curr->major > major)
 			break;
 
-	/* Check for overlapping minor ranges.  */
-	if (*cp && (*cp)->major == major) {
-		int old_min = (*cp)->baseminor;
-		int old_max = (*cp)->baseminor + (*cp)->minorct - 1;
-		int new_min = baseminor;
-		int new_max = baseminor + minorct - 1;
+		if (curr->baseminor + curr->minorct <= baseminor)
+			continue;
 
-		/* New driver overlaps from the left.  */
-		if (new_max >= old_min && new_max <= old_max) {
-			ret = -EBUSY;
-			goto out;
-		}
+		if (curr->baseminor >= baseminor + minorct)
+			break;
 
-		/* New driver overlaps from the right.  */
-		if (new_min <= old_max && new_min >= old_min) {
-			ret = -EBUSY;
-			goto out;
-		}
+		goto out;
+	}
 
-		if (new_min < old_min && new_max > old_max) {
-			ret = -EBUSY;
-			goto out;
-		}
+	cd->major = major;
+	cd->baseminor = baseminor;
+	cd->minorct = minorct;
+	strlcpy(cd->name, name, sizeof(cd->name));
 
+	if (!prev) {
+		cd->next = curr;
+		chrdevs[i] = cd;
+	} else {
+		cd->next = prev->next;
+		prev->next = cd;
 	}
 
-	cd->next = *cp;
-	*cp = cd;
 	mutex_unlock(&chrdevs_lock);
 	return cd;
 out:
-- 
2.20.1

