Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1672187-1521300523-2-10281466273758687493
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES ro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521300522; b=fWjRm/TyCF0zQdePZlvpAxccWWnmvfqklkoU2wFyexAyKEt
    Jz68C8lNvi+QiPQrxCUInslYIoZt/vbDOCj53PdgY6MYODIXGDuR4uq7n/Ioba3D
    Rh6PZ8VP1+6iQn+9n4zSXp5Ow6r3//ve+SVbQX7cOOMCLp7f6TnlPVIwj94Kpncv
    4Kdq/9FqB99CgSUzl9wpkkZsMNJT3BmWYOiegDtxQFZfhMkHDo2kxrFsPUOD6Aji
    IWPkFEf1LYR8AP2Me8jQ3Io1vlfzXWkTouYiJbxMqhg2zuxinZX+ILRZrqvnMAIx
    qXqh/hvqn3ZBRHZy6u1jG1OJ4IkRpiRcgxwAzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521300522; bh=Q
    9ATd2UC14b2oV4IV0ACjxzunZGaMa/hwFAtDcxMw5U=; b=tkN2MKBuuiV2uEHqH
    OaCOhEhybBE4lb3e/wVKe2wLZj0Me4o9QtVw5Xw18K1yQOpdurUcIwRbSnpZOyic
    OkqhluEizevwtTqhvjxTsYUu8qsDF/XHzb4/uzE8DrzxfBVbGH+HeHUQjhR6VrLu
    7rC6/9y/dzhnlq1O093pauQL4DE7g+AQVFQ5wSl7TZXcdWjNcJA80EBQZOlxm47h
    NH2Q6WmIMZCtkP2QMjVZjZSkjPSxfmXtXBo6PSirS9sm64b95vvWbqxsSpr2a/Ic
    nMOYNJ9H4Y6BfuLGKawrh6xF4itB0px3YPJtAZJ0HpvpO/qHPhxffk8D3mZ8eG7Q
    awliQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=c2IP2BN1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-75 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=H2+fQjFP;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=c2IP2BN1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-75 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=H2+fQjFP;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Google-Smtp-Source: AG47ELsxZog7nc+oj9l0zJwvEf6PsBxOwUQd4U+cpespNubF15J5foN2O4BWUqiCxQNTgw7WsmKcvQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH v1 1/5] media: staging: tegra-vde: Align bitstream size to 16K
