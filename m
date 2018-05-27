Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbeE0VXY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 17:23:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41921 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbeE0VXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 17:23:22 -0400
From: Colin King <colin.king@canonical.com>
To: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ALSA: xen-front: remove redundant error check on ret
Date: Sun, 27 May 2018 22:23:12 +0100
Message-Id: <20180527212312.23997-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The error for a -ve value in ret is redundant as all previous
assignments to ret have an associated -ve check and hence it
is impossible for ret to be less that zero at the point of the
check.  Remove this redundant error check.

Detected by CoveritScan, CID#1469407 ("Logically Dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/xen/xen_snd_front_evtchnl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/xen/xen_snd_front_evtchnl.c b/sound/xen/xen_snd_front_evtchnl.c
index d70a62e7f910..102d6e096cc8 100644
--- a/sound/xen/xen_snd_front_evtchnl.c
+++ b/sound/xen/xen_snd_front_evtchnl.c
@@ -351,8 +351,6 @@ int xen_snd_front_evtchnl_create_all(struct xen_snd_front_info *front_info,
 			}
 		}
 	}
-	if (ret < 0)
-		goto fail;
 
 	front_info->num_evt_pairs = num_streams;
 	return 0;
-- 
2.17.0
