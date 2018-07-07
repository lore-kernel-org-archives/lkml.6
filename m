Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820D7C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA0B22460
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcY//YBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA0B22460
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932838AbeGGCle (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 22:41:34 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36487 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932463AbeGGCld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 22:41:33 -0400
Received: by mail-pf0-f195.google.com with SMTP id u16-v6so9771726pfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 19:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=htUfFM8rhV51O+hOnHLRTS0wpyhA8r7OPWZND8Uot/c=;
        b=HcY//YBuI59yto+E5wWKN1FHLxRPv0pTK5wCE5claqp7pimT82yT0IhMgtHEI2qj+o
         Qs3GqcAZ5YAM2+YmF6OZAk+jBOKuHhZkZn/pqhGIgJHrdocS0rYOtgEBWBOpfRTtVSxY
         8BxEa+bw8LkLw+LKrcQuH1mIr4pE+47T3isjXp054EusfP114H5VwgjEndSkO3tRX5ek
         vFd976kfk7jvO9E3OOG2R4Ulycx7vkG4BllujPckRw0EP5huj1is5YLxDLIgg4OIJmEh
         yFntCyka/3Hf5pKvxdmigpOLzXq2mGp1AoDo0bYRGmZs/GV2jXENrIyjFF13EyE9Cxrd
         r9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=htUfFM8rhV51O+hOnHLRTS0wpyhA8r7OPWZND8Uot/c=;
        b=KSIJcGGeS77Y/PSPwHRK5MZdua4A+/MSvN2yzIWYbI5hy8O7ui76mTuORVDevx3/Vh
         eZo2zX4VIbmXL1rKritw5DOUsNWkjmpom4A0Zl+1Xvp+huMwsFUAtJYM9Kt0+yDdZfdS
         ISJnGaPEITGVkahVTfjTIvfMYKWC0LUMixPN6vxQ+OnwqXFx6Hp8T5MLiBnMf5A1WDt5
         JaHoFVZ5mswtLX8j/i18JHYseP9A6ZVEPXuYa1CfSZM2P2Pmq7rJtPqim5uEEigS8DXq
         VZEaEYGv7eimwCTrIDhD9MQk5YYm7dmIU70DxlDukmP2Vp5ZCYNRJ29fM4sE0kcKIu0b
         cqSA==
X-Gm-Message-State: APt69E31ybrB/Eupl0bzvAKWQ6wORuhBqU5BMOkC68yM5nHngT9WQ2qu
        9DvJD8aqculMfKaWdljjEFsPpVnU
X-Google-Smtp-Source: AAOMgpdOMOoF4hNHiRkuaKkCrAHfdGBeb7jgD9xnNLznQzXUd48AiJhQH4Nk9hgt8+FjLqzKi75org==
X-Received: by 2002:a65:4344:: with SMTP id k4-v6mr5383301pgq.409.1530931293038;
        Fri, 06 Jul 2018 19:41:33 -0700 (PDT)
Received: from localhost.localdomain (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i17-v6sm18897276pfj.95.2018.07.06.19.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 19:41:32 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 0/6] RAVE SP MFD driver fixes/improvements
Date:   Fri,  6 Jul 2018 19:41:02 -0700
Message-Id: <20180707024108.32373-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee:

This series is a number of small fixes the resulted from using RAVE SP
driver on wider selection of ZII devices that initial driver was
tested on. In addition to RDU1 and RDU2, the driver is now known to
work reasonably well on SCU2 Mezz (being upstreamed currently) as well
as SPU3 (not supported by upstream yet).

Hopefully all of the changes are straightforward.

Let me know if anything needs changing.

Thanks,
Andrey Smirnov

Andrey Smirnov (6):
  mfd: rave-sp: Remove unused defines
  mfd: rave-sp: Fix incorrectly specified checksum type
  mfd: rave-sp: Initialize flow control and parity of the port
  mfd: rave-sp: Add legacy EEPROM access command translation
  mfd: rave-sp: Add legacy watchdog ping command translation
  mfd: rave-sp: Emulate CMD_GET_STATUS on device that don't support it

 drivers/mfd/rave-sp.c       | 119 +++++++++++++++++++++++-------------
 include/linux/mfd/rave-sp.h |   1 +
 2 files changed, 76 insertions(+), 44 deletions(-)

-- 
2.17.1