Date: Sat, 17 Mar 2018 18:28:11 +0300
Message-Id: <8b159c6ccf8ea2e052222ffc498cc9f782ac8d49.1521300358.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1521300358.git.digetx@gmail.com>
References: <cover.1521300358.git.digetx@gmail.com>
In-Reply-To: <cover.1521300358.git.digetx@gmail.com>
References: <cover.1521300358.git.digetx@gmail.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I've noticed that decoding fails sometime if size of bitstream buffer
isn't aligned to 16K, probably because HW fetches data from memory in
a 16K granularity and if the last chunk of data isn't aligned, HW reads
garbage data beyond the dmabuf and tries to parse it.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/staging/media/tegra-vde/tegra-vde.c | 40 ++++++++++++-----------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/media/tegra-vde/tegra-vde.c b/drivers/staging/media/tegra-vde/tegra-vde.c
index c47659e96089..c2ff2071b23c 100644
--- a/drivers/staging/media/tegra-vde/tegra-vde.c
+++ b/drivers/staging/media/tegra-vde/tegra-vde.c
@@ -440,7 +440,7 @@ static int tegra_vde_setup_hw_context(struct tegra_vde *vde,
 	VDE_WR(value, vde->sxe + 0x4C);
 
 	value = 0x03800000;
-	value |= min_t(size_t, bitstream_data_size, SZ_1M);
+	value |= bitstream_data_size & GENMASK(19, 15);
 
 	VDE_WR(value, vde->sxe + 0x68);
 
@@ -522,7 +522,8 @@ static void tegra_vde_detach_and_put_dmabuf(struct dma_buf_attachment *a,
 static int tegra_vde_attach_dmabuf(struct device *dev,
 				   int fd,
 				   unsigned long offset,
-				   unsigned int min_size,
+				   size_t min_size,
+				   size_t align_size,
 				   struct dma_buf_attachment **a,
 				   dma_addr_t *addr,
 				   struct sg_table **s,
@@ -540,9 +541,16 @@ static int tegra_vde_attach_dmabuf(struct device *dev,
 		return PTR_ERR(dmabuf);
 	}
 
+	if (dmabuf->size & (align_size - 1)) {
+		dev_err(dev, "Unaligned dmabuf 0x%zX, "
+			     "should be aligned to 0x%zX\n",
+			dmabuf->size, align_size);
+		return -EINVAL;
+	}
+
 	if ((u64)offset + min_size > dmabuf->size) {
 		dev_err(dev, "Too small dmabuf size %zu @0x%lX, "
-			     "should be at least %d\n",
+			     "should be at least %zu\n",
 			dmabuf->size, offset, min_size);
 		return -EINVAL;
 	}
@@ -596,7 +604,7 @@ static int tegra_vde_attach_dmabufs_to_frame(struct device *dev,
 	int err;
 
 	err = tegra_vde_attach_dmabuf(dev, src->y_fd,
-				      src->y_offset, csize * 4,
+				      src->y_offset, csize * 4, SZ_256,
 				      &frame->y_dmabuf_attachment,
 				      &frame->y_addr,
 				      &frame->y_sgt,
@@ -605,7 +613,7 @@ static int tegra_vde_attach_dmabufs_to_frame(struct device *dev,
 		return err;
 
 	err = tegra_vde_attach_dmabuf(dev, src->cb_fd,
-				      src->cb_offset, csize,
+				      src->cb_offset, csize, SZ_256,
 				      &frame->cb_dmabuf_attachment,
 				      &frame->cb_addr,
 				      &frame->cb_sgt,
@@ -614,7 +622,7 @@ static int tegra_vde_attach_dmabufs_to_frame(struct device *dev,
 		goto err_release_y;
 
 	err = tegra_vde_attach_dmabuf(dev, src->cr_fd,
-				      src->cr_offset, csize,
+				      src->cr_offset, csize, SZ_256,
 				      &frame->cr_dmabuf_attachment,
 				      &frame->cr_addr,
 				      &frame->cr_sgt,
@@ -628,7 +636,7 @@ static int tegra_vde_attach_dmabufs_to_frame(struct device *dev,
 	}
 
 	err = tegra_vde_attach_dmabuf(dev, src->aux_fd,
-				      src->aux_offset, csize,
+				      src->aux_offset, csize, SZ_256,
 				      &frame->aux_dmabuf_attachment,
 				      &frame->aux_addr,
 				      &frame->aux_sgt,
@@ -677,21 +685,6 @@ static int tegra_vde_validate_frame(struct device *dev,
 		return -EINVAL;
 	}
 
-	if (frame->y_offset & 0xFF) {
-		dev_err(dev, "Bad y_offset 0x%X\n", frame->y_offset);
-		return -EINVAL;
-	}
-
-	if (frame->cb_offset & 0xFF) {
-		dev_err(dev, "Bad cb_offset 0x%X\n", frame->cb_offset);
-		return -EINVAL;
-	}
-
-	if (frame->cr_offset & 0xFF) {
-		dev_err(dev, "Bad cr_offset 0x%X\n", frame->cr_offset);
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
@@ -792,7 +785,8 @@ static int tegra_vde_ioctl_decode_h264(struct tegra_vde *vde,
 		return ret;
 
 	ret = tegra_vde_attach_dmabuf(dev, ctx.bitstream_data_fd,
-				      ctx.bitstream_data_offset, 0,
+				      ctx.bitstream_data_offset,
+				      SZ_16K, SZ_16K,
 				      &bitstream_data_dmabuf_attachment,
 				      &bitstream_data_addr,
 				      &bitstream_sgt,
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
