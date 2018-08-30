Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4708BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0144120834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqZnPA0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0144120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeHaCjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:39:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34524 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeHaCjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:39:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id f8-v6so8571676ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sa+LRTyejaXQKLKVVoWg55tj517huL+vpGIuXVPQaBQ=;
        b=dqZnPA0RjgF13lxqtprDvhH5DrmbsKxOu0eT29dXd50eSkSpPLk3fDOOSMGB8LtGju
         PKuH8x91+M4lGn+Qq0WFCLYl5fFbcLsWoivtoLPVc0hdfn1H8RlncnTwCzNW4qIKZU5f
         CBFck82xf8/M9P+fPL62hIxLZOh4woHlMhDjniHQd4hSor6+26aYbKXbKUk4nHVlpG7Q
         2CFpxn7KNS0QmjJF4RQ7rL8wdQnbe10RfzHFHcAon9W568CM4UlJ0hPLXnDcFkUzvqOJ
         t2PyP196my93lEaUoDp/4mBDAJ0Ly7AX073s6w7/63He2OTobj9MdxpkVdxcdgnUwLvt
         UgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sa+LRTyejaXQKLKVVoWg55tj517huL+vpGIuXVPQaBQ=;
        b=DJOs3U7LdEm7lOx8XJCkRwyw4EvF/f9ivpSOlncG8uJeKlit2V2gXmCPLj2gCv7Rk6
         FerBsUezPgS3AEUU9nFabQ8pu9QL+iCtEZb//tWEhXbg8Pq92hWIojis0OZMq34G6Rta
         LqHm6tXOq8QF1rbGivhms/w+3ChRrKHIMxjtibyRsX6V7T8hBiEXPLYZLskkFKpKwPba
         KLtlAmxriQRumW6QpQ5ATz3yItcILbJf1TrO3OoHIAHqWUO5CkO1nZ/yw98g4Tv6a6wi
         f/tQLWdYWzEdLbAqyiBqzSl9PG6xy1bjfqsVnesw/7FM9a3vzhNDOdxwGAGfMNiAayNH
         Fv2A==
X-Gm-Message-State: APzg51C1puKG5FtyQd4ExOw3QMwm/VT066aB8O2hJA2zGT8XH5vP2cK+
        84ITsXLg7BUl8bu8kpNOUxfc4m0RiYM=
X-Google-Smtp-Source: ANB0VdbHBIN+VrBfmb4zO6VUtMJxZUx0ZtwV2EFTtWxTgNT3uOMeUYBwqa5ZAhBBny8QUniK3xvkBA==
X-Received: by 2002:a2e:4745:: with SMTP id u66-v6mr8377222lja.76.1535668529174;
        Thu, 30 Aug 2018 15:35:29 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:35:28 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 06/23] virtio: add unlikely() to WARN_ON_ONCE()
Date:   Fri, 31 Aug 2018 01:34:12 +0300
Message-Id: <20180830223429.30051-7-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The condition to test is unlikely() to be true. Add the hint.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
---
 tools/virtio/linux/kernel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index fb22bccfbc8a..2b5e417ea2f0 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -123,7 +123,7 @@ static inline void free_page(unsigned long addr)
 #define dev_err(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 #define dev_warn(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 
-#define WARN_ON_ONCE(cond) ((cond) ? fprintf (stderr, "WARNING\n") : 0)
+#define WARN_ON_ONCE(cond) (unlikely(cond) ? fprintf (stderr, "WARNING\n") : 0)
 
 #define min(x, y) ({				\
 	typeof(x) _min1 = (x);			\
-- 
2.17.1

