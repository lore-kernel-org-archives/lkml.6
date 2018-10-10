Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08655C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7072087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AS8RYmKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7072087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbeJKEi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:38:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53051 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeJKEi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:38:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id 189-v6so6915627wmw.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QGgQn8rx+eBkR21WVIGdX9yTBhADwwjTtiJzjHyhMB4=;
        b=AS8RYmKFZPsSl1CUzyoeBYBT5R8Vg1ZLztfVZykFmRXetnbrdCtKSJzvnCPHYHn26Q
         Oon66oKKmIgzuBEqEwizYgmuMcTF/YgJTgXp+bDAPGccIu0V17cwbvRcn4SmZlLy8FMN
         zQpFVaP3lnvj5ZXSZdOaii+yuStl/IN5b67FHqgGBRpvxRU/mY859l2Pf3ge7ylP5KN7
         9pNb0lrR9hyEe1wT+UXPSsGj+I4hcNPRJIC4+W0kHxiSdM3VJKcZA73ySQ4QZ740P0LA
         RVm+m62/5kPbTPnB/q23mqHg2jX7Tw9c1NCW+bYv1ZwR0RlKhO9GZIb0PNh3dRamN9i8
         Qz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QGgQn8rx+eBkR21WVIGdX9yTBhADwwjTtiJzjHyhMB4=;
        b=IrK0o53kd7hbwi839fG9tkHpwkIeIZj6YxHTibYZniYTVqjk4kk2s/pTyTYWDjYtE5
         jBWsL+LqxbH9yuyxKJ0JwLiNgcvXACjbdBmBvYmbwoOrvQw8N8LGljog1OeZVXXK5fST
         WTjgQR+jHQNF5VU0dn8xKILyKvEfTikO4wYbOUMorHl8PEt0g2/LFG9rAab6yRw10B42
         PC+x/423CQpRHc5sABBsE+QQAf2elNieyP9+3XKpGY3ya93PGmZ7DjzPfDtfeT3B+yvC
         il8zyfvvZOV6RXr5KkzegGV2PLmu/M24GZ0QwIUFYwLEGSFgkw82p1yF3Sqn4gKP7WoM
         LWWA==
X-Gm-Message-State: ABuFfojAdOrLUlfc/9buSY4LHYn0PYTJrNoxZ9DdfNfJtQqgozmDYusB
        dJ8w9sQqKvBLkhW0MgO4FUw=
X-Google-Smtp-Source: ACcGV61UcvspGZWK9DMtUUB5CGyieLXuqUhMHbVsbvj9SAhYkm43tvbZpyzXMPfaL5c7waJDWC4Agg==
X-Received: by 2002:a1c:a505:: with SMTP id o5-v6mr2106534wme.53.1539206098212;
        Wed, 10 Oct 2018 14:14:58 -0700 (PDT)
Received: from minipc.home (host86-147-231-53.range86-147.btcentralplus.com. [86.147.231.53])
        by smtp.googlemail.com with ESMTPSA id 193-v6sm19853469wmj.21.2018.10.10.14.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 14:14:56 -0700 (PDT)
From:   Laurence Rochfort <laurence.rochfort@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Laurence Rochfort <laurence.rochfort@gmail.com>
Subject: [PATCH v3] staging: gasket: Fix sparse "incorrect type in assignment" warnings.
Date:   Wed, 10 Oct 2018 22:24:26 +0100
Message-Id: <20181010212426.3167-1-laurence.rochfort@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20181010142548.GB4071@kroah.com>
References: <20181010142548.GB4071@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the coherent buffer __iomem cookie because the buffer is
allocated from dma_alloc_coherent().

warning: incorrect type in assignment (different address spaces)
   expected unsigned char [noderef] [usertype] <asn:2>*virt_base
   got void *[assigned] mem
warning: incorrect type in argument 3 (different address spaces)
   expected void *cpu_addr
   got unsigned char [noderef] [usertype] <asn:2>*virt_base

Signed-off-by: Laurence Rochfort <laurence.rochfort@gmail.com>
---
Changes in v3:
 - Just remove the __iommem cookie, don't alter type.

 drivers/staging/gasket/gasket_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index 275fd0b..e62adcd 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -231,7 +231,7 @@ struct gasket_coherent_buffer_desc {
 /* Coherent buffer structure. */
 struct gasket_coherent_buffer {
 	/* Virtual base address. */
-	u8 __iomem *virt_base;
+	u8 *virt_base;
 
 	/* Physical base address. */
 	ulong phys_base;
-- 
2.9.5

