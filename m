Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A7AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBAE222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIjTmsvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404558AbfBOWoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:44:23 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45460 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404529AbfBOWoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:44:20 -0500
Received: by mail-pl1-f195.google.com with SMTP id r14so5623001pls.12;
        Fri, 15 Feb 2019 14:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=arIO7gLw9RNNWVmh9ZBQTlhTkHHBOY3pzYGT4D5o+8I=;
        b=ZIjTmsvrt5YtKJrEdwLrMAsf8mEpOCRVG4XnZE8f7/hixv5N7BRMfMLC4D3pJAZU5e
         zDX1nfa2aClf0rW49OWbWzCHEAuT7rgox8H2VqyAQOj8LBNSKMNivmSfgzQfNEgj9ZXS
         dL0b/FNTt9g9fffYzkj+FWPlK3q4HnjUqrTIZKpWUip7e2WEWqOfKXI/313nSJteQ5aS
         jEZSX5dHjTyTNrzcpAk9guHcEJV8tL/mUGxHX6rBEVL08EVwZUqqgmXn8y9z65H/RXoD
         c3whsxGpq3rOX2XENIYxBED5hmv9EcsgBSL3oIs9w1+/7s1H38keMlCVVDkdZrN3Z/bh
         8wEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=arIO7gLw9RNNWVmh9ZBQTlhTkHHBOY3pzYGT4D5o+8I=;
        b=ehwNhCDqNjHdxA87cbKgZKiPT4R++z9UUtCNurJzzqqR6p7/+HNe7TLQW4w5G6/dUX
         7hGryD6NqKFqH1EWcyXMTz1tH8ZtQ97PuLyV/r5T1CnvQ2wiFD1atccgj7EDwzlQnHFW
         Zn6R1c5diewIl3DSPGPB3g++xf8UY8Mzbo0uNPPh0rVvhi8a56B0W201w2e4/bovm89Z
         yHGqQpOulR78kiALqfH9pE8zInZwHDHUUj6oyGF/5pF6Q9nzSdUjJs9/R+/icI2x4Mzu
         siyEO+Ag39vWerQE2CztL1ryHWY5kxs1wPuEoyqEVFtNun7wWxW1O8civtgnt5sFAto7
         DtHg==
X-Gm-Message-State: AHQUAuYYNIvv/OD7wOZEk98ltqYRnr2dK9i/nL4NgDSpSZw5yv6YEdC9
        J1DqrH+7upW7uSyv9XL0VYLq8/sb
X-Google-Smtp-Source: AHgI3IZk++qbJ+Aw0T8SCVNVtUqt7mSJ6jHdTi9IXyXzVQ9vrAXgtGDbDZi10JSxCZ04o03LLc1tdA==
X-Received: by 2002:a17:902:4124:: with SMTP id e33mr12577981pld.236.1550270659310;
        Fri, 15 Feb 2019 14:44:19 -0800 (PST)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id s16sm16887803pfk.166.2019.02.15.14.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 14:44:18 -0800 (PST)
Subject: [net PATCH 2/2] net: Do not allocate page fragments that are not
 skb aligned
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     netdev@vger.kernel.org, davem@davemloft.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, jannh@google.com
Date:   Fri, 15 Feb 2019 14:44:18 -0800
Message-ID: <20190215224418.16881.69031.stgit@localhost.localdomain>
In-Reply-To: <20190215223741.16881.84864.stgit@localhost.localdomain>
References: <20190215223741.16881.84864.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

This patch addresses the fact that there are drivers, specifically tun,
that will call into the network page fragment allocators with buffer sizes
that are not cache aligned. Doing this could result in data alignment
and DMA performance issues as these fragment pools are also shared with the
skb allocator and any other devices that will use napi_alloc_frags or
netdev_alloc_frags.

Fixes: ffde7328a36d ("net: Split netdev_alloc_frag into __alloc_page_frag and add __napi_alloc_frag")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 net/core/skbuff.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 26d848484912..2415d9cb9b89 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -356,6 +356,8 @@ static void *__netdev_alloc_frag(unsigned int fragsz, gfp_t gfp_mask)
  */
 void *netdev_alloc_frag(unsigned int fragsz)
 {
+	fragsz = SKB_DATA_ALIGN(fragsz);
+
 	return __netdev_alloc_frag(fragsz, GFP_ATOMIC);
 }
 EXPORT_SYMBOL(netdev_alloc_frag);
@@ -369,6 +371,8 @@ static void *__napi_alloc_frag(unsigned int fragsz, gfp_t gfp_mask)
 
 void *napi_alloc_frag(unsigned int fragsz)
 {
+	fragsz = SKB_DATA_ALIGN(fragsz);
+
 	return __napi_alloc_frag(fragsz, GFP_ATOMIC);
 }
 EXPORT_SYMBOL(napi_alloc_frag);

