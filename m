Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C84C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7C3205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEbf1YsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7C3205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeJPXxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:53:37 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36454 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeJPXxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:53:37 -0400
Received: by mail-qt1-f195.google.com with SMTP id u34-v6so26315403qth.3;
        Tue, 16 Oct 2018 09:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Fm7LQ6Ee/qmZPDvQzx23oHRkOmSWdmtFc1gf6S26jyo=;
        b=dEbf1YsPhh/p4IXtzRINILDEPBXKs8fTk4OK4jDU20JqXdO17XWzfWx2chgh+NaPLM
         ib6ty9f6NDv91fmEc2FVSbfOgwFPwOI9j0I1gDX3IPMt2rHhnBumSLf47Awis9V5Qa70
         B6/DK2vg5fGUAKQ3e1BX6/NROpS0oYnCmIMjy1LBOtvVULG3eP66cCiCmOdug1TSjxTz
         fBFTPx967hp3PDsWMKRFZHrhgoxZYYnPXbPm2UUhCzXbTOjwU7zW92D240yb/yZEtoEg
         gCF4B6rG6w56pJkZvV1JDDe87o5O8Ye3rukvdrt9KzQcrU1++Vod40nI2IdXJgGAb2t5
         /21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Fm7LQ6Ee/qmZPDvQzx23oHRkOmSWdmtFc1gf6S26jyo=;
        b=pPej5M76GQsTjWDx0prUQJMFa3iajCQC5O+djV5n/MeCd40HRhNkWOdHD8aADuESpc
         yrAbKiE0iqck43Cuc9zyfJJC079LB7JzQCIlAXBrIvC9RSKDb9znqaZr80iDgSnoh0gt
         8V+3GCaPaQilnNpuFC4yT8Be19esUJScdQg8TAwW+EpLjmpVeljM41YyVQOOCjVxBfyd
         6AYw0qD/+x1h8WvSPCJEsK8e/vOjVwzdHQIIH8xGKtr9A1b6lYDHJQdl6Iac1uqTvB/6
         djycwTEZ/c9g6v7eFJk99BidnEML6yATvhtygA2kjpk0qu8EACV/ndbbz/IDNeoSPr+N
         UAIw==
X-Gm-Message-State: ABuFfogVFfwyJjGmPoyISF6Zmw5OOdQRg11dF9UE9oU50X79jeUycEPi
        PoeKkHmLPC/hm/tF7Z58Kgc=
X-Google-Smtp-Source: ACcGV60S3aGNFuxvRIezvLYn+RkZG+dgYPSUmpqmtarC5g5k9q9NYj4Dq2LkbiisTkjzsPg+lVJZew==
X-Received: by 2002:a0c:db91:: with SMTP id m17mr22071309qvk.166.1539705750870;
        Tue, 16 Oct 2018 09:02:30 -0700 (PDT)
Received: from marcelo-Aspire-5750.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 18-v6sm9445507qtm.13.2018.10.16.09.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 09:02:30 -0700 (PDT)
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: [PATCH] Staging iio/adc: fixes parenthesis alignment
Date:   Tue, 16 Oct 2018 13:01:04 -0300
Message-Id: <20181016160104.6276-1-marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes close parenthesis alignment to match open parenthesis at
iio/drivers/staging/iio/adc/ad7606.c line 379.

Signed-of-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/adc/ad7606.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 0b728b6ea135..230faae38c12 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -376,7 +376,7 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 		return 0;
 
 	st->gpio_os = devm_gpiod_get_array_optional(dev, "oversampling-ratio",
-			GPIOD_OUT_LOW);
+						    GPIOD_OUT_LOW);
 	return PTR_ERR_OR_ZERO(st->gpio_os);
 }
 
-- 
2.17.1

