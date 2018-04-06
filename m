Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756767AbeDFOX6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:23:58 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:40981 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752925AbeDFOX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:23:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Hans Verkuil <hansverk@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] media: platform: fsl-viu: mark local functions 'static'
Date: Fri,  6 Apr 2018 16:23:19 +0200
Message-Id: <20180406142336.2079928-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180406142336.2079928-1-arnd@arndb.de>
References: <20180406142336.2079928-1-arnd@arndb.de>
X-Provags-ID: V03:K1:eEWJ2Ampjg8wbaIO5ZaejpEw8rFHL5QW5/VWDA/bLt2PtFulIFl
 fvVlkFLUdWU9iPkj4AgadiscqmJMUXIYJLF4ylAa2vh6j5oP7GXZgXSCy7Kk2MWbImhSTu1
 Hzm8OSHA1j/vvlLJDvfnkLgltF9Huv1LEqsliWfneZbWSjM7TkJqIS9i8ZudlpQ7gxC2Ti8
 LsHc51EHk2olkw5S89DVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hh2IsQZ3Fb8=:wV2FdKuHkbBAHQswqlZCb6
 YRZ9nRejV1cDhhmX2EPS1ABR+PSLU790B/QvrdKcHAw3Lv4E2vezRPSsNGd0Dfef1TniUvcq3
 BSD50ngjCdzm3kfTw6pJUvHdDaXMWa2/d+vpQUHpUPLoAJ8gkGucZWJTcuu+Bqyj2VjRADz39
 SC+hda/GhiDMYhyl062TdvYJzFfmXSQcfLe0cWhI4NjMYw/SXW0gFoxrpxjZcYfhsiNFhL2J1
 8dK3y2csd5MGxxhrK2+T9hEwguaJkX4f3CVYGgNFVt0cAJiwpV/eSMIU/ZajGiej7SS8b69Wz
 ipG3tAMP7cImzDfY3FS02ZY+qnEbxGnsXMTzOxWOFmMoV1WEZlKiVhgc0By5CgLuKwyk18Vla
 F65ldu7949y/dl4NuX9REQ/JX/Q/N7b8wuOmQMNbzvSa0HqpuKIt+Jbhk7WzIyreqXa/G+B1M
 yXeMU0NLvZdDjfMB+MdfYcM92v77uE5leoOOPijGV1gBW03d3mfzABuT/nGr1QcQMLzaVpsvi
 3gwB7PsfCBfSg1RpqYJns3x7fd6KbYa2n3th11aTyp3iOfbiHnpIILnj0Mo+buA6kPB2N2Qtb
 bAsCSjbMyVUd20wriWucru9ClZLt4FQqCOTpPcZdCLe/wrmazwhxCra1s2VmJkS0V8N/z9zuT
 J4AWPjLQjmCH3uudYg+PvGAntwV1E3DyMynfR1cHwAgWew+oRC58YnpnreP3XvnZjiGlGa8KL
 S7uzUlnOKCXL/dZmJYeT7XV7xUrsjMcnyODrnQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both sparse and gcc (with 'make V=1') warn about non-static symbols that
have not been declared:

drivers/media/platform/fsl-viu.c:235:16: warning: symbol 'format_by_fourcc' was not declared. Should it be static?
drivers/media/platform/fsl-viu.c:248:6: warning: symbol 'viu_start_dma' was not declared. Should it be static?
drivers/media/platform/fsl-viu.c:259:6: warning: symbol 'viu_stop_dma' was not declared. Should it be static?
drivers/media/platform/fsl-viu.c:808:5: warning: symbol 'vidioc_g_fbuf' was not declared. Should it be static?
drivers/media/platform/fsl-viu.c:819:5: warning: symbol 'vidioc_s_fbuf' was not declared. Should it be static?
drivers/media/platform/fsl-viu.c:1311:6: warning: symbol 'viu_reset' was not declared. Should it be static?

In this driver, all instance should indeed be static. This leads to better
optimized code, and avoids potential namespace conflicts.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/fsl-viu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/fsl-viu.c b/drivers/media/platform/fsl-viu.c
index cc85620267f1..38c9be51f01f 100644
--- a/drivers/media/platform/fsl-viu.c
+++ b/drivers/media/platform/fsl-viu.c
@@ -229,7 +229,7 @@ enum status_config {
 
 static irqreturn_t viu_intr(int irq, void *dev_id);
 
-struct viu_fmt *format_by_fourcc(int fourcc)
+static struct viu_fmt *format_by_fourcc(int fourcc)
 {
 	int i;
 
@@ -242,7 +242,7 @@ struct viu_fmt *format_by_fourcc(int fourcc)
 	return NULL;
 }
 
-void viu_start_dma(struct viu_dev *dev)
+static void viu_start_dma(struct viu_dev *dev)
 {
 	struct viu_reg __iomem *vr = dev->vr;
 
@@ -253,7 +253,7 @@ void viu_start_dma(struct viu_dev *dev)
 	out_be32(&vr->status_cfg, INT_FIELD_EN);
 }
 
-void viu_stop_dma(struct viu_dev *dev)
+static void viu_stop_dma(struct viu_dev *dev)
 {
 	struct viu_reg __iomem *vr = dev->vr;
 	int cnt = 100;
@@ -802,7 +802,7 @@ static int vidioc_overlay(struct file *file, void *priv, unsigned int on)
 	return 0;
 }
 
-int vidioc_g_fbuf(struct file *file, void *priv, struct v4l2_framebuffer *arg)
+static int vidioc_g_fbuf(struct file *file, void *priv, struct v4l2_framebuffer *arg)
 {
 	struct viu_fh  *fh = priv;
 	struct viu_dev *dev = fh->dev;
@@ -813,7 +813,7 @@ int vidioc_g_fbuf(struct file *file, void *priv, struct v4l2_framebuffer *arg)
 	return 0;
 }
 
-int vidioc_s_fbuf(struct file *file, void *priv, const struct v4l2_framebuffer *arg)
+static int vidioc_s_fbuf(struct file *file, void *priv, const struct v4l2_framebuffer *arg)
 {
 	struct viu_fh  *fh = priv;
 	struct viu_dev *dev = fh->dev;
@@ -1305,7 +1305,7 @@ static int viu_release(struct file *file)
 	return 0;
 }
 
-void viu_reset(struct viu_reg __iomem *reg)
+static void viu_reset(struct viu_reg __iomem *reg)
 {
 	out_be32(&reg->status_cfg, 0);
 	out_be32(&reg->luminance, 0x9512a254);
-- 
2.9.0
