Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42722C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AA022399
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKdDcI/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7AA022399
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbeHJBBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 21:01:00 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:44825 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbeHJBA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 21:00:59 -0400
Received: by mail-qk0-f193.google.com with SMTP id v17-v6so5162436qkb.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 15:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=N/iammyicdprfiPqCgfqp2zyNq4laDzS+eXwNg+nDLA=;
        b=EKdDcI/8zTTVlHHLByycGopGSZAkJv2Wzdu6MQgXBYokJa4gaDyRWL8Az9X/kAe8S2
         UALo3W5yCntESS7nVnL/rmTeHpwdDNLsAR5h4+pDtGKWQR7oENbFz1KMi2KPcypF9b0y
         WjhjQXeBRnxmuQxKKubg4PKgbn5Hg1EVx9429I5p8HX+7rSqNDnaTcGCHHURsANDEedO
         r8IczRclBMDvK8mBhvWcn29TOFkCZw82TG/pLRWStKgeZUZiG0PzMVRisBfKvBmR/4WY
         7FtwepjjGtmbGsnomLvnPtIj6zV3v1lVqtUXwuStP7pKV9iOU2PvWDEw0ivz19dXK2lN
         +FBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=N/iammyicdprfiPqCgfqp2zyNq4laDzS+eXwNg+nDLA=;
        b=slIph1GWJ02ztSVEPizzQpP1XB+eEjtjo40rFUlR5coo368K/lJtHGEmoNtqWWFWJ2
         gm/EqF29v/caEpF+uKjM/EXjOVlUD1jPvEHNdx12uBnsGALfamCgv9005Lj/0V92r9fd
         nyKvrOzFwtFWZqo/bgkAYP9nq+MqrnGXGlevUWspTNGhBfDWqMA8d0WrQFKYSdalG51n
         pGrVQ/MS00a3s5f5yAnTDzgdN1IWi1F5XzVrt+NrNY4tzEqgMIJYBpZUY6uT3C4W0i5N
         LMW3bi8FgIr4YFUd0gHxlIVqqqrr4E0KnsAP0adXlRidWcUNJiNRjxrY5oKhw2zfsLcV
         vkVg==
X-Gm-Message-State: AOUpUlFB4EC+gjXDBWgJwppKPd57iM76YBHmYpm38m2zMwnroWhdnVzh
        zFOv+6NgNynuL0BJvgV23to=
X-Google-Smtp-Source: AA+uWPyRJgPnPQ3bOS37ZaHBGgpFepOIsLz0hncTegoVLNd+cjGze1YEvH9aBlicYLlgOPg1aIgUOw==
X-Received: by 2002:a37:c946:: with SMTP id q67-v6mr3839018qki.148.1533854042945;
        Thu, 09 Aug 2018 15:34:02 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id o80-v6sm5377507qki.19.2018.08.09.15.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 15:34:02 -0700 (PDT)
Date:   Thu, 9 Aug 2018 19:33:56 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] staging: fbtft: Includes description to mutex and
 spinlock - Style
Message-ID: <63297a43a9683cb6d925da67242c9e2c92fa9316.1533853354.git.leobras.c@gmail.com>
References: <cover.1533853354.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1533853354.git.leobras.c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds comments explaining what are the spinlock and mutex used for.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 798a8fe98e95..958835da433c 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -203,7 +203,7 @@ struct fbtft_par {
 	u8 *buf;
 	u8 startbyte;
 	struct fbtft_ops fbtftops;
-	spinlock_t dirty_lock;
+	spinlock_t dirty_lock; /* Protects dirty_lines_{start,end} */
 	unsigned int dirty_lines_start;
 	unsigned int dirty_lines_end;
 	struct {
@@ -219,7 +219,7 @@ struct fbtft_par {
 	} gpio;
 	const s16 *init_sequence;
 	struct {
-		struct mutex lock;
+		struct mutex lock; /* Mutex for Gamma curve locking */
 		u32 *curves;
 		int num_values;
 		int num_curves;
-- 
2.18.0

