Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC71CECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F26208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTf0ocvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F26208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387516AbeIXXjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:39:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55611 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730136AbeIXXjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:39:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id 206-v6so2703896wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+6oD/O5d4iP7VBQV58InjYcu3fiSW7q8KW851BwGR5A=;
        b=rTf0ocvWv8Loz9xWgHJCwSNdUc1N6BztOZkOImMQyL8NxJ+QkT3y+Q3Y1+DmD6v4NQ
         dnl4MRXmVCG6n1bDoDeyqrG6ylNNma5uNhS5XS5TyIUugBSk+OVD0y3N141J3EcPMZzg
         sG9UkxPHiEcDuD/IHjW75guR9O9EB/dk0BZYeHrFwty0qcgAEDjihnMmHawFoWuGYWSP
         nrOHFhhUc5WVqZ4f9Gg3MiQIPjy5wQ8XKW1Jwc+JxuNcjASqFCnjyCO9jsHmSGueGlcR
         rpqtAd1MStBwy/pcUyecqklQJ4fL1S4EI/Xh9o9JffM50UFoYMKvKPgkUtGKJprG+Odd
         ycLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+6oD/O5d4iP7VBQV58InjYcu3fiSW7q8KW851BwGR5A=;
        b=WVjXqgJdt+xcS8iBlsIp5v8CKM7nF4CNBCuhVALnofMxgRnj+0nnAEuu0ambCQCkC7
         KEW5szygcnET29dukok2uPzCVUQI3RAvnMYbohv3vB4+EMe5N+7X1saPQETvR3+2Nuot
         IYxH3ezwBUuAObdp4k3UuyfTLOV5Ze4kUYOSPHhKyolSStDA6wqR0AkXwmxTjejq79W/
         cPx4kus7u9GpLWIPmvJjm+wBwSfV62jc8D4WqCVGaLYX7KToqU8ekCO+UbnCHOy4ybrI
         qycn1Vns1qURckg5cEPWruV7DWhd1CJpB5ixCMQGrTzm6vrnFT59CMroYMQtkSPGDwPA
         qKUA==
X-Gm-Message-State: APzg51ANmIpSAIo1R4qvDlVYERdz2gHbyA/yS5nPjfkRNHS/K1+fRpe6
        b2g3lyeUftEMgA1IH1ejJh4=
X-Google-Smtp-Source: ACcGV60QiwQFpjCZlkQOVv4gVZ9G4x0A0/rCNTBnXLAm0m3PVJ1CCl8z+APRSIvdpu6fMBXCPtlFCQ==
X-Received: by 2002:a7b:c096:: with SMTP id r22-v6mr8319933wmh.118.1537810568438;
        Mon, 24 Sep 2018 10:36:08 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:c])
        by smtp.gmail.com with ESMTPSA id k34-v6sm52138834wre.18.2018.09.24.10.36.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 10:36:07 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Aymen Qader <qader.aymen@gmail.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] staging: vc04_services: Remove spaces after '*'
Date:   Mon, 24 Sep 2018 18:35:47 +0100
Message-Id: <20180924173547.23393-5-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180924173547.23393-1-qader.aymen@gmail.com>
References: <20180924173547.23393-1-qader.aymen@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl error:

ERROR: "foo * bar" should be "foo *bar"

in the interface/vchi directory

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/vc04_services/interface/vchi/vchi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index f96676227ddc..3fe19d72b3ab 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -116,8 +116,8 @@ typedef struct service_info_tag {
 extern "C" {
 #endif
 
-extern /*@observer@*/ VCHI_CONNECTION_T * vchi_create_connection(const VCHI_CONNECTION_API_T * function_table,
-								 const VCHI_MESSAGE_DRIVER_T * low_level);
+extern /*@observer@*/ VCHI_CONNECTION_T *vchi_create_connection(const VCHI_CONNECTION_API_T *function_table,
+								 const VCHI_MESSAGE_DRIVER_T *low_level);
 
 // Routine used to initialise the vchi on both local + remote connections
 extern int32_t vchi_initialise(VCHI_INSTANCE_T *instance_handle);
@@ -137,7 +137,7 @@ extern int32_t vchi_crc_control(VCHI_CONNECTION_T *connection,
 				VCHI_CRC_CONTROL_T control);
 
 // helper functions
-extern void * vchi_allocate_buffer(VCHI_SERVICE_HANDLE_T handle, uint32_t *length);
+extern void *vchi_allocate_buffer(VCHI_SERVICE_HANDLE_T handle, uint32_t *length);
 extern void vchi_free_buffer(VCHI_SERVICE_HANDLE_T handle, void *address);
 extern uint32_t vchi_current_time(VCHI_INSTANCE_T instance_handle);
 
-- 
2.17.1

