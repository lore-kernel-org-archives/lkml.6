Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DC2ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6762084C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AH0mdyZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B6762084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbeGPOvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:51:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45344 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbeGPOvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:51:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id i20-v6so17093546eds.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 07:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qesngSEkPK0iJwMWZLGYn8RI3jBjP0CHL3uWVXj5WcI=;
        b=AH0mdyZx7Hw7JnIkzxdoyP9KGhdLpSbxkb7mEZMxQp23xoIOVzJamEBK2IUnOe0aby
         pLn+o1uuGQJH9IjgrqP76qF7KvNDYIQAlOiIUJhYcaoTZBeQG6fw8pzRq0p40sDw8LIN
         yUXPnH6tU8RKhuU2jsg9chdOrkFy+hmVt0uuz9m8AkR9yjm0IolRSit7mYYwHsi/FMjF
         4e1Yc/mobMeSZsSTqxq1ws8HYVbQ8YjpEvgwD8MmaWU8ko8CgLda5OA0B5oGPdZYr9s/
         PL7wk28C6tnHnPJSlpIQhqNEIRDkr6uxKbr/JkK4lyZ/S0Zb0HMLlFoMohiYW4xvl661
         cWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qesngSEkPK0iJwMWZLGYn8RI3jBjP0CHL3uWVXj5WcI=;
        b=bIpyBkfYoKX0NL8JYrY7ZMs4SkP5Eyt2ONeogoq4f2UWOxFHTPRXbRziJJgxbg76af
         k0KAVyMxvMSE1Qv5eelkhc094LfTa7VwfgI/UqZWgHbXE55wjsx2wosrTG/Sml8OYVf2
         A2ZvlP/QBkNSkljOE9nve0SkK2HlIfrhTaBivK/6WtAaaVaMjkzI97kxvBgF08tSAy/6
         V6dPe0aAYJiS2sW2FRTa46vrSHqCM/mx+lDRKrdNY8xCr517fJHIFehu8JXRKubH3+sg
         KuR5+o8o7H30jNyw5jy3VDqUqW9NSKd4Rx68AYJui15VbaP0TKDIQNd7VmhS4BB6L8XS
         dpMg==
X-Gm-Message-State: AOUpUlGvYy8WeyuQ80M7vB576ki3P8oMMZp5nTA9YZySIJCrnE5vS0VF
        u7fAsaQ+6ySIdwtp5TQnO70=
X-Google-Smtp-Source: AAOMgpcEUxXHqu3vEbgk/g8Br1iB6c3edk334mNmb1cpxznV5vFB5CQ6GXrWf5ixgj6Jg6WI1AQ76Q==
X-Received: by 2002:a50:a804:: with SMTP id j4-v6mr18510840edc.61.1531751000744;
        Mon, 16 Jul 2018 07:23:20 -0700 (PDT)
Received: from arch.localdomain (x4db296c4.dyn.telefonica.de. [77.178.150.196])
        by smtp.gmail.com with ESMTPSA id o12-v6sm3264874edj.54.2018.07.16.07.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 07:23:20 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8188eu: use is_multicast_ether_addr
Date:   Mon, 16 Jul 2018 16:23:03 +0200
Message-Id: <20180716142303.1627-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716142303.1627-1-straube.linux@gmail.com>
References: <20180716142303.1627-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_multicast_ether_addr instead of IS_MCAST.
By definition the broadcast address is also a multicast address,
so checking for !multicast in the conditional is sufficient.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index 2edc3a8242b1..48e12b5439eb 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -549,7 +549,7 @@ static void count_rx_stats(struct adapter *padapter,
 
 	padapter->mlmepriv.LinkDetectInfo.NumRxOkInPeriod++;
 
-	if (!is_broadcast_ether_addr(pattrib->dst) && !IS_MCAST(pattrib->dst))
+	if (!is_multicast_ether_addr(pattrib->dst))
 		padapter->mlmepriv.LinkDetectInfo.NumRxUnicastOkInPeriod++;
 
 	if (sta)
-- 
2.18.0

