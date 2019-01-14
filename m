Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB72C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA92320659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQmqthy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbfANRAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:00:39 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37808 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfANRAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:00:39 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so9711000pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 09:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=e/CvF/NnJZ3Ummqb2d6II3oNkVJ6YV1gzCdFfZACztw=;
        b=uQmqthy1zKX1CW7pSdXTvAJ8ucWW5z6F/PvBRMExIR1nHrdsl+wXgOh6LTJCmBnPya
         /LpHGSIqFmd4kYn7TO0ssEsrktf7U38K4bswbJb1B8i6Ss6ihAz7QHyBXWsAqLKdMILq
         O4SihAGYEtp23dTejLuFNI1Li5cQW4ZNeAWgPiRgFkCtggoQvcnjB2d5zNvrVFZjCkea
         f4/BXe+kKEA12rye3kJHu98XgriKipZXd/I//f5FTzWlbUc/3xf6NI8ZGr+hKt6pA7ky
         BWA3UFF+Eh9kNH0JJ4zURDGqXtUMBG8YytNmc5/jPxUzHYqz6ef/6scJAPSLz5F2owLG
         se2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=e/CvF/NnJZ3Ummqb2d6II3oNkVJ6YV1gzCdFfZACztw=;
        b=TqHkCnO0rrHUbo7sX3ORnke6SYTiMk8zoDdW7ohANkCSspN7Vze54Y6HCoB/I4W/hP
         COfIPJWaSbI+xW6OyB1aMib5lP2t/JZFq/DnytdPZfDlkVWDCPxiqNxDkhpCZ7Jkc7jc
         e3WPBiWyxzUqnsXOwMSjBQQv0IuTqr6tXUnbLGA/kB4hyNgAMVmWBWTHYa3N2UwJcrJI
         vKC5YBMKCcB/X+Z38MQFm44lm2eTaN/Ivn3mLHyXAdTI2rhmlPbAnaW5d/r3LZx9J7GK
         jlR5Jo/GrqY0le6ZYAjK2hNvvxWX8z4wlIUNW1UJFEHMdOq3HpLSS5b2Dn+W4ONBuEd3
         lRzQ==
X-Gm-Message-State: AJcUukd23ZNwo6NC90Fm+ccbmrei7lSrwJ+6awS3ccQI2+xlmvpVl2/X
        aneeEJPM/aWLfehJg8vPkkMIGUYB
X-Google-Smtp-Source: ALg8bN4eGtcw6e7z8PVUspIno+yW+rcevE5LUWz+oANqgk+Nzw/dGETNaCe7hVGd0TbhkylHLr9j0w==
X-Received: by 2002:a63:fd0a:: with SMTP id d10mr23906271pgh.164.1547485238126;
        Mon, 14 Jan 2019 09:00:38 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([42.110.138.108])
        by smtp.gmail.com with ESMTPSA id 6sm2099171pfv.30.2019.01.14.09.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 09:00:37 -0800 (PST)
Date:   Mon, 14 Jan 2019 22:30:33 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     jrdr.linux@gmail.com, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] samples/mic/mpssd: Remove duplicate header
Message-ID: <20190114170033.GA3674@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate headers which are included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 samples/mic/mpssd/mpssd.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/samples/mic/mpssd/mpssd.h b/samples/mic/mpssd/mpssd.h
index 8bd64944aacc..82d3b519f0e7 100644
--- a/samples/mic/mpssd/mpssd.h
+++ b/samples/mic/mpssd/mpssd.h
@@ -37,21 +37,18 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
-#include <sys/types.h>
 #include <sys/mman.h>
 #include <sys/utsname.h>
 #include <sys/wait.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
 #include <netdb.h>
-#include <pthread.h>
 #include <signal.h>
 #include <limits.h>
 #include <syslog.h>
 #include <getopt.h>
 #include <net/if.h>
 #include <linux/if_tun.h>
-#include <linux/if_tun.h>
 #include <linux/virtio_ids.h>
 
 #define MICSYSFSDIR "/sys/class/mic"
-- 
2.17.1

