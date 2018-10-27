Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE53FECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 02:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F5F2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 02:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="i+xRmGsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F5F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeJ0KkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 06:40:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36117 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeJ0KkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 06:40:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id u34-v6so3425426qth.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 19:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J5RxTErJXoIN4DFbUXbMSG5XxKyOAlaWHaLsxy5wXNA=;
        b=i+xRmGszyHXsGOlwYvMiG4mFJva9OV47BWT/Z+nYhns536kXMs/XgGdbGBHG/S4BxN
         8mN8DYXRMSdt18k9VZKU2X66CnIzj4g1QLZKanEEZQQ8K4l+xr95iE2uOn/CcoUsELtp
         f7SazgtC7jPXVEzlAIbPL9p53IrzqLQ6R065RxSGCEPKqBOBm9z4mTNgaXwPvgDEFD+u
         7iB+MJwboM7159+DtOh9T47fyyDeGW2P+PWrQgHm6DnzBTGp22LkCH+wm9T4vbsshU2l
         MLaTLK40A//QLvOB2e3p95hgTbSePyVBvvc9ChiL3aX79AxY+fPHWi4/MYHky1Bd0jgg
         kduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J5RxTErJXoIN4DFbUXbMSG5XxKyOAlaWHaLsxy5wXNA=;
        b=D9EH23hFNRsl/LAXpZT3syGfWoWJK9+fMCoLyKaFZRYSZnHk/5AwebrOsu5UBaOy3y
         8MPPE4g/Lj0qcwc/IP7t9/vauKR64LFLP/37U4oShPYKV/d0Qh7w/K+EMnRa+66kqkV0
         MS0prkPa7WzwOkNUS+UWUaPWEorhfpwpCsCjZ/MUEXHj+YBoGojHKSl+LDWJRQMy4H3o
         /g3F7lytfzzbeXBaxMbfmda3l09i1mtfAicNaU/slSAhOFmN654SGRM4vW/nOw4h40Nk
         M8QJsTqZxo8rRyCY1J0rHuuBNLdLa1Te0MqpOaA0Ws1nkYzwnYaoVYzXYjIY5dIJSfqD
         Tdbg==
X-Gm-Message-State: AGRZ1gI7tTu5F0NU/4UaDhFGjvJaRl8UvrEN6Lu0XEYqO5gsLIRCB9rN
        z6QrQKO0U3a8qzFtgr/6xdjQfw==
X-Google-Smtp-Source: AJdET5fwcBZGWVm1ZBdNb85/o3FMVCpcze2t9NbIlq4FYOEOZPIPT/rN+rFMPUNvkgVz3WJk0P4U2Q==
X-Received: by 2002:ac8:5414:: with SMTP id b20-v6mr5489234qtq.144.1540605644110;
        Fri, 26 Oct 2018 19:00:44 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id h67-v6sm8499777qkf.32.2018.10.26.19.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 19:00:43 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 3/6] staging:iio:ad2s90: Remove always overwritten assignment
Date:   Fri, 26 Oct 2018 23:00:02 -0300
Message-Id: <20181027020005.3140-4-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181027020005.3140-1-matheus.bernardino@usp.br>
References: <20181027020005.3140-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an initial assignment to the variable ret at probe,
that was always overwritten.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 drivers/staging/iio/resolver/ad2s90.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index d6a42e3f1bd8..c20d37dc065a 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -64,7 +64,7 @@ static int ad2s90_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct ad2s90_state *st;
-	int ret = 0;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
-- 
2.18.0

