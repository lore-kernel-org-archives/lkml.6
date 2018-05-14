Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbeENL0c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:26:32 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:35742 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752122AbeENLZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:25:38 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, goliath@sigma-star.at,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/5] ubinize: Don't stat image file twice
Date: Mon, 14 May 2018 13:25:25 +0200
Message-Id: <20180514112528.24092-3-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180514112528.24092-1-richard@nod.at>
References: <20180514112528.24092-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 ubi-utils/ubinize.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/ubi-utils/ubinize.c b/ubi-utils/ubinize.c
index c85ff9b22c58..3390d0d95305 100644
--- a/ubi-utils/ubinize.c
+++ b/ubi-utils/ubinize.c
@@ -335,16 +335,11 @@ static int read_section(const struct ubigen_info *ui, const char *sname,
 				      sname, *img, (long long)st->st_size, vi->bytes);
 		verbose(args.verbose, "volume size: %lld bytes", vi->bytes);
 	} else {
-		struct stat st;
-
 		if (!*img)
 			return errmsg("neither image file (\"image=\") nor volume size "
 				      "(\"vol_size=\") specified in section \"%s\"", sname);
 
-		if (stat(*img, &st))
-			return sys_errmsg("cannot stat \"%s\"", *img);
-
-		vi->bytes = st.st_size;
+		vi->bytes = st->st_size;
 
 		if (vi->bytes == 0)
 			return errmsg("file \"%s\" referred from section \"%s\" is empty",
-- 
2.13.6
