Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32340C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE671206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="br3FnU4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfANTmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:42:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54177 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfANTmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:42:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so868343wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 11:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TGWMRgUa84leIvqNdPnLVf/SH/izWExH3OfySwLQBtc=;
        b=br3FnU4Gy9vKFnmadRUEn+ySuQhx1TLmNcHsX9lSmXToW/fCrcIrVDXVFEAYbDhyc2
         onw56Vm7miEoRIvEOQeNDetPuihdNj+CgULgPGEGBbu2rrbjTOa0XsCiXtM/nHkOLSoc
         WpaKqOYufCBH6wC578d9ZADwvKK30aNXFbfOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TGWMRgUa84leIvqNdPnLVf/SH/izWExH3OfySwLQBtc=;
        b=VurHGRzS/M/Os7qm+m8m/N/JZOrhPCJjVqSbW4/JJckBlsAmlRwbAXS8aDcLily2jI
         Fs7lS/GcwvJPWdtbs/M1sUZPHE3i3lngJGRQIk2aD46D0GkR8BvGXbfehf6rAh1h5QFI
         8NSq9M1BQA4gWK/QrYFR5Qlxi0eokX6YNF1cdG/BQnRgKHJasN5CWJKF4UBWZfhLwNUA
         84gvGixko8uh+WcJhvc07FCGqCvsqJb2BHVwcDatPDym9IVE+d1ZM9S4jy/ZN8/prada
         O+19DXqSeEEA4NY0XkzVjwpQdO4psasAuSrUpDWxXqosmgkoWeliyDOk/J0gM/0L4Av2
         Y/xw==
X-Gm-Message-State: AJcUukd0AAvf48IwT10HNYJMDSb0HtPzygDikItGkcNwm/+IKIr2RROA
        uLVTShrSuppOrJ3JpDXykSTR7w==
X-Google-Smtp-Source: ALg8bN4Tuo1ekr0zIqSOTVlSC+7ZcwSzSJmWGC+DkfDNrJKiuBhDHykmlBVKGocU6IsWDs5RLHADnQ==
X-Received: by 2002:a1c:2902:: with SMTP id p2mr529173wmp.19.1547494939238;
        Mon, 14 Jan 2019 11:42:19 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id b7sm66779996wrs.47.2019.01.14.11.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jan 2019 11:42:18 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        thierry.escande@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 4/5] misc: fastrpc: Add support for create remote init process
Date:   Mon, 14 Jan 2019 19:41:11 +0000
Message-Id: <20190114194112.32567-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114194112.32567-1-srinivas.kandagatla@linaro.org>
References: <20190114194112.32567-1-srinivas.kandagatla@linaro.org>
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
 drivers/misc/fastrpc.c      | 141 +++++++++++++++++++++++++++++++++++-
 include/uapi/misc/fastrpc.h |  10 +++
 2 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 6745e164ef12..c93960b5f3a5 100644
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
@@ -60,6 +63,13 @@
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
@@ -667,7 +677,96 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		fastrpc_context_free(ctx);
 
 	if (err)
-		dev_err(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
+		dev_dbg(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
+
+	return err;
+}
+
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
+			goto bail;
+	}
+
+	memlen = ALIGN(max(INIT_FILELEN_MAX, (int)init.filelen * 4),
+		       1024 * 1024);
+	err = fastrpc_buf_alloc(fl, fl->sctx->dev, memlen,
+				&imem);
+	if (err)
+		goto bail;
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
+bail:
+	if (map)
+		fastrpc_map_put(map);
 
 	return err;
 }
@@ -701,6 +800,22 @@ static void fastrpc_session_free(struct fastrpc_channel_ctx *cctx,
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
@@ -708,6 +823,8 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 	struct fastrpc_invoke_ctx *ctx, *n;
 	struct fastrpc_map *map, *m;
 
+	fastrpc_release_current_dsp_process(fl);
+
 	spin_lock(&cctx->lock);
 	list_del(&fl->user);
 	spin_unlock(&cctx->lock);
@@ -755,6 +872,22 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
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
@@ -795,6 +928,12 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
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
 		dev_err(fl->sctx->dev, "bad ioctl: %d\n", cmd);
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

