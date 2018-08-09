Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCC2C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A14223A1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zcy9TD14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A14223A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeHJCGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 22:06:06 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41330 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbeHJCGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 22:06:06 -0400
Received: by mail-qk0-f196.google.com with SMTP id n85-v6so5272478qke.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 16:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=bCCLchgmmh7XLJtpuj+Af2P1OhjHCfRSVjstn/mAXjs=;
        b=Zcy9TD14iuUGO15TGD35U973IOBjAugHPQlPkTmrrXja2hvRNNcZLihiIjhvYrmaSf
         +7EEGQqTbybIo5Evd4e3weRnfjdwgEHljkDpcHC2gKoLHrsfOH2K2hXIjn4o+YPcymSD
         vyY6Pon30jWdLWct0UiRKpRDbG7G5bZsCeD/ys5bqRwL5g2qY/rqNJiRvBFo596qUfkW
         ejsB5ibxnI9GAR0/racmyqsTVPqeYrOhWoSwe99FFESOc9n0jR3JZnGZrJlY09XJG427
         1cyC/GcJJdNlPAR1v9xCouWLKTSItEbCJx39cJm9Eo2/goRhGBXFBsfPQDD2OKIPYXfp
         r51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=bCCLchgmmh7XLJtpuj+Af2P1OhjHCfRSVjstn/mAXjs=;
        b=E6Q7uADHh0hf7D3b1CLHN9F/mwQwWBBLai5MeV+3QWyxTGknHg9ab3OAVkCmlZorkc
         eDB5R/NSQx1IVui9zQjuJ2QEHWFiTu8bgwdJLB2mtJHA0iQ/vu6Ze4wbaPtPtmT2JjqQ
         mtdLu4dcPQ90BWu93FBfh4L73OEHqih+MJ3jj45OYc3l39QyD7K1Gzd8MAYJW7QnnhmV
         c9TEyTPgxciLaEoDh+Zm/Slx9TsxLJ/PLwwGMnBLwMY3G4Tz0KDsIqJ2bizjOZnC8MMr
         OS8P3de4JWLDiN49YtKreSB7wHJK6AUUeQeUJkaPiejWhRGoXUHSjNMMWQcwJ7b+Ydwy
         oscQ==
X-Gm-Message-State: AOUpUlEL/sBvE5Su1UQdxwoVddxSeyu0QjV61izm8ERfy4S4SDzKy38e
        UwmE1PKzuRN0X0Xky6C/wfU=
X-Google-Smtp-Source: AA+uWPxPnNb+ojKvMbzdnttjEqiJKCV2nX8G9TJblvZu+edUh+OP4Y66zLpWcWowTIzKh8sU4ZvlCg==
X-Received: by 2002:a37:6dc4:: with SMTP id i187-v6mr3892746qkc.34.1533857936422;
        Thu, 09 Aug 2018 16:38:56 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id c11-v6sm5049983qkb.22.2018.08.09.16.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 16:38:55 -0700 (PDT)
Date:   Thu, 9 Aug 2018 20:38:49 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] staging: fbtft: Removes ";" from very used macro
 definition.
Message-ID: <30f5993e321ab1392914591b6f3a3d15d44610c8.1533857891.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All usages of this macro append the ";" at the end of
line. It is not recommended nor necessary to append
a ";" at the end of this macro definition.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 25302ffc4000..ad79d6a80443 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -342,7 +342,7 @@ static void __exit fbtft_driver_module_exit(void)                          \
 }                                                                          \
 									   \
 module_init(fbtft_driver_module_init);                                     \
-module_exit(fbtft_driver_module_exit);
+module_exit(fbtft_driver_module_exit)
 
 /* Debug macros */
 
-- 
2.18.0

