Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id g80kHtnaGFvcXQAAmS7hNA
	; Thu, 07 Jun 2018 07:12:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5D117608B8; Thu,  7 Jun 2018 07:12:25 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ea7mJrhF"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4272D60452;
	Thu,  7 Jun 2018 07:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4272D60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753092AbeFGHMW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:12:22 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39290 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751084AbeFGHMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:12:20 -0400
Received: by mail-qt0-f195.google.com with SMTP id p23-v6so9142525qtn.6;
        Thu, 07 Jun 2018 00:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VddLtINzkFpXqGHsaBu9mmbQr4SiECzbtdhqOXUEaKA=;
        b=Ea7mJrhF+I7I+TXviATrWlztBuRSR2PvO61EB0j7HVROucCmovgqPp44QoG+0HNYx+
         ogj56gN72M3N+OsyHlivQHg18ToGw9hy75OPy5Qogf6ENoTmdqSt1kbADW1wEykQ/9wc
         ZHeuZ6l1C43bmfyr8CDnUXDnidyGQ9tGNTqA4vYRvv55PsASBPB+aSMMZRQ/RvLpSXn7
         jrJcr8TRn22YKw/jxS0mw6avYtlaF+KquZEUFpkZblgzhod2DDKkosDkt6DfOIcsOovW
         J9W8WjyLAmFl4WCiM8HY9YqYCgV4dWD7eVJ9AI/jwWrOoIa7JAFJaQgfcEE6SeFmRada
         RWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VddLtINzkFpXqGHsaBu9mmbQr4SiECzbtdhqOXUEaKA=;
        b=pasGBzsTSJWNV20t3PMpGvrERj+V3IiiiX7dSmDjyG98Pr5uX4t+Ap8KiBurht/KUU
         rzHOl2zl3190M1VM/uzNACHneT6DgxlL/+YNHEVwFtPbjPqsrsnjp05XI6w/gfj3BFT+
         QXH19QoBSaibVVyzzgoBpMgiASQgENggbip62cm26NUpyPGpnmzzuOcJOexg0+0Ixa47
         llOwi+Wi1lfTvdgdL+L8UFooXkOUXukSv2ID5E1r3yDzySaOK4B7q71/hGjGxFkFuG+e
         P9F0BU/D4EyvUPiG2eaB/4X6zxvUfacunLhjOGmxWx3JZkxMObHa/dKMpOqs6qlvNlER
         Ah8Q==
X-Gm-Message-State: APt69E0TCjflnBgA9DcuGG7umQ1TO7Dtn5OFDk/HeI2RbV2YVkhlnxka
        ZWCu+YeZoVZtkSufTGjcN6o=
X-Google-Smtp-Source: ADUXVKLV/Y9+kc/+LCKPmW4sdBuWaa7cCxtFmO66KKYo0Lxk6jvG3JPei3O+ruSozmTfGCK7tJEseA==
X-Received: by 2002:ac8:7195:: with SMTP id w21-v6mr585119qto.111.1528355539807;
        Thu, 07 Jun 2018 00:12:19 -0700 (PDT)
Received: from localhost ([191.35.184.251])
        by smtp.gmail.com with ESMTPSA id v29-v6sm10190906qkv.28.2018.06.07.00.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 00:12:19 -0700 (PDT)
Date: Thu, 7 Jun 2018 04:12:16 -0300
From: Gabriel Fanelli <gabrielfanelli61@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: media: bcm2048: match alignment with open
 parenthesis
Message-ID: <20180607071216.GA31855@kaufman.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl issue:

CHECK: Alignment should match open parenthesis

Signed-off-by: Gabriel Fanelli <gabrielfanelli61@gmail.com>
---
 drivers/staging/media/bcm2048/radio-bcm2048.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/bcm2048/radio-bcm2048.c b/drivers/staging/media/bcm2048/radio-bcm2048.c
index 06d1920150da..a90b2eb112f9 100644
--- a/drivers/staging/media/bcm2048/radio-bcm2048.c
+++ b/drivers/staging/media/bcm2048/radio-bcm2048.c
@@ -2175,7 +2175,7 @@ static int bcm2048_fops_release(struct file *file)
 }
 
 static __poll_t bcm2048_fops_poll(struct file *file,
-				      struct poll_table_struct *pts)
+				  struct poll_table_struct *pts)
 {
 	struct bcm2048_device *bdev = video_drvdata(file);
 	__poll_t retval = 0;
-- 
2.17.1
