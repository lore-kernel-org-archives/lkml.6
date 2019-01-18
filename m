Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB180C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0BC2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PUFNMIJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfARE4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 23:56:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45763 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfARE4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 23:56:15 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so5771964plm.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 20:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=v5V4HdgKPzem6Mt8vERV5zTpQDshmsd4hAtGY7czJL0=;
        b=PUFNMIJuwqujt9WOvf9Z4DPIppubaEm2ldGp77stcL8tOvk//g0BA8xAnvBFpMKtjn
         2KQeYAiQ5RaFxAssOgmxSrIAlpWoIgb/F2XMLuzQXnCGudF9z7gu0qKw70A+2yTsWgMY
         SJ6PHk1wV2Darq5hxiR8nEBuVxrMKLnodCWms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v5V4HdgKPzem6Mt8vERV5zTpQDshmsd4hAtGY7czJL0=;
        b=adMJc0S/qKrh2lgGjw4wBWzWVkwROGBec6EfacOLzNQcaffv2/2M3useLer9IGzNgz
         U6C74Q7UT7LqVtNtLO4ssUPG4teLV8Rfi5OziPYo94PPK3MJAMuqE6PIhTmoKtJn40wG
         4+EjeGzARXkywCsOBICIbHOnEXy+I4hRbpUuWIiRnsaT5laqFcvQwvVOpvATCyBymH3Q
         /eG8jwxmcPWTL19GfzJ7bmWeTxRiRsvMFKtYX6NcOs6X2kvXGe4Gubgg+aXz6CU2L/R0
         MZkuJC6cpqY9K3/ZFVlnvmhihGo2gq4M1tQeF2bpKXPRSDI6UFRjujiO3DoX6GgypMry
         HKpw==
X-Gm-Message-State: AJcUukc3FHj/DTiseNQaIWYQKHIMb4r/1EFZrFAAKkIixZVAvfPJfVh7
        Z1+AOByxZwas+4YdgvdqSywIfw==
X-Google-Smtp-Source: ALg8bN654+JsiALBEl4o1BTokgcp1iG3ys8zMV49erC5pFZ06/ZGzaaJ4wXF1jKHRD5Bx2l8wsycHQ==
X-Received: by 2002:a17:902:33c1:: with SMTP id b59mr17556104plc.220.1547787373447;
        Thu, 17 Jan 2019 20:56:13 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 7sm6410910pfm.8.2019.01.17.20.56.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Jan 2019 20:56:12 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        leo.yan@linaro.org
Cc:     sboyd@kernel.org, colyli@suse.de, corbet@lwn.net,
        mathieu.poirier@linaro.org, ckeepax@opensource.wolfsonmicro.com,
        mchehab+samsung@kernel.org, gustavo@embeddedor.com,
        joe@perches.com, vkoul@kernel.org, o-takashi@sakamocchi.jp,
        keescook@chromium.org, jmiller@neverware.com,
        anna-maria@linutronix.de, willy@infradead.org, sr@denx.de,
        bgoswami@codeaurora.org, philburk@google.com,
        srinivas.kandagatla@linaro.org, arnd@arndb.de,
        daniel.thompson@linaro.org, baolin.wang@linaro.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [RFC PATCH] ALSA: core: Add DMA share buffer support
Date:   Fri, 18 Jan 2019 12:55:18 +0800
Message-Id: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds dma share buffer support, which allows a dma-buf to be shared
between processes by passing file descriptors between them, allowing multiple
processes to cooperate in filling the DMA buffer used by the audio hardware
without the need to copy data around. This reduces both latency and CPU load,
especially in configurations where only one application is playing audio and
so context switches can be avoided.

In userspace, we can use ioctl:SNDRV_PCM_IOCTL_DMABUF_EXPORT to export one
dma buffer to a PCM, and use ioctl:SNDRV_PCM_IOCTL_DMABUF_ATTACH and
ioctl:SNDRV_PCM_IOCTL_DMABUF_DETACH to attach or detach one device to the
dma buffer. Morevoer we can use dma buffer ioctl:DMA_BUF_IOCTL_SYNC to
guarantee the cache coherency of the DMA buffer.

