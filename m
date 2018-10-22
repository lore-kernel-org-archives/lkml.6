Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7FAC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636C720651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDP8PFox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636C720651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbeJWFAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:00:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34958 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbeJWFAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:00:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id a10-v6so3678233qtp.2;
        Mon, 22 Oct 2018 13:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FXmqSh4jX9nonZ3Gd1r5S+86lA+V7cMsIbQ77eKvgnc=;
        b=BDP8PFoxZi01MHKNC/1Yge+y7c1rqgTi39fg2rRIh4gvrIwP2bFZLX8o5620cHKYWP
         IF0byG5JGh1RAGTN+LhXhnXabZ+jGDYzIohBHcyCbWJw5arjUMcmjfJqCBcDkmaq0tDL
         Wqhb1RSGlM1PEJCgGlMu8+EMYz4C4XTlApFEXTpu5XP42XeFw49OdCxCk4AEaROn3bqQ
         M+uUv0P/f1ncqw1rKhjTewzcKVutaT5THMLW6Mb3SvLJ8fsR2RuAANeIk5Q9qju4CmAg
         lZXs9GDeerUwewXmE3Xm3ciHAdz8Cb4F4OsGJbxDx9ohTeYKyeboL8TXCodE+WoUIk/n
         u6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FXmqSh4jX9nonZ3Gd1r5S+86lA+V7cMsIbQ77eKvgnc=;
        b=jT+oyyTyYcN6OKopDoIbrW4nf/w7aGZW3QVquotR0+GzDN+HhG/xOgegbLsBXk8Smo
         HT6ifO6gckaNixQgBB3H8MIgGtzhmOS1gDs2B60WsTJwh6RSTVqmHNnBG6ufllBUkDXT
         M13i+1XI2V5TaYs6AxICXmQ6enijNFjRgTUAtpyHYzwkSDXPIcb/Yz6yvH50dauSfzxf
         PInT/loEJ7fPgQeb4FGYbTYkX23SEHMehLFY44fNT5csWCbjBecNX8dgtun/wPkpRWKS
         EPw8VlvXxflEok+2gK0qEJLcBmfb+LSaRP/M7vxI6BcuqJZBS3BhszkY/ls32ckB3OW2
         bGmg==
X-Gm-Message-State: AGRZ1gJOys0p5u6e4vyPBg+//qOtAIyLKzZc9RpILXuSsG6r3tPmvRnZ
        +Hf9Ifjf6MZEu4PqfUtlElLTdTc6jCJLYQ==
X-Google-Smtp-Source: AJdET5c6+Y+XvXsORKb4la/1mT/K7k13lXZ5Hf6Vv+aFCR3FZTT0zqxxX1uH/fb4eHvLjacERlDOJA==
X-Received: by 2002:a0c:fd87:: with SMTP id p7mr8805077qvr.36.1540240829718;
        Mon, 22 Oct 2018 13:40:29 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id x1-v6sm14646751qkx.93.2018.10.22.13.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 13:40:29 -0700 (PDT)
Date:   Mon, 22 Oct 2018 17:40:25 -0300
From:   Victor Colombo <victorcolombo@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 1/2] staging: iio: ad5933: Remove unnecessary space on casting
Message-ID: <20181022204025.lhkzj5ynjbfzbbuj@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

WARNING: No space is necessary after a cast

Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 8a920f675b83..7a216ea90784 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -210,7 +210,7 @@ static int ad5933_set_freq(struct ad5933_state *st,
 		u8 d8[4];
 	} dat;
 
-	freqreg = (u64) freq * (u64) (1 << 27);
+	freqreg = (u64)freq * (u64)(1 << 27);
 	do_div(freqreg, st->mclk_hz / 4);
 
 	switch (reg) {
-- 
2.19.1

