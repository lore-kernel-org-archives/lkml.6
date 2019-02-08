Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BE4C282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754D720811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yXhDYaDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfBHNXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:23:52 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53936 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfBHNX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:23:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so3409332wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 05:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+SQhU1V1D620CVCjZHrb7KLia31Hms3wHUfzwu8SezU=;
        b=yXhDYaDgS1glmOfJRdZDw1iWizeTevZJa+N07TQCz536cP/L3Iid3HmoHroot8taaH
         wEwXfnKV+HELeozk7IdbC4uVSFem19SFuiIUCa0LBul/EYAiomZqfTBsSwJ/BI982khe
         qLIl3/T8kCSqVWKPPLHkYIofy+j7m4yYcgKu0nNF6EJVy2DNhDbKUa2y1htNsex9Top3
         KUrtfILLC9TgbsHDK5zHxQ1cWW41baymE/xCsN4B50JpEpNW5vrnE+TQDyPa89EoMTVW
         XPcBvqz0QAzPQ4+y9NsIrUYkBf6892gruktdZWmO+dt4owNgf4fmjIvS3jRINjzrpCTp
         pB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+SQhU1V1D620CVCjZHrb7KLia31Hms3wHUfzwu8SezU=;
        b=mUfTQ+bP1LB9VYE8QRcMnZpVoVzTAnt2R58nrF06dnvXEzddAHMxk0JB7q/cWPd8CX
         7+5b3wUq8mMQBWno6Si/EiJs4QHNGdy+SqY4Mu8+pZDgljxR+aBstZZuGACX0dnEdlMt
         sf3SpQ6M0zbqGbI37ql2UWEViy1KKPuTMSAFlHzfix7ED8IpLQ2U9kMB03q/VaGomI78
         v35uVRpTdQxSU5PxSpAdZ06XWPBIY6/iWRphfyCmAT2e+dgcxQjIUn+jneY7XbDgGyvr
         1ju3EJ4m7ccFqxSxK+JF6m9IcZEsdFPzi3a2iA1iN0dVBVvJxMLu8+tEB2D4v+isA5N0
         QNIw==
X-Gm-Message-State: AHQUAuYxiDf6bSCcVqoApBczNo3m//BJg1Am3N/IdWw5FcsQHT7VCAQ9
        JvwfAXlO+9f4wtMOPqyrX0FOAQ==
X-Google-Smtp-Source: AHgI3IY0ZwCQDqc7pXxemY6zwIRTDJ9KXcGdyn7zuxZpVkx6FE3ogzgLwsiMOEXC4Dw7ztTmJd00+g==
X-Received: by 2002:a1c:2d4b:: with SMTP id t72mr10707566wmt.99.1549632207202;
        Fri, 08 Feb 2019 05:23:27 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id m21sm3033007wmi.43.2019.02.08.05.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Feb 2019 05:23:26 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Thierry Escande <thierry.escande@linaro.org>
Subject: [PATCH v6 4/5] misc: fastrpc: Add support for create remote init process
Date:   Fri,  8 Feb 2019 13:23:05 +0000
Message-Id: <20190208132306.12571-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208132306.12571-1-srinivas.kandagatla@linaro.org>
References: <20190208132306.12571-1-srinivas.kandagatla@linaro.org>
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
 drivers/misc/fastrpc.c      | 142 ++++++++++++++++++++++++++++++++++++
 include/uapi/misc/fastrpc.h |  10 +++
 2 files changed, 152 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 35035c0bb4fb..ddd9fa9b238e 100644
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
@@ -61,6 +64,13 @@
 #define FASTRPC_SCALARS(method, in, out) \
 		FASTRPC_BUILD_SCALARS(0, method, in, out, 0, 0)
 
+/* Remote Method id table */
+#define FASTRPC_RMID_INIT_ATTACH	0
+#define FASTRPC_RMID_INIT_RELEASE	1
+#define FASTRPC_RMID_INIT_CREATE	6
+#define FASTRPC_RMID_INIT_CREATE_ATTR	7
+#define FASTRPC_RMID_INIT_CREATE_STATIC	8
+
 #define miscdev_to_cctx(d) container_of(d, struct fastrpc_channel_ctx, miscdev)
 
 static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
@@ -688,6 +698,98 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	return err;
 }
 
+static int fastrpc_init_create_process(struct fastrpc_user *fl,
+					char __user *argp)
+{
+	struct fastrpc_init_create init;
+	struct fastrpc_invoke_args args[6];
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
+	if (copy_from_user(&init, argp, sizeof(init)))
+		return -EFAULT;
+
+	if (init.filelen > INIT_FILELEN_MAX)
+		return -EINVAL;
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
+			return err;
+	}
+
+	memlen = ALIGN(max(INIT_FILELEN_MAX, (int)init.filelen * 4),
+		       1024 * 1024);
+	err = fastrpc_buf_alloc(fl, fl->sctx->dev, memlen,
+				&imem);
+	if (err) {
+		fastrpc_map_put(map);
+		return err;
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
+				      sc, &args[0]);
+
+	if (err) {
+		fastrpc_map_put(map);
+		fastrpc_buf_free(imem);
+	}
+
+	return err;
+}
+
 static struct fastrpc_session_ctx *fastrpc_session_alloc(
 					struct fastrpc_channel_ctx *cctx)
 {
@@ -715,6 +817,22 @@ static void fastrpc_session_free(struct fastrpc_channel_ctx *cctx,
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
+	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_RELEASE, 1, 0);
+
+	return fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
+				       sc, &args[0]);
+}
+
 static int fastrpc_device_release(struct inode *inode, struct file *file)
 {
 	struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
@@ -722,6 +840,8 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 	struct fastrpc_invoke_ctx *ctx, *n;
 	struct fastrpc_map *map, *m;
 
+	fastrpc_release_current_dsp_process(fl);
+
 	spin_lock(&cctx->lock);
 	list_del(&fl->user);
 	spin_unlock(&cctx->lock);
@@ -773,6 +893,22 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
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
@@ -823,6 +959,12 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
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

