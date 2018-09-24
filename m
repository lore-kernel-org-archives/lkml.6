Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EF7ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E708208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfbTOabU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E708208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbeIXXby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:31:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35049 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731112AbeIXXbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:31:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id o16so7222569wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+6oD/O5d4iP7VBQV58InjYcu3fiSW7q8KW851BwGR5A=;
        b=BfbTOabUquwJCpLm5OWLDqWGv3OjuCG6xU+FilmyBuAjb95GwYpJ8GlkK/d4GT1pXM
         UaO9hS2D3/fqiefsn6Ogw4MhVdfSA5X1hCfhiYVGp+aQAqIhgU0/clnX9lQhYk/8d4dX
         wkSbmdaco72bexWhMPs8Q+AasaFWoF+R4srTHFHpz1E52oHlI2XguMDaYjpu2Ah2wQSX
         ZK+eviX82KJAzPticypSoGg756Z4ULedVfikdKlJuDrtigyF/JhF3WpTyrXvNuLqKBsg
         tuxVRBANPE4i6r/VgPULeY6ZNK/UvLObN1aTv2ZkDO9/T4Kr2LdpJfEgINLHNv5O+8Oa
         lkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+6oD/O5d4iP7VBQV58InjYcu3fiSW7q8KW851BwGR5A=;
        b=un9pwyoKxcTv0w7OTtedMH/NCGKQwsnWYvN3ysKB88LsomdPdr+MdOQPeEIBK1rMtp
         UJMDaeKJgut3vxBrrQ6YnqEk+tG3dXx6Vxi+Tjqa2NQSs003n0heaPwxupa3s4PmWP7I
         W3PyQKHSWifDKK9JmtyI2FnVHFmPxcxCWoB0HNMtzmWee1NDRoaJK+O2L4+X+qmqs99a
         rwcmpR97IgtkA6NlnODiHny64+BUeD9feV+F5cq6UcMwd/AEUKZwO3DCpeySHp/qnhzv
         xmoXSqC74Y2zhptsO6CI9PAgE57veKDNAlKZAdn7pAb93f5XBenBCKd5I8ITXCwqYolz
         N+dg==
X-Gm-Message-State: ABuFfojlV4xmcbS34l5azl+fwaeHtmh0hRABrUQlgJ6ChclAw5897VhJ
        oHGLBOBWyyv8lSb4+YUk7us=
X-Google-Smtp-Source: ACcGV619SqE4VYzlqAOr/pElF3T2G/5RZZ62nBkwQ1dkWcKTzbSR2rfP/+SNM7vt4K1QWaFNsUNpXA==
X-Received: by 2002:adf:db51:: with SMTP id f17-v6mr9545150wrj.212.1537810111642;
        Mon, 24 Sep 2018 10:28:31 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:c])
        by smtp.gmail.com with ESMTPSA id y206-v6sm15998258wmg.14.2018.09.24.10.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 10:28:31 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
Cc:     Aymen Qader <qader.aymen@gmail.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] staging: vc04_services: Remove spaces after '*'
Date:   Mon, 24 Sep 2018 18:27:43 +0100
Message-Id: <20180924172743.21153-5-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180924172743.21153-1-qader.aymen@gmail.com>
References: <20180923140620.14583-1-qader.aymen@gmail.com>
 <20180924172743.21153-1-qader.aymen@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
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

