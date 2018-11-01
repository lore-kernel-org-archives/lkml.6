Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905A0C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548AD2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zqu4lf9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548AD2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbeKAXrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:47:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45200 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbeKAXrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:47:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9-v6so21292759qtj.12;
        Thu, 01 Nov 2018 07:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=50YKaMUXZTtrepHYaXBxTyw7j/sLoX4pes7YMM1sdIA=;
        b=Zqu4lf9LEdI0JPVj8jo6iyJKhAc3Vf1Ky5bh/jyecME978KCvUvdi6l4PsE1BNFwrI
         i+9HOGB31BBMkKmiAamykmx//rwpewgM4H1L99OfohOKOxhaI74dcvaq5tbfY6U+KccH
         j2wueHie5ZOmiFvws8m4wFIPmauC+amohBSPban3Y4XpvNqOOw8RnecAgqibx/ING8qX
         XU0TgfSxdEmJvHx49PyCpimd4PVTRXiuPDLsXl6uoFd2/3UN/4uVZyRiwDEO2M/XR6VW
         1nuyLoMZPAjSyMHUKmFGXR8ew+jyBQS86zNI73sYoi+GnIHKpj79UeRWfb1JgnPu9tOC
         jTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=50YKaMUXZTtrepHYaXBxTyw7j/sLoX4pes7YMM1sdIA=;
        b=HJvQIwA+yzBaqNDrJR0sLtFmpH4HM60H/x6fsJphqegRHjp0VxOsklhDQpCDTUA6BG
         gv/rcZIKO0uKpQpbs9erDgQQE/KPmDTgeIGu8aA7aWaFZsvoA6gkK3RN4CaXR/vMkP8D
         Xf9VDF4MLAI46yH+NMw3iBuJmHIDV24S00o2hvDMe+HNF7ul7h5tSUWJoS1sh+g3efaK
         416D/CnL6m5wA0nAYgSFqz8PgbT78rX2KfH4BBsoXK35mfvNeuWFMz+62I/dmCXu4VVd
         gkdNWYZekFB0P4FqNu0tA4Tj8k9a7H4hn8+lmRIFPqzWadoMzRFvcYatH9lJBcg2UzeZ
         OGhw==
X-Gm-Message-State: AGRZ1gLjtgr3B9u9JvcRr1UVKbZ6UdvV+OfZNzv+OuRNFZY2rb6vl/YW
        6LF7IqDaiTsVaImt2ByjRlo=
X-Google-Smtp-Source: AJdET5eOnG5jnq5AI+JLmbs8efVFFw9CoUwubLYmzm7ARmwiWtyezKpVw1jfAKBmdODus7eKY6NfVw==
X-Received: by 2002:a0c:ae76:: with SMTP id z51-v6mr7098225qvc.108.1541083426113;
        Thu, 01 Nov 2018 07:43:46 -0700 (PDT)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id l123-v6sm5729208qkd.95.2018.11.01.07.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 07:43:45 -0700 (PDT)
Date:   Thu, 1 Nov 2018 11:43:41 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        giuliano.belinassi@usp.br
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v3 3/3] staging: iio: ad7780: remove unnecessary stashed
 voltage value
Message-ID: <d6b6aeda46121f59a53b43599bf0200580d7a79d.1541082656.git.renatogeh@gmail.com>
References: <cover.1541082656.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1541082656.git.renatogeh@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unnecessary field int_vref_mv in ad7780_state
referring to the device's voltage.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
Changes in v3:
	- removed unnecessary int_vref_mv from ad7780_state

 drivers/staging/iio/adc/ad7780.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index f2a11e9424cd..f250370efcf7 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -42,7 +42,6 @@ struct ad7780_state {
 	struct regulator		*reg;
 	struct gpio_desc		*powerdown_gpio;
 	unsigned int	gain;
-	u16				int_vref_mv;
 
 	struct ad_sigma_delta sd;
 };
@@ -190,9 +189,7 @@ static int ad7780_probe(struct spi_device *spi)
 	st->chip_info =
 		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
-	if (voltage_uv)
-		st->int_vref_mv = voltage_uv / 1000;
-	else
+	if (!voltage_uv)
 		dev_warn(&spi->dev, "Reference voltage unspecified\n");
 
 	spi_set_drvdata(spi, indio_dev);
-- 
2.19.1

