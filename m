Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2957C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A25B20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVHDtBEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A25B20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388938AbeGXXbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:31:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34006 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388572AbeGXXbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:31:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id c13-v6so5555762wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 15:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oQ1hrQIbXo4ILuEEm0+/82cRNiOE8p1XgzNfg9kLRKo=;
        b=QVHDtBEZEfjuUV+uNnZFAUuZ4M1gsUyWevG4Jwhhu2Xgg2h019TTeZuJCWPPem4zXF
         ZRlkRASep1yNKKjKMMQKBwU6nLbqed51cuQg5KzkUrl/vAbrXbYxIDuWB2b288BRWy9e
         IwL2V7am+YL9mSWxA8BrJWR23wYOR0dw05XWfuC0+B1gTgoja3Ci/5hwzxnCREi5/QhM
         mA5XmHFzAt/ty8B6KlBLPZgYHgPcigl8yuDcWMLMO0bI35a1qRX24Hw8lvn24Y0BT9xM
         wFho61fiuTEnOWb/sao8PMgYipHEQzkQ3LsKvuZkrSRY9M5bTYrpvzvBGLKEwbnrVeIW
         60Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oQ1hrQIbXo4ILuEEm0+/82cRNiOE8p1XgzNfg9kLRKo=;
        b=uABLQb9QSxLQdvYzp8ZB8Tkc09LdW/fFyuJNc38yUu6W2UbjPBmmAqCWd6kd4kX5PA
         31pc3ji7dU3xjqLxXSQxh/w9YLzW6+9fjmGbhD5eCwx+OISk2jO9jSnoQnG4HlQCPRyp
         QFGZQxpbwb7z9C3bjgK6Cxp1KxeZC9L076hGJVlp0G8gofBrKDt8F+3ayd/PqMXjFpUv
         1HNBh/+Uuv+80LgeshnmHmGfm3LNtRfd2JzJhS6cGswFvwy9KzH2FyqX6hzNbmN1kLmU
         hhYHS2hBtsD6Il84bao1+yNNb4M2hkN9qI6eGKSLBHqhL+81zXWOopt7NKcCJDy0hSht
         EJpg==
X-Gm-Message-State: AOUpUlGd/JOT2v54+V2zQl5qz2PbZuvhjsDu6OxwO1/WcDJx6kGqVqKC
        7Heezxx5Hu/3h8w7qqM9QTITaowNdWnEWA==
X-Google-Smtp-Source: AAOMgpdCmfCxsiC3or0vR5PCNfj5cOkSKBX1Nx/ZiMJA0Dzq6C87q4Xk/3yLzFd+PmXYKZIcbRCSaw==
X-Received: by 2002:adf:9051:: with SMTP id h75-v6mr1186412wrh.65.1532470946516;
        Tue, 24 Jul 2018 15:22:26 -0700 (PDT)
Received: from we.local (athedsl-4407117.home.otenet.gr. [79.130.175.61])
        by smtp.gmail.com with ESMTPSA id i205-v6sm4808107wmf.30.2018.07.24.15.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 15:22:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 0BC8B640654;
        Wed, 25 Jul 2018 01:22:23 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0pdWCoLTOKKS; Wed, 25 Jul 2018 01:22:22 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id 64B3A6408C2; Wed, 25 Jul 2018 01:22:21 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Staging: octeon-usb: Adds SPDX License Identifier for header file
Date:   Wed, 25 Jul 2018 01:22:11 +0300
Message-Id: <20180724222212.8742-5-tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180724222212.8742-1-tsotsos@gmail.com>
References: <20180724222212.8742-1-tsotsos@gmail.com>
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

