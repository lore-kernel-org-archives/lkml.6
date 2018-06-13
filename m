Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C590EC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797B4208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OISw+Qwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797B4208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935052AbeFMQI2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:08:28 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37459 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934533AbeFMQIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:08:24 -0400
Received: by mail-pf0-f195.google.com with SMTP id y5-v6so1663906pfn.4;
        Wed, 13 Jun 2018 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZLF05pfFqEy0KBvOMrLNMdcV6wQeNNbKUA6cbfKEhVQ=;
        b=OISw+QwotKaNlWvWL8wQrp/2yNcYaGdnas0Y3SnoUsUx9AvcjNzpOUWb5REk9RvyLG
         Q3kFj7clvpp53MM+ouAC8Ug6YTkeyZdtEr1ZSiXCVTuvy7iKq8hSrhMMUjcNXedYWOl3
         FQZppJ37tII8UZnKy1XOz1X83urFdtaCYPSMPOwhC8Z93LZyTdnF06A4Z+SGuFzHDG5V
         Pz8ux2xniT0s23Hi9iuYA27I2KjlI/fZhtW0FkxkyOLPnWVg+EegrsRn3YvvWXZgfCqh
         SwDpqmIboOi1APL8Y9cuZjmyRezPO+nCtNpJ7Aey6t44oIINMrucFH6Hkolos/f9EQNB
         73Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZLF05pfFqEy0KBvOMrLNMdcV6wQeNNbKUA6cbfKEhVQ=;
        b=YXNQe5fT5hyjJ7hnb8CtF+xcdaj9DdnWyMwZzFapEfe6XgJUezyp9kcEDQLLaWYtZd
         vIrAgQTOQbxy9MMXLBL0X23kXcrP3K0y4yBc3r0xq7ts1pYn0sxtXTu0bJPxNUehooXT
         ytWcpF/dX4Qzc3A6VvyhOdYC8evsq6eWKiPL/sfYGmVyQ7s+URBmKO/zMTcp58UMt4+C
         0HAj1Zju+MVHd6cIluqNA020CYJSOoy1J18t9WrAZWIB3fDuFL3FeYsYFMbHLZ4JAY5W
         23BCtHyHEvBE/vRhGGycVBizsHVNZEI+qB6XIgSHQW1avO25DeMnWRylaVni8Zf9LX+7
         8gaA==
X-Gm-Message-State: APt69E3k9s+jnBLYX+IX4KLpCTqH1IK/OExhyIKCb18xdOYO04/oppYw
        26aJhT+zoglqhA1tg2HNlQ==
X-Google-Smtp-Source: ADUXVKJEm3WFdW00Uo2HqmpLAiybK0MNtx1liDcHKSNm6StOGtau8zavZmd54agECy914SmvHFW7EA==
X-Received: by 2002:a63:b008:: with SMTP id h8-v6mr4584227pgf.137.1528906104197;
        Wed, 13 Jun 2018 09:08:24 -0700 (PDT)
Received: from localhost.localdomain (host81-131-105-100.range81-131.btcentralplus.com. [81.131.105.100])
        by smtp.googlemail.com with ESMTPSA id z19-v6sm4459577pfe.163.2018.06.13.09.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 09:08:23 -0700 (PDT)
From:   Craig Tatlor <ctatlor97@gmail.com>
Cc:     ctatlor97@gmail.com, linux-arm-msm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/4] MAINTAINERS: Add entry for the Qualcomm BMS
Date:   Wed, 13 Jun 2018 17:06:25 +0100
Message-Id: <20180613160643.12638-4-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180613160643.12638-1-ctatlor97@gmail.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <20180613160643.12638-1-ctatlor97@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c125f705f78..be485caf9313 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11646,6 +11646,12 @@ W:	http://wireless.kernel.org/en/users/Drivers/ath9k
 S:	Supported
 F:	drivers/net/wireless/ath/ath9k/
 
+QUALCOMM BATTERY MONITORING SYSTEM
+M:	Craig Tatlor <ctatlor97@gmail.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/power/supply/qcom_bms.c
+
 QUALCOMM CAMERA SUBSYSTEM DRIVER
 M:	Todor Tomov <todor.tomov@linaro.org>
 L:	linux-media@vger.kernel.org
-- 
2.17.0

