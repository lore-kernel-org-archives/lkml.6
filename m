Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DATE_IN_PAST_12_24,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9B7C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B906120652
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hN+52OVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B906120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933194AbeFUOfw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:35:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36268 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932960AbeFUOfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:35:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id v131-v6so6580849wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 07:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wFp6PMjWdFaEfTztXJUeh0l5ydczjQi9UMIpkt+EyY8=;
        b=hN+52OVR2Pu/6t8dt6DiglXNUVAYkrFDloIsoe5jf4NxfVrFgNaKhbEDEKJsbm/hSL
         c4ewP21xGNfi1Qg0OP6QqAkgjMzhAkZnsmBTaQJy3MtAdJrAagruk6uu0rUw3MLrvY9m
         a3MykQU4xlmjX9wH+4y5DqIW8Racy/pkLY9298G5/8HLLHkOXXgRplVWyT8kiTqI7DYV
         gjfXYdqJFqZg7AeroALGFtm1FJ0enBnvu4ZZ/VHxt6Io06Vy8qTv7ZAGZGImcoMC3Tyx
         f+rH0J39EQvbybAuJ2nz9BAPiVDdDNyY+B2qNpe//Cica2ABJ458sAmiwn27nGOvFttW
         qNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wFp6PMjWdFaEfTztXJUeh0l5ydczjQi9UMIpkt+EyY8=;
        b=Lw0+jOBCviXBobQ+35mpV0wJcINnvE+ST+Oq0xJxDk82VP7kZ+H3qXomr5YCoCv8At
         L3uLH5R/vQm3iXswiiELEoJBFARe1if9ffb1evsGzO1O19AOwvJ1dcmCc0mOYaydx1OS
         B1JB5GFEdqw8Pt8qlX1V0DFFovAmKHNlucqOaVkOH8dH45mF3GidzFFqNGsLgTjNk6hF
         2J4obLsziWcOxL+O3xjO9mvco+bnaqmqKUhNdQ7oifitkOHFH3jKVYv51WIWGwNQNI0G
         jc490vH/fC81KavnoTcyPSMP+4ZjVPmzHIeJCHh5oJYETf6/ca9hJB6Wu4ljhTd0fYif
         v8nA==
X-Gm-Message-State: APt69E0AsADLJW3bRteW3xZfTuB1luqCdjgbuXp6RQPPKjDCB7RwU3xt
        r4j3G7SkHCG6tmMnhZfCYcLDBrBu
X-Google-Smtp-Source: ADUXVKJWnJsA9KVTKW7LrmUROUpVu0VUKLMloMGSQBwK0K5/aJYvjofmwILHjTa2SzHH/qUYHHgifA==
X-Received: by 2002:a1c:108b:: with SMTP id 133-v6mr5972779wmq.136.1529591749655;
        Thu, 21 Jun 2018 07:35:49 -0700 (PDT)
Received: from lynn-ThinkPad-T400 ([196.43.135.103])
        by smtp.gmail.com with ESMTPSA id t13-v6sm8421996wro.62.2018.06.21.07.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 07:35:48 -0700 (PDT)
Date:   Thu, 21 Jun 2018 05:34:35 +0300
From:   Nabimanya Lynn <nabimanya000@gmail.com>
To:     jirislaby@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4.17.0-rc3 2/2] tty:mxser: remove trailing whitespace
Message-ID: <20180621023435.GA11350@lynn-ThinkPad-T400>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Nabimanya Lynn <nabimanya000@gmail.com>
---

 corrected error of trailing whitespace that was accidentally left behind.
 drivers/tty/mxser.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 93965d4..38544ff 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1089,7 +1089,7 @@ static void mxser_close(struct tty_struct *tty, struct file *filp)
 	mutex_unlock(&port->mutex);
 	info->closing = 0;
 	/* Right now the tty_port set is done outside of the close_end helper
-	   as we don't yet have everyone using refcounts */	
+	   as we don't yet have everyone using refcounts */
 	tty_port_close_end(port, tty);
 	tty_port_tty_set(port, NULL);
 }
@@ -1517,7 +1517,6 @@ static int mxser_ioctl_special(unsigned int cmd, void __user *argp)
 				mutex_lock(&port->mutex);
 				if (!ip->ioaddr)
 					goto copy;
-				
 				tty = tty_port_tty_get(port);
 
 				if (!tty)
-- 
2.7.4

