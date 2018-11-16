Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0A9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3174320892
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVz2fZvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3174320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389655AbeKPURj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:17:39 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44879 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeKPURj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:17:39 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so1745681pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9cOrWGy0bw3Jf3mcXusOfjE3yRmPdjz4cQN+BMKM0i4=;
        b=iVz2fZvx5wjd9kKnRhoS0053SQYYB+oCB45UWVFHNnk7X4F0HiYpxlbU6qZTv7p7FT
         Q5Ar6lJAa89atX5rAS/G1ajcB6z/oQV7JuzHlgFpkbV4kXIgjVUbWv+6ERrRDrWOQTYl
         nAMhmi1VOnBTXawHzfgNaRqUxTVxLhUQiq0awuXRCF3FkVkOG8muoXFkNNxKO3ndGPz9
         7XqHVVPsm7vAjoewrdniQSK9PSM+gmF2wKeN44+d0nxX0hbmM5G5bjZpPPOSJiOqy7ny
         ktEKxvtiVThEFd8j5tvJoktUcXSadr+M2nicE0K6rqrbDq9SauD3NZEPHTi/zG4GgLuy
         OTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9cOrWGy0bw3Jf3mcXusOfjE3yRmPdjz4cQN+BMKM0i4=;
        b=obpViuD3hRWxLfistNM0VF5VfZUoxbu615WehdZDoX61GvTZyBbTTmZoMGTRonrzRh
         mX7m/B84XvSRsr8UgqPQSIQiVYEyXQfoe6r4cVh8cVEEi/Ta/PF9oWhM2hq59Dqse20g
         zHYnkErO+rd8G/FsaucJcxo79N8OkXudqAK1R8NZXlAqHx385P/lG9pwYvMj9oUk63xO
         7gVTw4y02DkfTxKZT573T9SNbimiTCypMQX4sDxGkpKQPV9zfMojGgKdE225kEFktoNd
         CHueSgqkftMDbjk4dUYn+WrEja9VzMyu38AP/7ZpbLsrxHH2ca7cXPsWUj4bualb/jgf
         o0ZA==
X-Gm-Message-State: AGRZ1gLmVdkkh9Bqk5xvnbas6tUuk7VZ8sivZQ1bkjXpyoqmJXRqEj7l
        cVp8Cjs6SMoRtdqwLEIlSmo=
X-Google-Smtp-Source: AJdET5c7e92kGjeQmuxw7nbFcrwNJKoCJVVpaUFeCWK/pCtUKL3cu7JkBzuZoCa6GW7cunvJrzAL+w==
X-Received: by 2002:a62:d75d:: with SMTP id v29mr6429692pfl.90.1542362760819;
        Fri, 16 Nov 2018 02:06:00 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([45.251.61.99])
        by smtp.gmail.com with ESMTPSA id c7-v6sm37922312pfh.25.2018.11.16.02.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 02:06:00 -0800 (PST)
Date:   Fri, 16 Nov 2018 15:35:57 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     stuyoder@gmail.com, laurentiu.tudor@nxp.com
Cc:     jrdr.linux@gmail.com, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] drivers/bus/fsl-mc/dpcon.c: Remove duplicate header
Message-ID: <20181116100557.GA2497@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/fsl/mc.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/bus/fsl-mc/dpcon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/dpcon.c b/drivers/bus/fsl-mc/dpcon.c
index 760555d7946e..97b6fa605e62 100644
--- a/drivers/bus/fsl-mc/dpcon.c
+++ b/drivers/bus/fsl-mc/dpcon.c
@@ -5,7 +5,6 @@
  */
 #include <linux/kernel.h>
 #include <linux/fsl/mc.h>
-#include <linux/fsl/mc.h>
 
 #include "fsl-mc-private.h"
 
-- 
2.17.1

