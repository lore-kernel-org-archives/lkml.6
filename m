Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1689738-1521300525-2-2981056682751976461
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roenda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521300524; b=NvZSULe3S7cQvtBxJnJI54oDitflGRS7f+DJ1zw5DgQPSyG
    EMg8EvilfPXDNzuGtDI6dzQBpkZR6LsJEHzHF5cw4f8GrB4K4UjbprN8vHqooVb1
    gS9kWHf6Jtm7CYiBmp6f1XA2T1Ro2BUGrshCp5HNMXlQlGZuHyIjLBBANRIKprGx
    IRXIATmiUgjR/U9SY6cos8X1fa29oxM6M7FHlsNRgW25tR+tD0MUirmTylokYsy1
    RzZBvBu6Uxi9GCISs0B/KNfTet6mJOrJRjMyUaDpxg5I1JFoyFnZkpDdMV6GUbHA
    p8fGKjZWSuvr1ZKSC/KH4mqastNBZxu73tUS04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521300524; bh=5
    8/q2x9/VlepiIrwB1a+XFbVKNujzC2kcMvY9NUJ+3o=; b=rB4m/7Wbu4WIdIIu1
    yb19oNvub5vLnGpmSiNPPOfH8C3khjv6SaDHeBsYsfHHtDD3o+xgibVmlaSUdVSU
    p0nCO/0998Uzi6JiuC82F6wi9bNehisEa6AUimgvfHQNEHXc+NdzllwdP7FJIuDq
    BgmMyjB8ZGgmSYcfThtnfJu1QnHTGXo9Wy9F3E4IoBxuMpaS4gELQ11sMYplkmL1
    cup7Ms0+6Pc5m2xRKSo/gVmAU24l8WDzlW2QX1SOHpL90VCem4SCw162qCaUm10b
    GoMdPfQ8LIwBhXkNP4cD9UEHbjdQ4QRj8/tswkVsYTOkdnwG2aEL/7h1K0FuhHTL
    lSUMQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OSR2W6Ao x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-75 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uedByzfM;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OSR2W6Ao x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-75 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uedByzfM;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Google-Smtp-Source: AG47ELtmZvQsgAKo690LOGHc5BdTiusUKqiXXsgUIm/BBJudq0IaUEjhY5ODE77TB8ApUnW6xHTgMw==
From: Dmitry Osipenko <digetx@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH v1 3/5] media: staging: tegra-vde: Correct minimum size of U/V
 planes
Date: Sat, 17 Mar 2018 18:28:13 +0300
Message-Id: <419bd84d9a3e098d5796a6ce74be25be5381f544.1521300358.git.digetx@gmail.com>
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

Stride of U/V planes must be aligned to 16 bytes (2 macroblocks). This
needs to be taken into account, otherwise it is possible to get a silent
memory corruption if dmabuf size is less than the size of decoded video
frame.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/staging/media/tegra-vde/tegra-vde.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/tegra-vde/tegra-vde.c b/drivers/staging/media/tegra-vde/tegra-vde.c
index 14899c887d58..94b4db55cdb5 100644
--- a/drivers/staging/media/tegra-vde/tegra-vde.c
+++ b/drivers/staging/media/tegra-vde/tegra-vde.c
@@ -602,12 +602,12 @@ static int tegra_vde_attach_dmabufs_to_frame(struct device *dev,
 					     struct tegra_vde_h264_frame *src,
 					     enum dma_data_direction dma_dir,
 					     bool baseline_profile,
-					     size_t csize)
+					     size_t lsize, size_t csize)
 {
 	int err;
 
 	err = tegra_vde_attach_dmabuf(dev, src->y_fd,
-				      src->y_offset, csize * 4, SZ_256,
+				      src->y_offset, lsize, SZ_256,
 				      &frame->y_dmabuf_attachment,
 				      &frame->y_addr,
 				      &frame->y_sgt,
@@ -773,9 +773,11 @@ static int tegra_vde_ioctl_decode_h264(struct tegra_vde *vde,
 	enum dma_data_direction dma_dir;
 	dma_addr_t bitstream_data_addr;
 	dma_addr_t bsev_ptr;
+	size_t lsize, csize;
 	size_t bitstream_data_size;
 	unsigned int macroblocks_nb;
 	unsigned int read_bytes;
+	unsigned int cstride;
 	unsigned int i;
 	long timeout;
 	int ret, err;
@@ -814,6 +816,10 @@ static int tegra_vde_ioctl_decode_h264(struct tegra_vde *vde,
 		goto free_dpb_frames;
 	}
 
+	cstride = ALIGN(ctx.pic_width_in_mbs * 8, 16);
+	csize = cstride * ctx.pic_height_in_mbs * 8;
+	lsize = macroblocks_nb * 256;
+
 	for (i = 0; i < ctx.dpb_frames_nb; i++) {
 		ret = tegra_vde_validate_frame(dev, &frames[i]);
 		if (ret)
@@ -827,7 +833,7 @@ static int tegra_vde_ioctl_decode_h264(struct tegra_vde *vde,
 		ret = tegra_vde_attach_dmabufs_to_frame(dev, &dpb_frames[i],
 							&frames[i], dma_dir,
 							ctx.baseline_profile,
-							macroblocks_nb * 64);
+							lsize, csize);
 		if (ret)
 			goto release_dpb_frames;
 	}
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
