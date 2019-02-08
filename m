Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98CAC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9062A20823
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMyRio0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfBHRNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:13:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54338 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfBHRNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:13:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so4197417wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pw02RysD3yARf0G9aEsHcDFW4VSiASPNF5YAbP0ZM24=;
        b=aMyRio0wQzWbiR+AyTuJpioEIXdfpo8+3i/n5R4zaIsRYWbm9O1uCvgYDr75XR39mC
         1lTxFNDNmxtJzegSwfZfTMVXlevgyoBjW6+up3aICJrGhvWnELH/lPUbcyNKKhgvRSry
         I66BXAQgL0Sgcc9qADz/pCpCJJ+aCpzlpVpFGeiqLMvTpfrQJfRasLmE1EEl6Tz1GJyP
         iOhqICndPt7Sn4+Ehy6/ceLc7ht6Dl1E5WCuXJc3ZHwMHpsOdJiwFbxti/BXT3Wkl0Fg
         Dt/1HyPEYAX9y6h7wvozc+IlhV9a8PqODRjZubMmzeIPRRbVio95AE7yu+I8VMIQmB5c
         43aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pw02RysD3yARf0G9aEsHcDFW4VSiASPNF5YAbP0ZM24=;
        b=k1dYvPma281gpFv0P5S9Wr1AG6OcCSsFNf//OfSUs4NO8gkpnZS2C/o4Q3TZNBgKjD
         MNvNwZ5zJZvWC/obJnW8GpYb/EXKXrKCqXaidQ1fQC2KBKJP07awS4S6up6yW6t+IwNC
         BK6oDrh2Al+EL39rm5Zn/0yEc6C5GG4ftwPA1SF4EY8sqX6ta3yLRxM8UswKCGf0pY3K
         tDmTzFFdnHasLh3U3z0ns7V4w4Jdsz6oLgRR4432Qp3MIU7ww+MMQb8lT3MoXFvwP8w/
         i87M/wyHJvSSfsj4qUttZHHf3yVuEPzbCk8eRI89LvYChFWfVcGquEUAoLyv+BLJ8gjL
         WIYg==
X-Gm-Message-State: AHQUAubnYQ8t2kO2LY0YBn5Jh1puMm3ExikM2NRzKi+9VE/kGHQ3EfUr
        LHJ86CZCzh5DPgyIDauWtzFmkw==
X-Google-Smtp-Source: AHgI3IYKKOtaUJd+12ivq3E5K5E08REHHUIvApa6n3EpFT9UFduuBiKILErf1YhhLECnSOPyyDvLpA==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr2730227wmb.148.1549646012897;
        Fri, 08 Feb 2019 09:13:32 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id f139sm4521634wmd.19.2019.02.08.09.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Feb 2019 09:13:32 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Thierry Escande <thierry.escande@linaro.org>
Subject: [PATCH v7 4/5] misc: fastrpc: Add support for create remote init process
Date:   Fri,  8 Feb 2019 17:11:26 +0000
Message-Id: <20190208171127.24168-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208171127.24168-1-srinivas.kandagatla@linaro.org>
References: <20190208171127.24168-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to create or attach remote shell process.
The shell process called fastrpc_shell_0 is usually loaded on the DSP
when a user process is spawned.

Most of the work is derived from various downstream Qualcomm kernels.
Credits to various Qualcomm authors who have contributed to this code.
Specially Tharun Kumar Merugu <mtharu@codeaurora.org>

Co-developed-by: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c      | 156 ++++++++++++++++++++++++++++++++++++
 include/uapi/misc/fastrpc.h |  10 +++
 2 files changed, 166 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index cd69f8b308f6..ceb498487569 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -29,7 +29,10 @@
 #define FASTRPC_MAX_CRCLIST	64
 #define FASTRPC_PHYS(p)	((p) & 0xffffffff)
 #define FASTRPC_CTX_MAX (256)
