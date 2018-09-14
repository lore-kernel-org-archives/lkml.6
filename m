Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E7CECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DDE20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eqryql8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DDE20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbeINXHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:07:31 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:52984 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeINXHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:07:30 -0400
Received: by mail-vk1-f202.google.com with SMTP id t7-v6so1610032vke.19
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KxhIRbFFEU3g+V98uDkaBODNM61F/dfQeSx5dZf+fmE=;
        b=Eqryql8gcpya0M+KPkD5Af3rfuFDkzcmHcxFUe7DNyDZ/QIaJOAN1xQ+U3WiJfdmqM
         VQlR4QkfiZ9uXKsXxLSDddaZU4RL9CF97pB31P0DAl+lUAHaKe/DW+WsotaDfLcdbbP7
         tu/vkEC0b3MhJg7/CK1dF7lphX0yED3C/Dc4Nvr09RkhZ/QO0gLvmEglwVPP01B60Xhi
         /4b6MPd9uMN3gWbDE8vbyBnBPDl8BrHD9WD4g6DINmROknaAf7ydwNlhulNVauO7XYoQ
         M1rBEyGDkCPGgkOLC6qf1FSLXDNleTBBoyyclqGce56hwau3MhGXXoD06ia1Ne+wfmls
         1X/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KxhIRbFFEU3g+V98uDkaBODNM61F/dfQeSx5dZf+fmE=;
        b=IIFgEQhitISYfGKNkR8lyrmorBtryTgX7bEv0gvNSUxTlisC8bC+dqVqa72YUFe6Jd
         0B60U1UIqlKhqxuhDzKKng7MVOai9DaAutX5d7fpmoznhJEIpdhBJc54Oh9Q7AKaKrui
         LS05SgTjss8MNP+VzVIsuNxOfzTlTaoxXp+aludcjWQCPJGBHoC/B+HX5LzDUf69UBty
         7Tylq2eumK7WBLIlFgvHBMp1W5/9bztKA6uHdJgqRfc1G7sTAmSCSDjlRWIUk0NSca7I
         S6KHqH9RjFE1IRPMeMBzf2BNKWmimsFZJz6T9bvqd0Q0nzPH3o/bRdaijEdX2DNVdYhA
         i0WA==
X-Gm-Message-State: APzg51BE4PwEFfMcZ8utwT9YPgsbjNEeXVTknMvXXzsiAN9Q6Ebvld47
        CB8eBYbdBEZhOLYEdk3k5Izu0ib4
X-Google-Smtp-Source: ANB0VdZTzvlv7//OjclJbqsVfRwAbo3VMtsyquuY10AicR/AmOf6ZD4SrnuxnMiYfDKKqIlftpaQ0EeX
X-Received: by 2002:a67:4944:: with SMTP id w65-v6mr2484389vsa.1.1536947516852;
 Fri, 14 Sep 2018 10:51:56 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:51:04 -0700
In-Reply-To: <20180914175122.21036-1-rkir@google.com>
Message-Id: <20180914175122.21036-3-rkir@google.com>
Mime-Version: 1.0
References: <20180914175122.21036-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 03/21] platform: goldfish: pipe: Remove a redundant blank line
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     tkjos@google.com, linux-kernel@vger.kernel.org,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

The blank line is not required there.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 6ae2b00f4bff..8747ec330b7b 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -47,7 +47,6 @@
  * exchange is properly mapped during a transfer.
  */
 
-
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
-- 
2.19.0.397.gdd90340f6a-goog

