Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E6EECE567
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5179F214C1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAodKjF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5179F214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbeIWTG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 15:06:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39687 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbeIWTG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 15:06:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id q8-v6so7460930wmq.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S+I3UT9VYiO3SujnQjJ3n4EkuHKuOIM0YtM8Q9lPOPI=;
        b=NAodKjF6B99QVZLilyE+FgFdBRTkoIC1EtbS70IpxZ4+ForZcebC2ZqngCL1ADoWfG
         H5pHD/tGZNSdn8arFrD9K/j5wTxVosLK+mQ19NDn1BvoW1CQhUJELkfIEcXCLiHSObHR
         5Hpd19O6GflfQFizAB8cvIObnKtrgH/lCgyU+7JPt+YV/uMQGk3zS4zNXL7l0fgw8AwL
         iIKfsTkj9w632VpuNR03lzpOTYCzd4QFJRZ1tAVSNq8mWpG7RPQazxphq7ic7YQzbZ/Y
         udY98bi1bxl2llqM6S5ySB7amZJT0C60csRLe9D5m6opKWrPBJtHNgTOMAdVlmNjj+tK
         RVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S+I3UT9VYiO3SujnQjJ3n4EkuHKuOIM0YtM8Q9lPOPI=;
        b=uTt1vq10h1WN6ODrCzrlXKj7HYUZq8JeVs2YI6lqU3tiJ5CFaGDEWipLi1NFT5e9Mj
         XLZu2a4Olxi5Pa8vFjD3eD6C8dFw4jf8hqA/YK9lLdkPRKITCz7PPlM+ggo008QaEE2a
         iLncaz4E7Uo/laUB1a4Go1GdEgZqZz0SrZWXdtFMsP3lMvJZJpPT+p5CLQErJPjVGXX1
         XiG2Bab3Y/NaqqAPpeZZYoplv7qH8RBE+DNNKMJlb7kncvkrjRtmrJ5mffylQNEqOz14
         VaVJE3g4SCKmbDVSvFKJsTIMEad062D52DMGp+/Pt+l3gywp70ckFk3uQZEHnIK/IDm+
         xcfw==
X-Gm-Message-State: APzg51DHfFljMTONINolW6XYvg+uHTAD18CceXGP/MPBPv/3O8y1DsAd
        /XaT20ei6T88rXwx86ddR4U=
X-Google-Smtp-Source: ACcGV631hbY90QG/qBC+zct3dcXFDpg0r6ZSlax1J0k4hh69VNZx06BIF8ih4YUuj81ip6Yewd4T4g==
X-Received: by 2002:a1c:dac9:: with SMTP id r192-v6mr4285287wmg.141.1537708169265;
        Sun, 23 Sep 2018 06:09:29 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:8])
        by smtp.gmail.com with ESMTPSA id 75-v6sm19115718wml.21.2018.09.23.06.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 06:09:28 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
Cc:     Aymen Qader <qader.aymen@gmail.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] staging: vc04_services: Remove spaces after '*'
Date:   Sun, 23 Sep 2018 14:07:31 +0100
Message-Id: <20180923130733.4128-5-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180923130733.4128-1-qader.aymen@gmail.com>
References: <20180923130733.4128-1-qader.aymen@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl error:

ERROR: "foo * bar" should be "foo* bar"

in the interface/vchi directory

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/vc04_services/interface/vchi/vchi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index f818cf2e27e1..77bf92018165 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -154,7 +154,7 @@ typedef struct service_info_tag {
 extern "C" {
 #endif
 
-extern /*@observer@*/ VCHI_CONNECTION_T * vchi_create_connection(const VCHI_CONNECTION_API_T * function_table,
+extern /*@observer@*/ VCHI_CONNECTION_T *vchi_create_connection(const VCHI_CONNECTION_API_T * function_table,
 								 const VCHI_MESSAGE_DRIVER_T * low_level);
 
 // Routine used to initialise the vchi on both local + remote connections
@@ -175,7 +175,7 @@ extern int32_t vchi_crc_control(VCHI_CONNECTION_T *connection,
 				VCHI_CRC_CONTROL_T control);
 
 // helper functions
-extern void * vchi_allocate_buffer(VCHI_SERVICE_HANDLE_T handle, uint32_t *length);
+extern void *vchi_allocate_buffer(VCHI_SERVICE_HANDLE_T handle, uint32_t *length);
 extern void vchi_free_buffer(VCHI_SERVICE_HANDLE_T handle, void *address);
 extern uint32_t vchi_current_time(VCHI_INSTANCE_T instance_handle);
 
-- 
2.17.1

