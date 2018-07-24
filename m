Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC655C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151DB20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXVZBRuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151DB20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388999AbeGXXsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:48:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33140 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388970AbeGXXsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:48:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id g6-v6so5592739wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 15:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oQ1hrQIbXo4ILuEEm0+/82cRNiOE8p1XgzNfg9kLRKo=;
        b=QXVZBRuhdpX4LhiHuppijSP0W+JWX9K2TulYF89ZFMRheIMFf3FD7meeZndiRlnMNP
         /xiCDdVu6OAVMLMc+fgcPXENGESc7SUc52yWK2xaOO5Ob4vEzsial2o/IJqo7sqcp2bv
         m96xF4Enq6RIYgowFqIn4q9A8eFKZcmQvr3KlqospJJ6zipVIatd6Dgn1Oo/phkEEh+T
         j52Gjv9OQjYSl40wzjv2Xp299bmnSk3yQKS2NhPdeMrZWQ8EWSMZsfdqmYViiNng72hh
         gCraXOKhf5QOs03e7znpBCEgtkZdY0+Ry0t7RR4F3iLmHEa7CagcZOLhPxZ6DEbvdkQ1
         ky1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oQ1hrQIbXo4ILuEEm0+/82cRNiOE8p1XgzNfg9kLRKo=;
        b=Ke9Oaonml04p6nJcWptju/xRJ2R/VIjtLy4uE6iw3Bb0VBbCbfMbe6UZQSrqEkbmF6
         l18qoOA0pdEdTWNhWtAW4lQIveprUp53kuO9RMriYghCYmWfxDgr9c0lqPkjjAjsg/lq
         ejmdD1eNytxyjijsab3gg8eggIL0GKQn7j/RQ7ec69zm8DFgpnHNWk7NOHp9T63mbsf2
         Wmw8tT2tMSvgLc32/s8/jz3EsbsIKj5c98+fyMvbETw5wtLq8GCS5y8s5KikpYth5b/o
         i7aGAxZmlKSsN9mJJJ6KhWin8QYxA6I3XBmoZP2tiyODRJGrlJLFuiY6cz40WD8jhKoy
         lV1A==
X-Gm-Message-State: AOUpUlHrK17QDEgucrkpi5FfjrAO124y6LnGk41ysVSYi/0lrW6Q7ius
        6qSX2ZkMfUCPlTfEF7ZQ1Sc=
X-Google-Smtp-Source: AAOMgpf7BXlCn2AVhJGiCs3UL2mTXM1UyjkeoEgLNbUynxFlIwdzZVwKZ229xQmHNFj4rdqFX/AUFw==
X-Received: by 2002:adf:de84:: with SMTP id w4-v6mr13462210wrl.270.1532471964927;
        Tue, 24 Jul 2018 15:39:24 -0700 (PDT)
Received: from we.local (athedsl-4407117.home.otenet.gr. [79.130.175.61])
        by smtp.gmail.com with ESMTPSA id j3-v6sm15658297wrt.70.2018.07.24.15.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 15:39:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 292D6640816;
        Wed, 25 Jul 2018 01:39:23 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LT8r0vypp3Be; Wed, 25 Jul 2018 01:39:22 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id BDFF0640824; Wed, 25 Jul 2018 01:39:22 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Staging: octeon-usb: Adds SPDX License Identifier for header file
Date:   Wed, 25 Jul 2018 01:38:53 +0300
Message-Id: <20180724223853.10198-5-tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180724223853.10198-1-tsotsos@gmail.com>
References: <20180724223853.10198-1-tsotsos@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.h b/drivers/staging/octeon-usb/octeon-hcd.h
index 3353aefe662e..769c36cf6614 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.h
+++ b/drivers/staging/octeon-usb/octeon-hcd.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Octeon HCD hardware register definitions.
  *
-- 
2.16.4

