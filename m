Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1ACC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E692192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406108AbfBOM2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 07:28:24 -0500
Received: from mout.gmx.net ([212.227.17.22]:54925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406082AbfBOM2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 07:28:22 -0500
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx103 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0M7Y9j-1hFAQe167L-00xKFG; Fri, 15 Feb 2019 13:28:20 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     gregkh@linuxfoundation.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH v2 2/4] chardev: add a check for given minor range
Date:   Fri, 15 Feb 2019 20:27:12 +0800
Message-Id: <20190215122714.28842-2-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215122714.28842-1-cgxu519@gmx.com>
References: <20190215122714.28842-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:R4pWvPNm9tYZ5hJppJDSW4jb+Rnx7Qx3yYhPkIfANUeWzHFKrt+
 /CObWIPSQi/A9SeKZ0iG22h3K6z7Eq8OrTIm0UH0gdCBeoqsJn9vcShnEbFP9WjATXKTSlp
 oyU3KKWfGGoA8Bq7BVVb3GsvpYNKHcDDs8IF8Kpz309BII8tjf12V1rgF1FsxjkKTd4rQIM
 6/TmaxnHeYh7yaW8Vvugw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xgZ0fnmxC1U=:l8xSbyoaY7Kn7/v3WQM3yP
 X6dJy4bGWx8qJWQ+yMDmPvho3NFV40JkWSqbgs9hDyXsUHeOTV6ichZ41DC8CWFWPfBnmlvNl
 dIyI1VbCvd3+9u9WarM3c0dDFrEe/Mcv8rEEI4eONTkRn0eJQf2NYQrQ7uo3DU2pd2UhPbpn5
 w1WvDyUdQAYnFvOwI9FBj/2QRZasBIQ497sGCYjFbWzDpzCOXAt0aNFeHg4/SvQaRJmaM2Dmd
 3hVSV6kYM7H93px5DKLjBP+4yflfhMF4ZuQC2VhwMgbteSFrHlFKcRiJRxEai0c2VuA+wpkYB
 T7FbL6OmgUqqQV3e7QsRUdCbvoQj/eGHzmLD2eHV3T+yFFx8DYncXy8jDu84mhiMpmHJVpnnx
 SqJFFkXkJudHVv/15nDD4QiE6G4UfBnSbwGF6KLYPJSrlxB5pqRpc927PWVmIepL/Ee3xDwsA
 AVa/9rRuRFOqnyERBmO+9nMR6FBSHxFzaDJxc502cpyodVOhYihqUBaYxIoaIKzoIDDFeo76w
 ea89+mJMCBigma0DV4Mp9PRksiJJ7Xj3OEOxEzgL2kUj68opSq82UXVrYn8CPanGY+PhEiI2Q
 i7rNctdlWcwqwQszplWbQDliAC4B3MFP8wDkDeREpTkQnh6KAq4Axrf6Re/tR6VZlyrtbY3PN
 HytAJyW64Se4ijmDAqsgLEVXXNkQNlsIC9D8Ga7E1C0ABXEtUYuiTDKtBHeetGJxWrP67zTtn
 Z7b55kH0KoMlUVmsvgCBS+fi+s4hZwQmMdX8Q5UpTJVEutMsUke+V+EAiKFp8tgiKDRnx9wud
 vnxdK4L8ONJMYl94hpKJVh/5oi4PzVsKfppVYlxL2Nhc7ei6wh1LALHNrsVaAJd8qxl+R/997
 zBTbQl1pq9vWp0hOAMiopC7HNP43aOAtSu51Z78AEWmaS5IkviOmQp16YC7Qs+
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

register_chrdev_region() carefully checks minor range
before calling __register_chrdev_region() but there is
another path from alloc_chrdev_region() which does not
check the range properly. So add a check for given minor
range in __register_chrdev_region().

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
v1->v2:
- Split fix and cleanup patches.
- Remove printing minor range in chrdev_show().

 fs/char_dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 8a63cfa29005..6803e98414f1 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -104,6 +104,12 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
 	int ret = 0;
 	int i;
 
+	if (minorct > MINORMASK + 1 - baseminor) {
+		pr_err("CHRDEV \"%s\" minor range requested (%u-%u) is out of range of maximum range (%u-%u) for a single major\n",
+			name, baseminor, baseminor + minorct - 1, 0, MINORMASK);
+		return ERR_PTR(-EINVAL);
+	}
+
 	cd = kzalloc(sizeof(struct char_device_struct), GFP_KERNEL);
 	if (cd == NULL)
 		return ERR_PTR(-ENOMEM);
-- 
2.20.1

