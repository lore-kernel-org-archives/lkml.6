Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932095AbeCIKo7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:44:59 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:39456 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbeCIKoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:44:54 -0500
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] of: overlay: Fix forgotten reference to of_overlay_apply()
Date: Fri,  9 Mar 2018 11:44:47 +0100
Message-Id: <1520592288-7680-3-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520592288-7680-1-git-send-email-geert+renesas@glider.be>
References: <1520592288-7680-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While technically the ovcs_id is still returned by of_overlay_apply(),
this is an internal function.  All public callers of of_overlay_remove()
pass an ovcs_id returned by the public function of_overlay_fdt_apply().

Fixes: 39a751a4cb7e4798 ("of: change overlay apply input data from unflattened to FDT")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
The single internal caller is of_overlay_remove_all().
---
 drivers/of/overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index b930e05d121574ad..dbdeef5a12863ac3 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -958,7 +958,7 @@ static int overlay_removal_is_ok(struct overlay_changeset *remove_ovcs)
  * @ovcs_id:	Pointer to overlay changeset id
  *
  * Removes an overlay if it is permissible.  @ovcs_id was previously returned
- * by of_overlay_apply().
+ * by of_overlay_fdt_apply().
  *
  * If an error occurred while attempting to revert the overlay changeset,
  * then an attempt is made to re-apply any changeset entry that was
-- 
2.7.4
