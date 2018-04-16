Return-Path: <jrdr.linux@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523903524; cv=none;
        d=google.com; s=arc-20160816;
        b=PRMNFNNd6d8W+iBm7tuFh5qUrXq6F4zPzdr3re4OIR/xvG+1llSInmRzMSYRpI6x9+
         v4LkXSBoF0i+YW3vNssWYmsmjw1KeUK8o0Q7Ozq7ULo8V3BX+L/jFXB1bWwPw4DFxYG+
         CzBgI1wMoEBIH8A6R/NYbtb9ScYXTYgAN6xpy5f/6A9Ntz79+OOn9RbhRjy3t7uZ1jWw
         6sgPCN3eHCRZ9geWfsx8lXh1FT41vCdxRAJBBhilhm9nsS0V4vOpa7EeekNMyPMnzjfM
         Jx0T7PXMGD0ctugdXDSTY4IzH4c59cVJZXh0mHXcROTnJiXFTiP9Md7gLAHPxks8f7J/
         jwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=O4rqui448Xkf8B8oXDerzupuA6ujoq24RAQehdffvdE=;
        b=S4cuz0Adw8/ofAo3FgqZO6X0HIOzUhukDmGmoU5DOnravSVpOsRzVVsJ9MsbtUV7DB
         7EXhit/XZLj/CcgJ53sjwaBYnTyEQcIRvwW9dgFpNp9absQIgJd3wftvZmE6pqSP5P3M
         NVJO2aIeZbpqgWJMd/wApuuebsCn81YHJYs3kXpXQDVNayKBysBrNW107hC1wvnHmq87
         xYDhlav5G+s0uvbD2PpUK6TtkKDk+w5o6PNsio41BOqxqFrzOuOTCnL8wAkD1Xzm9bcn
         LFvbfFSiqekueM/VV7ibBJGhg3ZCrR+lVTpeR4r5Wl5bi78tFU4uvKJ1gmhGIyQRXXov
         kYTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Qkds783U;
       spf=pass (google.com: domain of jrdr.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jrdr.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Qkds783U;
       spf=pass (google.com: domain of jrdr.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jrdr.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49NxtbPMzFXzh0hl2DdYH8QWeIc9asf+CtsvqHif9us3Z6j1d/b1+4DVgexADhJjYoyKasIDw==
Date: Tue, 17 Apr 2018 00:03:55 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, willy@infradead.org
Subject: [PATCH v3] uio: Change return type to vm_fault_t
Message-ID: <20180416183355.GA29292@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597914866157448313?=
X-GMAIL-MSGID: =?utf-8?q?1597928662365021949?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use new return type vm_fault_t for fault handler
in struct vm_operations_struct. For now, this is
just documenting that the function returns a VM_
FAULT value rather than an errno.  Once all inst
ances are converted, vm_fault_t will become a di
stinct type.

Reference - 1c8f422059ae ("mm: change return type
to vm_fault_t")

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
v2: Modified the change log

v3: Updated the change log

 drivers/uio/uio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index fd48483..d9235f3 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -597,7 +597,7 @@ static int uio_find_mem_index(struct vm_area_struct *vma)
 	return -1;
 }

-static int uio_vma_fault(struct vm_fault *vmf)
+static vm_fault_t uio_vma_fault(struct vm_fault *vmf)
 {
 	struct uio_device *idev = vmf->vma->vm_private_data;
 	struct page *page;
--
1.9.1