+#define FASTRPC_INIT_HANDLE	1
 #define FASTRPC_CTXID_MASK (0xFF0)
+#define INIT_FILELEN_MAX (2 * 1024 * 1024)
+#define INIT_MEMLEN_MAX  (8 * 1024 * 1024)
 #define FASTRPC_DEVICE_NAME	"fastrpc"
 
 /* Retrives number of input buffers from the scalars parameter */
@@ -59,6 +62,14 @@
 #define FASTRPC_SCALARS(method, in, out) \
 		FASTRPC_BUILD_SCALARS(0, method, in, out, 0, 0)
 
+#define FASTRPC_CREATE_PROCESS_NARGS	6
+/* Remote Method id table */
+#define FASTRPC_RMID_INIT_ATTACH	0
+#define FASTRPC_RMID_INIT_RELEASE	1
+#define FASTRPC_RMID_INIT_CREATE	6
+#define FASTRPC_RMID_INIT_CREATE_ATTR	7
+#define FASTRPC_RMID_INIT_CREATE_STATIC	8
+
 #define miscdev_to_cctx(d) container_of(d, struct fastrpc_channel_ctx, miscdev)
 
 static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
@@ -688,6 +699,109 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	return err;
 }
 
+static int fastrpc_init_create_process(struct fastrpc_user *fl,
+					char __user *argp)
+{
+	struct fastrpc_init_create init;
+	struct fastrpc_invoke_args *args;
+	struct fastrpc_phy_page pages[1];
+	struct fastrpc_map *map = NULL;
+	struct fastrpc_buf *imem = NULL;
+	int memlen;
+	int err;
+	struct {
+		int pgid;
+		u32 namelen;
+		u32 filelen;
+		u32 pageslen;
+		u32 attrs;
+		u32 siglen;
+	} inbuf;
+	u32 sc;
+
+	args = kcalloc(FASTRPC_CREATE_PROCESS_NARGS, sizeof(*args), GFP_KERNEL);
+	if (!args)
+		return -ENOMEM;
+
+	if (copy_from_user(&init, argp, sizeof(init))) {
+		err = -EFAULT;
+		goto bail;
+	}
+
+	if (init.filelen > INIT_FILELEN_MAX) {
+		err = -EINVAL;
+		goto bail;
+	}
+
+	inbuf.pgid = fl->tgid;
+	inbuf.namelen = strlen(current->comm) + 1;
+	inbuf.filelen = init.filelen;
+	inbuf.pageslen = 1;
+	inbuf.attrs = init.attrs;
+	inbuf.siglen = init.siglen;
+	fl->pd = 1;
+
+	if (init.filelen && init.filefd) {
+		err = fastrpc_map_create(fl, init.filefd, init.filelen, &map);
+		if (err)
+			goto bail;
+	}
+
+	memlen = ALIGN(max(INIT_FILELEN_MAX, (int)init.filelen * 4),
+		       1024 * 1024);
+	err = fastrpc_buf_alloc(fl, fl->sctx->dev, memlen,
+				&imem);
+	if (err) {
+		fastrpc_map_put(map);
+		goto bail;
+	}
+
+	fl->init_mem = imem;
+	args[0].ptr = (u64)(uintptr_t)&inbuf;
+	args[0].length = sizeof(inbuf);
+	args[0].fd = -1;
+
+	args[1].ptr = (u64)(uintptr_t)current->comm;
+	args[1].length = inbuf.namelen;
+	args[1].fd = -1;
+
+	args[2].ptr = (u64) init.file;
+	args[2].length = inbuf.filelen;
+	args[2].fd = init.filefd;
+
+	pages[0].addr = imem->phys;
+	pages[0].size = imem->size;
+
+	args[3].ptr = (u64)(uintptr_t) pages;
+	args[3].length = 1 * sizeof(*pages);
+	args[3].fd = -1;
+
+	args[4].ptr = (u64)(uintptr_t)&inbuf.attrs;
+	args[4].length = sizeof(inbuf.attrs);
+	args[4].fd = -1;
+
+	args[5].ptr = (u64)(uintptr_t) &inbuf.siglen;
+	args[5].length = sizeof(inbuf.siglen);
+	args[5].fd = -1;
+
+	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE, 4, 0);
+	if (init.attrs)
+		sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_ATTR, 6, 0);
+
+	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
+				      sc, args);
+
+	if (err) {
+		fastrpc_map_put(map);
+		fastrpc_buf_free(imem);
+	}
+
+bail:
+	kfree(args);
+
+	return err;
+}
+
 static struct fastrpc_session_ctx *fastrpc_session_alloc(
 					struct fastrpc_channel_ctx *cctx)
 {
@@ -715,6 +829,23 @@ static void fastrpc_session_free(struct fastrpc_channel_ctx *cctx,
 	spin_unlock(&cctx->lock);
 }
 
+static int fastrpc_release_current_dsp_process(struct fastrpc_user *fl)
+{
+	struct fastrpc_invoke_args args[1];
+	int tgid = 0;
+	u32 sc;
+
+	tgid = fl->tgid;
+	args[0].ptr = (u64)(uintptr_t) &tgid;
+	args[0].length = sizeof(tgid);
+	args[0].fd = -1;
+	args[0].reserved = 0;
+	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_RELEASE, 1, 0);
+
+	return fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
+				       sc, &args[0]);
+}
+
 static int fastrpc_device_release(struct inode *inode, struct file *file)
 {
 	struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
@@ -722,6 +853,8 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 	struct fastrpc_invoke_ctx *ctx, *n;
 	struct fastrpc_map *map, *m;
 
+	fastrpc_release_current_dsp_process(fl);
+
 	spin_lock(&cctx->lock);
 	list_del(&fl->user);
 	spin_unlock(&cctx->lock);
@@ -773,6 +906,23 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static int fastrpc_init_attach(struct fastrpc_user *fl)
+{
+	struct fastrpc_invoke_args args[1];
+	int tgid = fl->tgid;
+	u32 sc;
+
+	args[0].ptr = (u64)(uintptr_t) &tgid;
+	args[0].length = sizeof(tgid);
+	args[0].fd = -1;
+	args[0].reserved = 0;
+	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_ATTACH, 1, 0);
+	fl->pd = 0;
+
+	return fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
+				       sc, &args[0]);
+}
+
 static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
 {
 	struct fastrpc_invoke_args *args = NULL;
@@ -814,6 +964,12 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 	case FASTRPC_IOCTL_INVOKE:
 		err = fastrpc_invoke(fl, argp);
 		break;
+	case FASTRPC_IOCTL_INIT_ATTACH:
+		err = fastrpc_init_attach(fl);
+		break;
+	case FASTRPC_IOCTL_INIT_CREATE:
+		err = fastrpc_init_create_process(fl, argp);
+		break;
 	default:
 		err = -ENOTTY;
 		break;
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index a69ef33dc37e..32d191c3b7bc 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -6,6 +6,8 @@
 #include <linux/types.h>
 
 #define FASTRPC_IOCTL_INVOKE		_IOWR('R', 3, struct fastrpc_invoke)
+#define FASTRPC_IOCTL_INIT_ATTACH	_IO('R', 4)
+#define FASTRPC_IOCTL_INIT_CREATE	_IOWR('R', 5, struct fastrpc_init_create)
 
 struct fastrpc_invoke_args {
 	__u64 ptr;
@@ -20,4 +22,12 @@ struct fastrpc_invoke {
 	__u64 args;
 };
 
+struct fastrpc_init_create {
+	__u32 filelen;	/* elf file length */
+	__s32 filefd;	/* fd for the file */
+	__u32 attrs;
+	__u32 siglen;
+	__u64 file;	/* pointer to elf file */
+};
+
 #endif /* __QCOM_FASTRPC_H__ */
-- 
2.20.1

