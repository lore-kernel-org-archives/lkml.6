Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A668ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3224020C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nps4AvcN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3224020C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbeGQCk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41761 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732013AbeGQCk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id z8-v6so6788677pgu.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aEfZIMxFucdVK7xM7W0p8/txQIgp0vjRpGPsUiqWxi0=;
        b=Nps4AvcNkfUKzLKc0VbMvNrFmespmdp5nYdo0HpKKnCLdIeVCBBksA4O+U4yPfzM+/
         JHb1YDcVA3/1DDQUIRfo5UMxigQk5RDfwfo+gw9kRxhCCOX2xp7K3moL5m/mvNKLzjyr
         jSXAI5RTA7eVUe5/MNezb25vXDZR9/cp27oFzv7ZJbK4uZp+y/GvsjtfLCGRxOLnuhki
         fnGiMq9w5wox/oO6KkmVaRfb1xZcQyi4R+A4RCEEV7lQ01GqPUx1Cmg+U3H5PKUVWFTJ
         6OyAyBqv95QNvaTrLKqUzRiwvyJG3wDyErIKV/qMJiUjqEMQ14i7UOIauBrSZBYxXDPX
         uPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aEfZIMxFucdVK7xM7W0p8/txQIgp0vjRpGPsUiqWxi0=;
        b=ikIvzMg3CQ5cw6XhuYKxEtuQisY8ZL+F+FRsHkmQx1YdwSXcbQUSaz3teIMqVo1XPo
         bQY1XF7iScO8rhgXCuowCxTLVc4Vczfwf+hMFgGTposAozwqgskOV9I4/fZ/00li1QMZ
         m7Kk9xDfvZ68/0bkEKEpLYLEdyehg5UuozLoEpXZSSHAROFKBUuGMhlHPAgvDg0NIPPm
         MGlAy6y7bbtGkR5jkBNcLnqECdV4GRntdgPdIHbBq5SjsjjAvvmvnUwywNV7JqU4QarT
         aCYRAjRdUJAKhUEMAFzaI1bRvnPspkB5oFeQRJhLSaJBmKxyONdgK7ae6yESxXnhFju7
         rxYw==
X-Gm-Message-State: AOUpUlGjtUCBs6rrgEml1Jq593yeOQyM6xQPntmu3KAUzitr7bzqP4JI
        GE8/GR6xqE3RUo+d9eUohEo=
X-Google-Smtp-Source: AAOMgpfJAx1YLot52tbhaugSI8cTu2Pxt6jr4HHgWcjUDhpsEKHLq5KZgmRXMxy+5y9zXRSkrqcKHg==
X-Received: by 2002:a63:4b5a:: with SMTP id k26-v6mr17166164pgl.384.1531793415846;
        Mon, 16 Jul 2018 19:10:15 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:10:15 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 21/32] staging: gasket: remove unnecessary code in coherent allocator
Date:   Mon, 16 Jul 2018 19:09:15 -0700
Message-Id: <20180717020926.176408-22-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove extraneous statement in gasket_config_coherent_allocator()

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_ioctl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index 531c360949a64..9ecf9a4ed1a53 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -419,10 +419,8 @@ static int gasket_config_coherent_allocator(
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
 
-	if (ibuf.size > PAGE_SIZE * MAX_NUM_COHERENT_PAGES) {
-		ibuf.size = PAGE_SIZE * MAX_NUM_COHERENT_PAGES;
+	if (ibuf.size > PAGE_SIZE * MAX_NUM_COHERENT_PAGES)
 		return -ENOMEM;
-	}
 
 	if (ibuf.enable == 0) {
 		ret = gasket_free_coherent_memory(
-- 
2.18.0.203.gfac676dfb9-goog