You can refer to below patches [1] created by Leo Yan to use the dma buffer
in userspace.

[1] https://github.com/tinyalsa/tinyalsa/pull/126

Welcome any comments. Thanks.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Hi,

Before sending to ALSA mailing list, we had some internal discussion off line,
so I posted them to follow up.

1. One issue proposed by Srinivas Kandagatla, he proposed one use case example:
DSP1 pre-process(compress-to-pcm) the buffers, pass the fd to DSP2/audio-ip
to play pcm data. The dmabuf exporter (DSP1) is a different device than
audio device in this instance, so the DSP1 device cannot call
snd_pcm_dmabuf_export() to export one dma buffer and pass to the DSP2/audio-ip.

Our original design is, the dma buffer should be associated with one PCM
device, since different PCM devices may need different buffer types (see
SNDRV_DMA_TYPE_XXX) to play PCM data, and need consider the PCM device's
coherent capability for DMA memory. My concern is, if we let other
non-audio device to allocate one buffer and export it, how to guarantee
the dma buffer can be used by PCM device and have the same coherent capability
with the PCM device.

So I am not sure for this issue and need more suggestion to get a consensus.

2. Second question raised by Srinivas Kandagatla, he wondered:
"Am still unclear on the whole idea making a audio device dmabuf exporter
in Linux systems, unless you are sharing the dmabuf fd with other devices.

If you are working with just one device we could just live with mmap,
isn't it?"

Mark Brown gave the answer:
"The issue is permissions management. We've got a sound server that owns
all the sound hardware and needs to be able to retain administrative control
over it which means that permissions for the sound devices are locked down to
it. For performance reasons on systems where it's practical (eg, where there's
multiple audio streams the system can use to play data to the hardware) we
want to be able to have that server allow other applications with lower
permissions to stream data to/from the hardware without going through it. The
applications can't mmap() the device directly as that's too painful to do that
securely from a permission management point of view so we want to be able to
have the sound server do the mmap() then hand the mapped buffer off to the
application for it to use via a FD over a pipe. That way the only thing with
direct access to the devices is the sound server but the clients have a data
path that doesn't need to bounce through another process.

Practically speaking the only use case I can think of in an audio context is
for one reader and one writer (AIUI Android is envisioning this as one hardware
and one software), it's difficult to see how you could usefully chain multiple
in place transformations together in the way that you can with video applications
but I'm possibly not thinking of something here."
---
 include/sound/pcm.h         |    2 +
 include/sound/pcm_dmabuf.h  |   29 +++
 include/uapi/sound/asound.h |    3 +
 sound/core/Kconfig          |    4 +
 sound/core/Makefile         |    1 +
 sound/core/pcm.c            |    2 +
 sound/core/pcm_compat.c     |    3 +
 sound/core/pcm_dmabuf.c     |  531 +++++++++++++++++++++++++++++++++++++++++++
 sound/core/pcm_native.c     |   38 ++++
 9 files changed, 613 insertions(+)
 create mode 100644 include/sound/pcm_dmabuf.h
 create mode 100644 sound/core/pcm_dmabuf.c

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index c47d9b4..d353e55 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -30,6 +30,7 @@
 #include <linux/mm.h>
 #include <linux/bitops.h>
 #include <linux/pm_qos.h>
+#include <linux/dma-buf.h>
 
 #define snd_pcm_substream_chip(substream) ((substream)->private_data)
 #define snd_pcm_chip(pcm) ((pcm)->private_data)
