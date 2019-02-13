Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D17C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0087E21934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfUJBKrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387761AbfBMD0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:26:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34139 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfBMD0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:26:44 -0500
Received: by mail-pf1-f195.google.com with SMTP id j18so492046pfe.1;
        Tue, 12 Feb 2019 19:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TvEUuB2TrS9TqI/lJYeV+4qO4xUS0hrOrQzEkqlGCM0=;
        b=hfUJBKrkDYm9r2hxxmqXZxSksj5NdGAlTmuXql39gt/dS/UEmkZy1Cx5OyjWldRGqt
         tOXwgmFlwT4Tk1F7d31ozFBuQZs8pxBiSsdHm3V9Io3oziI5Mwp9ToTwuwwFlQGOzm4s
         uvHhApgwbwzut8XroOmf4nIm5KJYmPT47u7DmAkFEiwo8VBPZdjznhCva/Zcq1fOQCLZ
         YALelzXtI5kXE0uw26zsIl7NUx6+4xhG9w5DH5HwtaNfC8FmVeiF9ak6S78/1i7xcVOY
         D8FeWvPAhoIasFryu3wJlwQ9hIPZwZ32198QWbaRiW2ycScoqI8kP7gZaEfccMlHGYlb
         96ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TvEUuB2TrS9TqI/lJYeV+4qO4xUS0hrOrQzEkqlGCM0=;
        b=mZFCoWq/cZTS3Ym8wFNUnDyPJocV6YHiXAaqQL7G52A5vEVOKAfjD2Lv2pSETB4fnC
         PaZLAysYFeCFFQSZOo9h+u9+gYdcjc6xqFnwqpNhz9jXOT76KnY0J7/r7KnchP70JwK6
         hwza5OdKPnEY2tTplFzznxYdx9cjS8Cbs5BdU1wmXbohztps4ePW6/XcDCERaDv+xu2y
         sgTOiftuPkj6mMlB77C868DxA3Xvo8tYwD/MfV9nugLvtUC1HZraMl44YZFJt0KDj1o7
         Ardg1z7cbqI8WD8crYJDMsCrytQ5Ri7vkUubRCIPgSKhvlQjSA7pFSazQMnB4w85fzDF
         ts5w==
X-Gm-Message-State: AHQUAuZLAgZAft4OAVBXsrj5XZQxHEAQgL3RMxUCVIJoGFb4U0wXAQGV
        ZsBOrVSuzI77WNAzMSaqo/U=
X-Google-Smtp-Source: AHgI3IZ0Km2GhXlzbuZg8TWRoVJFNtWDkXa5UolrlVmn6qisAZKajqsDZsq3YdG9xT5k1/5PVYhItw==
X-Received: by 2002:a65:5cc4:: with SMTP id b4mr6541230pgt.365.1550028403659;
        Tue, 12 Feb 2019 19:26:43 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id q7sm17337396pgp.40.2019.02.12.19.26.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 19:26:43 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, willemb@google.com, tglx@linutronix.de,
        arnd@arndb.de, y2038@lists.linaro.org
Subject: [PATCH net-next 2/2] errqueue.h: Include time_types.h
Date:   Tue, 12 Feb 2019 19:26:04 -0800
Message-Id: <20190213032604.2655-3-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213032604.2655-1-deepa.kernel@gmail.com>
References: <20190213032604.2655-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a separate header for struct __kernel_timespec,
include it directly without relying on userspace to do it.

Reported-by: Ran Rozenstein <ranro@mellanox.com>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 include/uapi/linux/errqueue.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/errqueue.h b/include/uapi/linux/errqueue.h
index d955b9e32288..28491dac074b 100644
--- a/include/uapi/linux/errqueue.h
+++ b/include/uapi/linux/errqueue.h
@@ -3,6 +3,7 @@
 #define _UAPI_LINUX_ERRQUEUE_H
 
 #include <linux/types.h>
+#include <linux/time_types.h>
 
 struct sock_extended_err {
 	__u32	ee_errno;	
-- 
2.17.1

