Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBE3C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DAE20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="t+XuVKzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfBVUcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:32:25 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46501 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfBVUcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:32:25 -0500
Received: by mail-qt1-f196.google.com with SMTP id z25so3980158qti.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 12:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tOKqtonCY30q8dxTzna/mDA4QR3QSgJhSBf9tddOgk4=;
        b=t+XuVKzGZRrGmPDJ2QMgATI+pISA21Qec2yko9tT94Viga8JYrqL0LqN8lAgJ953Xf
         RGSlRI/b1hInXT9bUhDLFAJ3/yMsumZVkI/P0Uf1aOPveXuSnDiCp6U+rcVXqRqUVR36
         1LyDDzu4U1LnqbaamQvXq8KcNv6q4hVsVLLEF3209CZk/hWiRwFqvjM6X6HMrGU9Rqgl
         roWztz89gVX/t9QAtNfA/+QS5PZVx9tRIeGwbipURj/qhBSwqcK/GmAC7qPNW7Szetw3
         Qdb95U2ns9MC30sjOz293tG+0M0arkcPgcEpqiO3AxMxPKytjGnF2qR3cwGykHq6zxN7
         69uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOKqtonCY30q8dxTzna/mDA4QR3QSgJhSBf9tddOgk4=;
        b=pe9B2zdMpkkOwKgRq9a+npREv2hXiRbIWZYIGjvQAoejLFKBhMRpvJ6CDfi9Xa3oYJ
         UdYWGuC6s+OqTydFs/B3x9TVd0CMZu5CjfWXUoeS6aK4AfVzZ2c0wKduTTyMFSE7Wmlz
         5/cRW1rf4nc56/gHLcoMKSUQwChOGYRFLmyW4GZdM5MC8k6Dwf5J/c69AWTd6zRxZqur
         S8MluYPQbz9mp42PJ04agknzrAl0S1raZkPominE2U2aAnZw8j3+8ypLAqAPUJP86gWF
         PGlSL/IUHLfackAWxlxCwtikQeIbguAA5R5nvUL68V++vQfSUOW8Fp8N7bFWKBRwkEd4
         +aIQ==
X-Gm-Message-State: AHQUAua1y83ok48iTs8nAxkNBB1Az5q29nsehpNUBP+kmy6k3CTQiBwY
        sUrlwb8uSE/9q4lqmb7A9+H/Ow==
X-Google-Smtp-Source: AHgI3IZ1wiTsQxMHvrBSouICUS7/WaLhE49ljQUYafXnFLNtmTPrD6C+vhGB2c/S/skD3jWKdwCcfg==
X-Received: by 2002:a0c:fb10:: with SMTP id c16mr4609710qvp.187.1550867543865;
        Fri, 22 Feb 2019 12:32:23 -0800 (PST)
Received: from greta.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id v26sm1449149qtk.22.2019.02.22.12.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 12:32:23 -0800 (PST)
From:   =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
Subject: [PATCH 1/4] iio:adc:ad7923: Align broken line to parenthesis
Date:   Fri, 22 Feb 2019 17:31:56 -0300
Message-Id: <20190222203159.15116-2-barbara.fernandes@usp.br>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222203159.15116-1-barbara.fernandes@usp.br>
References: <20190222203159.15116-1-barbara.fernandes@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get broken line aligned with parenthesis on upper line. Solves
checkpatch.pl's message:

CHECK: Alignment should match open parenthesis

Signed-off-by: Bárbara Fernandes <barbara.fernandes@usp.br>
---
 drivers/iio/adc/ad7923.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index d62dbb62be45..ebae7522710a 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -130,7 +130,7 @@ static const struct ad7923_chip_info ad7923_chip_info[] = {
  * ad7923_update_scan_mode() setup the spi transfer buffer for the new scan mask
  **/
 static int ad7923_update_scan_mode(struct iio_dev *indio_dev,
-	const unsigned long *active_scan_mask)
+				   const unsigned long *active_scan_mask)
 {
 	struct ad7923_state *st = iio_priv(indio_dev);
 	int i, cmd, len;
@@ -181,7 +181,7 @@ static irqreturn_t ad7923_trigger_handler(int irq, void *p)
 		goto done;
 
 	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
-		iio_get_time_ns(indio_dev));
+					   iio_get_time_ns(indio_dev));
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
@@ -314,7 +314,7 @@ static int ad7923_probe(struct spi_device *spi)
 		return ret;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-			&ad7923_trigger_handler, NULL);
+					 &ad7923_trigger_handler, NULL);
 	if (ret)
 		goto error_disable_reg;
 
-- 
2.17.1

