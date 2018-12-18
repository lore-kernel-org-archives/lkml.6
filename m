Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A263C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498DD214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BN3FWNRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeLRAKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:10:08 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39357 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbeLRAKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:10:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so6914437pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/CK6plly068rh/+CFs5o4qKr3D96uAMmAUOa6f+NxKw=;
        b=BN3FWNRR5cRsbF5luyviBRgEiJN4D2us9/bAMJRH3ZFnBJXCeAAelpZv6EaY5chTI8
         l77xXjF6MTA7Yd4Aas2ad9FucBo91gQ4paqBzD5eQ+6jfevhIS1HGUcn9JJJ/hMBs8Du
         aKOHF52vcMJFHL2DuJQPY6ThksP14XbmopeQg9wD+gGCcb8WEzKh6/N+1Lclr+TJyzuU
         KP1POjiUbAVMkBW/KgdMNLY3Ldre1Vkq+0SCJNnc4I8ofVlhJHGDnIwr4Oueqm0+MoWO
         wNaSbsoUfs5MvI1151tLi+XgW0q5so6ShFvLCBAj/fGoF/uP6Oe2HGT1FP99ABCP/GmH
         7ZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/CK6plly068rh/+CFs5o4qKr3D96uAMmAUOa6f+NxKw=;
        b=spFwKA/Au3+XlUpH0k+dkxjE77u6Ofyb6tZPV0u/3qyyZfMxuHWOH5FgeTPibVpU31
         1+MhBi++hi8eVZKpLkpTR3KYPLUZaER4ARSAkBwYMszj+0P++JAvPlSpEoXj4WhJtQSr
         DMHgzA1k8X3MeMmNeNaPP+h/5yIbR8mmEU41omYChlGjb8vz80qgBaWr7IsAR6DxGqOv
         GZbylsfBZeqCqbmf8upd+fUguq8z9n7zXBVnWiPHHeDu+Txg648rvDYcdMuUHG6RKc64
         2zPgadyrF8M2wpDT2OHtLPIYc7xirQt5U9CX88IrFzvkBWYZr96eYGEkloPxjyMCX1MN
         XLAg==
X-Gm-Message-State: AA+aEWYsq6r2jvps4oDfii19cYKui0sK6kncjkdpwc4o7OcsT4yqf0a/
        /eXOcnnhJfPckDScRmbgHnlVj3lLhm0=
X-Google-Smtp-Source: AFSGD/UW5hVdo0uzlWys23bxQWh7GHHbsu1ngguBUQYkQoHfCap0PkrgNyOyuOsQd7jJpWm+MYtHhw==
X-Received: by 2002:a17:902:ac8f:: with SMTP id h15mr13978396plr.245.1545091804897;
        Mon, 17 Dec 2018 16:10:04 -0800 (PST)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id d25sm20878535pfe.40.2018.12.17.16.10.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 16:10:04 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] MAINTAINERS: SiFive drivers: change the git tree to a SiFive git tree
Date:   Mon, 17 Dec 2018 16:09:58 -0800
Message-Id: <20181218000959.31352-2-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181218000959.31352-1-paul.walmsley@sifive.com>
References: <20181218000959.31352-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the git tree URL for drivers for SiFive-related IP blocks to
point to a SiFive-managed URL.

Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3318f30903b2..b48686f02516 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13623,7 +13623,7 @@ F:	drivers/media/mmc/siano/
 SIFIVE DRIVERS
 M:	Palmer Dabbelt <palmer@sifive.com>
 L:	linux-riscv@lists.infradead.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git
+T:	git git://github.com/sifive/riscv-linux.git
 S:	Supported
 K:	sifive
 N:	sifive
-- 
2.20.0

