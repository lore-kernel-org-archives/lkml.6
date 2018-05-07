Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4087485-1525655622-2-3266641133777060649
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525655622; b=CeLLFeLGZVjYQMYr0MOTFlsiZ3AzgWrQJm4a5GKLEZurSC+h8J
    mbZVWYOfvCIbupyR2Ld7hBkIY8MJilan4GX7SkoA2567qf+xN+mWdGAmhMlM/8W2
    /0vySiRS0FiNkwFT972SWtvGmc6+1oLBA4PrZtK4/IhyN31pFm5LvhhoMPvDUgtF
    kAk7e65NKyPK6QGJC8PNsXe2ch66XdnL7IetKC9oojfH5CPdNuaAMjVQ7E+xOGi+
    CN8oN6lQ5dHTICNN1j2RsClsf+uX7HQImIZ99yjR3+hU0g6iHkTeYyOjcmmwt9cG
    wge+W0ISbyC4UkHh2JGma+Qz04mCsbTCtB9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525655622; bh=+UAgP
    xqNpMDAUmDNb8DaLHT4ZpJrG6iMx0ZPizoN65M=; b=Zz1WXvw9xbKKrmZpNjyJb
    tFycvj/kjkyjl3vyYxUA3/NJPE8X8zM5qg+iqZdJcbWree/9EytRhsd0ljfSiQlv
    yblhc+RMbPtaO6kF+BQ9ZgK1WLx7yn//g9oHDD6u40c3vWlywCMk5UkoljEflfrU
    Lo1N9mAT9Q1wordStz5HQeMFLaY5KUGfth5qqzyMP4nqItCfW9JaffReqKgjZKNy
    BCwNW2neh+EInc2+eNY+6MVEjYyNN+6h+NCYeKV0yuzQmw9OpX1APAuAgqVaTAY/
    lbzevcIOGiNVGG/yRhPVnv7hmw1YBGX7OkthMWUcVR+erWDRcmWDQvcLN1Pz9NRW
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=GylIaMbx x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=CjLMvFxd;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=GylIaMbx x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=CjLMvFxd;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHcR41zo0PfjAVz+4D1LxEU+LOAyi2OzrA7sFAeZ+Esk0NMcWVKXn3rs7Pyq94HrC1IYzaNFh38hxsDsXLl4lWpa6CZuRyjnAvSdZHf+/C/kqFD7/ZOL
    JTNib7rSWl03ckuKrMalGWqJXJOwDGDntitz9QwLFqRWHIrvlJGJ7QG5P3dyyTw4ICi9iqs4oyz3WsykLVpkgtdvYf5+q3cLMx8Bnhmw8nUeXvUXe/FU3nMg
    ZRP1LsUFTSHb2euEsVxxiQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8
    a=DDOyTI_5AAAA:8 a=6cfhMGh1HYutjH849ZgA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZpTT4d9I4U9gwku1xA1g/v4ML2UobIgOEX4HxKR92AuQLqdoFWf7dDUQGl8F8CZ5TT18aEgoQ==
From: Nathan Chancellor <natechancellor@gmail.com>
To: devel@driverdev.osuosl.org
Subject: [PATCH 6/6] staging: android: vsoc: Fix ending '(' warnings in
 vsoc_probe_device
Date: Sun,  6 May 2018 18:13:28 -0700
Message-Id: <20180507011328.11982-6-natechancellor@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180507011328.11982-1-natechancellor@gmail.com>
References: <20180507011328.11982-1-natechancellor@gmail.com>
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
Cc: Todd Kjos <tkjos@android.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Martijn Coenen <maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixes checkpatch.pl warnings about lines ending with parentheses.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/android/vsoc.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index c460740f9561..806beda1040b 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -841,8 +841,8 @@ static int vsoc_probe_device(struct pci_dev *pdev,
 	vsoc_dev.regions = (struct vsoc_device_region __force *)
 		((void *)vsoc_dev.layout +
 		 vsoc_dev.layout->vsoc_region_desc_offset);
-	vsoc_dev.msix_entries = kcalloc(
-			vsoc_dev.layout->region_count,
+	vsoc_dev.msix_entries =
+		kcalloc(vsoc_dev.layout->region_count,
 			sizeof(vsoc_dev.msix_entries[0]), GFP_KERNEL);
 	if (!vsoc_dev.msix_entries) {
 		dev_err(&vsoc_dev.dev->dev,
@@ -850,8 +850,8 @@ static int vsoc_probe_device(struct pci_dev *pdev,
 		vsoc_remove_device(pdev);
 		return -ENOSPC;
 	}
-	vsoc_dev.regions_data = kcalloc(
-			vsoc_dev.layout->region_count,
+	vsoc_dev.regions_data =
+		kcalloc(vsoc_dev.layout->region_count,
 			sizeof(vsoc_dev.regions_data[0]), GFP_KERNEL);
 	if (!vsoc_dev.regions_data) {
 		dev_err(&vsoc_dev.dev->dev,
@@ -913,8 +913,8 @@ static int vsoc_probe_device(struct pci_dev *pdev,
 		       name_sz);
 		dev_info(&pdev->dev, "region %d name=%s\n",
 			 i, vsoc_dev.regions_data[i].name);
-		init_waitqueue_head(
-				&vsoc_dev.regions_data[i].interrupt_wait_queue);
+		init_waitqueue_head
+			(&vsoc_dev.regions_data[i].interrupt_wait_queue);
 		init_waitqueue_head(&vsoc_dev.regions_data[i].futex_wait_queue);
 		vsoc_dev.regions_data[i].incoming_signalled =
 			shm_off_to_virtual_addr(region->region_begin_offset) +
@@ -922,11 +922,10 @@ static int vsoc_probe_device(struct pci_dev *pdev,
 		vsoc_dev.regions_data[i].outgoing_signalled =
 			shm_off_to_virtual_addr(region->region_begin_offset) +
 			g_to_h_signal_table->interrupt_signalled_offset;
-		result = request_irq(
-				vsoc_dev.msix_entries[i].vector,
-				vsoc_interrupt, 0,
-				vsoc_dev.regions_data[i].name,
-				vsoc_dev.regions_data + i);
+		result = request_irq(vsoc_dev.msix_entries[i].vector,
+				     vsoc_interrupt, 0,
+				     vsoc_dev.regions_data[i].name,
+				     vsoc_dev.regions_data + i);
 		if (result) {
 			dev_info(&pdev->dev,
 				 "request_irq failed irq=%d vector=%d\n",
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
