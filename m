Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpq0PM3n2tIo3GavmOjimlmEqGO/c1SJvdb3qcE2ZcZpxDiKAb44xvRfuqjQH1Fcrq9PFpo
ARC-Seal: i=1; a=rsa-sha256; t=1525116522; cv=none;
        d=google.com; s=arc-20160816;
        b=kL3ahPUDz3nTW7qMnve79bOJmRwYL1i9k/5ewjFIuTCA58i+Cauu+dG8NXh5zSXNwc
         rbf7Ug7tQrY6wKo8xTvMbEfCZiuANtPXzRk2jlX68YWCRMSvl+qxBkAURwvnB6Jd4znr
         i9Evd7jC4u5/Q6tBFVLLFoaSttp4Sp+bolNMSpl8EPZGQ3FzYDlD2TydeDseQldsWYnO
         8Llm5itX9k74WacbqxJlGBBMU1gishlqzyRDDXisRnMXua6Y4Nc3N+oZCz0p0eIro4zV
         e4JAC4s6EPDDp7d7szy3Ehwklbk6TWTqYG+3QH5fMbBOFtoStGjSlzVE1GOhBwqHlN7I
         ZjnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=1qEeDy2e5ChIQpRC3i6vcidxMREGtY14WuqOhN8r2mg=;
        b=vYitDRNcp32gOSupeCNomshoScFYl7DJH0IBI22jTwL9sniL15mr80++G0Kn1Qot1v
         BaWJpo3L+LcHEqOwLTWoSymJh+4/symY2rs+Bo9CtCY+Ng64sZW2pWQqzLkw3pkD4j/s
         T1Ya5h1tofyizbKEaEM6byKSH4TrL+sbpvShP6iSNjjEfTSLvxQ/9z5rOBtXFQOXWNHn
         4R/vevUWEL4HzxIce2piZHZDFyNzlxsR9JOtgjFSUpREEUG6EoH1pkLIBu9txSmYSPZH
         5Yrh8VsUF2nJ9NymcSPkIeXwqET90iwlIMFLxMWjsHiV0fsQz3b6jZ/uyQ/LVjwJC2AA
         tsZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69FB922DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4.16 090/113] virt: vbox: Move declarations of vboxguest private functions to private header
Date: Mon, 30 Apr 2018 12:25:01 -0700
Message-Id: <20180430184019.004128899@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200582849058208?=
X-GMAIL-MSGID: =?utf-8?q?1599200582849058208?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 02cfde67df1f440c7c3c7038cc97992afb81804f upstream.

Move the declarations of functions from vboxguest_utils.c which are only
meant for vboxguest internal use from include/linux/vbox_utils.h to
drivers/virt/vboxguest/vboxguest_core.h.

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/virt/vboxguest/vboxguest_core.h |    8 ++++++++
 include/linux/vbox_utils.h              |   23 -----------------------
 2 files changed, 8 insertions(+), 23 deletions(-)

--- a/drivers/virt/vboxguest/vboxguest_core.h
+++ b/drivers/virt/vboxguest/vboxguest_core.h
@@ -171,4 +171,12 @@ irqreturn_t vbg_core_isr(int irq, void *
 
 void vbg_linux_mouse_event(struct vbg_dev *gdev);
 
+/* Private (non exported) functions form vboxguest_utils.c */
+void *vbg_req_alloc(size_t len, enum vmmdev_request_type req_type);
+int vbg_req_perform(struct vbg_dev *gdev, void *req);
+int vbg_hgcm_call32(
+	struct vbg_dev *gdev, u32 client_id, u32 function, u32 timeout_ms,
+	struct vmmdev_hgcm_function_parameter32 *parm32, u32 parm_count,
+	int *vbox_status);
+
 #endif
--- a/include/linux/vbox_utils.h
+++ b/include/linux/vbox_utils.h
@@ -24,24 +24,6 @@ __printf(1, 2) void vbg_debug(const char
 #define vbg_debug pr_debug
 #endif
 
-/**
- * Allocate memory for generic request and initialize the request header.
- *
- * Return: the allocated memory
- * @len:		Size of memory block required for the request.
- * @req_type:		The generic request type.
- */
-void *vbg_req_alloc(size_t len, enum vmmdev_request_type req_type);
-
-/**
- * Perform a generic request.
- *
- * Return: VBox status code
- * @gdev:		The Guest extension device.
- * @req:		Pointer to the request structure.
- */
-int vbg_req_perform(struct vbg_dev *gdev, void *req);
-
 int vbg_hgcm_connect(struct vbg_dev *gdev,
 		     struct vmmdev_hgcm_service_location *loc,
 		     u32 *client_id, int *vbox_status);
@@ -52,11 +34,6 @@ int vbg_hgcm_call(struct vbg_dev *gdev,
 		  u32 timeout_ms, struct vmmdev_hgcm_function_parameter *parms,
 		  u32 parm_count, int *vbox_status);
 
-int vbg_hgcm_call32(
-	struct vbg_dev *gdev, u32 client_id, u32 function, u32 timeout_ms,
-	struct vmmdev_hgcm_function_parameter32 *parm32, u32 parm_count,
-	int *vbox_status);
-
 /**
  * Convert a VirtualBox status code to a standard Linux kernel return value.
  * Return: 0 or negative errno value.
