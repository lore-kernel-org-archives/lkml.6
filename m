Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE852C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 14:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75304214AB
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 14:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kT6p4O2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75304214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeIWUEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 16:04:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52183 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeIWUEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 16:04:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id o20-v6so3470604wmh.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 07:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S+I3UT9VYiO3SujnQjJ3n4EkuHKuOIM0YtM8Q9lPOPI=;
        b=kT6p4O2M59qOuZa1uDW4PE3hNMDntDhtUKD2Ij9yhgMF+W5ASWVxBDPAWpHpLJRjY/
         +NP2A+g0YYs/64m26EIwRBLrMNXwUYN7yWsL+ckDuh0UUZum4EiKYpjproqzlLQFr+Ud
         KR534nAhksajPYPPRAvO3vpkUyN0JZIy2ivo0ht1J/9BQ4ia3xPsxnx/Eax8sgg4Q6P1
         9cgsjaEGE7otHaiV48sv3sDa7BXAj0BKEw4NUmYUoW1cEDOR0m0pqlUzGPUhDe8KBKQp
         kDiz3E3lSbtJw1nDMdQYXPYACO6X67eD1T6LM2mUKPtng0fyHdiVPMukDZkg2d+mg/rv
         dQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S+I3UT9VYiO3SujnQjJ3n4EkuHKuOIM0YtM8Q9lPOPI=;
        b=RMgRluv18WwrmHVxKq20JN0DIR+OQrGLWPqW9jTkFuavcZ8ENl8rj3VrVq3EAzCdin
         jTSZw2us+yqVMTFtTq/wCXnnmcNCyhFpZ/UMrzew/S26UgyjwtyC0jy81UT82baF0LA+
         O+/T0hVg7bxVzURGcgHwnZqua7xUZV/jIoBQfypH2flhmK75oWR9TwwIeIAxXjWtn5RT
         91HzULsHRScs/jAxiCA8IEymDfV8e44kaCqgoDHONF1CgIV5X1XsmJzdfbeS8xfiU7cR
         cAPomvDF0dgpkrByQhM8ssdarSY8J1yA9mmLCLPwhkYWkTYxkdG78KV/IecSv7Mj7mMa
         4kpg==
X-Gm-Message-State: ABuFfohhiDeqvvGatnOWVSoHu4ZrHhCkNGCd0a/nvySmtMcFO5sbZYPO
        +PNSnVyWAs/+Ve4u1lJm/eA=
X-Google-Smtp-Source: ANB0VdYgCg3kEp/5yBiAoYPMzZ9dOl2PRh5ZRwfhcsdw4FgZhBlU2i6JecfOUlUXc+TzoSmccbRT9A==
X-Received: by 2002:a1c:99c2:: with SMTP id b185-v6mr4388232wme.15.1537711607262;
        Sun, 23 Sep 2018 07:06:47 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:8])
        by smtp.gmail.com with ESMTPSA id j66-v6sm47477498wrj.28.2018.09.23.07.06.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 07:06:46 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
Cc:     Aymen Qader <qader.aymen@gmail.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] staging: vc04_services: Remove spaces after '*'
Date:   Sun, 23 Sep 2018 15:06:20 +0100
Message-Id: <20180923140620.14583-6-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180923140620.14583-1-qader.aymen@gmail.com>
References: <20180923140620.14583-1-qader.aymen@gmail.com>
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

