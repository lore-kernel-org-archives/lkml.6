Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA17ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 20:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E0E20869
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 20:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNzlEjLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E0E20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbeJ1FLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 01:11:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43516 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeJ1FLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 01:11:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id t10-v6so4562028wrn.10
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 13:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FFR/QUdYbn+5QcVPcGNA8HBenQd8cOrGmJeaXdBKxB0=;
        b=YNzlEjLwx8cehSVncpTQPJgX17QL198R8QovhQvHUY+jM7Yw5p9VzVUzoWgP/keoOS
         w6zp2+CopK02z93w2HvywXAGx5/D+PGszCaRGQvJ/rv3eBbKH989cCmmE4XEj7vLiuYw
         Ycv4/zFrJlWtby9104l6oFDTfZYr+3KAX9GlB9YOXkQmng6q9uLVCwcJqmkEthMTqSZY
         676oKApb4nUh9u7p8z0sbi8jIwQEKq3o23w8rCDvdST6NQcc018kkznllTWxUnWzwi9+
         A6TY7DWslzEzB1RNZtGZd4pNd5hOjPc8mkxU1eVPI5gxZ3+/rlX0hIbXATeQgXCzoSe4
         lsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FFR/QUdYbn+5QcVPcGNA8HBenQd8cOrGmJeaXdBKxB0=;
        b=uKTmHTca7Wk4xvQwZt5lhSKSkmAKmKHedgdf4E6G9IWYwxNqAvI3/74n6eIvzsspY4
         whY+fbytkAGThwj/PqKKNIyEPALfDRp/U+5FqGl5inJcMnxenaKb9uop+uGUt5wmPhO3
         ux0AlV/6vHrdZTsH+0BcTeJHLCCukvgjICrX3vS7xeZ4dw/XVVJmo0Sc0wazV88YrvBC
         Sm3OKJDLBUaO4aBDxVwUVRsYqJEua4Cf/Nnm9vN5c5FYZCIO+NaRf+FZm6B9XkBzvoOG
         MytLli3mnDRA8Yx3/6j76LjWCHh2bUveFz1cee5ieqcXPWXEIT2rBHsvCDMSf+6pnw+K
         H6tA==
X-Gm-Message-State: AGRZ1gId8QhA7+PJgIKBOcy6KT3v2gDArhIfjlcfNhFfDhsnMq3yhHuH
        fZB7nXvpjLbHLfuTibvgcZg=
X-Google-Smtp-Source: AJdET5fCb49s97UpW3p9URXT4+spij6Pav+pY0CQ324CQtAGOevYx3fmBJ5vHpRdG7yRJ77wJHaMcg==
X-Received: by 2002:a05:6000:11c1:: with SMTP id i1mr9886258wrx.310.1540672143121;
        Sat, 27 Oct 2018 13:29:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id v16-v6sm5335784wrt.32.2018.10.27.13.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 13:29:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/5] staging: rtl8188eu: change return type of rtw_hal_xmit()
Date:   Sat, 27 Oct 2018 22:28:49 +0200
Message-Id: <20181027202850.25636-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181027202850.25636-1-straube.linux@gmail.com>
References: <20181027202850.25636-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rtw_hal_xmit() returns true or false.
Change the return type from s32 to bool.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c | 2 +-
 drivers/staging/rtl8188eu/include/hal_intf.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
index 69a0edd27710..35bc8fc32db1 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
@@ -598,7 +598,7 @@ bool rtl8188eu_xmitframe_complete(struct adapter *adapt,
  *	true	dump packet directly
  *	false	enqueue packet
  */
-s32 rtw_hal_xmit(struct adapter *adapt, struct xmit_frame *pxmitframe)
+bool rtw_hal_xmit(struct adapter *adapt, struct xmit_frame *pxmitframe)
 {
 	s32 res;
 	struct xmit_buf *pxmitbuf = NULL;
diff --git a/drivers/staging/rtl8188eu/include/hal_intf.h b/drivers/staging/rtl8188eu/include/hal_intf.h
index e5be27af7bf5..8b65fcba1967 100644
--- a/drivers/staging/rtl8188eu/include/hal_intf.h
+++ b/drivers/staging/rtl8188eu/include/hal_intf.h
@@ -185,7 +185,7 @@ u32	rtw_hal_inirp_init(struct adapter *padapter);
 void	rtw_hal_inirp_deinit(struct adapter *padapter);
 void usb_intf_stop(struct adapter *padapter);
 
-s32	rtw_hal_xmit(struct adapter *padapter, struct xmit_frame *pxmitframe);
+bool rtw_hal_xmit(struct adapter *padapter, struct xmit_frame *pxmitframe);
 s32	rtw_hal_mgnt_xmit(struct adapter *padapter,
 			  struct xmit_frame *pmgntframe);
 
-- 
2.19.1

