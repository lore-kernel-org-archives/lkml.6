Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751139AbeDYEMz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 00:12:55 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42042 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeDYEMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 00:12:50 -0400
X-Google-Smtp-Source: AIpwx4/YTAiQqTPMHBHtaWUVuvINtDKUH1yO+vV6btVfbmGUAy/XAAMZXYN5O2X01ETy09CFa0AM5g==
Date: Wed, 25 Apr 2018 09:44:45 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: perex@perex.cz, tiwai@suse.com, viro@zeniv.linux.org.uk,
        johan@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: usb: usx2y: Change return type to vm_fault_t
Message-ID: <20180425041445.GA21283@jordon-HP-15-Notebook-PC>
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
 sound/usb/usx2y/us122l.c        | 2 +-
 sound/usb/usx2y/usX2Yhwdep.c    | 2 +-
 sound/usb/usx2y/usx2yhwdeppcm.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index ebcab5c..8082f7b 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -139,7 +139,7 @@ static void usb_stream_hwdep_vm_open(struct vm_area_struct *area)
 	snd_printdd(KERN_DEBUG "%i\n", atomic_read(&us122l->mmap_count));
 }

-static int usb_stream_hwdep_vm_fault(struct vm_fault *vmf)
+static vm_fault_t usb_stream_hwdep_vm_fault(struct vm_fault *vmf)
 {
 	unsigned long offset;
 	struct page *page;
diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index d8bd7c9..c1dd9a7 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -31,7 +31,7 @@
 #include "usbusx2y.h"
 #include "usX2Yhwdep.h"

-static int snd_us428ctls_vm_fault(struct vm_fault *vmf)
+static vm_fault_t snd_us428ctls_vm_fault(struct vm_fault *vmf)
 {
 	unsigned long offset;
 	struct page * page;
diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c b/sound/usb/usx2y/usx2yhwdeppcm.c
index 0d05052..4fd9276 100644
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -652,7 +652,7 @@ static void snd_usX2Y_hwdep_pcm_vm_close(struct vm_area_struct *area)
 }


-static int snd_usX2Y_hwdep_pcm_vm_fault(struct vm_fault *vmf)
+static vm_fault_t snd_usX2Y_hwdep_pcm_vm_fault(struct vm_fault *vmf)
 {
 	unsigned long offset;
 	void *vaddr;
--
1.9.1
