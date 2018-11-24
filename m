Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62767C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2934F20672
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="E3F06BDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2934F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeKXLKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 06:10:13 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37371 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbeKXLKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 06:10:12 -0500
Received: by mail-qk1-f193.google.com with SMTP id 131so9328223qkd.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 16:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=07HrCrFZL57ZGZlRkcwu/SANaQ8hX/F5vvNeAxNUWcY=;
        b=E3F06BDcpX0tUcZvT0Jo7RVs1E5GIE0VOaYvWYEOin37vDa9EWyzNtT50IbjDu3Zrk
         bPlXPC+Nr9wqHn2SMDw6r0rxcdhxZ88RMzBkrryevFlFAokbPyygTRtjjgueKZiI3xb/
         p/8tQtwBlbdzyAXLkDD5klTVJsYYS+LxtDBsMHHLUh7d38bmspyFxpNA8eck0cicyuCi
         nOjX7yUvtDgtX151c7mr0GEN652XEhWiyHOER9Ill8LtY70YikaOwvszKP8l3VaZQ9Zq
         nuJAZAScydVuHMaFQ+/KEyzgv5zfevYI1FT8o9VZBvG6Kql62EC3pXSVi9YebzsoEhKo
         7Vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=07HrCrFZL57ZGZlRkcwu/SANaQ8hX/F5vvNeAxNUWcY=;
        b=LfY+QFAeSHQuBsP8uj9IDas13IDaNC4/wflsAPEA9n4nPRZhW0IbcCs78E3txnfb0a
         LERNJRJlhHoGwAId9Z6zzvJYpF4g6MtYFy7ac214qCmVyrOzpIEeZVNj2hkhpHJbW3x0
         WRYaXOac+1A2Wm4jm20D92ScPAh+KKS8RoxPj0tBAplPM1XGDs4m5lqU31XxFWtchQv/
         Qc8w7Ae5PR1c2hOPlzVWXkXkObYBbp1yFRb6I3reklCWU7m6yhT7+VI4l6ow3xrBrAxd
         ycoPMWfXWiaJKiLq4AXRUMts3qwHeaVlo+LcGqwgj20XoxUKLnw0ye0g1o/CHbfoEH3U
         DkwQ==
X-Gm-Message-State: AA+aEWYsULbM+1avLBp89MNY6ZBpTZldf+/f6m7oSXwy9p0CHjaXujK1
        EjHGv0lbS308uImh1BaPAX4AIQ==
X-Google-Smtp-Source: AFSGD/WvA4JhUtrF9ncsJzkZ277oEYuV5h5A4ZWhv2NcIkM6QSk8ydm0BlHJxxEtwBrNBEv0KZI+sA==
X-Received: by 2002:a37:9745:: with SMTP id z66mr16219119qkd.170.1543019030566;
        Fri, 23 Nov 2018 16:23:50 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id o34sm26707515qte.4.2018.11.23.16.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 16:23:50 -0800 (PST)
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
Subject: [PATCH v3 6/7] staging:iio:ad2s90: Add comment to device state mutex
Date:   Fri, 23 Nov 2018 22:23:11 -0200
Message-Id: <20181124002312.6923-7-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181124002312.6923-1-matheus.bernardino@usp.br>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
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
Changes in v3:
 - none

Changes in v2:
 - Patch added in v2

 drivers/staging/iio/resolver/ad2s90.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 678351dabe6b..a41f5cb10da5 100644
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

