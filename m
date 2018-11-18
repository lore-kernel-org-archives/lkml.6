Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD55EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 04:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FAD20815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 04:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="uvwj89TP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FAD20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeKROph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 09:45:37 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42582 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeKROpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 09:45:36 -0500
Received: by mail-qk1-f194.google.com with SMTP id m5so43850422qka.9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 20:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N7SE5k2/kjJlroE/hqa7PLw1ubwrNoiXTEWaxQ/jVx4=;
        b=uvwj89TPt4Vz2zNB3MJepCQYIRyg9kyolqdmOzvUlLNywL9ktKvo21COnbvKmrtPac
         y+dXtAm08z43OgC7iKGu6trN1tget4IG73wg6fKgWcROj9vPtQfU8B6VzgOTzMfnmVgE
         I63RKZvY2rl99aMiuMDF8/Y0i3tNW8dgWVQWAvvgmNF+J+bf7ILb41CJPBLCGtvuetTm
         DVEwA865My0c22oMadQfaMLMsYjp/MJh1EUavlZCvkO1PgKLhOmSdDcLz4qOHOs6xcrm
         vriISTBoEQqbUfZtcqQkaUtyqg2/4ZMzj0Yi1ldKMHp0OHz+8Jl1zEGzqZre6JRR6WYL
         l7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N7SE5k2/kjJlroE/hqa7PLw1ubwrNoiXTEWaxQ/jVx4=;
        b=b37pw5c9BaTaw9eZ+GiXfueKICZznot9vDYt+nsMBgDpKaCvJO+kjABGCrcPZu3AjH
         FvkWO6OqpvDMTnf10OgsTwUCjdGbSjIyfP3NOikKX0k7wSPqrBNzTG4jDTmB3nZVtSDH
         IjLd2GNwLWrPoJ5nhM4ulKLj2YyJJ2gecS7fx5GoR3MtYj9g/D9H6jLgissa6cbAQRby
         10xgWUvdCPyvlhwy8DYJqQZFEth8IhBCFvX2YJQbq+5AwgG8h02Lf8b//P37IdCKIEgY
         5MjXviaRZB2/V+dZkRwVjbzTZ6VLIQCZqBz0JgAJbFOlOM1VIC2eb0PrbC2Uw+aXS+YN
         oCiA==
X-Gm-Message-State: AGRZ1gIuY4RDqp4jUjQDOQdNW9kXYrMwxXiHzMSmT24RWeVKvxx4QStk
        RXdLWvWapJXLOFOQyp3iEh41hg==
X-Google-Smtp-Source: AJdET5eVr79WfHlHYTwUofNKvCstmNQvNRi7iWO7TUkvGvQSvCtZCqAyTZwg9nL+mpEcUGiBrfl35A==
X-Received: by 2002:a37:8882:: with SMTP id k124mr15806046qkd.1.1542515195685;
        Sat, 17 Nov 2018 20:26:35 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id b6sm16112350qtq.29.2018.11.17.20.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 20:26:35 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: [PATCH v2 6/7] staging:iio:ad2s90: Add comment to device state mutex
Date:   Sun, 18 Nov 2018 02:25:39 -0200
Message-Id: <20181118042540.12697-7-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181118042540.12697-1-matheus.bernardino@usp.br>
References: <20181118042540.12697-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Colombo <victorcolombo@gmail.com>

Fix the checkpatch.pl issue:
"CHECK: struct mutex definition without comment".

Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
Changes in v2:
 - Patch added in v2

 drivers/staging/iio/resolver/ad2s90.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 9aa229ba47e7..f04dc5dede00 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -22,7 +22,7 @@
 #define AD2S90_MAX_SPI_FREQ_HZ  830000
 
 struct ad2s90_state {
-	struct mutex lock;
+	struct mutex lock; /* lock to protect rx buffer */
 	struct spi_device *sdev;
 	u8 rx[2] ____cacheline_aligned;
 };
-- 
2.18.0

