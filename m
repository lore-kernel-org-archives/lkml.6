Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1672187-1521300523-5-10426283691578470165
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521300523; b=Wbv6dK6ZKzXalnDsunEsW/kS2fFehIxQhyjXdvD1gVL6vTU
    Rhdvk3cq5afyPOML6arjyQWFZOl5+OGLprYUDPYZFII8FmCQM97thsJBf2SkVv+u
    pxyuPWFhzfHSOuDutQDqu5pUSO9wb5hvnZdy12emPZICJxtFlJLrOzKJkvax4Gp7
    PM8oAnKwYPgVoaQCxqK7rcDz7fDVZdm6T6dHHcxMT397YoTkSvah7pCsI+iLxuqs
    iR75bL5UpeCG4PC/zwC9bZQGQVuehYHAQ6fkIpu3zafHelmaHs2PEtKkQAMv8OEy
    nmnRsMoRUzdtPxDSGlXUqNJWi2LaV6CrzADOeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521300523; bh=p
    KqYR1xqzrXC1MSfoD2hDA3S6fa/4ze3PRezzMFc8M8=; b=JX5DS605FXVDxQZ0V
    nfKuni2NEYxttKor6+JsUwp1rmpwPBENJNyFdj1hgnh4+jzPQ0Kv7WgYXe3YR5y0
    kVdPoZjQpw8HNH0KUFBB/k0KJ/P9t50sj/VLwFFYPBtSaUeJdYN/jbIZO/gh/qGY
    wwuFlla4poi16/g7wryElUC85l06M99k6R0U5ZjlPNDu1/dYHIogow5uMK9pEi01
    2y7y9n4su5ukAysZK5Gk5og65vqnisCwC4sGB2/2gOw6rOax32f9Jn7mz6Nk5X3l
    SBFprz48EzazsKINGYeFqZ4bXjJn7Npy2cnqhmPL5cioHHN7de59hpRHYyFskp8h
    u89bw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=u998PTCJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-75 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HRnCFRv2;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=u998PTCJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-75 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HRnCFRv2;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Google-Smtp-Source: AG47ELsglqxCLTDjalkRSP3ND7l9lu3J7fQ3g8s4QSJMrQp9N2LY/Fe2FO18eIeyasbEDdnG7AWUaQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH v1 2/5] media: staging: tegra-vde: Silence some of checkpatch
 warnings
Date: Sat, 17 Mar 2018 18:28:12 +0300
Message-Id: <9ec5460f88ac716d84cc626aa9e8d0a3c2e6acf3.1521300358.git.digetx@gmail.com>
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

Make all strings single line to make them grep'able and add a comment
to the memory barrier.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/staging/media/tegra-vde/tegra-vde.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/tegra-vde/tegra-vde.c b/drivers/staging/media/tegra-vde/tegra-vde.c
index c2ff2071b23c..14899c887d58 100644
--- a/drivers/staging/media/tegra-vde/tegra-vde.c
+++ b/drivers/staging/media/tegra-vde/tegra-vde.c
@@ -368,6 +368,11 @@ static int tegra_vde_setup_hw_context(struct tegra_vde *vde,
 	tegra_vde_setup_iram_tables(vde, dpb_frames,
 				    ctx->dpb_frames_nb - 1,
 				    ctx->dpb_ref_frames_with_earlier_poc_nb);
+
+	/*
+	 * The IRAM mapping is write-combine, ensure that CPU buffers have
+	 * been flushed at this point.
+	 */
 	wmb();
 
 	VDE_WR(0x00000000, vde->bsev + 0x8C);
@@ -542,15 +547,13 @@ static int tegra_vde_attach_dmabuf(struct device *dev,
 	}
 
 	if (dmabuf->size & (align_size - 1)) {
-		dev_err(dev, "Unaligned dmabuf 0x%zX, "
-			     "should be aligned to 0x%zX\n",
+		dev_err(dev, "Unaligned dmabuf 0x%zX, should be aligned to 0x%zX\n",
 			dmabuf->size, align_size);
 		return -EINVAL;
 	}
 
 	if ((u64)offset + min_size > dmabuf->size) {
-		dev_err(dev, "Too small dmabuf size %zu @0x%lX, "
-			     "should be at least %zu\n",
+		dev_err(dev, "Too small dmabuf size %zu @0x%lX, should be at least %zu\n",
 			dmabuf->size, offset, min_size);
 		return -EINVAL;
 	}
@@ -863,8 +866,7 @@ static int tegra_vde_ioctl_decode_h264(struct tegra_vde *vde,
 		macroblocks_nb = readl_relaxed(vde->sxe + 0xC8) & 0x1FFF;
 		read_bytes = bsev_ptr ? bsev_ptr - bitstream_data_addr : 0;
 
-		dev_err(dev, "Decoding failed: "
-				"read 0x%X bytes, %u macroblocks parsed\n",
+		dev_err(dev, "Decoding failed: read 0x%X bytes, %u macroblocks parsed\n",
 			read_bytes, macroblocks_nb);
 
 		ret = -EIO;
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
