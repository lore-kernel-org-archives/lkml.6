Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E912C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD00222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVmHLMAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439160AbfBNOXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:23:35 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40312 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407233AbfBNOXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:23:32 -0500
Received: by mail-lj1-f193.google.com with SMTP id w6so620372ljd.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M2KaFgmEMxaJMx4FSDSsegncmhuMa0Qmr/kERv623g4=;
        b=lVmHLMARwa2H11UHIQyyCJ4xmznLqt61RBkOVVLc3L5cWJg4heCc6SRNcHTTGYPWKU
         l+VeL9Z8F157YudzKfbGeq4RZgLAOa9yf86fMWqlMBDdB4OKIfY/gZtIURNmy8cpUBsu
         ld0bMMMYoJT8CsPnTGUl6FAXFgw1A8jn4gALLdzk8x2H2AXi5eN3MevbGCw8Fk0Ie+Q3
         Bnzuzab+MxDWRnEZnnFYtUkrJQAaYzBAYBt73wHIAVcD3zmUoK2RQRMNi9vxsrS/+PMA
         NuARG/y3ovGyZF0cq3XGwj47IvIwY/9Jnl1Lmqd0+6OJEy4Vm14cdZ4KtGgex2fYsP9v
         vxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M2KaFgmEMxaJMx4FSDSsegncmhuMa0Qmr/kERv623g4=;
        b=Yid7eob5rdxGYJoVftGjvXPb8k4mOuwQxxzQzA7f02HN469iMMcSVm302bif0b6aoF
         iSLcZ11apk0HO6wE3D0Vd7yVtPAtRqg02Cp9LPLn2/FPaDKt9HNyHvXgsI1pC4x93A68
         qa5TrOhZaqTByMKrJ8KjCY7B84pBxJRwcH2OT3Mc5yVvFLT216kKy0LkGY7DSYuVX9S7
         vl5NKvn03CD5pthU0D6xfa11HLOletwL3se4F2hJqk93mkmncAClEY4VCxWA7i9BNdF3
         Gf54QqncMP6GR51QRUqZEK/elC9F3mvbny0CMOvqzYfgnyMiShfRXM6dJ3k6F9DrE7U3
         w50w==
X-Gm-Message-State: AHQUAuah5Kg1Tt1pKHMNQMbix+Y6xl0md89DK+LwLJwqD7/EfHGiw831
        pwOStK27fvGRPfCvwMUKIYNetWae
X-Google-Smtp-Source: AHgI3IaUVi5USYEg7fZiMFe+RbT61bPbpzdMHBnJOn+lwi3fM8NkigmRKrxH1OGkC5Unx+KXNoVbeQ==
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr2611359ljj.30.1550154210249;
        Thu, 14 Feb 2019 06:23:30 -0800 (PST)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id j27sm481078lfh.93.2019.02.14.06.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Feb 2019 06:23:29 -0800 (PST)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com
Cc:     andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [Xen-devel][PATCH 2/2] xen/gntdev: Check and release imported dma-bufs on close
Date:   Thu, 14 Feb 2019 16:23:21 +0200
Message-Id: <20190214142321.1138-2-andr2000@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214142321.1138-1-andr2000@gmail.com>
References: <20190214142321.1138-1-andr2000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Check if there are any imported dma-bufs left not released by
user-space when grant device's release callback is called and
free those if this is the case. This can happen if user-space
leaks the buffers because of a bug or application has been
terminated for any reason.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/xen/gntdev-dmabuf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index d97fcfc5e558..2c4f324f8626 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -745,6 +745,14 @@ static int dmabuf_imp_release(struct gntdev_dmabuf_priv *priv, u32 fd)
 	return 0;
 }
 
+static void dmabuf_imp_release_all(struct gntdev_dmabuf_priv *priv)
+{
+	struct gntdev_dmabuf *q, *gntdev_dmabuf;
+
+	list_for_each_entry_safe(gntdev_dmabuf, q, &priv->imp_list, next)
+		dmabuf_imp_release(priv, gntdev_dmabuf->fd);
+}
+
 /* DMA buffer IOCTL support. */
 
 long gntdev_ioctl_dmabuf_exp_from_refs(struct gntdev_priv *priv, int use_ptemod,
@@ -862,5 +870,6 @@ struct gntdev_dmabuf_priv *gntdev_dmabuf_init(struct file *filp)
 
 void gntdev_dmabuf_fini(struct gntdev_dmabuf_priv *priv)
 {
+	dmabuf_imp_release_all(priv);
 	kfree(priv);
 }
-- 
2.20.1

