Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EA8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265D820A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGzwbuZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265D820A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeHYAAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 20:00:30 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:47078 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeHYAAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 20:00:30 -0400
Received: by mail-lj1-f193.google.com with SMTP id 203-v6so7783153ljj.13;
        Fri, 24 Aug 2018 13:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vohmwziAkODnCt0AF8JnYFsfiDmkD6hNq6sdef5/DJs=;
        b=JGzwbuZtNa2Iby4iLHsEf7UTI/lLBy/2Fw43Z27gko1TkqFPixMS0IBNnhOIu9eJm3
         xGeCMEywJWJncC3REGx6HZwJbaG5Kf2EBT45Jbpi8w0StRpDMl9dhdXzxCPOTWZ6j2an
         7zzC0bgBPMBZfCiLNyhvtBw32cmkhxfQL0WUJ4iPIKx7Ixlm7eGjjL5kEijGWQ49sfCh
         83AalnH3Zuu9SvIEwwb1gHLgaeQE0qX1/A3hMmTiTXkN55WQ2qzDZwuErSGYoOm9qoP7
         Id8AH/WNsvdmwh6he7yoR0BK7fhw6nDiUeX9+WskSjFtJcllDpzzTuqBr39vW1OsuzXm
         4lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vohmwziAkODnCt0AF8JnYFsfiDmkD6hNq6sdef5/DJs=;
        b=ky/jvsylOl+UPr9j2pMZC3EC+Obbxs+e6aStjvXVcVMMCTotFxAscyp9MLd/R9A1Te
         ULlCz1yndnj3RH0P1k2al98Z6qIFmBeH+R7O3sxM11JoeMQFaDLz0rZbrGczh8gi1e7v
         PAOJpDOc2zhgaL76SXujZxvJrD1/GvQZJMXV/8mdjgJhJQ8tG0PHqkaJAKti8lozS7IK
         UCUKGapvDGWDhGovc7gPWjS6PTfy1IhgXestVT9EXdehD5Ype1Fb6g6i6w1eqwWFLwa2
         9+nEjvWd7fBHrkR0EQTFMjzZOrmy8MiS24idp91dqDF8ssfRSeNEXPevszeuLTfXEvZn
         kMzA==
X-Gm-Message-State: APzg51AGdgHCQkkMT6Y3RDAjAMgdVrYkrv85NI8vzAoyecxe2xhaXilF
        dPEAZOGyCxZx7OmUcc1R/kjQySTV
X-Google-Smtp-Source: ANB0VdZYKDgz7Ta3Tz+shKx7v4XXQZY6VyPucr819/KvnYiU+Iaux/46pM/UQz0kGDn+sVoiUDSV7w==
X-Received: by 2002:a2e:5b4a:: with SMTP id p71-v6mr2207966ljb.91.1535142259181;
        Fri, 24 Aug 2018 13:24:19 -0700 (PDT)
Received: from localhost.localdomain (c-2ec26f18-74736162.cust.telenor.se. [46.194.111.24])
        by smtp.gmail.com with ESMTPSA id s82-v6sm1493213lfk.73.2018.08.24.13.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 13:24:17 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] iio: dac: mcp4922: fix error handling in mcp4922_write_raw
Date:   Fri, 24 Aug 2018 22:24:40 +0200
Message-Id: <20180824202440.21754-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not try to write negative values and make sure that the write goes well.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/dac/mcp4922.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
index bf9aa3fc0534..b5190d1dae8e 100644
--- a/drivers/iio/dac/mcp4922.c
+++ b/drivers/iio/dac/mcp4922.c
@@ -94,17 +94,22 @@ static int mcp4922_write_raw(struct iio_dev *indio_dev,
 		long mask)
 {
 	struct mcp4922_state *state = iio_priv(indio_dev);
+	int ret;
 
 	if (val2 != 0)
 		return -EINVAL;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val > GENMASK(chan->scan_type.realbits-1, 0))
+		if (val < 0 || val > GENMASK(chan->scan_type.realbits - 1, 0))
 			return -EINVAL;
 		val <<= chan->scan_type.shift;
-		state->value[chan->channel] = val;
-		return mcp4922_spi_write(state, chan->channel, val);
+
+		ret = mcp4922_spi_write(state, chan->channel, val);
+		if (!ret)
+			state->value[chan->channel] = val;
+		return ret;
+
 	default:
 		return -EINVAL;
 	}
-- 
2.18.0

