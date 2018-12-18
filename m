Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE078C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6FC214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VLm5OZtM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeLRAKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:10:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46455 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbeLRAKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:10:09 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so6888052ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+xxpTAjzTNqqNaFYU9Wyu+uP/lSy890ha1exRAWavCw=;
        b=VLm5OZtMkWQ/pMzVbrc49sZ6PvDkO2XPQFe/fs3gvWtJEW/jhCdq6Pfkl8e36DkTuq
         cd6rEFakFg9/axu+4ub8GYUG2TusFfGw4GYt3YjVfdBKYXBqCWlLnqIGpsFdnyaS8Fnv
         np2iERdSEoxG491VynQDJh/wAh3BHb/PRYIzBLKumJaCGPXetYpWKvhPVv9v7Vl3NlGF
         yT/cMiM5kb2gQpLHPoQWA77KiV7heJcO+nf3nKgo8uRAsaBdpJu53FiGIBaTvD7uV7NJ
         QPJW9iIecwD/VOnDi2sUSiXrKfIAMpFuNae75t9xXVXjULOcO9osUr+eHpUo+dIzRKMw
         +oKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+xxpTAjzTNqqNaFYU9Wyu+uP/lSy890ha1exRAWavCw=;
        b=h8UnP+SNA69VMvBqkrMdYgnmqlM1rCayj6VxwUNXsz3zkBo3y5W7rZp9Pi1f6M5/QR
         i4zVjkJ20vbEl7hPWErqAIer2FIsvrOi1mFopsbVF0nJk1ONltEAY+ZPkP7YSTxnew1h
         gWZzi42sUx1VeAx2I/j3UmJwDVQLXHXLEqxOGvmtp9OcNQbdVpnZl6BM/KzLDoonaQSj
         FtqqlgcqVOHwuD5Q+PR0rmVou7OVapbMUGcQ9yJHzCqB5u0EMRsaHrfj/ke+mmi9gIgh
         +VeCvvM4ZOPY8FT/FEt9AxKJ3ZDiC9ruVlz9M/aE+VC54D44EhUf8+CmxGncJ0EijG0j
         IuCQ==
X-Gm-Message-State: AA+aEWaOFOVckYV0D4yCFUhbfJs0IMqeAAo4rNPWS2cTrdk3Ll08Bt2M
        8Fg27CFdYDU6KgBWnSXNRsNp+3GAOzs=
X-Google-Smtp-Source: AFSGD/WlraVBlHzckQEn1dhauv4TW0MKPRrgrD1BS91EV6LDT3JwZB+TCPzJGN3rDpuSGOL1+pZL0Q==
X-Received: by 2002:a17:902:28c1:: with SMTP id f59mr14475737plb.37.1545091808554;
        Mon, 17 Dec 2018 16:10:08 -0800 (PST)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id d25sm20878535pfe.40.2018.12.17.16.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 16:10:08 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] MAINTAINERS: SiFive drivers: add myself as a SiFive driver maintainer
Date:   Mon, 17 Dec 2018 16:09:59 -0800
Message-Id: <20181218000959.31352-3-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181218000959.31352-1-paul.walmsley@sifive.com>
References: <20181218000959.31352-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll be helping Palmer review drivers for SiFive-specific IP blocks,
so add myself to the MAINTAINERS file.

Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b48686f02516..a8e5346023fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13622,6 +13622,7 @@ F:	drivers/media/mmc/siano/
 
 SIFIVE DRIVERS
 M:	Palmer Dabbelt <palmer@sifive.com>
+M:	Paul Walmsley <paul.walmsley@sifive.com>
 L:	linux-riscv@lists.infradead.org
 T:	git git://github.com/sifive/riscv-linux.git
 S:	Supported
-- 
2.20.0

