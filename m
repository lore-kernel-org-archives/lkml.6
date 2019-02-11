Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90977C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FD721B1C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQTmjHlS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfBKQO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:14:59 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41511 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbfBKOVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:21:02 -0500
Received: by mail-pl1-f196.google.com with SMTP id k15so5365970pls.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 06:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vHVmlgopHIx0N72f92t2Wp+YYgILXvePaeg84jVpJQw=;
        b=OQTmjHlSW8AOx33heQrYf/3GrpDudvyG+3Qdcz2aoedEuXrgpesaDp5RY84+hLTxJq
         r1EA52FcjU6EYhJL34y/qAshDSf08B6CnB0yck3+8l6dSWM24D9cIP0XCG+tlv3GNLlY
         gOEzKj3a26QpOTdQQqprgscV+ZdSZlxRPbA5srFM0iWW+8dORNNfkMgjn/8TGb2dRi6S
         Q7zbKi/3o7Zgldh+ErsmC31fTOY2r7GhHjTtMIH6HNJTho17wAumABnsI5GsSQRW/S6s
         G1NE/oCqfrrhja0fYHUMQ0lQp1Q9lXhCxX3lAO6qo/b2vo/oI8p00XdNPIsdFB0sVjrm
         +AzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vHVmlgopHIx0N72f92t2Wp+YYgILXvePaeg84jVpJQw=;
        b=APfTZ5QVo40Qly8pc3wDtrM8YX7rJqMnqR/q3cb5bfwFUIaxksfPQjo1X7aDAZ4AMV
         y9cT21u2l01PGMeyOYTHAX9I/Nk61+au69MYtwjWJvCgMchA+TB+nWBqA0vyLOdg+wzn
         Dd4Z0z0bOPo7uP8ZsAXcRGaOb3ioUUi0uGXYQLOZqoPmqJz6USxQZ2Upiho3jyiO7KWD
         nyrdCRmRleQHns/bFHLREkRMG7HJhunFezOgpXxt07sJWdTZu+zY7yMfNrTc6N6n2k7N
         ArORGfT2P+SL4jV03mpZoU+FK8AHtAx4m+GE5ARjwJGCx6N8kDD4nQ02g95deobEVWOz
         1lEQ==
X-Gm-Message-State: AHQUAuYtSiLqOW3WgWVul1yLjVLFN0FrJXZTyVgMORKkHypJItS9MvDz
        apYRe/69wYhA7w3bWVy2qFA=
X-Google-Smtp-Source: AHgI3IZOnJdBFX7jRzeaA4F0hhHir3SplndK/VYhdldPTW47E4Ek5WB9E6oEuemNM1EwHBmF7GVJpA==
X-Received: by 2002:a17:902:583:: with SMTP id f3mr38416338plf.202.1549894861706;
        Mon, 11 Feb 2019 06:21:01 -0800 (PST)
Received: from tianyukernel.corp.microsoft.com ([167.220.255.93])
        by smtp.googlemail.com with ESMTPSA id e2sm20551664pga.92.2019.02.11.06.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Feb 2019 06:21:00 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, mchehab+samsung@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com, alex.williamson@redhat.com,
        joro@8bytes.org, sashal@kernel.org, dan.carpenter@oracle.com
Subject: [PATCH V4 3/3] MAINTAINERS: Add Hyper-V IOMMU driver into Hyper-V CORE AND DRIVERS scope
Date:   Mon, 11 Feb 2019 22:20:24 +0800
Message-Id: <1549894824-26623-4-git-send-email-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549894824-26623-1-git-send-email-Tianyu.Lan@microsoft.com>
References: <1549894824-26623-1-git-send-email-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to add Hyper-V IOMMU driver file into Hyper-V CORE and
DRIVERS scope.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9f64f8d..5fb6306 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7015,6 +7015,7 @@ F:	drivers/net/hyperv/
 F:	drivers/scsi/storvsc_drv.c
 F:	drivers/uio/uio_hv_generic.c
 F:	drivers/video/fbdev/hyperv_fb.c
+F:	drivers/iommu/hyperv_iommu.c
 F:	net/vmw_vsock/hyperv_transport.c
 F:	include/linux/hyperv.h
 F:	include/uapi/linux/hyperv.h
-- 
2.7.4

