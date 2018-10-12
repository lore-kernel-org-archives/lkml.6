Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D192C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AD62087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="hX/XUZTe";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="CJ6p2Tzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AD62087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=raspberrypi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeJLQza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:55:30 -0400
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:23767 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727808AbeJLQz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:55:29 -0400
Received: from pps.filterd (m0102628.ppops.net [127.0.0.1])
        by mx07-00252a01.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9C9NGOW016000
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 10:23:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=from : to : cc :
 subject : date : message-id; s=pp;
 bh=mrY1CyvyMabVXJ4QRkAlmBNpSzFpNgQzn+xS2PQnbj4=;
 b=hX/XUZTeJkHwvSpVytO22tbsoZm5qmEKmmqfmVtEVYCHgSwMiEyEe1mNERxiPd4bDODv
 btkSvIcXQAEcTqhpGPE5FI0bj7HcOtsvu/ulrmkuzJwaY3WH/3ZizwUDQUvx/YGuSFzY
 TPvvgSDhVj5MPtJR8emTNr6W5jlvGYtJ9SQq7/r2oVAXRV+GN2lrz55LDDb2Gim13/Qa
 69quj0QDG1Rij75FnAvkpsJR88FB2uNm/evIhL/Ysl3eiArtxw5GfuekkgPrAanwq6xB
 g9m5T1xjrbccNYlSGzL/UFv0+MU4ibrxfzun0E8VmtI2UaZkX3BEIEvQwQLFfB49Iw8T Ug== 
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        by mx07-00252a01.pphosted.com with ESMTP id 2mxjf0k6tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 10:23:57 +0100
Received: by mail-wm1-f70.google.com with SMTP id i8-v6so5845078wma.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 02:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mrY1CyvyMabVXJ4QRkAlmBNpSzFpNgQzn+xS2PQnbj4=;
        b=CJ6p2TzdVoCwmiJ5ZAnw47FNynG2txzB27nI3xodJZW+NwTDd/Si4fr4XkLx+lfLIY
         ondqtZwEpVcz7V+pxTorgsr+LgWQA7u4FlF2G49EOryxk79Yu8LY0XWe8/dhpgLPKTO1
         72r4+2hXFXvnAysacdFRP/RDPTgHEqzX0bHHM5A5J8FpCo6XF85nQFQo6/DvnAefPA96
         A8EndvLNSZUOw1LNBeKu97LvBG+IfkFz3N3BR6uMD+tXDCsumi3Gomlbnl5Krgr9wwXO
         XgJHf0XVWSFQhxOVuC5Pn+iLI/kRx9F+H4OqqpioHJ/ldAeNqF3hDDeN/wLwAqv30IM/
         kGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mrY1CyvyMabVXJ4QRkAlmBNpSzFpNgQzn+xS2PQnbj4=;
        b=S2J8X8e+pUCrElTIRO+V6yjqSQOVIppsjcutiyiKDcY7SS7WDqmtwMHTU9PGE6aITl
         4ZlfjkPryYtchSdrNoNTBPg94CCiP1+5I6kWo1UI9XFfkfmMBuXepitrLYnpJ8VYrnes
         AcoHngQtEoROv6nl0KSE0eL+3vMaErqHhsujuLJi7xmV5cHokkxqk4uCl5bFw9NbOaqe
         42Pahfno0WcnAzoHgTEy/SFRwFdJ6aOD8A+/TAUtjV/raodRTj26eA8EBSlEv6ehhRWR
         m6uv0T9JUa2+v4AZroKltZ3RKjvOGXBrMfPEeTBghpVmreAWSw4aMHTyxILuZdQLzLGu
         uFpw==
X-Gm-Message-State: ABuFfohS90GLu4jDNYQaIKCG6J8LezJY3gzfF1Jq69Bk29IGS20AYbmk
        LK8hksnOaP7wOhYT98CGnj9cPCLo40vVxGBz9arhAYM4/d4kXIAVdPSHSl05IesLWwB3norpd2s
        ogM9k2+NythjElaInJfK3MrMA
X-Received: by 2002:a5d:4151:: with SMTP id c17-v6mr4478417wrq.61.1539336236658;
        Fri, 12 Oct 2018 02:23:56 -0700 (PDT)
X-Google-Smtp-Source: ACcGV62PsR5A4vc3G79b9jlFR855x6SnQtBbtm+xXVKts9JK08JXjg6Nc4YfydnZ+0uN3zuQLag+PA==
X-Received: by 2002:a5d:4151:: with SMTP id c17-v6mr4478406wrq.61.1539336236370;
        Fri, 12 Oct 2018 02:23:56 -0700 (PDT)
Received: from buildbot.pitowers.org ([2a00:2381:fdf7:14:d078:5595:7c26:ec82])
        by smtp.gmail.com with ESMTPSA id e6-v6sm547370wrc.70.2018.10.12.02.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 02:23:55 -0700 (PDT)
From:   Phil Elwell <phil@raspberrypi.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH] spi: Make GPIO CSs honour the SPI_NO_CS flag
Date:   Fri, 12 Oct 2018 10:23:18 +0100
Message-Id: <1539336198-84179-1-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-12_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPI configuration state includes an SPI_NO_CS flag that disables
all CS line manipulation, for applications that want to manage their
own chip selects. However, this flag is ignored by the GPIO CS code
in the SPI framework.

Correct this omission with a trivial patch.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---
 drivers/spi/spi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 84dfef4..b1d88fe 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -729,7 +729,9 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 		enable = !enable;
 
 	if (gpio_is_valid(spi->cs_gpio)) {
-		gpio_set_value(spi->cs_gpio, !enable);
+		/* Honour the SPI_NO_CS flag */
+		if (!(spi->mode & SPI_NO_CS))
+			gpio_set_value(spi->cs_gpio, !enable);
 		/* Some SPI masters need both GPIO CS & slave_select */
 		if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
 		    spi->controller->set_cs)
-- 
2.7.4