@@ -455,6 +456,7 @@ struct snd_pcm_substream {
 	size_t buffer_bytes_max;	/* limit ring buffer size */
 	struct snd_dma_buffer dma_buffer;
 	size_t dma_max;
+	struct dma_buf_attachment *attachment;
 	/* -- hardware operations -- */
 	const struct snd_pcm_ops *ops;
 	/* -- runtime information -- */
diff --git a/include/sound/pcm_dmabuf.h b/include/sound/pcm_dmabuf.h
new file mode 100644
index 0000000..4e88c5f6
--- /dev/null
+++ b/include/sound/pcm_dmabuf.h
@@ -0,0 +1,29 @@
+#ifndef __SOUND_PCM_DMABUF_H
+#define __SOUND_PCM_DMABUF_H
+
+#include <sound/pcm.h>
+
+#ifdef CONFIG_SND_PCM_DMABUF
+int snd_pcm_dmabuf_export(struct snd_pcm_substream *substream);
+int snd_pcm_dmabuf_attach(struct snd_pcm_substream *substream, int fd);
+void snd_pcm_dmabuf_detach(struct snd_pcm_substream *substream);
+#else
+static inline int snd_pcm_dmabuf_export(struct snd_pcm_substream *substream)
+{
+	return -EBADF;
+}
+
+static inline int snd_pcm_dmabuf_attach(struct snd_pcm_substream *substream,
+					int fd)
+{
+	return -ENXIO;
+}
+
+static inline void snd_pcm_dmabuf_detach(struct snd_pcm_substream *substream)
+{
+
+}
+
+#endif
+
+#endif /* __SOUND_PCM_DMABUF_H */
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 404d4b9..4770b41 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -602,6 +602,9 @@ enum {
 #define SNDRV_PCM_IOCTL_READN_FRAMES	_IOR('A', 0x53, struct snd_xfern)
 #define SNDRV_PCM_IOCTL_LINK		_IOW('A', 0x60, int)
 #define SNDRV_PCM_IOCTL_UNLINK		_IO('A', 0x61)
+#define SNDRV_PCM_IOCTL_DMABUF_EXPORT	_IOR('A', 0x70, int)
+#define SNDRV_PCM_IOCTL_DMABUF_ATTACH	_IOW('A', 0x71, int)
+#define SNDRV_PCM_IOCTL_DMABUF_DETACH	_IO('A', 0x72)
 
 /*****************************************************************************
  *                                                                           *
diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index 63b3ef9..5ee02f2 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -184,4 +184,8 @@ config SND_DMA_SGBUF
 	def_bool y
 	depends on X86
 
+config SND_PCM_DMABUF
+	def_bool y
+	select DMA_SHARED_BUFFER
+
 source "sound/core/seq/Kconfig"
diff --git a/sound/core/Makefile b/sound/core/Makefile
index ee4a4a6..beea463 100644
--- a/sound/core/Makefile
+++ b/sound/core/Makefile
@@ -49,3 +49,4 @@ obj-$(CONFIG_SND_OSSEMUL)	+= oss/
 obj-$(CONFIG_SND_SEQUENCER)	+= seq/
 
 obj-$(CONFIG_SND_COMPRESS_OFFLOAD)	+= snd-compress.o
+obj-$(CONFIG_SND_PCM_DMABUF)	+= pcm_dmabuf.o
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 01b9d62..7781db2 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -32,6 +32,7 @@
 #include <sound/timer.h>
 #include <sound/control.h>
 #include <sound/info.h>
+#include <sound/pcm_dmabuf.h>
 
 #include "pcm_local.h"
 
@@ -890,6 +891,7 @@ static void snd_pcm_free_stream(struct snd_pcm_str * pstr)
 		substream_next = substream->next;
 		snd_pcm_timer_done(substream);
 		snd_pcm_substream_proc_done(substream);
+		snd_pcm_dmabuf_detach(substream);
 		kfree(substream);
 		substream = substream_next;
 	}
diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index 946ab08..af24489 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -687,6 +687,9 @@ static long snd_pcm_ioctl_compat(struct file *file, unsigned int cmd, unsigned l
 	case SNDRV_PCM_IOCTL_XRUN:
 	case SNDRV_PCM_IOCTL_LINK:
 	case SNDRV_PCM_IOCTL_UNLINK:
+	case SNDRV_PCM_IOCTL_DMABUF_EXPORT:
+	case SNDRV_PCM_IOCTL_DMABUF_ATTACH:
+	case SNDRV_PCM_IOCTL_DMABUF_DETACH:
 		return snd_pcm_common_ioctl(file, substream, cmd, argp);
 	case SNDRV_PCM_IOCTL_HW_REFINE32:
 		return snd_pcm_ioctl_hw_params_compat(substream, 1, argp);
diff --git a/sound/core/pcm_dmabuf.c b/sound/core/pcm_dmabuf.c
new file mode 100644
index 0000000..76211ea
--- /dev/null
+++ b/sound/core/pcm_dmabuf.c
@@ -0,0 +1,531 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright(C) 2018 Linaro Limited. All rights reserved.
+// Author: Baolin Wang <baolin.wang@linaro.org>
+
+#include <linux/export.h>
+#include <linux/dma-buf.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <linux/slab.h>
+
+struct pcm_dmabuf_attachment {
+	struct device *dev;
+	struct sg_table *sgt;
+	enum dma_data_direction dir;
+	struct list_head list;
+};
+
+struct pcm_dmabuf_object {
+	struct snd_dma_buffer *dmab;
+	struct dma_buf *dmabuf;
+	struct page **pages;
+	int pages_num;
+	struct mutex lock;
+	struct list_head attachments;
+};
+
+static int snd_pcm_map_attach(struct dma_buf *dma_buf,
+			      struct dma_buf_attachment *attach)
+{
+	struct pcm_dmabuf_attachment *pcm_attach;
+
+	pcm_attach = kzalloc(sizeof(*pcm_attach), GFP_KERNEL);
+	if (!pcm_attach)
+		return -ENOMEM;
+
+	pcm_attach->dir = DMA_NONE;
+	attach->priv = pcm_attach;
+
+	return 0;
+}
+
+static void snd_pcm_map_detach(struct dma_buf *dma_buf,
+			       struct dma_buf_attachment *attach)
+{
+	struct pcm_dmabuf_attachment *pcm_attach = attach->priv;
+	struct sg_table *sgt;
+
+	if (!pcm_attach)
+		return;
+
+	sgt = pcm_attach->sgt;
+	if (sgt) {
+		if (pcm_attach->dir != DMA_NONE)
+			dma_unmap_sg_attrs(attach->dev, sgt->sgl,
+					   sgt->nents,
+					   pcm_attach->dir,
+					   DMA_ATTR_SKIP_CPU_SYNC);
+
+		sg_free_table(sgt);
+	}
+
+	kfree(sgt);
+	kfree(pcm_attach);
+	attach->priv = NULL;
+}
+
+static struct sg_table *snd_pcm_dmabuf_to_sgt(struct pcm_dmabuf_object *obj)
+{
+	struct snd_dma_buffer *dmab = obj->dmab;
+	int type = dmab->dev.type, ret, i;
+	struct sg_table *sgt;
+	unsigned long offset;
+
+	sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
+	if (!sgt)
+		return ERR_PTR(-ENOMEM);
+
+	switch (type) {
+	case SNDRV_DMA_TYPE_CONTINUOUS:
+		offset = offset_in_page(dmab->area);
+
+		for (i = 0; i < obj->pages_num; i++) {
+			struct page *page =
+				virt_to_page(dmab->area + i * PAGE_SIZE);
+
+			obj->pages[i] = page;
+		}
+
+		ret = sg_alloc_table_from_pages(sgt, obj->pages, obj->pages_num,
+						offset, dmab->bytes, GFP_KERNEL);
+		if (ret)
+			goto error;
+
+		break;
+
+#ifdef CONFIG_GENERIC_ALLOCATOR
+	case SNDRV_DMA_TYPE_DEV_IRAM:
+#endif
+	case SNDRV_DMA_TYPE_DEV:
+	case SNDRV_DMA_TYPE_DEV_UC:
+		ret = dma_get_sgtable(dmab->dev.dev, sgt, dmab->area,
+				      dmab->addr, dmab->bytes);
+		if (ret)
+			goto error;
+
+		break;
+
+#ifdef CONFIG_SND_DMA_SGBUF
+	case SNDRV_DMA_TYPE_DEV_SG:
+	case SNDRV_DMA_TYPE_DEV_UC_SG:
+		struct snd_sg_buf *sgbuf = dmab->private_data;
+
+		obj->pages = sgbuf->page_table;
+		ret = sg_alloc_table_from_pages(sgt, obj->pages, obj->pages_num,
+						0, dmab->bytes, GFP_KERNEL);
+		if (ret)
+			goto error;
+
+		break;
+#endif
+
+	default:
+		ret = -ENXIO;
+		goto error;
+	}
+
+	return sgt;
+
+error:
+	kfree(sgt);
+	return ERR_PTR(ret);
+}
+
+static struct sg_table *snd_pcm_map_dmabuf(struct dma_buf_attachment *attach,
+					   enum dma_data_direction dir)
+{
+	struct pcm_dmabuf_attachment *pcm_attach = attach->priv;
+	struct pcm_dmabuf_object *obj = attach->dmabuf->priv;
+	struct sg_table *sgt;
+	int ret;
+
+	if (WARN_ON(dir == DMA_NONE || !pcm_attach))
+		return ERR_PTR(-EINVAL);
+
+	if (pcm_attach->dir == dir)
+		return pcm_attach->sgt;
+
+	if (WARN_ON(pcm_attach->dir != DMA_NONE))
+		return ERR_PTR(-EBUSY);
+
+	sgt = snd_pcm_dmabuf_to_sgt(obj);
+	if (IS_ERR(sgt))
+		return sgt;
+
+	ret = dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,
+			       DMA_ATTR_SKIP_CPU_SYNC);
+	if (!ret) {
+		sg_free_table(sgt);
+		kfree(sgt);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	pcm_attach->sgt = sgt;
+	pcm_attach->dir = dir;
+
+	return sgt;
+}
+
+static void snd_pcm_unmap_dmabuf(struct dma_buf_attachment *attach,
+				 struct sg_table *sgt,
+				 enum dma_data_direction dir)
+{
+	/* Nothing need to do */
+}
+
+static int snd_pcm_dmabuf_mmap(struct dma_buf *dma_buf,
+			       struct vm_area_struct *vma)
+{
+	struct pcm_dmabuf_object *obj = dma_buf->priv;
+	struct snd_dma_buffer *dmab = obj->dmab;
+	unsigned long addr = vma->vm_start;
+	unsigned long offset = vma->vm_pgoff * PAGE_SIZE;
+	int type = dmab->dev.type, ret, i;
+	struct sg_table *sgt;
+	struct scatterlist *sg;
+
+	switch (type) {
+#ifdef CONFIG_GENERIC_ALLOCATOR
+	case SNDRV_DMA_TYPE_DEV_IRAM:
+#endif
+	case SNDRV_DMA_TYPE_DEV:
+	case SNDRV_DMA_TYPE_DEV_UC:
+		return dma_mmap_coherent(dmab->dev.dev, vma,
+					 dmab->area, dmab->addr,
+					 vma->vm_end - vma->vm_start);
+
+#ifdef CONFIG_SND_DMA_SGBUF
+	case SNDRV_DMA_TYPE_DEV_SG:
+	case SNDRV_DMA_TYPE_DEV_UC_SG:
+#endif
+	case SNDRV_DMA_TYPE_CONTINUOUS:
+		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+
+		sgt = snd_pcm_dmabuf_to_sgt(obj);
+		if (IS_ERR(sgt))
+			return PTR_ERR(sgt);
+
+		for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+			struct page *page = sg_page(sg);
+			unsigned long remainder = vma->vm_end - addr;
+			unsigned long len = sg->length;
+
+			if (offset >= sg->length) {
+				offset -= sg->length;
+				continue;
+			} else if (offset) {
+				page += offset / PAGE_SIZE;
+				len = sg->length - offset;
+				offset = 0;
+			}
+
+			len = min(len, remainder);
+			ret = remap_pfn_range(vma, addr, page_to_pfn(page), len,
+					      vma->vm_page_prot);
+			if (ret)
+				return ret;
+
+			addr += len;
+			if (addr >= vma->vm_end)
+				return 0;
+		}
+
+	default:
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static void snd_pcm_dmabuf_release(struct dma_buf *dmabuf)
+{
+	struct pcm_dmabuf_object *obj = dmabuf->priv;
+
+	kfree(obj->pages);
+	kfree(obj);
+}
+
+static int snd_pcm_dmabuf_begin_cpu_access(struct dma_buf *dmabuf,
+					   enum dma_data_direction direction)
+{
+	struct pcm_dmabuf_object *obj = dmabuf->priv;
+	struct snd_dma_buffer *dmab = obj->dmab;
+	int type = dmab->dev.type;
+	struct pcm_dmabuf_attachment *pcm_attach;
+
+	switch (type) {
+#ifdef CONFIG_GENERIC_ALLOCATOR
+	case SNDRV_DMA_TYPE_DEV_IRAM:
+#endif
+	case SNDRV_DMA_TYPE_DEV:
+	case SNDRV_DMA_TYPE_DEV_UC:
+		/* Memory types are uncacheable, nothing need to do. */
+		return 0;
+
+#ifdef CONFIG_SND_DMA_SGBUF
+	case SNDRV_DMA_TYPE_DEV_SG:
+	case SNDRV_DMA_TYPE_DEV_UC_SG:
+#endif
+	case SNDRV_DMA_TYPE_CONTINUOUS:
+		mutex_lock(&obj->lock);
+
+		/*
+		 * Sync the whole DMA buffer properly in order for the CPU
+		 * to see the most up-to-date and correct copy of the DMA
+		 * buffer.
+		 */
+		list_for_each_entry(pcm_attach, &obj->attachments, list) {
+			dma_sync_sg_for_cpu(pcm_attach->dev,
+					    pcm_attach->sgt->sgl,
+					    pcm_attach->sgt->nents,
+					    direction);
+		}
+
+		mutex_unlock(&obj->lock);
+
+		break;
+
+	default:
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static int snd_pcm_dmabuf_end_cpu_access(struct dma_buf *dmabuf,
+					 enum dma_data_direction direction)
+{
+	struct pcm_dmabuf_object *obj = dmabuf->priv;
+	struct snd_dma_buffer *dmab = obj->dmab;
+	struct pcm_dmabuf_attachment *pcm_attach;
+	int type = dmab->dev.type;
+
+	switch (type) {
+#ifdef CONFIG_GENERIC_ALLOCATOR
+	case SNDRV_DMA_TYPE_DEV_IRAM:
+#endif
+	case SNDRV_DMA_TYPE_DEV:
+	case SNDRV_DMA_TYPE_DEV_UC:
+		/* Memory types are uncacheable, nothing need to do. */
+		return 0;
+
+#ifdef CONFIG_SND_DMA_SGBUF
+	case SNDRV_DMA_TYPE_DEV_SG:
+	case SNDRV_DMA_TYPE_DEV_UC_SG:
+#endif
+	case SNDRV_DMA_TYPE_CONTINUOUS:
+		mutex_lock(&obj->lock);
+
+		/*
+		 * Sync the whole DMA buffer properly in order for the devices
+		 * to see the most up-to-date and correct copy of the DMA
+		 * buffer.
+		 */
+		list_for_each_entry(pcm_attach, &obj->attachments, list) {
+			dma_sync_sg_for_device(pcm_attach->dev,
+					       pcm_attach->sgt->sgl,
+					       pcm_attach->sgt->nents,
+					       direction);
+		}
+
+		mutex_unlock(&obj->lock);
+
+		break;
+
+	default:
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static const struct dma_buf_ops snd_pcm_dmabuf_ops =  {
+	.attach = snd_pcm_map_attach,
+	.detach = snd_pcm_map_detach,
+	.map_dma_buf = snd_pcm_map_dmabuf,
+	.unmap_dma_buf = snd_pcm_unmap_dmabuf,
+	.release = snd_pcm_dmabuf_release,
+	.mmap = snd_pcm_dmabuf_mmap,
+	.begin_cpu_access = snd_pcm_dmabuf_begin_cpu_access,
+	.end_cpu_access = snd_pcm_dmabuf_end_cpu_access,
+};
+
+/**
+ * snd_pcm_dmabuf_export - export one dma buffer associated with a PCM substream
+ * @substream: PCM substream
+ *
+ * Return: a file descriptor for the given dma buffer, otherwise a negative
+ * value on error.
+ */
+int snd_pcm_dmabuf_export(struct snd_pcm_substream *substream)
+{
+	struct snd_dma_buffer *dmab = &substream->dma_buffer;
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct pcm_dmabuf_object *obj;
+	int ret;
+
+	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
+	if (!obj)
+		return -ENOMEM;
+
+	mutex_init(&obj->lock);
+	INIT_LIST_HEAD(&obj->attachments);
+	obj->dmab = dmab;
+	obj->pages_num = (dmab->bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	obj->pages = kcalloc(obj->pages_num, sizeof(obj->pages[0]), GFP_KERNEL);
+	if (!obj->pages) {
+		ret = -ENOMEM;
+		goto alloc_err;
+	}
+
+	exp_info.ops = &snd_pcm_dmabuf_ops;
+	exp_info.size = dmab->bytes;
+	exp_info.flags = O_RDWR;
+	exp_info.priv = obj;
+
+	obj->dmabuf = dma_buf_export(&exp_info);
+	if (IS_ERR(obj->dmabuf)) {
+		ret = PTR_ERR(obj->dmabuf);
+		goto export_err;
+	}
+
+	ret = dma_buf_fd(obj->dmabuf, O_CLOEXEC);
+	if (ret < 0)
+		goto fd_err;
+
+	return ret;
+
+fd_err:
+	dma_buf_put(obj->dmabuf);
+export_err:
+	kfree(obj->pages);
+alloc_err:
+	kfree(obj);
+	return ret;
+}
+EXPORT_SYMBOL(snd_pcm_dmabuf_export);
+
+/**
+ * snd_pcm_dmabuf_attach - attach one device to the dma buffer
+ * @substream: PCM substream
+ * @fd: file descriptor for the dma buffer
+ *
+ * Add one attachment to the dma buffer and map the scatterlist table of
+ * the attachment into device address space.
+ *
+ * Return: zero if attaching successfully, otherwise a negative value on error.
+ */
+int snd_pcm_dmabuf_attach(struct snd_pcm_substream *substream, int fd)
+{
+	enum dma_data_direction dir =
+		substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+		DMA_TO_DEVICE : DMA_FROM_DEVICE;
+	struct snd_card *card = substream->pcm->card;
+	struct device *dev = card->dev;
+	struct dma_buf_attachment *attachment;
+	struct pcm_dmabuf_object *obj;
+	struct pcm_dmabuf_attachment *pcm_attach;
+	struct snd_dma_buffer *dmab;
+	struct dma_buf *dmabuf;
+	struct sg_table *sgt;
+	int ret;
+
+	dmabuf = dma_buf_get(fd);
+	if (IS_ERR(dmabuf))
+		return PTR_ERR(dmabuf);
+
+	attachment = dma_buf_attach(dmabuf, dev);
+	if (IS_ERR(attachment)) {
+		ret = PTR_ERR(attachment);
+		goto err_put;
+	}
+
+	sgt = dma_buf_map_attachment(attachment, dir);
+	if (IS_ERR(sgt)) {
+		ret = PTR_ERR(sgt);
+		goto err_detach;
+	}
+
+	pcm_attach = attachment->priv;
+	pcm_attach->dev = dev;
+	INIT_LIST_HEAD(&pcm_attach->list);
+	obj = dmabuf->priv;
+	dmab = obj->dmab;
+
+	switch (dmab->dev.type) {
+	case SNDRV_DMA_TYPE_CONTINUOUS:
+		substream->runtime->dma_area = dmab->area;
+		substream->runtime->dma_addr = sg_dma_address(sgt->sgl);
+		substream->runtime->dma_bytes = dmab->bytes;
+		break;
+
+#ifdef CONFIG_GENERIC_ALLOCATOR
+	case SNDRV_DMA_TYPE_DEV_IRAM:
+#endif
+	case SNDRV_DMA_TYPE_DEV:
+	case SNDRV_DMA_TYPE_DEV_UC:
+		substream->runtime->dma_area = dmab->area;
+		substream->runtime->dma_addr = dmab->addr;
+		substream->runtime->dma_bytes = dmab->bytes;
+		break;
+
+#ifdef CONFIG_SND_DMA_SGBUF
+	case SNDRV_DMA_TYPE_DEV_SG:
+	case SNDRV_DMA_TYPE_DEV_UC_SG:
+		/* TODO: Do not support now */
+		/* fall-through */
+#endif
+
+	default:
+		ret = -ENXIO;
+		goto err_runtime_buf;
+	}
+
+	substream->attachment = attachment;
+
+	mutex_lock(&obj->lock);
+	list_add(&pcm_attach->list, &obj->attachments);
+	mutex_unlock(&obj->lock);
+
+	return 0;
+
+err_runtime_buf:
+	dma_buf_unmap_attachment(attachment, sgt, dir);
+err_detach:
+	dma_buf_detach(dmabuf, attachment);
+err_put:
+	dma_buf_put(dmabuf);
+
+	return ret;
+}
+EXPORT_SYMBOL(snd_pcm_dmabuf_attach);
+
+/**
+ * snd_pcm_dmabuf_detach - detach the given attachment from dma buffer
+ * @substream: PCM substream
+ */
+void snd_pcm_dmabuf_detach(struct snd_pcm_substream *substream)
+{
+	struct dma_buf_attachment *attachment = substream->attachment;
+	struct pcm_dmabuf_attachment *pcm_attach;
+	struct pcm_dmabuf_object *obj;
+	struct dma_buf *dmabuf;
+
+	if (!attachment)
+		return;
+
+	pcm_attach = attachment->priv;
+	dmabuf = attachment->dmabuf;
+	obj = dmabuf->priv;
+
+	mutex_lock(&obj->lock);
+	list_del(&pcm_attach->list);
+	mutex_unlock(&obj->lock);
+
+	dma_buf_unmap_attachment(attachment, pcm_attach->sgt, pcm_attach->dir);
+	dma_buf_detach(dmabuf, attachment);
+	dma_buf_put(dmabuf);
+	substream->attachment = NULL;
+}
+EXPORT_SYMBOL(snd_pcm_dmabuf_detach);
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index ac37a71..5fad8dc 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -33,6 +33,7 @@
 #include <sound/info.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/pcm_dmabuf.h>
 #include <sound/timer.h>
 #include <sound/minors.h>
 #include <linux/uio.h>
@@ -2863,6 +2864,37 @@ static int snd_pcm_forward_ioctl(struct snd_pcm_substream *substream,
 	return result < 0 ? result : 0;
 }
 
+static int snd_pcm_dmabuf_export_ioctl(struct snd_pcm_substream *substream,
+				       int __user *_fd)
+{
+	int fd;
+
+	fd = snd_pcm_dmabuf_export(substream);
+	if (fd < 0)
+		return fd;
+
+	__put_user(fd, _fd);
+	return 0;
+}
+
+static int snd_pcm_dmabuf_attach_ioctl(struct snd_pcm_substream *substream,
+				       int __user *_fd)
+{
+	int fd;
+
+	if (get_user(fd, _fd))
+		return -EFAULT;
+
+	return snd_pcm_dmabuf_attach(substream, fd);
+}
+
+static int snd_pcm_dmabuf_detach_ioctl(struct snd_pcm_substream *substream)
+{
+	snd_pcm_dmabuf_detach(substream);
+
+	return 0;
+}
+
 static int snd_pcm_common_ioctl(struct file *file,
 				 struct snd_pcm_substream *substream,
 				 unsigned int cmd, void __user *arg)
@@ -2960,6 +2992,12 @@ static int snd_pcm_common_ioctl(struct file *file,
 		return snd_pcm_rewind_ioctl(substream, arg);
 	case SNDRV_PCM_IOCTL_FORWARD:
 		return snd_pcm_forward_ioctl(substream, arg);
+	case SNDRV_PCM_IOCTL_DMABUF_EXPORT:
+		return snd_pcm_dmabuf_export_ioctl(substream, arg);
+	case SNDRV_PCM_IOCTL_DMABUF_ATTACH:
+		return snd_pcm_dmabuf_attach_ioctl(substream, arg);
+	case SNDRV_PCM_IOCTL_DMABUF_DETACH:
+		return snd_pcm_dmabuf_detach_ioctl(substream);
 	}
 	pcm_dbg(substream->pcm, "unknown ioctl = 0x%x\n", cmd);
 	return -ENOTTY;
-- 
1.7.9.5

