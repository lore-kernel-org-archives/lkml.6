Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781DCC282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 18:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7F72146E
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 18:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpOp4qIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfA0STw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 13:19:52 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32798 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfA0STu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 13:19:50 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so10273601lfc.0;
        Sun, 27 Jan 2019 10:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k4K07+PMA9omMHyycWXsghoi13jqHOsNkg22kq8mIMI=;
        b=fpOp4qIoxQDcbky2gQSqWxhKcHdQ6CXA31S2USbRlYgocXKc/AdyAQSWcSjDFFPqJM
         hBoQbVOm/xIUwnLuxJBAWkmGQP2dMZ8idu0VeTTZGYX/Ak8SOC79XeCcrqZSz/1qjsOh
         j30dPVFpp9GYx2vUxM6jvEzumP6JDuVjVwiw0JXmax1GyoOQfqsWp/Kgo1WqA4EAR2f5
         GC4Yh34EB5wCeFPYbSaOkloo9Rj2tGVTpuWzoEM3f0+HSi+/rJW7l604nUeOUDtT2D8c
         kNz74jXMfmwCuD/De/mqyUFlD+I+QdvDB7fOakBdPUU9AniEz65CUYTumOE7lU1Zpqre
         rNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4K07+PMA9omMHyycWXsghoi13jqHOsNkg22kq8mIMI=;
        b=LHAgnnGKUK2e+r65ga9nNPWaYAQDf2qMHeABpcg64vhcFvOmcZFMSQiu4EF1D8RVxm
         xT/JA88UAXy4F09P1auNwzbYwFJfl2JoNxDmk2FFSmt/EIdfrTbK4Oq6ZdCKElgxOgfF
         GNuWvW7lFf6glF/ifNBE92yQFSOVTzJgx5vR9Bsnsg8xsDTzFxhHG384sDn54tIPdHoz
         CpvZAAvqQCtA4VXhAipq9fr0Q2N5/Mbl+jtCIRi76Zsqnb8VN74i+ZmdumMSr/xxFoif
         7I3lGCDwi/nDkHPLvjYqNoA091x6Y69yw7oyfXvmx3+cCyig1VXhM0ZfQEOFankrYcnB
         gXJQ==
X-Gm-Message-State: AJcUukfp7iqYkRPAdXuQNZPxqMl7MSZVghuJ3tJkLthNlqHsgFFumy7r
        FE9kkPP+Ybdt4R3GC+SiwVvC44sfnGM=
X-Google-Smtp-Source: ALg8bN6NTugbKTnDfHMnyaWnjdw5A8CYS4XUpXAwBfti9Weu7WihaoXdxKlLIZIhP7Ju3kqiM7M5Eg==
X-Received: by 2002:a19:5d42:: with SMTP id p2mr13869526lfj.83.1548613187526;
        Sun, 27 Jan 2019 10:19:47 -0800 (PST)
Received: from arch.domain.name (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id c20sm2518923lfj.67.2019.01.27.10.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 10:19:47 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        johan@kernel.org, robh@kernel.org, jic23@jic23.retrosnub.co.uk,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH v2 2/3] dt-bindings: add Plantower to the vendor prefixes
Date:   Sun, 27 Jan 2019 19:19:15 +0100
Message-Id: <20190127181916.19948-3-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190127181916.19948-1-tduszyns@gmail.com>
References: <20190127181916.19948-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Plantower to the vendor prefixes.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 3cfe0c8b8250..fa391a650f3a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -300,6 +300,7 @@ phytec	PHYTEC Messtechnik GmbH
 picochip	Picochip Ltd
 pine64	Pine64
 pixcir  PIXCIR MICROELECTRONICS Co., Ltd
+plantower Plantower Co., Ltd
 plathome	Plat'Home Co., Ltd.
 plda	PLDA
 plx	Broadcom Corporation (formerly PLX Technology)
--
2.20.1

