Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754018AbeDRO3y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:29:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42112 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbeDRO3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:29:50 -0400
Date: Wed, 18 Apr 2018 17:29:37 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm: omapdrm: silence unititialized variable warning
Message-ID: <20180418142937.GA13828@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8866 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=739
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804180131
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch complains that "area_free" could be used without being
initialized.  This code is several years old and premusably works fine
so this can't be a very serious bug.  But it's easy enough to silence
the warning.  If "area_free" is false at the end of the function then
we return -ENOMEM.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/gpu/drm/omapdrm/tcm-sita.c b/drivers/gpu/drm/omapdrm/tcm-sita.c
index d7f7bc9f061a..817be3c41863 100644
--- a/drivers/gpu/drm/omapdrm/tcm-sita.c
+++ b/drivers/gpu/drm/omapdrm/tcm-sita.c
@@ -90,7 +90,7 @@ static int l2r_t2b(u16 w, u16 h, u16 a, s16 offset,
 {
 	int i;
 	unsigned long index;
-	bool area_free;
+	bool area_free = false;
 	unsigned long slots_per_band = PAGE_SIZE / slot_bytes;
 	unsigned long bit_offset = (offset > 0) ? offset / slot_bytes : 0;
 	unsigned long curr_bit = bit_offset;
