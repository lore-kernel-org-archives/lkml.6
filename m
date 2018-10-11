Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDE2C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BC02098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb5/ZVbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BC02098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbeJKXf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:35:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33604 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeJKXf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:35:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id y18-v6so4412629pge.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 09:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1jOcQXN5+GWW/5PK8zMt3dyDaWoVBQJ/HOmHKzGvS54=;
        b=jb5/ZVbMAYUhbN8jjzpg9yQxl37ZU4R5LohxYJyDDDr/Veek49AvwzB9YbCseWJdVi
         B7ywzkn7nYm39l9Ky2+cva4rWbasFDXswco9Lp9q4KJWVpJZOf+hVOszdoVxnAZf0PWj
         uD7BAXQQwvsfbDTkWSxWpHHm2MCeRmEgKlQlUiLMndW0WrI5VQ8R37q2wGyBc+huAyD4
         YI/7Iyw33j3bqEZ0CYoO5JueovRCA4areb5PoN7QCJvPpR+E0ab1j+H6bX3Nkavio346
         ypQInkIloS8A0T/pif3nqNOTLg1IHMeN9OOmkEA/24yCaIpRuiHbGEkRFmHKs97iedsF
         ErWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1jOcQXN5+GWW/5PK8zMt3dyDaWoVBQJ/HOmHKzGvS54=;
        b=ZcO7CfDL/MxzBN1txAmtiCoWkGG3YQoifggpB8r3tT3n0XlGaa1sXhTQxgn4vA4h2D
         tac4L8kfqrsjPAelvzLtVRaGb8z8aQSjvHp9SsDesG387mTlfk/ahALJfCALsZCiX1wW
         woDFHclXVMNH9Pdf+5sUaOgAixHbo7NBHsRT6xFIHOu7RityuL/4L2cC+f2Q/u36TdlL
         DPMZGupuAb8A9tsvZQIxs85Rl+QgfO0czNgWB13ly5oxKX0BXDVXDE3R45sqlDnJCk+N
         IvEz/PWkZY3pUpRit5dtV3py39/c16KFCMjOlgptpHYqBLQMh4VSsBpwjqi4f6rLcf9j
         R3jw==
X-Gm-Message-State: ABuFfoiFjpkThkiLpnoEgjaM5xdzdzQ7Vv6hGTh9twSm2X7NR2t1cdG8
        4eigbrmCiJkRW+oedgAnJa0=
X-Google-Smtp-Source: ACcGV62A6v+VINM04VHKoeyoeVpOuJ7eqMP6Rl+gm1jG0Q5Us0QhwDMs2/8g4OcWFzGRTw0HOS1/hQ==
X-Received: by 2002:a63:ed09:: with SMTP id d9-v6mr1944153pgi.305.1539274084649;
        Thu, 11 Oct 2018 09:08:04 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id t85-v6sm37205605pfi.73.2018.10.11.09.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 09:08:04 -0700 (PDT)
Date:   Thu, 11 Oct 2018 21:37:57 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] staging: mt7621-mmc: Fix lines over 80 characters in dbg.h
Message-ID: <20181011160753.GA4815@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes lines over 80 characters in dbg.h.
Issue found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/mt7621-mmc/dbg.h | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
index 89acf590ed11..0822de5b8f42 100644
--- a/drivers/staging/mt7621-mmc/dbg.h
+++ b/drivers/staging/mt7621-mmc/dbg.h
@@ -5,7 +5,8 @@
  * is confidential and proprietary to MediaTek Inc. and/or its licensors.
  * Without the prior written permission of MediaTek inc. and/or its licensors,
  * any reproduction, modification, use or disclosure of MediaTek Software,
- * and information contained herein, in whole or in part, shall be strictly prohibited.
+ * and information contained herein, in whole or in part, shall be strictly
+ * prohibited.
  *
  * MediaTek Inc. (C) 2010. All rights reserved.
  *
@@ -18,19 +19,20 @@
  * NEITHER DOES MEDIATEK PROVIDE ANY WARRANTY WHATSOEVER WITH RESPECT TO THE
  * SOFTWARE OF ANY THIRD PARTY WHICH MAY BE USED BY, INCORPORATED IN, OR
  * SUPPLIED WITH THE MEDIATEK SOFTWARE, AND RECEIVER AGREES TO LOOK ONLY TO SUCH
- * THIRD PARTY FOR ANY WARRANTY CLAIM RELATING THERETO. RECEIVER EXPRESSLY ACKNOWLEDGES
- * THAT IT IS RECEIVER'S SOLE RESPONSIBILITY TO OBTAIN FROM ANY THIRD PARTY ALL PROPER LICENSES
- * CONTAINED IN MEDIATEK SOFTWARE. MEDIATEK SHALL ALSO NOT BE RESPONSIBLE FOR ANY MEDIATEK
- * SOFTWARE RELEASES MADE TO RECEIVER'S SPECIFICATION OR TO CONFORM TO A PARTICULAR
- * STANDARD OR OPEN FORUM. RECEIVER'S SOLE AND EXCLUSIVE REMEDY AND MEDIATEK'S ENTIRE AND
- * CUMULATIVE LIABILITY WITH RESPECT TO THE MEDIATEK SOFTWARE RELEASED HEREUNDER WILL BE,
- * AT MEDIATEK'S OPTION, TO REVISE OR REPLACE THE MEDIATEK SOFTWARE AT ISSUE,
- * OR REFUND ANY SOFTWARE LICENSE FEES OR SERVICE CHARGE PAID BY RECEIVER TO
- * MEDIATEK FOR SUCH MEDIATEK SOFTWARE AT ISSUE.
+ * THIRD PARTY FOR ANY WARRANTY CLAIM RELATING THERETO. RECEIVER EXPRESSLY
+ * ACKNOWLEDGES THAT IT IS RECEIVER'S SOLE RESPONSIBILITY TO OBTAIN FROM ANY
+ * THIRD PARTY ALL PROPER LICENSES CONTAINED IN MEDIATEK SOFTWARE. MEDIATEK
+ * SHALL ALSO NOT BE RESPONSIBLE FOR ANY MEDIATEK SOFTWARE RELEASES MADE TO
+ * RECEIVER'S SPECIFICATION OR TO CONFORM TO A PARTICULAR STANDARD OR OPEN
+ * FORUM. RECEIVER'S SOLE AND EXCLUSIVE REMEDY AND MEDIATEK'S ENTIRE AND
+ * CUMULATIVE LIABILITY WITH RESPECT TO THE MEDIATEK SOFTWARE RELEASED
+ * HEREUNDER WILL BE, AT MEDIATEK'S OPTION, TO REVISE OR REPLACE THE MEDIATEK
+ * SOFTWARE AT ISSUE, OR REFUND ANY SOFTWARE LICENSE FEES OR SERVICE CHARGE
+ * PAID BY RECEIVER TO MEDIATEK FOR SUCH MEDIATEK SOFTWARE AT ISSUE.
  *
- * The following software/firmware and/or related documentation ("MediaTek Software")
- * have been modified by MediaTek Inc. All revisions are subject to any receiver's
- * applicable license agreements with MediaTek Inc.
+ * The following software/firmware and/or related documentation
+ * ("MediaTek Software") have been modified by MediaTek Inc. All revisions are
+ * subject to any receiver's applicable license agreements with MediaTek Inc.
  */
 #ifndef __MT_MSDC_DEUBG__
 #define __MT_MSDC_DEUBG__
-- 
2.17.1

