Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4D1C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABC620855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhuhYG7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABC620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeKITay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:30:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44091 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeKITay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:30:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id b81-v6so207809pfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 01:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=yr34ds14Lv5OMRgFhI4MuVj2I3UlzTRahrIqMm+Zjzo=;
        b=hhuhYG7GQSv3Gn0smtrQK4ApAhaYj9nBBEjoyojHfkOr6e9G5Fo6+H3+EXzq+Eh4IC
         LjpGoshFBiznKSv9wVvcS2pUm1SnGbxS0wifhbVdapPelQeP+qJRJrWC9oC8e0m3zcBt
         MSsoY/Qa9BjniV9wLGIPFDU4teQ0GVWAslZS6ohnntS5feJ0CewjFmdUZM0Tn90bgYjl
         hzUz5rV21lXhpiuVf8ce7+Vg5INNoqJ5iQn0aiCyPZLvMTjRMGTCW2AoAC9ZainDzZxJ
         TuLuDpQM8G6u/JM0nV7JAr2LKrCjdh4/ixk41a9O8QOl9Wk76WQbzv+5MqxX2iFXq4fW
         uulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yr34ds14Lv5OMRgFhI4MuVj2I3UlzTRahrIqMm+Zjzo=;
        b=i+mfweYTlLmPz+iviVAWW9SZ9s0uuIl8E0XH1wepwgqWCme8jRLGul5szyGuhe2kcT
         YhAOIMgzeUEyJAdLsqhUvRs7MB3PeDruujw1tyh7SJGn8yiWeeGQlt5jrNlDQvjwMMu0
         ToL5sWwn1lGLAeNax7aTIyF+16wnr4rvZYayH/zANimU4fEPUe3k0+q4nkseypMrEU8r
         QZrfdABwAy6XJtT5JjF8Nb1S1W7GXoIpAesAj+qbd8VP452xlmj+lLiclXAoRi6AtL9R
         BGkKkzkjh4zIk0uhmFcjwjDd6ucDgPIbZeyjkXsxgcMbrLdoCXV0mWMpRl59g9wLu7VW
         RJZw==
X-Gm-Message-State: AGRZ1gLuX0urG1kKm8U5hgKHbbY5sbTtpXTDAKwIJXH8erU5AY5uTGCY
        Eadguh3pyvUIQeJIoYMqOY4=
X-Google-Smtp-Source: AJdET5fRv5X0yxCbQqjpsjTo1p3wWKlfCktal9tvkUbaHnHRMmGPMKXP+Q4GNtMC73jUviYuNUPQSg==
X-Received: by 2002:a65:584c:: with SMTP id s12-v6mr6297431pgr.99.1541757065580;
        Fri, 09 Nov 2018 01:51:05 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([45.251.61.161])
        by smtp.gmail.com with ESMTPSA id 79sm5628304pge.66.2018.11.09.01.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 01:51:05 -0800 (PST)
Date:   Fri, 9 Nov 2018 15:21:02 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     stuyoder@gmail.com, laurentiu.tudor@nxp.com
Cc:     jrdr.linux@gmail.com, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] drivers/bus/fsl-mc/dpbp.c: Remove duplicate header
Message-ID: <20181109095101.GA2558@hp-pavilion-15-notebook-pc-brajeswar>
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
 drivers/bus/fsl-mc/dpbp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/dpbp.c b/drivers/bus/fsl-mc/dpbp.c
index 17e3c5d2f22e..9003cd3698a5 100644
--- a/drivers/bus/fsl-mc/dpbp.c
+++ b/drivers/bus/fsl-mc/dpbp.c
@@ -5,7 +5,6 @@
  */
 #include <linux/kernel.h>
 #include <linux/fsl/mc.h>
-#include <linux/fsl/mc.h>
 
 #include "fsl-mc-private.h"
 
-- 
2.17.1

