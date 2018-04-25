Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbeDYESf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 00:18:35 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41161 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbeDYESe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 00:18:34 -0400
X-Google-Smtp-Source: AIpwx48qM+mrCP51OSgzxCLLhGGnZ5VPUSmBiAKAqJ7cP4COpS/TkkCBHBgaYH9f88eWKNUszdUe0Q==
Date: Wed, 25 Apr 2018 09:50:29 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: perex@perex.cz, tiwai@suse.com, o-takashi@sakamocchi.jp
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: core: Change return type to vm_fault_t
Message-ID: <20180425042029.GA21407@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler. For
now, this is just documenting that the function returns
a VM_FAULT value rather than an errno. Once all instances
are converted, vm_fault_t will become a distinct type.

Commit 1c8f422059ae ("mm: change return type to vm_fault_t")

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 sound/core/pcm_native.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 77ba50d..2d331f4 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3229,7 +3229,7 @@ static __poll_t snd_pcm_capture_poll(struct file *file, poll_table * wait)
 /*
  * mmap status record
  */
-static int snd_pcm_mmap_status_fault(struct vm_fault *vmf)
+static vm_fault_t snd_pcm_mmap_status_fault(struct vm_fault *vmf)
 {
 	struct snd_pcm_substream *substream = vmf->vma->vm_private_data;
 	struct snd_pcm_runtime *runtime;
@@ -3265,7 +3265,7 @@ static int snd_pcm_mmap_status(struct snd_pcm_substream *substream, struct file
 /*
  * mmap control record
  */
-static int snd_pcm_mmap_control_fault(struct vm_fault *vmf)
+static vm_fault_t snd_pcm_mmap_control_fault(struct vm_fault *vmf)
 {
 	struct snd_pcm_substream *substream = vmf->vma->vm_private_data;
 	struct snd_pcm_runtime *runtime;
@@ -3354,7 +3354,7 @@ static int snd_pcm_mmap_control(struct snd_pcm_substream *substream, struct file
 /*
  * fault callback for mmapping a RAM page
  */
-static int snd_pcm_mmap_data_fault(struct vm_fault *vmf)
+static vm_fault_t snd_pcm_mmap_data_fault(struct vm_fault *vmf)
 {
 	struct snd_pcm_substream *substream = vmf->vma->vm_private_data;
 	struct snd_pcm_runtime *runtime;
--
1.9.1
