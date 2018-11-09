Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5380CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1818E20989
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="wmoUDSzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1818E20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbeKJHnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:43:47 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46616 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbeKJHnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:43:47 -0500
Received: by mail-qk1-f194.google.com with SMTP id q1so4345309qkf.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 14:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p/X2wTrJ6gYWDUzneo6iXqbAQE6eHh9pqWoFFxc0EC0=;
        b=wmoUDSzotsDenF8P/rn6XCX+3Nvyw/DHS1nSNmLnZhKNDT//HdfFX+D2iNyL3j2qnw
         V1QSd7PegcnNJyRqQk45n9JXjsRm25AYoG8sbD1E8oBc80DqX584aVSWDVws+LfruM5o
         Yzy5WvQrHThJqlRM/+iGwx8zqmBlKTjWVCq4tZrDHRekGhQy+pGMaXXwbxI6hJl85AXT
         gjOcJbdpjd0Kxmi1nWfPOkgO0UycZv341ZaXNEI7zML370or5ZhdqBcmKbesspcK67h3
         IVwEmyhnrOBsPHUQkyB4YALHYi+hcjjrcNMqHJAFlM35pvU0uKsvjoBO+STb2DDC9KS+
         8drQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p/X2wTrJ6gYWDUzneo6iXqbAQE6eHh9pqWoFFxc0EC0=;
        b=qDDSRhxHVdLdAXniKc4l9tANUXj1jRseCOLZoQ43E9h/AC4jbQPzXzTdSt1Y1+QHhW
         udxBT/nUwueKtExrO5gk5EUAojCaccY4Yy9MLW3qBoRKb+R1UJLzpYhsWHVyNCVt2vpK
         ljem4rAfrXS24Fz3m3ghgYSisX2srl4f2HmTHI2ZRO+Z4LNWy5NcRELDmeAR8VqPMOVU
         I2pgCahm1cWXloRxi0eUD0MpIP4TpBNgvPjDz7wWmFxV0jv0dgQuoVWT39VfB+knjFNu
         mxn+IEbYnq+10VqBI9C4bCG6YVLBX+40U2+Tz9mZo4slfuH11mxF4I/hKbl0BqMhh1dT
         8/Fg==
X-Gm-Message-State: AGRZ1gIPHT0nkMTF+KSyYIyVh74FVMSchEV9JchqY3UTyI22kHoTZzdz
        CPiu3XqpwKkSU7s4L+LIFZa0uw==
X-Google-Smtp-Source: AJdET5c4499jCQYATZXq5CRhTmGFUouxLzNMM3xSDS6kbgsFFUifZUFIKbZPqH16Y0+g2RUWTjEk7A==
X-Received: by 2002:a0c:89e9:: with SMTP id 38mr10609001qvs.31.1541800876402;
        Fri, 09 Nov 2018 14:01:16 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id k6sm6082723qtk.41.2018.11.09.14.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 14:01:15 -0800 (PST)
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
Subject: [PATCH 1/6] staging:iio:ad2s90: Add device tree support
Date:   Fri,  9 Nov 2018 20:00:39 -0200
Message-Id: <20181109220044.24843-2-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181109220044.24843-1-matheus.bernardino@usp.br>
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device tree support to ad2s90 with standard
device tree id table.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 drivers/staging/iio/resolver/ad2s90.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 3e257ac46f7a..ff32ca76ca00 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -107,6 +107,12 @@ static int ad2s90_probe(struct spi_device *spi)
 	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
 }
 
+static const struct of_device_id ad2s90_of_match[] = {
+	{ .compatible = "adi,ad2s90", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ad2s90_of_match);
+
 static const struct spi_device_id ad2s90_id[] = {
 	{ "ad2s90" },
 	{}
@@ -116,6 +122,7 @@ MODULE_DEVICE_TABLE(spi, ad2s90_id);
 static struct spi_driver ad2s90_driver = {
 	.driver = {
 		.name = "ad2s90",
+		.of_match_table = of_match_ptr(ad2s90_of_match),
 	},
 	.probe = ad2s90_probe,
 	.id_table = ad2s90_id,
-- 
2.18.0

