Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E2CC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8124A218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="ux28+rki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfAYMYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:24:34 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41609 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfAYMYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:24:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15-v6so8192165ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 04:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t213Fky0dlXC3LPSWsEKGnyugEHm5O3iqscObb9Pu/w=;
        b=ux28+rkiGYdzx/BIIXR9Dt412sbQF9EfCE0/FXheXQuGmB2DzBvMMITxFxJWwOE22h
         3yQmuz01wfISkJwgcJdXynWm+L+7Z/d7L1eMsJRyoObFIp62Hg3q387btvSi3Pa//NXU
         pm16WLR9Xi8poduFYMCrD8dEK5OZvRCl+uQ/Ic6MvhaLXIX4AF052d9ZYleMWdoeIfbj
         ACfe+s++MiRS7G/8OW3C4IfxX6+MRsNJtzPAvmshP4Asx6VOG97wCcOdgcJXYpmRXYgU
         8/1aL4GWaGu8n8eTFHmIyuDlXniAOSK9VwrmuOIyIVCRJWtr3/F+uMnkvgOm3T80jCFP
         xPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t213Fky0dlXC3LPSWsEKGnyugEHm5O3iqscObb9Pu/w=;
        b=fRPsgYEXzVceyPH7yTbUCGNTMihttJsHLKzlCxoqAKzZT77pAfD6heV/g+kX/x7srD
         jAN/a22gUzYdDGRvXdz3lDqbUzUYqFrppI3g84fQm0lrYYXGPgWBGtlhli3A1k06IbJa
         pe246NPGmTy01BNKuPmkFLLFFHmdK+8YXPRSbNt3fWbd01wo6OLtC8ir52wWa+wJuUOy
         Iff2fYY7PubQJmdv5v8gz0kUOggv8H1nDLIKO8h3u39XH8hvxs6fMte6tpeRLTnqaDrU
         pA+R52/PayOPqYBnhQL7Hu6nc6fK1+6SgeWEo5lB38GAhxtTxxa0r8hF7mMw3DU/VwKZ
         HElg==
X-Gm-Message-State: AJcUukeYDgKjRxLYSCOdqhYuysQRquLTaP6EMFzFsC04pNDO0gHom6Cp
        ySaFLk8kNcyV4oMOpuMsp4unm5zH2lk=
X-Google-Smtp-Source: ALg8bN6ETeWG1r6djfeHOB2AkscgnzjCeqWd1IFZk+1jbAwo6p8CArdmPo5QVMe7Mr11r3mPkFXm1w==
X-Received: by 2002:a2e:8087:: with SMTP id i7-v6mr8747843ljg.179.1548419069469;
        Fri, 25 Jan 2019 04:24:29 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id y81-v6sm1508376lje.30.2019.01.25.04.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 04:24:29 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Jonas Bonn <jonas@norrbonn.se>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] spi: support inter-word delay requirement for devices
Date:   Fri, 25 Jan 2019 13:24:24 +0100
Message-Id: <20190125122425.30676-2-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125122425.30676-1-jonas@norrbonn.se>
References: <20190125122425.30676-1-jonas@norrbonn.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices are slow and cannot keep up with the SPI bus and therefore
require a short delay between words of the SPI transfer.

The example of this that I'm looking at is a SAMA5D2 with a minimum SPI
clock of 400kHz talking to an AVR-based SPI slave.  The AVR cannot put
bytes on the bus fast enough to keep up with the SoC's SPI controller
even at the lowest bus speed.

This patch introduces the ability to specify a required inter-word
delay for SPI devices.  It is up to the controller driver to configure
itself accordingly in order to introduce the requested delay.

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
CC: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: linux-spi@vger.kernel.org
CC: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/spi/spi-bus.txt | 1 +
 drivers/spi/spi.c                                 | 4 ++++
 include/linux/spi/spi.h                           | 1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index 1f6e86f787ef..a5f20060676d 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -77,6 +77,7 @@ All slave nodes can contain the following optional properties:
 		    Defaults to 1 if not present.
 - spi-rx-delay-us - Microsecond delay after a read transfer.
 - spi-tx-delay-us - Microsecond delay after a write transfer.
+- spi-word-delay-us - Microsecond delay between individual words of a transfer
 
 Some SPI controllers and devices support Dual and Quad SPI transfer mode.
 It allows data in the SPI system to be transferred using 2 wires (DUAL) or 4
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9a7def7c3237..cd4d4065eca2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1692,6 +1692,10 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	}
 	spi->max_speed_hz = value;
 
+	if (!of_property_read_u32(nc, "spi-word-delay-us", &value)) {
+		spi->word_delay = value;
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 314d922ca607..e5200dd9d750 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -164,6 +164,7 @@ struct spi_device {
 	char			modalias[SPI_NAME_SIZE];
 	const char		*driver_override;
 	int			cs_gpio;	/* chip select gpio */
+	uint16_t		word_delay;	/* inter-word delay (us) */
 
 	/* the statistics */
 	struct spi_statistics	statistics;
-- 
2.19.1

