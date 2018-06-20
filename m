Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1F8C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA471208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOEfEQBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA471208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754762AbeFTIhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:37:07 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:32891 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeFTIhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:37:03 -0400
Received: by mail-lf0-f67.google.com with SMTP id y20-v6so3694746lfy.0;
        Wed, 20 Jun 2018 01:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O0vJUcT4Mc+H9wUe3QEqBqdbXIDak+uMs4CoMKKvHTA=;
        b=JOEfEQBIjXYzn/vuXqmXtseykNqihRjle8cAO6+y8a2RNR5NEsZdgwNZYZXe5W8DlU
         FxQ9e5qB4Q/49uhwJ31J6D46pxmYHv/wKFp/hnloFjPEmA5n5R1NgCWDAVMXHWPpMKPT
         JMWi6osjOak7enZbxoD1FowlsMq/xM2wBC9WA/lcrW9apzA4T92/UlsQLa8ohWtFhRhs
         3rJLsJLTUP2oQaJqvHIF/ASMY9ArvlpgHy+57NSux9eGMErDagKDMEtk1nmj85VoaN4O
         HXlIxaRKzXkXdPPAb9nBAE56TD5wESt6zsNLYsb3OhYUdwrD375PclvtUPg56OnrYXlU
         junA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=O0vJUcT4Mc+H9wUe3QEqBqdbXIDak+uMs4CoMKKvHTA=;
        b=gt1rLL8F9nbYa1fjFktk89IPFdTlgSbHo+qjFPREQv3sg1LMHMjjgcF1F1N0mzTikV
         l2umoIbjRLTH60Gu41xxNRsG/46Crr2CSO7SZ/p1VJTwN3eivurmtjQyLxb3Bw9wsMg8
         YB3fQUGluhYWMb9vAIpU5l+1VFsOZUEODqjfF/dEAJQWEF+vWkmjnLzMxvcjuQ+12bBp
         Az5fLN8+XypZOTSqH6AT9DGQ6Y2eBLYcu7I1lQzu2D5yffE7tOW+R95Ckj2NcbSq6Zvy
         /i1ZR8HqwRiBiNJeEd+eMWjXt3+BPkh0CMqf1Mn1Xi8iv9i0vLNvWNQ6iHo91K0rq91k
         ZTQA==
X-Gm-Message-State: APt69E2aXMpSzVxdOzVfPMjoBlh35rNuU0kSGrSIXfXj/RAuutYigwxF
        ySiPOJNKOk0N38hEGmsCFuv59W92
X-Google-Smtp-Source: ADUXVKIP8Y2GnxEm65O8FXJ+02vDfRNfBpq3ZEqpSi4vqCdXN48UsexTr5SlIT08E5V9ICkV0HI2Ow==
X-Received: by 2002:a19:ccc6:: with SMTP id c189-v6mr3044347lfg.88.1529480087204;
        Wed, 20 Jun 2018 00:34:47 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id z3-v6sm284167lfg.47.2018.06.20.00.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 00:34:46 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 01/12] spi: spi-fsl-dspi: Drop unreachable else if statement
Date:   Wed, 20 Jun 2018 09:34:31 +0200
Message-Id: <20180620073442.20913-2-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620073442.20913-1-esben.haabendal@gmail.com>
References: <20180620073442.20913-1-esben.haabendal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

The if statement just above this if/else statement triggers on the same
condition, and then invalidates it.

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Martin Hundebøll <martin@geanix.com>
---
 drivers/spi/spi-fsl-dspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 0630962ce442..3ca9b9608801 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -593,8 +593,7 @@ static int dspi_eoq_write(struct fsl_dspi *dspi)
 			dspi_pushr |= SPI_PUSHR_EOQ;
 			if ((dspi->cs_change) && (!dspi->len))
 				dspi_pushr &= ~SPI_PUSHR_CONT;
-		} else if (tx_word && (dspi->len == 1))
-			dspi_pushr |= SPI_PUSHR_EOQ;
+		}
 
 		regmap_write(dspi->regmap, SPI_PUSHR, dspi_pushr);
 
-- 
2.17.1

