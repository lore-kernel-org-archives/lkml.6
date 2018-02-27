Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeB0Reo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:34:44 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:56100 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751735AbeB0Ren (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:34:43 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <perex@perex.cz>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ALSA: control: Fix a bunch of whitespace errors
Date: Tue, 27 Feb 2018 17:29:54 +0000
Message-ID: <20180227172954.24819-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802270217
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a bunch of trailing whitespace errors. They are
fairly annoying if you have your editor set to strip trailing
whitespace because you find you've introduced more changes
than you were trying to make.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/core/control.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 8a77620a3854..69734b0eafd0 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -105,7 +105,7 @@ static void snd_ctl_empty_read_queue(struct snd_ctl_file * ctl)
 {
 	unsigned long flags;
 	struct snd_kctl_event *cread;
-	
+
 	spin_lock_irqsave(&ctl->read_lock, flags);
 	while (!list_empty(&ctl->events)) {
 		cread = snd_kctl_event(ctl->events.next);
@@ -159,7 +159,7 @@ void snd_ctl_notify(struct snd_card *card, unsigned int mask,
 	unsigned long flags;
 	struct snd_ctl_file *ctl;
 	struct snd_kctl_event *ev;
-	
+
 	if (snd_BUG_ON(!card || !id))
 		return;
 	if (card->shutdown)
@@ -213,7 +213,7 @@ static int snd_ctl_new(struct snd_kcontrol **kctl, unsigned int count,
 {
 	unsigned int size;
 	unsigned int idx;
-	
+
 	if (count == 0 || count > MAX_CONTROL_COUNT)
 		return -EINVAL;
 
@@ -238,7 +238,7 @@ static int snd_ctl_new(struct snd_kcontrol **kctl, unsigned int count,
  * @ncontrol: the initialization record
  * @private_data: the private data to set
  *
- * Allocates a new struct snd_kcontrol instance and initialize from the given 
+ * Allocates a new struct snd_kcontrol instance and initialize from the given
  * template.  When the access field of ncontrol is 0, it's assumed as
  * READWRITE access. When the count field is 0, it's assumes as one.
  *
@@ -251,7 +251,7 @@ struct snd_kcontrol *snd_ctl_new1(const struct snd_kcontrol_new *ncontrol,
 	unsigned int count;
 	unsigned int access;
 	int err;
-	
+
 	if (snd_BUG_ON(!ncontrol || !ncontrol->info))
 		return NULL;
 
@@ -753,7 +753,7 @@ static int snd_ctl_elem_list(struct snd_card *card,
 	struct snd_ctl_elem_id id;
 	unsigned int offset, space, jidx;
 	int err = 0;
-	
+
 	if (copy_from_user(&list, _list, sizeof(list)))
 		return -EFAULT;
 	offset = list.offset;
@@ -827,7 +827,7 @@ static int snd_ctl_elem_info(struct snd_ctl_file *ctl,
 	struct snd_kcontrol_volatile *vd;
 	unsigned int index_offset;
 	int result;
-	
+
 	down_read(&card->controls_rwsem);
 	kctl = snd_ctl_find_id(card, &info->id);
 	if (kctl == NULL) {
@@ -992,7 +992,7 @@ static int snd_ctl_elem_lock(struct snd_ctl_file *file,
 	struct snd_kcontrol *kctl;
 	struct snd_kcontrol_volatile *vd;
 	int result;
-	
+
 	if (copy_from_user(&id, _id, sizeof(id)))
 		return -EFAULT;
 	down_write(&card->controls_rwsem);
@@ -1020,7 +1020,7 @@ static int snd_ctl_elem_unlock(struct snd_ctl_file *file,
 	struct snd_kcontrol *kctl;
 	struct snd_kcontrol_volatile *vd;
 	int result;
-	
+
 	if (copy_from_user(&id, _id, sizeof(id)))
 		return -EFAULT;
 	down_write(&card->controls_rwsem);
-- 
2.11.0
