Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1E4C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6C720880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPaZtlIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6C720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388941AbeGXXsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:48:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34977 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388495AbeGXXsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:48:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id a3-v6so5578019wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 15:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X/oD0R3Z90QARiH+jvmG8mbyro/3L/Fxxa4VcHkoC/Q=;
        b=nPaZtlICDQ5/yXz4yFayIf0QoDiVaIx2bdecbWT57o4CFQm+x3Nm/FJYAeJ9p2A/CP
         DnZvFXg0WtaVfFOPUGtlaeKLjiCgMgzeLOXl1xVZiINbWwaCNLw36Pu6dyz66zgwX1bh
         Oj+Crsg6dk0Ltm2CO/ZxEl5eZhswbDacrgCjIJaUUDOnI+kDcHZ6JO//5CiNJcbQOuxy
         8lAsPfYUszc+KSzuXYPhE3hQh2tM8MN4SPxibnEqArNEK9OUingsDcQQErC4Dq6PNXGf
         hhZB+nMYu9/WQjLyCxrCVXPrVWp8ZMB94TKnLZX+7sPHxK1z156/FOZOdVKibfLh5R25
         psvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X/oD0R3Z90QARiH+jvmG8mbyro/3L/Fxxa4VcHkoC/Q=;
        b=RMKkRDft1Yt9bhaeldTyoy1IUrLLWpPD4ugx7898gE/IhhbSNVwSQoivCjMNwYkNEi
         RX/dDVPejMFgtTn36uUINyWOoAqgl0WNbhRzrvUA9RLPGOtCqweaTt1FDsSTv0DuuZQp
         peFAQs6Ub8UqhcPotw6m9w/qq6Gqw0FakElAnF/o4m358KYxpf198rmO9bAXHi/DgcpE
         gvu1yTBI92BxsCNnos8JcMugalXxv3wrSq2RCL9/O5VjTt2B///f8EUZcmyrJ1AZc8FR
         /RQ0Q1uOdto381WIxCraRt++Mddruh2oq/Hl3zPmM9046XWJoPQGYbJj8Rzy9TccKuYM
         Mh5g==
X-Gm-Message-State: AOUpUlGvN0+v+7WKi2QbzeIhsNV96rrD1L5FGv4K2B0k3IEnQ3eGgtvL
        JaV0XfJf9MhJGFmjnJsk8Gw=
X-Google-Smtp-Source: AAOMgpdKRmvWFi4LmyLRMQO+9qYcWR4n0SZQP2TLgxrvYabLjUw9bWsiSt3SkEzhd4xa/NeJaqGogw==
X-Received: by 2002:adf:f585:: with SMTP id f5-v6mr12325542wro.59.1532471960326;
        Tue, 24 Jul 2018 15:39:20 -0700 (PDT)
Received: from we.local (athedsl-4407117.home.otenet.gr. [79.130.175.61])
        by smtp.gmail.com with ESMTPSA id j9-v6sm33942641wrv.5.2018.07.24.15.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 15:39:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 9389C640816;
        Wed, 25 Jul 2018 01:39:18 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4gqJjw3gndu6; Wed, 25 Jul 2018 01:39:18 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id 3367464081F; Wed, 25 Jul 2018 01:39:18 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Staging: octeon-usb: Adds SPDX License Identifier
Date:   Wed, 25 Jul 2018 01:38:50 +0300
Message-Id: <20180724223853.10198-2-tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180724223853.10198-1-tsotsos@gmail.com>
References: <20180724223853.10198-1-tsotsos@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index cded30f145aa..cff5e790b196 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
-- 
2.16.4

