Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21789C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01402086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mi1YUKaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01402086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbeLMQxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:53:20 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41111 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbeLMQxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:53:20 -0500
Received: by mail-yw1-f68.google.com with SMTP id f65so1077841ywc.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 08:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FHaLBt9H2hOOTwP5FxmmI503NqEsUSU4gN9Qp7qTk18=;
        b=mi1YUKaXPIuC2Bh6LEW0El+zGU28bZ9XrxfXj8D75SYAqevJYs9xVEwpfAMsoBnMkO
         5Awn1a1ayuVjTBS53ZITU5+cpjauLiVKg9L/1jLFMvnkylxUQUGuADnkormREawEh2GT
         h6blWs+ZtCOlnws7xQh7mlAyaEMntHBSCcIo/ZS8cSR2OJzSws+WsnqFE8NQXrypz+TP
         9eWak8jf5MWuOLPejD43Fw6eYIpXKsCXsWZyH5SIdD+NsR0HXSlD77YC/kyU79dmff2N
         SRC/eMgoDMJ4LEIcOLENby3LXQCPfRtW98VPReu7Wx/vqDH02+AnKq83eB8aomAiZt0j
         NVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FHaLBt9H2hOOTwP5FxmmI503NqEsUSU4gN9Qp7qTk18=;
        b=nsNTXzMGtBSnEEcRMycNXRCUCsPtwKsawGrykxYdI2KPHhXiNW2Sr4JfRDjzhPko8a
         gfS6EobsbLmmpKnsfIqkh8QNQaSYaXhg7tNCGamO0CJflKFYoZYDQnCeBA+7QuPV5I0X
         hPWky57ORzWhVXyM8AAheMHP/Ba4R+w6lmCgLCDWvUjVxLB8PCU0FWJw+VDFg8CRTsGq
         u0Fr71T1j42ecOJnBx0sC1T7MzNrSC268Fk8IrGh8oCarpTdRRIuACpS0NgfTHFcP9CZ
         slAIa6iaJ1byKd/nHmlTd8FloAOU8httlluMipBAR4mhxlI/KLcbHZbeNE03mcQunpdV
         Y2ww==
X-Gm-Message-State: AA+aEWb0j9xVH1W/WrJK+hwn6oz4vaR9OP0tBlC40M3glQOeM0Qe0Fb0
        TkguQmHsTMJ3E31lcZFC2RM=
X-Google-Smtp-Source: AFSGD/V4fZMLNC4tjM7IW7dP0c4f4bCtbzt489yQueZPSzXnt22QUG5QRu9vriKKvDJrrS4Bxir/2Q==
X-Received: by 2002:a81:1086:: with SMTP id 128mr14536952ywq.418.1544719998876;
        Thu, 13 Dec 2018 08:53:18 -0800 (PST)
Received: from ubuntu ([67.191.186.148])
        by smtp.gmail.com with ESMTPSA id r188sm663614ywb.30.2018.12.13.08.53.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 08:53:18 -0800 (PST)
From:   Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
To:     abbotti@mev.co.uk
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Amir Mahdi Ghorbanian <indigoOmega021@gmail.com>
Subject: [PATCH] Staging: comedi: 8255: fixed an SPDX License Tag coding style issue
Date:   Thu, 13 Dec 2018 08:53:17 -0800
Message-Id: <1544719997-4490-1-git-send-email-indigoomega021@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amir Mahdi Ghorbanian <indigoOmega021@gmail.com>

Fixed a coding style issue.

Signed-off-by: Amir Mahdi Ghorbanian <indigoOmega021@gmail.com>
---
 drivers/staging/comedi/drivers/8255.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/8255.h b/drivers/staging/comedi/drivers/8255.h
index 6cd1339..ceae3ca 100644
--- a/drivers/staging/comedi/drivers/8255.h
+++ b/drivers/staging/comedi/drivers/8255.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * module/8255.h
  * Header file for 8255
-- 
2.7.4

