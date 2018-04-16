Return-Path: <jrdr.linux@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523890367; cv=none;
        d=google.com; s=arc-20160816;
        b=lES9WrKXOSNoFelh612JSEZ+tsiqIgVG/bkRyhEa5aCYLMSIqeoTCefDL3YAni/lZM
         popI+uedHQm41Y24T7OAGDGJM/pL0sxdQ6A2uDYo4/38A1pPFR59l97S5dm56CeovCvs
         C77aKD7HSY8K/63KVKdI5O+AKCoU6o5zFNFvPgmd16f5Ch3B4fPhn5uY9h3TJAa3PB1L
         CAZ0cxAwQJBoxIPW7nwMBLVx3p70Nd65w8TZX9aDTa7Qx/Ckp+pmIvbUY2gHFH7bMdVZ
         Ctb7RJAM6gDNx1eb+NL6bPOxSt2ZhQY2EJwzCY+WYXrGYwPkEzg3NKpBQv+A+ACQR1jH
         sFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=5haypmvomhHW2e+KZSL7VkhPO1QdoR8820dxVMMbp68=;
        b=LPqolGnNgYAqFFPFBr6BoAjY8mUTIgtkWJky4pyjAEI9jUXSKVbw5UKSqhxpCMg6de
         072YWYNihS27i60YQ/u+1KX5wAzYoa0C/Q3e42p6GGRQTidNxWOEzSigP0ZXiFImp6Vy
         kDTBVFkPAPUUq2M2ojGX0mNGNeY6aakHz55sGq2Os7cmN99733GWy+l6zjbxKUJH4yHe
         jStadx2PztwT8nu+rW3uCpPAOcPZG3lq/wFF7BKz8jNNxYv4KDbxI/fsk8tTDlnP/ZCn
         lYR6By6DffKvr6Ih/x1Ngi/RxbR/3vpDyoQVvPWg1MhwKCCnhmFWrvlmIsikXUElJuFc
         vwZg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mm3DlKTk;
       spf=pass (google.com: domain of jrdr.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jrdr.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mm3DlKTk;
       spf=pass (google.com: domain of jrdr.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jrdr.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/On/yV76bUH1SnfNph5tWMdZudlCthOJ6unT4EA1KPu0bVuhtvQK6xDfCh+OL0Z73gKotKYw==
Date: Mon, 16 Apr 2018 20:24:40 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, willy@infradead.org
Subject: [PATCH v2] uio: Change return type to vm_fault_t
Message-ID: <20180416145440.GA26704@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597914866157448313?=
X-GMAIL-MSGID: =?utf-8?q?1597914866157448313?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use new return type vm_fault_t for fault handler
in struct vm_operations_struct. For now, this is
just documenting that the function returns a 
VM_FAULT value rather than an errno.  Once all
instances are converted, vm_fault_t will become
a distinct type.

Reference commit id->
1c8f422059ae5da07db7406ab916203f9417e396

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
v2: Modified the change log

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
